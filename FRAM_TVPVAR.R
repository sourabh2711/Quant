# install.packages("kableExtra")
# install.packages("ConnectednessApproach")

# Load necessary libraries
library("ConnectednessApproach")
library("zoo")
library("kableExtra")

# Read your dataset using read.zoo
dd <- read.csv.zoo('dd.csv', sep = ",", header = TRUE)
#write.csv(x = Commodity_dataset,file = "dd.csv",row.names = F)
# Define partition and other necessary variables
partition <- c(pi + 0.00001, pi / 5, 0)

# Perform the analysis with your dataset
dca <- ConnectednessApproach(
  dd,  # Using your loaded dataset 'dd'
  model = "TVP-VAR",
  connectedness = "Frequency",
  nlag = 1,
  nfore = 100,
  window.size = 200,
  VAR_config = list(TVPVAR = list(kappa1 = 0.99, kappa2 = 0.99, prior = "BayesPrior")),
  Connectedness_config = list(
    FrequencyConnectedness = list(partition = partition, generalized = TRUE, scenario = "ABS")
  )
)

# Generate the results
kbl(dca$CT)
dca$CT
PlotNPDC(dca)
dd


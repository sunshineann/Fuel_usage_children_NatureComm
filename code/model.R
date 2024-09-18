# Author: Yanwen Wang
# Date: September 6, 2024
# Purpose: model used in analysis for 
#         Wang et al. (submitted to Nature Communications).

# NOTE: this code is a guide for transparency and 
#       reproducibility and is not able to be run.

# Key R Packages used in this model
library("lmerTest")  # for linear mixed-effects models
library("splines")  # for non-linear spline functions in models

#Full model formula for the primary analysis
# NOTE: the primary analysis was conducted using data 
#       among 9997 schoolchildren undergoing 24371 visits 
#       across 46 cities in China.

# The linear mixed-effects model was used to estimate 
# the relation between residential solid fuel usage and lung function level.
model <- lmer(
              #indicating the pulmonary function measurement index 
              #including forced vital capacity (FVC), 
              #forced expiratory volume in one second (FEV1), 
              #peak expiratory flow (PEF), 
              #and forced expiratory flow (FEF) at 25% and 75% (FEF25%, FEF75%)
              PULMONARYFUNCTION ~ 
               
              #a categorical variable with “0” for clean fuel usage, 
              #“1” for residential solid fuel usage 
              as.factor(FUEL) +
                
              #adjust for sex, age, and mother education level
              SEX + AGE + BMI + MOTHEREDU + 
              
              #adjust for indoor condition, including 
              #indoor passive smoking, pet keeping
              PASSIVESMOKE + PET + 
              
              #adjust for disease and symptoms, including 
              #history of respiratory disease, allergy history  
              RESPIRATORY + ALLERGIES + 
                
              #adjust for ambient condition, including 
              #annual average ozone exposure level, annual average temperature exposure, 
              #and annual average relative humidity exposure
              OZONE + ns(TEMP, 3) + ns(RH, 3) + 
                
              #adjust for the districts and counties where participants’ schools located 
              COUNTY + 
                
              #adjust for the month of performing lung function test
              MONTH + 
                
              #indicating the participant’s unique coding, 
              #adjusted for as a random effect in the model
              (1 | ID), 
              
              #DATA1 is analysis data
              data = DATA1)


# NOTE: Further models and analyses continue in a similar manner for other variables and outcome measures.

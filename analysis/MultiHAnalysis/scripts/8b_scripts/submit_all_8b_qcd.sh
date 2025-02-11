
ODIR="/store/user/ekoenig/8BAnalysis/NTuples/2018/preselection/t8btag_minmass/"

# VERSION="Run2_UL/RunIISummer20UL16NanoAODv9"
# CFG="config/8b_config/skim_ntuple_2016_t8btag_minmass.cfg"

# VERSION="Run2_UL/RunIISummer20UL17NanoAODv9"
# CFG="config/8b_config/skim_ntuple_2017_t8btag_minmass.cfg"

VERSION="Run2_UL/RunIISummer20UL18NanoAODv9"
# VERSION="Run2_Autumn18"
CFG="config/8b_config/skim_ntuple_2018_t8btag_minmass.cfg"

TAG="$VERSION/QCD/"

rm -rf /eos/uscms/$ODIR/$TAG/analysis_tar
make exe -j || exit -1

echo "... tag       : ", $TAG
echo "... saving to : ", $ODIR

qcd_files=$(ls input/$VERSION/QCD*BGenFilter* input/$VERSION/QCD*bEnriched*)

for input in ${qcd_files[@]}; do
    python scripts/submitSkimOnBatch.py --tag $TAG --outputDir $ODIR --cfg $CFG --njobs 100 --input $input --memory 2500 --forceOverwrite
done

function test_bug255

% TEST test_bug255
% TEST ft_timelockanalysis ft_prepare_layout ft_timelockstatistics ft_topoplotER

% this script tests the functionality of ft_topoplotER with respect to
% functional data having dimord 'chan', i.e. after doing statistics with
% 'avgoverfreq' or 'avgovertime' = 'yes';

cd('/home/common/matlab/fieldtrip/data/test/raw/eeg/');
load('preproc_neuroscan16');

%there's an unresolved issue with duplicate labels 'FREE'
%FIXME
data.label{1} = 'FREE1';
data.label{2} = 'FREE2';
data.label{3} = 'FREE3';
data.label{4} = 'FREE4';

cfg = [];
cfg.demean = 'yes';
cfg.keeptrials = 'yes';
tlck = ft_timelockanalysis(cfg, data);

cfg = [];
cfg.layout = 'biosemi64.lay';
lay = ft_prepare_layout(cfg);

% do statistics
cfg = [];
cfg.statistic   = 'indepsamplesT';
cfg.avgovertime = 'yes';
cfg.design      = [ones(1,5) ones(1,5)*2];
cfg.method      = 'montecarlo';
cfg.numrandomization = 0;
cfg.latency = [0 0.1];
stat = ft_timelockstatistics(cfg, tlck);

cfg        = [];
cfg.layout = lay;
cfg.zparam = 'stat';
cfg.interactive = 'no';

%plot data
ft_topoplotER(cfg, stat);

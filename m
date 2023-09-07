Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CEE797CAC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbjIGTYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjIGTYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:24:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A93B2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 12:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694114672; x=1725650672;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gmdJv9k5Hlrl7l+9ky7dngBQQOJTQs48s9FRH3s0wNI=;
  b=fRv5h/U/CPxelSwtBQVsJEVc3APtoLzMN8WEiOKnt98WB14Njsgn5zVf
   h7Flh3DzqVQuOPtMFoFENwuS18S0nfRyG7Ehw5VrzbhInlGxS3dzpxfLS
   DrOkd2hrm8Mp90h5Kz30XXXG6GOxK5vwBdAIVQcanW21csRcECs2o5noe
   xYX8ZeZBQvANrMzF2kO5cWQ85XwrpPa7BmLflcd+JRZbS19+EOo/wbobP
   IYPiaYDo3ra8NClruaAr7Z1Hqfkm9B4gPbf+yHkh9c1HBU2/F3pshUAH6
   IGEeZPaIB1qtwCdz7B4X2EnsefQHGeT8BVy3mLy6qYBfjGrEjjYRo9u5n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="362517230"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="362517230"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 12:24:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="691911846"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="691911846"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2023 12:24:29 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeKc7-0001V9-1Z;
        Thu, 07 Sep 2023 19:24:27 +0000
Date:   Fri, 8 Sep 2023 03:23:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: sound/soc/soc-pcm.c:1082:1: warning: the frame size of 1324 bytes is
 larger than 1024 bytes
Message-ID: <202309080339.rbPMLUjl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4a0fc73da97efd23a383ca839e6fe86410268f6b
commit: ac950278b0872c87bcef6153fd9c119265c8ba83 ASoC: add N cpus to M codecs dai link support
date:   3 months ago
config: i386-buildonly-randconfig-006-20230908 (https://download.01.org/0day-ci/archive/20230908/202309080339.rbPMLUjl-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230908/202309080339.rbPMLUjl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309080339.rbPMLUjl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/soc/soc-pcm.c: In function '__soc_pcm_hw_params':
>> sound/soc/soc-pcm.c:1082:1: warning: the frame size of 1324 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    }
    ^


vim +1082 sound/soc/soc-pcm.c

4662c59688b8db Kuninori Morimoto 2020-09-29   975  
ddee627cf6bb60 Liam Girdwood     2011-06-09   976  /*
ddee627cf6bb60 Liam Girdwood     2011-06-09   977   * Called by ALSA when the hardware params are set by application. This
ddee627cf6bb60 Liam Girdwood     2011-06-09   978   * function can also be called multiple times and can allocate buffers
ddee627cf6bb60 Liam Girdwood     2011-06-09   979   * (using snd_pcm_lib_* ). It's non-atomic.
ddee627cf6bb60 Liam Girdwood     2011-06-09   980   */
b7898396f4bbe1 Takashi Iwai      2021-12-07   981  static int __soc_pcm_hw_params(struct snd_soc_pcm_runtime *rtd,
b7898396f4bbe1 Takashi Iwai      2021-12-07   982  			       struct snd_pcm_substream *substream,
ddee627cf6bb60 Liam Girdwood     2011-06-09   983  			       struct snd_pcm_hw_params *params)
ddee627cf6bb60 Liam Girdwood     2011-06-09   984  {
19bdcc7aeed416 Shreyas NC        2020-02-25   985  	struct snd_soc_dai *cpu_dai;
0b7990e38971da Kuninori Morimoto 2018-09-03   986  	struct snd_soc_dai *codec_dai;
244e293690a6e0 Charles Keepax    2018-06-19   987  	int i, ret = 0;
ddee627cf6bb60 Liam Girdwood     2011-06-09   988  
b7898396f4bbe1 Takashi Iwai      2021-12-07   989  	snd_soc_dpcm_mutex_assert_held(rtd);
5cca59516de5df Shengjiu Wang     2019-11-12   990  
5cca59516de5df Shengjiu Wang     2019-11-12   991  	ret = soc_pcm_params_symmetry(substream, params);
5cca59516de5df Shengjiu Wang     2019-11-12   992  	if (ret)
5cca59516de5df Shengjiu Wang     2019-11-12   993  		goto out;
5cca59516de5df Shengjiu Wang     2019-11-12   994  
7cf3c5b4a04f4b Kuninori Morimoto 2020-05-25   995  	ret = snd_soc_link_hw_params(substream, params);
a5e6c1090001b8 Kuninori Morimoto 2020-05-25   996  	if (ret < 0)
ddee627cf6bb60 Liam Girdwood     2011-06-09   997  		goto out;
ddee627cf6bb60 Liam Girdwood     2011-06-09   998  
a4be4187b2bfc6 Kuninori Morimoto 2020-03-09   999  	for_each_rtd_codec_dais(rtd, i, codec_dai) {
2e5894d73789ee Benoit Cousson    2014-07-08  1000  		struct snd_pcm_hw_params codec_params;
e15ff262e21238 Kuninori Morimoto 2023-01-31  1001  		unsigned int tdm_mask = snd_soc_dai_tdm_mask_get(codec_dai, substream->stream);
2e5894d73789ee Benoit Cousson    2014-07-08  1002  
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1003  		/*
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1004  		 * Skip CODECs which don't support the current stream type,
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1005  		 * the idea being that if a CODEC is not used for the currently
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1006  		 * set up transfer direction, it should not need to be
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1007  		 * configured, especially since the configuration used might
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1008  		 * not even be supported by that CODEC. There may be cases
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1009  		 * however where a CODEC needs to be set up although it is
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1010  		 * actually not being used for the transfer, e.g. if a
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1011  		 * capture-only CODEC is acting as an LRCLK and/or BCLK master
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1012  		 * for the DAI link including a playback-only CODEC.
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1013  		 * If this becomes necessary, we will have to augment the
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1014  		 * machine driver setup with information on how to act, so
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1015  		 * we can do the right thing here.
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1016  		 */
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1017  		if (!snd_soc_dai_stream_valid(codec_dai, substream->stream))
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1018  			continue;
cde79035c6cf57 Ricard Wanderlof  2015-08-24  1019  
2e5894d73789ee Benoit Cousson    2014-07-08  1020  		/* copy params for each codec */
2e5894d73789ee Benoit Cousson    2014-07-08  1021  		codec_params = *params;
2e5894d73789ee Benoit Cousson    2014-07-08  1022  
2e5894d73789ee Benoit Cousson    2014-07-08  1023  		/* fixup params based on TDM slot masks */
e15ff262e21238 Kuninori Morimoto 2023-01-31  1024  		if (tdm_mask)
e15ff262e21238 Kuninori Morimoto 2023-01-31  1025  			soc_pcm_codec_params_fixup(&codec_params, tdm_mask);
2e5894d73789ee Benoit Cousson    2014-07-08  1026  
aa6166c2ac2839 Kuninori Morimoto 2019-07-22  1027  		ret = snd_soc_dai_hw_params(codec_dai, substream,
aa6166c2ac2839 Kuninori Morimoto 2019-07-22  1028  					    &codec_params);
93e6958a3674d2 Benoit Cousson    2014-07-08  1029  		if(ret < 0)
4662c59688b8db Kuninori Morimoto 2020-09-29  1030  			goto out;
ddee627cf6bb60 Liam Girdwood     2011-06-09  1031  
2805b8bd3e0bdd Kuninori Morimoto 2020-12-11  1032  		soc_pcm_set_dai_params(codec_dai, &codec_params);
078a85f2806f0f Charles Keepax    2019-01-31  1033  		snd_soc_dapm_update_dai(substream, &codec_params, codec_dai);
ddee627cf6bb60 Liam Girdwood     2011-06-09  1034  	}
ddee627cf6bb60 Liam Girdwood     2011-06-09  1035  
a4be4187b2bfc6 Kuninori Morimoto 2020-03-09  1036  	for_each_rtd_cpu_dais(rtd, i, cpu_dai) {
ac950278b0872c Bard Liao         2023-06-07  1037  		struct snd_pcm_hw_params cpu_params;
ac950278b0872c Bard Liao         2023-06-07  1038  		unsigned int ch_mask = 0;
ac950278b0872c Bard Liao         2023-06-07  1039  		int j;
ac950278b0872c Bard Liao         2023-06-07  1040  
0e9cf4c452ad7e Bard Liao         2020-02-25  1041  		/*
0e9cf4c452ad7e Bard Liao         2020-02-25  1042  		 * Skip CPUs which don't support the current stream
0e9cf4c452ad7e Bard Liao         2020-02-25  1043  		 * type. See soc_pcm_init_runtime_hw() for more details
0e9cf4c452ad7e Bard Liao         2020-02-25  1044  		 */
0e9cf4c452ad7e Bard Liao         2020-02-25  1045  		if (!snd_soc_dai_stream_valid(cpu_dai, substream->stream))
0e9cf4c452ad7e Bard Liao         2020-02-25  1046  			continue;
0e9cf4c452ad7e Bard Liao         2020-02-25  1047  
ac950278b0872c Bard Liao         2023-06-07  1048  		/* copy params for each cpu */
ac950278b0872c Bard Liao         2023-06-07  1049  		cpu_params = *params;
ac950278b0872c Bard Liao         2023-06-07  1050  
ac950278b0872c Bard Liao         2023-06-07  1051  		if (!rtd->dai_link->codec_ch_maps)
ac950278b0872c Bard Liao         2023-06-07  1052  			goto hw_params;
ac950278b0872c Bard Liao         2023-06-07  1053  		/*
ac950278b0872c Bard Liao         2023-06-07  1054  		 * construct cpu channel mask by combining ch_mask of each
ac950278b0872c Bard Liao         2023-06-07  1055  		 * codec which maps to the cpu.
ac950278b0872c Bard Liao         2023-06-07  1056  		 */
ac950278b0872c Bard Liao         2023-06-07  1057  		for_each_rtd_codec_dais(rtd, j, codec_dai) {
ac950278b0872c Bard Liao         2023-06-07  1058  			if (rtd->dai_link->codec_ch_maps[j].connected_cpu_id == i)
ac950278b0872c Bard Liao         2023-06-07  1059  				ch_mask |= rtd->dai_link->codec_ch_maps[j].ch_mask;
ac950278b0872c Bard Liao         2023-06-07  1060  		}
ac950278b0872c Bard Liao         2023-06-07  1061  
ac950278b0872c Bard Liao         2023-06-07  1062  		/* fixup cpu channel number */
ac950278b0872c Bard Liao         2023-06-07  1063  		if (ch_mask)
ac950278b0872c Bard Liao         2023-06-07  1064  			soc_pcm_codec_params_fixup(&cpu_params, ch_mask);
ac950278b0872c Bard Liao         2023-06-07  1065  
ac950278b0872c Bard Liao         2023-06-07  1066  hw_params:
ac950278b0872c Bard Liao         2023-06-07  1067  		ret = snd_soc_dai_hw_params(cpu_dai, substream, &cpu_params);
93e6958a3674d2 Benoit Cousson    2014-07-08  1068  		if (ret < 0)
4662c59688b8db Kuninori Morimoto 2020-09-29  1069  			goto out;
ddee627cf6bb60 Liam Girdwood     2011-06-09  1070  
19bdcc7aeed416 Shreyas NC        2020-02-25  1071  		/* store the parameters for each DAI */
ac950278b0872c Bard Liao         2023-06-07  1072  		soc_pcm_set_dai_params(cpu_dai, &cpu_params);
ac950278b0872c Bard Liao         2023-06-07  1073  		snd_soc_dapm_update_dai(substream, &cpu_params, cpu_dai);
19bdcc7aeed416 Shreyas NC        2020-02-25  1074  	}
ca58221d2212af Kuninori Morimoto 2019-05-13  1075  
3a36a64a2de469 Kuninori Morimoto 2020-09-29  1076  	ret = snd_soc_pcm_component_hw_params(substream, params);
ddee627cf6bb60 Liam Girdwood     2011-06-09  1077  out:
041107289c5ceb Kuninori Morimoto 2022-08-30  1078  	if (ret < 0)
b7898396f4bbe1 Takashi Iwai      2021-12-07  1079  		soc_pcm_hw_clean(rtd, substream, 1);
ddee627cf6bb60 Liam Girdwood     2011-06-09  1080  
041107289c5ceb Kuninori Morimoto 2022-08-30  1081  	return soc_pcm_ret(rtd, ret);
ddee627cf6bb60 Liam Girdwood     2011-06-09 @1082  }
ddee627cf6bb60 Liam Girdwood     2011-06-09  1083  

:::::: The code at line 1082 was first introduced by commit
:::::: ddee627cf6bb601aa980104fc17d4f84201380be ASoC: core - Separate out PCM operations into new file.

:::::: TO: Liam Girdwood <lrg@ti.com>
:::::: CC: Mark Brown <broonie@opensource.wolfsonmicro.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

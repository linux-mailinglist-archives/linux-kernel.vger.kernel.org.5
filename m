Return-Path: <linux-kernel+bounces-18719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987908261BE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 22:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7C2283173
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 21:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7EBF9E5;
	Sat,  6 Jan 2024 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/BImDs0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C10F9C5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704577530; x=1736113530;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BZj/L9d8QmDiI38CZrDI4hTGF54mL2Vy1/XCTC4nKdw=;
  b=l/BImDs0Ja8qljK1+ngK4x1nAjF7YpC+QRc74YoWJOfiCJVEG3YOPcgc
   C1DQv04Us/rWAUCon+/c1Q9K0hKdXF+NNwbEu7rJu4FRVwSqxjswuvTEP
   7kjt9u3lpi+5L80iaCDezjfmlG+bLN8ZVyoXGgSKy46TKf7X+PE8yXXBv
   iRtxyQNyB6tkcQ2tVBC+oIDiEhHNcoYFu0UCu6wB5jqrXP+ytCTKJH5AD
   OJlTr+iHW6V3PKPsZ5cvL7yr6iFdAaCZibkY2xPo+SkE3SdkB3rsf4FD+
   grhzbkk6dHHhPI8L5rMojOrPqoQGDYLw0qhj6Ay718HFQDmNoygmMdeYD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="5049986"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="5049986"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 13:45:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="22801816"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 06 Jan 2024 13:45:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMETr-00032a-1J;
	Sat, 06 Jan 2024 21:45:23 +0000
Date: Sun, 7 Jan 2024 05:44:23 +0800
From: kernel test robot <lkp@intel.com>
To: Raphael-Xu <13691752556@139.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: sound/soc/codecs/tas2780.c:160:14: sparse: sparse: restricted
 snd_pcm_format_t degrades to integer
Message-ID: <202401070546.NJItWLJY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: eae9f9ce181be4f47dcba1ee93185b71cac3f312 ASoC: add tas2780 driver
date:   1 year, 6 months ago
config: x86_64-randconfig-122-20240106 (https://download.01.org/0day-ci/archive/20240107/202401070546.NJItWLJY-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401070546.NJItWLJY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401070546.NJItWLJY-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/soc/codecs/tas2780.c:160:14: sparse: sparse: restricted snd_pcm_format_t degrades to integer
   sound/soc/codecs/tas2780.c:167:14: sparse: sparse: restricted snd_pcm_format_t degrades to integer
   sound/soc/codecs/tas2780.c:174:14: sparse: sparse: restricted snd_pcm_format_t degrades to integer
>> sound/soc/codecs/tas2780.c:288:58: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int bitwidth @@     got restricted snd_pcm_format_t @@
   sound/soc/codecs/tas2780.c:288:58: sparse:     expected int bitwidth
   sound/soc/codecs/tas2780.c:288:58: sparse:     got restricted snd_pcm_format_t

vim +160 sound/soc/codecs/tas2780.c

   150	
   151	static int tas2780_set_bitwidth(struct tas2780_priv *tas2780, int bitwidth)
   152	{
   153		struct snd_soc_component *component = tas2780->component;
   154		int sense_en;
   155		int val;
   156		int ret;
   157		int slot_size;
   158	
   159		switch (bitwidth) {
 > 160		case SNDRV_PCM_FORMAT_S16_LE:
   161			ret = snd_soc_component_update_bits(component,
   162				TAS2780_TDM_CFG2,
   163				TAS2780_TDM_CFG2_RXW_MASK,
   164				TAS2780_TDM_CFG2_RXW_16BITS);
   165			slot_size = TAS2780_TDM_CFG2_RXS_16BITS;
   166			break;
   167		case SNDRV_PCM_FORMAT_S24_LE:
   168			ret = snd_soc_component_update_bits(component,
   169				TAS2780_TDM_CFG2,
   170				TAS2780_TDM_CFG2_RXW_MASK,
   171				TAS2780_TDM_CFG2_RXW_24BITS);
   172			slot_size = TAS2780_TDM_CFG2_RXS_24BITS;
   173			break;
   174		case SNDRV_PCM_FORMAT_S32_LE:
   175			ret = snd_soc_component_update_bits(component,
   176				TAS2780_TDM_CFG2,
   177				TAS2780_TDM_CFG2_RXW_MASK,
   178				TAS2780_TDM_CFG2_RXW_32BITS);
   179			slot_size = TAS2780_TDM_CFG2_RXS_32BITS;
   180			break;
   181	
   182		default:
   183			ret = -EINVAL;
   184		}
   185	
   186		if (ret < 0) {
   187			dev_err(tas2780->dev, "%s:errCode:0x%x set bitwidth error\n",
   188				__func__, ret);
   189			goto err;
   190		}
   191	
   192		ret = snd_soc_component_update_bits(component, TAS2780_TDM_CFG2,
   193			TAS2780_TDM_CFG2_RXS_MASK, slot_size);
   194		if (ret < 0) {
   195			dev_err(tas2780->dev,
   196				"%s:errCode:0x%x set RX slot size error\n",
   197				__func__, ret);
   198			goto err;
   199		}
   200	
   201		val = snd_soc_component_read(tas2780->component, TAS2780_PWR_CTRL);
   202		if (val < 0) {
   203			dev_err(tas2780->dev, "%s:errCode:0x%x read PWR_CTRL error\n",
   204				__func__, val);
   205			ret = val;
   206			goto err;
   207		}
   208	
   209		if (val & (1 << TAS2780_VSENSE_POWER_EN))
   210			sense_en = 0;
   211		else
   212			sense_en = TAS2780_TDM_CFG5_VSNS_ENABLE;
   213	
   214		ret = snd_soc_component_update_bits(tas2780->component,
   215			TAS2780_TDM_CFG5, TAS2780_TDM_CFG5_VSNS_ENABLE, sense_en);
   216		if (ret < 0) {
   217			dev_err(tas2780->dev, "%s:errCode:0x%x enable vSNS error\n",
   218				__func__, ret);
   219			goto err;
   220		}
   221	
   222		if (val & (1 << TAS2780_ISENSE_POWER_EN))
   223			sense_en = 0;
   224		else
   225			sense_en = TAS2780_TDM_CFG6_ISNS_ENABLE;
   226	
   227		ret = snd_soc_component_update_bits(tas2780->component,
   228			TAS2780_TDM_CFG6, TAS2780_TDM_CFG6_ISNS_ENABLE, sense_en);
   229		if (ret < 0) {
   230			dev_err(tas2780->dev, "%s:errCode:0x%x enable iSNS error\n",
   231				__func__, ret);
   232			goto err;
   233		}
   234		ret = 0;
   235	err:
   236		return ret;
   237	}
   238	
   239	static int tas2780_set_samplerate(
   240		struct tas2780_priv *tas2780, int samplerate)
   241	{
   242		struct snd_soc_component *component = tas2780->component;
   243		int ramp_rate_val;
   244		int ret;
   245	
   246		switch (samplerate) {
   247		case 48000:
   248			ramp_rate_val = TAS2780_TDM_CFG0_SMP_48KHZ |
   249					TAS2780_TDM_CFG0_44_1_48KHZ;
   250			break;
   251		case 44100:
   252			ramp_rate_val = TAS2780_TDM_CFG0_SMP_44_1KHZ |
   253					TAS2780_TDM_CFG0_44_1_48KHZ;
   254			break;
   255		case 96000:
   256			ramp_rate_val = TAS2780_TDM_CFG0_SMP_48KHZ |
   257					TAS2780_TDM_CFG0_88_2_96KHZ;
   258			break;
   259		case 88200:
   260			ramp_rate_val = TAS2780_TDM_CFG0_SMP_44_1KHZ |
   261					TAS2780_TDM_CFG0_88_2_96KHZ;
   262			break;
   263		default:
   264			return -EINVAL;
   265		}
   266		ret = snd_soc_component_update_bits(component, TAS2780_TDM_CFG0,
   267			TAS2780_TDM_CFG0_SMP_MASK | TAS2780_TDM_CFG0_MASK,
   268			ramp_rate_val);
   269		if (ret < 0) {
   270			dev_err(tas2780->dev,
   271				"%s:errCode:0x%x Failed to set ramp_rate_val\n",
   272				__func__, ret);
   273			goto err;
   274		}
   275		ret = 0;
   276	err:
   277		return ret;
   278	}
   279	
   280	static int tas2780_hw_params(struct snd_pcm_substream *substream,
   281		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
   282	{
   283		struct snd_soc_component *component = dai->component;
   284		struct tas2780_priv *tas2780 =
   285			snd_soc_component_get_drvdata(component);
   286		int ret;
   287	
 > 288		ret = tas2780_set_bitwidth(tas2780, params_format(params));
   289		if (ret < 0)
   290			return ret;
   291	
   292		return tas2780_set_samplerate(tas2780, params_rate(params));
   293	}
   294	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


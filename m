Return-Path: <linux-kernel+bounces-10407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CD481D3FF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 13:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5581C21957
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE525D2E9;
	Sat, 23 Dec 2023 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHE0hCGx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF321D264;
	Sat, 23 Dec 2023 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703334133; x=1734870133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JdTJVddce5nTGKgEYfvCn0hUfu9G4o5BGyVJH1RDGFU=;
  b=PHE0hCGxzGaaBqp5+5I5uogX59KEcbkktQdhAUr+dWQQaa3Klu8ZtBTU
   XD12zHIGCe6LAQ4LVUJnlkNa7o958Yxl4AkoEkHfTvGxRqJnEgLKyLK/7
   dWkJyfciDoBZYcU/tmob7eFPfGuMgxPui/x+8phc8TVjsphbU3xUIdgrd
   mJEkJmgwY6xx6O9lVMR/SWgV0l+lErEjGbcZrrfGN1sgreuTCHyo0XpK2
   PrUteOFAO4r6HuRoRnj/yrPvxPdlX8j1lEO+38L8guNCc9tneuIA6csJp
   kMc9s7nh8NyJ5ip+/+qk2i/Y1Wh9BTlRBMvACpR22uKfmmO1N1w+Y6dZH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="376335437"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="376335437"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 04:22:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="19013064"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 23 Dec 2023 04:22:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rH113-000AxU-18;
	Sat, 23 Dec 2023 12:22:05 +0000
Date: Sat, 23 Dec 2023 19:54:50 +0800
From: kernel test robot <lkp@intel.com>
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Claudiu Beznea <Claudiu.Beznea@microchip.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Walker Chen <walker.chen@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ASoC: starfive: Add drivers of Cadence
 Multi-Channel I2S Controller
Message-ID: <202312231911.DFYqQ9Gl-lkp@intel.com>
References: <20231221033223.73201-3-xingyu.wu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221033223.73201-3-xingyu.wu@starfivetech.com>

Hi Xingyu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on robh/for-next linus/master v6.7-rc6 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xingyu-Wu/dt-bindings-ASoC-Add-Cadence-I2S-controller-for-StarFive-JH8100-SoC/20231222-172628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20231221033223.73201-3-xingyu.wu%40starfivetech.com
patch subject: [PATCH v1 2/2] ASoC: starfive: Add drivers of Cadence Multi-Channel I2S Controller
config: sparc64-randconfig-r071-20231223 (https://download.01.org/0day-ci/archive/20231223/202312231911.DFYqQ9Gl-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312231911.DFYqQ9Gl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312231911.DFYqQ9Gl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from sound/soc/starfive/cdns-jh8100-i2s.c:18:
>> sound/soc/starfive/cdns-jh8100-i2s.h:163:6: warning: no previous prototype for 'cdns_jh8100_i2s_pcm_push_tx' [-Wmissing-prototypes]
     163 | void cdns_jh8100_i2s_pcm_push_tx(struct cdns_jh8100_i2s_dev *dev) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/starfive/cdns-jh8100-i2s.h:164:6: warning: no previous prototype for 'cdns_jh8100_i2s_pcm_pop_rx' [-Wmissing-prototypes]
     164 | void cdns_jh8100_i2s_pcm_pop_rx(struct cdns_jh8100_i2s_dev *dev) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/starfive/cdns-jh8100-i2s.h:165:5: warning: no previous prototype for 'cdns_jh8100_i2s_pcm_register' [-Wmissing-prototypes]
     165 | int cdns_jh8100_i2s_pcm_register(struct platform_device *pdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/cdns_jh8100_i2s_pcm_push_tx +163 sound/soc/starfive/cdns-jh8100-i2s.h

   157	
   158	#if IS_ENABLED(CONFIG_SND_SOC_JH8100_CADENCE_I2S_PCM)
   159	void cdns_jh8100_i2s_pcm_push_tx(struct cdns_jh8100_i2s_dev *dev);
   160	void cdns_jh8100_i2s_pcm_pop_rx(struct cdns_jh8100_i2s_dev *dev);
   161	int cdns_jh8100_i2s_pcm_register(struct platform_device *pdev);
   162	#else
 > 163	void cdns_jh8100_i2s_pcm_push_tx(struct cdns_jh8100_i2s_dev *dev) { }
 > 164	void cdns_jh8100_i2s_pcm_pop_rx(struct cdns_jh8100_i2s_dev *dev) { }
 > 165	int cdns_jh8100_i2s_pcm_register(struct platform_device *pdev)
   166	{
   167		return -EINVAL;
   168	}
   169	#endif
   170	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


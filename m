Return-Path: <linux-kernel+bounces-10067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8BC81CF81
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667B9286487
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 21:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD082EAED;
	Fri, 22 Dec 2023 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nM96ILFf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7884E2E84B;
	Fri, 22 Dec 2023 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703280877; x=1734816877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dpqNdfS4ahJoafXVsQek4DZnUBoFniH8a9Xe1zk0FlM=;
  b=nM96ILFfgAIzjBoeLubwMxtFp1AGhsOdrTQZBiNl4WnGLsW81mMzzcaJ
   nzgOX1Miha+GRMQcIo3ZF0Xr2Wkth1An84a12F6o0oME2a0I1/eRinm26
   bEmOQ74bTwfW8mx6vhD4297gh0vEAeJ3sv35uM39sL23mHa9zjf5kx0Hs
   F2fVVipo7YuRB35O89uqwtVw+0u5078KfIopSUZk9x0DNz4pjy9ZKwfti
   S4DosO1D0tPXgXVGJsGD4VujMC0FO5bnL87M4dNVx+wj5n2C+iXcHFI1K
   pKUQIwooypQq/V6oRBmSqIS+9CxS0Iu27SgidLUCt4NDivX1e5clCp4HH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="395052344"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="395052344"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 13:34:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="895566717"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="895566717"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 22 Dec 2023 13:34:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGn9p-0009tc-1J;
	Fri, 22 Dec 2023 21:34:16 +0000
Date: Sat, 23 Dec 2023 05:32:31 +0800
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
Message-ID: <202312230525.gch9VlZT-lkp@intel.com>
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
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20231223/202312230525.gch9VlZT-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312230525.gch9VlZT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312230525.gch9VlZT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/starfive/cdns-jh8100-i2s.c:519:12: warning: 'cdns_jh8100_i2s_runtime_resume' defined but not used [-Wunused-function]
     519 | static int cdns_jh8100_i2s_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/cdns_jh8100_i2s_runtime_resume +519 sound/soc/starfive/cdns-jh8100-i2s.c

   518	
 > 519	static int cdns_jh8100_i2s_runtime_resume(struct device *dev)
   520	{
   521		struct cdns_jh8100_i2s_dev *i2s = dev_get_drvdata(dev);
   522	
   523		return clk_prepare_enable(i2s->clks[1].clk); /* ICG clock */
   524	}
   525	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


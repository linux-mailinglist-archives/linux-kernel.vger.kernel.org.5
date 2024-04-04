Return-Path: <linux-kernel+bounces-132222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A175A89919E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A581F2797A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC4E7175D;
	Thu,  4 Apr 2024 22:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jI6yA9Ei"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D78F71723;
	Thu,  4 Apr 2024 22:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271203; cv=none; b=CQHoQL6+vktB/WTYdn0XDtDQarNlL4Iwp1gxFX0D7LTA5Qw+zgYPa159skWaEMjlYCBeyExL+V1UXKBonxOWPtLjjHrF7L6gyW2st/YYhQ8HpFsK+wxnXtf/+sKM+kj9MH8pUW/eZiiu3pZ/VLYh5kgN9v/aGLfQS7zxfoivkEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271203; c=relaxed/simple;
	bh=nHDeIZjgG/ABq+COPbhriixxj1CJ1aiFsFPnz9B5/Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzXPltvc/38mxa0NM3bUVoz3/WDmJV9bb4Gffd77wvu/IRggzZ5bcSn0Ahz1dyD3UxIdk8C9x/x6KqNR3HfzjMM1eCmSdUtrmOv9wgJLJxxiAmHZ214Jkl4+nW3AGm91VaCm+GxrJ4Jomqbwu0L/Y6jd2OM2OZ6H4HDP1ghhQq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jI6yA9Ei; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712271202; x=1743807202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nHDeIZjgG/ABq+COPbhriixxj1CJ1aiFsFPnz9B5/Ew=;
  b=jI6yA9Ein2vQr/xrpwN8Wdagm7yBeJxof7VWn5CEPxe/EsC71g1w9spL
   Y+VSCINywYjsWn4HO8pgnux8klDq/AJ4LGrR0UIyHE2tduDWPEIrx6IRg
   Fpe7WN5hDQpt/GaO7Fo0cb2yFBTxU1Tgjq+EeDtn6R1yEEP9CoggIE28E
   XHyyct9M1XPrvh6lVz6z7eW5Plzsyl0MpUh/X76w5Fj0weCWVjYMHycQt
   r7J+3KzNtqMPZFwbTN1M8Ux+1+g6Z6Bc1CNRqylefVbjnTnrZnySJjGI/
   HaY73yb3c9C07Q99wWYCCrNFAcsH+Yd+Nh1d3IDcDISvD8zA4rCAm1a8S
   w==;
X-CSE-ConnectionGUID: AxPZNNiXQ+Sm++dRuJQXTQ==
X-CSE-MsgGUID: DGEll113QRa54DvJegj47A==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7747184"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7747184"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 15:53:21 -0700
X-CSE-ConnectionGUID: DMVI8dVNQt+mFpCKldjuFw==
X-CSE-MsgGUID: qHDgff3ISNujXJMguBDG9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="50191958"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Apr 2024 15:53:14 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsVxH-0001b6-2d;
	Thu, 04 Apr 2024 22:53:11 +0000
Date: Fri, 5 Apr 2024 06:52:21 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Griffin <peter.griffin@linaro.org>, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	s.nawrocki@samsung.com, cw00.choi@samsung.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, chanho61.park@samsung.com,
	ebiggers@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org, andre.draszik@linaro.org,
	saravanak@google.com, willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH 08/17] clk: samsung: gs101: add support for cmu_hsi2
Message-ID: <202404050633.EZfOttFD-lkp@intel.com>
References: <20240404122559.898930-9-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404122559.898930-9-peter.griffin@linaro.org>

Hi Peter,

kernel test robot noticed the following build warnings:

[auto build test WARNING on krzk/for-next]
[also build test WARNING on robh/for-next clk/clk-next linus/master v6.9-rc2 next-20240404]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Griffin/dt-bindings-clock-google-gs101-clock-add-HSI2-clock-management-unit/20240404-205113
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
patch link:    https://lore.kernel.org/r/20240404122559.898930-9-peter.griffin%40linaro.org
patch subject: [PATCH 08/17] clk: samsung: gs101: add support for cmu_hsi2
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240405/202404050633.EZfOttFD-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240405/202404050633.EZfOttFD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404050633.EZfOttFD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/clk/samsung/clk-gs101.c:16:
>> drivers/clk/samsung/clk-gs101.c:3640:7: warning: 'mout_hsi2_mmc_card_p' defined but not used [-Wunused-const-variable=]
    3640 | PNAME(mout_hsi2_mmc_card_p)     = { "fout_shared2_pll", "fout_shared3_pll",
         |       ^~~~~~~~~~~~~~~~~~~~
   drivers/clk/samsung/clk.h:229:44: note: in definition of macro 'PNAME'
     229 | #define PNAME(x) static const char * const x[] __initconst
         |                                            ^
>> drivers/clk/samsung/clk-gs101.c:3633:7: warning: 'mout_hsi2_bus_p' defined but not used [-Wunused-const-variable=]
    3633 | PNAME(mout_hsi2_bus_p)          = { "dout_cmu_shared0_div4",
         |       ^~~~~~~~~~~~~~~
   drivers/clk/samsung/clk.h:229:44: note: in definition of macro 'PNAME'
     229 | #define PNAME(x) static const char * const x[] __initconst
         |                                            ^
>> drivers/clk/samsung/clk-gs101.c:3631:7: warning: 'mout_hsi2_pcie_p' defined but not used [-Wunused-const-variable=]
    3631 | PNAME(mout_hsi2_pcie_p)         = { "oscclk", "dout_cmu_shared2_div2" };
         |       ^~~~~~~~~~~~~~~~
   drivers/clk/samsung/clk.h:229:44: note: in definition of macro 'PNAME'
     229 | #define PNAME(x) static const char * const x[] __initconst
         |                                            ^
>> drivers/clk/samsung/clk-gs101.c:3628:7: warning: 'mout_hsi2_ufs_embd_p' defined but not used [-Wunused-const-variable=]
    3628 | PNAME(mout_hsi2_ufs_embd_p)     = { "oscclk", "dout_cmu_shared0_div4",
         |       ^~~~~~~~~~~~~~~~~~~~
   drivers/clk/samsung/clk.h:229:44: note: in definition of macro 'PNAME'
     229 | #define PNAME(x) static const char * const x[] __initconst
         |                                            ^


vim +/mout_hsi2_mmc_card_p +3640 drivers/clk/samsung/clk-gs101.c

  3627	
> 3628	PNAME(mout_hsi2_ufs_embd_p)	= { "oscclk", "dout_cmu_shared0_div4",
  3629					    "dout_cmu_shared2_div2", "fout_spare_pll" };
  3630	
> 3631	PNAME(mout_hsi2_pcie_p)		= { "oscclk", "dout_cmu_shared2_div2" };
  3632	
> 3633	PNAME(mout_hsi2_bus_p)		= { "dout_cmu_shared0_div4",
  3634					    "dout_cmu_shared1_div4",
  3635					    "dout_cmu_shared2_div2",
  3636					    "dout_cmu_shared3_div2",
  3637					    "fout_spare_pll", "oscclk", "oscclk",
  3638					    "oscclk" };
  3639	
> 3640	PNAME(mout_hsi2_mmc_card_p)	= { "fout_shared2_pll", "fout_shared3_pll",
  3641					    "dout_cmu_shared0_div4", "fout_spare_pll" };
  3642	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


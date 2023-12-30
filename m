Return-Path: <linux-kernel+bounces-13326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2C7820389
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 04:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033F51C211D3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 03:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBA74696;
	Sat, 30 Dec 2023 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJkYXgpb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97694416;
	Sat, 30 Dec 2023 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703908631; x=1735444631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7KTADohvzNzWSyBpmRRq9cn6nMwx5d/WtwPcUCMZsaA=;
  b=nJkYXgpbXPq0JsH8CjGryDRNaPd5689AbgjQMGGaynDFy4rQdzFCK7j8
   WUBDuVINPgiOYt2tPtOSOw3LjSom3+yUCkzYrgadYQs5xHG2j4xyf/p5D
   8ycmssCfLZr7S1ZIE5kZ83vfBV3TBYcSkFF+sMaVz4CBMMJBT8rjxznh9
   NXWxPFL5OWb4DYy7U7Ocrcakh3TbVVsD4ItZT47GGeyZP6A7APNpy2Sh6
   G1daj3D8WmJ5HQ+mPnA0uIsRWSwL54LUTIFEp1ECHJ2BCgy8BiB6GMStX
   ILAAjFTpa7GaPWx9Sj/cURKm9YOK7EtF5f7UtTuhLiEPIhH3hw8nZ3WhF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="396429681"
X-IronPort-AV: E=Sophos;i="6.04,317,1695711600"; 
   d="scan'208";a="396429681"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 19:57:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="778943952"
X-IronPort-AV: E=Sophos;i="6.04,317,1695711600"; 
   d="scan'208";a="778943952"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 29 Dec 2023 19:57:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJQTC-000I2H-0C;
	Sat, 30 Dec 2023 03:57:06 +0000
Date: Sat, 30 Dec 2023 11:56:29 +0800
From: kernel test robot <lkp@intel.com>
To: Sergey Khimich <serghox@gmail.com>, linux-mmc@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jyan Chou <jyanchou@realtek.com>
Subject: Re: [PATCH v4 2/2] mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support
Message-ID: <202312301155.5OSXAOG5-lkp@intel.com>
References: <20231229101128.392089-3-serghox@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229101128.392089-3-serghox@gmail.com>

Hi Sergey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on ulf-hansson-mmc-mirror/next v6.7-rc7]
[cannot apply to next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sergey-Khimich/mmc-cqhci-Add-cqhci-set_tran_desc-callback/20231229-181345
base:   linus/master
patch link:    https://lore.kernel.org/r/20231229101128.392089-3-serghox%40gmail.com
patch subject: [PATCH v4 2/2] mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231230/202312301155.5OSXAOG5-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231230/202312301155.5OSXAOG5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312301155.5OSXAOG5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-of-dwcmshc.c:224:5: warning: no previous prototype for 'dwcmshc_execute_tuning' [-Wmissing-prototypes]
     224 | int dwcmshc_execute_tuning(struct mmc_host *mmc, u32 opcode)
         |     ^~~~~~~~~~~~~~~~~~~~~~


vim +/dwcmshc_execute_tuning +224 drivers/mmc/host/sdhci-of-dwcmshc.c

   223	
 > 224	int dwcmshc_execute_tuning(struct mmc_host *mmc, u32 opcode)
   225	{
   226		int err = sdhci_execute_tuning(mmc, opcode);
   227		struct sdhci_host *host = mmc_priv(mmc);
   228	
   229		if (err)
   230			return err;
   231	
   232		/*
   233		 * Tuning can leave the IP in an active state (Buffer Read Enable bit
   234		 * set) which prevents the entry to low power states (i.e. S0i3). Data
   235		 * reset will clear it.
   236		 */
   237		sdhci_reset(host, SDHCI_RESET_DATA);
   238	
   239		return 0;
   240	}
   241	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


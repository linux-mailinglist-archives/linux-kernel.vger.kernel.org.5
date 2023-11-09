Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C087E71BD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345059AbjKISuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345046AbjKISud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:50:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5FE3C0E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699555832; x=1731091832;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PGvYyFVw+q+L99L7GnKiK36ka8U3v3VCNhnM8v0C5Y8=;
  b=dzBb55wlwbW5y1M2CMaKqN4g64DU1MyLiI+HYqArA7PHfQHI4A1MOoWP
   CbZahkAuFNKI5eTjIblOyhyRgK+dB/vzLlxZ9OBpFejT6m5gHCVfCFts4
   SNg9hBbJeCf/eykZyETbakW1XC0GnYRIn4KATWU5pfoDDX5cMQLP9crVs
   lpWz7mJpbpdJSbfxUstZdkMccYdxe8OmClAZQDdzsdYyob9Ef3yXAqiZS
   84rt4QHmBpgqU05i4jz0slVZ0wX6zD1SXDFGFs82JfqIkaxYm23HbROWm
   Jy4Y7O3LwxVhL3EW3hC5g8FikCQHHVrDEJN2gP15xwi1vnY/k7dHMkuzj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="3087095"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="3087095"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 10:50:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="880688831"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="880688831"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Nov 2023 10:50:25 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1A6h-000933-1y;
        Thu, 09 Nov 2023 18:50:23 +0000
Date:   Fri, 10 Nov 2023 02:49:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: drivers/edac/versal_edac.c:745:21: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202311100254.i2Rgql3X-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bc986ab839c844e78a2333a02e55f02c9e57935
commit: 6f15b178cd6315c997981f76c6ebed7ad39144c5 EDAC/versal: Add a Xilinx Versal memory controller driver
date:   2 weeks ago
config: arm64-randconfig-r121-20231109 (https://download.01.org/0day-ci/archive/20231110/202311100254.i2Rgql3X-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231110/202311100254.i2Rgql3X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311100254.i2Rgql3X-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/edac/versal_edac.c:745:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const * @@     got char const [noderef] __user *data @@
   drivers/edac/versal_edac.c:745:21: sparse:     expected char const *
   drivers/edac/versal_edac.c:745:21: sparse:     got char const [noderef] __user *data

vim +745 drivers/edac/versal_edac.c

   736	
   737	static ssize_t xddr_inject_data_poison_store(struct mem_ctl_info *mci,
   738						     const char __user *data)
   739	{
   740		struct edac_priv *priv = mci->pvt_info;
   741	
   742		writel(0, priv->ddrmc_baseaddr + ECCW0_FLIP0_OFFSET);
   743		writel(0, priv->ddrmc_baseaddr + ECCW1_FLIP0_OFFSET);
   744	
 > 745		if (strncmp(data, "CE", 2) == 0) {
   746			writel(ECC_CEPOISON_MASK, priv->ddrmc_baseaddr +
   747			       ECCW0_FLIP0_OFFSET);
   748			writel(ECC_CEPOISON_MASK, priv->ddrmc_baseaddr +
   749			       ECCW1_FLIP0_OFFSET);
   750		} else {
   751			writel(ECC_UEPOISON_MASK, priv->ddrmc_baseaddr +
   752			       ECCW0_FLIP0_OFFSET);
   753			writel(ECC_UEPOISON_MASK, priv->ddrmc_baseaddr +
   754			       ECCW1_FLIP0_OFFSET);
   755		}
   756	
   757		/* Lock the PCSR registers */
   758		writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
   759	
   760		return 0;
   761	}
   762	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

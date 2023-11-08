Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B4F7E4E79
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjKHBLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjKHBLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:11:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEA7E7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 17:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699405859; x=1730941859;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EKS17sYaDCEyWkiDk5EsTfJpaqXNTvXg8O5cE3E3W40=;
  b=i3MN/nNp4SafIkUnk+iNwTmUOGPJUzACgdxY1radTEMsZu39IK/L98dI
   qug1Obwpy/P1YrvEc3P8OUvLqmXCssRn38Xb+1M+uwcJ5BRwP6pGsTqhn
   nnlcGtmoBoul0dE56rmea7djKPT+0g7zp20vJYUsbKMTEuXxfdXyPXj30
   XrTnHU6Z+fUqJcUgK+FVc10LYQ4brh/Z31Qav40FH7chBZPNfyR4mLGwD
   HiE1Z1pJCIkq+CMEP2BjVsKU1OxzMSW1ocwguxJEw2gCCRUP/3ZO7poqV
   GLWGN7rusPEAP7Xovb5dqkg0uxWyC/5y/yW8grdRiSPaD5gtyhn60NlMc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="475891258"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="475891258"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 17:10:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="10623719"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 07 Nov 2023 17:10:40 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0X5a-0007XX-0j;
        Wed, 08 Nov 2023 01:10:38 +0000
Date:   Wed, 8 Nov 2023 09:04:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: drivers/remoteproc/stm32_rproc.c:139:20: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202311080824.j8FQFyrT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   13d88ac54ddd1011b6e94443958e798aa06eb835
commit: 03bd158e1535e68bcd2b1e095b0ebcad7c84bd20 remoteproc: stm32: use correct format strings on 64-bit
date:   5 months ago
config: mips-randconfig-r122-20231108 (https://download.01.org/0day-ci/archive/20231108/202311080824.j8FQFyrT-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231108/202311080824.j8FQFyrT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311080824.j8FQFyrT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/stm32_rproc.c:122:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/stm32_rproc.c:122:12: sparse:     expected void *va
   drivers/remoteproc/stm32_rproc.c:122:12: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/stm32_rproc.c:139:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *va @@
   drivers/remoteproc/stm32_rproc.c:139:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/remoteproc/stm32_rproc.c:139:20: sparse:     got void *va
   drivers/remoteproc/stm32_rproc.c:644:17: sparse: sparse: cast removes address space '__iomem' of expression

vim +139 drivers/remoteproc/stm32_rproc.c

13140de09cc2dd5 Fabien Dessenne 2019-05-14  114  
13140de09cc2dd5 Fabien Dessenne 2019-05-14  115  static int stm32_rproc_mem_alloc(struct rproc *rproc,
13140de09cc2dd5 Fabien Dessenne 2019-05-14  116  				 struct rproc_mem_entry *mem)
13140de09cc2dd5 Fabien Dessenne 2019-05-14  117  {
13140de09cc2dd5 Fabien Dessenne 2019-05-14  118  	struct device *dev = rproc->dev.parent;
13140de09cc2dd5 Fabien Dessenne 2019-05-14  119  	void *va;
13140de09cc2dd5 Fabien Dessenne 2019-05-14  120  
03bd158e1535e68 Arnd Bergmann   2023-06-09  121  	dev_dbg(dev, "map memory: %pad+%zx\n", &mem->dma, mem->len);
13140de09cc2dd5 Fabien Dessenne 2019-05-14 @122  	va = ioremap_wc(mem->dma, mem->len);
13140de09cc2dd5 Fabien Dessenne 2019-05-14  123  	if (IS_ERR_OR_NULL(va)) {
03bd158e1535e68 Arnd Bergmann   2023-06-09  124  		dev_err(dev, "Unable to map memory region: %pad+0x%zx\n",
13140de09cc2dd5 Fabien Dessenne 2019-05-14  125  			&mem->dma, mem->len);
13140de09cc2dd5 Fabien Dessenne 2019-05-14  126  		return -ENOMEM;
13140de09cc2dd5 Fabien Dessenne 2019-05-14  127  	}
13140de09cc2dd5 Fabien Dessenne 2019-05-14  128  
13140de09cc2dd5 Fabien Dessenne 2019-05-14  129  	/* Update memory entry va */
13140de09cc2dd5 Fabien Dessenne 2019-05-14  130  	mem->va = va;
13140de09cc2dd5 Fabien Dessenne 2019-05-14  131  
13140de09cc2dd5 Fabien Dessenne 2019-05-14  132  	return 0;
13140de09cc2dd5 Fabien Dessenne 2019-05-14  133  }
13140de09cc2dd5 Fabien Dessenne 2019-05-14  134  
13140de09cc2dd5 Fabien Dessenne 2019-05-14  135  static int stm32_rproc_mem_release(struct rproc *rproc,
13140de09cc2dd5 Fabien Dessenne 2019-05-14  136  				   struct rproc_mem_entry *mem)
13140de09cc2dd5 Fabien Dessenne 2019-05-14  137  {
13140de09cc2dd5 Fabien Dessenne 2019-05-14  138  	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
13140de09cc2dd5 Fabien Dessenne 2019-05-14 @139  	iounmap(mem->va);
13140de09cc2dd5 Fabien Dessenne 2019-05-14  140  
13140de09cc2dd5 Fabien Dessenne 2019-05-14  141  	return 0;
13140de09cc2dd5 Fabien Dessenne 2019-05-14  142  }
13140de09cc2dd5 Fabien Dessenne 2019-05-14  143  

:::::: The code at line 139 was first introduced by commit
:::::: 13140de09cc2dd5e5166ad42292bb82af4e23cef remoteproc: stm32: add an ST stm32_rproc driver

:::::: TO: Fabien Dessenne <fabien.dessenne@st.com>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

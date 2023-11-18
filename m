Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427C57EFD99
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 04:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346428AbjKRDtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 22:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjKRDte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 22:49:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8ECD72
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700279366; x=1731815366;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+EoFR0cj0+VGJ4groLlxTDAtdkFOj1XwxfhyfTgLFts=;
  b=mLyZffc3bGZwegzNZDl2vUy6txeD8DH4//jyMLC3hGkAyPJm4awf4N4j
   jKtMv4j/TfZnyabMwzunmECW/18NriJ9SNpQt8kwgpdNyBzvaZKhXMCyY
   1Wd6nBF/iDdMiOTpRatMsBUrtydY3fl8emKOYU+KqS7ls1Hqlw1B7objn
   OU6mWpva32zbbE4hOk1OEoEmn3dz5CD6Bbn5hn3ikHFRleM0cdTK1/yeA
   iOVm99+sogrfg398d1Zb61i/6H5R6g6AzkMgUAyzWt/Y+Wc5mawDpKzhF
   6StucjVWkYcs7PK6FPW8PdC+MEWw9CKcycaYNA1ofZvqPrM640iuoH1Qo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="376452269"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="376452269"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 19:49:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="13661858"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 17 Nov 2023 19:49:25 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4CKg-0003Up-0K;
        Sat, 18 Nov 2023 03:49:22 +0000
Date:   Sat, 18 Nov 2023 11:49:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: drivers/remoteproc/stm32_rproc.c:139:20: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202311181131.FV6wkpIs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   791c8ab095f71327899023223940dd52257a4173
commit: 03bd158e1535e68bcd2b1e095b0ebcad7c84bd20 remoteproc: stm32: use correct format strings on 64-bit
date:   5 months ago
config: arm-randconfig-r121-20231118 (https://download.01.org/0day-ci/archive/20231118/202311181131.FV6wkpIs-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231118/202311181131.FV6wkpIs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311181131.FV6wkpIs-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/stm32_rproc.c:122:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/stm32_rproc.c:122:12: sparse:     expected void *va
   drivers/remoteproc/stm32_rproc.c:122:12: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/stm32_rproc.c:139:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *va @@
   drivers/remoteproc/stm32_rproc.c:139:20: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/remoteproc/stm32_rproc.c:139:20: sparse:     got void *va
   drivers/remoteproc/stm32_rproc.c:644:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/remoteproc/stm32_rproc.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false

vim +139 drivers/remoteproc/stm32_rproc.c

13140de09cc2dd Fabien Dessenne 2019-05-14  114  
13140de09cc2dd Fabien Dessenne 2019-05-14  115  static int stm32_rproc_mem_alloc(struct rproc *rproc,
13140de09cc2dd Fabien Dessenne 2019-05-14  116  				 struct rproc_mem_entry *mem)
13140de09cc2dd Fabien Dessenne 2019-05-14  117  {
13140de09cc2dd Fabien Dessenne 2019-05-14  118  	struct device *dev = rproc->dev.parent;
13140de09cc2dd Fabien Dessenne 2019-05-14  119  	void *va;
13140de09cc2dd Fabien Dessenne 2019-05-14  120  
03bd158e1535e6 Arnd Bergmann   2023-06-09  121  	dev_dbg(dev, "map memory: %pad+%zx\n", &mem->dma, mem->len);
13140de09cc2dd Fabien Dessenne 2019-05-14 @122  	va = ioremap_wc(mem->dma, mem->len);
13140de09cc2dd Fabien Dessenne 2019-05-14  123  	if (IS_ERR_OR_NULL(va)) {
03bd158e1535e6 Arnd Bergmann   2023-06-09  124  		dev_err(dev, "Unable to map memory region: %pad+0x%zx\n",
13140de09cc2dd Fabien Dessenne 2019-05-14  125  			&mem->dma, mem->len);
13140de09cc2dd Fabien Dessenne 2019-05-14  126  		return -ENOMEM;
13140de09cc2dd Fabien Dessenne 2019-05-14  127  	}
13140de09cc2dd Fabien Dessenne 2019-05-14  128  
13140de09cc2dd Fabien Dessenne 2019-05-14  129  	/* Update memory entry va */
13140de09cc2dd Fabien Dessenne 2019-05-14  130  	mem->va = va;
13140de09cc2dd Fabien Dessenne 2019-05-14  131  
13140de09cc2dd Fabien Dessenne 2019-05-14  132  	return 0;
13140de09cc2dd Fabien Dessenne 2019-05-14  133  }
13140de09cc2dd Fabien Dessenne 2019-05-14  134  
13140de09cc2dd Fabien Dessenne 2019-05-14  135  static int stm32_rproc_mem_release(struct rproc *rproc,
13140de09cc2dd Fabien Dessenne 2019-05-14  136  				   struct rproc_mem_entry *mem)
13140de09cc2dd Fabien Dessenne 2019-05-14  137  {
13140de09cc2dd Fabien Dessenne 2019-05-14  138  	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
13140de09cc2dd Fabien Dessenne 2019-05-14 @139  	iounmap(mem->va);
13140de09cc2dd Fabien Dessenne 2019-05-14  140  
13140de09cc2dd Fabien Dessenne 2019-05-14  141  	return 0;
13140de09cc2dd Fabien Dessenne 2019-05-14  142  }
13140de09cc2dd Fabien Dessenne 2019-05-14  143  

:::::: The code at line 139 was first introduced by commit
:::::: 13140de09cc2dd5e5166ad42292bb82af4e23cef remoteproc: stm32: add an ST stm32_rproc driver

:::::: TO: Fabien Dessenne <fabien.dessenne@st.com>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

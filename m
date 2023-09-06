Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7422079463B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 00:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbjIFWfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 18:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjIFWfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:35:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D893419AE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 15:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694039708; x=1725575708;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qg1VT1sBPSgMYLBDvSJrNzsTj+lZy5SZ8Bvh677TZRA=;
  b=Zibj3omGiExiKv0PTnbrvF148aj6kKwJbTQzl3TmGHMW4ejgJamT2me0
   2fzZV/wPzP/EikWAxEkMOMjp0c3+1KHhWiQY6Jv0lJrPanWLplSwY8e44
   yWXVYa9z+/J0xH4P3nuSILDuqKYS0p4g6cH4UKGluYaK+di1lt4ltaal6
   FqyzgwQcU9/2V2oLIaIVtDYlXE6fPQ68SBuVPWL3lvSZZro4JvEVNZzj7
   yt7ogUBcDxk8tQKC/2Gt82V5hYtl8spigcLslMUZJX6V4uQr3U49zZ9Z6
   HNn3iv4x559RKzOjtR7qgR3q7C5Ac6t8F5OxB0uSyoL6wSstnAch6DV2/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="441188230"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="441188230"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 15:35:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="865341984"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="865341984"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Sep 2023 15:35:07 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qe173-0000eR-06;
        Wed, 06 Sep 2023 22:35:05 +0000
Date:   Thu, 7 Sep 2023 06:34:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: drivers/remoteproc/stm32_rproc.c:122:12: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202309070614.RoOUEXgt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   744a759492b5c57ff24a6e8aabe47b17ad8ee964
commit: 03bd158e1535e68bcd2b1e095b0ebcad7c84bd20 remoteproc: stm32: use correct format strings on 64-bit
date:   3 months ago
config: csky-randconfig-r121-20230906 (https://download.01.org/0day-ci/archive/20230907/202309070614.RoOUEXgt-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230907/202309070614.RoOUEXgt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309070614.RoOUEXgt-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/stm32_rproc.c:122:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/stm32_rproc.c:122:12: sparse:     expected void *va
   drivers/remoteproc/stm32_rproc.c:122:12: sparse:     got void [noderef] __iomem *
   drivers/remoteproc/stm32_rproc.c:139:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *va @@
   drivers/remoteproc/stm32_rproc.c:139:20: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/remoteproc/stm32_rproc.c:139:20: sparse:     got void *va
>> drivers/remoteproc/stm32_rproc.c:644:17: sparse: sparse: cast removes address space '__iomem' of expression

vim +122 drivers/remoteproc/stm32_rproc.c

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

:::::: The code at line 122 was first introduced by commit
:::::: 13140de09cc2dd5e5166ad42292bb82af4e23cef remoteproc: stm32: add an ST stm32_rproc driver

:::::: TO: Fabien Dessenne <fabien.dessenne@st.com>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

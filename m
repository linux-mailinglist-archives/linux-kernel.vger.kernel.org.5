Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F637FD4A0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjK2KqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjK2KqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:46:02 -0500
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Nov 2023 02:46:06 PST
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2773E10C4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701254766; x=1732790766;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tAA3JyoOSCo+TNAdr+NmsuknLSEqhg5tDenfDzhMgHs=;
  b=GAPqjh1RAaije5PwTqSzzY7A721NWyt0F5BKyyiu3/CUp9oOdZW7FUzP
   kH2ERWOqXBns9Ptc0Ox917GMJUivn4l2qod4d0n5tlKeY0ufmnnA/i9/9
   LdmsJ4VDozsmhfqNRydJkaLWtRXADZqZqRG7IylkP/8cI/e//3YJSEGZR
   alZ87y5tbZZdAYfSEvM/4u8loooteRf0awFh1g/VrVBxzS3G7xzDmJZ5R
   iBaM6wY8SA9faohvelCSH0i5RoSYaW/0p5bxOtULruMZeVQBCcwZId4f9
   Ul3lKEip+BB2tXLbuUZljHjZHUIVDisn+poFNZNRrXWQRIIHhtQ7MnGCY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="29530"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="29530"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:45:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="834969699"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="834969699"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 29 Nov 2023 02:45:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8I3w-00006G-0l;
        Wed, 29 Nov 2023 10:45:00 +0000
Date:   Wed, 29 Nov 2023 18:44:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: drivers/remoteproc/stm32_rproc.c:139:20: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202311291623.yfI5obiT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   18d46e76d7c2eedd8577fae67e3f1d4db25018b0
commit: 03bd158e1535e68bcd2b1e095b0ebcad7c84bd20 remoteproc: stm32: use correct format strings on 64-bit
date:   5 months ago
config: microblaze-randconfig-r034-20230909 (https://download.01.org/0day-ci/archive/20231129/202311291623.yfI5obiT-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231129/202311291623.yfI5obiT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311291623.yfI5obiT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/stm32_rproc.c:122:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/stm32_rproc.c:122:12: sparse:     expected void *va
   drivers/remoteproc/stm32_rproc.c:122:12: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/stm32_rproc.c:139:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *va @@
   drivers/remoteproc/stm32_rproc.c:139:20: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/remoteproc/stm32_rproc.c:139:20: sparse:     got void *va
   drivers/remoteproc/stm32_rproc.c:644:17: sparse: sparse: cast removes address space '__iomem' of expression

vim +139 drivers/remoteproc/stm32_rproc.c

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

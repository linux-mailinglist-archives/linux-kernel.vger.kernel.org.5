Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B97806306
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjLEXe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEXe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:34:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F45A137
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 15:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701819303; x=1733355303;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iyM8ro7RsQ4+Pgny0pEn8oxhHpuc4JLJ1i7uBx+bacM=;
  b=PF4svUk8lpFP9dQpp82sbZGmCFMnC1nAzFALIm2qvyCBThul0r3iotI0
   JS+jUuPXSh7F9Y8PCVGUTou8cDFPrChXmufJDrKg5F4Q1xiss3MUFVlkg
   PjEjTxD0qIg/DtOZFhWw91Zu4Beij00PlKW8Bw1lAtPpbNfv56/BaQzbH
   2esR32BisomRpJdh/DoZeUn3b87dky09SP99KjSxRBkzPflwuejyEB2WF
   Ya/cR9BDZnJp9nwItOEfYCv3zJY5eAKjCxcHFPBVGZw5tzpYxF4y1/jfR
   5RYd21MNaCPrWpn/1HfTPhzh7qy1HccBYeryrGcci7ZRc8bfJv5dM3wCU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="374157354"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="374157354"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 15:35:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="914974631"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="914974631"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 05 Dec 2023 15:35:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAewM-0009sM-2o;
        Tue, 05 Dec 2023 23:34:58 +0000
Date:   Wed, 6 Dec 2023 07:34:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: drivers/remoteproc/stm32_rproc.c:139:20: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202312060704.Jby88WRF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 03bd158e1535e68bcd2b1e095b0ebcad7c84bd20 remoteproc: stm32: use correct format strings on 64-bit
date:   6 months ago
config: mips-randconfig-r122-20231108 (https://download.01.org/0day-ci/archive/20231206/202312060704.Jby88WRF-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312060704.Jby88WRF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060704.Jby88WRF-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/stm32_rproc.c:122:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/stm32_rproc.c:122:12: sparse:     expected void *va
   drivers/remoteproc/stm32_rproc.c:122:12: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/stm32_rproc.c:139:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *va @@
   drivers/remoteproc/stm32_rproc.c:139:20: sparse:     expected void const volatile [noderef] __iomem *addr
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

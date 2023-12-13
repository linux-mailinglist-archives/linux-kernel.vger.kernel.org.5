Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C809810ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377814AbjLMKtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjLMKs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:48:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1942799
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702464543; x=1734000543;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KUh5tvimxAf3MbeVJV4qN4C/AzAsXEXceasJd+D8H5Q=;
  b=IAQPNy6EzoKH1QrkkFYyMYnfuakHJmPWDJMKABXBpb9uAYYje+qXh2Z3
   y7ajqREuRdO2pcwP8BnIzaKvteAgMO9lgFeA6ZUgLOT651jLBu5RQ84y3
   STBGeUEMsaRqz9LJCKkvlO4dq7DuMLQJz1vWRs7hyWKaWOB/V+GxISHlw
   jpLhtKL9TStUHDvuzTxhmJ4fe3DiJRsUVhoUp/JABc9Qet1NzIT2sfU9g
   bJtxGPkDdRxwihHuEqOYUS8b2PyUriT1mDlgCEzrVBAd2yEOTxJ0GSXQ+
   jVkspTH8ypn+THAfuo0e4KT9jy6LxCD9JbowK1HtgLPfHTbK2/iDPcxQL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="375099901"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="375099901"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 02:49:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="839820088"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="839820088"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 13 Dec 2023 02:49:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDMnT-000KQZ-08;
        Wed, 13 Dec 2023 10:48:59 +0000
Date:   Wed, 13 Dec 2023 18:48:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/mtd/nand/raw/r852.c:63:16: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202312131846.d1bazU5H-lkp@intel.com>
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

Hi Miquel,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88035e5694a86a7167d490bb95e9df97a9bb162b
commit: 72c5af00272339af6bbed6fe7275cd731f57be2d mtd: rawnand: Clarify Kconfig entry MTD_NAND
date:   4 years, 8 months ago
config: sparc-randconfig-r121-20231119 (https://download.01.org/0day-ci/archive/20231213/202312131846.d1bazU5H-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231213/202312131846.d1bazU5H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312131846.d1bazU5H-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/mtd/nand/raw/r852.c:110:25: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:110:25: sparse:     expected unsigned int [usertype] value
   drivers/mtd/nand/raw/r852.c:110:25: sparse:     got restricted __le32 [usertype]
   drivers/mtd/nand/raw/r852.c:114:25: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:114:25: sparse:     expected unsigned int [usertype] value
   drivers/mtd/nand/raw/r852.c:114:25: sparse:     got restricted __le32 [usertype]
   drivers/mtd/nand/raw/r852.c:147:17: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:147:17: sparse:     expected unsigned int [usertype] value
   drivers/mtd/nand/raw/r852.c:147:17: sparse:     got restricted __le32 [usertype]
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
>> drivers/mtd/nand/raw/r852.c:63:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     expected unsigned int [usertype] l
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     got restricted __le32 [usertype]
>> drivers/mtd/nand/raw/r852.c:63:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     expected unsigned int [usertype] l
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     got restricted __le32 [usertype]
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
>> drivers/mtd/nand/raw/r852.c:63:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     expected unsigned int [usertype] l
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     got restricted __le32 [usertype]
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
>> drivers/mtd/nand/raw/r852.c:63:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     expected unsigned int [usertype] l
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     got restricted __le32 [usertype]
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
>> drivers/mtd/nand/raw/r852.c:63:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     expected unsigned int [usertype] l
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     got restricted __le32 [usertype]
>> drivers/mtd/nand/raw/r852.c:63:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     expected unsigned int [usertype] l
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     got restricted __le32 [usertype]
>> drivers/mtd/nand/raw/r852.c:63:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     expected unsigned int [usertype] l
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     got restricted __le32 [usertype]
>> drivers/mtd/nand/raw/r852.c:63:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     expected unsigned int [usertype] l
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     got restricted __le32 [usertype]
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
>> drivers/mtd/nand/raw/r852.c:63:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     expected unsigned int [usertype] l
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     got restricted __le32 [usertype]
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
>> drivers/mtd/nand/raw/r852.c:63:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     expected unsigned int [usertype] l
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     got restricted __le32 [usertype]
>> drivers/mtd/nand/raw/r852.c:63:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     expected unsigned int [usertype] l
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     got restricted __le32 [usertype]
>> drivers/mtd/nand/raw/r852.c:63:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     expected unsigned int [usertype] l
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     got restricted __le32 [usertype]
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
>> drivers/mtd/nand/raw/r852.c:63:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     expected unsigned int [usertype] l
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     got restricted __le32 [usertype]
>> drivers/mtd/nand/raw/r852.c:63:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     expected unsigned int [usertype] l
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     got restricted __le32 [usertype]
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/r852.c:55:24: sparse: sparse: cast to restricted __le32
>> drivers/mtd/nand/raw/r852.c:63:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     expected unsigned int [usertype] l
   drivers/mtd/nand/raw/r852.c:63:16: sparse:     got restricted __le32 [usertype]

vim +63 drivers/mtd/nand/raw/r852.c

67e054e919248f drivers/mtd/nand/r852.c Maxim Levitsky 2010-02-22  58  
67e054e919248f drivers/mtd/nand/r852.c Maxim Levitsky 2010-02-22  59  /* write dword sized register */
67e054e919248f drivers/mtd/nand/r852.c Maxim Levitsky 2010-02-22  60  static inline void r852_write_reg_dword(struct r852_device *dev,
67e054e919248f drivers/mtd/nand/r852.c Maxim Levitsky 2010-02-22  61  							int address, uint32_t value)
67e054e919248f drivers/mtd/nand/r852.c Maxim Levitsky 2010-02-22  62  {
67e054e919248f drivers/mtd/nand/r852.c Maxim Levitsky 2010-02-22 @63  	writel(cpu_to_le32(value), dev->mmio + address);
67e054e919248f drivers/mtd/nand/r852.c Maxim Levitsky 2010-02-22  64  	mmiowb();
67e054e919248f drivers/mtd/nand/r852.c Maxim Levitsky 2010-02-22  65  }
67e054e919248f drivers/mtd/nand/r852.c Maxim Levitsky 2010-02-22  66  

:::::: The code at line 63 was first introduced by commit
:::::: 67e054e919248fa1db93de727fb9ad49eb700642 mtd: nand: Add driver for Ricoh xD/SmartMedia reader

:::::: TO: Maxim Levitsky <maximlevitsky@gmail.com>
:::::: CC: David Woodhouse <David.Woodhouse@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

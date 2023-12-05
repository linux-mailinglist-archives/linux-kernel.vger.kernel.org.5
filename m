Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D73C8043A1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343727AbjLEA5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLEA5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:57:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218D3FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701737871; x=1733273871;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1NyS742JU7xEN/+M0yGPdldIAwdu5q4u0RdJbUAGUVE=;
  b=AKAFLLka9/p/rS6ph0Xx+1HbNVMK4VDfwzPZRuPDspNC76OJ5duFU1cE
   Cg/4dOearHeGCs5MAZkyhZNcKNrNEGduCWsU+c046tRt7VdTJZkFsEZp0
   mOZywOucuLpdsnRT8++0OaaFxyIkdWYB23W7tEQTza7qpYiAdLJA2plHJ
   sbpXS/vGzIvcesTnoUfYsCLuyasOTe9DNnS4KEpe6ltsRuON9I6coAfAU
   120/p/bbcJdviQDxcb8pMY7bXkrdPvXn+vvy7ybo5wKdwwQRjUbqoEmhQ
   ck8Ms7pWWdmGnMnyMQrBlNfM2kHHscAND/SWGyva0q3OLpZvLpIVKCZRG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="373266637"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="373266637"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:57:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="861570165"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="861570165"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2023 16:57:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAJkw-0008F8-18;
        Tue, 05 Dec 2023 00:57:46 +0000
Date:   Tue, 5 Dec 2023 08:56:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/include/cpu-sh2/cpu/watchdog.h:44:16: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202312050810.GJwZDVwY-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   3 years, 3 months ago
config: sh-randconfig-r111-20231117 (https://download.01.org/0day-ci/archive/20231205/202312050810.GJwZDVwY-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312050810.GJwZDVwY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050810.GJwZDVwY-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/watchdog/shwdt.c: note: in included file:
   arch/sh/include/asm/watchdog.h:144:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:144:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:144:16: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:156:9: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:134:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:134:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:134:9: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:144:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:144:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:144:16: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:156:9: sparse:     got unsigned int
   drivers/watchdog/shwdt.c: note: in included file (through arch/sh/include/asm/watchdog.h):
>> arch/sh/include/cpu-sh2/cpu/watchdog.h:44:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/cpu-sh2/cpu/watchdog.h:44:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/cpu-sh2/cpu/watchdog.h:44:16: sparse:     got unsigned int
   arch/sh/include/cpu-sh2/cpu/watchdog.h:62:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/cpu-sh2/cpu/watchdog.h:62:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/cpu-sh2/cpu/watchdog.h:62:9: sparse:     got unsigned int
   drivers/watchdog/shwdt.c: note: in included file:
   arch/sh/include/asm/watchdog.h:144:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:144:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:144:16: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:156:9: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:144:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:144:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:144:16: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:156:9: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:134:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:134:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:134:9: sparse:     got unsigned int

vim +44 arch/sh/include/cpu-sh2/cpu/watchdog.h

^1da177e4c3f41 include/asm-sh/cpu-sh2/watchdog.h      Linus Torvalds 2005-04-16  33  
^1da177e4c3f41 include/asm-sh/cpu-sh2/watchdog.h      Linus Torvalds 2005-04-16  34  /**
^1da177e4c3f41 include/asm-sh/cpu-sh2/watchdog.h      Linus Torvalds 2005-04-16  35   * 	sh_wdt_read_rstcsr - Read from Reset Control/Status Register
^1da177e4c3f41 include/asm-sh/cpu-sh2/watchdog.h      Linus Torvalds 2005-04-16  36   *
^1da177e4c3f41 include/asm-sh/cpu-sh2/watchdog.h      Linus Torvalds 2005-04-16  37   *	Reads back the RSTCSR value.
^1da177e4c3f41 include/asm-sh/cpu-sh2/watchdog.h      Linus Torvalds 2005-04-16  38   */
^1da177e4c3f41 include/asm-sh/cpu-sh2/watchdog.h      Linus Torvalds 2005-04-16  39  static inline __u8 sh_wdt_read_rstcsr(void)
^1da177e4c3f41 include/asm-sh/cpu-sh2/watchdog.h      Linus Torvalds 2005-04-16  40  {
^1da177e4c3f41 include/asm-sh/cpu-sh2/watchdog.h      Linus Torvalds 2005-04-16  41  	/*
^1da177e4c3f41 include/asm-sh/cpu-sh2/watchdog.h      Linus Torvalds 2005-04-16  42  	 * Same read/write brain-damage as for WTCNT here..
^1da177e4c3f41 include/asm-sh/cpu-sh2/watchdog.h      Linus Torvalds 2005-04-16  43  	 */
9d56dd3b083a3b arch/sh/include/cpu-sh2/cpu/watchdog.h Paul Mundt     2010-01-26 @44  	return __raw_readb(RSTCSR_R);
^1da177e4c3f41 include/asm-sh/cpu-sh2/watchdog.h      Linus Torvalds 2005-04-16  45  }
^1da177e4c3f41 include/asm-sh/cpu-sh2/watchdog.h      Linus Torvalds 2005-04-16  46  

:::::: The code at line 44 was first introduced by commit
:::::: 9d56dd3b083a3bec56e9da35ce07baca81030b03 sh: Mass ctrl_in/outX to __raw_read/writeX conversion.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217C6803622
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbjLDOM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbjLDOMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:12:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED6083
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701699179; x=1733235179;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MXhTUKskcobwCrPLD/euScyvX+4fETPObP25ded9Org=;
  b=P/+uxRI53d7wjSONhnZbBwRzCuG7+qJQZykTRQrHITqXCst1rkkefc2k
   eN6MF7lOvPYYqDRqfMVHMZ+oFFzOjEspn5oN4p0jp/hqQ5fY77w9CN18v
   QNMNnYZ4dh6Z7yqmFKCuczMMHUdWu/DpuQEokojo16UJe0g51ADVJxu6f
   hnTEPsihqf+YDIQheMgyoX8/ns48pwgeNPKjjcYfDHqjFqfIiZigYksX/
   TrlqsC4WE55PdxGqFcHLuWbX21n+QhrcrYz6dvgcMBrivx7V9RgtMz9pc
   MvCJy9H1USMBjaSgqGMD+G1y/EbMC9fwkEi/dQ6sPY9mj8xaX3+IMwyiD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="458059596"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="458059596"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 06:12:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="888540359"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="888540359"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 04 Dec 2023 06:12:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rA9gr-0007ni-29;
        Mon, 04 Dec 2023 14:12:53 +0000
Date:   Mon, 4 Dec 2023 22:12:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/include/cpu-sh2/cpu/watchdog.h:44:16: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202312042150.BH4sJFe4-lkp@intel.com>
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
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   3 years, 3 months ago
config: sh-randconfig-r111-20231117 (https://download.01.org/0day-ci/archive/20231204/202312042150.BH4sJFe4-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231204/202312042150.BH4sJFe4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312042150.BH4sJFe4-lkp@intel.com/

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

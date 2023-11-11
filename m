Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A8E7E8A30
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 11:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjKKKXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 05:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjKKKXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 05:23:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372069F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699698196; x=1731234196;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6dhJDCo2Sx7Nuc9ZuhnfAD+Xq8KlFKrWMzhR+b1b9eQ=;
  b=cNCqh27xNvQ1TDpu+RfxMy00TIkwMFIvTpGNIa1Jhpu7RtiVxzIGGKKs
   LZDtn+5irJpCrAzMiXBofT04BfWlqeylSpY92K+eKxisM0SrEAK5DYogr
   HiZYziO27sItKDj/+B8wVCYPftvxSRAjV6DvPBIDQ8aLkfaRFItG+qzCC
   cBmDzu5Gx3zLcY5ejK0T+QVsB+o5+wnx4EWaPVu46RLrbfrtRh/64MAq6
   aHMYJAVb5DLMrj8o2JNH+LszdbfXK+Yl7oQMSMJrbl1FCZuOQdZV7mvWc
   29SKiB+/QWWSRkrBodyu3/N6zt08NntZxsSaXSlRAqcm7kg4s4ofPdv8Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="390075539"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="390075539"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 02:23:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="793029086"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="793029086"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2023 02:23:12 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1l8v-000AMq-34;
        Sat, 11 Nov 2023 10:23:09 +0000
Date:   Sat, 11 Nov 2023 18:22:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: arch/x86/kernel/cpu/common.c:111:43: sparse: sparse: cast truncates
 bits from constant value (fffff becomes ffff)
Message-ID: <202311111812.GT19bClP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: 38e9e81f4c81c75799b002d5811de7241b307676 x86/gdt: Use bitfields for initialization
date:   6 years ago
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231111/202311111812.GT19bClP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311111812.GT19bClP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311111812.GT19bClP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/x86/kernel/cpu/common.c:446:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got char ( * )[40] @@
   arch/x86/kernel/cpu/common.c:446:44: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   arch/x86/kernel/cpu/common.c:446:44: sparse:     got char ( * )[40]
   arch/x86/kernel/cpu/common.c:1301:1: sparse: sparse: symbol 'irq_stack_union' redeclared with different type (different address spaces):
   arch/x86/kernel/cpu/common.c:1301:1: sparse:    union irq_stack_union [addressable] [noderef] [toplevel] <asn:3> irq_stack_union
   arch/x86/kernel/cpu/common.c: note: in included file (through arch/x86/include/asm/cpufeature.h, arch/x86/include/asm/thread_info.h, include/linux/thread_info.h, ...):
   arch/x86/include/asm/processor.h:385:1: sparse: note: previously declared as:
   arch/x86/include/asm/processor.h:385:1: sparse:    union irq_stack_union extern [addressable] [toplevel] irq_stack_union
   arch/x86/kernel/cpu/common.c:1313:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *[addressable] [noderef] [toplevel] <asn:3> irq_stack_ptr @@     got char [noderef] <asn:3> * @@
   arch/x86/kernel/cpu/common.c:1313:53: sparse:     expected char *[addressable] [noderef] [toplevel] <asn:3> irq_stack_ptr
   arch/x86/kernel/cpu/common.c:1313:53: sparse:     got char [noderef] <asn:3> *
   arch/x86/kernel/cpu/common.c:1532:33: sparse: sparse: incorrect type in initializer (different modifiers) @@     expected char *estacks @@     got char [noderef] * @@
   arch/x86/kernel/cpu/common.c:1532:33: sparse:     expected char *estacks
   arch/x86/kernel/cpu/common.c:1532:33: sparse:     got char [noderef] *
>> arch/x86/kernel/cpu/common.c:111:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)
   arch/x86/kernel/cpu/common.c:112:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)
   arch/x86/kernel/cpu/common.c:113:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)
   arch/x86/kernel/cpu/common.c:114:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)
   arch/x86/kernel/cpu/common.c:115:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)
   arch/x86/kernel/cpu/common.c:116:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)
   arch/x86/kernel/cpu/common.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h, include/linux/list.h, ...):
   arch/x86/include/asm/bitops.h:115:37: sparse: sparse: cast truncates bits from constant value (ffffff7f becomes 7f)
   arch/x86/include/asm/bitops.h:115:37: sparse: sparse: cast truncates bits from constant value (ffffff7f becomes 7f)
   In file included from arch/x86/include/asm/page_types.h:47,
                    from arch/x86/include/asm/page.h:8,
                    from arch/x86/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:37,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:80,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/bootmem.h:7,
                    from arch/x86/kernel/cpu/common.c:1:
   arch/x86/include/asm/page_64_types.h:22:21: warning: initialized field overwritten [-Woverride-init]
      22 | #define DEBUG_STKSZ (PAGE_SIZE << DEBUG_STACK_ORDER)
         |                     ^
   arch/x86/kernel/cpu/common.c:1328:51: note: in expansion of macro 'DEBUG_STKSZ'
    1328 |           [DEBUG_STACK - 1]                     = DEBUG_STKSZ
         |                                                   ^~~~~~~~~~~
   arch/x86/include/asm/page_64_types.h:22:21: note: (near initialization for 'exception_stack_sizes[2]')
      22 | #define DEBUG_STKSZ (PAGE_SIZE << DEBUG_STACK_ORDER)
         |                     ^
   arch/x86/kernel/cpu/common.c:1328:51: note: in expansion of macro 'DEBUG_STKSZ'
    1328 |           [DEBUG_STACK - 1]                     = DEBUG_STKSZ
         |                                                   ^~~~~~~~~~~

vim +111 arch/x86/kernel/cpu/common.c

0a488a53d7ca46 arch/x86/kernel/cpu/common.c  Yinghai Lu                2008-09-04  100  
06deef892c7327 arch/x86/kernel/cpu/common.c  Brian Gerst               2009-01-21  101  DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
950ad7ff6ec17f arch/x86/kernel/cpu/common.c  Yinghai Lu                2008-09-04  102  #ifdef CONFIG_X86_64
06deef892c7327 arch/x86/kernel/cpu/common.c  Brian Gerst               2009-01-21  103  	/*
06deef892c7327 arch/x86/kernel/cpu/common.c  Brian Gerst               2009-01-21  104  	 * We need valid kernel segments for data and code in long mode too
950ad7ff6ec17f arch/x86/kernel/cpu/common.c  Yinghai Lu                2008-09-04  105  	 * IRET will check the segment types  kkeil 2000/10/28
950ad7ff6ec17f arch/x86/kernel/cpu/common.c  Yinghai Lu                2008-09-04  106  	 * Also sysret mandates a special GDT layout
06deef892c7327 arch/x86/kernel/cpu/common.c  Brian Gerst               2009-01-21  107  	 *
9766cdbcb26038 arch/x86/kernel/cpu/common.c  Jaswinder Singh Rajput    2009-03-14  108  	 * TLS descriptors are currently at a different place compared to i386.
06deef892c7327 arch/x86/kernel/cpu/common.c  Brian Gerst               2009-01-21  109  	 * Hopefully nobody expects them at a fixed place (Wine?)
950ad7ff6ec17f arch/x86/kernel/cpu/common.c  Yinghai Lu                2008-09-04  110  	 */
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19 @111  	[GDT_ENTRY_KERNEL32_CS]		= GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  112  	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  113  	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  114  	[GDT_ENTRY_DEFAULT_USER32_CS]	= GDT_ENTRY_INIT(0xc0fb, 0, 0xfffff),
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  115  	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(0xc0f3, 0, 0xfffff),
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  116  	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(0xa0fb, 0, 0xfffff),
950ad7ff6ec17f arch/x86/kernel/cpu/common.c  Yinghai Lu                2008-09-04  117  #else
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  118  	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(0xc09a, 0, 0xfffff),
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  119  	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  120  	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(0xc0fa, 0, 0xfffff),
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  121  	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(0xc0f2, 0, 0xfffff),
bf50467204b435 arch/i386/kernel/cpu/common.c Rusty Russell             2007-05-02  122  	/*
bf50467204b435 arch/i386/kernel/cpu/common.c Rusty Russell             2007-05-02  123  	 * Segments used for calling PnP BIOS have byte granularity.
bf50467204b435 arch/i386/kernel/cpu/common.c Rusty Russell             2007-05-02  124  	 * They code segments and data segments have fixed 64k limits,
bf50467204b435 arch/i386/kernel/cpu/common.c Rusty Russell             2007-05-02  125  	 * the transfer segment sizes are set at run time.
bf50467204b435 arch/i386/kernel/cpu/common.c Rusty Russell             2007-05-02  126  	 */
6842ef0e85a9cc arch/x86/kernel/cpu/common.c  Glauber de Oliveira Costa 2008-01-30  127  	/* 32-bit code */
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  128  	[GDT_ENTRY_PNPBIOS_CS32]	= GDT_ENTRY_INIT(0x409a, 0, 0xffff),
6842ef0e85a9cc arch/x86/kernel/cpu/common.c  Glauber de Oliveira Costa 2008-01-30  129  	/* 16-bit code */
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  130  	[GDT_ENTRY_PNPBIOS_CS16]	= GDT_ENTRY_INIT(0x009a, 0, 0xffff),
6842ef0e85a9cc arch/x86/kernel/cpu/common.c  Glauber de Oliveira Costa 2008-01-30  131  	/* 16-bit data */
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  132  	[GDT_ENTRY_PNPBIOS_DS]		= GDT_ENTRY_INIT(0x0092, 0, 0xffff),
6842ef0e85a9cc arch/x86/kernel/cpu/common.c  Glauber de Oliveira Costa 2008-01-30  133  	/* 16-bit data */
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  134  	[GDT_ENTRY_PNPBIOS_TS1]		= GDT_ENTRY_INIT(0x0092, 0, 0),
6842ef0e85a9cc arch/x86/kernel/cpu/common.c  Glauber de Oliveira Costa 2008-01-30  135  	/* 16-bit data */
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  136  	[GDT_ENTRY_PNPBIOS_TS2]		= GDT_ENTRY_INIT(0x0092, 0, 0),
bf50467204b435 arch/i386/kernel/cpu/common.c Rusty Russell             2007-05-02  137  	/*
bf50467204b435 arch/i386/kernel/cpu/common.c Rusty Russell             2007-05-02  138  	 * The APM segments have byte granularity and their bases
bf50467204b435 arch/i386/kernel/cpu/common.c Rusty Russell             2007-05-02  139  	 * are set at run time.  All have 64k limits.
bf50467204b435 arch/i386/kernel/cpu/common.c Rusty Russell             2007-05-02  140  	 */
6842ef0e85a9cc arch/x86/kernel/cpu/common.c  Glauber de Oliveira Costa 2008-01-30  141  	/* 32-bit code */
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  142  	[GDT_ENTRY_APMBIOS_BASE]	= GDT_ENTRY_INIT(0x409a, 0, 0xffff),
bf50467204b435 arch/i386/kernel/cpu/common.c Rusty Russell             2007-05-02  143  	/* 16-bit code */
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  144  	[GDT_ENTRY_APMBIOS_BASE+1]	= GDT_ENTRY_INIT(0x009a, 0, 0xffff),
6842ef0e85a9cc arch/x86/kernel/cpu/common.c  Glauber de Oliveira Costa 2008-01-30  145  	/* data */
72c4d853024426 arch/x86/kernel/cpu/common.c  Ingo Molnar               2009-08-03  146  	[GDT_ENTRY_APMBIOS_BASE+2]	= GDT_ENTRY_INIT(0x4092, 0, 0xffff),
bf50467204b435 arch/i386/kernel/cpu/common.c Rusty Russell             2007-05-02  147  
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  148  	[GDT_ENTRY_ESPFIX_SS]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
1e5de18278e686 arch/x86/kernel/cpu/common.c  Akinobu Mita              2009-07-19  149  	[GDT_ENTRY_PERCPU]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
60a5317ff0f42d arch/x86/kernel/cpu/common.c  Tejun Heo                 2009-02-09  150  	GDT_STACK_CANARY_INIT
950ad7ff6ec17f arch/x86/kernel/cpu/common.c  Yinghai Lu                2008-09-04  151  #endif
06deef892c7327 arch/x86/kernel/cpu/common.c  Brian Gerst               2009-01-21  152  } };
7a61d35d4b4056 arch/i386/kernel/cpu/common.c Jeremy Fitzhardinge       2007-05-02  153  EXPORT_PER_CPU_SYMBOL_GPL(gdt_page);
ae1ee11be77f51 arch/i386/kernel/cpu/common.c Rusty Russell             2007-05-02  154  

:::::: The code at line 111 was first introduced by commit
:::::: 1e5de18278e6862f4198412b5059a03770fa816a x86: Introduce GDT_ENTRY_INIT()

:::::: TO: Akinobu Mita <akinobu.mita@gmail.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

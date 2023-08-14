Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED6077B0BD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjHNFZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjHNFYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:24:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F1DE71;
        Sun, 13 Aug 2023 22:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691990685; x=1723526685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xqssrgPoW+7qqT3+gcPDxmnVRasonQkWmPp3DntLtjo=;
  b=J38qqW2fzSmUi+MbmozDj/gNRPGnU3ILOS7mNW9pIEU6ux3j4Amcc31F
   v6pgMsF06/UMX2v0lFYRKHEtOwBCGHBzfRN0fiuYoFxZrNQLtmS1NwVjb
   lA1pDvL057icmVqBUPqLYuShjWnMHvg5JzdQXbIVUydxdUzNdnGlceK4N
   u6RXPHtxiKAcQLtGqJRSglb/V34Fwd+H8dJ9fXfIhgTqxPHVLuSf8MPIk
   MWM5hZ/NA4OG9GoaUgMldXFAot+tLOW0oPTo2vQqRPKT6vvidQQwOupJn
   iuMB3ZQMg0me/gVRae2rUyVZzichxQs+b0lJRq+QIFd3ueP8xRS1Gj7q9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="369435843"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="369435843"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 22:24:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="847505701"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="847505701"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2023 22:24:43 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVQ4I-0009NU-1k;
        Mon, 14 Aug 2023 05:24:42 +0000
Date:   Mon, 14 Aug 2023 13:24:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2 1/3] MIPS: Remove noreturn attribute for die()
Message-ID: <202308141322.sZl3fv7u-lkp@intel.com>
References: <1691985181-28363-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1691985181-28363-2-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5-rc6 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tiezhu-Yang/MIPS-Remove-noreturn-attribute-for-die/20230814-115513
base:   linus/master
patch link:    https://lore.kernel.org/r/1691985181-28363-2-git-send-email-yangtiezhu%40loongson.cn
patch subject: [PATCH v2 1/3] MIPS: Remove noreturn attribute for die()
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230814/202308141322.sZl3fv7u-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230814/202308141322.sZl3fv7u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308141322.sZl3fv7u-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/mips/kernel/traps.c:370:6: warning: no previous prototype for 'show_registers' [-Wmissing-prototypes]
     370 | void show_registers(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~
   arch/mips/kernel/traps.c:447:17: warning: no previous prototype for 'do_be' [-Wmissing-prototypes]
     447 | asmlinkage void do_be(struct pt_regs *regs)
         |                 ^~~~~
   arch/mips/kernel/traps.c:752:17: warning: no previous prototype for 'do_ov' [-Wmissing-prototypes]
     752 | asmlinkage void do_ov(struct pt_regs *regs)
         |                 ^~~~~
   arch/mips/kernel/traps.c:874:17: warning: no previous prototype for 'do_fpe' [-Wmissing-prototypes]
     874 | asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
         |                 ^~~~~~
   arch/mips/kernel/traps.c:1027:17: warning: no previous prototype for 'do_bp' [-Wmissing-prototypes]
    1027 | asmlinkage void do_bp(struct pt_regs *regs)
         |                 ^~~~~
   arch/mips/kernel/traps.c:1114:17: warning: no previous prototype for 'do_tr' [-Wmissing-prototypes]
    1114 | asmlinkage void do_tr(struct pt_regs *regs)
         |                 ^~~~~
   arch/mips/kernel/traps.c:1151:17: warning: no previous prototype for 'do_ri' [-Wmissing-prototypes]
    1151 | asmlinkage void do_ri(struct pt_regs *regs)
         |                 ^~~~~
   arch/mips/kernel/traps.c:1402:17: warning: no previous prototype for 'do_cpu' [-Wmissing-prototypes]
    1402 | asmlinkage void do_cpu(struct pt_regs *regs)
         |                 ^~~~~~
   arch/mips/kernel/traps.c:1507:17: warning: no previous prototype for 'do_msa_fpe' [-Wmissing-prototypes]
    1507 | asmlinkage void do_msa_fpe(struct pt_regs *regs, unsigned int msacsr)
         |                 ^~~~~~~~~~
   arch/mips/kernel/traps.c:1527:17: warning: no previous prototype for 'do_msa' [-Wmissing-prototypes]
    1527 | asmlinkage void do_msa(struct pt_regs *regs)
         |                 ^~~~~~
   arch/mips/kernel/traps.c:1548:17: warning: no previous prototype for 'do_mdmx' [-Wmissing-prototypes]
    1548 | asmlinkage void do_mdmx(struct pt_regs *regs)
         |                 ^~~~~~~
   arch/mips/kernel/traps.c:1560:17: warning: no previous prototype for 'do_watch' [-Wmissing-prototypes]
    1560 | asmlinkage void do_watch(struct pt_regs *regs)
         |                 ^~~~~~~~
   arch/mips/kernel/traps.c:1587:17: warning: no previous prototype for 'do_mcheck' [-Wmissing-prototypes]
    1587 | asmlinkage void do_mcheck(struct pt_regs *regs)
         |                 ^~~~~~~~~
   arch/mips/kernel/traps.c: In function 'do_mcheck':
   arch/mips/kernel/traps.c:1590:24: warning: variable 'prev_state' set but not used [-Wunused-but-set-variable]
    1590 |         enum ctx_state prev_state;
         |                        ^~~~~~~~~~
   arch/mips/kernel/traps.c: At top level:
   arch/mips/kernel/traps.c:1612:17: warning: no previous prototype for 'do_mt' [-Wmissing-prototypes]
    1612 | asmlinkage void do_mt(struct pt_regs *regs)
         |                 ^~~~~
   arch/mips/kernel/traps.c:1648:17: warning: no previous prototype for 'do_dsp' [-Wmissing-prototypes]
    1648 | asmlinkage void do_dsp(struct pt_regs *regs)
         |                 ^~~~~~
   arch/mips/kernel/traps.c:1656:17: warning: no previous prototype for 'do_reserved' [-Wmissing-prototypes]
    1656 | asmlinkage void do_reserved(struct pt_regs *regs)
         |                 ^~~~~~~~~~~
   arch/mips/kernel/traps.c:1832:17: warning: no previous prototype for 'cache_parity_error' [-Wmissing-prototypes]
    1832 | asmlinkage void cache_parity_error(void)
         |                 ^~~~~~~~~~~~~~~~~~
   arch/mips/kernel/traps.c:1880:17: warning: no previous prototype for 'do_ftlb' [-Wmissing-prototypes]
    1880 | asmlinkage void do_ftlb(void)
         |                 ^~~~~~~
   arch/mips/kernel/traps.c:1909:17: warning: no previous prototype for 'do_gsexc' [-Wmissing-prototypes]
    1909 | asmlinkage void do_gsexc(struct pt_regs *regs, u32 diag1)
         |                 ^~~~~~~~
   arch/mips/kernel/traps.c:1944:6: warning: no previous prototype for 'ejtag_exception_handler' [-Wmissing-prototypes]
    1944 | void ejtag_exception_handler(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/traps.c:1989:17: warning: no previous prototype for 'nmi_exception_handler' [-Wmissing-prototypes]
    1989 | void __noreturn nmi_exception_handler(struct pt_regs *regs)
         |                 ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/traps.c: In function 'die':
>> arch/mips/kernel/traps.c:426:1: warning: 'noreturn' function does return
     426 | }
         | ^


vim +/noreturn +426 arch/mips/kernel/traps.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  393  
84d992b55d603d Tiezhu Yang     2023-08-14  394  void die(const char *str, struct pt_regs *regs)
^1da177e4c3f41 Linus Torvalds  2005-04-16  395  {
^1da177e4c3f41 Linus Torvalds  2005-04-16  396  	static int die_counter;
84d992b55d603d Tiezhu Yang     2023-08-14  397  	int ret;
^1da177e4c3f41 Linus Torvalds  2005-04-16  398  
8742cd23471635 Nathan Lynch    2011-09-30  399  	oops_enter();
8742cd23471635 Nathan Lynch    2011-09-30  400  
84d992b55d603d Tiezhu Yang     2023-08-14  401  	ret = notify_die(DIE_OOPS, str, regs, 0,
84d992b55d603d Tiezhu Yang     2023-08-14  402  			 current->thread.trap_nr, SIGSEGV);
5dd11d5d47d248 Jason Wessel    2010-05-20  403  
^1da177e4c3f41 Linus Torvalds  2005-04-16  404  	console_verbose();
4d85f6afa43d36 Wu Zhangjin     2011-07-23  405  	raw_spin_lock_irq(&die_lock);
41c594ab65fc89 Ralf Baechle    2006-04-05  406  	bust_spinlocks(1);
ce384d83d00ee4 Yury Polyanskiy 2010-04-26  407  
178086c86ac973 Ralf Baechle    2005-10-13  408  	printk("%s[#%d]:\n", str, ++die_counter);
^1da177e4c3f41 Linus Torvalds  2005-04-16  409  	show_registers(regs);
373d4d099761cb Rusty Russell   2013-01-21  410  	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
4d85f6afa43d36 Wu Zhangjin     2011-07-23  411  	raw_spin_unlock_irq(&die_lock);
d4fd1989ea142b Maxime Bizon    2006-07-20  412  
8742cd23471635 Nathan Lynch    2011-09-30  413  	oops_exit();
8742cd23471635 Nathan Lynch    2011-09-30  414  
d4fd1989ea142b Maxime Bizon    2006-07-20  415  	if (in_interrupt())
d4fd1989ea142b Maxime Bizon    2006-07-20  416  		panic("Fatal exception in interrupt");
d4fd1989ea142b Maxime Bizon    2006-07-20  417  
99a7a234c89017 Aaro Koskinen   2016-03-09  418  	if (panic_on_oops)
d4fd1989ea142b Maxime Bizon    2006-07-20  419  		panic("Fatal exception");
d4fd1989ea142b Maxime Bizon    2006-07-20  420  
7aa1c8f47e7e79 Ralf Baechle    2012-10-11  421  	if (regs && kexec_should_crash(current))
7aa1c8f47e7e79 Ralf Baechle    2012-10-11  422  		crash_kexec(regs);
7aa1c8f47e7e79 Ralf Baechle    2012-10-11  423  
84d992b55d603d Tiezhu Yang     2023-08-14  424  	if (ret != NOTIFY_STOP)
84d992b55d603d Tiezhu Yang     2023-08-14  425  		make_task_dead(SIGSEGV);
^1da177e4c3f41 Linus Torvalds  2005-04-16 @426  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  427  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

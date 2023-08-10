Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2F17775DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbjHJKbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjHJKbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:31:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCFC26B5;
        Thu, 10 Aug 2023 03:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691663473; x=1723199473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PMrRyI3wHHwgDhdj9UI4XGzA7mO9eIIOADBUbe4YCiA=;
  b=OvvaML0AAZ0bwkp9fE9eMgaSigT/261NuR4emaggcRXldiU1NStygEWt
   ulW5J9JV823LEAivsfCcL3T1YEOSdgyI+pxsPJlw4QJVhs8wWFrGHj7tp
   jz22t5cDhGWA+b5qbF5VosX677/mXhct6HOthtlVzX4Z7+0/ppdR1xARF
   Eoyl9TTazUCq+D/NavCKc2G85Mwr4ZMemvDFlY+q/x6ivxa3udWX3XjC5
   alJLO2Kq6SEAJREdCiPrdjhN7X4fIi+cE4Xos+TKAA61+lB9sQ7LXNbyF
   BlnQ5tOOXtE69FE09Vw+eHd23kLtMU8jCn6fHYkxlxXZ05lGhThhi3zOT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="375079307"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="375079307"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 03:31:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="732171552"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="732171552"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Aug 2023 03:31:07 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qU2wd-0006vy-0t;
        Thu, 10 Aug 2023 10:31:07 +0000
Date:   Thu, 10 Aug 2023 18:30:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        chenhuacai@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH V2 1/2] tick: Rename tick_do_update_jiffies64() and allow
 external usage
Message-ID: <202308101853.wOMMd0Tf-lkp@intel.com>
References: <20230810062527.3700080-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810062527.3700080-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huacai,

kernel test robot noticed the following build errors:

[auto build test ERROR on paulmck-rcu/dev]
[also build test ERROR on linus/master]
[cannot apply to tip/timers/nohz]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/rcu-Update-jiffies-in-rcu_cpu_stall_reset/20230810-142629
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
patch link:    https://lore.kernel.org/r/20230810062527.3700080-1-chenhuacai%40loongson.cn
patch subject: [PATCH V2 1/2] tick: Rename tick_do_update_jiffies64() and allow external usage
config: powerpc-randconfig-r013-20230809 (https://download.01.org/0day-ci/archive/20230810/202308101853.wOMMd0Tf-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230810/202308101853.wOMMd0Tf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308101853.wOMMd0Tf-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:677:
   arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      45 | DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      46 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:674:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     674 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:49:1: note: expanded from here
      49 | __do_insw
         | ^
   arch/powerpc/include/asm/io.h:615:56: note: expanded from macro '__do_insw'
     615 | #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
         |                                        ~~~~~~~~~~~~~~~~~~~~~^
   In file included from kernel/time/tick-sched.c:14:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:677:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      47 | DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      48 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:674:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     674 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:51:1: note: expanded from here
      51 | __do_insl
         | ^
   arch/powerpc/include/asm/io.h:616:56: note: expanded from macro '__do_insl'
     616 | #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
         |                                        ~~~~~~~~~~~~~~~~~~~~~^
   In file included from kernel/time/tick-sched.c:14:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:677:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      49 | DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      50 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:674:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     674 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:53:1: note: expanded from here
      53 | __do_outsb
         | ^
   arch/powerpc/include/asm/io.h:617:58: note: expanded from macro '__do_outsb'
     617 | #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
         |                                         ~~~~~~~~~~~~~~~~~~~~~^
   In file included from kernel/time/tick-sched.c:14:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:677:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      51 | DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      52 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:674:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     674 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:55:1: note: expanded from here
      55 | __do_outsw
         | ^
   arch/powerpc/include/asm/io.h:618:58: note: expanded from macro '__do_outsw'
     618 | #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
         |                                         ~~~~~~~~~~~~~~~~~~~~~^
   In file included from kernel/time/tick-sched.c:14:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:677:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      53 | DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      54 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:674:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     674 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:57:1: note: expanded from here
      57 | __do_outsl
         | ^
   arch/powerpc/include/asm/io.h:619:58: note: expanded from macro '__do_outsl'
     619 | #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
         |                                         ~~~~~~~~~~~~~~~~~~~~~^
>> kernel/time/tick-sched.c:114:4: error: call to undeclared function 'tick_do_update_jiffies_64'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     114 |                         tick_do_update_jiffies_64(now);
         |                         ^
   kernel/time/tick-sched.c:114:4: note: did you mean 'do_update_jiffies_64'?
   include/linux/jiffies.h:91:6: note: 'do_update_jiffies_64' declared here
      91 | void do_update_jiffies_64(s64 now); /* typedef s64 ktime_t */
         |      ^
   6 warnings and 1 error generated.


vim +/tick_do_update_jiffies_64 +114 kernel/time/tick-sched.c

   100	
   101		/* Check, if the jiffies need an update */
   102		if (tick_do_timer_cpu == cpu)
   103			do_update_jiffies_64(now);
   104	
   105		/*
   106		 * If jiffies update stalled for too long (timekeeper in stop_machine()
   107		 * or VMEXIT'ed for several msecs), force an update.
   108		 */
   109		if (ts->last_tick_jiffies != jiffies) {
   110			ts->stalled_jiffies = 0;
   111			ts->last_tick_jiffies = READ_ONCE(jiffies);
   112		} else {
   113			if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
 > 114				tick_do_update_jiffies_64(now);
   115				ts->stalled_jiffies = 0;
   116				ts->last_tick_jiffies = READ_ONCE(jiffies);
   117			}
   118		}
   119	
   120		if (ts->inidle)
   121			ts->got_idle_tick = 1;
   122	}
   123	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C2C7CEE09
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjJSCXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjJSCXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:23:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893E7AB;
        Wed, 18 Oct 2023 19:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697682224; x=1729218224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gX5iJ38ZQvf5cWeS4R0xMfAt/hXJIpQcACVP6RF0PXs=;
  b=H1q7vDIAp9FXVpOK1OaXPkI3/1K/0SxvlssrivIMcq8YdISBZQdITanR
   SGJyS/8Qrnj4mM82hA5jZXrSp9CCg5HLpI3iZtNTK3z3pMgQrr6D0xTnS
   hXKrEoqvlex7HcDgdcOWGePcJaFe7+xa/q9wSJBcGxAzEc4mV9MatF5c4
   yy+ScpFpeeb6Z56RBzpk/PPmGfUKTQuqKSOJ0atnbPymrYkx4b425jFEH
   FgkdUchLlhpJHI3VFgYAijKNUwQcLiTYrxKBBsX89sjHdgozJL/MJQf9M
   jELz5KeUEjW6z5nlb1borlce3IxyZhjNUk8hsLPJWD7lff4YQERXdMckO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="417268317"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="417268317"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 19:23:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="4782300"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Oct 2023 19:23:44 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtIhH-0001Ry-0I;
        Thu, 19 Oct 2023 02:23:39 +0000
Date:   Thu, 19 Oct 2023 10:23:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@linux.intel.com, arnd@arndb.de, peterz@infradead.org,
        aleksander.lobakin@intel.com, ilpo.jarvinen@linux.intel.com,
        rajvi.jingar@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V4 10/17] linux/io.h: iounmap/ioport_unmap cleanup.h
 support
Message-ID: <202310191053.t22G0O9p-lkp@intel.com>
References: <20231018231624.1044633-11-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018231624.1044633-11-david.e.box@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3f720b21ec5af466e50e99dc517af267b67d248c]

url:    https://github.com/intel-lab-lkp/linux/commits/David-E-Box/platform-x86-intel-vsec-Move-structures-to-header/20231019-071914
base:   3f720b21ec5af466e50e99dc517af267b67d248c
patch link:    https://lore.kernel.org/r/20231018231624.1044633-11-david.e.box%40linux.intel.com
patch subject: [PATCH V4 10/17] linux/io.h: iounmap/ioport_unmap cleanup.h support
config: um-defconfig (https://download.01.org/0day-ci/archive/20231019/202310191053.t22G0O9p-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310191053.t22G0O9p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191053.t22G0O9p-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/preempt.h:11,
                    from include/linux/spinlock.h:56,
                    from include/linux/kref.h:16,
                    from include/linux/mm_types.h:8,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from init/main.c:17:
   include/linux/io.h: In function '__free_ioport_unmap':
>> include/linux/io.h:25:43: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]
      25 | DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
         |                                           ^~~~~~~~~~~~
   include/linux/cleanup.h:38:78: note: in definition of macro 'DEFINE_FREE'
      38 |         static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
         |                                                                              ^~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/irqflags.h:16,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/x86/um/syscalls_64.c:8:
   include/linux/io.h: In function '__free_ioport_unmap':
>> include/linux/io.h:25:43: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]
      25 | DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
         |                                           ^~~~~~~~~~~~
   include/linux/cleanup.h:38:78: note: in definition of macro 'DEFINE_FREE'
      38 |         static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
         |                                                                              ^~~~~
   arch/x86/um/syscalls_64.c: At top level:
   arch/x86/um/syscalls_64.c:84:6: warning: no previous prototype for 'arch_switch_to' [-Wmissing-prototypes]
      84 | void arch_switch_to(struct task_struct *to)
         |      ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/preempt.h:11,
                    from include/linux/percpu.h:6,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from kernel/panic.c:14:
   include/linux/io.h: In function '__free_ioport_unmap':
>> include/linux/io.h:25:43: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]
      25 | DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
         |                                           ^~~~~~~~~~~~
   include/linux/cleanup.h:38:78: note: in definition of macro 'DEFINE_FREE'
      38 |         static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
         |                                                                              ^~~~~
   kernel/panic.c: In function '__warn':
   kernel/panic.c:666:17: warning: function '__warn' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     666 |                 vprintk(args->fmt, args->args);
         |                 ^~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/irqflags.h:16,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rcuwait.h:5,
                    from include/linux/irq_work.h:6,
                    from kernel/irq_work.c:12:
   include/linux/io.h: In function '__free_ioport_unmap':
>> include/linux/io.h:25:43: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]
      25 | DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
         |                                           ^~~~~~~~~~~~
   include/linux/cleanup.h:38:78: note: in definition of macro 'DEFINE_FREE'
      38 |         static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
         |                                                                              ^~~~~
   kernel/irq_work.c: At top level:
   kernel/irq_work.c:72:13: warning: no previous prototype for 'arch_irq_work_raise' [-Wmissing-prototypes]
      72 | void __weak arch_irq_work_raise(void)
         |             ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/preempt.h:11,
                    from include/linux/spinlock.h:56,
                    from include/linux/kref.h:16,
                    from include/linux/mm_types.h:8,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from arch/um/kernel/mem.c:7:
   include/linux/io.h: In function '__free_ioport_unmap':
>> include/linux/io.h:25:43: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]
      25 | DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
         |                                           ^~~~~~~~~~~~
   include/linux/cleanup.h:38:78: note: in definition of macro 'DEFINE_FREE'
      38 |         static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
         |                                                                              ^~~~~
   arch/um/kernel/mem.c: At top level:
   arch/um/kernel/mem.c:202:8: warning: no previous prototype for 'pgd_alloc' [-Wmissing-prototypes]
     202 | pgd_t *pgd_alloc(struct mm_struct *mm)
         |        ^~~~~~~~~
   arch/um/kernel/mem.c:215:7: warning: no previous prototype for 'uml_kmalloc' [-Wmissing-prototypes]
     215 | void *uml_kmalloc(int size, int flags)
         |       ^~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/preempt.h:11,
                    from include/linux/percpu.h:6,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from arch/um/kernel/process.c:11:
   include/linux/io.h: In function '__free_ioport_unmap':
>> include/linux/io.h:25:43: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]
      25 | DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
         |                                           ^~~~~~~~~~~~
   include/linux/cleanup.h:38:78: note: in definition of macro 'DEFINE_FREE'
      38 |         static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
         |                                                                              ^~~~~
   arch/um/kernel/process.c: At top level:
   arch/um/kernel/process.c:51:5: warning: no previous prototype for 'pid_to_processor_id' [-Wmissing-prototypes]
      51 | int pid_to_processor_id(int pid)
         |     ^~~~~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:87:7: warning: no previous prototype for '__switch_to' [-Wmissing-prototypes]
      87 | void *__switch_to(struct task_struct *from, struct task_struct *to)
         |       ^~~~~~~~~~~
   arch/um/kernel/process.c: In function 'new_thread_handler':
   arch/um/kernel/process.c:122:28: warning: variable 'n' set but not used [-Wunused-but-set-variable]
     122 |         int (*fn)(void *), n;
         |                            ^
   arch/um/kernel/process.c: At top level:
   arch/um/kernel/process.c:140:6: warning: no previous prototype for 'fork_handler' [-Wmissing-prototypes]
     140 | void fork_handler(void)
         |      ^~~~~~~~~~~~
   arch/um/kernel/process.c:217:6: warning: no previous prototype for 'arch_cpu_idle' [-Wmissing-prototypes]
     217 | void arch_cpu_idle(void)
         |      ^~~~~~~~~~~~~
   arch/um/kernel/process.c:253:5: warning: no previous prototype for 'copy_to_user_proc' [-Wmissing-prototypes]
     253 | int copy_to_user_proc(void __user *to, void *from, int size)
         |     ^~~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:263:5: warning: no previous prototype for 'clear_user_proc' [-Wmissing-prototypes]
     263 | int clear_user_proc(void __user *buf, int size)
         |     ^~~~~~~~~~~~~~~
   arch/um/kernel/process.c:271:6: warning: no previous prototype for 'set_using_sysemu' [-Wmissing-prototypes]
     271 | void set_using_sysemu(int value)
         |      ^~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:278:5: warning: no previous prototype for 'get_using_sysemu' [-Wmissing-prototypes]
     278 | int get_using_sysemu(void)
         |     ^~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:316:12: warning: no previous prototype for 'make_proc_sysemu' [-Wmissing-prototypes]
     316 | int __init make_proc_sysemu(void)
         |            ^~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:356:15: warning: no previous prototype for 'arch_align_stack' [-Wmissing-prototypes]
     356 | unsigned long arch_align_stack(unsigned long sp)
         |               ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/irqflags.h:16,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/um/kernel/um_arch.c:6:
   include/linux/io.h: In function '__free_ioport_unmap':
>> include/linux/io.h:25:43: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]
      25 | DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
         |                                           ^~~~~~~~~~~~
   include/linux/cleanup.h:38:78: note: in definition of macro 'DEFINE_FREE'
      38 |         static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
         |                                                                              ^~~~~
   arch/um/kernel/um_arch.c: At top level:
   arch/um/kernel/um_arch.c:408:19: warning: no previous prototype for 'read_initrd' [-Wmissing-prototypes]
     408 | int __init __weak read_initrd(void)
         |                   ^~~~~~~~~~~
   arch/um/kernel/um_arch.c:461:7: warning: no previous prototype for 'text_poke' [-Wmissing-prototypes]
     461 | void *text_poke(void *addr, const void *opcode, size_t len)
         |       ^~~~~~~~~
   arch/um/kernel/um_arch.c:473:6: warning: no previous prototype for 'text_poke_sync' [-Wmissing-prototypes]
     473 | void text_poke_sync(void)
         |      ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/mutex.h:22,
                    from include/linux/notifier.h:14,
                    from include/linux/clk.h:14,
                    from lib/vsprintf.c:22:
   include/linux/io.h: In function '__free_ioport_unmap':
>> include/linux/io.h:25:43: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]
      25 | DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
         |                                           ^~~~~~~~~~~~
   include/linux/cleanup.h:38:78: note: in definition of macro 'DEFINE_FREE'
      38 |         static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
         |                                                                              ^~~~~
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1682:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1682 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/preempt.h:11,
                    from include/linux/spinlock.h:56,
                    from include/linux/debugobjects.h:6,
                    from include/linux/timer.h:8,
                    from include/linux/netdevice.h:24,
                    from arch/um/os-Linux/drivers/ethertap_kern.c:10:
   include/linux/io.h: In function '__free_ioport_unmap':
>> include/linux/io.h:25:43: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]
      25 | DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
         |                                           ^~~~~~~~~~~~
   include/linux/cleanup.h:38:78: note: in definition of macro 'DEFINE_FREE'
      38 |         static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
         |                                                                              ^~~~~
   arch/um/os-Linux/drivers/ethertap_kern.c: At top level:
   arch/um/os-Linux/drivers/ethertap_kern.c:66:5: warning: no previous prototype for 'ethertap_setup' [-Wmissing-prototypes]
      66 | int ethertap_setup(char *str, char **mac_out, void *data)
         |     ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/preempt.h:11,
                    from include/linux/spinlock.h:56,
                    from include/linux/debugobjects.h:6,
                    from include/linux/timer.h:8,
                    from include/linux/netdevice.h:24,
                    from arch/um/os-Linux/drivers/tuntap_kern.c:6:
   include/linux/io.h: In function '__free_ioport_unmap':
>> include/linux/io.h:25:43: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]
      25 | DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
         |                                           ^~~~~~~~~~~~
   include/linux/cleanup.h:38:78: note: in definition of macro 'DEFINE_FREE'
      38 |         static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
         |                                                                              ^~~~~
   arch/um/os-Linux/drivers/tuntap_kern.c: At top level:
   arch/um/os-Linux/drivers/tuntap_kern.c:56:5: warning: no previous prototype for 'tuntap_setup' [-Wmissing-prototypes]
      56 | int tuntap_setup(char *str, char **mac_out, void *data)
         |     ^~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/preempt.h:11,
                    from include/linux/spinlock.h:56,
                    from include/linux/kref.h:16,
                    from include/linux/mm_types.h:8,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from net/ipv4/route.c:63:
   include/linux/io.h: In function '__free_ioport_unmap':
>> include/linux/io.h:25:43: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]
      25 | DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
         |                                           ^~~~~~~~~~~~
   include/linux/cleanup.h:38:78: note: in definition of macro 'DEFINE_FREE'
      38 |         static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
         |                                                                              ^~~~~
   net/ipv4/route.c: In function 'ip_rt_send_redirect':
   net/ipv4/route.c:880:13: warning: variable 'log_martians' set but not used [-Wunused-but-set-variable]
     880 |         int log_martians;
         |             ^~~~~~~~~~~~
   cc1: some warnings being treated as errors
..


vim +/ioport_unmap +25 include/linux/io.h

    23	
    24	DEFINE_FREE(iounmap, void __iomem *, iounmap(_T));
  > 25	DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
    26	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

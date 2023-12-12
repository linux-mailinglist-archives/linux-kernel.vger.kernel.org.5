Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D64980F5D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376720AbjLLSyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376703AbjLLSyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:54:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454AFD0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702407290; x=1733943290;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0hVYkWzitVyH556SnbRUqJ/JGtITbvnw7xXOLEJ/QRs=;
  b=Teuq4hUogtsOE6aIVWhBDI0voTamnc4u3qcHQiWKnZlmeVgY5V62rT3K
   bVG8JAR6HpWMNH42XzcXHPOUiybFdW4dgXJNv6ZcXQvRobgFhBwX9B2ID
   n9HBF196k8YNRxCVbj7UrJhwikoGD0HtqDJdY5vuSruLcvLFCFJbTNVnR
   Vl2kR+AXon433S1+cDpdTBzbGUfkBUEZQPOmm2QmqxwQPf6mfy18jmvbB
   I6v2ApktT3OVmNolZG2Gzstd7fLJX6LkfGVsbsUOstgzV6saA0Oz+ksVv
   N9ewPreS5M2/1tEF92y2v/Kdl6sMwnIOjfHrNI+ifhDCOBrV8KvnXogCe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="385263217"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="385263217"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 10:54:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="749814653"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="749814653"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Dec 2023 10:54:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rD7u1-000Ja3-1P;
        Tue, 12 Dec 2023 18:54:45 +0000
Date:   Wed, 13 Dec 2023 02:53:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: drivers/watchdog/ath79_wdt.c:165:37: sparse: sparse: incorrect type
 in initializer (different address spaces)
Message-ID: <202312130257.RgeLtCBh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26aff849438cebcd05f1a647390c4aa700d5c0f1
commit: d15155824c5014803d91b829736d249c500bdda6 linux/compiler.h: Split into compiler.h and compiler_types.h
date:   6 years ago
config: arm-randconfig-r131-20231117 (https://download.01.org/0day-ci/archive/20231213/202312130257.RgeLtCBh-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231213/202312130257.RgeLtCBh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312130257.RgeLtCBh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/watchdog/ath79_wdt.c:165:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *register __p @@     got char const * @@
   drivers/watchdog/ath79_wdt.c:165:37: sparse:     expected char const [noderef] __user *register __p
   drivers/watchdog/ath79_wdt.c:165:37: sparse:     got char const *
   drivers/watchdog/ath79_wdt.c:239:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( *write )( ... ) @@     got int ( * )( ... ) @@
   drivers/watchdog/ath79_wdt.c:239:27: sparse:     expected int ( *write )( ... )
   drivers/watchdog/ath79_wdt.c:239:27: sparse:     got int ( * )( ... )
   In file included from include/linux/workqueue.h:8,
                    from include/linux/mm_types.h:15,
                    from include/linux/fs.h:21,
                    from drivers/watchdog/ath79_wdt.c:25:
   include/linux/timer.h: In function 'timer_setup':
   include/linux/timer.h:178:30: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
     178 |         __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
         |                              ^
   include/linux/timer.h:143:39: note: in definition of macro '__setup_timer'
     143 |                 (_timer)->function = (_fn);                             17-      |                                       ^~~
--
   kernel/futex.c: note: in included file:
>> arch/arm/include/asm/futex.h:57:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:57:9: sparse:     expected void const *
   arch/arm/include/asm/futex.h:57:9: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   kernel/futex.c:1480:9: sparse: sparse: context imbalance in 'wake_futex_pi' - unexpected unlock
   arch/arm/include/asm/futex.h:142:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:142:17: sparse:     expected void const *
   arch/arm/include/asm/futex.h:142:17: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   arch/arm/include/asm/futex.h:145:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:145:17: sparse:     expected void const *
   arch/arm/include/asm/futex.h:145:17: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   arch/arm/include/asm/futex.h:148:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:148:17: sparse:     expected void const *
   arch/arm/include/asm/futex.h:148:17: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   arch/arm/include/asm/futex.h:151:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:151:17: sparse:     expected void const *
   arch/arm/include/asm/futex.h:151:17: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   arch/arm/include/asm/futex.h:154:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:154:17: sparse:     expected void const *
   arch/arm/include/asm/futex.h:154:17: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   kernel/futex.c:1633:33: sparse: sparse: context imbalance in 'futex_wake_op' - different lock contexts for basic block
   kernel/futex.c:1924:41: sparse: sparse: context imbalance in 'futex_requeue' - different lock contexts for basic block
   kernel/futex.c:2442:13: sparse: sparse: context imbalance in 'futex_wait_queue_me' - unexpected unlock
   kernel/futex.c:2545:9: sparse: sparse: context imbalance in 'futex_wait_setup' - different lock contexts for basic block
   kernel/futex.c:2834:12: sparse: sparse: context imbalance in 'futex_unlock_pi' - different lock contexts for basic block
   kernel/futex.c:3102:29: sparse: sparse: context imbalance in 'futex_wait_requeue_pi' - unexpected unlock
   In file included from include/linux/workqueue.h:8,
                    from include/linux/srcu.h:34,
                    from include/linux/notifier.h:15,
                    from include/linux/memory_hotplug.h:6,
                    from include/linux/mmzone.h:779,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:14,
                    from kernel/futex.c:47:
   include/linux/timer.h: In function 'timer_setup':
   include/linux/timer.h:178:30: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
     178 |         __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
         |                              ^
   include/linux/timer.h:143:39: note: in definition of macro '__setup_timer'
     143 |                 (_timer)->function = (_fn);                             41-      |                                       ^~~
   In file included from kernel/futex.c:56:
   kernel/futex.c: At top level:
   include/linux/syscalls.h:211:25: warning: 'sys_set_robust_list' alias between functions of incompatible types 'long int(struct robust_list_head *, size_t)' {aka 'long int(struct robust_list_head *, unsigned int)'} and 'long int(long int,  long int)' [-Wattribute-alias=]
     211 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       46-      |                         ^~~
   include/linux/syscalls.h:207:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     207 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:197:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     197 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex.c:3237:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    3237 | SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:25: note: aliased declaration here
     215 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       58-      |                         ^~~
   include/linux/syscalls.h:207:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     207 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:197:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     197 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex.c:3237:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    3237 | SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:211:25: warning: 'sys_futex' alias between functions of incompatible types 'long int(u32 *, int,  u32,  struct timespec *, u32 *, u32)' {aka 'long int(unsigned int *, int,  unsigned int,  struct timespec *, unsigned int *, unsigned int)'} and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Wattribute-alias=]
     211 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       70-      |                         ^~~
   include/linux/syscalls.h:207:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     207 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     201 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex.c:3494:1: note: in expansion of macro 'SYSCALL_DEFINE6'
    3494 | SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:25: note: aliased declaration here
     215 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       82-      |                         ^~~
   include/linux/syscalls.h:207:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     207 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     201 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex.c:3494:1: note: in expansion of macro 'SYSCALL_DEFINE6'
    3494 | SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:211:25: warning: 'sys_get_robust_list' alias between functions of incompatible types 'long int(int,  struct robust_list_head **, size_t *)' {aka 'long int(int,  struct robust_list_head **, unsigned int *)'} and 'long int(long int,  long int,  long int)' [-Wattribute-alias=]
     211 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       94-      |                         ^~~
   include/linux/syscalls.h:207:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     207 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:198:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     198 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex.c:3259:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3259 | SYSCALL_DEFINE3(get_robust_list, int, pid,

vim +165 drivers/watchdog/ath79_wdt.c

f8394f61c66f48 Gabor Juhos 2011-01-04  152  
f8394f61c66f48 Gabor Juhos 2011-01-04  153  static ssize_t ath79_wdt_write(struct file *file, const char *data,
f8394f61c66f48 Gabor Juhos 2011-01-04  154  				size_t len, loff_t *ppos)
f8394f61c66f48 Gabor Juhos 2011-01-04  155  {
f8394f61c66f48 Gabor Juhos 2011-01-04  156  	if (len) {
f8394f61c66f48 Gabor Juhos 2011-01-04  157  		if (!nowayout) {
f8394f61c66f48 Gabor Juhos 2011-01-04  158  			size_t i;
f8394f61c66f48 Gabor Juhos 2011-01-04  159  
f8394f61c66f48 Gabor Juhos 2011-01-04  160  			clear_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags);
f8394f61c66f48 Gabor Juhos 2011-01-04  161  
f8394f61c66f48 Gabor Juhos 2011-01-04  162  			for (i = 0; i != len; i++) {
f8394f61c66f48 Gabor Juhos 2011-01-04  163  				char c;
f8394f61c66f48 Gabor Juhos 2011-01-04  164  
f8394f61c66f48 Gabor Juhos 2011-01-04 @165  				if (get_user(c, data + i))
f8394f61c66f48 Gabor Juhos 2011-01-04  166  					return -EFAULT;
f8394f61c66f48 Gabor Juhos 2011-01-04  167  
f8394f61c66f48 Gabor Juhos 2011-01-04  168  				if (c == 'V')
f8394f61c66f48 Gabor Juhos 2011-01-04  169  					set_bit(WDT_FLAGS_EXPECT_CLOSE,
f8394f61c66f48 Gabor Juhos 2011-01-04  170  						&wdt_flags);
f8394f61c66f48 Gabor Juhos 2011-01-04  171  			}
f8394f61c66f48 Gabor Juhos 2011-01-04  172  		}
f8394f61c66f48 Gabor Juhos 2011-01-04  173  
f8394f61c66f48 Gabor Juhos 2011-01-04  174  		ath79_wdt_keepalive();
f8394f61c66f48 Gabor Juhos 2011-01-04  175  	}
f8394f61c66f48 Gabor Juhos 2011-01-04  176  
f8394f61c66f48 Gabor Juhos 2011-01-04  177  	return len;
f8394f61c66f48 Gabor Juhos 2011-01-04  178  }
f8394f61c66f48 Gabor Juhos 2011-01-04  179  

:::::: The code at line 165 was first introduced by commit
:::::: f8394f61c66f48b1fe9d6964ddce492d7f9a4cd9 watchdog: add driver for the Atheros AR71XX/AR724X/AR913X SoCs

:::::: TO: Gabor Juhos <juhosg@openwrt.org>
:::::: CC: Wim Van Sebroeck <wim@iguana.be>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

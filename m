Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB36E80DB40
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344917AbjLKUHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLKUHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:07:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9B5C4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702325242; x=1733861242;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d6H4B40TtYGwFVjYcYQ+RuIi/PlPjI1Vp41HV8BuC54=;
  b=QL05G46HyDR2VbTAoRLtRBcr4XuJgbYtNJzcFUFT+WqxQkknyrnwI60M
   SruQ2Y1fW/2KXAoZL8OWXXM5uFq+8IHSH0ZHpMc6oqv0CIwxxbvE7vcqV
   J46NG4TXZYfqqU5InD9ufF3cR501bMbZ7kmMLkc9h98febLZvuROCAqR3
   MPWshX3ZP7KbIgK+sE+5PKXOjKFDDSGoCsNdJfXZHQDEYaS3Oufcc9ooX
   7FjMHHj4aLHwpnI6V48zGXPGIYpsyPCBIiUBC/vXxd5n15HJ+I6sQlxxx
   V0yxDwi3L5jmICgT+piPlfKRAlkpB7p5LSDUz38QO22M+7wuAssBfBUOk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="13397880"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="13397880"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 12:07:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1104605225"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1104605225"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Dec 2023 12:07:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCmYf-000IRW-0i;
        Mon, 11 Dec 2023 20:07:17 +0000
Date:   Tue, 12 Dec 2023 04:06:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Luca Abeni <luca.abeni@santannapisa.it>
Subject: drivers/watchdog/ath79_wdt.c:165:37: sparse: sparse: incorrect type
 in initializer (different address spaces)
Message-ID: <202312120412.tOagTH3Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
commit: aa5222e92f8000ed3c1c38dddf11c83222aadfb3 sched/deadline: Don't use dubious signed bitfields
date:   6 years ago
config: arm-randconfig-r131-20231117 (https://download.01.org/0day-ci/archive/20231212/202312120412.tOagTH3Q-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231212/202312120412.tOagTH3Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312120412.tOagTH3Q-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/watchdog/ath79_wdt.c:165:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *register __p @@     got char const * @@
   drivers/watchdog/ath79_wdt.c:165:37: sparse:     expected char const [noderef] __user *register __p
   drivers/watchdog/ath79_wdt.c:165:37: sparse:     got char const *
   drivers/watchdog/ath79_wdt.c:239:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( *write )( ... ) @@     got int ( * )( ... ) @@
   drivers/watchdog/ath79_wdt.c:239:27: sparse:     expected int ( *write )( ... )
   drivers/watchdog/ath79_wdt.c:239:27: sparse:     got int ( * )( ... )
--
   kernel/futex.c: note: in included file:
>> arch/arm/include/asm/futex.h:58:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:58:9: sparse:     expected void const *
   arch/arm/include/asm/futex.h:58:9: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   kernel/futex.c:1497:9: sparse: sparse: context imbalance in 'wake_futex_pi' - unexpected unlock
   arch/arm/include/asm/futex.h:143:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:143:17: sparse:     expected void const *
   arch/arm/include/asm/futex.h:143:17: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   arch/arm/include/asm/futex.h:146:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:146:17: sparse:     expected void const *
   arch/arm/include/asm/futex.h:146:17: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   arch/arm/include/asm/futex.h:149:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:149:17: sparse:     expected void const *
   arch/arm/include/asm/futex.h:149:17: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   arch/arm/include/asm/futex.h:152:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:152:17: sparse:     expected void const *
   arch/arm/include/asm/futex.h:152:17: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   arch/arm/include/asm/futex.h:155:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:155:17: sparse:     expected void const *
   arch/arm/include/asm/futex.h:155:17: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   kernel/futex.c:1658:33: sparse: sparse: context imbalance in 'futex_wake_op' - different lock contexts for basic block
   kernel/futex.c:1949:41: sparse: sparse: context imbalance in 'futex_requeue' - different lock contexts for basic block
   kernel/futex.c:2467:13: sparse: sparse: context imbalance in 'futex_wait_queue_me' - unexpected unlock
   kernel/futex.c:2570:9: sparse: sparse: context imbalance in 'futex_wait_setup' - different lock contexts for basic block
   kernel/futex.c:2859:12: sparse: sparse: context imbalance in 'futex_unlock_pi' - different lock contexts for basic block
   kernel/futex.c:3127:29: sparse: sparse: context imbalance in 'futex_wait_requeue_pi' - unexpected unlock
   In file included from kernel/futex.c:56:
   include/linux/syscalls.h:211:25: warning: 'sys_set_robust_list' alias between functions of incompatible types 'long int(struct robust_list_head *, size_t)' {aka 'long int(struct robust_list_head *, unsigned int)'} and 'long int(long int,  long int)' [-Wattribute-alias=]
     211 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       30-      |                         ^~~
   include/linux/syscalls.h:207:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     207 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:197:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     197 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex.c:3262:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    3262 | SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:25: note: aliased declaration here
     215 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       42-      |                         ^~~
   include/linux/syscalls.h:207:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     207 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:197:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     197 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex.c:3262:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    3262 | SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:211:25: warning: 'sys_futex' alias between functions of incompatible types 'long int(u32 *, int,  u32,  struct timespec *, u32 *, u32)' {aka 'long int(unsigned int *, int,  unsigned int,  struct timespec *, unsigned int *, unsigned int)'} and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Wattribute-alias=]
     211 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       54-      |                         ^~~
   include/linux/syscalls.h:207:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     207 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     201 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex.c:3519:1: note: in expansion of macro 'SYSCALL_DEFINE6'
    3519 | SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:25: note: aliased declaration here
     215 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       66-      |                         ^~~
   include/linux/syscalls.h:207:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     207 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     201 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex.c:3519:1: note: in expansion of macro 'SYSCALL_DEFINE6'
    3519 | SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:211:25: warning: 'sys_get_robust_list' alias between functions of incompatible types 'long int(int,  struct robust_list_head **, size_t *)' {aka 'long int(int,  struct robust_list_head **, unsigned int *)'} and 'long int(long int,  long int,  long int)' [-Wattribute-alias=]
     211 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       78-      |                         ^~~
   include/linux/syscalls.h:207:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     207 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:198:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     198 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex.c:3284:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3284 | SYSCALL_DEFINE3(get_robust_list, int, pid,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:25: note: aliased declaration here
     215 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       90-      |                         ^~~
   include/linux/syscalls.h:207:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     207 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:198:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     198 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/futex.c:3284:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    3284 | SYSCALL_DEFINE3(get_robust_list, int, pid,
         | ^~~~~~~~~~~~~~~
   kernel/futex.c: In function 'do_futex':
   kernel/futex.c:3489:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
    3489 |                 val3 = FUTEX_BITSET_MATCH_ANY;

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

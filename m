Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E6A81262B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 04:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjLND4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 22:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjLND4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 22:56:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85EBB7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 19:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702526197; x=1734062197;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tzBlg4vy7z8zm5rJJW6LFmMSRrSHeWPUKe5hc1mkteg=;
  b=WMTku9gIdPWBJhutN+v7M+qzhxt+1RrMZTIJwjpAMQtRs9/hyj7rPOBa
   X1kT3NMZ8/3XTouiEWlxueA1uQsjWiqDzQFPyWuG/HoVQxO6aLoLUh16v
   dfDAvVDjJaPj2xyjzPhFCAvMBA8qwui3u5dC4XczA31F+xH2ZLwS630ca
   2+55osFij04jvxfyhXXwPGpMgtsyHBVumrHz2qFxdOqDWUewzCCoR8e2o
   WtkcJ1PR85pw9RvpV2r7IHbApA0eEam6BdMUU868BG7IngZULFy2Di5QF
   bDRN+YAi+RHjPWEBN00BUQaDBLQC9otQe+RSwuq1YXNnIBBRHQPFSkxtB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="398902634"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="398902634"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 19:56:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="947427164"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="947427164"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Dec 2023 19:56:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDcps-000LVX-2r;
        Thu, 14 Dec 2023 03:56:32 +0000
Date:   Thu, 14 Dec 2023 11:55:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: kernel/fork.c:1610:9: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202312141146.rGQV1JEY-lkp@intel.com>
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
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: 913292c97d750fe4188b4f5aa770e5e0ca1e5a91 sched.h: Annotate sighand_struct with __rcu
date:   3 years, 11 months ago
config: parisc-randconfig-r133-20231118 (https://download.01.org/0day-ci/archive/20231214/202312141146.rGQV1JEY-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231214/202312141146.rGQV1JEY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312141146.rGQV1JEY-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/fork.c: note: in included file (through arch/parisc/include/uapi/asm/unistd.h, arch/parisc/include/asm/unistd.h, include/uapi/linux/unistd.h, ...):
   ./arch/parisc/include/generated/uapi/asm/unistd_32.h:381:41: sparse: sparse: no newline at end of file
   kernel/fork.c:995:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *owner @@     got struct task_struct *p @@
   kernel/fork.c:995:19: sparse:     expected struct task_struct [noderef] __rcu *owner
   kernel/fork.c:995:19: sparse:     got struct task_struct *p
   kernel/fork.c:1507:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:1507:38: sparse:     expected struct refcount_struct [usertype] *r
   kernel/fork.c:1507:38: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1516:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1516:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1516:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1517:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *src @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1517:36: sparse:     expected void const *src
   kernel/fork.c:1517:36: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1518:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1518:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1518:33: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/fork.c:1610:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct arch_spinlock_t [usertype] *x @@     got struct arch_spinlock_t [noderef] __rcu * @@
   kernel/fork.c:1610:9: sparse:     expected struct arch_spinlock_t [usertype] *x
   kernel/fork.c:1610:9: sparse:     got struct arch_spinlock_t [noderef] __rcu *
   kernel/fork.c:1901:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1901:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1901:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1905:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1905:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1905:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2201:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct *task @@
   kernel/fork.c:2201:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2201:32: sparse:     got struct task_struct *task
   kernel/fork.c:2207:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2207:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2207:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2256:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2256:54: sparse:     expected struct list_head *head
   kernel/fork.c:2256:54: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2277:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2277:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2277:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2292:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2292:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2292:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2321:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/fork.c:2321:28: sparse:     expected struct sighand_struct *sighand
   kernel/fork.c:2321:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/fork.c:2349:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2349:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2349:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2351:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2351:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2351:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2747:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/fork.c:2747:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:2747:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2827:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:2827:43: sparse:     expected struct refcount_struct const [usertype] *r
   kernel/fork.c:2827:43: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1936:27: sparse: sparse: dereference of noderef expression
   kernel/fork.c:1936:27: sparse: sparse: dereference of noderef expression
   kernel/fork.c:1938:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/parisc/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:218:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:218:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:218:45: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:218:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   include/linux/ptrace.h:218:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:218:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/fork.c:2254:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2255:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:987:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/fork.c:987:23: sparse:    struct task_struct [noderef] __rcu *
   kernel/fork.c:987:23: sparse:    struct task_struct *
--
   kernel/seccomp.c: note: in included file (through arch/parisc/include/uapi/asm/unistd.h, arch/parisc/include/asm/unistd.h, include/uapi/linux/unistd.h, ...):
   ./arch/parisc/include/generated/uapi/asm/unistd_32.h:381:41: sparse: sparse: no newline at end of file
>> kernel/seccomp.c:517:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct arch_spinlock_t [usertype] *x @@     got struct arch_spinlock_t [noderef] __rcu * @@
   kernel/seccomp.c:517:9: sparse:     expected struct arch_spinlock_t [usertype] *x
   kernel/seccomp.c:517:9: sparse:     got struct arch_spinlock_t [noderef] __rcu *
   kernel/seccomp.c:972:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:972:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:972:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:984:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:984:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:984:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:1325:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:1325:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:1325:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:1338:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:1338:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:1338:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/ptrace.h, ...):
   include/linux/uaccess.h:111:13: sparse: sparse: self-comparison always evaluates to true
   kernel/seccomp.c:343:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct arch_spinlock_t [usertype] *x @@     got struct arch_spinlock_t [noderef] __rcu * @@
   kernel/seccomp.c:343:9: sparse:     expected struct arch_spinlock_t [usertype] *x
   kernel/seccomp.c:343:9: sparse:     got struct arch_spinlock_t [noderef] __rcu *
   kernel/seccomp.c:384:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct arch_spinlock_t [usertype] *x @@     got struct arch_spinlock_t [noderef] __rcu * @@
   kernel/seccomp.c:384:9: sparse:     expected struct arch_spinlock_t [usertype] *x
   kernel/seccomp.c:384:9: sparse:     got struct arch_spinlock_t [noderef] __rcu *
   kernel/seccomp.c:301:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct arch_spinlock_t [usertype] *x @@     got struct arch_spinlock_t [noderef] __rcu * @@
   kernel/seccomp.c:301:9: sparse:     expected struct arch_spinlock_t [usertype] *x
   kernel/seccomp.c:301:9: sparse:     got struct arch_spinlock_t [noderef] __rcu *
   kernel/seccomp.c:287:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct arch_spinlock_t [usertype] *x @@     got struct arch_spinlock_t [noderef] __rcu * @@
   kernel/seccomp.c:287:9: sparse:     expected struct arch_spinlock_t [usertype] *x
   kernel/seccomp.c:287:9: sparse:     got struct arch_spinlock_t [noderef] __rcu *
   kernel/seccomp.c:301:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct arch_spinlock_t [usertype] *x @@     got struct arch_spinlock_t [noderef] __rcu * @@
   kernel/seccomp.c:301:9: sparse:     expected struct arch_spinlock_t [usertype] *x
   kernel/seccomp.c:301:9: sparse:     got struct arch_spinlock_t [noderef] __rcu *
   include/linux/uaccess.h:129:13: sparse: sparse: self-comparison always evaluates to true
   include/linux/uaccess.h:111:13: sparse: sparse: self-comparison always evaluates to true
   include/linux/uaccess.h:111:13: sparse: sparse: self-comparison always evaluates to true
   kernel/seccomp.c:287:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct arch_spinlock_t [usertype] *x @@     got struct arch_spinlock_t [noderef] __rcu * @@
   kernel/seccomp.c:287:9: sparse:     expected struct arch_spinlock_t [usertype] *x
   kernel/seccomp.c:287:9: sparse:     got struct arch_spinlock_t [noderef] __rcu *
   kernel/seccomp.c:301:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct arch_spinlock_t [usertype] *x @@     got struct arch_spinlock_t [noderef] __rcu * @@
   kernel/seccomp.c:301:9: sparse:     expected struct arch_spinlock_t [usertype] *x
   kernel/seccomp.c:301:9: sparse:     got struct arch_spinlock_t [noderef] __rcu *
   include/linux/uaccess.h:111:13: sparse: sparse: self-comparison always evaluates to true
   include/linux/uaccess.h:129:13: sparse: sparse: self-comparison always evaluates to true

vim +1610 kernel/fork.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  1600  
dbd952127d11bb Kees Cook      2014-06-27  1601  static void copy_seccomp(struct task_struct *p)
dbd952127d11bb Kees Cook      2014-06-27  1602  {
dbd952127d11bb Kees Cook      2014-06-27  1603  #ifdef CONFIG_SECCOMP
dbd952127d11bb Kees Cook      2014-06-27  1604  	/*
dbd952127d11bb Kees Cook      2014-06-27  1605  	 * Must be called with sighand->lock held, which is common to
dbd952127d11bb Kees Cook      2014-06-27  1606  	 * all threads in the group. Holding cred_guard_mutex is not
dbd952127d11bb Kees Cook      2014-06-27  1607  	 * needed because this new task is not yet running and cannot
dbd952127d11bb Kees Cook      2014-06-27  1608  	 * be racing exec.
dbd952127d11bb Kees Cook      2014-06-27  1609  	 */
69f6a34bdeea4f Guenter Roeck  2014-08-10 @1610  	assert_spin_locked(&current->sighand->siglock);
dbd952127d11bb Kees Cook      2014-06-27  1611  
dbd952127d11bb Kees Cook      2014-06-27  1612  	/* Ref-count the new filter user, and assign it. */
dbd952127d11bb Kees Cook      2014-06-27  1613  	get_seccomp_filter(current);
dbd952127d11bb Kees Cook      2014-06-27  1614  	p->seccomp = current->seccomp;
dbd952127d11bb Kees Cook      2014-06-27  1615  
dbd952127d11bb Kees Cook      2014-06-27  1616  	/*
dbd952127d11bb Kees Cook      2014-06-27  1617  	 * Explicitly enable no_new_privs here in case it got set
dbd952127d11bb Kees Cook      2014-06-27  1618  	 * between the task_struct being duplicated and holding the
dbd952127d11bb Kees Cook      2014-06-27  1619  	 * sighand lock. The seccomp state and nnp must be in sync.
dbd952127d11bb Kees Cook      2014-06-27  1620  	 */
dbd952127d11bb Kees Cook      2014-06-27  1621  	if (task_no_new_privs(current))
dbd952127d11bb Kees Cook      2014-06-27  1622  		task_set_no_new_privs(p);
dbd952127d11bb Kees Cook      2014-06-27  1623  
dbd952127d11bb Kees Cook      2014-06-27  1624  	/*
dbd952127d11bb Kees Cook      2014-06-27  1625  	 * If the parent gained a seccomp mode after copying thread
dbd952127d11bb Kees Cook      2014-06-27  1626  	 * flags and between before we held the sighand lock, we have
dbd952127d11bb Kees Cook      2014-06-27  1627  	 * to manually enable the seccomp thread flag here.
dbd952127d11bb Kees Cook      2014-06-27  1628  	 */
dbd952127d11bb Kees Cook      2014-06-27  1629  	if (p->seccomp.mode != SECCOMP_MODE_DISABLED)
dbd952127d11bb Kees Cook      2014-06-27  1630  		set_tsk_thread_flag(p, TIF_SECCOMP);
dbd952127d11bb Kees Cook      2014-06-27  1631  #endif
dbd952127d11bb Kees Cook      2014-06-27  1632  }
dbd952127d11bb Kees Cook      2014-06-27  1633  

:::::: The code at line 1610 was first introduced by commit
:::::: 69f6a34bdeea4fec50bb90619bc9602973119572 seccomp: Replace BUG(!spin_is_locked()) with assert_spin_lock

:::::: TO: Guenter Roeck <linux@roeck-us.net>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

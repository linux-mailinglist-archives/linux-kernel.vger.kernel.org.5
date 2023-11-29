Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649597FDBBB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343809AbjK2Pma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343823AbjK2Pm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:42:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E043A10C0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701272553; x=1732808553;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=APaWSwz5I7OxVC+NmWSeIaqYRiFHKuAnOFaJzL8Exw0=;
  b=RQS8UR8lK5by1ppU0MhKAHRv12VpnFHLEFBYTEnjnuM5w9H5zxT3hI9v
   GHA7mGb7tMKec6PQ+eOcKLGsPl9RK1a0kMPI1H+kExc4x2Bt6VxQC31HF
   LBsM8pp7YSl5qtZiS5iGtXB8jL68SOcKby+kFcbKwu6ruwqQiAELVyiGB
   biOzwwCh/dbr9wr6fHn1dUr0AncTzUr10ABhTG55w3Mt1cC+XVfQ8Eovk
   REsy+WJTNC0cjmpmQYiWF+Dwu+i+rWv9ToD5pfYjbYoB3VPJdVK2eVuxL
   FCvQzWquRfk3OqhPmO2A1GRN/hKSx9epPJJp7+KiYbczqpl5fm4bmoeJ9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="424331091"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="424331091"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 07:42:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="718788658"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="718788658"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 29 Nov 2023 07:42:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8Mhk-0000Od-0s;
        Wed, 29 Nov 2023 15:42:26 +0000
Date:   Wed, 29 Nov 2023 23:42:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jun Yi <yijun@loongson.cn>
Subject: kernel/fork.c:1647:36: sparse: sparse: incorrect type in argument 2
 (different address spaces)
Message-ID: <202311292218.LfF2vCN0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   18d46e76d7c2eedd8577fae67e3f1d4db25018b0
commit: a275a82dcd4024c75337db15d59ed039c31e21da LoongArch: Use alternative to optimize libraries
date:   12 months ago
config: loongarch-randconfig-r034-20230511 (https://download.01.org/0day-ci/archive/20231129/202311292218.LfF2vCN0-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231129/202311292218.LfF2vCN0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311292218.LfF2vCN0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/fork.c:1310:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] old_exe_file @@     got struct file [noderef] __rcu *[assigned] __res @@
   kernel/fork.c:1310:22: sparse:     expected struct file *[assigned] old_exe_file
   kernel/fork.c:1310:22: sparse:     got struct file [noderef] __rcu *[assigned] __res
   kernel/fork.c:1637:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:1637:38: sparse:     expected struct refcount_struct [usertype] *r
   kernel/fork.c:1637:38: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1646:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1646:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1646:31: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/fork.c:1647:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *__from @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1647:36: sparse:     expected void const *__from
   kernel/fork.c:1647:36: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1648:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1648:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1648:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2074:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2074:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2074:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2078:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2078:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2078:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2109:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/fork.c:2109:9: sparse:     expected void *ptr
   kernel/fork.c:2109:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/fork.c:2109:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/fork.c:2109:9: sparse:     expected void *ptr
   kernel/fork.c:2109:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/fork.c:2109:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/fork.c:2109:9: sparse:     expected void *ptr
   kernel/fork.c:2109:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/fork.c:2109:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/fork.c:2109:9: sparse:     expected void *ptr
   kernel/fork.c:2109:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/fork.c:2109:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/fork.c:2109:9: sparse:     expected void *ptr
   kernel/fork.c:2109:9: sparse:     got int [noderef] __percpu *
   kernel/fork.c:2109:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/fork.c:2109:9: sparse:     expected void *ptr
   kernel/fork.c:2109:9: sparse:     got int [noderef] __percpu *
   kernel/fork.c:2109:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/fork.c:2109:9: sparse:     expected void *ptr
   kernel/fork.c:2109:9: sparse:     got int [noderef] __percpu *
   kernel/fork.c:2109:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/fork.c:2109:9: sparse:     expected void *ptr
   kernel/fork.c:2109:9: sparse:     got int [noderef] __percpu *
   kernel/fork.c:2398:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct *task @@
   kernel/fork.c:2398:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2398:32: sparse:     got struct task_struct *task
   kernel/fork.c:2407:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2407:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2407:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2454:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2454:54: sparse:     expected struct list_head *head
   kernel/fork.c:2454:54: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2476:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2476:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2476:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2497:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2497:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2497:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2524:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/fork.c:2524:28: sparse:     expected struct sighand_struct *sighand
   kernel/fork.c:2524:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/fork.c:2553:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2553:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2553:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2555:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2555:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2555:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2998:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/fork.c:2998:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:2998:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:3079:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:3079:43: sparse:     expected struct refcount_struct const [usertype] *r
   kernel/fork.c:3079:43: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:2119:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through arch/loongarch/include/uapi/asm/bpf_perf_event.h, include/uapi/linux/bpf_perf_event.h, ...):
   include/linux/ptrace.h:210:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:210:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:210:45: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:210:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   include/linux/ptrace.h:210:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:210:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/fork.c:2452:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2453:59: sparse: sparse: dereference of noderef expression

vim +1647 kernel/fork.c

a016f3389c0660 JANAK DESAI        2006-02-07  1631  
a39bc51691a0c8 Alexey Dobriyan    2007-10-18  1632  static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
^1da177e4c3f41 Linus Torvalds     2005-04-16  1633  {
^1da177e4c3f41 Linus Torvalds     2005-04-16  1634  	struct sighand_struct *sig;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1635  
60348802e9cb13 Zhaolei            2009-01-06  1636  	if (clone_flags & CLONE_SIGHAND) {
d036bda7d0e726 Elena Reshetova    2019-01-18  1637  		refcount_inc(&current->sighand->count);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1638  		return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1639  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  1640  	sig = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
0c282b068eb26d Madhuparna Bhowmik 2020-01-27  1641  	RCU_INIT_POINTER(tsk->sighand, sig);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1642  	if (!sig)
^1da177e4c3f41 Linus Torvalds     2005-04-16  1643  		return -ENOMEM;
9d7fb04276481c Peter Zijlstra     2015-06-30  1644  
d036bda7d0e726 Elena Reshetova    2019-01-18  1645  	refcount_set(&sig->count, 1);
06e62a46bbba20 Jann Horn          2018-08-21  1646  	spin_lock_irq(&current->sighand->siglock);
^1da177e4c3f41 Linus Torvalds     2005-04-16 @1647  	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
06e62a46bbba20 Jann Horn          2018-08-21  1648  	spin_unlock_irq(&current->sighand->siglock);
b612e5df4587c9 Christian Brauner  2019-10-14  1649  
b612e5df4587c9 Christian Brauner  2019-10-14  1650  	/* Reset all signal handler not set to SIG_IGN to SIG_DFL. */
b612e5df4587c9 Christian Brauner  2019-10-14  1651  	if (clone_flags & CLONE_CLEAR_SIGHAND)
b612e5df4587c9 Christian Brauner  2019-10-14  1652  		flush_signal_handlers(tsk, 0);
b612e5df4587c9 Christian Brauner  2019-10-14  1653  
^1da177e4c3f41 Linus Torvalds     2005-04-16  1654  	return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1655  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  1656  

:::::: The code at line 1647 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

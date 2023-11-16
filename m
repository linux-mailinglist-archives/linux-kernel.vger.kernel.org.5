Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DBE7ED923
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344286AbjKPCLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPCLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:11:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757D1187
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700100659; x=1731636659;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CWO4AeBjwZNTRB7MBw429hImhHBEO6jTqwx+UsfJImE=;
  b=UWAwknFGTFRAy2gwvDXZ0yqtbPNrcE/6Keti1WNrTKzWGWpDc3MXjlgi
   NMRzBtn8EVSBEvL2TpomeNqKu0UIF/HC65CAPE74MGCV8tD7d85FgwWMR
   cVQrJSXwLGfx5uSN4/sbVcC9Qr1T9L6Ghvfj4GsLaoxd5iAge5y0INZdf
   H2jybMqSLUjsEzWnGiDx2T5ttrHWmwFQ5c0GSmAY2DDnq7xlgQpSQkQqR
   dmUom36TWPos/+HmZXvT7q8hcYheBD9Rv6slJQR6UiiDrDQXBqqTQnRj3
   8kfZbJDFVcTb7YcDF46xEMJ+JuEgEMAPqVVmekWvgL8gK3e8zPfdATRkN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="390787958"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="390787958"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 18:10:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768776043"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="768776043"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 15 Nov 2023 18:10:57 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3Rq1-00017S-1T;
        Thu, 16 Nov 2023 02:10:43 +0000
Date:   Thu, 16 Nov 2023 10:08:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: kernel/fork.c:1672:9: sparse: sparse: incorrect type in argument 2
 (different address spaces)
Message-ID: <202311161044.YTQKDdiw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: 4ec4190be4cf9cc3e0ccaf5f155a5f9066d18950 kasan, x86: don't rename memintrinsics in uninstrumented files
date:   9 months ago
config: x86_64-randconfig-a012-20230530 (https://download.01.org/0day-ci/archive/20231116/202311161044.YTQKDdiw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311161044.YTQKDdiw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311161044.YTQKDdiw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/fork.c:1110:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *owner @@     got struct task_struct *p @@
   kernel/fork.c:1110:19: sparse:     expected struct task_struct [noderef] __rcu *owner
   kernel/fork.c:1110:19: sparse:     got struct task_struct *p
   kernel/fork.c:1334:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file [noderef] __rcu *__ret @@     got struct file *new_exe_file @@
   kernel/fork.c:1334:24: sparse:     expected struct file [noderef] __rcu *__ret
   kernel/fork.c:1334:24: sparse:     got struct file *new_exe_file
   kernel/fork.c:1334:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] old_exe_file @@     got struct file [noderef] __rcu *[assigned] __ret @@
   kernel/fork.c:1334:22: sparse:     expected struct file *[assigned] old_exe_file
   kernel/fork.c:1334:22: sparse:     got struct file [noderef] __rcu *[assigned] __ret
   kernel/fork.c:1662:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:1662:38: sparse:     expected struct refcount_struct [usertype] *r
   kernel/fork.c:1662:38: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1671:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1671:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1671:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1672:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1672:9: sparse:     expected void const *
   kernel/fork.c:1672:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1672:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1672:9: sparse:     expected void const *
   kernel/fork.c:1672:9: sparse:     got struct k_sigaction [noderef] __rcu *
>> kernel/fork.c:1672:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *q @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1672:9: sparse:     expected void const *q
   kernel/fork.c:1672:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1673:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1673:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1673:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2090:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2090:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2090:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2094:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2094:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2094:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2414:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct * @@
   kernel/fork.c:2414:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2414:32: sparse:     got struct task_struct *
   kernel/fork.c:2423:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2423:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2423:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2472:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2472:54: sparse:     expected struct list_head *head
   kernel/fork.c:2472:54: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2494:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2494:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2494:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2515:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2515:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2515:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2542:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/fork.c:2542:28: sparse:     expected struct sighand_struct *sighand
   kernel/fork.c:2542:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/fork.c:2571:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2571:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2571:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2573:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2573:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2573:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:3011:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/fork.c:3011:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:3011:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:3096:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:3096:43: sparse:     expected struct refcount_struct const [usertype] *r
   kernel/fork.c:3096:43: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1767:9: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2135:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/x86/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:210:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:210:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:210:45: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:210:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   include/linux/ptrace.h:210:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:210:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/fork.c:2470:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2471:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:1102:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/fork.c:1102:23: sparse:    struct task_struct [noderef] __rcu *
   kernel/fork.c:1102:23: sparse:    struct task_struct *

vim +1672 kernel/fork.c

a016f3389c0660 JANAK DESAI        2006-02-07  1656  
a39bc51691a0c8 Alexey Dobriyan    2007-10-18  1657  static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
^1da177e4c3f41 Linus Torvalds     2005-04-16  1658  {
^1da177e4c3f41 Linus Torvalds     2005-04-16  1659  	struct sighand_struct *sig;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1660  
60348802e9cb13 Zhaolei            2009-01-06  1661  	if (clone_flags & CLONE_SIGHAND) {
d036bda7d0e726 Elena Reshetova    2019-01-18  1662  		refcount_inc(&current->sighand->count);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1663  		return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1664  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  1665  	sig = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
0c282b068eb26d Madhuparna Bhowmik 2020-01-27  1666  	RCU_INIT_POINTER(tsk->sighand, sig);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1667  	if (!sig)
^1da177e4c3f41 Linus Torvalds     2005-04-16  1668  		return -ENOMEM;
9d7fb04276481c Peter Zijlstra     2015-06-30  1669  
d036bda7d0e726 Elena Reshetova    2019-01-18  1670  	refcount_set(&sig->count, 1);
06e62a46bbba20 Jann Horn          2018-08-21 @1671  	spin_lock_irq(&current->sighand->siglock);
^1da177e4c3f41 Linus Torvalds     2005-04-16 @1672  	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
06e62a46bbba20 Jann Horn          2018-08-21  1673  	spin_unlock_irq(&current->sighand->siglock);
b612e5df4587c9 Christian Brauner  2019-10-14  1674  
b612e5df4587c9 Christian Brauner  2019-10-14  1675  	/* Reset all signal handler not set to SIG_IGN to SIG_DFL. */
b612e5df4587c9 Christian Brauner  2019-10-14  1676  	if (clone_flags & CLONE_CLEAR_SIGHAND)
b612e5df4587c9 Christian Brauner  2019-10-14  1677  		flush_signal_handlers(tsk, 0);
b612e5df4587c9 Christian Brauner  2019-10-14  1678  
^1da177e4c3f41 Linus Torvalds     2005-04-16  1679  	return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1680  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  1681  

:::::: The code at line 1672 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

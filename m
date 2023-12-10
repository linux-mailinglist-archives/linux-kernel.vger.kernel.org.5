Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45F280BA6C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 12:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjLJLiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 06:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjLJLiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 06:38:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB21114
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 03:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702208285; x=1733744285;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=amKsmiOudTx7fviB5WFl8m5teG+gXO3MPl7JvOJeoRA=;
  b=Wsr4zZPcWPqj62syYzRziahPlwU7SvKO6cJsjgfow+1s2+5C5CTlxnIW
   S0eq859wSIJ46mp1WK1OxITF0P4OpOcwYY85JfoLm9OiN1u4WvLKPwgtX
   zNYpsPxX3tlTu5LXjefqayTEcw8MRn4Rdd9mj67P1xaskydER8QsoAQsT
   TsZz5qi0EZAEKsjj+DlYS5L0gScbPaC/lI8D+0XR4QaeaFPaR6jBR2bi1
   plH6D/yUQMQMhi968crYO1Z0GePfP2QN5BOdN3SON4i5ekxOvXqzQoU8N
   HAWYT9nU1Zg/zj6xR6uMQQ3kQQr8+y2Eotr8sge+jcvyV2Iz8TF8gOWzU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="374709070"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="374709070"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 03:38:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="722406422"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="722406422"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Dec 2023 03:38:04 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCI8H-000Gmu-2v;
        Sun, 10 Dec 2023 11:38:01 +0000
Date:   Sun, 10 Dec 2023 19:37:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/exit.c:738:45: sparse: sparse: incorrect type in initializer
 (different address spaces)
Message-ID: <202312101924.ApMqg932-lkp@intel.com>
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
head:   c527f5606aa545233a4d2c6d5c636ed82b8633ef
commit: d80f7d7b2c75c5954d335dffbccca62a5002c3e0 signal: Guarantee that SIGNAL_GROUP_EXIT is set on process exit
date:   1 year, 5 months ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231210/202312101924.ApMqg932-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312101924.ApMqg932-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312101924.ApMqg932-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/exit.c:281:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:281:37: sparse:     expected struct task_struct *tsk
   kernel/exit.c:281:37: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:284:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:284:32: sparse:     expected struct task_struct *task
   kernel/exit.c:284:32: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:285:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:285:35: sparse:     expected struct task_struct *task
   kernel/exit.c:285:35: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:330:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:330:24: sparse:     expected struct task_struct *parent
   kernel/exit.c:330:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:357:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:357:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:357:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:360:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:360:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:360:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:583:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *reaper @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:583:29: sparse:     expected struct task_struct *reaper
   kernel/exit.c:583:29: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:585:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *reaper @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:585:29: sparse:     expected struct task_struct *reaper
   kernel/exit.c:585:29: sparse:     got struct task_struct [noderef] __rcu *real_parent
>> kernel/exit.c:738:45: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/exit.c:738:45: sparse:     expected struct sighand_struct *sighand
   kernel/exit.c:738:45: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/exit.c:927:63: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *const sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/exit.c:927:63: sparse:     expected struct sighand_struct *const sighand
   kernel/exit.c:927:63: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/exit.c:1082:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1082:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1082:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1107:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1107:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1107:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1196:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1196:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1196:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1211:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1211:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1211:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1262:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1262:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1262:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1265:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1265:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1265:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1271:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1271:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1271:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1452:59: sparse: sparse: incompatible types in comparison expression (different base types):
   kernel/exit.c:1452:59: sparse:    void *
   kernel/exit.c:1452:59: sparse:    struct task_struct [noderef] __rcu *
   kernel/exit.c:1468:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu * @@
   kernel/exit.c:1468:25: sparse:     expected struct task_struct *parent
   kernel/exit.c:1468:25: sparse:     got struct task_struct [noderef] __rcu *
   kernel/exit.c: note: in included file:
   include/linux/ptrace.h:92:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:92:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:92:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:92:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:92:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:92:60: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:92:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:92:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:92:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:92:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:92:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:92:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/exit.c: note: in included file (through include/linux/sched/signal.h, include/linux/rcuwait.h, include/linux/percpu-rwsem.h, ...):
   include/linux/sched/task.h:110:21: sparse: sparse: context imbalance in 'wait_task_zombie' - unexpected unlock
   include/linux/sched/task.h:110:21: sparse: sparse: context imbalance in 'wait_task_stopped' - unexpected unlock
   include/linux/sched/task.h:110:21: sparse: sparse: context imbalance in 'wait_task_continued' - unexpected unlock
   kernel/exit.c: note: in included file:
   include/linux/ptrace.h:92:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:92:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:92:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:92:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:92:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:92:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/exit.c: note: in included file (through include/linux/thread_info.h, arch/x86/include/asm/preempt.h, include/linux/preempt.h, ...):
   arch/x86/include/asm/current.h:15:16: sparse: sparse: context imbalance in 'do_wait' - wrong count at exit

vim +738 kernel/exit.c

   735	
   736	static void synchronize_group_exit(struct task_struct *tsk, long code)
   737	{
 > 738		struct sighand_struct *sighand = tsk->sighand;
   739		struct signal_struct *signal = tsk->signal;
   740	
   741		spin_lock_irq(&sighand->siglock);
   742		signal->quick_threads--;
   743		if ((signal->quick_threads == 0) &&
   744		    !(signal->flags & SIGNAL_GROUP_EXIT)) {
   745			signal->flags = SIGNAL_GROUP_EXIT;
   746			signal->group_exit_code = code;
   747			signal->group_stop_count = 0;
   748		}
   749		spin_unlock_irq(&sighand->siglock);
   750	}
   751	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

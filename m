Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CE47CB553
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjJPVci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjJPVcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:32:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0DFAB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697491953; x=1729027953;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q51HNleOSwFMWwVp99DwyEX8L5IvhxPcZ4tUzT7QosU=;
  b=B8X6h+A3ETEt6JpH5z67FS995iiTHDIhFMxEJ9XOSWeQ63KsEJZezWTS
   HJPfzki/NnYM68S2aEC4f3+Pyc/clf9VRYKUFLySEMyKx6/epTIYQ7MSP
   Gi3Jef1KTUOAvkI6UzOxfYKXglXRXNO7B+VOGsQfcwtqPoUfQJQ3H0THj
   p4MDbFczCS7s2omFIL15WOUcUNE4bxhlmWwL60ZcAh7H5bzkL6QopS0Qg
   uNWbu8iHnfotEb55ZtRO68TdXllksby8q3A5AhVVMm2fqSiA5Kvur4muH
   1cUbgbWPpjuVgJPkgF2s8PQQ3P4cRv9MtNSANjCe7T7ZrcLs2IA/JnLTw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="449866131"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="449866131"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 14:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="929505690"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="929505690"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Oct 2023 14:32:31 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsVCP-0008gx-29;
        Mon, 16 Oct 2023 21:32:29 +0000
Date:   Tue, 17 Oct 2023 05:32:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: kernel/sched/fair.c:939:34: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202310170509.6oaAGzjD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   58720809f52779dc0f08e53e54b014209d13eebb
commit: 904cbab71dda1689d41a240541179f21ff433c40 sched: Make const-safe
date:   10 months ago
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231017/202310170509.6oaAGzjD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310170509.6oaAGzjD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310170509.6oaAGzjD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/sched/fair.c:939:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_entity const *se @@     got struct sched_entity [noderef] __rcu * @@
   kernel/sched/fair.c:939:34: sparse:     expected struct sched_entity const *se
   kernel/sched/fair.c:939:34: sparse:     got struct sched_entity [noderef] __rcu *
   kernel/sched/fair.c:7698:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7698:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7698:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:7996:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7996:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7996:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:6039:35: sparse: sparse: marked inline, but without a definition
   kernel/sched/fair.c: note: in included file:
   kernel/sched/sched.h:2232:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2232:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2232:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2074:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2074:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct *
--
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/rt.c:961:70: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:961:70: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:961:70: sparse:    struct task_struct *
   kernel/sched/rt.c:1047:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1047:38: sparse:     expected struct task_struct *curr
   kernel/sched/rt.c:1047:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:1592:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1592:31: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:1592:31: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/build_policy.c: note: in included file:
>> kernel/sched/deadline.c:1954:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:1954:42: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:1954:42: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:1182:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1182:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1182:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1309:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1309:38: sparse:     expected struct task_struct *curr
   kernel/sched/deadline.c:1309:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2645:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2645:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2645:22: sparse:    struct task_struct *
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/sched.h:2074:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2074:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2074:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2074:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2074:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct *

vim +939 kernel/sched/fair.c

bf0f6f24a1ece8 kernel/sched_fair.c Ingo Molnar       2007-07-09  936  
6e998916dfe327 kernel/sched/fair.c Stanislaw Gruszka 2014-11-12  937  static void update_curr_fair(struct rq *rq)
6e998916dfe327 kernel/sched/fair.c Stanislaw Gruszka 2014-11-12  938  {
6e998916dfe327 kernel/sched/fair.c Stanislaw Gruszka 2014-11-12 @939  	update_curr(cfs_rq_of(&rq->curr->se));
6e998916dfe327 kernel/sched/fair.c Stanislaw Gruszka 2014-11-12  940  }
6e998916dfe327 kernel/sched/fair.c Stanislaw Gruszka 2014-11-12  941  

:::::: The code at line 939 was first introduced by commit
:::::: 6e998916dfe327e785e7c2447959b2c1a3ea4930 sched/cputime: Fix clock_nanosleep()/clock_gettime() inconsistency

:::::: TO: Stanislaw Gruszka <sgruszka@redhat.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

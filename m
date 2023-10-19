Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1461E7D03DB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346682AbjJSVXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbjJSVWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:22:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FB6171A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697750525; x=1729286525;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Mga0hzehnFDhfflJAOvOwX5ea7rI+hOcN+1KatIr3pY=;
  b=e8rS0EfvNBoJNw7q6DMquZZANvrziZXiM7TL1KuVJrD/tudpI0h0zlDc
   u3juyULI6I6zei5FAxrytYyq5J2uAEmnfk8b0mT0R13+klgom3hUdWewi
   fDb3q88ol5gB1Vz8q78549J/n1hDLXGC/lv3yyfX9dg4nZ6SqfYdCSyZP
   pYwucKVlQFWF6S3iPbIYRYJQF++LU3mnVjF0iwZADNqbhMhrkJNHYH7kn
   67ZlNl7RM5Xj5zpWRC5iszuOYYk0SfTzejXB83BDT4uZqq/BWc7HK0e+X
   SY7GDaqm9ZzO3cvle5/S8ZzlsaU+5iUQyq4UEVpSja0WVWapn+VAX3Xij
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389233977"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="389233977"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 14:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="880847200"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="880847200"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Oct 2023 14:16:30 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtaNY-0002be-2D;
        Thu, 19 Oct 2023 21:16:28 +0000
Date:   Fri, 20 Oct 2023 05:16:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: kernel/sched/fair.c:939:34: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202310200515.2Iu6YmEe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   74e9347ebc5be452935fe4f3eddb150aa5a6f4fe
commit: 904cbab71dda1689d41a240541179f21ff433c40 sched: Make const-safe
date:   10 months ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231020/202310200515.2Iu6YmEe-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310200515.2Iu6YmEe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310200515.2Iu6YmEe-lkp@intel.com/

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

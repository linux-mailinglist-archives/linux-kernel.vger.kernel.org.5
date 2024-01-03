Return-Path: <linux-kernel+bounces-15862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D2282346B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D17B20E14
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E339D1CA94;
	Wed,  3 Jan 2024 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhqPw1Jh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C9A1C692
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704306350; x=1735842350;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0FmM6REjcPMlVapg/3xigqZW0gnXHP2PRQf4biW9CUk=;
  b=jhqPw1JhPWqsq02DO3azoeWV+I9g55IDGyAhxn9vm8de3gArIOshNhgh
   J8PSOQHle/X0En5NOdwG6JdAFSOXmMsOLxirYnqOOXI2E/LV/VORH7Kfy
   ZHyFsz2z+yN2T5PyPfgqyL2KFfRrQJofQkzSzG9+Ec2X7p9tRpr8Ov5WW
   5heaYTCoknHV+ALegMEGPfiufCcg2SZhmwwSK0KF7IjGpGTGkBUWwHz1k
   34dDrH/btF7xt4sQeFt+OTu6CyGDS3PXGK8sfczJH4OklY/9X9kThu+Ss
   DIgmQQai9CTk5plymD+kpiYwT70R6tfjkncyLSIj0jHXlaPz0ck+UQRGT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="10641287"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="10641287"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 10:25:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="773208656"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="773208656"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Jan 2024 10:25:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rL5w0-000MR5-0U;
	Wed, 03 Jan 2024 18:25:44 +0000
Date: Thu, 4 Jan 2024 02:25:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: kernel/sched/fair.c:939:34: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202401040045.9KKYlmkt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   610a9b8f49fbcf1100716370d3b5f6f884a2835a
commit: 904cbab71dda1689d41a240541179f21ff433c40 sched: Make const-safe
date:   1 year ago
config: arm64-buildonly-randconfig-r004-20230608 (https://download.01.org/0day-ci/archive/20240104/202401040045.9KKYlmkt-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240104/202401040045.9KKYlmkt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401040045.9KKYlmkt-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/sched/fair.c:939:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_entity const *se @@     got struct sched_entity [noderef] __rcu * @@
   kernel/sched/fair.c:939:34: sparse:     expected struct sched_entity const *se
   kernel/sched/fair.c:939:34: sparse:     got struct sched_entity [noderef] __rcu *
   kernel/sched/fair.c:11691:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:11691:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:11691:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:6110:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:6110:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:6110:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:7343:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:7343:20: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:7343:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:7518:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:7518:9: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/fair.c:7518:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:7698:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7698:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7698:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:7996:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7996:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7996:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:9043:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/fair.c:9043:40: sparse:     expected struct sched_domain *child
   kernel/sched/fair.c:9043:40: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/fair.c:9608:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:9608:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:9608:22: sparse:    struct task_struct *
   kernel/sched/fair.c:10967:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:10967:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:10967:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:10626:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *sd_parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:10626:44: sparse:     expected struct sched_domain *sd_parent
   kernel/sched/fair.c:10626:44: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:11063:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:11063:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:11063:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:6039:35: sparse: sparse: marked inline, but without a definition
   kernel/sched/fair.c: note: in included file:
   kernel/sched/sched.h:2074:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct *
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
   kernel/sched/rt.c:2411:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2411:25: sparse:    struct task_struct *
   kernel/sched/rt.c:2411:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:577:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:577:54: sparse:     expected struct task_struct *curr
   kernel/sched/rt.c:577:54: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:1047:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1047:38: sparse:     expected struct task_struct *curr
   kernel/sched/rt.c:1047:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:1592:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1592:31: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:1592:31: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:1929:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/rt.c:1929:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/rt.c:1929:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/rt.c:1612:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu * @@
   kernel/sched/rt.c:1612:14: sparse:     expected struct task_struct *curr
   kernel/sched/rt.c:1612:14: sparse:     got struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:1677:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1677:45: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:1677:45: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:1738:67: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1738:67: sparse:     expected struct task_struct *tsk
   kernel/sched/rt.c:1738:67: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2093:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2093:40: sparse:     expected struct task_struct *task
   kernel/sched/rt.c:2093:40: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2114:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2114:13: sparse:    struct task_struct *
   kernel/sched/rt.c:2114:13: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:2462:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2462:54: sparse:     expected struct task_struct *tsk
   kernel/sched/rt.c:2462:54: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2464:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2464:40: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:2464:40: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2464:61: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2464:61: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:2464:61: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/deadline.c:2315:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2315:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:2315:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2325:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2325:13: sparse:    struct task_struct *
   kernel/sched/deadline.c:2325:13: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2433:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2433:25: sparse:    struct task_struct *
   kernel/sched/deadline.c:2433:25: sparse:    struct task_struct [noderef] __rcu *
>> kernel/sched/deadline.c:1954:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:1954:42: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:1954:42: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:1965:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1965:38: sparse:     expected struct task_struct *tsk
   kernel/sched/deadline.c:1965:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1182:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1182:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1182:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1309:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1309:38: sparse:     expected struct task_struct *curr
   kernel/sched/deadline.c:1309:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2174:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/deadline.c:2174:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/deadline.c:2174:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/deadline.c:1839:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu * @@
   kernel/sched/deadline.c:1839:14: sparse:     expected struct task_struct *curr
   kernel/sched/deadline.c:1839:14: sparse:     got struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:1915:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1915:43: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1915:43: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2478:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2478:38: sparse:     expected struct task_struct *tsk
   kernel/sched/deadline.c:2478:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2480:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2480:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:2480:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2482:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:2482:44: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:2482:44: sparse:     got struct sched_dl_entity [noderef] __rcu *
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


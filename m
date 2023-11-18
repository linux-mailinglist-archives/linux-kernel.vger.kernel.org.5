Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACCB7EFF20
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjKRKtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKRKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:49:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36B6D6C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 02:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700304538; x=1731840538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wVVfhPDwl/dqtOvp2c5T3cYoSRLUsQlhAimKcz+kBlE=;
  b=RMNx/d5ftWhwa1hW94i1dpx+11TGe4jVRGJghMx4ctx0dKJy6h4iCL78
   8voAUHr7yfjX/g7KAiSqG+eb6qqXaMW3rc3qmm1gOoqrh9b1srKVtRLSo
   dGwVwtG90+U7isjO33p5doxnkkMhbLybQ6Pps/X7GzWdPtjbKg1XlHOtl
   7H8APe1AeET42x0A4wpRYRUzo46ah8wL0GAUT0ZVhEvpvRTngNqM5iWUi
   1QuxXAzisIFGlWVPcoEsdoaYBHXbPSVDTiNsT59r5ZS+7X4yyudY+7C1m
   gmNjcd6QdhGxuADSb0VqXz9WFl6YXbv3pqpjpCXCuorVEzkfeHqo22jEK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="388572655"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="388572655"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 02:48:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="939382115"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="939382115"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Nov 2023 02:48:54 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Isd-0003pF-39;
        Sat, 18 Nov 2023 10:48:51 +0000
Date:   Sat, 18 Nov 2023 18:48:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joel@joelfernandes.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched/core: introduce core to struct cfs_rq
Message-ID: <202311181807.OhNGAYXK-lkp@intel.com>
References: <20231115113341.13261-3-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115113341.13261-3-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cruz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc1 next-20231117]
[cannot apply to tip/sched/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cruz-Zhao/sched-core-introduce-core_id-to-struct-rq/20231115-193559
base:   linus/master
patch link:    https://lore.kernel.org/r/20231115113341.13261-3-CruzZhao%40linux.alibaba.com
patch subject: [PATCH 2/4] sched/core: introduce core to struct cfs_rq
config: x86_64-randconfig-123-20231118 (https://download.01.org/0day-ci/archive/20231118/202311181807.OhNGAYXK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231118/202311181807.OhNGAYXK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311181807.OhNGAYXK-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/fair.c:1178:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_entity const *se @@     got struct sched_entity [noderef] __rcu * @@
   kernel/sched/fair.c:1178:34: sparse:     expected struct sched_entity const *se
   kernel/sched/fair.c:1178:34: sparse:     got struct sched_entity [noderef] __rcu *
   kernel/sched/fair.c:2949:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu * @@
   kernel/sched/fair.c:2949:13: sparse:     expected struct task_struct *tsk
   kernel/sched/fair.c:2949:13: sparse:     got struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:12185:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:12185:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:12185:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:7801:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:7801:20: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:7801:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:8006:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:8006:9: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/fair.c:8006:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:8105:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:8105:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:8105:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:8385:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:8385:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:8385:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:9376:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/fair.c:9376:40: sparse:     expected struct sched_domain *child
   kernel/sched/fair.c:9376:40: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/fair.c:10013:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:10013:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:10013:22: sparse:    struct task_struct *
   kernel/sched/fair.c:11445:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:11445:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:11445:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:11102:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *sd_parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:11102:44: sparse:     expected struct sched_domain *sd_parent
   kernel/sched/fair.c:11102:44: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:11541:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:11541:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:11541:9: sparse:     got struct sched_domain [noderef] __rcu *parent
>> kernel/sched/fair.c:12423:6: sparse: sparse: symbol 'sched_core_init_cfs_rq' was not declared. Should it be static?
   kernel/sched/fair.c:6418:35: sparse: sparse: marked inline, but without a definition
   kernel/sched/fair.c: note: in included file:
   kernel/sched/sched.h:2283:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2283:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2283:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2119:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2119:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2119:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2119:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2119:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2119:25: sparse:    struct task_struct *

vim +/sched_core_init_cfs_rq +12423 kernel/sched/fair.c

 12422	
 12423	void sched_core_init_cfs_rq(struct task_group *tg, struct cfs_rq *cfs_rq)
 12424	{
 12425	#ifdef CONFIG_FAIR_GROUP_SCHED
 12426		struct rq *rq = rq_of(cfs_rq);
 12427		int core_id = rq->core_id;
 12428	
 12429		cfs_rq->core = tg->cfs_rq[core_id];
 12430	#endif
 12431	}
 12432	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

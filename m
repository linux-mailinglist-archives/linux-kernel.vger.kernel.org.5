Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A4875D7EE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 01:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGUXqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 19:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGUXqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 19:46:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A72A30DD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689983165; x=1721519165;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DshBWCdp1DuGEi6SnZZL0MjZFlUodWYOJsqGH/FLDaQ=;
  b=fy15CHje3VCtdgQmZVl2ebOXbVCJRh0KADSb7c79m2gmQBShBvz9RD0s
   aqLVLGWxQVxt6BLbtYlncQBkvkmW/Beo6lZeIj2rtDaGnY/iqxvHe6IkU
   HoDh4kKuAgeCo/mytjMVdsbzKZu1AF/OTkR3M4xP0CDBBLbmc2qAi2yYY
   bwBA1/9zwIRBTMlskeTC5LyNKWoyrEB5aNsjhvSmtovrctchxojsxh9ft
   BBSvzfu78gHsCpg3LToolSiO+SPJ8aptx9RqxloBpBeMrlZPhcThWHVSF
   vVAtQDn1tHbAGVq9u1hnN7qoBamv3fdtQCWbYY1WwYh/Ad9vMyXWrRcYW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="352030668"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="352030668"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 16:46:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="815179724"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="815179724"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jul 2023 16:46:02 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMzov-0007lp-2o;
        Fri, 21 Jul 2023 23:46:01 +0000
Date:   Sat, 22 Jul 2023 07:45:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: kernel/sched/fair.c:9458:20: warning: stack frame size (1184)
 exceeds limit (1024) in 'update_sd_lb_stats'
Message-ID: <202307220719.ftYLcX0c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d192f5382581d972c4ae1b4d72e0b59b34cadeb9
commit: c82a69629c53eda5233f13fc11c3c01585ef48a2 sched/fair: fix case with reduced capacity CPU
date:   1 year ago
config: riscv-randconfig-r022-20230722 (https://download.01.org/0day-ci/archive/20230722/202307220719.ftYLcX0c-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230722/202307220719.ftYLcX0c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307220719.ftYLcX0c-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/sched/fair.c:519:20: warning: unused function 'list_del_leaf_cfs_rq' [-Wunused-function]
   static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
                      ^
   kernel/sched/fair.c:540:19: warning: unused function 'tg_is_idle' [-Wunused-function]
   static inline int tg_is_idle(struct task_group *tg)
                     ^
   kernel/sched/fair.c:5587:20: warning: unused function 'cfs_bandwidth_used' [-Wunused-function]
   static inline bool cfs_bandwidth_used(void)
                      ^
   kernel/sched/fair.c:5595:20: warning: unused function 'sync_throttle' [-Wunused-function]
   static inline void sync_throttle(struct task_group *tg, int cpu) {}
                      ^
   kernel/sched/fair.c:5620:37: warning: unused function 'tg_cfs_bandwidth' [-Wunused-function]
   static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
                                       ^
   kernel/sched/fair.c:5624:20: warning: unused function 'destroy_cfs_bandwidth' [-Wunused-function]
   static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
                      ^
>> kernel/sched/fair.c:9458:20: warning: stack frame size (1184) exceeds limit (1024) in 'update_sd_lb_stats' [-Wframe-larger-than]
   static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sds)
                      ^
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   7 warnings and 20 errors generated.


vim +/update_sd_lb_stats +9458 kernel/sched/fair.c

70fb5ccf2ebb09 kernel/sched/fair.c Chen Yu           2022-06-13  9451  
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra    2009-12-17  9452  /**
461819ac8ee950 kernel/sched_fair.c Hui Kang          2011-10-11  9453   * update_sd_lb_stats - Update sched_domain's statistics for load balancing.
cd96891d48a945 kernel/sched/fair.c Randy Dunlap      2012-06-08  9454   * @env: The load balancing environment.
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra    2009-12-17  9455   * @sds: variable to hold the statistics for this sched_domain.
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra    2009-12-17  9456   */
0b0695f2b34a4a kernel/sched/fair.c Vincent Guittot   2019-10-18  9457  
0ec8aa00f2b4dc kernel/sched/fair.c Peter Zijlstra    2013-10-07 @9458  static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sds)
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra    2009-12-17  9459  {
bd939f45da24e2 kernel/sched/fair.c Peter Zijlstra    2012-05-02  9460  	struct sched_domain *child = env->sd->child;
bd939f45da24e2 kernel/sched/fair.c Peter Zijlstra    2012-05-02  9461  	struct sched_group *sg = env->sd->groups;
05b40e05773481 kernel/sched/fair.c Srikar Dronamraju 2017-03-22  9462  	struct sg_lb_stats *local = &sds->local_stat;
56cf515b4b1567 kernel/sched/fair.c Joonsoo Kim       2013-08-06  9463  	struct sg_lb_stats tmp_sgs;
70fb5ccf2ebb09 kernel/sched/fair.c Chen Yu           2022-06-13  9464  	unsigned long sum_util = 0;
630246a06ae2a7 kernel/sched/fair.c Quentin Perret    2018-12-03  9465  	int sg_status = 0;
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra    2009-12-17  9466  
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra    2009-12-17  9467  	do {
56cf515b4b1567 kernel/sched/fair.c Joonsoo Kim       2013-08-06  9468  		struct sg_lb_stats *sgs = &tmp_sgs;
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra    2009-12-17  9469  		int local_group;
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra    2009-12-17  9470  
ae4df9d6c93510 kernel/sched/fair.c Peter Zijlstra    2017-05-01  9471  		local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(sg));
56cf515b4b1567 kernel/sched/fair.c Joonsoo Kim       2013-08-06  9472  		if (local_group) {
56cf515b4b1567 kernel/sched/fair.c Joonsoo Kim       2013-08-06  9473  			sds->local = sg;
05b40e05773481 kernel/sched/fair.c Srikar Dronamraju 2017-03-22  9474  			sgs = local;
b72ff13ce6021b kernel/sched/fair.c Peter Zijlstra    2013-08-28  9475  
b72ff13ce6021b kernel/sched/fair.c Peter Zijlstra    2013-08-28  9476  			if (env->idle != CPU_NEWLY_IDLE ||
63b2ca30bdb3db kernel/sched/fair.c Nicolas Pitre     2014-05-26  9477  			    time_after_eq(jiffies, sg->sgc->next_update))
63b2ca30bdb3db kernel/sched/fair.c Nicolas Pitre     2014-05-26  9478  				update_group_capacity(env->sd, env->dst_cpu);
56cf515b4b1567 kernel/sched/fair.c Joonsoo Kim       2013-08-06  9479  		}
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra    2009-12-17  9480  
c0d14b57fe0c11 kernel/sched/fair.c Ricardo Neri      2021-09-10  9481  		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra    2009-12-17  9482  
b72ff13ce6021b kernel/sched/fair.c Peter Zijlstra    2013-08-28  9483  		if (local_group)
b72ff13ce6021b kernel/sched/fair.c Peter Zijlstra    2013-08-28  9484  			goto next_group;
b72ff13ce6021b kernel/sched/fair.c Peter Zijlstra    2013-08-28  9485  
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra    2009-12-17  9486  
b72ff13ce6021b kernel/sched/fair.c Peter Zijlstra    2013-08-28  9487  		if (update_sd_pick_busiest(env, sds, sg, sgs)) {
532cb4c401e225 kernel/sched_fair.c Michael Neuling   2010-06-08  9488  			sds->busiest = sg;
56cf515b4b1567 kernel/sched/fair.c Joonsoo Kim       2013-08-06  9489  			sds->busiest_stat = *sgs;
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra    2009-12-17  9490  		}
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra    2009-12-17  9491  
b72ff13ce6021b kernel/sched/fair.c Peter Zijlstra    2013-08-28  9492  next_group:
b72ff13ce6021b kernel/sched/fair.c Peter Zijlstra    2013-08-28  9493  		/* Now, start updating sd_lb_stats */
b72ff13ce6021b kernel/sched/fair.c Peter Zijlstra    2013-08-28  9494  		sds->total_load += sgs->group_load;
63b2ca30bdb3db kernel/sched/fair.c Nicolas Pitre     2014-05-26  9495  		sds->total_capacity += sgs->group_capacity;
b72ff13ce6021b kernel/sched/fair.c Peter Zijlstra    2013-08-28  9496  
70fb5ccf2ebb09 kernel/sched/fair.c Chen Yu           2022-06-13  9497  		sum_util += sgs->group_util;
532cb4c401e225 kernel/sched_fair.c Michael Neuling   2010-06-08  9498  		sg = sg->next;
bd939f45da24e2 kernel/sched/fair.c Peter Zijlstra    2012-05-02  9499  	} while (sg != env->sd->groups);
0ec8aa00f2b4dc kernel/sched/fair.c Peter Zijlstra    2013-10-07  9500  
0b0695f2b34a4a kernel/sched/fair.c Vincent Guittot   2019-10-18  9501  	/* Tag domain that child domain prefers tasks go to siblings first */
0b0695f2b34a4a kernel/sched/fair.c Vincent Guittot   2019-10-18  9502  	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
0b0695f2b34a4a kernel/sched/fair.c Vincent Guittot   2019-10-18  9503  
f643ea2207010d kernel/sched/fair.c Vincent Guittot   2018-02-13  9504  
0ec8aa00f2b4dc kernel/sched/fair.c Peter Zijlstra    2013-10-07  9505  	if (env->sd->flags & SD_NUMA)
0ec8aa00f2b4dc kernel/sched/fair.c Peter Zijlstra    2013-10-07  9506  		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
4486edd12b5ac8 kernel/sched/fair.c Tim Chen          2014-06-23  9507  
4486edd12b5ac8 kernel/sched/fair.c Tim Chen          2014-06-23  9508  	if (!env->sd->parent) {
2802bf3cd936fe kernel/sched/fair.c Morten Rasmussen  2018-12-03  9509  		struct root_domain *rd = env->dst_rq->rd;
2802bf3cd936fe kernel/sched/fair.c Morten Rasmussen  2018-12-03  9510  
4486edd12b5ac8 kernel/sched/fair.c Tim Chen          2014-06-23  9511  		/* update overload indicator if we are at root domain */
2802bf3cd936fe kernel/sched/fair.c Morten Rasmussen  2018-12-03  9512  		WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
2802bf3cd936fe kernel/sched/fair.c Morten Rasmussen  2018-12-03  9513  
2802bf3cd936fe kernel/sched/fair.c Morten Rasmussen  2018-12-03  9514  		/* Update over-utilization (tipping point, U >= 0) indicator */
2802bf3cd936fe kernel/sched/fair.c Morten Rasmussen  2018-12-03  9515  		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
f9f240f96efc5b kernel/sched/fair.c Qais Yousef       2019-06-04  9516  		trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
2802bf3cd936fe kernel/sched/fair.c Morten Rasmussen  2018-12-03  9517  	} else if (sg_status & SG_OVERUTILIZED) {
f9f240f96efc5b kernel/sched/fair.c Qais Yousef       2019-06-04  9518  		struct root_domain *rd = env->dst_rq->rd;
f9f240f96efc5b kernel/sched/fair.c Qais Yousef       2019-06-04  9519  
f9f240f96efc5b kernel/sched/fair.c Qais Yousef       2019-06-04  9520  		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
f9f240f96efc5b kernel/sched/fair.c Qais Yousef       2019-06-04  9521  		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
4486edd12b5ac8 kernel/sched/fair.c Tim Chen          2014-06-23  9522  	}
70fb5ccf2ebb09 kernel/sched/fair.c Chen Yu           2022-06-13  9523  
70fb5ccf2ebb09 kernel/sched/fair.c Chen Yu           2022-06-13  9524  	update_idle_cpu_scan(env, sum_util);
532cb4c401e225 kernel/sched_fair.c Michael Neuling   2010-06-08  9525  }
532cb4c401e225 kernel/sched_fair.c Michael Neuling   2010-06-08  9526  

:::::: The code at line 9458 was first introduced by commit
:::::: 0ec8aa00f2b4dc457836ef4e2662b02483e94fb7 sched/numa: Avoid migrating tasks that are placed on their preferred node

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

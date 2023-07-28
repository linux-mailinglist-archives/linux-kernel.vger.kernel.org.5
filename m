Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302C5766173
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjG1BoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 21:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjG1BoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:44:13 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE63F2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 18:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690508652; x=1722044652;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jiXO+e/9FmwFmWxU1jRcHfveHEgaDPNMgs0lc3dYRCY=;
  b=eEM1+oubFkox04nsVgG3wl4kHeB7dcMfoh9QhoxD+KlXHZgARY89d7QK
   h5N2yoK7v8GLhu/peSsMtrXOkndyOeyF+QUYjOVw7z6aTIsoxPvwV65hB
   J0f4v27U3cppeF+zyvdLOXFHzBU/yWZpf94IjeVGkcYu6LjrnzAKlPT8z
   VHzzOaThirZ4eFoQKCt5Z+TkZ4280viw7vtux/Nfm3U63dwYNDHOuImnP
   ZmciRfGQGUAzIKFTGtDD3+jdeNjn3NcGBuK25K86yBiNLCSU1yAncy2I6
   xCf0k680C/azBZ5UR2nj7mFO10x/tTsbb+GxxAe2P274gmGq4Jq/s/+bW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432294325"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="432294325"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 18:44:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="841086600"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="841086600"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jul 2023 18:44:10 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPCWV-0002lr-2S;
        Fri, 28 Jul 2023 01:44:08 +0000
Date:   Fri, 28 Jul 2023 09:44:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [tip:sched/eevdf 5/12] kernel/sched/fair.c:721:6: sparse: sparse:
 symbol 'update_entity_lag' was not declared. Should it be static?
Message-ID: <202307280906.nLYx7MtQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/eevdf
head:   d07f09a1f99cabbc86bc5c97d962eb8a466106b5
commit: 86bfbb7ce4f67a88df2639198169b685668e7349 [5/12] sched/fair: Add lag based placement
config: i386-randconfig-i061-20230727 (https://download.01.org/0day-ci/archive/20230728/202307280906.nLYx7MtQ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307280906.nLYx7MtQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307280906.nLYx7MtQ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/sched/fair.c:721:6: sparse: sparse: symbol 'update_entity_lag' was not declared. Should it be static?
   kernel/sched/fair.c:1065:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_entity const *se @@     got struct sched_entity [noderef] __rcu * @@
   kernel/sched/fair.c:1065:34: sparse:     expected struct sched_entity const *se
   kernel/sched/fair.c:1065:34: sparse:     got struct sched_entity [noderef] __rcu *
   kernel/sched/fair.c:8167:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:8167:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:8167:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:8465:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:8465:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:8465:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:6402:35: sparse: sparse: marked inline, but without a definition
   kernel/sched/fair.c: note: in included file:
   kernel/sched/sched.h:2279:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2279:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2279:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2117:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2117:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2117:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2117:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2117:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2117:25: sparse:    struct task_struct *

vim +/update_entity_lag +721 kernel/sched/fair.c

   712	
   713	/*
   714	 * Entity is eligible once it received less service than it ought to have,
   715	 * eg. lag >= 0.
   716	 *
   717	 * lag_i = S - s_i = w_i*(V - v_i)
   718	 *
   719	 * lag_i >= 0 -> V >= v_i
   720	 *
 > 721	 *     \Sum (v_i - v)*w_i
   722	 * V = ------------------ + v
   723	 *          \Sum w_i
   724	 *
   725	 * lag_i >= 0 -> \Sum (v_i - v)*w_i >= (v_i - v)*(\Sum w_i)
   726	 *
   727	 * Note: using 'avg_vruntime() > se->vruntime' is inacurate due
   728	 *       to the loss in precision caused by the division.
   729	 */
   730	int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
   731	{
   732		struct sched_entity *curr = cfs_rq->curr;
   733		s64 avg = cfs_rq->avg_vruntime;
   734		long load = cfs_rq->avg_load;
   735	
   736		if (curr && curr->on_rq) {
   737			unsigned long weight = scale_load_down(curr->load.weight);
   738	
   739			avg += entity_key(cfs_rq, curr) * weight;
   740			load += weight;
   741		}
   742	
   743		return avg >= entity_key(cfs_rq, se) * load;
   744	}
   745	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

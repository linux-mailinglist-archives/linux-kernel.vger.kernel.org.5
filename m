Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05C07ED1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbjKOUUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjKOUUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:20:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4343B8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700079626; x=1731615626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T1GP7GXoaoIChGMuNLSf49/e9iQXuhmOH31So9M2lVQ=;
  b=SmI/ehJvmIbM+V3iG5S0DA9kBkXLCfSJSEOkuziJqBaQj0+KRa/IzH9y
   A16Tyi8CYPtejtFyXLxeIhBX24Pt8LUCJJPDlpTtOvTcderu754BTvH/j
   +zkCJ9B6d9tiEWqfe+p99CJbrhfffN7AKqFmp3NU0FSND/r5tBsDgNTux
   iNJu5s5cIKUu6J9vxugwr4l8GOMIRZpVeV15pBeZ8903iz4xtY042Z1PM
   d/dIzdXgQGuc8tPJ7BjsFSX97531CM9nGPrsVGyaXWi8XQ+MN+xelZ3Jk
   R8YQ7vXMQr26nvXB7t1hlu46/QD2/qnCE1Oj4ExyDD3AXrs1VCKVu+8EZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="4027460"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="4027460"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 12:20:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="835504492"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="835504492"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Nov 2023 12:20:22 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3MN2-0000n2-10;
        Wed, 15 Nov 2023 20:20:20 +0000
Date:   Thu, 16 Nov 2023 04:19:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joel@joelfernandes.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched/core: introduce core to struct cfs_rq
Message-ID: <202311160408.5eq3Ye68-lkp@intel.com>
References: <20231115113341.13261-3-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115113341.13261-3-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cruz,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7-rc1 next-20231115]
[cannot apply to tip/sched/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cruz-Zhao/sched-core-introduce-core_id-to-struct-rq/20231115-193559
base:   linus/master
patch link:    https://lore.kernel.org/r/20231115113341.13261-3-CruzZhao%40linux.alibaba.com
patch subject: [PATCH 2/4] sched/core: introduce core to struct cfs_rq
config: x86_64-buildonly-randconfig-004-20231116 (https://download.01.org/0day-ci/archive/20231116/202311160408.5eq3Ye68-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160408.5eq3Ye68-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160408.5eq3Ye68-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/sched/fair.c: In function 'alloc_fair_sched_group':
>> kernel/sched/fair.c:12728:17: error: implicit declaration of function 'sched_core_init_cfs_rq'; did you mean 'sched_core_idle_cpu'? [-Werror=implicit-function-declaration]
   12728 |                 sched_core_init_cfs_rq(tg, cfs_rq);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
         |                 sched_core_idle_cpu
   cc1: some warnings being treated as errors


vim +12728 kernel/sched/fair.c

 12697	
 12698	int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 12699	{
 12700		struct sched_entity *se;
 12701		struct cfs_rq *cfs_rq;
 12702		int i;
 12703	
 12704		tg->cfs_rq = kcalloc(nr_cpu_ids, sizeof(cfs_rq), GFP_KERNEL);
 12705		if (!tg->cfs_rq)
 12706			goto err;
 12707		tg->se = kcalloc(nr_cpu_ids, sizeof(se), GFP_KERNEL);
 12708		if (!tg->se)
 12709			goto err;
 12710	
 12711		tg->shares = NICE_0_LOAD;
 12712	
 12713		init_cfs_bandwidth(tg_cfs_bandwidth(tg), tg_cfs_bandwidth(parent));
 12714	
 12715		for_each_possible_cpu(i) {
 12716			cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
 12717					      GFP_KERNEL, cpu_to_node(i));
 12718			if (!cfs_rq)
 12719				goto err;
 12720	
 12721			se = kzalloc_node(sizeof(struct sched_entity_stats),
 12722					  GFP_KERNEL, cpu_to_node(i));
 12723			if (!se)
 12724				goto err_free_rq;
 12725	
 12726			init_cfs_rq(cfs_rq);
 12727			init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
 12728			sched_core_init_cfs_rq(tg, cfs_rq);
 12729			init_entity_runnable_average(se);
 12730		}
 12731	
 12732		return 1;
 12733	
 12734	err_free_rq:
 12735		kfree(cfs_rq);
 12736	err:
 12737		return 0;
 12738	}
 12739	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8E5806746
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376793AbjLFGad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjLFGab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:30:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D101B5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701844238; x=1733380238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=In9RUFFIUXErDaIineMw7IEV2lx9EUq4uLOuxVCGDAQ=;
  b=k3fmHIK21bpVIZAzrGHc4DzM4QcwWYoxiaO4e5ar9FEV7WPBu9K4YG3g
   LCjefhOwfCDY6/prAI5vu7TFcftlc2bSh52eRkiSZTS8OK9TF83aYYe7W
   +C7FOLkl4sSXHUasr0aCegqna//baREGlUXEroF1GOZcvHX5xYYmEZ7f4
   viSl1kkkKxSaRKCNJ3rLZuYVFk+khEKZlJQtpsESCgyAkPtw8GRw2ENBW
   K9pRrV0IJgaAEKLRs3KZ4D35RAU78ggHUGenS1CqnyZyQ4g0eWASvGmeF
   VV9/usz3AxdmfaPycrodvncezS67isbaB2XbDVrb3dRjbn4/a+bY60XEJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="15564126"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="15564126"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 22:30:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="944537718"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="944537718"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2023 22:30:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAlQP-000AOS-0w;
        Wed, 06 Dec 2023 06:30:26 +0000
Date:   Wed, 6 Dec 2023 14:29:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yajun Deng <yajun.deng@linux.dev>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [PATCH 2/2] sched/rt: Return NULL when rt entity isn't a task in
 rt_task_of()
Message-ID: <202312061449.VhDizEfx-lkp@intel.com>
References: <20231201022704.3526377-3-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201022704.3526377-3-yajun.deng@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yajun,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on next-20231206]
[cannot apply to linus/master v6.7-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yajun-Deng/sched-fair-Return-NULL-when-entity-isn-t-a-task-in-task_of/20231201-103036
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20231201022704.3526377-3-yajun.deng%40linux.dev
patch subject: [PATCH 2/2] sched/rt: Return NULL when rt entity isn't a task in rt_task_of()
config: arm-ixp4xx_defconfig (https://download.01.org/0day-ci/archive/20231206/202312061449.VhDizEfx-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312061449.VhDizEfx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061449.VhDizEfx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:45:
>> kernel/sched/rt.c:947:17: error: no member named 'highest_prio' in 'struct rt_rq'
                   return rt_rq->highest_prio.curr;
                          ~~~~~  ^
   1 error generated.


vim +947 kernel/sched/rt.c

ac086bc22997a2b kernel/sched_rt.c Peter Zijlstra  2008-04-19  941  
6f505b16425a512 kernel/sched_rt.c Peter Zijlstra  2008-01-25  942  static inline int rt_se_prio(struct sched_rt_entity *rt_se)
6f505b16425a512 kernel/sched_rt.c Peter Zijlstra  2008-01-25  943  {
6f505b16425a512 kernel/sched_rt.c Peter Zijlstra  2008-01-25  944  	struct rt_rq *rt_rq = group_rt_rq(rt_se);
6f505b16425a512 kernel/sched_rt.c Peter Zijlstra  2008-01-25  945  
6f505b16425a512 kernel/sched_rt.c Peter Zijlstra  2008-01-25  946  	if (rt_rq)
e864c499d9e5780 kernel/sched_rt.c Gregory Haskins 2008-12-29 @947  		return rt_rq->highest_prio.curr;
6f505b16425a512 kernel/sched_rt.c Peter Zijlstra  2008-01-25  948  
6f505b16425a512 kernel/sched_rt.c Peter Zijlstra  2008-01-25  949  	return rt_task_of(rt_se)->prio;
6f505b16425a512 kernel/sched_rt.c Peter Zijlstra  2008-01-25  950  }
6f505b16425a512 kernel/sched_rt.c Peter Zijlstra  2008-01-25  951  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AD37E4F29
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344036AbjKHCw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbjKHCwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:52:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9420010FE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 18:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699411936; x=1730947936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ic2PifihHMw92O/FRVfICjOpNVYui/Aoj90HmnbW4YI=;
  b=UWaanYbu1rkVZFJsvWe8NicNpgonZvSUHbNfmgKsNIUXqmD+UWZQf5CE
   CkCBP3W9Z2ehSV9KQIE2PQjVk2Ho4AYSxfViGMaEgzcoFl8zme4r/p7tV
   42sbngHDfZLY03lltthFNrHhpE4+S5JMG8bbu4+ax/7CaQU40jYZ0Km72
   umirKLzMsB8E2CY63AHyDN+ZQgoMH+7Uz3bImpExtk4VEMRC708+DwIwP
   IyxUumAfb/oo+2vRMiY0jUZ/FBmocUFP0XeHYNM9pDg4UPhj8IG6d0K+H
   UtFhrw9vFaWzY70lXcQ15VNzTdBKWil1/aWIM5Y82RJnFQ53mqtO45tH0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="475905409"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="475905409"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 18:52:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="756409496"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="756409496"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Nov 2023 18:52:11 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0Yfo-0007bG-0o;
        Wed, 08 Nov 2023 02:52:08 +0000
Date:   Wed, 8 Nov 2023 10:51:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH v6 15/20] sched: Add proxy deactivate helper
Message-ID: <202311081028.yDLmCWgr-lkp@intel.com>
References: <20231106193524.866104-16-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106193524.866104-16-jstultz@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on v6.6]
[cannot apply to tip/sched/core tip/master linus/master tip/auto-latest next-20231107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Stultz/sched-Unify-runtime-accounting-across-classes/20231107-033946
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20231106193524.866104-16-jstultz%40google.com
patch subject: [PATCH v6 15/20] sched: Add proxy deactivate helper
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231108/202311081028.yDLmCWgr-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231108/202311081028.yDLmCWgr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311081028.yDLmCWgr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/sched/core.c:6616:6: warning: no previous prototype for 'proxy_deactivate' [-Wmissing-prototypes]
    6616 | bool proxy_deactivate(struct rq *rq, struct task_struct *next)
         |      ^~~~~~~~~~~~~~~~


vim +/proxy_deactivate +6616 kernel/sched/core.c

  6615	
> 6616	bool proxy_deactivate(struct rq *rq, struct task_struct *next)
  6617	{
  6618		unsigned long state = READ_ONCE(next->__state);
  6619	
  6620		/* Don't deactivate if the state has been changed to TASK_RUNNING */
  6621		if (!state)
  6622			return false;
  6623		if (!try_to_deactivate_task(rq, next, state, true))
  6624			return false;
  6625		put_prev_task(rq, next);
  6626		rq_set_selected(rq, rq->idle);
  6627		resched_curr(rq);
  6628		return true;
  6629	}
  6630	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

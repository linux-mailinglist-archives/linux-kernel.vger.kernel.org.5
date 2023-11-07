Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0390B7E4C05
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjKGWqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjKGWqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:46:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E835DA;
        Tue,  7 Nov 2023 14:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699397211; x=1730933211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rer7ZGPLUThrKBd9/9741+alvyawJLNkmw1r/GSP3/g=;
  b=GtKCs919Cb304LKjXSoo46bMaXNAdJbJv6Pg8T7iC9rxAPwTPuHVTx2d
   6bcCRm088OvW2KrRLaYAqHLAKy0P8gk+ZATdzP7GLhVzJEq6LoGY5sXM8
   y7MPwmnGDIDhxHE36MZlfQVs5VBT6TTWB7kOn1N2e+g0e3sXwE2X8bAzc
   DE77exoSGn6LsDgcYls+NYrGlF4TPqfDq+mdWJO2I5ul7EabkuTrD4QzN
   YVH+RTywtpo59bG4vVV0XXsFMdtrFhX8h7FIMHMDUGvqe4gS65oKLIgNu
   R1nOGCv4bc6WyfNcfO8Xn9uC83/LYdNlpYyXmQV83buoKmOimPVwq0Nj7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="392507857"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="392507857"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 14:46:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="886460393"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="886460393"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Nov 2023 14:46:47 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0UqK-0007Rw-30;
        Tue, 07 Nov 2023 22:46:44 +0000
Date:   Wed, 8 Nov 2023 06:45:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 4/7] net/sched: taprio: get corrected value of
 cycle_time and interval
Message-ID: <202311080506.qMlPx2WA-lkp@intel.com>
References: <20231107112023.676016-5-faizal.abdul.rahim@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107112023.676016-5-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Faizal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Faizal-Rahim/net-sched-taprio-fix-too-early-schedules-switching/20231107-192843
base:   net/main
patch link:    https://lore.kernel.org/r/20231107112023.676016-5-faizal.abdul.rahim%40linux.intel.com
patch subject: [PATCH v2 net 4/7] net/sched: taprio: get corrected value of cycle_time and interval
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20231108/202311080506.qMlPx2WA-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231108/202311080506.qMlPx2WA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311080506.qMlPx2WA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/sched/sch_taprio.c:227:5: warning: no previous prototype for 'get_interval' [-Wmissing-prototypes]
     227 | u32 get_interval(const struct sched_entry *entry,
         |     ^~~~~~~~~~~~
>> net/sched/sch_taprio.c:236:5: warning: no previous prototype for 'get_cycle_time' [-Wmissing-prototypes]
     236 | s64 get_cycle_time(const struct sched_gate_list *oper)
         |     ^~~~~~~~~~~~~~


vim +/get_interval +227 net/sched/sch_taprio.c

   226	
 > 227	u32 get_interval(const struct sched_entry *entry,
   228			 const struct sched_gate_list *oper)
   229	{
   230		if (entry->correction_active)
   231			return entry->interval + oper->cycle_time_correction;
   232		else
   233			return entry->interval;
   234	}
   235	
 > 236	s64 get_cycle_time(const struct sched_gate_list *oper)
   237	{
   238		if (cycle_corr_active(oper->cycle_time_correction))
   239			return oper->cycle_time + oper->cycle_time_correction;
   240		else
   241			return oper->cycle_time;
   242	}
   243	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

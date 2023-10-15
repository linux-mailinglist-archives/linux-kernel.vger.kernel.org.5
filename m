Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC857C98C0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 13:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjJOLEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 07:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOLEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 07:04:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9576C5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697367871; x=1728903871;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UZTLHkcFYTnxd6qgSdi4Kz02bDuGQ++kI+b+p54QUL8=;
  b=EGw+6XAQK9bkXmHG3WVu00YzYhYNyWzjV3eWfMRL7c9QUuxXjsKsG6nn
   OtyYrxJqfsmiyNvWl//c9Dqjh2CuoWRkQnKdUWQ56KjTtOP5XReCtJm3T
   khGEJXi5izgyKa5xf6xIxrO6I8TNunEIVH+xXwenWgMSCvByxPFwgdGS4
   YHSq8gdjmCO/pMAGebWI9Dt/mY8q7ZWKSyeagY5RgpLHHUjIKXfi26N3r
   KmaCa9flgw5SAV3vXWdZ2FUyypCGT5xrFhXjUl6oh3uPVvpVHuPFZD7/j
   MxGjLe8Ydswr2pDMiNzUumqXQFbvJHUsk2DAaAhEVRqcik6UJ0yJpOeen
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="382610280"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="382610280"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 04:04:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1002575533"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="1002575533"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 15 Oct 2023 04:04:29 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qryv5-0007LX-28;
        Sun, 15 Oct 2023 11:04:27 +0000
Date:   Sun, 15 Oct 2023 19:03:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baisong Zhong <zhongbaisong@huawei.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: kernel/sched/rt.c:9:18: warning: 'max_rt_runtime' defined but not
 used
Message-ID: <202310151835.jARUbXX7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baisong,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9a3dad63edbe9a2ab2be1e7361a2133f519f855b
commit: 28f152cd0926596e69d412467b11b6fe6fe4e864 sched/rt: fix build error when CONFIG_SYSCTL is disable
date:   1 year, 6 months ago
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20231015/202310151835.jARUbXX7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231015/202310151835.jARUbXX7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310151835.jARUbXX7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:43:
   kernel/sched/rt.c:309:6: warning: no previous prototype for 'unregister_rt_sched_group' [-Wmissing-prototypes]
     309 | void unregister_rt_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:311:6: warning: no previous prototype for 'free_rt_sched_group' [-Wmissing-prototypes]
     311 | void free_rt_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:313:5: warning: no previous prototype for 'alloc_rt_sched_group' [-Wmissing-prototypes]
     313 | int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:716:6: warning: no previous prototype for 'sched_rt_bandwidth_account' [-Wmissing-prototypes]
     716 | bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/sched/rt.c:9:18: warning: 'max_rt_runtime' defined but not used [-Wunused-const-variable=]
       9 | static const u64 max_rt_runtime = MAX_BW;
         |                  ^~~~~~~~~~~~~~


vim +/max_rt_runtime +9 kernel/sched/rt.c

d505b8af58912a Huaixin Chang  2020-04-25  @9  static const u64 max_rt_runtime = MAX_BW;
ce0dbbbb30aee6 Clark Williams 2013-02-07  10  

:::::: The code at line 9 was first introduced by commit
:::::: d505b8af58912ae1e1a211fabc9995b19bd40828 sched: Defend cfs and rt bandwidth quota against overflow

:::::: TO: Huaixin Chang <changhuaixin@linux.alibaba.com>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351747802DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356780AbjHRBDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356776AbjHRBDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:03:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001B9359C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692320595; x=1723856595;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t++tpmMuAIkOauTGE1vde2ij/1bAp1pjX5+7zj/xqdA=;
  b=XJEa5ey20fjhaJq7J11WGY6QOImcoXAkScsrQnXPPo0obMLQfZrw3Onv
   n5uaDdwOYUD13PwOi2uF16XIcJRGL5j54eLXbHJ8P2Doe3GBu6jGEvea7
   L23W6DM99geOmk+bixc6N+7r/hDQ2UdqhweYd7+I4XBxCNG2EZLmMrk1i
   +xArW77LbXBSjbv4QdK6gGkgd2mOStWOeHqBWfiEUh699zQN0YdEop2oR
   RnewSfqiKW7bj8C+n2Ek526GvS6zn/gwyJcJ13z8g+kK7pGrz0N4Qx6BQ
   iELGI97KjQ1Nsfemw7jt/lfip97EaXzSp5baSxzxt/Bif60ofrVj5t8vJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="376736494"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="376736494"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 18:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="981430211"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="981430211"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2023 18:03:02 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWntF-0001Zx-2K;
        Fri, 18 Aug 2023 01:03:01 +0000
Date:   Fri, 18 Aug 2023 09:02:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:locktorture.2023.08.17a 14/20]
 kernel/rcu/tree.c:4100:6: warning: no previous declaration for
 'rcu_barrier_throttled'
Message-ID: <202308180853.brWVZKoo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git locktorture.2023.08.17a
head:   ccd7c62460a1ca6a8fb800de0d50d973ba62dcb8
commit: 365332de5f7bd1ab448ad4a6bd73a4fc8f1cc8ec [14/20] rcu: Add sysfs to provide throttled access to rcu_barrier()
config: x86_64-randconfig-x071-20230818 (https://download.01.org/0day-ci/archive/20230818/202308180853.brWVZKoo-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308180853.brWVZKoo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308180853.brWVZKoo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/rcu/tree.c:4100:6: warning: no previous declaration for 'rcu_barrier_throttled' [-Wmissing-declarations]
    void rcu_barrier_throttled(void)
         ^~~~~~~~~~~~~~~~~~~~~


vim +/rcu_barrier_throttled +4100 kernel/rcu/tree.c

  4083	
  4084	/**
  4085	 * rcu_barrier_throttled - Do rcu_barrier(), but limit to one per second
  4086	 *
  4087	 * This can be thought of as guard rails around rcu_barrier() that
  4088	 * permits unrestricted userspace use, at least assuming the hardware's
  4089	 * try_cmpxchg() is robust.  There will be at most one call per second to
  4090	 * rcu_barrier() system-wide from use of this function, which means that
  4091	 * callers might needlessly wait a second or three.
  4092	 *
  4093	 * This is intended for use by test suites to avoid OOM by flushing RCU
  4094	 * callbacks from the previous test before starting the next.  See the
  4095	 * rcutree.do_rcu_barrier module parameter for more information.
  4096	 *
  4097	 * Why not simply make rcu_barrier() more scalable?  That might be the
  4098	 * eventual endpoint, but let's keep it simple for the time being.
  4099	 */
> 4100	void rcu_barrier_throttled(void)
  4101	{
  4102		unsigned long j = jiffies;
  4103		unsigned long old = READ_ONCE(rcu_barrier_last_throttle);
  4104		unsigned long s = rcu_seq_snap(&rcu_state.barrier_sequence);
  4105	
  4106		while (time_after(old + HZ, j) || !try_cmpxchg(&rcu_barrier_last_throttle, &old, j + HZ)) {
  4107			schedule_timeout_idle(HZ);
  4108			if (rcu_seq_done(&rcu_state.barrier_sequence, s))
  4109				return;
  4110			old = READ_ONCE(rcu_barrier_last_throttle);
  4111		}
  4112		rcu_barrier();
  4113	}
  4114	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

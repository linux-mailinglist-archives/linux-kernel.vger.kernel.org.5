Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C38E780460
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357548AbjHRDYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348309AbjHRDYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:24:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4CC11F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05C6265940
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 03:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBCAC433C8;
        Fri, 18 Aug 2023 03:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692329073;
        bh=qNRr6+x24LcKBk4geTb/46pv1/HC9zZu1tLc1Ev6D8A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lJnVrMc3HXLhbt4Zwbivk/SZ3v5+EEAEk+oW58m3KeR9HHEdfOLTSXyiC8WbTTGWR
         agCaua/Eg2lz7AlUdCorxNlsT6gPdEWVdBlnc+oSq0JhWY92x8hdl/y1vCAWx1vc9N
         IjWj0mPxSFEF3hEx41a5GSeRubQ56S+gSVwrgbBn5zQRlKimH0HHTNLAeJGCJjLys+
         juwzfZntU1k2VATVYGorghHGXg+rmQI1B7d6nijkd6VPju3O6e8HRKjYvPUjEK3dO5
         lzgbFOpjsLFc30rr27wxGxVC+bqqJGA7CNfXDcEZvKYIil+1D0NEul1QW+s6f9fug2
         v1qgw6RVuW6PQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E12C6CE03F0; Thu, 17 Aug 2023 20:24:32 -0700 (PDT)
Date:   Thu, 17 Aug 2023 20:24:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:locktorture.2023.08.17a 14/20]
 kernel/rcu/tree.c:4100:6: warning: no previous declaration for
 'rcu_barrier_throttled'
Message-ID: <3f3ebf13-2899-4246-af73-4c0c1b7c9f3a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202308180853.brWVZKoo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308180853.brWVZKoo-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 09:02:35AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git locktorture.2023.08.17a
> head:   ccd7c62460a1ca6a8fb800de0d50d973ba62dcb8
> commit: 365332de5f7bd1ab448ad4a6bd73a4fc8f1cc8ec [14/20] rcu: Add sysfs to provide throttled access to rcu_barrier()
> config: x86_64-randconfig-x071-20230818 (https://download.01.org/0day-ci/archive/20230818/202308180853.brWVZKoo-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce: (https://download.01.org/0day-ci/archive/20230818/202308180853.brWVZKoo-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308180853.brWVZKoo-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/rcu/tree.c:4100:6: warning: no previous declaration for 'rcu_barrier_throttled' [-Wmissing-declarations]
>     void rcu_barrier_throttled(void)
>          ^~~~~~~~~~~~~~~~~~~~~

This has since been declared static in a later version of this commit at:

f9d771b016ca ("rcu: Add sysfs to provide throttled access to rcu_barrier()")

Thank you for your testing efforts!

							Thanx, Paul

> vim +/rcu_barrier_throttled +4100 kernel/rcu/tree.c
> 
>   4083	
>   4084	/**
>   4085	 * rcu_barrier_throttled - Do rcu_barrier(), but limit to one per second
>   4086	 *
>   4087	 * This can be thought of as guard rails around rcu_barrier() that
>   4088	 * permits unrestricted userspace use, at least assuming the hardware's
>   4089	 * try_cmpxchg() is robust.  There will be at most one call per second to
>   4090	 * rcu_barrier() system-wide from use of this function, which means that
>   4091	 * callers might needlessly wait a second or three.
>   4092	 *
>   4093	 * This is intended for use by test suites to avoid OOM by flushing RCU
>   4094	 * callbacks from the previous test before starting the next.  See the
>   4095	 * rcutree.do_rcu_barrier module parameter for more information.
>   4096	 *
>   4097	 * Why not simply make rcu_barrier() more scalable?  That might be the
>   4098	 * eventual endpoint, but let's keep it simple for the time being.
>   4099	 */
> > 4100	void rcu_barrier_throttled(void)
>   4101	{
>   4102		unsigned long j = jiffies;
>   4103		unsigned long old = READ_ONCE(rcu_barrier_last_throttle);
>   4104		unsigned long s = rcu_seq_snap(&rcu_state.barrier_sequence);
>   4105	
>   4106		while (time_after(old + HZ, j) || !try_cmpxchg(&rcu_barrier_last_throttle, &old, j + HZ)) {
>   4107			schedule_timeout_idle(HZ);
>   4108			if (rcu_seq_done(&rcu_state.barrier_sequence, s))
>   4109				return;
>   4110			old = READ_ONCE(rcu_barrier_last_throttle);
>   4111		}
>   4112		rcu_barrier();
>   4113	}
>   4114	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

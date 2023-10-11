Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937287C5007
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345805AbjJKKZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjJKKZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:25:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F24792;
        Wed, 11 Oct 2023 03:25:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9ABC433C8;
        Wed, 11 Oct 2023 10:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697019901;
        bh=oT4bek1giU2pcDYjiPRXCUo2soNQg3dhKRIybePgP1E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KqLvHSipnPlMwzHGJdVAKj6HMQ5itgvrbriu3Kt0KYusl1WwnoCxEmexa4C66Shuk
         OAd2y4iuoUrtppWRFxsVbMxUN7A9qD5qG0qIrxtFlJaGEMVOAp0NwbvHdFtvKBZvqu
         1eVCHj0Y7XX/sFiYnQbWnTSW22A/n5kqDlA2quEh89NzNReAKos0HpLMgqBt052XmQ
         /G0P8o/aMapojyFGLHyKrGGLRyJ8YKhRbSNkIbin+IYFG95F2EcZwQHqKydm01TzJX
         m1lcvKQTmt91RpHA7Ctd82QOMwoD/8XLLWVhPW4vBRAkrVReOiDITtySe7FlpMq6Wk
         dN3PIvbhO1cQQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B5D56CE041E; Wed, 11 Oct 2023 03:25:00 -0700 (PDT)
Date:   Wed, 11 Oct 2023 03:25:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>,
        Ingo Molnar <mingo@kernel.org>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
Message-ID: <afe86f8d-e412-48e8-b2f6-a0879c832d4d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231004175203.943277832@linuxfoundation.org>
 <CA+G9fYunnEUT2evdabX1KOTiryP1heNHWDH4LWZCt2SVRmnKOA@mail.gmail.com>
 <20231006162038.d3q7sl34b4ouvjxf@revolver>
 <57c1ff4d-f138-4f89-8add-c96fb3ba6701@paulmck-laptop>
 <20231006175714.begtgj6wrs46ukmo@revolver>
 <7652477c-a37c-4509-9dc9-7f9d1dc08291@paulmck-laptop>
 <CAEXW_YS16NxPxg52T=3FcyZ2qocj36zKyhPnEQL3nBTbD-qJ-A@mail.gmail.com>
 <9470dab6-dee5-4505-95a2-f6782b648726@paulmck-laptop>
 <433f5823-059c-4b51-8d18-8b356a5a507f@paulmck-laptop>
 <20231011050504.GA201855@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011050504.GA201855@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 05:05:04AM +0000, Joel Fernandes wrote:
> On Tue, Oct 10, 2023 at 06:34:35PM -0700, Paul E. McKenney wrote:
> [...]
> > > > > > > > It's also worth noting that the bug this fixes wasn't exposed until the
> > > > > > > > maple tree (added in v6.1) was used for the IRQ descriptors (added in
> > > > > > > > v6.5).
> > > > > > >
> > > > > > > Lots of latent bugs, to be sure, even with rcutorture.  :-/
> > > > > >
> > > > > > The Right Thing is to fix the bug all the way back to the introduction,
> > > > > > but what fallout makes the backport less desirable than living with the
> > > > > > unexposed bug?
> > > > >
> > > > > You are quite right that it is possible for the risk of a backport to
> > > > > exceed the risk of the original bug.
> > > > >
> > > > > I defer to Joel (CCed) on how best to resolve this in -stable.
> > > > 
> > > > Maybe I am missing something but this issue should also be happening
> > > > in mainline right?
> > > > 
> > > > Even though mainline has 897ba84dc5aa ("rcu-tasks: Handle idle tasks
> > > > for recently offlined CPUs") , the warning should still be happening
> > > > due to Liam's "kernel/sched: Modify initial boot task idle setup"
> > > > because the warning is just rearranged a bit but essentially the same.
> > > > 
> > > > IMHO, the right thing to do then is to drop Liam's patch from 5.15 and
> > > > fix it in mainline (using the ideas described in this thread), then
> > > > backport both that new fix and Liam's patch to 5.15.
> > > > 
> > > > Or is there a reason this warning does not show up on the mainline?
> > 
> > There is not a whole lot of commonality between the v5.15.134 version of
> > RCU Tasks Trace and that of mainline.  In theory, in mainline, CPU hotplug
> > is supposed to be disabled across all calls to trc_inspect_reader(),
> > which means that there would not be any CPU coming or going.
> > 
> > But there could potentially be some time between when a CPU was
> > marked as online and its idle task was marked PF_IDLE.  And in
> > fact x86 start_secondary() invokes set_cpu_online() before it calls
> > cpu_startup_entry(), and it is the latter than sets PF_IDLE.
> > 
> > The same is true of alpha, arc, arm, arm64, csky, ia64, loongarch, mips,
> > openrisc, parisc, powerpc, riscv, s390, sh, sparc32, sparc64, x86 xen,
> > and xtensa, which is everybody.
> > 
> > One reason why my testing did not reproduce this is because I was running
> > against v6.6-rc1, and cff9b2332ab7 ("kernel/sched: Modify initial boot
> > task idle setup") went into v6.6-rc3.  An initial run merging in current
> > mainline also failed to reproduce this, but I am running overnight.
> > If that doesn't reproduce, I will try inserting delays between the
> > set_cpu_online() and the cpu_startup_entry().
> 
> I thought the warning happens before set_cpu_online() is even called, because
> under such situation, ofl == true and the task is not set to PF_IDLE yet:
> 
>                   WARN_ON_ONCE(ofl && task_curr(t) && !is_idle_task(t));

That case is supposed to be excluded by the cpus_read_lock() calls.
Yes, key phrase "supposed to be".  ;-)

> > If this problem is real, fixes include:
> > 
> > o	Revert Liam's patch and make Tiny RCU's call_rcu() deal with
> > 	the problem.  This is overhead and non-tinyness, but to Joel's
> > 	point, it might be best.
> > 
> > o	Go back to something more like Liam's original patch, which
> > 	cleared PF_IDLE only for the boot CPU.
> > 
> > o	Set PF_IDLE before calling set_cpu_online().  This would work,
> > 	but it would also be rather ugly, reaching into each and every
> > 	architecture.
> > 
> > o	Move the call to set_cpu_online() into cpu_startup_entry().
> > 	This would require some serious inspection to prove that it is
> > 	safe, assuming that it is in fact safe.
> > 
> > o	Drop the WARN_ON_ONCE() from trc_inspect_reader().  Not all
> > 	that excited by losing this diagnostic, but then again it
> > 	has been awhile since it has caught anything.
> > 
> > o	Make the WARN_ON_ONCE() condition in trc_inspect_reader() instead
> > 	to a "return false" to retry later.  Ditto, also not liking the
> > 	possibility of indefinite deferral with no warning.
> 
> Just for completeness, 
> 
>  o      Since it just a warning, checking for task_struct::pid == 0 instead of is_idle_task()?
>         Though PF_IDLE is also set in play_idle_precise().
> 
>  o	Change warning to:
>                   WARN_ON_ONCE(ofl && task_curr(t) && (!is_idle_task(t) && t->pid != 0));

This change does look promising, thank you!

							Thanx, Paul

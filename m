Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7E97C4754
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344642AbjJKBek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344233AbjJKBei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:34:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897BE91;
        Tue, 10 Oct 2023 18:34:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1103BC433CA;
        Wed, 11 Oct 2023 01:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696988076;
        bh=4g8W/jW1SSIMz/38aKZaH0NTpzAoKS0+MDQD5UVH4CY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n4R8kUPNlWi3gtL5dxIL5j3VfTlh+xmHshY0QyZKCQ3paqQ0+XAQQO+JElDt/7Xpb
         hPHtrPI/F2+8gfKJbbd9L/T7Ch4XqK+aKL930JC7CtI2RwNcyKRDuT/cWDX/Rm3/Ry
         doURb+FprBHd72J7wZmxtBhQ6xLyuHdkCbwP6Zp2SpV95yDArqLgs+up4LYJ/6+gmN
         RsHZP+tLD+ulDFeRQyH4WbgjaZxalhKCL3ei5WWWOqSsv1mFE8wbm+dBo+POFzP8l4
         M4uwmS3g1ZyZRfI9tw2/ocjKkjCfEcFgG6s+MSRnFugsPUrRLGPusMzKCva2OFlLY8
         oXyXm5yhIJzIw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A3140CE0D02; Tue, 10 Oct 2023 18:34:35 -0700 (PDT)
Date:   Tue, 10 Oct 2023 18:34:35 -0700
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
Message-ID: <433f5823-059c-4b51-8d18-8b356a5a507f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231004175203.943277832@linuxfoundation.org>
 <CA+G9fYunnEUT2evdabX1KOTiryP1heNHWDH4LWZCt2SVRmnKOA@mail.gmail.com>
 <20231006162038.d3q7sl34b4ouvjxf@revolver>
 <57c1ff4d-f138-4f89-8add-c96fb3ba6701@paulmck-laptop>
 <20231006175714.begtgj6wrs46ukmo@revolver>
 <7652477c-a37c-4509-9dc9-7f9d1dc08291@paulmck-laptop>
 <CAEXW_YS16NxPxg52T=3FcyZ2qocj36zKyhPnEQL3nBTbD-qJ-A@mail.gmail.com>
 <9470dab6-dee5-4505-95a2-f6782b648726@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9470dab6-dee5-4505-95a2-f6782b648726@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 06:20:53PM -0700, Paul E. McKenney wrote:
> On Sat, Oct 07, 2023 at 09:22:55PM -0400, Joel Fernandes wrote:
> > On Fri, Oct 6, 2023 at 2:20 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Fri, Oct 06, 2023 at 01:57:14PM -0400, Liam R. Howlett wrote:
> > > > * Paul E. McKenney <paulmck@kernel.org> [231006 12:47]:
> > > > > On Fri, Oct 06, 2023 at 12:20:38PM -0400, Liam R. Howlett wrote:
> > > > > > * Naresh Kamboju <naresh.kamboju@linaro.org> [231005 13:49]:
> > > > > > > On Wed, 4 Oct 2023 at 23:33, Greg Kroah-Hartman
> > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > >
> > > > > > > > This is the start of the stable review cycle for the 5.15.134 release.
> > > > > > > > There are 183 patches in this series, all will be posted as a response
> > > > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > > > let me know.
> > > > > > > >
> > > > > > > > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > > > > > > > Anything received after that time might be too late.
> > > > > > > >
> > > > > > > > The whole patch series can be found in one patch at:
> > > > > > > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.134-rc1.gz
> > > > > > > > or in the git tree and branch at:
> > > > > > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > > > > > and the diffstat can be found below.
> > > > > > > >
> > > > > > > > thanks,
> > > > > > > >
> > > > > > > > greg k-h
> > > > > > >
> > > > > > > Results from Linaro’s test farm.
> > > > > > > Regressions on x86.
> > > > > > >
> > > > > > > Following kernel warning noticed on x86 while booting stable-rc 5.15.134-rc1
> > > > > > > with selftest merge config built kernel.
> > > > > > >
> > > > > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > > > >
> > > > > > > Anyone noticed this kernel warning ?
> > > > > > >
> > > > > > > This is always reproducible while booting x86 with a given config.
> > > > > >
> > > > > > >From that config:
> > > > > > #
> > > > > > # RCU Subsystem
> > > > > > #
> > > > > > CONFIG_TREE_RCU=y
> > > > > > # CONFIG_RCU_EXPERT is not set
> > > > > > CONFIG_SRCU=y
> > > > > > CONFIG_TREE_SRCU=y
> > > > > > CONFIG_TASKS_RCU_GENERIC=y
> > > > > > CONFIG_TASKS_RUDE_RCU=y
> > > > > > CONFIG_TASKS_TRACE_RCU=y
> > > > > > CONFIG_RCU_STALL_COMMON=y
> > > > > > CONFIG_RCU_NEED_SEGCBLIST=y
> > > > > > # end of RCU Subsystem
> > > > > >
> > > > > > #
> > > > > > # RCU Debugging
> > > > > > #
> > > > > > CONFIG_PROVE_RCU=y
> > > > > > # CONFIG_RCU_SCALE_TEST is not set
> > > > > > # CONFIG_RCU_TORTURE_TEST is not set
> > > > > > # CONFIG_RCU_REF_SCALE_TEST is not set
> > > > > > CONFIG_RCU_CPU_STALL_TIMEOUT=21
> > > > > > CONFIG_RCU_TRACE=y
> > > > > > # CONFIG_RCU_EQS_DEBUG is not set
> > > > > > # end of RCU Debugging
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > x86 boot log:
> > > > > > > -----
> > > > > > > [    0.000000] Linux version 5.15.134-rc1 (tuxmake@tuxmake)
> > > > > > > (x86_64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
> > > > > > > for Debian) 2.40) #1 SMP @1696443178
> > > > > > > ...
> > > > > > > [    1.480701] ------------[ cut here ]------------
> > > > > > > [    1.481296] WARNING: CPU: 0 PID: 13 at kernel/rcu/tasks.h:958
> > > > > > > trc_inspect_reader+0x80/0xb0
> > > > > > > [    1.481296] Modules linked in:
> > > > > > > [    1.481296] CPU: 0 PID: 13 Comm: rcu_tasks_trace Not tainted 5.15.134-rc1 #1
> > > > > > > [    1.481296] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > > > > > > 2.5 11/26/2020
> > > > > > > [    1.481296] RIP: 0010:trc_inspect_reader+0x80/0xb0
> > > > > >
> > > > > > This function has changed a lot, including the dropping of this
> > > > > > WARN_ON_ONCE().  The warning was replaced in 897ba84dc5aa ("rcu-tasks:
> > > > > > Handle idle tasks for recently offlined CPUs") with something that looks
> > > > > > equivalent so I'm not sure why it would not trigger in newer revisions.
> > > > > >
> > > > > > Obviously the behaviour I changed was the test for the task being idle.
> > > > > > I am not sure how best to short-circuit that test from happening during
> > > > > > boot as I am not familiar with the RCU code.
> > > > >
> > > > > The usual test for RCU's notion of early boot being completed is
> > > > > (rcu_scheduler_active != RCU_SCHEDULER_INIT).
> > > > >
> > > > > Except that "ofl" should always be false that early in boot, at least
> > > > > in mainline.
> > > >
> > > > Is this still true in the final version of the patch where we set the
> > > > boot task as !idle until just before the early boot is finished?  I
> > > > wouldn't think of this as 'early in boot' anymore as much as the entire
> > > > kernel setup.  Maybe we need to shorten the time we stay in !idle mode
> > > > for earlier kernels?
> > >
> > > In mainline, the ofl variable is defined as cpu_is_offline(cpu), and
> > > during boot, the boot CPU is guaranteed to be online.  (As opposed to
> > > the boot CPU's idle-task state.)
> > >
> > > > How frequent is this function called?  We could check something for
> > > > early boot... or track down where the cpu is put online and restore idle
> > > > before that happens?
> > >
> > > Once per RCU Tasks Trace grace period per reader seen to be blocking
> > > that grace period.  Its performance is as issue, but not to anywhere
> > > near the same extent as (say) rcu_read_lock_trace().
> > >
> > > > > > It's also worth noting that the bug this fixes wasn't exposed until the
> > > > > > maple tree (added in v6.1) was used for the IRQ descriptors (added in
> > > > > > v6.5).
> > > > >
> > > > > Lots of latent bugs, to be sure, even with rcutorture.  :-/
> > > >
> > > > The Right Thing is to fix the bug all the way back to the introduction,
> > > > but what fallout makes the backport less desirable than living with the
> > > > unexposed bug?
> > >
> > > You are quite right that it is possible for the risk of a backport to
> > > exceed the risk of the original bug.
> > >
> > > I defer to Joel (CCed) on how best to resolve this in -stable.
> > 
> > Maybe I am missing something but this issue should also be happening
> > in mainline right?
> > 
> > Even though mainline has 897ba84dc5aa ("rcu-tasks: Handle idle tasks
> > for recently offlined CPUs") , the warning should still be happening
> > due to Liam's "kernel/sched: Modify initial boot task idle setup"
> > because the warning is just rearranged a bit but essentially the same.
> > 
> > IMHO, the right thing to do then is to drop Liam's patch from 5.15 and
> > fix it in mainline (using the ideas described in this thread), then
> > backport both that new fix and Liam's patch to 5.15.
> > 
> > Or is there a reason this warning does not show up on the mainline?

There is not a whole lot of commonality between the v5.15.134 version of
RCU Tasks Trace and that of mainline.  In theory, in mainline, CPU hotplug
is supposed to be disabled across all calls to trc_inspect_reader(),
which means that there would not be any CPU coming or going.

But there could potentially be some time between when a CPU was
marked as online and its idle task was marked PF_IDLE.  And in
fact x86 start_secondary() invokes set_cpu_online() before it calls
cpu_startup_entry(), and it is the latter than sets PF_IDLE.

The same is true of alpha, arc, arm, arm64, csky, ia64, loongarch, mips,
openrisc, parisc, powerpc, riscv, s390, sh, sparc32, sparc64, x86 xen,
and xtensa, which is everybody.

One reason why my testing did not reproduce this is because I was running
against v6.6-rc1, and cff9b2332ab7 ("kernel/sched: Modify initial boot
task idle setup") went into v6.6-rc3.  An initial run merging in current
mainline also failed to reproduce this, but I am running overnight.
If that doesn't reproduce, I will try inserting delays between the
set_cpu_online() and the cpu_startup_entry().

If this problem is real, fixes include:

o	Revert Liam's patch and make Tiny RCU's call_rcu() deal with
	the problem.  This is overhead and non-tinyness, but to Joel's
	point, it might be best.

o	Go back to something more like Liam's original patch, which
	cleared PF_IDLE only for the boot CPU.

o	Set PF_IDLE before calling set_cpu_online().  This would work,
	but it would also be rather ugly, reaching into each and every
	architecture.

o	Move the call to set_cpu_online() into cpu_startup_entry().
	This would require some serious inspection to prove that it is
	safe, assuming that it is in fact safe.

o	Drop the WARN_ON_ONCE() from trc_inspect_reader().  Not all
	that excited by losing this diagnostic, but then again it
	has been awhile since it has caught anything.

o	Make the WARN_ON_ONCE() condition in trc_inspect_reader() instead
	to a "return false" to retry later.  Ditto, also not liking the
	possibility of indefinite deferral with no warning.

There are likely other approaches.

> > My impression is that dropping Liam's patch for the stable release and
> > revisiting it later is a better approach since tiny RCU is used way
> > less in the wild than tree/tasks RCU. Thoughts?
> 
> I think that this one is strange enough that we need to write down the
> situation in detail, make sure we have all the corner cases covered in
> both mainline and -stable, and decide what to do from there.
> 
> Yes, I know, this email thread contains much of this information, but
> a little organizing of it would be good.
> 
> Would you like to put that together, or should I?  If me, I will get
> a draft out by the end of this coming Tuesday, Pacific Time.

And I guess that this is that draft.

It is quite possible that Tasks RCU also has issues with momentary
online non-idleness of non-boot-CPU idle tasks, but checking that is a
task for another time.

							Thanx, Paul

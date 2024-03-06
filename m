Return-Path: <linux-kernel+bounces-93757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F4873430
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6FB1C22313
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A835FBB2;
	Wed,  6 Mar 2024 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4PSjb2q"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4565D750
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720946; cv=none; b=rnKFWZL9scEqvIkFjiHZ8x4dV5c9Ud5yQwcUcmUiSgQmjIhbdWOgU0fZhYDYPxl3RoZvb6q6h3kODOGyoMm70KwBbJPJcMfdr7ZUdavTllrb67kHPLai3/6GLcgg27IkVmxkn7MKAvB9C0hlfgsgzugpgliY8gxsm1PBhDDb334=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720946; c=relaxed/simple;
	bh=1rEWJ0y32itb0wD+A91e8kIfPcTpbdk4HwzKnvVcGks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g93TDNpJmS2uK8WgxbnRDOi5yXbDNcaLDNQgXAoLeJK9lxDXvOqCcVwmzoiBzrxg7te+m7iI6bB3L7QeepmIa4jfz94Osq7HTd/oTsO4gJ/sqQeqEK9dgkIcx53w7ZLWCYEjqElCodTeYF4+1reAjkzntmciP4hao8LCKSOItpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z4PSjb2q; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6082eab17so3183740b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 02:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709720943; x=1710325743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pbEDDUpDwixN7ee9G378S21uFFpj/jAUkLZnJV6WsYI=;
        b=z4PSjb2qee0vc9LfrijOV11GtTUUg+BcBABdHd8dHoydkZOJBHtpQ03vHVmiJXQBmy
         CGFjKUwuc7mWp/FCPbfK/cwBxL8/KeyzV8LUhlYl61wbERN+4k1Os+3xppwrJTHUfznt
         s+qocovPIY/V8dE0alc+0aaPC0A9uGxDi8HeQEPMVhuOrcuy2RL8qzEyrpZb1Wy/jmxo
         +JxwJoL3nZoSfT3ZCLu91ddufoXlxwB1OGoYwTAv+pFG+iHBRLJEiVzUlN7ubwz9ssta
         Mvr5Umr+UBpcDJauHlpPSQ/JodeKtR8o/wYdvLgVyU5W/2vJEUnYIHFhjrj8yGOAGd8+
         0eXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709720943; x=1710325743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbEDDUpDwixN7ee9G378S21uFFpj/jAUkLZnJV6WsYI=;
        b=LKngDC2Fk1Y+8XISpRjk+kJ5kTpI4/+g/SH3/yeMw+rpqymnRvsj1nehK0hl3LQNwm
         OpywlJk0Cj+xYd/z+hGcDT7xtgkP0shv7hwbm9m56k8Sx6tGuS8cS5IQJ+0OWIBJQKR8
         1Hk+qgDWAoFo17WsmOFly2VV0YcdzsDXVcM/TvRosTVFnAamvEh8xw4zVbb6lCO00ZeO
         W9AtxUbka1k6nBwV7AYMFu03hXdwqUTGO3MbC7BH9gHnxNr12cVQ07L5S9ju7KrSKHpm
         9XwHqSiNKONPGWoYrZSvX/5CJ/Jugod2sURiFx0TaKKm+HGMDN5kv3CXrxIy8KNHwvMr
         Lttw==
X-Gm-Message-State: AOJu0YwVjzN8Oepg2R676EwWStLI7VIA9V3KPutvEWDxvhcJBMUDEX2j
	dg9P6sUPykt32whRx6iSktN4MB2DUBneTyOfcqrDUSJ93PRr41/rlLjIjnazUPaHmgaOHygHh0i
	5mlJPFLhTXiZgiBAtttdtV2QujXNzPpxxYqiNYA==
X-Google-Smtp-Source: AGHT+IH+Co7wnYCaVbcXoiOExnp9w7t/+wCnTVwTyg+qbqeg7aWO86bz6NfNRw5NaJtVGJUHBv9nijoH3pab6TDOIWw=
X-Received: by 2002:a05:6a20:8f0c:b0:1a1:4cd2:4398 with SMTP id
 b12-20020a056a208f0c00b001a14cd24398mr4593260pzk.8.1709720943091; Wed, 06 Mar
 2024 02:29:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220171457.703-1-kprateek.nayak@amd.com> <CAKfTPtBqPVQ5bo8HTZ=sPCUTYr48qtH61A8Z1dwCT434O7cSyQ@mail.gmail.com>
 <bf7b4e37-51cf-50d6-dc8e-626f29b5bdd8@amd.com>
In-Reply-To: <bf7b4e37-51cf-50d6-dc8e-626f29b5bdd8@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 6 Mar 2024 11:28:51 +0100
Message-ID: <CAKfTPtCbofSw5eyMNtimRC_ZT66w4727h0w5v73R7bnsQ54ong@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] Introducing TIF_NOTIFY_IPI flag
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Andrew Donnellan <ajd@linux.ibm.com>, 
	Nicholas Miehlbradt <nicholas@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tony Battersby <tonyb@cybernetics.com>, 
	Brian Gerst <brgerst@gmail.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	David Vernet <void@manifault.com>, x86@kernel.org, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-pm@vger.kernel.org, 
	Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 11:18, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Vincent,
>
> Thank you for taking a look at the series.
>
> On 3/6/2024 3:29 PM, Vincent Guittot wrote:
> > Hi Prateek,
> >
> > Adding Julia who could be interested in this patchset. Your patchset
> > should trigger idle load balance instead of newly idle load balance
> > now when the polling is used. This was one reason for not migrating
> > task in idle CPU
>
> Thank you.
>
> >
> > On Tue, 20 Feb 2024 at 18:15, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> >>
> >> Hello everyone,
> >>
> >> [..snip..]
> >>
> >>
> >> Skipping newidle_balance()
> >> ==========================
> >>
> >> In an earlier attempt to solve the challenge of the long IRQ disabled
> >> section, newidle_balance() was skipped when a CPU waking up from idle
> >> was found to have no runnable tasks, and was transitioning back to
> >> idle [2]. Tim [3] and David [4] had pointed out that newidle_balance()
> >> may be viable for CPUs that are idling with tick enabled, where the
> >> newidle_balance() has the opportunity to pull tasks onto the idle CPU.
> >>
> >> Vincent [5] pointed out a case where the idle load kick will fail to
> >> run on an idle CPU since the IPI handler launching the ILB will check
> >> for need_resched(). In such cases, the idle CPU relies on
> >> newidle_balance() to pull tasks towards itself.
> >
> > Calling newidle_balance() instead of the normal idle load balance
> > prevents the CPU to pull tasks from other groups
>
> Thank you for the correction.
>
> >
> >>
> >> Using an alternate flag instead of NEED_RESCHED to indicate a pending
> >> IPI was suggested as the correct approach to solve this problem on the
> >> same thread.
> >>
> >>
> >> Proposed solution: TIF_NOTIFY_IPI
> >> =================================
> >>
> >> Instead of reusing TIF_NEED_RESCHED bit to pull an TIF_POLLING CPU out
> >> of idle, TIF_NOTIFY_IPI is a newly introduced flag that
> >> call_function_single_prep_ipi() sets on a target TIF_POLLING CPU to
> >> indicate a pending IPI, which the idle CPU promises to process soon.
> >>
> >> On architectures that do not support the TIF_NOTIFY_IPI flag (this
> >> series only adds support for x86 and ARM processors for now),
> >
> > I'm surprised that you are mentioning ARM processors because they
> > don't use TIF_POLLING.
>
> Yup I just realised that after Linus Walleij pointed it out on the
> thread.
>
> >
> >> call_function_single_prep_ipi() will fallback to setting
> >> TIF_NEED_RESCHED bit to pull the TIF_POLLING CPU out of idle.
> >>
> >> Since the pending IPI handlers are processed before the call to
> >> schedule_idle() in do_idle(), schedule_idle() will only be called if the
> >> IPI handler have woken / migrated a new task on the idle CPU and has set
> >> TIF_NEED_RESCHED bit to indicate the same. This avoids running into the
> >> long IRQ disabled section in schedule_idle() unnecessarily, and any
> >> need_resched() check within a call function will accurately notify if a
> >> task is waiting for CPU time on the CPU handling the IPI.
> >>
> >> Following is the crude visualization of how the situation changes with
> >> the newly introduced TIF_NOTIFY_IPI flag:
> >> --
> >> CPU0                                                    CPU1
> >> ====                                                    ====
> >>                                                         do_idle() {
> >>                                                                 __current_set_polling();
> >>                                                                 ...
> >>                                                                 monitor(addr);
> >>                                                                 if (!need_resched_or_ipi())
> >>                                                                         mwait() {
> >>                                                                         /* Waiting */
> >> smp_call_function_single(CPU1, func, wait = 1) {                                ...
> >>         ...                                                                     ...
> >>         set_nr_if_polling(CPU1) {                                               ...
> >>                 /* Realizes CPU1 is polling */                                  ...
> >>                 try_cmpxchg(addr,                                               ...
> >>                             &val,                                               ...
> >>                             val | _TIF_NOTIFY_IPI);                             ...
> >>         } /* Does not send an IPI */                                            ...
> >>         ...                                                             } /* mwait exit due to write at addr */
> >>         csd_lock_wait() {                                       ...
> >>         /* Waiting */                                           preempt_fold_need_resched(); /* fold if NEED_RESCHED */
> >>                 ...                                             __current_clr_polling();
> >>                 ...                                             flush_smp_call_function_queue() {
> >>                 ...                                                     func(); /* Will set NEED_RESCHED if sched_ttwu_pending() */
> >>         } /* End of wait */                                     }
> >> }                                                               if (need_resched()) {
> >>                                                                         schedule_idle();
> >> smp_call_function_single(CPU1, func, wait = 1) {                }
> >>         ...                                                     ... /* IRQs remain enabled */
> >>         arch_send_call_function_single_ipi(CPU1); ----------->  /* Processes the IPI */
> >> --
> >>
> >> Results
> >> =======
> >>
> >> With the TIF_NOTIFY_IPI, the time taken to complete a fixed set of IPIs
> >> using ipistorm improves drastically. Following are the numbers from the
> >> same dual socket 3rd Generation EPYC system (2 x 64C/128T) (boost on,
> >> C2 disabled) running ipistorm between CPU8 and CPU16:
> >>
> >> cmdline: insmod ipistorm.ko numipi=100000 single=1 offset=8 cpulist=8 wait=1
> >>
> >>   ==================================================================
> >>   Test          : ipistorm (modified)
> >>   Units         : Normalized runtime
> >>   Interpretation: Lower is better
> >>   Statistic     : AMean
> >>   ==================================================================
> >>   kernel:                               time [pct imp]
> >>   tip:sched/core                        1.00 [0.00]
> >>   tip:sched/core + revert               0.81 [19.36]
> >>   tip:sched/core + TIF_NOTIFY_IPI       0.20 [80.99]
> >>
> >> Same experiment was repeated on an dual socket ARM server (2 x 64C)
> >> which too saw a significant improvement in the ipistorm performance:
> >
> > Could you share more details about this ARM server ? Could it be an Arm64 one ?
> > I was not expecting any change for arm/arm64 which are not using TIF_POLLING
>
> I looked at the lscpu output and it said It was an "aarch64" server with
> model name "Neoverse-N1". Let me go back and test it once again just to
> be sure I did not catch a one off behavior (Might be a while since I
> have limited access to this machine) I'll also add a debug
> WARN_ON_ONCE() to see if "TIF_NOTIF_IPI" is being set.
>
> >
> >
> >>
> >>   ==================================================================
> >>   Test          : ipistorm (modified)
> >>   Units         : Normalized runtime
> >>   Interpretation: Lower is better
> >>   Statistic     : AMean
> >>   ==================================================================
> >>   kernel:                               time [pct imp]
> >>   tip:sched/core                        1.00 [0.00]
> >>   tip:sched/core + TIF_NOTIFY_IPI       0.41 [59.29]
> >>
> >> netperf and tbench results with the patch match the results on tip on
> >> the dual socket 3rd Generation AMD system (2 x 64C/128T). Additionally,
> >> hackbench, stream, and schbench too were tested, with results from the
> >> patched kernel matching that of the tip.
> >>
> >>
> >> Future Work
> >> ===========
> >>
> >> Evaluate impact of newidle_balance() when scheduler tick hits an idle
> >> CPU. The call to newidle_balance() will be skipped with the
> >
> > But it should call the normal idle load balance instead
>
> Yup, but the frequency of normal idle balance will be lower than the
> frequency at which a newidle balance is being triggered currently if
> tick is not disabled right? Please correct me if I'm wrong.

No it should be the same. When a cpu is idle, we do some periodic idle
load balance either directly on the CPU if it has not stopped its tick
or we wakes up one idle CPU to run the idle load balance of all idle
cpus which stopped their tick.

The newidle balance happens when the cpu becomes idle, i.e. when the
current thread is going to sleep and before idle thread becomes the
current.

The newidle balance has some restrictions compared to idle load balance

>
> >
> >> TIF_NOTIFY_IPI solution similar to [2]. Counter argument for the case is
> >> that if the idle state did not set the TIF_POLLING bit, the idle CPU
> >> would not have called schedule_idle() unless the IPI handler set the
> >> NEED_RESCHED bit.
> >>
> >>
> >> Links
> >> =====
> >>
> >> [1] https://github.com/antonblanchard/ipistorm
> >> [2] https://lore.kernel.org/lkml/20240119084548.2788-1-kprateek.nayak@amd.com/
> >> [3] https://lore.kernel.org/lkml/b4f5ac150685456cf45a342e3bb1f28cdd557a53.camel@linux.intel.com/
> >> [4] https://lore.kernel.org/lkml/20240123211756.GA221793@maniforge/
> >> [5] https://lore.kernel.org/lkml/CAKfTPtC446Lo9CATPp7PExdkLhHQFoBuY-JMGC7agOHY4hs-Pw@mail.gmail.com/
> >>
> >> This series is based on tip:sched/core at tag "sched-core-2024-01-08".
> >> [..snip..]
> >>
>
> --
> Thanks and Regards,
> Prateek


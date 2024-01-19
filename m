Return-Path: <linux-kernel+bounces-31088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B1A8328B5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308D61C2295E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1894C62F;
	Fri, 19 Jan 2024 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLvusuJs"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FEB3C68C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705663611; cv=none; b=IDIONmLRAQ0i85dEPqFmHYaldLbP/7fLREdW/09dzeioDL4wwNSO+vmWuj64RNgTzJ2j6Uy/hnbZBJtaWf5RAxtrGhaQ6RieNsCVtt8o6Z82a+FwiVkvEsHrCFYZuk1eArwsqwy5Dnh8WKFpVF37XY9BWHzTZUP7ysY7J6/lquM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705663611; c=relaxed/simple;
	bh=HqPHDKQYSexzdzgAirCoX3CVVkTbqA2yf472mmlYSjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDFHxzhrhIztJsT2BHjqtQ35gpQjc3mZgdcuEM8CdZ9VwLg4LsMTRg5sF+3yQMlGa95qAiUYYOKq86lGADf4J+aRhqJAYDdpUf09YeAlTFoQni+5XuSq1/FccrahDrW4TCWcpEweJ4aOZ/6j5RvCsrhxyHUCNzIrWXv7BVrt10Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CLvusuJs; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6817a4a7bf2so4028326d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705663608; x=1706268408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SDqwGi/6zwjAXt+qVPqrPannGRgBhzkBVpj3uGANZos=;
        b=CLvusuJsCFJFrPtxGwgXF6MGbGlmkL0+rGXPlFl3zbGICRNJxj8Qfq3Q6r3ZPjyJmZ
         +KcA2dO5ZgxXJKZMiYqByiDeeNcI0LvBGSktwD2I8vdad4Q+kNrsmsrusN0WCGz61z6D
         wj+OPXmcwFXD/5Og3+V27EC+57yg7lrYAACkhTQ4kOgXe/GpcMOszdQhSL0UIvX9O5zF
         bFyiMYwHuFVV0xu+JiiMxGXcAFigceTdnaCXXA+WnPngMLk3YIN+aoXwfEdmE0WsY57M
         NHd/UuR0YTVnIdX08WkMabfflNntMmUr/7sAOnWqc/pIncaAjNC+6LjebssTwWifGqZV
         W6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705663608; x=1706268408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDqwGi/6zwjAXt+qVPqrPannGRgBhzkBVpj3uGANZos=;
        b=TSoKODqA5SG7Mt793u/Tfd8AVR9Zs1fvIFR4K1wdeCYBX9nbR0OURfw2BLLzfM/OFL
         iQbxjWklrQAkJD5v37t8Ep/c/OFQv3SyEftuS4S50IyqKqVFE2UWNAxv8OGdWkzEn+81
         ZSw0HBhIUI3OZubRNqdUec+hg2c1HGdep3YubM+zi9qnJLjSpiRWiMoqA+sPbwR1QqJu
         cW/7l/HCAf+h9nriBfP5AO70MwRs77yIAz5nDKfThOHm5Cwuqv4t4CNZT5V4ze8CM86u
         +prvd/V7Waq3CpZepVIiNml/Kwdb/fqcTcFHfCN6bmred7w7sfDfAxGnXpRiE80Wvf43
         tWng==
X-Gm-Message-State: AOJu0YyhbPWnQk8B4fQ4Es7FxeA4vya7w54u8aqZzeAEnf2X/1OKVzOV
	sfg2ztNG2kxdT4sVB0sgRCrEylUjzEPCkosR8X11f2xAFW9KHAMTMGkmJdmClepVBDulxrzNnlb
	sqnLS6I72c9WRXkDfWEQEwKhqUbRdG8r8spuHZw==
X-Google-Smtp-Source: AGHT+IFIJERrdl95MjLMqOrgAOH0xM2KXwkRXhzDcvsRtw6blACBRDWHjnJ0VTXpqtAsW5Ik2dB4gjKa8GfscFh0pKY=
X-Received: by 2002:a0c:da08:0:b0:681:79cf:e6e with SMTP id
 x8-20020a0cda08000000b0068179cf0e6emr1969210qvj.77.1705663608178; Fri, 19 Jan
 2024 03:26:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien>
 <CAKfTPtCRN_eWgVdK2-h6E_ifJKwwJEtMjeNjB=5DXZFWyBS+tQ@mail.gmail.com>
 <93112fbe-30be-eab8-427c-5d4670a0f94e@inria.fr> <CAKfTPtAeFvrZxApK3RruWwCjMxbQvOkU+_YgZSo4QPT_AD6FxA@mail.gmail.com>
 <9dc451b5-9dd8-89f2-1c9c-7c358faeaad@inria.fr> <CAKfTPtDCsLnDnVje9maP5s-L7TbtSu4CvF19xHOxbkvSNd7vZg@mail.gmail.com>
 <2359ab5-4556-1a73-9255-3fcf2fc57ec@inria.fr> <6618dcfa-a42f-567c-2a9d-a76786683b29@inria.fr>
 <CAKfTPtDrULyOB9+RhjoPfCpHKVhx5kRf6dq79DSE6jZgsEairw@mail.gmail.com>
 <edbd8ecd-148c-b366-fd46-3531dec39d49@inria.fr> <cecfd395-f067-99e1-bdd2-fec2ebc3db3@inria.fr>
 <CAKfTPtCAcHuzhcDvry6_nH2K29wc-LEo2yOi-J-mnZkwMvGDbw@mail.gmail.com>
 <cfae246d-9383-59d-ee5b-81ea3dd0a795@inria.fr> <CAKfTPtD0B29zadkeEOCWvry123zWVEEm41ouKj7noXwQdoh2+Q@mail.gmail.com>
 <7a845b43-bd8e-6c7d-6bca-2e6f174f671@inria.fr> <36f2cc93-db10-5977-78ab-d9d07c3f445@inria.fr>
 <CAKfTPtA31Z0N9hd4z_GPvoZwK=KTf4fPbx_jDbK653mdVDLEbw@mail.gmail.com> <alpine.DEB.2.22.394.2401182304170.3296@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2401182304170.3296@hadrien>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 19 Jan 2024 12:26:35 +0100
Message-ID: <CAKfTPtC9Px_W84YRJqnFNkL8oofO15D-P=VTCMUUu7NJr+xwBA@mail.gmail.com>
Subject: Re: EEVDF and NUMA balancing
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jan 2024 at 23:13, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Thu, 18 Jan 2024, Vincent Guittot wrote:
>
> > Hi Julia,
> >
> > Sorry for the delay. I have been involved on other perf regression
> >
> > On Fri, 5 Jan 2024 at 18:27, Julia Lawall <julia.lawall@inria.fr> wrote:
> > >
> > >
> > >
> > > On Fri, 5 Jan 2024, Julia Lawall wrote:
> > >
> > > >
> > > >
> > > > On Fri, 5 Jan 2024, Vincent Guittot wrote:
> > > >
> > > > > On Fri, 5 Jan 2024 at 15:51, Julia Lawall <julia.lawall@inria.fr> wrote:
> > > > > >
> > > > > > > Your system is calling the polling mode and not the default
> > > > > > > cpuidle_idle_call() ? This could explain why I don't see such problem
> > > > > > > on my system which doesn't have polling
> > > > > > >
> > > > > > > Are you forcing the use of polling mode ?
> > > > > > > If yes, could you check that this problem disappears without forcing
> > > > > > > polling mode ?
> > > > > >
> > > > > > I expanded the code in do_idle to:
> > > > > >
> > > > > >                 if (cpu_idle_force_poll) { c1++;
> > > > > >                         tick_nohz_idle_restart_tick();
> > > > > >                         cpu_idle_poll();
> > > > > >                 } else if (tick_check_broadcast_expired()) { c2++;
> > > > > >                         tick_nohz_idle_restart_tick();
> > > > > >                         cpu_idle_poll();
> > > > > >                 } else { c3++;
> > > > > >                         cpuidle_idle_call();
> > > > > >                 }
> > > > > >
> > > > > > Later, I have:
> > > > > >
> > > > > >         trace_printk("force poll: %d: c1: %d, c2: %d, c3: %d\n",cpu_idle_force_poll, c1, c2, c3);
> > > > > >         flush_smp_call_function_queue();
> > > > > >         schedule_idle();
> > > > > >
> > > > > > force poll, c1 and c2 are always 0, and c3 is always some non-zero value.
> > > > > > Sometimes small (often 1), and sometimes large (304 or 305).
> > > > > >
> > > > > > So I don't think it's calling cpu_idle_poll().
> > > > >
> > > > > I agree that something else
> > > > >
> > > > > >
> > > > > > x86 has TIF_POLLING_NRFLAG defined to be a non zero value, which I think
> > > > > > is sufficient to cause the issue.
> > > > >
> > > > > Could you trace trace_sched_wake_idle_without_ipi() ans csd traces as well ?
> > > > > I don't understand what set need_resched() in your case; having in
> > > > > mind that I don't see the problem on my Arm systems and IIRC Peter
> > > > > said that he didn't face the problem on his x86 system.
> > > >
> > > > TIF_POLLING_NRFLAG doesn't seem to be defined on Arm.
> > > >
> > > > Peter said that he didn't see the problem, but perhaps that was just
> > > > random.  It requires a NUMA move to occur.  I make 20 runs to be sure to
> > > > see the problem at least once.  But another machine might behave
> > > > differently.
> > > >
> > > > I believe the call chain is:
> > > >
> > > > scheduler_tick
> > > >   trigger_load_balance
> > > >     nohz_balancer_kick
> > > >       kick_ilb
> > > >         smp_call_function_single_async
> > > >           generic_exec_single
> > > >             __smp_call_single_queue
> > > >               send_call_function_single_ipi
> > > >                 call_function_single_prep_ipi
> > > >                   set_nr_if_polling <====== sets need_resched
> > > >
> > > > I'll make a trace to reverify that.
> > >
> > > This is what I see at a tick, which corresponds to the call chain shown
> > > above:
> > >
> > >           bt.B.x-4184  [046]   466.410605: bputs:                scheduler_tick: calling trigger_load_balance
> > >           bt.B.x-4184  [046]   466.410605: bputs:                trigger_load_balance: calling nohz_balancer_kick
> > >           bt.B.x-4184  [046]   466.410605: bputs:                trigger_load_balance: calling kick_ilb
> > >           bt.B.x-4184  [046]   466.410607: bprint:               trigger_load_balance: calling smp_call_function_single_async 22
> > >           bt.B.x-4184  [046]   466.410607: bputs:                smp_call_function_single_async: calling generic_exec_single
> > >           bt.B.x-4184  [046]   466.410607: bputs:                generic_exec_single: calling __smp_call_single_queue
> > >           bt.B.x-4184  [046]   466.410608: bputs:                __smp_call_single_queue: calling send_call_function_single_ipi
> > >           bt.B.x-4184  [046]   466.410608: bputs:                __smp_call_single_queue: calling call_function_single_prep_ipi
> > >           bt.B.x-4184  [046]   466.410608: bputs:                call_function_single_prep_ipi: calling set_nr_if_polling
> > >           bt.B.x-4184  [046]   466.410609: sched_wake_idle_without_ipi: cpu=22
> >
> > I don't know if you have made progress on this in the meantime.
> >
> > Regarding the trace above, do you know if anything happens on CPU22
> > just before the scheduler tried to kick the ILB on it ?
> >
> > Have you found why TIF_POLLING_NRFLAG seems to be always set when the
> > kick_ilb happens ? It should be cleared once entering the idle state.
>
> I haven't figured out everything, but the attached graph shows
> that TIF_POLLING_NRFLAG is not always set.  Sometimes it is and sometimes
> it isn't.
>
> In the graph, on core 57, the blue box and the green x are before and
> after the call to cpuidle_idle_call(), resplectively.  One can't see it in
> this graph, but the green x comes before the blue box.  So almost all of
> the time, it is in cpuidle_idle_call(), only in the tiny gap between the x
> and the box is it back in do_idle with TIF_POLLING_NRFLAG set.
>
> Afterwards, there is a diamond for the polling case and a triangle for the
> non polling case.  These also occur on clock ticks, and may be
> microscopically closer to (polling) or further from (not polling) the
> green x and blue box.

Your problem really looks like weird timing.

It would be good to know which idle states are selected ? or even
better if it's possible, disable all but one idle state and see if one
idle state in particular trigger your problem

idle state can be disable here :
echo 1 > /sys/devices/system/cpu/cpu*/cpuidle/state*/disable

One possible sequence:
tick is not stopped on the idle cpu
tick fires on busy and idle cpus
idle cpu wakes up and the wake up time varies depending of wakeup
latency of the entered c-state
busy cpu executes call_function_single_prep_ipi() and idle cpu could
be already woken or not depending of the time to wake up

>
> I haven't yet studied what happens afterwards in the non polling case.

Side point, according to your trace above, you can 2 consecutives real
idle load balance so the patch that I proposed, should be able to
trigger active migration because the nr_balance_failed will be != 0
the 2nd idle load balance. Are I missing something ?

Vincent
>
> julia
>
> >
> > Could you check your cpuidle driver ?
> >
> > Vincent
> >
> > >
> > > julia
> >


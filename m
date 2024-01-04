Return-Path: <linux-kernel+bounces-16923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 715E3824621
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA40E1F2117C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA7924B35;
	Thu,  4 Jan 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRsSNgQo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C999E24B2C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9af1f12d5so480011b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 08:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704385630; x=1704990430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FnYAokOhwR9OqZmkxeqPvu/rT3S42+z3MXWvmRmQ4QQ=;
        b=CRsSNgQoxR8wM0eATvfuIWg7h+ooIQoG9a4vfS47PdXO0RZCeyw2mRc+WhKF9jlQLa
         GMHlewS3iJoQoV5fUS0vOi94gHWSJfSe6HOT15k1meCzLJ5O+C3h+NB/dpuVEs8LGv1f
         6FZPM1ar7pSEX/4gzFlYetAXrKGEu/pq7bbz19qkCJ5hpcscAg5ZKDpgQFJjqbKZn8Xg
         +S2mLC4w4seGfRy5ZFI/3Fc3LrNy8HNJh7kcA0RKul6mVEhWb6lj/mtzS1LKhnatW9g1
         RjLPUuC9XQIdCKKqQTJnpue3kpTInvHPeoK1MbJzvnDKNn0P/4jQ+G6VNQS3n1p6MOT6
         Ys0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704385630; x=1704990430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnYAokOhwR9OqZmkxeqPvu/rT3S42+z3MXWvmRmQ4QQ=;
        b=vKB/32ZmNo5+3hAA3EhkAfftGf7Hx9+aven7TvZ1x1NwM7vAA84guwTyMR49jP1Hgh
         RT86PGH24gHdaHK9/sVKv1FFVZ13yi20fKCpCezHmC2IvMfW7HBpsdkwRQ7IZOBSmwc2
         WefmXRRZU7BCx8acA1vaM5wER45RpzOZRJvlW9puXjzutxOSEZnt7maKN0eDgqQDl59u
         HqF8canqq0ANBSFq9gZqUgg7LqaPniInRbZXMX8cO8p3zLBeV4RorjxrJbDlOlgWSSZ7
         ZCWneN6jEzobjCyrvqlemLVbkpD4NAp9P7Xy6O2gjTGNQO2mOIz+3SanOvrw/w2I2T7B
         eDng==
X-Gm-Message-State: AOJu0Yz/h8BnDW2tG9Hmg45TpW/oH0KD6JRIw1qz6LLBv18PQTQeDq5M
	Rlf/sbSmhaAHTnPyLrTJR3hLjqXPdUFQJQ3HDNJ6DppaMX8wXA==
X-Google-Smtp-Source: AGHT+IHxNDL2SCklXExrZBno6wrVarH3D+WkSYzCdxI/W6IebtqJZR+DyujGCrzA8xMpDshpkAzNcAMO/Dk/rzlXP1I=
X-Received: by 2002:a62:5f82:0:b0:6da:13bc:fb4d with SMTP id
 t124-20020a625f82000000b006da13bcfb4dmr843842pfb.47.1704385630172; Thu, 04
 Jan 2024 08:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien>
 <alpine.DEB.2.22.394.2310041958380.3108@hadrien> <20231009102949.GC14330@noisy.programming.kicks-ass.net>
 <b8ab29de-1775-46e-dd75-cdf98be8b0@inria.fr> <CAKfTPtBhWwk9sf9F1=KwubiAWFDC2A9ZT-SSJ+tgFxme1cFmYA@mail.gmail.com>
 <alpine.DEB.2.22.394.2312182302310.3361@hadrien> <CAKfTPtALEFtrapi3Kk97KLGQN4259eEQEwwftVUK4RG42Vgoyw@mail.gmail.com>
 <98b3df1-79b7-836f-e334-afbdd594b55@inria.fr> <CAKfTPtCRN_eWgVdK2-h6E_ifJKwwJEtMjeNjB=5DXZFWyBS+tQ@mail.gmail.com>
 <93112fbe-30be-eab8-427c-5d4670a0f94e@inria.fr> <CAKfTPtAeFvrZxApK3RruWwCjMxbQvOkU+_YgZSo4QPT_AD6FxA@mail.gmail.com>
 <9dc451b5-9dd8-89f2-1c9c-7c358faeaad@inria.fr> <CAKfTPtDCsLnDnVje9maP5s-L7TbtSu4CvF19xHOxbkvSNd7vZg@mail.gmail.com>
 <2359ab5-4556-1a73-9255-3fcf2fc57ec@inria.fr> <6618dcfa-a42f-567c-2a9d-a76786683b29@inria.fr>
 <CAKfTPtDrULyOB9+RhjoPfCpHKVhx5kRf6dq79DSE6jZgsEairw@mail.gmail.com>
 <edbd8ecd-148c-b366-fd46-3531dec39d49@inria.fr> <cecfd395-f067-99e1-bdd2-fec2ebc3db3@inria.fr>
In-Reply-To: <cecfd395-f067-99e1-bdd2-fec2ebc3db3@inria.fr>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 4 Jan 2024 17:26:57 +0100
Message-ID: <CAKfTPtCAcHuzhcDvry6_nH2K29wc-LEo2yOi-J-mnZkwMvGDbw@mail.gmail.com>
Subject: Re: EEVDF and NUMA balancing
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Dec 2023 at 16:18, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Thu, 28 Dec 2023, Julia Lawall wrote:
>
> > > > > > > > I'm surprised that you have mainly CPU_NEWLY_IDLE. Do you know the reason ?
> > > > > > >
> > > > > > > No.  They come from do_idle calling the scheduler.  I will look into why
> > > > > > > this happens so often.
> > > > > >
> > > > > > Hmm, the CPU was idle and received a need resched which triggered the
> > > > > > scheduler but there was nothing to schedule so it goes back to idle
> > > > > > after running a newly_idle _load_balance.
> > > > >
> > > > > I spent quite some time thinking the same until I saw the following code
> > > > > in do_idle:
> > > > >
> > > > > preempt_set_need_resched();
> > > > >
> > > > > So I have the impression that do_idle sets need resched itself.
> > > >
> > > > But of course that code is only executed if need_resched is true.  But I
> > >
> > > Yes, that is your root cause. something, most probably in interrupt
> > > context, wakes up your CPU and expect to wake up a thread
> > >
> > > > don't know who would be setting need resched on each clock tick.
> > >
> > > that can be a timer, interrupt, ipi, rcu ...
> > > a trace should give you some hints
> >
> > I have the impression that it is the goal of calling nohz_csd_func on each
> > clock tick that causes the calls to need_resched.  If the idle process is
> > polling, call_function_single_prep_ipi just sets need_resched to get the

Your system is calling the polling mode and not the default
cpuidle_idle_call() ? This could explain why I don't see such problem
on my system which doesn't have polling

Are you forcing the use of polling mode ?
If yes, could you check that this problem disappears without forcing
polling mode ?

> > idle process to stop polling.  But there is no actual task that the idle
> > process should schedule.  The need_resched then prevents the idle process
> > from stealing, due to the CPU_NEWLY_IDLE flag, contradicting the whole
> > purpose of calling nohz_csd_func in the first place.

Do I understand correctly that your sequence is :
CPU A                                  CPU B
cpu enters idle
do_idle()
  ...
  loop in cpu_idle_poll
  ...
                                       kick_ilb on CPU A
                                         send_call_function_single_ipi
                                           set_nr_if_polling
                                             set TIF_NEED_RESCHED

  exit polling loop
exit while (!need_resched())

call nohz_csd_func but
  need_resched is true so it's a nope

pick_next_task_fair
  newidle_balance
    load_balance(CPU_NEWLY_IDLE)


>
> Looking in more detail, do_idle contains the following after existing the
> polling loop:
>
>         flush_smp_call_function_queue();
>         schedule_idle();
>
> flush_smp_call_function_queue() does end up calling nohz_csd_func, but
> this has no impact, because it first checks that need_resched() is false,
> whereas it is currently true to cause existing the polling loop.  Removing
> that test causes:
>
> raise_softirq_irqoff(SCHED_SOFTIRQ);
>
> but that causes the load balancing code to be executed from a ksoftirqd
> task, which means that there is now no load imbalance.
>
> So the only chance to detect an imbalance does seem to be to have the load
> balance call be executed by the idle task, via schedule_idle(), as is
> done currently.  But that leads to the core being considered to be newly
> idle.
>
> julia
>
>


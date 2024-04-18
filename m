Return-Path: <linux-kernel+bounces-149453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227748A914B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1D6282AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0334F5EC;
	Thu, 18 Apr 2024 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no0KAk0I"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429E13A27E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713408661; cv=none; b=sQg1UZH5Kf4yj5d8Q674lt5HyVgmtf/8fExApbV0wcSFNgt/HdbBaZ+CUX1ZD9DHqYsn1wwkNANniP6BBgkbn8iQXsOFJHQPcOhEuiNbPXUq2A9Q8WaOJ6NChqqdnKm1G2f3NFhwGd/iahqqwGhN9ssOkXl+MW87LmIrvO9e/Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713408661; c=relaxed/simple;
	bh=Qa1BZlUYuZHOYV+NVXE2hHo1yuuynsOgFFRA9Z8Hqyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJhYlBKrwoXowTK69xgGPNf75H/hM+sn7QnQL1dDraUIi73lJ4E8CX3GrOaUgrIHryNys8GiVT5An5rn5xf8K5oGUUoOv7+axTt1MS4vjE2RKaLz8voHI+clCqWtEdYHTQNfyM8Fw9o4A9dezwsROoHbI1nGAoegwD7YE8bB3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no0KAk0I; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-22fa7e4b0beso273164fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713408658; x=1714013458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaepHLljVpGyk/mFkMGOIy6ak+RsQmuvWbFo4fYn+EY=;
        b=no0KAk0Ib/GOx86WXa3IRqPPD/dMPXZOj2hWym6wdGsUWDM68AiOOv6sU14LryR6cJ
         WT6+aS2SHeDdatIooGs4v8N/H/p+z29/S0RiZ6zz8T0yCNtgnabjto/ur2+zGqT4zZXN
         EfW9r/0uDp5ORfYleY6/qbKSZuMmj9lqzM/2pfDpS3op0fJ4O3Rn7N1fimMavf7gNAcu
         Hsmj80vQFkNPlx/kIXclo7luF5fbWdCIRJfp24iVibiwlIHl33Xd7uw8HaSCopTCKjhh
         VpqDxHbmDGfe+W8n0zW/NkGkrjXqL9VaKBeuQQRCfU7u60X67tF/2Pg2qlSMLiR8My4B
         tqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713408658; x=1714013458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gaepHLljVpGyk/mFkMGOIy6ak+RsQmuvWbFo4fYn+EY=;
        b=kySxfPO9R6R3+NEz8S3kvvXXetaDdrCBxGCydWxHHzpMNeLRPXIEc5iosT2iFbjJmH
         4Wlp4Xtx0stWzx6SEkEZFsYKqouQ68s78VEnxJFARYWBHqR6AO7FuUQQKA6hNrLYHV1c
         AOCSu1GuT6PMrvKkM5fyGNqj0/XhqCaL+WH3j7G5rd33I5sh2N+3NNM/qZRMbjjOWdfX
         8e7PBb6AFAazVZZB7MD8cCJ5dfyWWr1Io7P1mH1DYGc/9NBkMF1h2HbwAUy8v2POnE+n
         ZHExxwEIF+j6q374cg5/7Q6pOnstQKoUwhYS/Ir23nyY7zRerbuKviulXzMXTy/AQdIM
         PFvg==
X-Forwarded-Encrypted: i=1; AJvYcCXCM6fj/dl/5/q7BtT0DJVCfRowjdydhekNbw3psOqDU0Tz19wb3xayr4c/63p1ux5nXazoFl/6ZGo21NcYI8I8LWHXw0881aryFt2O
X-Gm-Message-State: AOJu0YwDeN8IUlLykQrizDfph4y4a9CmCv9f7q/RYgswwgafydEXubn7
	+qDyPSbyGkhxzz+1Dnxd6yutjKdJXtOt6Q7SD3eqspQrakA/z9cRMg9+J4PAZrO8ZBLs0b2lrM5
	NVKLqhLNA/hNDdZotvNbH2nloI44=
X-Google-Smtp-Source: AGHT+IF5mPRQcTRK9N7bfgokeGGNrIhJ7XjmKEsj73TBro3T+oTewRdisERPYvEKOIa1VfZAsUQh9bPrOeFjFnjvc5c=
X-Received: by 2002:a05:6870:8327:b0:22e:9e53:3fd2 with SMTP id
 p39-20020a056870832700b0022e9e533fd2mr1700537oae.28.1713408658235; Wed, 17
 Apr 2024 19:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130080643.1828-1-xuewen.yan@unisoc.com> <20240408120604.GH21904@noisy.programming.kicks-ass.net>
In-Reply-To: <20240408120604.GH21904@noisy.programming.kicks-ass.net>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 18 Apr 2024 10:50:47 +0800
Message-ID: <CAB8ipk8KL=1dT36OhyJfzVBTkOMn8CxiwO0J_ocdHAUm2aqe4g@mail.gmail.com>
Subject: Re: [PATCH] sched/eevdf: Prevent vlag from exceeding the limit value
To: Peter Zijlstra <peterz@infradead.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	wuyun.abel@bytedance.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org, 
	Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Sorry for the late reply.

On Mon, Apr 8, 2024 at 8:06=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Tue, Jan 30, 2024 at 04:06:43PM +0800, Xuewen Yan wrote:
> > There are some scenarios here that will cause vlag to
> > exceed eevdf's limit.
> >
> > 1. In set_next_entity, it will stash a copy of deadline
> > at the point of pick in vlag, and if the task fork child,
> > the child's vlag would inherit parent's vlag, as a result,
> > the child's vlag is equal to the deadline. And then,
> > when place_entity, because the se's vlag is wrong, it would
> > cause vruntime and deadline update error.
>
> But __sched_fork() clears it? Or am I missing something subtle?

Yes, you are right, I missed the __sched_fork().

>
> > 2. When reweight_entity, the vlag would be recalculated,
> > because the new weights are uncertain, and it may cause
> > the vlag to exceed eevdf's limit.
> >
> > In order to ensure that vlag does not exceed the limit,
> > separate the calculation of limit from the update_entity_lag
> > and create a new func limit_entity_lag. When the vlag is
> > updated, use this func to prevent vlag from exceeding the limit.
> >
> > And add check whether the se is forked in place_entity, and calc
> > the curr's vlag to update the se's vlag.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/sched/fair.c | 28 +++++++++++++++++++++++++---
> >  1 file changed, 25 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 533547e3c90a..3fc99b4b8b41 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -696,15 +696,22 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
> >   *
> >   * XXX could add max_slice to the augmented data to track this.
> >   */
> > +static s64 limit_entity_lag(struct sched_entity *se, s64 lag)
> > +{
> > +     s64 limit;
> > +
> > +     limit =3D calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se)=
;
> > +     return clamp(lag, -limit, limit);
> > +}
>
> I used to run with a trace_printk() in there to check how often this
> trips, can you readily trigger these sites, or do you have to work hard
> at it?

I can trigger this easily. And I add dump_stack, the case is much:

[   11.372967] Call trace:
[   11.372971] dump_backtrace+0xec/0x138
[   11.372990] show_stack+0x18/0x24
[   11.372995] dump_stack_lvl+0x60/0x84
[   11.373002] dump_stack+0x18/0x24
[   11.373007] place_entity+0x210/0x25c
[   11.373015] enqueue_task_fair+0x1e0/0x658
[   11.373021] enqueue_task+0x94/0x188
[   11.373028] ttwu_do_activate+0xb4/0x27c
[   11.373034] try_to_wake_up+0x2fc/0x800
[   11.373040] wake_up_q+0x70/0xd8
[   11.373046] futex_wake+0x1e4/0x32c
[   11.373052] do_futex+0x144/0x27c
[   11.373056] __arm64_sys_futex_time32+0xa8/0x1b8
[   11.373061] invoke_syscall+0x58/0x114
[   11.373068] el0_svc_common+0xac/0xe0
[   11.373074] do_el0_svc_compat+0x1c/0x28
[   11.373079] el0_svc_compat+0x38/0x6c
[   11.373085] el0t_32_sync_handler+0x60/0x8c
[   11.373091] el0t_32_sync+0x1ac/0x1b0
[   11.373097] the lag=3D4562177811 vruntime=3D18058609737 limit=3D30719999=
98

[   38.778444] Call trace:
[   38.778447] dump_backtrace+0xec/0x138
[   38.778465] show_stack+0x18/0x24
[   38.778470] dump_stack_lvl+0x60/0x84
[   38.778479] dump_stack+0x18/0x24
[   38.778484] place_entity+0x210/0x25c
[   38.778492] enqueue_task_fair+0x1e0/0x658
[   38.778498] enqueue_task+0x94/0x188
[   38.778505] ttwu_do_activate+0xb4/0x27c
[   38.778512] try_to_wake_up+0x2fc/0x800
[   38.778518] wake_up_process+0x18/0x28
[   38.778523] hrtimer_wakeup+0x20/0x94
[   38.778530] __hrtimer_run_queues+0x19c/0x39c
[   38.778536] hrtimer_interrupt+0xdc/0x39c
[   38.778541] arch_timer_handler_phys+0x50/0x64
[   38.778549] handle_percpu_devid_irq+0xb4/0x258
[   38.778556] generic_handle_domain_irq+0x44/0x60
[   38.778563] gic_handle_irq+0x4c/0x114
[   38.778568] call_on_irq_stack+0x3c/0x74
[   38.778573] do_interrupt_handler+0x4c/0x84
[   38.778580] el0_interrupt+0x54/0xe4
[   38.778586] __el0_irq_handler_common+0x18/0x28
[   38.778591] el0t_64_irq_handler+0x10/0x1c
[   38.778596] el0t_64_irq+0x1a8/0x1ac
[   38.778602] the lag=3D-993821948 vruntime=3D162909998203 limit=3D8777142=
84

[   41.205507] Call trace:
[   41.205508] dump_backtrace+0xec/0x138
[   41.205516] show_stack+0x18/0x24
[   41.205518] dump_stack_lvl+0x60/0x84
[   41.205523] dump_stack+0x18/0x24
[   41.205526] place_entity+0x210/0x25c
[   41.205530] enqueue_task_fair+0x1e0/0x658
[   41.205533] enqueue_task+0x94/0x188
[   41.205537] ttwu_do_activate+0xb4/0x27c
[   41.205540] try_to_wake_up+0x2fc/0x800
[   41.205543] default_wake_function+0x20/0x38
[   41.205547] autoremove_wake_function+0x18/0x7c
[   41.205551] receiver_wake_function+0x28/0x38
[   41.205555] __wake_up_common+0xe8/0x188
[   41.205558] __wake_up_sync_key+0x88/0x144
[   41.205561] sock_def_readable+0xb4/0x1ac
[   41.205565] unix_dgram_sendmsg+0x5b4/0x764
[   41.205569] sock_write_iter+0xe0/0x160
[   41.205571] do_iter_write+0x210/0x338
[   41.205575] do_writev+0xd8/0x198
[   41.205577] __arm64_sys_writev+0x20/0x30
[   41.205581] invoke_syscall+0x58/0x114
[   41.205584] el0_svc_common+0x80/0xe0
[   41.205588] do_el0_svc+0x1c/0x28
[   41.205591] el0_svc+0x3c/0x70
[   41.205594] el0t_64_sync_handler+0x68/0xbc
[   41.205597] el0t_64_sync+0x1a8/0x1ac
[   41.205599] the lag=3D-7374172458 vruntime=3D209576555829 limit=3D307199=
9998

[   41.416780] Call trace:
[   41.416781] dump_backtrace+0xec/0x138
[   41.416788] show_stack+0x18/0x24
[   41.416791] dump_stack_lvl+0x60/0x84
[   41.416797] dump_stack+0x18/0x24
[   41.416799] place_entity+0x210/0x25c
[   41.416804] enqueue_task_fair+0x1e0/0x658
[   41.416807] enqueue_task+0x94/0x188
[   41.416811] ttwu_do_activate+0xb4/0x27c
[   41.416814] try_to_wake_up+0x2fc/0x800
[   41.416818] default_wake_function+0x20/0x38
[   41.416821] autoremove_wake_function+0x18/0x7c
[   41.416825] __wake_up_common+0xe8/0x188
[   41.416828] __wake_up_sync_key+0x88/0x144
[   41.416831] __wake_up_sync+0x14/0x24
[   41.416834] binder_transaction+0x1794/0x1e98
[   41.416838] binder_ioctl_write_read+0x590/0x3950
[   41.416841] binder_ioctl+0x1ec/0xa40
[   41.416844] __arm64_sys_ioctl+0xa8/0xe4
[   41.416849] invoke_syscall+0x58/0x114
[   41.416853] el0_svc_common+0x80/0xe0
[   41.416857] do_el0_svc+0x1c/0x28
[   41.416860] el0_svc+0x3c/0x70
[   41.416868] the lag=3D3625583753 vruntime=3D254849351272 limit=3D3071999=
998
[   41.416863] el0t_64_sync_handler+0x68/0xbc
[   41.416866] el0t_64_sync+0x1a8/0x1ac

Thanks!
BR

---
xuewen

>
>
> >  static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_enti=
ty *se)
> >  {
> > -     s64 lag, limit;
> > +     s64 lag;
> >
> >       SCHED_WARN_ON(!se->on_rq);
> >       lag =3D avg_vruntime(cfs_rq) - se->vruntime;
> >
> > -     limit =3D calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se)=
;
> > -     se->vlag =3D clamp(lag, -limit, limit);
> > +     se->vlag =3D limit_entity_lag(se, lag);
> >  }
> >
> >  /*
> > @@ -3757,6 +3764,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq,=
 struct sched_entity *se,
> >       if (avruntime !=3D se->vruntime) {
> >               vlag =3D (s64)(avruntime - se->vruntime);
> >               vlag =3D div_s64(vlag * old_weight, weight);
> > +             vlag =3D limit_entity_lag(se, vlag);
> >               se->vruntime =3D avruntime - vlag;
> >       }
> >
> > @@ -3804,6 +3812,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq=
, struct sched_entity *se,
> >
> >       update_load_set(&se->load, weight);
> >
> > +     if (!se->on_rq)
> > +             se-vlag =3D limit_entity_lag(se, se->vlag);
> > +
> >  #ifdef CONFIG_SMP
> >       do {
> >               u32 divider =3D get_pelt_divider(&se->avg);
>
> > @@ -5237,6 +5258,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_=
entity *se, int flags)
> >               if (WARN_ON_ONCE(!load))
> >                       load =3D 1;
> >               lag =3D div_s64(lag, load);
> > +             lag =3D limit_entity_lag(se, lag);
> >       }
> >
> >       se->vruntime =3D vruntime - lag;
> > --
> > 2.25.1
> >


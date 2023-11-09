Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67BA7E63FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 07:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjKIGif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 01:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjKIGid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 01:38:33 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF2225AC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 22:38:31 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1e9c9d181d6so326423fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 22:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699511911; x=1700116711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kksALbMgAHmmTJWVEudCC6iY847BSNybHcn4JTkNkc=;
        b=RDUODXDSxIDfmyv/kIU8+vrhKEEKQDEt6qispFFVbPMxJk7ST8Yp4gNBxLsA1Mx+AM
         9NvhKl3bwqYcoUxgbTV+iCzyG93TgPXoqhsi2aiDgoXVAaM1nioIZbQqUxDWGVQ9nwGk
         nSeOElGWykfV0K0Mq8/kaUbStKGb0HQ3QjQoK+DogQlB4GlGo/r+zQHo0KplzM3ircL5
         2HcVYn9s2hjDwovDlS8PFbvCNP8XSdI4lq/MtPLmHtgbMrm7prt/w/ARpka0H2rxjlBO
         34lP53f4ePb5Pnc5/qq/jAMb3OT+l7bvUgm6sGwMYHMB2UBsEG/AoPwNpUAvPbPgJXGR
         +L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699511911; x=1700116711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kksALbMgAHmmTJWVEudCC6iY847BSNybHcn4JTkNkc=;
        b=lAnpWVHJ98TvG3xORF/6ceTYtzJH20Ka6YeLaEAdX/vgpCEaKekRblUWXaUUze+2k9
         H3Jd5NpdbLeZJu3qOSm6VZMIHUyElw1u5IyzyCepEXhvkkWGDpJ6EOk4+YmWCoS3uavA
         QD4lFxzdzURFlyMeeri3k8jCKeag3AYXG1xF3Wcaj1lTEqPbvkH2KiyhfnAp8aRv1bx1
         0QQqMByfzmCWCjY/R93mdpnejr5zxeLWOuPlVuOloDDBVtMfAkMzS6wguEhtp/i3vl/n
         C+9yAeljZPsbupEEArvDbtAZcreE853pVh1G6hXht8v74Hdg+geVj5+rpnnMQHrVWQPT
         TwmA==
X-Gm-Message-State: AOJu0YxL7o+48r0Ohy5fuFCHeABJQSWZFOKvxzDjLnqWqm745QTPX0Hw
        NoT2yunR79syXLT2+F+xtyc93UVwLjFMgvC21T8=
X-Google-Smtp-Source: AGHT+IGJGmV+wofGJgHhYcnVwKgvOrdGdDD5Py4hIHU+6Yqtzf6L7VVbDlNsWEHazkH87FgDTOpgFpuJjVD6uKCcx14=
X-Received: by 2002:a05:6870:9710:b0:1e9:e063:ca6b with SMTP id
 n16-20020a056870971000b001e9e063ca6bmr4215423oaq.32.1699511910697; Wed, 08
 Nov 2023 22:38:30 -0800 (PST)
MIME-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com> <20231106193524.866104-19-jstultz@google.com>
 <CAB8ipk8faF30V8_maGiB62adBg6PLfynGg3p6PBoGJO_rzS7_Q@mail.gmail.com> <CANDhNCoqx-5PUB63Px8OuZnSrYsFzzMBFRrRZ7b72CbPOe9W9g@mail.gmail.com>
In-Reply-To: <CANDhNCoqx-5PUB63Px8OuZnSrYsFzzMBFRrRZ7b72CbPOe9W9g@mail.gmail.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Thu, 9 Nov 2023 14:38:19 +0800
Message-ID: <CAB8ipk9Mye4t=wuSwF-xqJJ36BUxfW2wqb1k_6BCVrKqc4hTFg@mail.gmail.com>
Subject: Re: [PATCH v6 18/20] sched: Handle blocked-waiter migration (and
 return migration)
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        Qais Yousef <qyousef@layalina.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 2:08=E2=80=AFPM John Stultz <jstultz@google.com> wro=
te:
>
> On Wed, Nov 8, 2023 at 9:32=E2=80=AFPM Xuewen Yan <xuewen.yan94@gmail.com=
> wrote:
> > I understand what you mean here. But I have some other worries:
> > considering the scenario of Big-Little cpu topology, when EAS is in
> > effect.
> > If the owner is a "small task", and the owner is on a small core, and
> > the blocked task is a "big task", the block task will be directly
> > migrated to the small core,
> > and because the task is on rq, when wake up, it would skip the
> > =E2=80=9Cselect_task_rq=E2=80=9D and put it directly on the small core.
> > As a result, the big task's performance may decrease.
> > The same reason, a small task may be placed on the big core, and there
> > may be a regression in power consumption.
> >
> ...
> > > +static inline bool proxy_return_migration(struct rq *rq, struct rq_f=
lags *rf,
> > > +                                         struct task_struct *next)
> > > +{
> > > +       if (!sched_proxy_exec())
> > > +               return false;
> > > +
> > > +       if (next->blocked_on && next->blocked_on_waking) {
> > > +               if (!is_cpu_allowed(next, cpu_of(rq))) {
> >
> >
> > Based on the above reasons, could this be changed to the following?
> >                 /* When EAS enabled, we hope the task selects the cpu a=
gain */
> >                  if (sched_energy_enabled() || !is_cpu_allowed(next,
> > cpu_of(rq)) )
>
> Hey! Thanks so much for the feedback and review!
>
> That is a good point, this would cause a misplacement on the lock
> handoff.  Though I fret having to run through the return migration
> lock juggling here for every blocked_on wakeup would further hurt
> performance as well.
>
> I'm currently trying to see if I can extend the blocked_on_waking flag
> to keep more state (BLOCKED, WAKING, RUNNABLE) so that we can move the
> return migration back to the the try_to_wake_up() call path, while
> avoiding the task from becoming suddenly runnable on wakeup while on
> the wrong runqueue.  This would avoid the lock juggling as we'd
> already have the pi_lock. Though I'm a little hesitant as doing the
> deactivate()/select_task_rq()/activate() steps from ttwu might muddle
> up the careful logic around the on_rq/ttwu_runnable checks (definitely
> had issues in that area with earlier versions of the patch).

I also think it is better to put the return migration back to the
try_to_wake_up() call path.
When mutex_unlock, could we deactivate the block task before adding it
to wake_q?
In this case, it can follow the try_to_wake_up patch. But at this
time, the trace_sched_blocked_reason
may be no need?

>
> > In addition, I also thought that since the block task is no longer
> > dequeued, this will definitely cause the load on the CPU to increase.
> > Perhaps we need to evaluate the impact of this on power consumption.
> >
>
> Yeah. I've got that still as a todo in the cover letter:
> * CFS load balancing. Blocked tasks may carry forward load (PELT)
>   to the lock owner's CPU, so CPU may look like it is overloaded.
>
> If you have any thoughts there for a preferred approach, I'd be happy to =
hear.

Okay, I'm still studying these patches carefully, and I will to test
these patches later. When I find other problems, I will be happy to
share.

Thanks!

>
> thanks
> -john

BR
---
xuewen

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B37E638D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 07:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjKIGIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 01:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKIGIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 01:08:21 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000F026A0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 22:08:18 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so5605a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 22:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699510097; x=1700114897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UU9sPLv6CzJmHHmUxzOy9fFS65gcOmIMEq+DTeRoz5I=;
        b=wz3mx0BBoTypG0ZWKkN52jQyYMjAHLQjNcPUOaerQUehfDoUFPKm05rQ8dxiut43Gf
         0ar37aXNdf1gsvEnOAQpyE0ACCA7YiU7WVcvMjJryXz9XLCPMR7NBYcyFb+SCQlu3y2P
         iuAN8obvSzXQPVoGiZj+dQWXgZX8+MQGrLIR19l936723IRcInH56KrNatHStx7OiD0d
         Popj6y6jPugJzsybw+RyQEnre++jsBfSSz6lRPPgmyOxcBnmJJOjcwYwts8gpGYX0WvN
         itzs28Q2GLeG1b87qLDWCnhUreFV2sJdhViZcOuydIXNDoU512/zDy0Mkyn0OHgVBtOm
         xdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699510097; x=1700114897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UU9sPLv6CzJmHHmUxzOy9fFS65gcOmIMEq+DTeRoz5I=;
        b=DyvJ8lNZE3fNBfdGAEUEaMOBAtHJueKMcoLoNPCHUlGyA46DJQoCXrQavFvuUQPYEF
         NIaTA+URffsJq7PPguOk6qgbDuVwiTzUVXzC80QOlOeJTdMA7XkEVloa36XnRegbxm17
         i6kTFlgaQhEv7kid7tW38+HujMg6OsxhIqkaTRmYIkpaOFkHLQZU3Katb2HkaJ2FJLc2
         OMOYHJl4US6bXTfehksOfVM4PfS4uGbD0/UYK8lXtqwmp/xUKtggVJzgCSYToJNeJoGY
         FG3RjpC1vBahIFofrERFfj84asYDaPCPei6ORPgItLJeQXRG8e5qKGiObsAXOrR57At4
         i6KA==
X-Gm-Message-State: AOJu0YxB1mAFKtUpBDHUMQ4Bfa0oIw24Lsqcc7KNsecGTd8Ya45cZ1XO
        KSRRosVWx9zzTu3Xh2DRBUVs6LjozbEmZnTGurBE
X-Google-Smtp-Source: AGHT+IH9QTjujZlEwNyfzUlNUVzPbwI5r4vvEJV59uklQit52rwAH870TEYonbqoLRHCSp3ssvqxvRFdu8uZkR2L31I=
X-Received: by 2002:a05:6402:497:b0:544:24a8:ebd with SMTP id
 k23-20020a056402049700b0054424a80ebdmr107493edv.4.1699510096578; Wed, 08 Nov
 2023 22:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com> <20231106193524.866104-19-jstultz@google.com>
 <CAB8ipk8faF30V8_maGiB62adBg6PLfynGg3p6PBoGJO_rzS7_Q@mail.gmail.com>
In-Reply-To: <CAB8ipk8faF30V8_maGiB62adBg6PLfynGg3p6PBoGJO_rzS7_Q@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 8 Nov 2023 22:08:05 -0800
Message-ID: <CANDhNCoqx-5PUB63Px8OuZnSrYsFzzMBFRrRZ7b72CbPOe9W9g@mail.gmail.com>
Subject: Re: [PATCH v6 18/20] sched: Handle blocked-waiter migration (and
 return migration)
To:     Xuewen Yan <xuewen.yan94@gmail.com>
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

On Wed, Nov 8, 2023 at 9:32=E2=80=AFPM Xuewen Yan <xuewen.yan94@gmail.com> =
wrote:
> I understand what you mean here. But I have some other worries:
> considering the scenario of Big-Little cpu topology, when EAS is in
> effect.
> If the owner is a "small task", and the owner is on a small core, and
> the blocked task is a "big task", the block task will be directly
> migrated to the small core,
> and because the task is on rq, when wake up, it would skip the
> =E2=80=9Cselect_task_rq=E2=80=9D and put it directly on the small core.
> As a result, the big task's performance may decrease.
> The same reason, a small task may be placed on the big core, and there
> may be a regression in power consumption.
>
...
> > +static inline bool proxy_return_migration(struct rq *rq, struct rq_fla=
gs *rf,
> > +                                         struct task_struct *next)
> > +{
> > +       if (!sched_proxy_exec())
> > +               return false;
> > +
> > +       if (next->blocked_on && next->blocked_on_waking) {
> > +               if (!is_cpu_allowed(next, cpu_of(rq))) {
>
>
> Based on the above reasons, could this be changed to the following?
>                 /* When EAS enabled, we hope the task selects the cpu aga=
in */
>                  if (sched_energy_enabled() || !is_cpu_allowed(next,
> cpu_of(rq)) )

Hey! Thanks so much for the feedback and review!

That is a good point, this would cause a misplacement on the lock
handoff.  Though I fret having to run through the return migration
lock juggling here for every blocked_on wakeup would further hurt
performance as well.

I'm currently trying to see if I can extend the blocked_on_waking flag
to keep more state (BLOCKED, WAKING, RUNNABLE) so that we can move the
return migration back to the the try_to_wake_up() call path, while
avoiding the task from becoming suddenly runnable on wakeup while on
the wrong runqueue.  This would avoid the lock juggling as we'd
already have the pi_lock. Though I'm a little hesitant as doing the
deactivate()/select_task_rq()/activate() steps from ttwu might muddle
up the careful logic around the on_rq/ttwu_runnable checks (definitely
had issues in that area with earlier versions of the patch).

> In addition, I also thought that since the block task is no longer
> dequeued, this will definitely cause the load on the CPU to increase.
> Perhaps we need to evaluate the impact of this on power consumption.
>

Yeah. I've got that still as a todo in the cover letter:
* CFS load balancing. Blocked tasks may carry forward load (PELT)
  to the lock owner's CPU, so CPU may look like it is overloaded.

If you have any thoughts there for a preferred approach, I'd be happy to he=
ar.

thanks
-john

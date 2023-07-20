Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9A275AE71
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjGTMcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGTMb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:31:59 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83B126AE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:31:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52173d4e9f9so922182a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689856281; x=1690461081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwyVBskHu9u82S5j1r+c54PapgOt8ZJeaa6uiacAAyI=;
        b=bQpsKViJ69i5DO8zqxe1hYjCJFpk4UdRa9epAqMhVsteW4QW98DJ0COgn0YTFAbvQ9
         ZNK4TA5EMaEvAk7wME+9ciKcAdiJh1ly1hrRW8pahPZczqPMJzFM4m56YVikVKG/U+y+
         Dfp473Ln5mura2M/NjM30c4o1HEtDhbOgO5hEwoXzkkyONBYq6NGUKaNdJvQLsDE9nFY
         KnHcZ+IWnMXyXuv1MX8ujRwjkv4a3qXzdKmSUJtuQXCJvyckQa+in2yZ05aWcFrR10MV
         wVmEQBfPHhOsTWTQHcy1hWTkFxzQSsfVXT38aApnjINubH7Q1fYnVAnrVTh/avBlZm6M
         s4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689856281; x=1690461081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwyVBskHu9u82S5j1r+c54PapgOt8ZJeaa6uiacAAyI=;
        b=RZCGIOyUdWF+jBYj+rOVycuZhw9Cnx+gHmUYI2HYgC/2ffjkLxGyQxLG6mlQD6gnSb
         w0813bZppRoNWFd5A4JPSvQwJbc5iovfD1hgE9o/u9FnyWsHQfft9oMqKO3b2oKJykYR
         7wap2qCGk+F1Yyrhirr7ZnnXJbEoni6DOJt4u9XkkmdjJSGGuDkt+Mk9h0iue6hS9Yl8
         24td3iXgg8SNjctuWU/p5KiEBWnpmdXj40h7R7/1zawZ26O1JBHmGJvmEBYoiuuTIokl
         ZW9IR5Px4o0brZDwJEXQ9sshHQF2oP5nXA5W6sqOJnlpjy9nnvxJzbZASaJxf2bVoJnx
         n9Mw==
X-Gm-Message-State: ABy/qLYHqA4Jw+oX0Zk8bRsDqkeKRK38Mq7K95eayrmZ+AQk1KpGkfyb
        7CBSdgNCrOb/XVMCFMys3SHN69ESuQ1OWdbWwpIfRA==
X-Google-Smtp-Source: APBJJlHx4yyMQJ3V/gvWkGZ2/bjk4MrSa7DQ22VXV1+OHI/devcdk+Np/f+a6befHdH8je0NqqfdUt73bsLA30Vwhn0=
X-Received: by 2002:aa7:c1d4:0:b0:51e:5251:8f45 with SMTP id
 d20-20020aa7c1d4000000b0051e52518f45mr4681180edp.4.1689856280567; Thu, 20 Jul
 2023 05:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230716014125.139577-1-qyousef@layalina.io> <ZLaKFFjY6NWaJdOq@vingu-book>
 <20230718161829.ws3vn3ufnod6kpxh@airbuntu> <CAKfTPtA55NemHq0tZPuiEN=c3DRZWD-7jf7ZrKdHE9y9b_szZg@mail.gmail.com>
 <20230718172522.s4gcfx3ppljwbks7@airbuntu>
In-Reply-To: <20230718172522.s4gcfx3ppljwbks7@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Jul 2023 14:31:09 +0200
Message-ID: <CAKfTPtA6s82qXWOSdd6eNu__z_HZe9U_F0+RcBJj=PVKT7go7A@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: Fix impossible migrate_util scenario in
 load balance
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 at 19:25, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 07/18/23 18:31, Vincent Guittot wrote:
> > On Tue, 18 Jul 2023 at 18:18, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 07/18/23 14:48, Vincent Guittot wrote:
> > > > Le dimanche 16 juil. 2023 =C3=A0 02:41:25 (+0100), Qais Yousef a =
=C3=A9crit :
> > > > > We've seen cases while running geekbench that an idle little core=
 never
> > > > > pulls a task from a bigger overloaded cluster for 100s of ms and
> > > > > sometimes over a second.
> > > > >
> > > > > It turned out that the load balance identifies this as a migrate_=
util
> > > > > type since the local group (little cluster) has a spare capacity =
and
> > > > > will try to pull a task. But the little cluster capacity is very =
small
> > > > > nowadays (around 200 or less) and if two busy tasks are stuck on =
a mid
> > > > > core which has a capacity of over 700, this means the util of eac=
h tasks
> > > > > will be around 350+ range. Which is always bigger than the spare
> > > > > capacity of the little group with a single idle core.
> > > > >
> > > > > When trying to detach_tasks() we bail out then because of the com=
parison
> > > > > of:
> > > > >
> > > > >     if (util > env->imbalance)
> > > > >             goto next;
> > > > >
> > > > > In calculate_imbalance() we convert a migrate_util into migrate_t=
ask
> > > > > type if the CPU trying to do the pull is idle. But we only do thi=
s if
> > > > > env->imbalance is 0; which I can't understand. AFAICT env->imbala=
nce
> > > > > contains the local group's spare capacity. If it is 0, this means=
 it's
> > > > > fully busy.
> > > > >
> > > > > Removing this condition fixes the problem, but since I can't full=
y
> > > > > understand why it checks for 0, sending this as RFC. It could be =
a typo
> > > > > and meant to check for
> > > > >
> > > > >     env->imbalance !=3D 0
> > > > >
> > > > > instead?
> > > > >
> > > > > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > > > > ---
> > > > >  kernel/sched/fair.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > index a80a73909dc2..682d9d6a8691 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -10288,7 +10288,7 @@ static inline void calculate_imbalance(st=
ruct lb_env *env, struct sd_lb_stats *s
> > > > >                      * waiting task in this overloaded busiest gr=
oup. Let's
> > > > >                      * try to pull it.
> > > > >                      */
> > > > > -                   if (env->idle !=3D CPU_NOT_IDLE && env->imbal=
ance =3D=3D 0) {
> > > > > +                   if (env->idle !=3D CPU_NOT_IDLE) {
> > > >
> > > > With this change you completely skip migrate_util for idle and newl=
y idle case
> > > > and this would be too aggressive.
> > >
> > > Yeah I didn't have great confidence in it to be honest.
> > >
> > > Could you help me understand the meaning of env->imbalance =3D=3D 0 t=
hough? At this
> > > stage its value is
> > >
> > >         env->imbalance =3D max(local->group_capacity, local->group_ut=
il) - local->group_util;
> > >
> > > which AFAICT is calculating the _spare_ capacity, right? So when we c=
heck
> > > env->imbalance =3D=3D 0 we say if this_cpu is (idle OR newly idle) AN=
D the local
> > > group is fully utilized? Why it must be fully utilized to do the pull=
? It's
> > > counter intuitive to me. I'm probably misinterpreting something but c=
an't see
> >
> > This is a special case. We have some situations where group_util is
> > higher than capacity because of tasks newly migrated to this group for
> > example so the spare capacity is null but one cpu is idle or newly
> > idle. In this case we try to pull a task with the risk that this group
> > becomes overloaded. That's why we do not try to pull a task every
> > time.
> > But that might be good choice all the time
>
> So on misfit, I do see that a bigger cpu will pull the task quickly as so=
on as
> a bigger cpu gets idle.
>
> This scenario is the opposite. Maybe the exception in my case is that the
> little cpu has spare capacity as it's mostly idle all the time. It's just
> unlucky circumstances at wake up ended up putting two tasks on bigger cor=
e.

I was trying to reproduce the behavior but I was failing until I
realized that this code path is used when the 2 groups are not sharing
their cache. Which topology do you use ? I thought that dynamiQ and
shares cache between all 8 cpus was the norm for arm64 embedded device
now

Also when you say "the little cluster capacity is very small nowadays
(around 200 or less)", it is the capacity of 1 core or the cluster ?

>
> Specifically, at the start of some of the sub-tests, there's a good chanc=
e that
> we have simultaneous wake ups and there's a limitation/race in EAS becaus=
e of
> the gap between select_task_rq_fair() and enqueue_task_fair(). If two tas=
k wake
> up simultaneously, select_task_rq_fair() could be called twice before the
> enqueue_task_fair() and end up selecting the same CPU for both tasks not
> realizing one of them is just waiting to be enqueued. IOW, EAS will not t=
ake
> into account the updated util of one of the CPUs because of the (short) d=
elay
> to enqueue it.
>
> This should be fixed (the wake up race), but this is a different story an=
d
> a bit trickier.
>
> The risk of pulling always is:
>
>         1. Risk force migrating prev task if it woke up shortly after the=
 pull.
>            Which is no worse IMHO than misfit going almost immediately to
>            bigger core.
>
>         2. Not sure of not being too smart about which task to pull. I ca=
n
>            envisage other scenarios where one of the two tasks is better =
to
>            pull. In geekbench both tasks are equal. But maybe in other us=
e
>            cases one of them less impactful. For example if one of them h=
as
>            a low uclamp_max but the other doesn't. But this case is unsup=
ported
>            feature at the moment. My plan (hope) to treat these uclamp_ma=
x as
>            misfit migration. Which I think is the better path in general =
to
>            treat special cases. So for migration_util this behavior might=
 be
>            sensible all the time. We are working too hard, let's use all =
of our
>            resources and make use all of idle cpus. If prev_task wakes up=
,
>            there's no harm; I doubt the cache hotness is a problem even g=
iven
>            two tasks are busy all the time trashing L1 anyway.
>
>         3. Not sure what will happen in cases we have nu_running > nr_cpu=
s and
>            some tasks happen to sleep for brief period of times. Two task=
s
>            stuck on little core is worse than two tasks stuck on mid or b=
ig
>            core. But maybe migrate_util will pull it back again given how
>            little capacity they have?
>
> Cheers
>
> --
> Qais Yousef
>
> >
> > > it.
> > >
> > > >
> > > > We can do something similar to migrate_load in detach_tasks():
> > > >
> > > > ---
> > > >  kernel/sched/fair.c | 8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index d3df5b1642a6..64111ac7e137 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -8834,7 +8834,13 @@ static int detach_tasks(struct lb_env *env)
> > > >               case migrate_util:
> > > >                       util =3D task_util_est(p);
> > > >
> > > > -                     if (util > env->imbalance)
> > > > +                     /*
> > > > +                      * Make sure that we don't migrate too much u=
tilization.
> > > > +                      * Nevertheless, let relax the constraint if
> > > > +                      * scheduler fails to find a good waiting tas=
k to
> > > > +                      * migrate.
> > > > +                      */
> > > > +                     if (shr_bound(util, env->sd->nr_balance_faile=
d) > env->imbalance)
> > > >                               goto next;
> > >
> > > Thanks! This looks better but I still see a 100 or 200 ms delay somet=
imes.
> > > Still debugging it but I _think_ it's a combination of two things:
> > >
> > >         1. nr_balance_failed doesn't increment as fast - I see a lot =
of 0s with
> > >            occasional 1s and less frequent 2s
> > >         2. something might wake up briefly on that cpu in between loa=
d balance,
> > >            and given how small the littles are they make the required
> > >            nr_balance_failed to tip the scale even higher
> > >
> > >
> > > Thanks
> > >
> > > --
> > > Qais Yousef
> > >
> > > >
> > > >                       env->imbalance -=3D util;
> > > > --
> > > >
> > > >
> > > >
> > > > >                             env->migration_type =3D migrate_task;
> > > > >                             env->imbalance =3D 1;
> > > > >                     }
> > > > > --
> > > > > 2.25.1
> > > > >

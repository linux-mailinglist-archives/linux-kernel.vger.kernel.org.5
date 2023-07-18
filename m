Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246E0758223
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjGRQcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjGRQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:32:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6EF19A3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:31:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so6404834a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689697916; x=1692289916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4koP/HZ+u7r0Zop/wu4/GvdR7sOW4wNBVwfwknXTyg=;
        b=Bd4cmWn8yjk2Zz9oegA94747wkZgCwp6cnQcAzafXVz91kedJWe+Nq0jFE7sVXDokP
         5gSj/EDiMFbnImcv3YKyLGq7QnUPmBjAHzmD1Zj+S26+DCrVFXS2xiXebZnxqdCrig4P
         ukh7tKicCiJvD42D7clA52wI7wGrDeLUNM95HY8fgBfImYk83hF8WA+Sl2xuhumtdGHG
         h9OyR3Qyyb6Ygbz/+Odl9rTHHJePgjuzsFv++dypwXJM/eRTTKJeH91Iq/JZNa8Rq25a
         e7H8txr5ENFDOE2PdrRyermnqPWuTHRXNk/RJ/3ztjXrQfsEX6ZcpT7S7xu1H+ZeEjr1
         KiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689697916; x=1692289916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4koP/HZ+u7r0Zop/wu4/GvdR7sOW4wNBVwfwknXTyg=;
        b=CJVS5aC4U9AZsdhJTa1LMUYCMfdKO1Sr++4yXMQiWxTRsItQ4NPY1bCTiwsI8niaoD
         Wsjo0VwwHGp7cR+ASsIaJEYN1v5bNV4vLsLJZm3/3aN3T1C4QFM9Uc1IGCeKLCys7ftR
         s5Ph0w0y665RkqLluIWaB6iH9XplB+nF+Vh34VQi4RoSblSh4BVN7OiNRX6Kg17apckW
         K7W4Lrrz9KXHZZn5srzKNJ+dXEEdxBAL+rJXPItiHjN5Z8eduVrWhc66HuoYeptkdL3X
         xZCoUOyaZRqMpVgi4ySwilscqZiVwaUAVisIgUDAzqevkqt5nmTMccz5AhCaGdwmemVF
         OFCg==
X-Gm-Message-State: ABy/qLZAWNFRWv+PwtW52SXDiRFeH140XE1lFgiP0awYarMpC0RASnVu
        /SXTme2jxz7BbAuxgeKD3knHHGWwMmqlaBUm1DFa/rDBrCnLEOz5
X-Google-Smtp-Source: APBJJlF9pLaE5t/Y6vo7FK0EmzS8mP9q9rEum4F4LOZgKqAKZxe95oMPMd6k1xoz4mOzB7eE3r8+vDD8wTu4uOMBb5g=
X-Received: by 2002:aa7:c305:0:b0:51d:98e4:4c4e with SMTP id
 l5-20020aa7c305000000b0051d98e44c4emr171955edq.40.1689697916380; Tue, 18 Jul
 2023 09:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230716014125.139577-1-qyousef@layalina.io> <ZLaKFFjY6NWaJdOq@vingu-book>
 <20230718161829.ws3vn3ufnod6kpxh@airbuntu>
In-Reply-To: <20230718161829.ws3vn3ufnod6kpxh@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 Jul 2023 18:31:45 +0200
Message-ID: <CAKfTPtA55NemHq0tZPuiEN=c3DRZWD-7jf7ZrKdHE9y9b_szZg@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 at 18:18, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 07/18/23 14:48, Vincent Guittot wrote:
> > Le dimanche 16 juil. 2023 =C3=A0 02:41:25 (+0100), Qais Yousef a =C3=A9=
crit :
> > > We've seen cases while running geekbench that an idle little core nev=
er
> > > pulls a task from a bigger overloaded cluster for 100s of ms and
> > > sometimes over a second.
> > >
> > > It turned out that the load balance identifies this as a migrate_util
> > > type since the local group (little cluster) has a spare capacity and
> > > will try to pull a task. But the little cluster capacity is very smal=
l
> > > nowadays (around 200 or less) and if two busy tasks are stuck on a mi=
d
> > > core which has a capacity of over 700, this means the util of each ta=
sks
> > > will be around 350+ range. Which is always bigger than the spare
> > > capacity of the little group with a single idle core.
> > >
> > > When trying to detach_tasks() we bail out then because of the compari=
son
> > > of:
> > >
> > >     if (util > env->imbalance)
> > >             goto next;
> > >
> > > In calculate_imbalance() we convert a migrate_util into migrate_task
> > > type if the CPU trying to do the pull is idle. But we only do this if
> > > env->imbalance is 0; which I can't understand. AFAICT env->imbalance
> > > contains the local group's spare capacity. If it is 0, this means it'=
s
> > > fully busy.
> > >
> > > Removing this condition fixes the problem, but since I can't fully
> > > understand why it checks for 0, sending this as RFC. It could be a ty=
po
> > > and meant to check for
> > >
> > >     env->imbalance !=3D 0
> > >
> > > instead?
> > >
> > > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > > ---
> > >  kernel/sched/fair.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index a80a73909dc2..682d9d6a8691 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -10288,7 +10288,7 @@ static inline void calculate_imbalance(struct=
 lb_env *env, struct sd_lb_stats *s
> > >                      * waiting task in this overloaded busiest group.=
 Let's
> > >                      * try to pull it.
> > >                      */
> > > -                   if (env->idle !=3D CPU_NOT_IDLE && env->imbalance=
 =3D=3D 0) {
> > > +                   if (env->idle !=3D CPU_NOT_IDLE) {
> >
> > With this change you completely skip migrate_util for idle and newly id=
le case
> > and this would be too aggressive.
>
> Yeah I didn't have great confidence in it to be honest.
>
> Could you help me understand the meaning of env->imbalance =3D=3D 0 thoug=
h? At this
> stage its value is
>
>         env->imbalance =3D max(local->group_capacity, local->group_util) =
- local->group_util;
>
> which AFAICT is calculating the _spare_ capacity, right? So when we check
> env->imbalance =3D=3D 0 we say if this_cpu is (idle OR newly idle) AND th=
e local
> group is fully utilized? Why it must be fully utilized to do the pull? It=
's
> counter intuitive to me. I'm probably misinterpreting something but can't=
 see

This is a special case. We have some situations where group_util is
higher than capacity because of tasks newly migrated to this group for
example so the spare capacity is null but one cpu is idle or newly
idle. In this case we try to pull a task with the risk that this group
becomes overloaded. That's why we do not try to pull a task every
time.
But that might be good choice all the time

> it.
>
> >
> > We can do something similar to migrate_load in detach_tasks():
> >
> > ---
> >  kernel/sched/fair.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d3df5b1642a6..64111ac7e137 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8834,7 +8834,13 @@ static int detach_tasks(struct lb_env *env)
> >               case migrate_util:
> >                       util =3D task_util_est(p);
> >
> > -                     if (util > env->imbalance)
> > +                     /*
> > +                      * Make sure that we don't migrate too much utili=
zation.
> > +                      * Nevertheless, let relax the constraint if
> > +                      * scheduler fails to find a good waiting task to
> > +                      * migrate.
> > +                      */
> > +                     if (shr_bound(util, env->sd->nr_balance_failed) >=
 env->imbalance)
> >                               goto next;
>
> Thanks! This looks better but I still see a 100 or 200 ms delay sometimes=
.
> Still debugging it but I _think_ it's a combination of two things:
>
>         1. nr_balance_failed doesn't increment as fast - I see a lot of 0=
s with
>            occasional 1s and less frequent 2s
>         2. something might wake up briefly on that cpu in between load ba=
lance,
>            and given how small the littles are they make the required
>            nr_balance_failed to tip the scale even higher
>
>
> Thanks
>
> --
> Qais Yousef
>
> >
> >                       env->imbalance -=3D util;
> > --
> >
> >
> >
> > >                             env->migration_type =3D migrate_task;
> > >                             env->imbalance =3D 1;
> > >                     }
> > > --
> > > 2.25.1
> > >

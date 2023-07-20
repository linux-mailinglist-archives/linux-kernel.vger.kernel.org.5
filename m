Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9430775B1FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjGTPEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjGTPEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:04:33 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45577BB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:04:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso1208716a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689865470; x=1690470270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7aSG/EqU9I5oy5fQXPoCvjc38F4/1Ha3I7wLiLMebnc=;
        b=LXRHONLbIoaLxmq89NXaIJ4qaJYib7ePx6++u0uBdbGJMLkSeoqleivsbRF7ubTTVW
         PvSD/HsKMM6LLAKUb+9xt/DXPfvo1J3XRWFbNXPIPAz7ea1NqIG6FQP9TyPtFWfZe5IX
         FugLgbq0sc3jNxC0MH/RN70WkB9kJKD3yC3cMJGPAHSYeIR9yI4FF3AGo+jogzdCPf1G
         WeMy9C2368W6iPUiDmb3SL3j7zcS+jU6rtAQv0T8EfRjzOMvspQhu0l9E1lhfSPJE7O/
         KmKBKx3nCYLWeWrrU2FmqQwqI6jHk2ENRXd7AXYDhjzgajsiw+6Mb2GWFuPw5OBmjLnM
         vhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689865470; x=1690470270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aSG/EqU9I5oy5fQXPoCvjc38F4/1Ha3I7wLiLMebnc=;
        b=WU2soN/bsDHGv9XczUn4uNRPdfhhRGFOxuGoSMwLgL8cfU959OEq7Vz8H2D/RAWT/D
         bQZ1FzCxcZmKTRHGxDNzZ9YvDdMPKbaMT0kiJ7HIaDnz/Yt8OtzNkoorKQgRNeutFeal
         DwnBQYVHjm0+eFcD+IYeyR8U40D6wrYTYsV7qf2PpWSuETE3M8+uG/UxVgqyaznvanz8
         IwzVDAQ/9+tDcWIL6tflyiH9Fnx1AMVVu8LKPRqei76O4MZmwnxwBswovTRPUN2t2J3c
         AhsBKpjgFt8sr29MRgML2HGq+N8TS+l6njaSXrENbORGCW8LbMhHyYWhL0+KdQhn7PcQ
         yc/A==
X-Gm-Message-State: ABy/qLaNfUx2t0vZ4s5ApYPTtVajDM7Eht7aiFuFhNGeenJNiowcStfp
        zMce7Gd392y/38W5Uxo5u4Od3dEQo06bcKq/TmG0yQ==
X-Google-Smtp-Source: APBJJlH9lmghh4l44WkdwYIQOatd/BtNQnH7v3/47BBuIrYB8vIuRx0N0JLtAcVMJPw0tJYG2wCsfTPPsWyjjCtpyxM=
X-Received: by 2002:aa7:d145:0:b0:51b:e4c7:410f with SMTP id
 r5-20020aa7d145000000b0051be4c7410fmr4710171edo.6.1689865469711; Thu, 20 Jul
 2023 08:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230718134120.81199-1-aaron.lu@intel.com> <20230718134120.81199-4-aaron.lu@intel.com>
 <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com>
 <20230719051826.GB84059@ziqianlu-dell> <20230719080105.GA90441@ziqianlu-dell>
 <CAKfTPtCnvOehfrz1OSW+rmkKW+28bdGw8fU+AvVrZTxkHibL_g@mail.gmail.com>
 <20230719132914.GA91858@ziqianlu-dell> <CAKfTPtAqpAo8Y9BdWZ-fmnyYgA8PEtFbObqWJxc-hs2Ktqkt3Q@mail.gmail.com>
 <20230720144233.GA185317@ziqianlu-dell>
In-Reply-To: <20230720144233.GA185317@ziqianlu-dell>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Jul 2023 17:04:18 +0200
Message-ID: <CAKfTPtC+q5t+Kumyhq=vLhmx75VSimZPZ2U9qc6UQXwZVAZQ4w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] sched/fair: delay update_tg_load_avg() for
 cfs_rq's removed load
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 at 16:42, Aaron Lu <aaron.lu@intel.com> wrote:
>
> On Thu, Jul 20, 2023 at 03:10:30PM +0200, Vincent Guittot wrote:
> > On Wed, 19 Jul 2023 at 15:29, Aaron Lu <aaron.lu@intel.com> wrote:
> > >
> > > On Wed, Jul 19, 2023 at 11:47:06AM +0200, Vincent Guittot wrote:
> > > > On Wed, 19 Jul 2023 at 10:01, Aaron Lu <aaron.lu@intel.com> wrote:
> > > > >
> > > > > On Wed, Jul 19, 2023 at 01:18:26PM +0800, Aaron Lu wrote:
> > > > > > Alternatively, I can remove some callsites of update_tg_load_avg() like
> > > > > > you suggested below and only call update_tg_load_avg() when cfs_rq is
> > > > > > decayed(really just decayed, not when it detected it has removed load
> > > > > > pending or load propagated from its children). This way it would give us
> > > > > > similar result as above(roughly once per ms).
> > > > >
> > > > > Something like this: (I think this is better since it removed those
> > > > > unnecessary calls to update_tg_load_avg(), although it is inline but
> > > > > still)
> > > > >
> > > > >
> > > > > From bc749aaefa6bed36aa946921a4006b3dddb69b77 Mon Sep 17 00:00:00 2001
> > > > > From: Aaron Lu <aaron.lu@intel.com>
> > > > > Date: Wed, 19 Jul 2023 13:54:48 +0800
> > > > > Subject: [PATCH] sched/fair: only update_tg_load_avg() when cfs_rq decayed
> > > > >
> > > > > ---
> > > > >  kernel/sched/fair.c | 22 +++++++---------------
> > > > >  1 file changed, 7 insertions(+), 15 deletions(-)
> > > > >
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > index a80a73909dc2..7d5b7352b8b5 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -3913,16 +3913,16 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
> > > > >  }
> > > > >
> > > > >  /* Update task and its cfs_rq load average */
> > > > > -static inline int propagate_entity_load_avg(struct sched_entity *se)
> > > > > +static inline void propagate_entity_load_avg(struct sched_entity *se)
> > > > >  {
> > > > >         struct cfs_rq *cfs_rq, *gcfs_rq;
> > > > >
> > > > >         if (entity_is_task(se))
> > > > > -               return 0;
> > > > > +               return;
> > > > >
> > > > >         gcfs_rq = group_cfs_rq(se);
> > > > >         if (!gcfs_rq->propagate)
> > > > > -               return 0;
> > > > > +               return;
> > > > >
> > > > >         gcfs_rq->propagate = 0;
> > > > >
> > > > > @@ -3936,8 +3936,6 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
> > > > >
> > > > >         trace_pelt_cfs_tp(cfs_rq);
> > > > >         trace_pelt_se_tp(se);
> > > > > -
> > > > > -       return 1;
> > > > >  }
> > > > >
> > > > >  /*
> > > > > @@ -3974,9 +3972,8 @@ static inline bool skip_blocked_update(struct sched_entity *se)
> > > > >
> > > > >  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
> > > > >
> > > > > -static inline int propagate_entity_load_avg(struct sched_entity *se)
> > > > > +static inline void propagate_entity_load_avg(struct sched_entity *se)
> > > > >  {
> > > > > -       return 0;
> > > > >  }
> > > > >
> > > > >  static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum) {}
> > > > > @@ -4086,7 +4083,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> > > > >  {
> > > > >         unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
> > > > >         struct sched_avg *sa = &cfs_rq->avg;
> > > > > -       int decayed = 0;
> > > > > +       int decayed;
> > > > >
> > > > >         if (cfs_rq->removed.nr) {
> > > > >                 unsigned long r;
> > > > > @@ -4134,11 +4131,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> > > > >                  */
> > > > >                 add_tg_cfs_propagate(cfs_rq,
> > > > >                         -(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT);
> > > > > -
> > > > > -               decayed = 1;
> > > > >         }
> > > > >
> > > > > -       decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
> > > > > +       decayed = __update_load_avg_cfs_rq(now, cfs_rq);
> > > > >         u64_u32_store_copy(sa->last_update_time,
> > > > >                            cfs_rq->last_update_time_copy,
> > > > >                            sa->last_update_time);
> > > > > @@ -4252,7 +4247,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> > > > >                 __update_load_avg_se(now, cfs_rq, se);
> > > > >
> > > > >         decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> > > > > -       decayed |= propagate_entity_load_avg(se);
> > > > > +       propagate_entity_load_avg(se);
> > > >
> > > > but then you  also skip the call to cfs_rq_util_change()
> > >
> > > Ah right, I missed that, thanks for catching this.
> > >
> > > Updated:
> > >
> > > From 09a649f8111cfca656b7b735da975ef607b00956 Mon Sep 17 00:00:00 2001
> > > From: Aaron Lu <aaron.lu@intel.com>
> > > Date: Wed, 19 Jul 2023 13:54:48 +0800
> > > Subject: [PATCH] sched/fair: only update_tg_load_avg() when cfs_rq decayed
> > >
> > > ---
> > >  kernel/sched/fair.c | 17 ++++++-----------
> > >  1 file changed, 6 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index a80a73909dc2..8d4b9e0a19b6 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4086,7 +4086,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> > >  {
> > >         unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
> > >         struct sched_avg *sa = &cfs_rq->avg;
> > > -       int decayed = 0;
> > > +       int decayed;
> > >
> > >         if (cfs_rq->removed.nr) {
> > >                 unsigned long r;
> > > @@ -4134,11 +4134,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> > >                  */
> > >                 add_tg_cfs_propagate(cfs_rq,
> > >                         -(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT);
> > > -
> > > -               decayed = 1;
> >
> > We need this to propagate the change in other place like cpufreq
>
> Ah, I just made the same mistake again, sorry.
>
> So there are three cases for a cfs_rq: load decayed, load removed and
> load propagated. For all three cases, cfs_rq_util_change() needs to be
> called and only for decayed, update_tg_load_avg() needs to be called.
>
> I'll update the patch accordingly.
>
> > >         }
> > >
> > > -       decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
> > > +       decayed = __update_load_avg_cfs_rq(now, cfs_rq);
> > >         u64_u32_store_copy(sa->last_update_time,
> > >                            cfs_rq->last_update_time_copy,
> > >                            sa->last_update_time);
> > > @@ -4242,7 +4240,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> > >  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > >  {
> > >         u64 now = cfs_rq_clock_pelt(cfs_rq);
> > > -       int decayed;
> > > +       int decayed, propagated;
> > >
> > >         /*
> > >          * Track task load average for carrying it to new CPU after migrated, and
> > > @@ -4252,7 +4250,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> > >                 __update_load_avg_se(now, cfs_rq, se);
> > >
> > >         decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> > > -       decayed |= propagate_entity_load_avg(se);
> > > +       propagated = propagate_entity_load_avg(se);
> > >
> > >         if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
> > >
> > > @@ -4264,19 +4262,16 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> > >                  * IOW we're enqueueing a task on a new CPU.
> > >                  */
> > >                 attach_entity_load_avg(cfs_rq, se);
> > > -               update_tg_load_avg(cfs_rq);
> > > -
> > >         } else if (flags & DO_DETACH) {
> > >                 /*
> > >                  * DO_DETACH means we're here from dequeue_entity()
> > >                  * and we are migrating task out of the CPU.
> > >                  */
> > >                 detach_entity_load_avg(cfs_rq, se);
> > > -               update_tg_load_avg(cfs_rq);
> > > -       } else if (decayed) {
> > > +       } else if (decayed || propagated) {
> > >                 cfs_rq_util_change(cfs_rq, 0);
> > >
> > > -               if (flags & UPDATE_TG)
> > > +               if (decayed && (flags & UPDATE_TG))



> >
> > It would be simpler and more readable to clear UPDATE_TG or not set it
> > from the beginning
>
> Do you mean something like this?
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8d4b9e0a19b6..084d63371355 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4249,7 +4249,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>         if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
>                 __update_load_avg_se(now, cfs_rq, se);
>
> -       decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> +       decayed  = update_cfs_rq_load_avg(now, cfs_rq) && (flags & UPDATE_TG);
>         propagated = propagate_entity_load_avg(se);
>
>         if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
> @@ -4271,7 +4271,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>         } else if (decayed || propagated) {
>                 cfs_rq_util_change(cfs_rq, 0);
>
> -               if (decayed && (flags & UPDATE_TG))
> +               if (decayed)
>                         update_tg_load_avg(cfs_rq);
>         }

something like below:

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4252,6 +4252,8 @@ static inline void update_load_avg(struct cfs_rq
*cfs_rq, struct sched_entity *s
                __update_load_avg_se(now, cfs_rq, se);

        decayed  = update_cfs_rq_load_avg(now, cfs_rq);
+       if (!decayed)
+               flags &= ~UPDATE_TG;
        decayed |= propagate_entity_load_avg(se);

        if (!se->avg.last_update_time && (flags & DO_ATTACH)) {


>  }
>
> > IIUC, you rely on the fact that a decay happens every 1024 us of the
> > cfs_rq_clock_pelt() which is scaled by frequency and cpu compute
> > capacity. So you can end up with a cfs_rq_clock_pelt() that is far
> > slower than real clock and the 1ms can easily be extended to dozens of
> > ms
>
> Thanks for the info. I'm not familiar with this clock scale part and will
> need to take a closer look.
>
> As you know, the intent is to make the unbound update to tg->load_avg
> become bound for those wakeup migration heavy workloads and the way this
> change does to achieve it is to remove the update to tg->load_avg on
> attach and detach path, just leave the update on load decay path. And if
> the current implementation makes load decay longer than 1024us, that
> shouldn't be a problem for this change. I don't see an immediate problem
> if update to tg->load_avg happens less often than once per ms but please
> let me know if I missed something, thanks.
>
> >
> > >                         update_tg_load_avg(cfs_rq);
> > >         }
> > >  }
> > > --
> > > 2.41.0
> > >
> > >
> > > > >
> > > > >         if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
> > > > >
> > > > > @@ -4264,15 +4259,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> > > > >                  * IOW we're enqueueing a task on a new CPU.
> > > > >                  */
> > > > >                 attach_entity_load_avg(cfs_rq, se);
> > > > > -               update_tg_load_avg(cfs_rq);
> > > > > -
> > > > >         } else if (flags & DO_DETACH) {
> > > > >                 /*
> > > > >                  * DO_DETACH means we're here from dequeue_entity()
> > > > >                  * and we are migrating task out of the CPU.
> > > > >                  */
> > > > >                 detach_entity_load_avg(cfs_rq, se);
> > > > > -               update_tg_load_avg(cfs_rq);
> > > > >         } else if (decayed) {
> > > > >                 cfs_rq_util_change(cfs_rq, 0);
> > > > >
> > > > > --
> > > > > 2.41.0
> > > > >

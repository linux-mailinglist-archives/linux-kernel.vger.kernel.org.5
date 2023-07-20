Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A8A75AF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjGTNK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjGTNKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:10:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E85026B0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:10:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e5d9e20ecso1005358a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689858641; x=1690463441;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/vdjeypC9mI/FaLJo0Dvqdpeo8wqfa8neTmhylDJ/Os=;
        b=HGjuEVbnioWE6ZoRIGoFxcz3Mb4cWJDj/yAJgoej0MO+Kxo2ql3Xz637b9cTb67Jg0
         aYnTPW1oqFYDWC4yHoiySjlErvmdYSn4PmamqwAn+cwuTtnfJ5f5JpGmS1jk50CTFN3G
         UrIyDfvbUjlN3vuuWk8CSZ7YY0/eBuFMHPS2EkKxVq+U0WpRyMYHzBMwSXOSnFi9CA5D
         VNitUjTHZ9kl05qdotur75wBPeIBm5O22rGrtfagHcwCq3zvWMmFjrxQkUNawPMbNxwZ
         oBUTFyZvrzAId2ez3S1jGAnPY3DzOflRSj13F4LX6HMsUdI41E6HsOjd1YdHU72XSnkJ
         HpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689858641; x=1690463441;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vdjeypC9mI/FaLJo0Dvqdpeo8wqfa8neTmhylDJ/Os=;
        b=kEVqT8V8GWjbRjvv9/O9CqEkRFyskHYsuzuCjkXFg4lSew6RsCiDn08YdXFRmRta9G
         9Bhc8XrIyomR5nIwUmlDhntXkrSJbCcOJo3Hfzoe2EDInuHFUhSVYKKKsbS/0GWj3w0M
         q6gJazc27qPr13/RNWbPIlFMivDGq2zkrGT7/g0afnzVEwf0by/gNFPzn2Oux5Fz06fg
         zpRYHiD4E40BoSUPhNp6R2Ovnp8+H5ic/FW5SelSivTeTgRKMQJPDe/S4WFvZwouoXfy
         7fjO5RInwf8L0cfy3zuwh/3Nx95AJCMUL+XtWgg+czU/XEQRpIIf9Gqx4t7Xj26CrIyx
         fkrQ==
X-Gm-Message-State: ABy/qLb6iaK8ipp7kwFUAJ0JNGagVP5bzqm+LxIvl8EPp+IlwD821KJD
        VVLEL/IJI4XirUdT4xdx++6y7OPuUtSzS238SPBiaA==
X-Google-Smtp-Source: APBJJlFSXpV5rlzS7wwz7w8nkkspM2DSSS0cbgU9v9asjixKlLsLY7K8Hm0Jf0b7JKwVQXjeX9hc87WhvDYO2pjveVE=
X-Received: by 2002:aa7:d384:0:b0:51e:309:2e11 with SMTP id
 x4-20020aa7d384000000b0051e03092e11mr5184558edq.36.1689858641525; Thu, 20 Jul
 2023 06:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230718134120.81199-1-aaron.lu@intel.com> <20230718134120.81199-4-aaron.lu@intel.com>
 <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com>
 <20230719051826.GB84059@ziqianlu-dell> <20230719080105.GA90441@ziqianlu-dell>
 <CAKfTPtCnvOehfrz1OSW+rmkKW+28bdGw8fU+AvVrZTxkHibL_g@mail.gmail.com> <20230719132914.GA91858@ziqianlu-dell>
In-Reply-To: <20230719132914.GA91858@ziqianlu-dell>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Jul 2023 15:10:30 +0200
Message-ID: <CAKfTPtAqpAo8Y9BdWZ-fmnyYgA8PEtFbObqWJxc-hs2Ktqkt3Q@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 at 15:29, Aaron Lu <aaron.lu@intel.com> wrote:
>
> On Wed, Jul 19, 2023 at 11:47:06AM +0200, Vincent Guittot wrote:
> > On Wed, 19 Jul 2023 at 10:01, Aaron Lu <aaron.lu@intel.com> wrote:
> > >
> > > On Wed, Jul 19, 2023 at 01:18:26PM +0800, Aaron Lu wrote:
> > > > Alternatively, I can remove some callsites of update_tg_load_avg() like
> > > > you suggested below and only call update_tg_load_avg() when cfs_rq is
> > > > decayed(really just decayed, not when it detected it has removed load
> > > > pending or load propagated from its children). This way it would give us
> > > > similar result as above(roughly once per ms).
> > >
> > > Something like this: (I think this is better since it removed those
> > > unnecessary calls to update_tg_load_avg(), although it is inline but
> > > still)
> > >
> > >
> > > From bc749aaefa6bed36aa946921a4006b3dddb69b77 Mon Sep 17 00:00:00 2001
> > > From: Aaron Lu <aaron.lu@intel.com>
> > > Date: Wed, 19 Jul 2023 13:54:48 +0800
> > > Subject: [PATCH] sched/fair: only update_tg_load_avg() when cfs_rq decayed
> > >
> > > ---
> > >  kernel/sched/fair.c | 22 +++++++---------------
> > >  1 file changed, 7 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index a80a73909dc2..7d5b7352b8b5 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -3913,16 +3913,16 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
> > >  }
> > >
> > >  /* Update task and its cfs_rq load average */
> > > -static inline int propagate_entity_load_avg(struct sched_entity *se)
> > > +static inline void propagate_entity_load_avg(struct sched_entity *se)
> > >  {
> > >         struct cfs_rq *cfs_rq, *gcfs_rq;
> > >
> > >         if (entity_is_task(se))
> > > -               return 0;
> > > +               return;
> > >
> > >         gcfs_rq = group_cfs_rq(se);
> > >         if (!gcfs_rq->propagate)
> > > -               return 0;
> > > +               return;
> > >
> > >         gcfs_rq->propagate = 0;
> > >
> > > @@ -3936,8 +3936,6 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
> > >
> > >         trace_pelt_cfs_tp(cfs_rq);
> > >         trace_pelt_se_tp(se);
> > > -
> > > -       return 1;
> > >  }
> > >
> > >  /*
> > > @@ -3974,9 +3972,8 @@ static inline bool skip_blocked_update(struct sched_entity *se)
> > >
> > >  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
> > >
> > > -static inline int propagate_entity_load_avg(struct sched_entity *se)
> > > +static inline void propagate_entity_load_avg(struct sched_entity *se)
> > >  {
> > > -       return 0;
> > >  }
> > >
> > >  static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum) {}
> > > @@ -4086,7 +4083,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> > >  {
> > >         unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
> > >         struct sched_avg *sa = &cfs_rq->avg;
> > > -       int decayed = 0;
> > > +       int decayed;
> > >
> > >         if (cfs_rq->removed.nr) {
> > >                 unsigned long r;
> > > @@ -4134,11 +4131,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> > >                  */
> > >                 add_tg_cfs_propagate(cfs_rq,
> > >                         -(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT);
> > > -
> > > -               decayed = 1;
> > >         }
> > >
> > > -       decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
> > > +       decayed = __update_load_avg_cfs_rq(now, cfs_rq);
> > >         u64_u32_store_copy(sa->last_update_time,
> > >                            cfs_rq->last_update_time_copy,
> > >                            sa->last_update_time);
> > > @@ -4252,7 +4247,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> > >                 __update_load_avg_se(now, cfs_rq, se);
> > >
> > >         decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> > > -       decayed |= propagate_entity_load_avg(se);
> > > +       propagate_entity_load_avg(se);
> >
> > but then you  also skip the call to cfs_rq_util_change()
>
> Ah right, I missed that, thanks for catching this.
>
> Updated:
>
> From 09a649f8111cfca656b7b735da975ef607b00956 Mon Sep 17 00:00:00 2001
> From: Aaron Lu <aaron.lu@intel.com>
> Date: Wed, 19 Jul 2023 13:54:48 +0800
> Subject: [PATCH] sched/fair: only update_tg_load_avg() when cfs_rq decayed
>
> ---
>  kernel/sched/fair.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a80a73909dc2..8d4b9e0a19b6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4086,7 +4086,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  {
>         unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
>         struct sched_avg *sa = &cfs_rq->avg;
> -       int decayed = 0;
> +       int decayed;
>
>         if (cfs_rq->removed.nr) {
>                 unsigned long r;
> @@ -4134,11 +4134,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>                  */
>                 add_tg_cfs_propagate(cfs_rq,
>                         -(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT);
> -
> -               decayed = 1;

We need this to propagate the change in other place like cpufreq

>         }
>
> -       decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
> +       decayed = __update_load_avg_cfs_rq(now, cfs_rq);
>         u64_u32_store_copy(sa->last_update_time,
>                            cfs_rq->last_update_time_copy,
>                            sa->last_update_time);
> @@ -4242,7 +4240,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
>         u64 now = cfs_rq_clock_pelt(cfs_rq);
> -       int decayed;
> +       int decayed, propagated;
>
>         /*
>          * Track task load average for carrying it to new CPU after migrated, and
> @@ -4252,7 +4250,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>                 __update_load_avg_se(now, cfs_rq, se);
>
>         decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> -       decayed |= propagate_entity_load_avg(se);
> +       propagated = propagate_entity_load_avg(se);
>
>         if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
>
> @@ -4264,19 +4262,16 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>                  * IOW we're enqueueing a task on a new CPU.
>                  */
>                 attach_entity_load_avg(cfs_rq, se);
> -               update_tg_load_avg(cfs_rq);
> -
>         } else if (flags & DO_DETACH) {
>                 /*
>                  * DO_DETACH means we're here from dequeue_entity()
>                  * and we are migrating task out of the CPU.
>                  */
>                 detach_entity_load_avg(cfs_rq, se);
> -               update_tg_load_avg(cfs_rq);
> -       } else if (decayed) {
> +       } else if (decayed || propagated) {
>                 cfs_rq_util_change(cfs_rq, 0);
>
> -               if (flags & UPDATE_TG)
> +               if (decayed && (flags & UPDATE_TG))

It would be simpler and more readable to clear UPDATE_TG or not set it
from the beginning

IIUC, you rely on the fact that a decay happens every 1024 us of the
cfs_rq_clock_pelt() which is scaled by frequency and cpu compute
capacity. So you can end up with a cfs_rq_clock_pelt() that is far
slower than real clock and the 1ms can easily be extended to dozens of
ms

>                         update_tg_load_avg(cfs_rq);
>         }
>  }
> --
> 2.41.0
>
>
> > >
> > >         if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
> > >
> > > @@ -4264,15 +4259,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
> > >         } else if (decayed) {
> > >                 cfs_rq_util_change(cfs_rq, 0);
> > >
> > > --
> > > 2.41.0
> > >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FA28039A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344475AbjLDQHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjLDQHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:07:12 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6702095
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:07:18 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cddc148285so4923465b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701706038; x=1702310838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0eXTJmt29eCW3Ou83aYWQmui7jnQpgwQ9joAhuqNSb4=;
        b=wY6vF7PYnaR5ji2YF7ZLkm6IXLAtHYeIwumqNKgzOcWmnjha9sLaTPdpWEFb9EjbeH
         7ORnHUKPQYbM6yxNsE4Yu3Gge5XI0TvkLIcvZyfY0pAX5Jh2qE/0xdijFeaZS/e/VBxo
         uam3W7/ReHt8kC4z3OGbx4sJQyuBfJnzT8VD29A2/458HNu+Ob0XXb+1rkTNWPMIIvuK
         eyNOsQtbSrkciKE7Sk6uGwyQlZ2yIa4iImVhCS5z4phsRhNQ20k3nfS8LcZHDsGVydKE
         CqP9kJqMebXfSY8EeqHxEvj8fyj1b2IWZrmB6rVDLn1Rcj8z1Swt1nFQdcsRBkYqQ3ua
         HfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701706038; x=1702310838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eXTJmt29eCW3Ou83aYWQmui7jnQpgwQ9joAhuqNSb4=;
        b=jzaLOYhKRZvHNRNhukr2XwcCaF8u8yGW2ZvU64YnT+J9xTonfOhp8bmHmwE1SxUWTG
         ymrL6RZdvd+l+PeFV8lQt0P5P/UxK6+vDQNOiglP1FiV+3EMNtur8cUZBrJTxbLnKwqA
         w6whtkIjYHaPKeyPZPpYuyplrKTywwbgLJQV19LFPx2p/u/kCWR+CcjJD5r+IBjEaUJO
         Pqo1cHnRJKp+X2upsIyqJTeEYoaShLPD/bGlGZOiM3CmiX01tYQnHYa3wpOnb93ufH4M
         J+B1a4F9BWxPvbOsrW7qjumV4HdfZbeihQbVnELmIe5+u+/ZBorydtDVwbnPhZDYIEN3
         bJuw==
X-Gm-Message-State: AOJu0Yx79PZGCYoKn8ZZnCF4zW1vQl4iYtI7pq26VCJKydJiWUApOcI0
        Ti64Gh42I/sjxwF0JB7hsSMVvmKQSRNYTiAVVTkkFw==
X-Google-Smtp-Source: AGHT+IF/L2jWCsd95A3qxEX1r2vYPRphEt/ADMTEWKAJrylNhm6IoZ7k8WpgzKgTWEstqn9uDYIIoQDXRyvgELqqq04=
X-Received: by 2002:a05:6a20:54a3:b0:18b:8158:86ea with SMTP id
 i35-20020a056a2054a300b0018b815886eamr5085101pzk.10.1701706037767; Mon, 04
 Dec 2023 08:07:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1696345700.git.Hongyan.Xia2@arm.com> <d73fc3e9a02f047902fdd5e4c07402452d6e0590.1696345700.git.Hongyan.Xia2@arm.com>
In-Reply-To: <d73fc3e9a02f047902fdd5e4c07402452d6e0590.1696345700.git.Hongyan.Xia2@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 4 Dec 2023 17:07:06 +0100
Message-ID: <CAKfTPtAoTB_1RM+COXFYTc7_YUUQ12we_2bqsy_ygpiT1RSViA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] sched/uclamp: Simulate PELT decay in util_avg_uclamp
To:     Hongyan Xia <Hongyan.Xia2@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
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

On Wed, 4 Oct 2023 at 11:05, Hongyan Xia <Hongyan.Xia2@arm.com> wrote:
>
> From: Hongyan Xia <hongyan.xia2@arm.com>
>
> Because util_avg_uclamp is not directly managed by PELT, it lacks the
> nice property of slowly decaying to a lower value, resulting in
> performance degredation due to premature frequency drops.

That a very good reason for not doing this

>
> Add functions to decay root cfs utilization and tasks that are not on
> the rq. This way, we get the benefits of PELT while still maintaining
> uclamp. The rules are simple:

Nack. This just highlights that you are mixing different things and
then trying to make it work.

Please keep PELT out of uclamp_min/max

>
> 1. When task is se->on_rq, enforce its util_avg_uclamp within uclamp
>    range.
> 2. When task is !se->on_rq, PELT decay its util_avg_uclamp.
> 3. When the root CFS util drops, PELT decay to the target frequency
>    instead of immediately dropping to a lower target frequency.
>
> TODO: Can we somehow integrate this uclamp sum aggregation directly into
> util_avg, so that we don't need to introduce a new util_avg_uclamp
> signal and don't need to simulate PELT decay?
>
> Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
> ---
>  kernel/sched/fair.c  |  20 +++++++++
>  kernel/sched/pelt.c  | 103 ++++++++++++++++++++++++++++++++++++++++---
>  kernel/sched/sched.h |   2 +
>  3 files changed, 119 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 33e5a6e751c0..420af57d01ee 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4311,17 +4311,22 @@ static inline int
>  update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  {
>         unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
> +       unsigned int removed_root_util = 0;
>         struct sched_avg *sa = &cfs_rq->avg;
>         int decayed = 0;
>
>         if (cfs_rq->removed.nr) {
>                 unsigned long r;
> +               struct rq *rq = rq_of(cfs_rq);
>                 u32 divider = get_pelt_divider(&cfs_rq->avg);
>
>                 raw_spin_lock(&cfs_rq->removed.lock);
>                 swap(cfs_rq->removed.util_avg, removed_util);
>                 swap(cfs_rq->removed.load_avg, removed_load);
>                 swap(cfs_rq->removed.runnable_avg, removed_runnable);
> +#ifdef CONFIG_UCLAMP_TASK
> +               swap(rq->root_cfs_util_uclamp_removed, removed_root_util);
> +#endif
>                 cfs_rq->removed.nr = 0;
>                 raw_spin_unlock(&cfs_rq->removed.lock);
>
> @@ -4346,6 +4351,12 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>                  *    util_avg * minimum possible divider
>                  */
>                 sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * PELT_MIN_DIVIDER);
> +#ifdef CONFIG_UCLAMP_TASK
> +               r = removed_root_util;
> +               sub_positive(&rq->root_cfs_util_uclamp, r);
> +               rq->root_cfs_util_uclamp =
> +                       max(rq->root_cfs_util_uclamp, rq->cfs.avg.util_avg_uclamp);
> +#endif
>
>                 r = removed_runnable;
>                 sub_positive(&sa->runnable_avg, r);
> @@ -4527,6 +4538,7 @@ static void sync_entity_load_avg(struct sched_entity *se)
>  static void remove_entity_load_avg(struct sched_entity *se)
>  {
>         struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +       struct rq *rq = rq_of(cfs_rq);
>         unsigned long flags;
>
>         /*
> @@ -4542,6 +4554,9 @@ static void remove_entity_load_avg(struct sched_entity *se)
>         cfs_rq->removed.util_avg        += se->avg.util_avg;
>         cfs_rq->removed.load_avg        += se->avg.load_avg;
>         cfs_rq->removed.runnable_avg    += se->avg.runnable_avg;
> +#ifdef CONFIG_UCLAMP_TASK
> +       rq->root_cfs_util_uclamp_removed += se->avg.util_avg_uclamp;
> +#endif
>         raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
>  }
>
> @@ -6462,6 +6477,11 @@ static void update_se_chain(struct task_struct *p)
>                 struct cfs_rq *cfs_rq = cfs_rq_of(se);
>
>                 ___update_util_avg_uclamp(&cfs_rq->avg, se);
> +               if (&rq->cfs == cfs_rq) {
> +                       rq->root_cfs_util_uclamp = max(rq->root_cfs_util_uclamp,
> +                                                      cfs_rq->avg.util_avg_uclamp);
> +                       cfs_rq_util_change(cfs_rq, 0);
> +               }
>         }
>  #endif
>  }
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index c656e4dcb1d1..83d5ac7e7ddb 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -267,6 +267,57 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
>  }
>
>  #ifdef CONFIG_UCLAMP_TASK
> +static void ___decay_util_avg_uclamp_towards(u64 now,
> +                                            u64 last_update_time,
> +                                            u32 period_contrib,
> +                                            unsigned int *old,
> +                                            unsigned int new_val)
> +{
> +       unsigned int old_val = READ_ONCE(*old);
> +       u64 delta, periods;
> +
> +       if (old_val <= new_val) {
> +               WRITE_ONCE(*old, new_val);
> +               return;
> +       }
> +
> +       if (!last_update_time)
> +               return;
> +       delta = now - last_update_time;
> +       if ((s64)delta < 0)
> +               return;
> +       delta >>= 10;
> +       if (!delta)
> +               return;
> +
> +       delta += period_contrib;
> +       periods = delta / 1024;
> +       if (periods) {
> +               u64 diff = old_val - new_val;
> +
> +               /*
> +                * Let's assume 3 tasks, A, B and C. A is still on rq but B and
> +                * C have just been dequeued. The cfs.avg.util_avg_uclamp has
> +                * become A but root_cfs_util_uclamp just starts to decay and is
> +                * now still A + B + C.
> +                *
> +                * After p periods with y being the decay factor, the new
> +                * root_cfs_util_uclamp should become
> +                *
> +                * A + B * y^p + C * y^p == A + (A + B + C - A) * y^p
> +                *     == cfs.avg.util_avg_uclamp +
> +                *        (root_cfs_util_uclamp_at_the_start - cfs.avg.util_avg_uclamp) * y^p
> +                *     == cfs.avg.util_avg_uclamp + diff * y^p
> +                *
> +                * So, instead of summing up each individual decayed values, we
> +                * could just decay the diff and not bother with the summation
> +                * at all. This is why we decay the diff here.
> +                */
> +               diff = decay_load(diff, periods);
> +               WRITE_ONCE(*old, new_val + diff);
> +       }
> +}
> +
>  /* avg must belong to the queue this se is on. */
>  void ___update_util_avg_uclamp(struct sched_avg *avg, struct sched_entity *se)
>  {
> @@ -336,17 +387,33 @@ ___update_util_avg_uclamp(struct sched_avg *avg, struct sched_entity *se)
>
>  int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
>  {
> +       u64 last_update_time = se->avg.last_update_time;
> +       u32 period_contrib = se->avg.period_contrib;
> +       int ret = 0;
> +
>         if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
>                 ___update_load_avg(&se->avg, se_weight(se));
>                 trace_pelt_se_tp(se);
> -               return 1;
> +               ret = 1;
>         }
>
> -       return 0;
> +#ifdef CONFIG_UCLAMP_TASK
> +       if (entity_is_task(se))
> +               ___decay_util_avg_uclamp_towards(now,
> +                                                last_update_time,
> +                                                period_contrib,
> +                                                &se->avg.util_avg_uclamp,
> +                                                0);
> +#endif
> +       return ret;
>  }
>
>  int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> +       u64 last_update_time = se->avg.last_update_time;
> +       u32 period_contrib = se->avg.period_contrib;
> +       int ret = 0;
> +
>         if (___update_load_sum(now, &se->avg, !!se->on_rq, se_runnable(se),
>                                 cfs_rq->curr == se)) {
>
> @@ -354,14 +421,26 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
>                 ___update_util_avg_uclamp(&cfs_rq->avg, se);
>                 cfs_se_util_change(&se->avg);
>                 trace_pelt_se_tp(se);
> -               return 1;
> +               ret = 1;
>         }
>
> -       return 0;
> +#ifdef CONFIG_UCLAMP_TASK
> +       if (!se->on_rq && entity_is_task(se))
> +               ___decay_util_avg_uclamp_towards(now,
> +                                                last_update_time,
> +                                                period_contrib,
> +                                                &se->avg.util_avg_uclamp,
> +                                                0);
> +#endif
> +       return ret;
>  }
>
>  int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
>  {
> +       u64 last_update_time = cfs_rq->avg.last_update_time;
> +       u32 period_contrib = cfs_rq->avg.period_contrib;
> +       int ret = 0;
> +
>         if (___update_load_sum(now, &cfs_rq->avg,
>                                 scale_load_down(cfs_rq->load.weight),
>                                 cfs_rq->h_nr_running,
> @@ -369,10 +448,22 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
>
>                 ___update_load_avg(&cfs_rq->avg, 1);
>                 trace_pelt_cfs_tp(cfs_rq);
> -               return 1;
> +               ret = 1;
>         }
>
> -       return 0;
> +#ifdef CONFIG_UCLAMP_TASK
> +       if (&rq_of(cfs_rq)->cfs == cfs_rq) {
> +               unsigned int target = READ_ONCE(cfs_rq->avg.util_avg_uclamp);
> +
> +               ___decay_util_avg_uclamp_towards(now,
> +                               last_update_time,
> +                               period_contrib,
> +                               &rq_of(cfs_rq)->root_cfs_util_uclamp,
> +                               target);
> +       }
> +#endif
> +
> +       return ret;
>  }
>
>  /*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2eefcdb0c3b0..98fa5e79f4e9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -992,6 +992,8 @@ struct rq {
>         /* Utilization clamp values based on CPU's RUNNABLE tasks */
>         struct uclamp_rq        uclamp[UCLAMP_CNT] ____cacheline_aligned;
>         unsigned int            uclamp_flags;
> +       unsigned int            root_cfs_util_uclamp;
> +       unsigned int            root_cfs_util_uclamp_removed;
>  #define UCLAMP_FLAG_IDLE 0x01
>  #endif
>
> --
> 2.34.1
>

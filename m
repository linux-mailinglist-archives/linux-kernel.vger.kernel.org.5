Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B497591EE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjGSJr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGSJrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:47:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A0C1BFC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:47:19 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so10906736e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689760037; x=1690364837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q6km1N3QDvMLrFHM+xaKSuxTKuat8pnQJ2uvdkcsox0=;
        b=uFaikO9xKwghPdCHqDKUXGEbV8DH5dRLrSIz5FdoJiz9Uw92PWkhbwCFWuVnDkM6Sw
         R2hquTyKPtKOWszwpuj5WE/a3hRUCgpnwg6t/90bZEsnw8crUmHAmDlGi+ckTmc5CVqW
         hD8Ac7JtdSrBu5FPSbM8K9tuleWYwqyJFPzvZqibHHa/RKDoX9WaZqVNETLONKpwHGfy
         LHMUnU/aJJUlNY8+z6vL28OUbva8AaoRQ6CYifLGZEnoZnXhE6LX70Z4FtTHfdW1g5yy
         td9gThQYCyOoLX3ICXfl6edFUFwcXPNGeBoUIr3uyLVl5WmDDBzOKtKLbZHrb21umeOc
         /Lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689760037; x=1690364837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6km1N3QDvMLrFHM+xaKSuxTKuat8pnQJ2uvdkcsox0=;
        b=Iv3nOnH9cqZcksPnc+Z0ATcF141Qpz6WGfWjyH+kSRc+9JwurhGDYiDedLS9ruLxbS
         KBZ6AXNrqOR3XdrNA0OBFIGgEq6P5iwdMJxzlPq7ArXyKwbhpr1jHduGoml1AkSG5ahx
         joO+0MUmU3JmQGbKgPdjHWIgcDYeaD+TpfTvMJwNJufhM5uVPrN+vHzp7NGYlCsyKSqj
         f4mFNi+W6xbY9KC98OxIxh7biaoPjoJTZwYYVG07HnUEEITHpZQoN+U6oTkLU8fLxrNL
         DpFGyQJv5tLapc7OSM2pk1qN7ZYjXZauAI5EeYUIrLEfdIgYUxRhnFBHFO+d8Ur/1N8h
         +cZg==
X-Gm-Message-State: ABy/qLYGMNHPCdk2Xvi1ahTJIcqO2sOep/dWu2fsD6aQnIEj3YL9GqPm
        oSyvaVbS7Tl73+6ITeAgKi+IRQktljzEQEwZj2F/Ww==
X-Google-Smtp-Source: APBJJlGgQ2z/oGyWaKU+R2ZCWv6qOiMx9ZWcojS3hysuxFnsES585De/vvVvU5fCepSCek0BytYzGVPzHeH+4W46eSU=
X-Received: by 2002:a05:6512:108b:b0:4fb:8926:b137 with SMTP id
 j11-20020a056512108b00b004fb8926b137mr14146299lfg.33.1689760037461; Wed, 19
 Jul 2023 02:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230718134120.81199-1-aaron.lu@intel.com> <20230718134120.81199-4-aaron.lu@intel.com>
 <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com>
 <20230719051826.GB84059@ziqianlu-dell> <20230719080105.GA90441@ziqianlu-dell>
In-Reply-To: <20230719080105.GA90441@ziqianlu-dell>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Jul 2023 11:47:06 +0200
Message-ID: <CAKfTPtCnvOehfrz1OSW+rmkKW+28bdGw8fU+AvVrZTxkHibL_g@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 at 10:01, Aaron Lu <aaron.lu@intel.com> wrote:
>
> On Wed, Jul 19, 2023 at 01:18:26PM +0800, Aaron Lu wrote:
> > Alternatively, I can remove some callsites of update_tg_load_avg() like
> > you suggested below and only call update_tg_load_avg() when cfs_rq is
> > decayed(really just decayed, not when it detected it has removed load
> > pending or load propagated from its children). This way it would give us
> > similar result as above(roughly once per ms).
>
> Something like this: (I think this is better since it removed those
> unnecessary calls to update_tg_load_avg(), although it is inline but
> still)
>
>
> From bc749aaefa6bed36aa946921a4006b3dddb69b77 Mon Sep 17 00:00:00 2001
> From: Aaron Lu <aaron.lu@intel.com>
> Date: Wed, 19 Jul 2023 13:54:48 +0800
> Subject: [PATCH] sched/fair: only update_tg_load_avg() when cfs_rq decayed
>
> ---
>  kernel/sched/fair.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a80a73909dc2..7d5b7352b8b5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3913,16 +3913,16 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
>  }
>
>  /* Update task and its cfs_rq load average */
> -static inline int propagate_entity_load_avg(struct sched_entity *se)
> +static inline void propagate_entity_load_avg(struct sched_entity *se)
>  {
>         struct cfs_rq *cfs_rq, *gcfs_rq;
>
>         if (entity_is_task(se))
> -               return 0;
> +               return;
>
>         gcfs_rq = group_cfs_rq(se);
>         if (!gcfs_rq->propagate)
> -               return 0;
> +               return;
>
>         gcfs_rq->propagate = 0;
>
> @@ -3936,8 +3936,6 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
>
>         trace_pelt_cfs_tp(cfs_rq);
>         trace_pelt_se_tp(se);
> -
> -       return 1;
>  }
>
>  /*
> @@ -3974,9 +3972,8 @@ static inline bool skip_blocked_update(struct sched_entity *se)
>
>  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
>
> -static inline int propagate_entity_load_avg(struct sched_entity *se)
> +static inline void propagate_entity_load_avg(struct sched_entity *se)
>  {
> -       return 0;
>  }
>
>  static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum) {}
> @@ -4086,7 +4083,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  {
>         unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
>         struct sched_avg *sa = &cfs_rq->avg;
> -       int decayed = 0;
> +       int decayed;
>
>         if (cfs_rq->removed.nr) {
>                 unsigned long r;
> @@ -4134,11 +4131,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>                  */
>                 add_tg_cfs_propagate(cfs_rq,
>                         -(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT);
> -
> -               decayed = 1;
>         }
>
> -       decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
> +       decayed = __update_load_avg_cfs_rq(now, cfs_rq);
>         u64_u32_store_copy(sa->last_update_time,
>                            cfs_rq->last_update_time_copy,
>                            sa->last_update_time);
> @@ -4252,7 +4247,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>                 __update_load_avg_se(now, cfs_rq, se);
>
>         decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> -       decayed |= propagate_entity_load_avg(se);
> +       propagate_entity_load_avg(se);

but then you  also skip the call to cfs_rq_util_change()
>
>         if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
>
> @@ -4264,15 +4259,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
>         } else if (decayed) {
>                 cfs_rq_util_change(cfs_rq, 0);
>
> --
> 2.41.0
>

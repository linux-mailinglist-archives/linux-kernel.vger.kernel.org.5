Return-Path: <linux-kernel+bounces-94189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4D3873B15
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13FACB231BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCAE1353EC;
	Wed,  6 Mar 2024 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glyZ6U2t"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A571EF1C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740011; cv=none; b=S9182vE36RdCrT/EjrWLoZBrE5MUaACV8v7Sy2vgxMxqrc8+pYeMSUhXu1kUtj0pW8KtDVaD2aSQo/uZ8VXZPaX/WyS7lepQB6eTyu0krVnLC4ElYr+hwaTspl9+qS7GhbOoblmNkgmAaCO5wZ5p69dNGgu0nQuxkYyv0f0r5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740011; c=relaxed/simple;
	bh=WzHVlCnKIOv/vaanA5lJ8h9tIiuSZPhdFTtYwzsrDCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgR0NxNhMlsFWM0g01ynMskGQJn2wtqP8nO1+IqSV+LIGE+Fjbhj7eu/sW0El4pLmMpITAxuWwb4uHRXpDCsoD/Rx40GNBwfif3TyRa976priVxyZ8myzODqJre/2/8W7j49BIikAlGJIwhZfAEBr+htDS8j6YNxomyXGsE1t+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=glyZ6U2t; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29a5f100c1aso4306917a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709740009; x=1710344809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5gweCxqXk4S131YXuvxyq68tQVRRjvhJQnz+BcuSgxQ=;
        b=glyZ6U2tUQuKEpKE3OVUw9vD8TsnJUuJMJU80f69cqeBCOR5t1alm7BJzIYEo+AVJK
         ot2sC50ZCljCbicClarZ//mvT2oV1vaE4nIKMd0npzJyhDhUXKDDEuTqMcdWlvTGegmd
         c1Agkkj6Y/bLRWIjiWYWGVDuL4tkP6+zfcZmWyAIElPHJoPXwRobpLDc4arXtD01frzd
         nYoLl2/M09J+5iFUFy9x56Fvq9GSmJmpcUjnJFh3DphWD1gSEVAxG5kZO3tvlMGXi2yK
         ECcf5yCD7eXhM+4cYSS/uuCmHghSz9sYs8RbaxMNFN9WY4ij02KjZaGbV8ho5c0N5wVN
         bIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740009; x=1710344809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gweCxqXk4S131YXuvxyq68tQVRRjvhJQnz+BcuSgxQ=;
        b=JekVtP1Gfm77VDtXZ+UyYYhNFRAysvxQgQoN+tIuRw841a8dvc+1UYGp6DEc82GV/b
         rPDQOOWjrLQx7tQZx0gOLKYxAGpmFqRURR2oAfS/3YJy7JvvSc0ckSCpGmfuxbkIWxFv
         cTKrE0/P7lw6Ako70AXRZeh5bPT9Zp+tn8BBQjnGX+8CNGBeeAJ+4q8nCF1H77dpdFX3
         j69a5d+l63wm6w9LYzcZcX9fcjZPGT1tQNmTe2hq62LmA6V4eNiDPTHHqGk64QhUPs8v
         0hPugaNBK6u/9faPPjJuQ2OQOeYSSBCRHWwsQtJccaJTbNuZAx8uhobNZUsFCKghszfB
         Gj0w==
X-Gm-Message-State: AOJu0YzKptO8hduLK/qrV22Ni/HL7yVi4RFxOds/ji/vbFuGECBusuiS
	b5Lpun+gmvB3xv23cGbuYmvxlf6JrQ+4VvjMblaFZBV/gjcxuNND1A5V3DvBAPx61Vm3lj1tOsL
	/sun2QwKQlFwLLqade5KNaUrxEZh6mE6q2aBECw==
X-Google-Smtp-Source: AGHT+IGNl/Kdsf5L4RChWua3lySyLGeuihuSCg8CfxmXsjrp44HpHTa9Rq7pPmWzy+9CUc/UYpH/6Y+s6ZlpdJcou+g=
X-Received: by 2002:a17:90b:1bd0:b0:29b:3d08:c644 with SMTP id
 oa16-20020a17090b1bd000b0029b3d08c644mr9332259pjb.9.1709740009462; Wed, 06
 Mar 2024 07:46:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304094831.3639338-1-mingo@kernel.org> <20240304094831.3639338-4-mingo@kernel.org>
In-Reply-To: <20240304094831.3639338-4-mingo@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 6 Mar 2024 16:46:38 +0100
Message-ID: <CAKfTPtCu=_ys+FFTqKfZbu9f_yD69fN7L3nETykEK3y9TW3BmQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] sched/balancing: Change 'enum cpu_idle_type' to have
 more natural definitions
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 10:48, Ingo Molnar <mingo@kernel.org> wrote:
>
> The cpu_idle_type enum has the confusingly inverted property
> that 'not idle' is 1, and 'idle' is '0'.
>
> This resulted in a number of unnecessary complications in the code.
>
> Reverse the order, remove the CPU_NOT_IDLE type, and convert
> all code to a natural boolean form.
>
> It's much more readable:
>
>   -       enum cpu_idle_type idle = this_rq->idle_balance ?
>   -                                               CPU_IDLE : CPU_NOT_IDLE;
>   -
>   +       enum cpu_idle_type idle = this_rq->idle_balance;
>
>   --------------------------------
>
>   -       if (env->idle == CPU_NOT_IDLE || !busiest->sum_nr_running)
>   +       if (!env->idle || !busiest->sum_nr_running)
>
>   --------------------------------
>
> And gets rid of the double negation in these usages:
>
>   -               if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1)
>   +               if (env->idle && env->src_rq->nr_running <= 1)
>
> Furthermore, this makes code much more obvious where there's
> differentiation between CPU_IDLE and CPU_NEWLY_IDLE.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Valentin Schneider <vschneid@redhat.com>
> ---
>  include/linux/sched/idle.h |  3 +--
>  kernel/sched/fair.c        | 27 ++++++++++++---------------
>  2 files changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
> index 478084f9105e..4a6423700ffc 100644
> --- a/include/linux/sched/idle.h
> +++ b/include/linux/sched/idle.h
> @@ -5,8 +5,7 @@
>  #include <linux/sched.h>
>
>  enum cpu_idle_type {
> -       CPU_IDLE,
> -       CPU_NOT_IDLE,

Could be set CPU_NOT_IDLE = 0  to help keeping in mind that 0 means
cpu is not idle even if we don't use it ?

> +       CPU_IDLE = 1,
>         CPU_NEWLY_IDLE,
>         CPU_MAX_IDLE_TYPES
>  };
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 64ae3d8dc93b..f11fc6dd39b1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9070,7 +9070,7 @@ static int detach_tasks(struct lb_env *env)
>                  * We don't want to steal all, otherwise we may be treated likewise,
>                  * which could at worst lead to a livelock crash.
>                  */
> -               if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1)
> +               if (env->idle && env->src_rq->nr_running <= 1)
>                         break;
>
>                 env->loop++;
> @@ -9803,7 +9803,7 @@ static inline bool smt_vs_nonsmt_groups(struct sched_group *sg1,
>  static inline bool smt_balance(struct lb_env *env, struct sg_lb_stats *sgs,
>                                struct sched_group *group)
>  {
> -       if (env->idle == CPU_NOT_IDLE)
> +       if (!env->idle)
>                 return false;
>
>         /*
> @@ -9827,7 +9827,7 @@ static inline long sibling_imbalance(struct lb_env *env,
>         int ncores_busiest, ncores_local;
>         long imbalance;
>
> -       if (env->idle == CPU_NOT_IDLE || !busiest->sum_nr_running)
> +       if (!env->idle || !busiest->sum_nr_running)
>                 return 0;
>
>         ncores_busiest = sds->busiest->cores;
> @@ -9927,8 +9927,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                                 sgs->group_misfit_task_load = rq->misfit_task_load;
>                                 *sg_status |= SG_OVERLOAD;
>                         }
> -               } else if ((env->idle != CPU_NOT_IDLE) &&
> -                          sched_reduced_capacity(rq, env->sd)) {
> +               } else if (env->idle && sched_reduced_capacity(rq, env->sd)) {
>                         /* Check for a task running on a CPU with reduced capacity */
>                         if (sgs->group_misfit_task_load < load)
>                                 sgs->group_misfit_task_load = load;
> @@ -9940,7 +9939,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>         sgs->group_weight = group->group_weight;
>
>         /* Check if dst CPU is idle and preferred to this group */
> -       if (!local_group && env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> +       if (!local_group && env->idle && sgs->sum_h_nr_running &&
>             sched_group_asym(env, sgs, group))
>                 sgs->group_asym_packing = 1;
>
> @@ -10698,7 +10697,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>                          * waiting task in this overloaded busiest group. Let's
>                          * try to pull it.
>                          */
> -                       if (env->idle != CPU_NOT_IDLE && env->imbalance == 0) {
> +                       if (env->idle && env->imbalance == 0) {
>                                 env->migration_type = migrate_task;
>                                 env->imbalance = 1;
>                         }
> @@ -10913,7 +10912,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>                 goto force_balance;
>
>         if (busiest->group_type != group_overloaded) {
> -               if (env->idle == CPU_NOT_IDLE) {
> +               if (!env->idle) {
>                         /*
>                          * If the busiest group is not overloaded (and as a
>                          * result the local one too) but this CPU is already
> @@ -11121,7 +11120,7 @@ asym_active_balance(struct lb_env *env)
>          * the lower priority @env::dst_cpu help it. Do not follow
>          * CPU priority.
>          */
> -       return env->idle != CPU_NOT_IDLE && sched_use_asym_prio(env->sd, env->dst_cpu) &&
> +       return env->idle && sched_use_asym_prio(env->sd, env->dst_cpu) &&
>                (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
>                 !sched_use_asym_prio(env->sd, env->src_cpu));
>  }
> @@ -11159,7 +11158,7 @@ static int need_active_balance(struct lb_env *env)
>          * because of other sched_class or IRQs if more capacity stays
>          * available on dst_cpu.
>          */
> -       if ((env->idle != CPU_NOT_IDLE) &&
> +       if (env->idle &&
>             (env->src_rq->cfs.h_nr_running == 1)) {
>                 if ((check_cpu_capacity(env->src_rq, sd)) &&
>                     (capacity_of(env->src_cpu)*sd->imbalance_pct < capacity_of(env->dst_cpu)*100))
> @@ -11735,8 +11734,8 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
>                                  * env->dst_cpu, so we can't know our idle
>                                  * state even if we migrated tasks. Update it.
>                                  */
> -                               idle = idle_cpu(cpu) ? CPU_IDLE : CPU_NOT_IDLE;
> -                               busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
> +                               idle = idle_cpu(cpu);
> +                               busy = !idle && !sched_idle_cpu(cpu);
>                         }
>                         sd->last_balance = jiffies;
>                         interval = get_sd_balance_interval(sd, busy);
> @@ -12416,9 +12415,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
>  {
>         struct rq *this_rq = this_rq();
> -       enum cpu_idle_type idle = this_rq->idle_balance ?
> -                                               CPU_IDLE : CPU_NOT_IDLE;
> -
> +       enum cpu_idle_type idle = this_rq->idle_balance;
>         /*
>          * If this CPU has a pending nohz_balance_kick, then do the
>          * balancing on behalf of the other idle CPUs whose ticks are
> --
> 2.40.1
>


Return-Path: <linux-kernel+bounces-95883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C380F875487
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798D5284CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C9812FB0D;
	Thu,  7 Mar 2024 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CNmBpf27"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E817AE43
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830260; cv=none; b=nnf6Y9XMt3oZQORRObo/sosebCqeZmoTza091CFs/FpzfyOepMmmoG9kuRgJWYvkqaLIYu1ZPevU+kV1JoOTITQSUwUuZl3LR1CJg0t5IwnjOmBQL0PfB42+UUs4DAJEXED6jSyeq1e4Yf8RxT19byhq4i4rjU/DKoe3YCuK5+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830260; c=relaxed/simple;
	bh=cDg7BLE3fcUKhWVulwdNMzB+xKXZ9swBkar0n40qnFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fk+7/QeHVF+swoK7Zemc2YxGM7XEXcRopxeMv/cqjKhMETqTFzuy+Qooo5WZpTkbQMbBXOv00hTkf+33aIFnSsoeiZxeuNc8iwAHcyyK9VNQVWi04hb3zyd9Yed31SQzg6sBrxifvHJtKnX92ieub7DbsmF+8nytPZr8ixbdmwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CNmBpf27; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so709730a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 08:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709830258; x=1710435058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+2EL+36/QM0SPYJ1Yjq4H+n/RkoUib4NeLlBdPXO/Vc=;
        b=CNmBpf27xr16E/xm6fXXnVYE6JWHnn8QkPt6USsGGZCCU6OmwHpySOmZwgS2ocjMct
         y1u9EDpu8FdG7YMRdw7j3ZBExUOD9FSMdVBwWoSdD/ULT03bT8sqH0uyX2r7FFvvPmcW
         vjH7SCJnVyQkqSaDtmSyCeBrWEMra30+DFZQvF0ZZ2Qqf7/aOcaSTxZw1/BGLCRlF+5n
         jO9hmcu15ciABsAnHHUYn9gODKYw7ObsAGbdvTea33jZb0Hvu7j8Q6hMkritKsffmjkY
         mOs0WmJoUeM8AJk1xphcKyTRlDXVSY5ceITHNgW7pNtUcCG81iJacB+aLgKqKuCH6N0L
         RBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709830258; x=1710435058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2EL+36/QM0SPYJ1Yjq4H+n/RkoUib4NeLlBdPXO/Vc=;
        b=PlJUaDHzjWRcgPM4BYwcd2TiQMazKrsbVbc8yNUJe7wZXJEVrBSG+qoSLwgPvDxgaG
         ERdX1zMo86SnuuNYddrtN2CNC8nQy7Q86qFcCZCLY7Q07ZmyPtGZZqSPm99Hl8Co4+5P
         JeWV/dSNRUu0h7J+qrfWttOU8UBf4QHHPbYA7OLOzbmoGJKkcuhOQHaSN2GslNJPQ5Km
         MZ2GLEYJ2AwpkBqDvEmX9TD/uH5tA3pJugjCkzqNTRsh806uOJ538aVz+DpK8xxug0hF
         9VoWew2kIAhMGPCkQxfMD4q8yBFwQTn/O5HQJ0rs2HH3HDKV1ACqvvQRMvHSX+ma2Zqq
         aHlw==
X-Forwarded-Encrypted: i=1; AJvYcCU8PtRKwWtcOCPGq/NsLCrwt7a4nLs66iYrbQHj+aZwdriqJQHp1r7nU9bz1A9Roh/FzSuiASIIHFaeqTqsy/p1GA0CNNm6H24+/UxR
X-Gm-Message-State: AOJu0YwpqRAeLuEP7F1hHdSPnkScuoyYnxlLvUqBM/JKtVIYamlf+iEm
	0pYq/oYK2Tx/DUPxzkw2z0eVlikix18JdmX8mlY2Ac0DTCgRJEm4ZzSWcf6vbTfSXd8KpR8mUTU
	LXe/+N2O1jEzzMwDnPh+NthlUDawRKJ+VH8Kftg==
X-Google-Smtp-Source: AGHT+IHSnsjlea2bY/kzFtJY+SzGlSQzGtgrgjB2eUI5lJjJcb2+1sns5qQYCZYmWqxEBtkwkGxHsqBBYvCGRXKYrwc=
X-Received: by 2002:a17:90a:de18:b0:29a:97f5:9970 with SMTP id
 m24-20020a17090ade1800b0029a97f59970mr14151303pjv.45.1709830256753; Thu, 07
 Mar 2024 08:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307085725.444486-1-sshegde@linux.ibm.com> <20240307085725.444486-2-sshegde@linux.ibm.com>
In-Reply-To: <20240307085725.444486-2-sshegde@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 7 Mar 2024 17:50:43 +0100
Message-ID: <CAKfTPtDauh-QEyyR2T8=zcbWe5vzndZKj3=+3TZFceYkizjXaw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] sched/fair: Add EAS checks before updating overutilized
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, yu.c.chen@intel.com, 
	dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, nysal@linux.ibm.com, 
	aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com, 
	pierre.gondois@arm.com, qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 09:57, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> Overutilized field of root domain is only used for EAS(energy aware scheduler)
> to decide whether to do load balance or not. It is not used if EAS
> not possible.
>
> Currently enqueue_task_fair and task_tick_fair accesses, sometime updates
> this field. In update_sd_lb_stats it is updated often. This causes cache
> contention due to true sharing and burns a lot of cycles. overload and
> overutilized are part of the same cacheline. Updating it often invalidates
> the cacheline. That causes access  to overload to slow down due to
> false sharing. Hence add EAS check before accessing/updating this field.
> EAS check is optimized at compile time or it is a static branch.
> Hence it shouldn't cost much.
>
> With the patch, both enqueue_task_fair and newidle_balance don't show
> up as hot routines in perf profile.
>
> 6.8-rc4:
> 7.18%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
> 6.78%  s                [kernel.vmlinux]              [k] newidle_balance
> +patch:
> 0.14%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
> 0.00%  swapper          [kernel.vmlinux]              [k] newidle_balance
>
> Minor change: trace_sched_overutilized_tp expect that second argument to
> be bool. So do a int to bool conversion for that.
>
> Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
> Reviewed-by: Qais Yousef <qyousef@layalina.io>
> Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> ---
>  kernel/sched/fair.c | 53 +++++++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6a16129f9a5c..5aa6e918598c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6663,22 +6663,42 @@ static inline void hrtick_update(struct rq *rq)
>  #ifdef CONFIG_SMP
>  static inline bool cpu_overutilized(int cpu)
>  {
> -       unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> -       unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> +       unsigned long  rq_util_min, rq_util_max;
> +
> +       if (!sched_energy_enabled())
> +               return false;
> +
> +       rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> +       rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
>
>         /* Return true only if the utilization doesn't fit CPU's capacity */
>         return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
>  }
>
> -static inline void update_overutilized_status(struct rq *rq)
> +static inline void set_rd_overutilized_status(struct root_domain *rd,
> +                                             unsigned int status)
>  {
> -       if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
> -               WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
> -               trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
> -       }
> +       if (!sched_energy_enabled())
> +               return;
> +
> +       WRITE_ONCE(rd->overutilized, status);
> +       trace_sched_overutilized_tp(rd, !!status);
> +}
> +
> +static inline void check_update_overutilized_status(struct rq *rq)
> +{
> +       /*
> +        * overutilized field is used for load balancing decisions only
> +        * if energy aware scheduler is being used
> +        */
> +       if (!sched_energy_enabled())
> +               return;
> +
> +       if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
> +               set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
>  }
>  #else
> -static inline void update_overutilized_status(struct rq *rq) { }
> +static inline void check_update_overutilized_status(struct rq *rq) { }
>  #endif
>
>  /* Runqueue only has SCHED_IDLE tasks enqueued */
> @@ -6779,7 +6799,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>          * and the following generally works well enough in practice.
>          */
>         if (!task_new)
> -               update_overutilized_status(rq);
> +               check_update_overutilized_status(rq);
>
>  enqueue_throttle:
>         assert_list_leaf_cfs_rq(rq);
> @@ -10596,19 +10616,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>                 env->fbq_type = fbq_classify_group(&sds->busiest_stat);
>
>         if (!env->sd->parent) {
> -               struct root_domain *rd = env->dst_rq->rd;
> -
>                 /* update overload indicator if we are at root domain */
> -               WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
> +               WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
>
>                 /* Update over-utilization (tipping point, U >= 0) indicator */
> -               WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
> -               trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
> +               set_rd_overutilized_status(env->dst_rq->rd,
> +                                          sg_status & SG_OVERUTILIZED);
>         } else if (sg_status & SG_OVERUTILIZED) {
> -               struct root_domain *rd = env->dst_rq->rd;
> -
> -               WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
> -               trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
> +               set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
>         }
>
>         update_idle_cpu_scan(env, sum_util);
> @@ -12609,7 +12624,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>                 task_tick_numa(rq, curr);
>
>         update_misfit_status(curr, rq);
> -       update_overutilized_status(task_rq(curr));
> +       check_update_overutilized_status(task_rq(curr));
>
>         task_tick_core(rq, curr);
>  }
> --
> 2.39.3
>


Return-Path: <linux-kernel+bounces-95885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A95A87548D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E345B228BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F41B12FF90;
	Thu,  7 Mar 2024 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rbuWuVd2"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D282A12FB0D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830270; cv=none; b=fIz+qKim9jcjOSXuKd3I0k/99E2VoEzh+A601hPlfq0dNmXtdGc7/9NSWtaNjRg5Y1+wPONVyhB3Ryu+U2TqjVyIPZ7BWxzNAuVoZry5TLCBuMSAYoWXb8uN2ZtWe41ZGEB8IxXf4id54KzEagnJkLje38BwJfXd0nIO9aO0oeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830270; c=relaxed/simple;
	bh=yWoN7kMXPJ1+jbDqJWHNPeW5N/s3MWg1CoEk+cIJmbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0O3ZfftMrFpO8r2RyLJEoCPzn3XPLW8Ujn/Gs9bduAJn1zvJQV5DUOA438QtVthYUAOTB/A6NVTaSNWI00PT+QFWM9V138qsvDb6nX2BfTee/C5VYIAeLNjLfDT73rCtrd17n837Xmp6VIZGMdRwSDAWHIAkAXXo+YfC1Z+jk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rbuWuVd2; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e649a2548cso1028154b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 08:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709830268; x=1710435068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wnra5m+sq3wWPvqWL6tYqfrszmGzJT5oM76OsNcwHZ0=;
        b=rbuWuVd2WgP5l+OHA2PAeWut6yjAkfhQEj4NwrrMwv38Eb6nul0He7gRubb/8I/4vT
         AvJBAOszVG15YsF4z5XOJHwrpKvlmv8c9w8yNjSOejgzwOgicW+tTP83rsTuoVxJ7ee6
         Gs/DY1swrV9LBmS0pV4v+ygYnWTRpMs0bkCcQHmABZi33GKT26AxhuTEd9L8wbrzBL9T
         A2IqhCAJOwZa+0eQGPQum4lUXvrwQjfJxJioiazMWCYC3P2vrubygFvKVkYxi6A1kFnZ
         d0GXsx7knuNhYQna77vpxPHhaFGF3rz6jb/NpcjZaI3/OIOb5S0x1wQcAeR5NG1k0l+x
         +zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709830268; x=1710435068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wnra5m+sq3wWPvqWL6tYqfrszmGzJT5oM76OsNcwHZ0=;
        b=hQ13E1LOBNOCzYhp0aCTdZRjUIppko8Zm9HmRyCLl7rjOfpGriKsn6Duz/q0ddyycQ
         TfNPaSSCsMLBU1SfVSNcxIGDr7lbrXeJN0iJAQOBKDUX3ce/N0p7IpyTqUCI+JfIW/9Q
         N3J8hKP5qqyaJ9BVPPaRM/isXLTd5EpzM3tIbBt+wcMTFBXWftEF/fX7jtpIS8PnDnKp
         EWd6b/UR7FTvbqJrxzg+5Rkow1/Xyoe1FE87Juki8NnoLAyTnVyIrChBJ05h9S/9lPdh
         kACBLOxFXF0J1mf/ytAq9iQVez61IBYYkSwu6iFiuryW91d8hw+KycTy6TlIBo5sA6Ex
         AxQA==
X-Forwarded-Encrypted: i=1; AJvYcCW2koUVHC1uZFmEAQYQxthZKGaMXrksUEO2+Gte9fNyOc+hH9RQxkySYs7L5zFdFAmEkaKrXQ1gwK6Y8yN5GGAU2FTeTFP/D8S3pBFN
X-Gm-Message-State: AOJu0YxKbUQfLj6Ft5tkNkbkpS+6JuYOQXYhzLg/RUF6/B6lOnj/5OtO
	MHzQARDrrUsahC/JMOi66TiZaU+7Z2kGhIL7+9gz/oIoW44Xy5pj5VEmVA67TpRj5UqnYHQ9ZCR
	cuUohA0vFcWRQmLKJmuK36D9r4viSjEa7v//dvw==
X-Google-Smtp-Source: AGHT+IGWiCtikINcXQC5UYYAtVCH7LWwyXLjtB4t2oNJeFVmf12w/bWgGO/Er+FIlyaQ7rwIB5vTmXIBgk3xQgeNOx0=
X-Received: by 2002:a05:6a20:8f18:b0:1a1:6b2c:873e with SMTP id
 b24-20020a056a208f1800b001a16b2c873emr5788398pzk.13.1709830268191; Thu, 07
 Mar 2024 08:51:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307085725.444486-1-sshegde@linux.ibm.com> <20240307085725.444486-4-sshegde@linux.ibm.com>
In-Reply-To: <20240307085725.444486-4-sshegde@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 7 Mar 2024 17:50:57 +0100
Message-ID: <CAKfTPtD0BmFFc+Hce-iwDXF5+P1jm16+sW74-u0WZO1-9x5=eQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] sched/fair: Combine EAS check with overutilized access
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, yu.c.chen@intel.com, 
	dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, nysal@linux.ibm.com, 
	aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com, 
	pierre.gondois@arm.com, qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 09:58, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> Access to overutilized is always used with sched_energy_enabled in
> the pattern:
>
> if (sched_energy_enabled && !overutilized)
>        do something
>
> So modify the helper function to return this pattern. This is more
> readable code as it would say, do something when root domain is not
> overutilized.
>
> No change in functionality intended.
>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> ---
>  kernel/sched/fair.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 87e08a252f94..bcda18a2ccfe 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6676,12 +6676,11 @@ static inline bool cpu_overutilized(int cpu)
>  }
>
>  /*
> - * Ensure that caller can do EAS. overutilized value
> - * make sense only if EAS is enabled
> + * overutilized value make sense only if EAS is enabled
>   */
> -static inline int is_rd_overutilized(struct root_domain *rd)
> +static inline int is_rd_not_overutilized(struct root_domain *rd)
>  {
> -       return READ_ONCE(rd->overutilized);
> +       return sched_energy_enabled() && !READ_ONCE(rd->overutilized);
>  }
>
>  static inline void set_rd_overutilized_status(struct root_domain *rd,
> @@ -6700,10 +6699,8 @@ static inline void check_update_overutilized_status(struct rq *rq)
>          * overutilized field is used for load balancing decisions only
>          * if energy aware scheduler is being used
>          */
> -       if (!sched_energy_enabled())
> -               return;
>
> -       if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
> +       if (is_rd_not_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
>                 set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
>  }
>  #else
> @@ -7989,7 +7986,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>
>         rcu_read_lock();
>         pd = rcu_dereference(rd->pd);
> -       if (!pd || is_rd_overutilized(rd))
> +       if (!pd)
>                 goto unlock;
>
>         /*
> @@ -8192,7 +8189,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>                     cpumask_test_cpu(cpu, p->cpus_ptr))
>                         return cpu;
>
> -               if (sched_energy_enabled()) {
> +               if (is_rd_not_overutilized(this_rq()->rd)) {
>                         new_cpu = find_energy_efficient_cpu(p, prev_cpu);
>                         if (new_cpu >= 0)
>                                 return new_cpu;
> @@ -10869,12 +10866,9 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>         if (busiest->group_type == group_misfit_task)
>                 goto force_balance;
>
> -       if (sched_energy_enabled()) {
> -               struct root_domain *rd = env->dst_rq->rd;
> -
> -               if (rcu_dereference(rd->pd) && !is_rd_overutilized(rd))
> -                       goto out_balanced;
> -       }
> +       if (is_rd_not_overutilized(env->dst_rq->rd) &&
> +           rcu_dereference(env->dst_rq->rd->pd))
> +               goto out_balanced;
>
>         /* ASYM feature bypasses nice load balance check */
>         if (busiest->group_type == group_asym_packing)
> --
> 2.39.3
>


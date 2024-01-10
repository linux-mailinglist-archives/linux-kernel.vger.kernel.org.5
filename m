Return-Path: <linux-kernel+bounces-22521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CD7829EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54CB9B225D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DA24D10E;
	Wed, 10 Jan 2024 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZJbBBT6"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FA947A48
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbebe6191bso3968430b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704907275; x=1705512075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ixiqCJ7toFC2ykhZEFAjNRDsHVRvZatAv23Lu2SKRPc=;
        b=fZJbBBT6kteGFSnn65Zpbt8Iziq2EzCSy6X9Q+7U3rZ6ix83e8XGl249g4cyAQ4UB3
         B6Aep2/+tpzyJ1NWJimeQpSbRn9tsd4vagQ+lkX38i2n3UC/9xg+1OJzBFH8bCYelRpU
         e3l6YkWjkpxvJsvONZrwvF4NTSuDhWijXqg8pP5SvB3Oc3Vr1l/vltNtmxg2W+BpgsTg
         mKU1wRqyBVpwRSgT9ArLJETTVV0bfY5fBVFwve8A1P/2a8SF4/1YbDSfmsCldW926FOC
         SSXjq1qDS59ERHG+XYS29k6/oVsh3gYTAribKEUpxVOJdwGqlzu2AiD7AWVX0BwV1v2J
         IyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704907275; x=1705512075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixiqCJ7toFC2ykhZEFAjNRDsHVRvZatAv23Lu2SKRPc=;
        b=LZFYMSyUYEcDV6God1mqAW80C1gZqkTvlUC65VKjLx/VJsgxGUg8WPxaut4iOV5YnF
         ueBspHrBJPikH8lyc5FOxhv6jqS1CQH+N/rtfiGeWQYLVc0Y0Rf2elOJKdgNcAZYgc9b
         XsHdjwVFm6MLjBdPEpJ5F3tSwBhE1I9E9T7tTkaRM3SGMT08hZXnIFAR49pb8LtPTDEj
         ot1PILVQsewJqPdZEFALwnpYUl5FoSAqMaxpnYM+9C4x0MZRKuXS3TMn9mlaYSNaBCpS
         TfjJc5vP9Nurg8U3NNFhQVMAi5v9x0oW0VRRwWiAAV1V1H9odvf+bXJAH6VR1iGiF5yl
         jMvA==
X-Gm-Message-State: AOJu0YxHjCxOLpDaYD6qLNIiSI85lz/ib32bqF4EE7VBYqb5K4IEj8sP
	5eTJm0bJy2sSwidqJdAxuaUt69H1lZ4JRLUqoFQw0zfbayK/RQ==
X-Google-Smtp-Source: AGHT+IFIQfvSC24ftaZP9nwJm+WZ1GHoxQsWlGy4sQ7nD9VzS7S3Bz6fQD7zkm1FIE2AXWgu0eLrSClVlwxCs3hr1CM=
X-Received: by 2002:a05:6808:e82:b0:3bc:29c2:2b97 with SMTP id
 k2-20020a0568080e8200b003bc29c22b97mr1504352oil.88.1704907274742; Wed, 10 Jan
 2024 09:21:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110131707.437301-1-keisuke.nishimura@inria.fr>
In-Reply-To: <20240110131707.437301-1-keisuke.nishimura@inria.fr>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 10 Jan 2024 18:21:02 +0100
Message-ID: <CAKfTPtCgqkUUtWMknyHrNeb994V_L4T9bxV9A=bUXCQu-+S1SQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2 RESEND] sched/fair: take into account scheduling
 domain in select_idle_smt()
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Julia Lawall <julia.lawall@inria.fr>, 
	Xunlei Pang <xlpang@linux.alibaba.com>, Abel Wu <wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 14:19, Keisuke Nishimura
<keisuke.nishimura@inria.fr> wrote:
>
> When picking out a CPU on a task wakeup, select_idle_smt() has to take
> into account the scheduling domain of @target. This is because the
> "isolcpus" kernel command line option can remove CPUs from the domain to
> isolate them from other SMT siblings.
>
> This fix checks if the candidate CPU is in the target scheduling domain.
>
> The commit df3cb4ea1fb6 ("sched/fair: Fix wrong cpu selecting from isolated
> domain") originally proposed this fix by adding the check of the scheduling
> domain in the loop. However, the commit 3e6efe87cd5cc ("sched/fair: Remove
> redundant check in select_idle_smt()") accidentally removed the check.
> This commit brings the check back.
>
> Fixes: 3e6efe87cd5c ("sched/fair: Remove redundant check in select_idle_smt()")
> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
> ---
> v2: - Changed the log message to mention only isolcpus
>     - Moved the check in the loop according to the original fix
>
>  kernel/sched/fair.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 533547e3c90a..66457d4b8965 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7311,13 +7311,19 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>  /*
>   * Scan the local SMT mask for idle CPUs.
>   */
> -static int select_idle_smt(struct task_struct *p, int target)
> +static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>         int cpu;
>
>         for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
>                 if (cpu == target)
>                         continue;
> +               /*
> +                * Check if the CPU is in the LLC scheduling domain of @target.
> +                * Due to isolcpus, there is no guarantee that all the siblings are in the domain.
> +                */
> +               if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))

commit df3cb4ea1fb6 ("sched/fair: Fix wrong cpu selecting from isolated domain")
also checked if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||

Why didn't you also re-add this test ?


> +                       continue;
>                 if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>                         return cpu;
>         }
> @@ -7341,7 +7347,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
>         return __select_idle_cpu(core, p);
>  }
>
> -static inline int select_idle_smt(struct task_struct *p, int target)
> +static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>         return -1;
>  }
> @@ -7591,7 +7597,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>                 has_idle_core = test_idle_cores(target);
>
>                 if (!has_idle_core && cpus_share_cache(prev, target)) {
> -                       i = select_idle_smt(p, prev);
> +                       i = select_idle_smt(p, sd, prev);
>                         if ((unsigned int)i < nr_cpumask_bits)
>                                 return i;
>                 }
> --
> 2.34.1
>


Return-Path: <linux-kernel+bounces-78013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E5B860DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006871C2346E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5335B69A;
	Fri, 23 Feb 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWpadWqj"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA022067
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680630; cv=none; b=rERQZtzLX0toD/6IbYEgFcoSAg3u/DV66qywbmWR0IK/us9tnBizyOrRNH+ZRvrN250ZoVmurV8Aa4CBAyHvVYvo14LAzfajpNVHS6ijaeer2TaxiDupEkrV+flSOk1vRJzQnABnMwQtN5o+9zYjie4WMFO8Nyv5QB/hgY32k9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680630; c=relaxed/simple;
	bh=Ybf/MDaCPTNpKGaepdYl0XIKX/UWt3G1dxR6vgL+XJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oz8l7T9rFg/nWT6QNKeM1q7tnYTJv/Wi4FtQcH28iQsH3KYF29ywS1QGrDbNbNp4bY5rqKy6/3NXbNMiXmvpqhIa/gXXI5d9uTMP1pq9xumWP+bunCTUzFxNnKv/AbTmhUiqrJH0AEaYIA2V8L7MhIvlXWQ2DTPf0EW/ohivOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dWpadWqj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e43ee3f6fbso481551b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708680628; x=1709285428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iXfQlP+2csLP0kLMIi0ta6O+uknjSiZBPO+UL1Pbr5U=;
        b=dWpadWqjlm7BjoFvTa62rFSaRXZ9w27wjP+WQobufjqMDMLv8mGH2dOfMyofhe/gJc
         VqHIckUBR9lG9S4ZajCYeH4CjuiUxuehNvtuyIBW9yXqxhN6RHdJmwvLRhRODe5blbxa
         3/4CA3OdnBjSQmHldHrHQCFWuRCmOhpZswvt9HtdmssAQsltjIJSiFXspCnYe8L+YLKB
         1P3o1c//VJnSKFzw7BckREVZIlFE3NhQ63zclVx4+h/220YdepZu/JST/OIdkQYQi8xe
         NgkA3ws0SsJuXLQnO1bMvZADAPC3A+ex0VgOuW7anNWPp+6RvLm8YquXuovAIwf5e6p3
         YNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708680628; x=1709285428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXfQlP+2csLP0kLMIi0ta6O+uknjSiZBPO+UL1Pbr5U=;
        b=IY3YblvNYwFNkeK+/WGcN37tLioPQ49gocRbVRpKZLeUwuC8969OX24pUjYMbvBPSP
         u2shk03avGh6GXjqQ7JOAZuqjJqcKkbHqoWEsZxZtmeA4t1dkRqWtgRIueay35x1KkLO
         g1aAqOpfiFvA1CFuM7LnrED/mj1zGFU90HtE6c4BV92OPy0KE9aia71Y3IOKX0RO+8fx
         Arwauky7d4CqkWe1PYO5KrVTWioc7C+J4Hv80jLez6tAWEQAVbkszF0narWBCsKrzfcy
         hXq54vdnxBUNMoKLixNNdoJFK/Bhp4dOH4IQCGk4m3Mm3wdMqynymoggF12XmPVaMqNA
         DJRw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ6CL9js54UGgLwRZ37wOgIzNGzddulL7bJYRXuXdixyrA93trTOnIP5EgpXtw7DZpU26shnqlegDAM7M4Lyvkqd++CY2w9z0Y2qAy
X-Gm-Message-State: AOJu0YzhPsIE0hluRmU1lxQ1ksFNubnERaemUhrEA/a+Zvlz5hH7du3/
	g43/KPJNgWgoWuDuJ0TuYhuLDFyVfRJ7L58Cg1qOA9NNd7QrlZHMeB3oUdSRbBQ2Zqd8vaLvldZ
	fs6noDr1wIzHUW4uDvlMmvl9Ygw08ZjYmITYHjg==
X-Google-Smtp-Source: AGHT+IHwPSCmicn73azwzD9AX9/PJWgTdtmQL8RntkH8tMfb8wmHx9dxPUsURB3bZ+rJi9eWhI3QPTPqlkzVkJIQ24w=
X-Received: by 2002:a05:6a20:e188:b0:1a0:e4ae:34c2 with SMTP id
 ks8-20020a056a20e18800b001a0e4ae34c2mr193315pzb.50.1708680628248; Fri, 23 Feb
 2024 01:30:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220225622.2626569-1-qyousef@layalina.io> <20240220225622.2626569-2-qyousef@layalina.io>
In-Reply-To: <20240220225622.2626569-2-qyousef@layalina.io>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 23 Feb 2024 10:30:16 +0100
Message-ID: <CAKfTPtD+N1b9h3sJyAmyj38WM4fODXUgyHHAyV4UMax438WGHA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] sched/topology: Export asym_capacity_list
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	Pierre Gondois <Pierre.Gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 23:56, Qais Yousef <qyousef@layalina.io> wrote:
>
> So that we can use it to iterate through available capacities in the
> system. Sort asym_cap_list in descending order as expected users are
> likely to be interested on the highest capacity first.
>
> Make the list RCU protected to allow for cheap access in hot paths.
>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/sched.h    | 14 ++++++++++++++
>  kernel/sched/topology.c | 43 ++++++++++++++++++++++++-----------------
>  2 files changed, 39 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 001fe047bd5d..e85976bd2bab 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -109,6 +109,20 @@ extern int sysctl_sched_rt_period;
>  extern int sysctl_sched_rt_runtime;
>  extern int sched_rr_timeslice;
>
> +/*
> + * Asymmetric CPU capacity bits
> + */
> +struct asym_cap_data {
> +       struct list_head link;
> +       struct rcu_head rcu;
> +       unsigned long capacity;
> +       unsigned long cpus[];
> +};
> +
> +extern struct list_head asym_cap_list;
> +
> +#define cpu_capacity_span(asym_data) to_cpumask((asym_data)->cpus)
> +
>  /*
>   * Helpers for converting nanosecond timing to jiffy resolution
>   */
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 10d1391e7416..1505677e4247 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1329,24 +1329,13 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
>         update_group_capacity(sd, cpu);
>  }
>
> -/*
> - * Asymmetric CPU capacity bits
> - */
> -struct asym_cap_data {
> -       struct list_head link;
> -       unsigned long capacity;
> -       unsigned long cpus[];
> -};
> -
>  /*
>   * Set of available CPUs grouped by their corresponding capacities
>   * Each list entry contains a CPU mask reflecting CPUs that share the same
>   * capacity.
>   * The lifespan of data is unlimited.
>   */
> -static LIST_HEAD(asym_cap_list);
> -
> -#define cpu_capacity_span(asym_data) to_cpumask((asym_data)->cpus)
> +LIST_HEAD(asym_cap_list);
>
>  /*
>   * Verify whether there is any CPU capacity asymmetry in a given sched domain.
> @@ -1386,21 +1375,39 @@ asym_cpu_capacity_classify(const struct cpumask *sd_span,
>
>  }
>
> +static void free_asym_cap_entry(struct rcu_head *head)
> +{
> +       struct asym_cap_data *entry = container_of(head, struct asym_cap_data, rcu);
> +       kfree(entry);
> +}
> +
>  static inline void asym_cpu_capacity_update_data(int cpu)
>  {
>         unsigned long capacity = arch_scale_cpu_capacity(cpu);
> -       struct asym_cap_data *entry = NULL;
> +       struct asym_cap_data *insert_entry = NULL;
> +       struct asym_cap_data *entry;
>
> +       /*
> +        * Search if capacity already exits. If not, track which the entry
> +        * where we should insert to keep the list ordered descendingly.
> +        */
>         list_for_each_entry(entry, &asym_cap_list, link) {
>                 if (capacity == entry->capacity)
>                         goto done;
> +               else if (!insert_entry && capacity > entry->capacity)
> +                       insert_entry = list_prev_entry(entry, link);
>         }
>
>         entry = kzalloc(sizeof(*entry) + cpumask_size(), GFP_KERNEL);
>         if (WARN_ONCE(!entry, "Failed to allocate memory for asymmetry data\n"))
>                 return;
>         entry->capacity = capacity;
> -       list_add(&entry->link, &asym_cap_list);
> +
> +       /* If NULL then the new capacity is the smallest, add last. */
> +       if (!insert_entry)
> +               list_add_tail_rcu(&entry->link, &asym_cap_list);
> +       else
> +               list_add_rcu(&entry->link, &insert_entry->link);
>  done:
>         __cpumask_set_cpu(cpu, cpu_capacity_span(entry));
>  }
> @@ -1423,8 +1430,8 @@ static void asym_cpu_capacity_scan(void)
>
>         list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
>                 if (cpumask_empty(cpu_capacity_span(entry))) {
> -                       list_del(&entry->link);
> -                       kfree(entry);
> +                       list_del_rcu(&entry->link);
> +                       call_rcu(&entry->rcu, free_asym_cap_entry);
>                 }
>         }
>
> @@ -1434,8 +1441,8 @@ static void asym_cpu_capacity_scan(void)
>          */
>         if (list_is_singular(&asym_cap_list)) {
>                 entry = list_first_entry(&asym_cap_list, typeof(*entry), link);
> -               list_del(&entry->link);
> -               kfree(entry);
> +               list_del_rcu(&entry->link);
> +               call_rcu(&entry->rcu, free_asym_cap_entry);
>         }
>  }
>
> --
> 2.34.1
>


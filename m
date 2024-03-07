Return-Path: <linux-kernel+bounces-95193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733B3874A7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E4C282D29
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4853B839F1;
	Thu,  7 Mar 2024 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKASO+2M"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81BE633EE
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802873; cv=none; b=AmB596Dq5Jw6RIcR8b6OwkjhM4mhxJrVQgbrYoWThygrnCKth8plADr5NNNtvm5ZtZ9iAlMRtE/0ymQZEfK5/Iviab7vrbm2192GSUDlqfzLB+3kHCqCQm8Xp49gRUr1kWpWL8ZA1S9FBHOR2rXfruwdqFo1+PkZ4ElU8XvW+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802873; c=relaxed/simple;
	bh=Q0slKLIP924PofBfG2UKU9OJDkNEVuHtq9eX84AT2gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTx6nZ3IU9+L0CkDsRHL3DZSOEprRBCAt7AaP/OrppL4gfZLhWGguh4nmCpzgWdg4Ea7BLB2yXrrLpqC52Sb6RtHoq16q7bpAPT6Ukg+uZFcAIZaDcLEpTw6iMaWuQqfEGhZOJ9S0C9QJmljyHmAFu2jpdtXUGdKppUvpPfPAc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKASO+2M; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e5a50d91b4so619601b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 01:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709802871; x=1710407671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=setaAaz/66a25J+sReUz5tbD1smBtJUkh29q89x1Cnk=;
        b=aKASO+2M5+vzFBClimaz6Ng2kC3bNdORLSGe+22FLWqcp3gW42Ml1sgXShM7JeexHC
         d9DyvS/QmAL9e4YlCZOSHaO7CXmbpXqoLmjMIq8Hcn14ISuTMm8++Vu4BvBtCA2oTIj/
         vH5CBX7mXsQ25Qh7Uozd4rvRD01tkBKORdRIb+sEBAgYpAe1tVRm8SWMd2+LFZE6UV20
         J0vnXjHfWx6H9gsgJ3d1xnN1h8xdWSqlGPdXnymnIridKqU4FCiH/2dOKT4AQIWOQPeo
         kwQpr6oyRh06sKA6/IVbDsvOLYunqM7H7+W7MMNI3gRDcZ+0wI+VayXDKnY/mHpxLr2M
         x86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709802871; x=1710407671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=setaAaz/66a25J+sReUz5tbD1smBtJUkh29q89x1Cnk=;
        b=RwMo8F+MBpLv0K9uktPQiWA4fZZkYWXe0K5H2G7ZUQlO31DtrKNmdEhvnh+QKydWgV
         J2kB9NNgwqy1gstzehsYHp4nCxSKnkk/ogp4YMxYm2eSWUM1x2qRYOLy00oYDZB5cy/r
         XjFyL3FnAN3ApTJg9f+jCT6y59m5QJaMKL4nglfIC5OrkFXm/KjL9oLiDBlaSrC9DWpS
         4TXSKWh9zgPBKAhMt6OOXywbv2Tg307N0m1bHmr9FPE/mgeXj8AqXm/svl9Gae3TcNp1
         UflzCF++73P4GB5e6DiXzQ9cjFDj70gOshke3ujkqeb4CY8bcVXy4Q9H5q/s8C/b2FJK
         isQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXeBo6H7b60+6F5dR3xLKaOy09jXCne5/3VtNxifDcQ5GuUAQkkNkmEOJiNawJjUf8XtWsBtO8/GAq1gfRTm4oYBpAAg8Nt8dtJSVg
X-Gm-Message-State: AOJu0YwzfPEKkWQKQoo5nUuUfga9vicLi+h3vMAHYvc48ncLSBGL5ELB
	oXreF9hd+rSKaVaAy9kx+oHQYMucZ9xoYqvDHEA2Sm/jRt0remW+aSs6DK04eUxNkI6JI8Wcw0P
	yCoFFppaZvJfx3AqLG8sJ5o9jGHeGyaRXdKpO46MBbLZqmcAr
X-Google-Smtp-Source: AGHT+IFdPrDGB4UcDhudYcr3d2U/xI+GmhvHyPHuZ/uu/86OJrvitSg2gus2jzqa+T0vL7Vr75f9mfiQNbor7eLE+cw=
X-Received: by 2002:a05:6a20:c896:b0:1a1:e4b:dffc with SMTP id
 hb22-20020a056a20c89600b001a10e4bdffcmr9964088pzb.41.1709802871013; Thu, 07
 Mar 2024 01:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220225622.2626569-1-qyousef@layalina.io> <20240220225622.2626569-3-qyousef@layalina.io>
 <d6699c3a-3df6-46a3-98db-e07c8722f106@arm.com> <20240303174416.7m3gv5wywcmedov4@airbuntu>
 <20240306214704.uditboboedut2lm2@airbuntu>
In-Reply-To: <20240306214704.uditboboedut2lm2@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 7 Mar 2024 10:14:19 +0100
Message-ID: <CAKfTPtBLUkZ0hEd8K=e9wjg+zn9N5jgia-7wwLa3jaeYK+qkCw@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] sched/fair: Check a task has a fitting cpu when
 updating misfit
To: Qais Yousef <qyousef@layalina.io>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	Pierre Gondois <Pierre.Gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 22:47, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 03/03/24 17:44, Qais Yousef wrote:
>
> >       diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >       index 174687252e1a..b0e60a565945 100644
> >       --- a/kernel/sched/fair.c
> >       +++ b/kernel/sched/fair.c
> >       @@ -8260,6 +8260,8 @@ static void set_task_max_allowed_capacity(struct task_struct *p)
> >                       cpumask_t *cpumask;
> >
> >                       cpumask = cpu_capacity_span(entry);
> >       +               if (!cpumask_intersects(cpu_active_mask, cpumask))
> >       +                       continue;
> >                       if (!cpumask_intersects(p->cpus_ptr, cpumask))
> >                               continue;
> >
> >       @@ -8269,6 +8271,53 @@ static void set_task_max_allowed_capacity(struct task_struct *p)
> >               rcu_read_unlock();
> >        }
> >
> >       +static void __update_tasks_max_allowed_capacity(unsigned long capacity)
> >       +{
> >       +       struct task_struct *g, *p;
> >       +
> >       +       for_each_process_thread(g, p) {
> >       +               if (fair_policy(p->policy) && p->max_allowed_capacity == capacity)
>
> This condition actually not good enough. We need to differentiate between going
> online/offline. I didn't want to call set_task_max_allowed_capacity()
> unconditionally and make hotplug even slower.

But should we even try to fix this ? hotplugging a cpu is a special
case and with patch 4 you will not increase lb_interval anymore

>
> I'm doing more testing and will post v8 once done. I need to cater for a new
> user when dynamic EM changes capacities too.. Small things can snow ball easily
> hehe.
>
> >       +                       set_task_max_allowed_capacity(p);
> >       +       }
> >       +}
> >       +
> >       +/*
> >       + * Handle a cpu going online/offline changing the available capacity levels.
> >       + */
> >       +static void update_tasks_max_allowed_capacity(int cpu, bool online)
> >       +{
> >       +       struct asym_cap_data *entry;
> >       +       bool do_update = false;
> >       +
> >       +       if (!sched_asym_cpucap_active())
> >       +               return;
> >       +
> >       +       if (cpuhp_tasks_frozen)
> >       +               return;
> >       +
> >       +       rcu_read_lock();
> >       +       /* Did a capacity level appear/disappear? */
> >       +       list_for_each_entry_rcu(entry, &asym_cap_list, link) {
> >       +               unsigned int nr_active;
> >       +               cpumask_t *cpumask;
> >       +
> >       +               cpumask = cpu_capacity_span(entry);
> >       +
> >       +               if (!cpumask_test_cpu(cpu, cpumask))
> >       +                       continue;
> >       +
> >       +               nr_active = cpumask_weight_and(cpu_active_mask, cpumask);
> >       +               if (online)
> >       +                       do_update = nr_active == 1;
> >       +               else
> >       +                       do_update = !nr_active;
> >       +               break;
> >       +       }
> >       +       if (do_update)
> >       +               __update_tasks_max_allowed_capacity(entry->capacity);
> >       +       rcu_read_unlock();
> >       +}
> >       +
> >        static void set_cpus_allowed_fair(struct task_struct *p, struct affinity_context *ctx)
> >        {
> >               set_cpus_allowed_common(p, ctx);
> >       @@ -12500,6 +12549,8 @@ static void rq_online_fair(struct rq *rq)
> >               update_sysctl();
> >
> >               update_runtime_enabled(rq);
> >       +
> >       +       update_tasks_max_allowed_capacity(cpu_of(rq), true);
> >        }
> >
> >        static void rq_offline_fair(struct rq *rq)
> >       @@ -12511,6 +12562,8 @@ static void rq_offline_fair(struct rq *rq)
> >
> >               /* Ensure that we remove rq contribution to group share: */
> >               clear_tg_offline_cfs_rqs(rq);
> >       +
> >       +       update_tasks_max_allowed_capacity(cpu_of(rq), false);
> >        }
> >
> >        #endif /* CONFIG_SMP */
> > --
> > 2.34.1


Return-Path: <linux-kernel+bounces-674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB80381444A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD19F2849AE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314E918C3D;
	Fri, 15 Dec 2023 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q6E7RiRE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00218C11
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c6b9583dcbso391491a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 01:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702631525; x=1703236325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x2/o57oIhboI+Wbd75MHEtArr6Tb450k2c1DD2KUSNw=;
        b=Q6E7RiRE0c2YygUbX69Jdl7DtgH2CYYx55sA/3RtNIw7wEZ+3nQcwMwpX8FInpynZC
         wxPgZL07GiQZE4BeYMSAf4dOvY8WTcwE0loIqThOYG3OzgZx/5UZerJjUivQb0sVuTEo
         h6pcwDjv8IydeUmOSi7y//mQultRq8jLl/KZ2+WfCHqXw1fl2ej6ymKgj0oI/YCCiVkd
         7OMSYxrAtMu3kcpCZGUcoieRHHSPfdtUbc6qU37yGV3I6PO7Cl+l0C5SinlTMsrBV5Q3
         3DJrw1wa5ZIoRw8HBcf+KdMY3EmSiby4Dg9HIuY4eI4p75KbjVqYtGVA+qnkIfyYLHbm
         XCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702631525; x=1703236325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2/o57oIhboI+Wbd75MHEtArr6Tb450k2c1DD2KUSNw=;
        b=WvqDrCd7XwAe37OcCsEk5MbkzxmiRb0pMwOwylOHgikTLQa0Q+XRBzeTID8DCCCG0b
         TY2UzInK5fvepiR1mz5np+QXsyrTGrldwhwltr1c4MfR5L1tTAgoqZRVatcyRvVhUp2n
         lZGrTlYqe6CFK4g3w7uvbdJ+JmZJANpLA0CCpt+ZFXY6lTrW8RdDubxoPjgS+hJFZpf8
         8BD3u1xkSj8yYpKFOGmMkvLhfQKAXy7hM1B+JERaY6A7Wa7HOfM8A81+0X2nBwHPwrnB
         FgYMMfUwbkkuduQstG/bSX8eeMBKx9bWqxDL5qT/XpUjEYAk32eGxWbyN/du8/2V1Egw
         zmew==
X-Gm-Message-State: AOJu0YxOxARZASFuDKCoL2lGwZrByTMK9NXMxqfyw+KUj+0FPYCNY4ZJ
	5QAd3eLhvuCX0Pl65btt3pWqpCBBjiBM5O0iftzDIw==
X-Google-Smtp-Source: AGHT+IHMeY9RSR1DE4HQrTNr0mEblhscmnke8/MjIb5lXLJmo2Z1ZLCd435IIo5J/FC3wM3IbFMWbsMkTZSO8rskoKc=
X-Received: by 2002:a05:6a21:6da1:b0:18f:97c:9792 with SMTP id
 wl33-20020a056a216da100b0018f097c9792mr13932714pzb.122.1702631525213; Fri, 15
 Dec 2023 01:12:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215052652.917741-1-imran.f.khan@oracle.com>
In-Reply-To: <20231215052652.917741-1-imran.f.khan@oracle.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 15 Dec 2023 10:11:54 +0100
Message-ID: <CAKfTPtD85OSem=7RMquLWokVp7gffvDaY3mtwevkxp1mSSVVqQ@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: fair: reset task_group.load_avg when there are
 no running tasks.
To: Imran Khan <imran.f.khan@oracle.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Dec 2023 at 06:27, Imran Khan <imran.f.khan@oracle.com> wrote:
>
> It has been found that sometimes a task_group has some residual
> load_avg even though the load average at each of its owned queues
> i.e task_group.cfs_rq[cpu].avg.load_avg and task_group.cfs_rq[cpu].
> tg_load_avg_contrib have become 0 for a long time.
> Under this scenario if another task starts running in this task_group,
> it does not get proper time share on CPU since pre-existing
> load average of task group inversely impacts the new task's CPU share
> on each CPU.
>
> This change looks for the condition when a task_group has no running
> tasks and sets the task_group's load average to 0 in such cases, so
> that tasks that run in future under this task_group get the CPU time
> in accordance with the current load.
>
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> ---
>

[...]

>
> 4. Now move systemd-udevd to one of these test groups, say test_group_1, and
> perform scale up to 124 CPUs followed by scale down back to 4 CPUs from the
> host side.

Could it be the root cause of your problem ?

The cfs_rq->tg_load_avg_contrib of the 120 CPUs that have been plugged
then unplugged,  have not been correctly removed from tg->load_avg. If
the cfs_rq->tg_load_avg_contrib of the 4 remaining CPUs is 0 then
tg->load_avg should be 0 too.

Could you track that the cfs_rq->tg_load_avg_contrib is correctly
removed from tg->load_avg when you unplug the CPUs ? I can easily
imagine that the rate limit can skip some update of tg- >load_avg
while offlining the cpu

> 5. Run the same workload i.e 4 instances of CPU hogger under /sys/fs/cgroup/cpu
> and one instance of  CPU hogger each in /sys/fs/cgroup/cpu/test_group_1 and
> /sys/fs/cgroup/test_group_2.
> It is seen that test_group_1 (the one where systemd-udevd was moved) is getting
> much less CPU than the test_group_2, even though at this point of time both of
> these groups have only CPU hogger running.
>

[...]

> Apologies for this long description of the issue, but I have found only one way
> of reproducing this issue and using this way issue can be reproduced with 100%
> strike rate, so I thought of providing as much info as possible.
>
> I have kept the change as RFC as I was not sure if the load_avg should be
> dragged down to 0 in one go (as being done in this change) or should it be
> pulled back in steps like making it half of the previous value each time.
>
>
>  kernel/sched/fair.c  | 17 +++++++++++++++++
>  kernel/sched/sched.h |  1 +
>  2 files changed, 18 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d7a3c63a2171..c34d9e7abb96 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3572,6 +3572,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>
>                 account_numa_enqueue(rq, task_of(se));
>                 list_add(&se->group_node, &rq->cfs_tasks);
> +               atomic_long_inc(&task_group(task_of(se))->cfs_nr_running);

We have rate limited the access to the atomic tg->load_avg because it
was impacting significantly the performance.  We don't want to add a
new one at every enqueue/dequeue


>         }
>  #endif
>         cfs_rq->nr_running++;
> @@ -3587,6 +3588,7 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>         if (entity_is_task(se)) {
>                 account_numa_dequeue(rq_of(cfs_rq), task_of(se));
>                 list_del_init(&se->group_node);
> +               atomic_long_dec(&task_group(task_of(se))->cfs_nr_running);
>         }
>  #endif
>         cfs_rq->nr_running--;
> @@ -4104,6 +4106,20 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
>         if (now - cfs_rq->last_update_tg_load_avg < NSEC_PER_MSEC)
>                 return;
>
> +       /*
> +        * If number of running tasks for a task_group is 0, pull back its
> +        * load_avg to 0 as well.
> +        * This avoids the situation where a freshly forked task in a cgroup,
> +        * with some residual load_avg but with no running tasks, gets less
> +        * CPU time because of pre-existing load_avg of task_group.
> +        */
> +       if (!atomic_long_read(&cfs_rq->tg->cfs_nr_running)
> +           && atomic_long_read(&cfs_rq->tg->load_avg)) {
> +               atomic_long_set(&cfs_rq->tg->load_avg, 0);
> +               cfs_rq->last_update_tg_load_avg = now;
> +               return;
> +       }
> +
>         delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
>         if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
>                 atomic_long_add(delta, &cfs_rq->tg->load_avg);
> @@ -12808,6 +12824,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
>                 goto err;
>
>         tg->shares = NICE_0_LOAD;
> +       atomic_long_set(&tg->cfs_nr_running, 0);
>
>         init_cfs_bandwidth(tg_cfs_bandwidth(tg), tg_cfs_bandwidth(parent));
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2e5a95486a42..c3390bdb8400 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -370,6 +370,7 @@ struct task_group {
>          */
>         atomic_long_t           load_avg ____cacheline_aligned;
>  #endif
> +       atomic_long_t           cfs_nr_running ____cacheline_aligned;
>  #endif
>
>  #ifdef CONFIG_RT_GROUP_SCHED
> --
> 2.34.1
>


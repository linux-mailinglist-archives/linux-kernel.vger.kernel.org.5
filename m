Return-Path: <linux-kernel+bounces-4231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE716817962
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 456A4B22105
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F110C5D730;
	Mon, 18 Dec 2023 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRnwuZAt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8925BFAC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702922838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yYJufJrlzlVf1xxmX9kS7ZpXvMjk3rAZT96vQVb8Vls=;
	b=IRnwuZAt7S9B8CGB3wqj8yFBLERJrL+0UFgov9lNysC61YF73udx7L1MosrGWGImUsGrlD
	ySMhKyWQQlYGnod9wNoJ/5XfKJfghIGCqXFzWPV48TxUriYrvN/L+F0JS5oNb0PEX0Mt/L
	1XNF4Wd12gb8PZlb9r+9Il7kilqYg8g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-SNBHuB9-O1C9goRHKbBKvA-1; Mon, 18 Dec 2023 13:07:16 -0500
X-MC-Unique: SNBHuB9-O1C9goRHKbBKvA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33668563c94so677704f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702922835; x=1703527635;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYJufJrlzlVf1xxmX9kS7ZpXvMjk3rAZT96vQVb8Vls=;
        b=ny7HLapvpPToj8X5oqr1p8vtro2Dn/A8fwO/LdXjSTWc/fwjjaBwofuVa4l/3taHBl
         KMaUdqDRRYm/N4egJVzrHmENceaSJo5kasvQ93CF2X4A1BcbRYZ5MXFYaqMnwWVfF/GA
         tJ+8QDTGA15KPJrcR8W/JYtLZzkTDC5HYtPrB8nKcY0VmM2nYCYtLgU9WLXt5E07NNoS
         8gxW3LmrXwi6UoyrMqtcejsq4JuDFGkYekuCUfUyJpvTRF8OBLN11MfosrnkvxotJyxM
         msCbpSuRNCJJ//FepnPnwNF0Yj3zbe9X3CIuCLRabxI/EtiBwTQ/xPjey3aSDcx/1lZl
         yFBQ==
X-Gm-Message-State: AOJu0Yw1wa3QgG7wjN7QR8OlHNrayT2yinVaWuTcqFRvn+73CDFgMzzw
	mVBlHniYDoCm+JXRGnVwctykdC2jylp/TatlsEaY6Yx6o2xj8Y8dYnnLen68jl/gbHxIwJ0hAJw
	q/svzMIhVYFyxPL0NgP6oIk8/
X-Received: by 2002:a05:6000:18c1:b0:333:43b6:9a5a with SMTP id w1-20020a05600018c100b0033343b69a5amr9933471wrq.78.1702922834904;
        Mon, 18 Dec 2023 10:07:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmuPbb5FDmaT7rHFUhIWjHtd+gPE543rI/UIDUJziSwe/J8ow1EJ/tznm+/oIV4sVdS0gQTA==
X-Received: by 2002:a05:6000:18c1:b0:333:43b6:9a5a with SMTP id w1-20020a05600018c100b0033343b69a5amr9933458wrq.78.1702922834478;
        Mon, 18 Dec 2023 10:07:14 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d4604000000b0033642a9a1eesm14611648wrq.21.2023.12.18.10.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 10:07:13 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Benjamin Segall <bsegall@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Phil Auld <pauld@redhat.com>, Clark Williams <williams@redhat.com>, Tomas
 Glozar <tglozar@redhat.com>
Subject: Re: [RFC PATCH 1/2] sched/fair: Only throttle CFS tasks on return
 to userspace
In-Reply-To: <xm26edfxpock.fsf@bsegall-linux.svl.corp.google.com>
References: <20231130161245.3894682-1-vschneid@redhat.com>
 <20231130161245.3894682-2-vschneid@redhat.com>
 <xm26sf4n2ar6.fsf@google.com>
 <xhsmhfs0maw49.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <xm26edfxpock.fsf@bsegall-linux.svl.corp.google.com>
Date: Mon, 18 Dec 2023 19:07:12 +0100
Message-ID: <xhsmhy1dr9ygf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 07/12/23 15:47, Benjamin Segall wrote:
> Alright, this took longer than I intended, but here's the basic version
> with the duplicate "runqueue" just being a list rather than actual EEVDF
> or anything sensible.
>
> I also wasn't actually able to adapt it to work via task_work like I
> thought I could; flagging the entry to the relevant schedule() calls is
> too critical.
>

Thanks for sharing this! Have a first set of comments.

> --------
>
> Subject: [RFC PATCH] sched/fair: only throttle CFS tasks in userspace
>
> The basic idea of this implementation is to maintain duplicate runqueues
> in each cfs_rq that contain duplicate pointers to sched_entitys which
> should bypass throttling. Then we can skip throttling cfs_rqs that have
> any such children, and when we pick inside any not-actually-throttled
> cfs_rq, we only look at this duplicated list.
>
> "Which tasks should bypass throttling" here is "all schedule() calls
> that don't set a special flag", but could instead involve the lockdep
> markers (except for the problem of percpu-rwsem and similar) or explicit
> flags around syscalls and faults, or something else.
>
> This approach avoids any O(tasks) loops, but leaves partially-throttled
> cfs_rqs still contributing their full h_nr_running to their parents,
> which might result in worse balancing. Also it adds more (generally
> still small) overhead to the common enqueue/dequeue/pick paths.
>
> The very basic debug test added is to run a cpusoaker and "cat
> /sys/kernel/debug/sched_locked_spin" pinned to the same cpu in the same
> cgroup with a quota < 1 cpu.

So if I'm trying to compare notes:

The dual tree:
- Can actually throttle cfs_rq's once all tasks are in userspace
- Adds (light-ish) overhead to enqueue/dequeue
- Doesn't keep *nr_running updated when not fully throttled

Whereas dequeue via task_work:
- Can never fully throttle a cfs_rq
- Adds (not so light) overhead to unthrottle
- Keeps *nr_running updated

My thoughts right now are that there might be a way to mix both worlds: go
with the dual tree, but subtract from h_nr_running at dequeue_kernel()
(sort of doing the count update in throttle_cfs_rq() early) and keep track
of in-user tasks via handle_kernel_task_prev() to add this back when
unthrottling a not-fully-throttled cfs_rq. I need to actually think about
it though :-)

> @@ -154,11 +154,11 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>       while (ti_work & EXIT_TO_USER_MODE_WORK) {
>
>               local_irq_enable_exit_to_user(ti_work);
>
>               if (ti_work & _TIF_NEED_RESCHED)
> -			schedule();
> +			schedule_usermode(); /* TODO: also all of the arch/* loops that don't use this yet */
                                                                          ^^
                                      Interestingly -Werror=comment trips on this

>
>               if (ti_work & _TIF_UPROBE)
>                       uprobe_notify_resume(regs);
>
>               if (ti_work & _TIF_PATCH_PENDING)
> @@ -5416,18 +5426,38 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>       se->prev_sum_exec_runtime = se->sum_exec_runtime;
>  }
>
>  /*
>   * Pick the next process, keeping these things in mind, in this order:
> - * 1) keep things fair between processes/task groups
> - * 2) pick the "next" process, since someone really wants that to run
> - * 3) pick the "last" process, for cache locality
> - * 4) do not run the "skip" process, if something else is available
> + * 1) If we're inside a throttled cfs_rq, only pick threads in the kernel
> + * 2) keep things fair between processes/task groups
> + * 3) pick the "next" process, since someone really wants that to run
> + * 4) pick the "last" process, for cache locality
> + * 5) do not run the "skip" process, if something else is available
>   */
>  static struct sched_entity *
> -pick_next_entity(struct cfs_rq *cfs_rq)
> +pick_next_entity(struct cfs_rq *cfs_rq, bool throttled)
>  {
> +#ifdef CONFIG_CFS_BANDWIDTH
> +	/*
> +	 * TODO: This might trigger, I'm not sure/don't remember. Regardless,
> +	 * while we do not explicitly handle the case where h_kernel_running
> +	 * goes to 0, we will call account/check_cfs_rq_runtime at worst in
> +	 * entity_tick and notice that we can now properly do the full
> +	 * throttle_cfs_rq.
> +	 */
> +	WARN_ON_ONCE(list_empty(&cfs_rq->kernel_children));

FWIW this triggers pretty much immediately in my environment (buildroot
over QEMU).

> @@ -5712,16 +5748,26 @@ static int tg_throttle_down(struct task_group *tg, void *data)
>       cfs_rq->throttle_count++;
>
>       return 0;
>  }
>
> +static void enqueue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int count);
> +static void dequeue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int count);
> +
>  static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>       struct rq *rq = rq_of(cfs_rq);
>       struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
>       struct sched_entity *se;
> -	long task_delta, idle_task_delta, dequeue = 1;
> +	long task_delta, idle_task_delta, kernel_delta, dequeue = 1;
> +
> +	/*
> +	 * We don't actually throttle, though account() will have made sure to
> +	 * resched us so that we pick into a kernel task.
> +	 */
> +	if (cfs_rq->h_kernel_running)
> +		return false;
>

So as long as a cfs_rq has at least one task executing in the kernel, we
keep its *nr_running intact. We do throttle the whole thing once all the
tasks are in userspace (or about to be anyway), and unthrottle_on_enqueue()
undoes that.

> @@ -8316,15 +8471,44 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>
>  preempt:
>       resched_curr(rq);
>  }
>
> +static void handle_kernel_task_prev(struct task_struct *prev)
> +{
> +#ifdef CONFIG_CFS_BANDWIDTH
> +	struct sched_entity *se = &prev->se;
> +	bool new_kernel = is_kernel_task(prev);
> +	bool prev_kernel = !list_empty(&se->kernel_node);
> +	/*
> +	 * These extra loops are bad and against the whole point of the merged
> +	 * PNT, but it's a pain to merge, particularly since we want it to occur
> +	 * before check_cfs_runtime.
> +	 */
> +	if (prev_kernel && !new_kernel) {
> +		WARN_ON_ONCE(!se->on_rq); /* dequeue should have removed us */
> +		for_each_sched_entity(se) {
> +			dequeue_kernel(cfs_rq_of(se), se, 1);
> +			if (cfs_rq_throttled(cfs_rq_of(se)))
> +				break;
> +		}
> +	} else if (!prev_kernel && new_kernel && se->on_rq) {
> +		for_each_sched_entity(se) {
> +			enqueue_kernel(cfs_rq_of(se), se, 1);
> +			if (cfs_rq_throttled(cfs_rq_of(se)))
> +				break;
> +		}
> +	}
> +#endif
> +}


I'm trying to grok what the implications of a second tasks_timeline would
be on picking - we'd want a RBtree update equivalent to put_prev_entity()'s
__enqueue_entity(), but that second tree doesn't follow the same
enqueue/dequeue cycle as the first one. Would a __dequeue_entity() +
__enqueue_entity() to force a rebalance make sense? That'd also take care
of updating the min_vruntime.



Return-Path: <linux-kernel+bounces-4449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E448A817D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF161F23187
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CF176080;
	Mon, 18 Dec 2023 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="whjQNCXt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AE1DFC1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3d7873796so18935ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702938882; x=1703543682; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mGdD/5IEfD8p7+cvvZG2CNSCawN+QXNticMsrF0mEfY=;
        b=whjQNCXtn9aQNuuf0248KdTP6Rh85x0rOd5S40DYlIEPUj5QERfNo0575bPiBkeEFL
         C3WAX8GN57fkvOyTLQVGVoNXiP50UUX6+/umJG6EMvnBUcLr9MAWZJr2me8vVZs0M/SI
         SO2MmIA2DYj2XQqWzvsySbm0l6TF9fE/qgT61TLMXZiLltuPgu/4kEwAF8KBNTevMTHR
         CFf1+awOkqBQmj2tpvZXwAJ5Hv094Obc8zG1xRTFM3aZnKrfTKc9+XD6FD+UiPbN2Ny5
         OPodRmOpVEO6h1XIT6ZLmwj6vsHdlF0DR8ac1X8GVDQLzZiVq/YkE1PXhAQXcbgoClGt
         0trA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702938882; x=1703543682;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGdD/5IEfD8p7+cvvZG2CNSCawN+QXNticMsrF0mEfY=;
        b=UYbMGFXzRtJvnXchKnyV59ziAIWbBOWe5qBxIpqHZgo4Hs1gddmSVLH5QP3K5KU6xo
         DwirJ/oncbK5BGS4vfgXSzPz11tJX/uVKfwzl+VN9R8YhXZsqEHCOZ1BnfcQAuYgGiXu
         qOySOB9LtSuLjV5Z1/2uF6Y3VM1qR2KFyhEF7rBzWjqzTBae6pbQROesit4OEdS+N92e
         RoUNdF+p2C8w3YdPds8JHIeqd5fGmdbnur23JcmtGsE0McTHKWqjVCVXZxtrL9pRS6vj
         khomSF7706nrZewhTgLcI75rZW8qxyzSOb28cSiPLayE0UB/n9jZ1NPtaVTQmIzBL5G6
         0VPA==
X-Gm-Message-State: AOJu0YyUKu5m9eA1GY45Odtyb1gdB8dgiXBbiFA69Q60k5sNhLJsmpKx
	WuS+Yw5nL0kXg5PJVVVYMKIEHl58K+6m
X-Google-Smtp-Source: AGHT+IEVlrk47vBAjXn5AAJYXmCa9G8zb7wk9x+1SMEQdAYgsdRllc8yqlR933BkzGKNxMQ+Yfux9Q==
X-Received: by 2002:a17:902:d48f:b0:1d3:dc24:31c with SMTP id c15-20020a170902d48f00b001d3dc24031cmr24664plg.3.1702938881600;
        Mon, 18 Dec 2023 14:34:41 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id ju2-20020a170903428200b001d3a9e20b79sm3457934plb.120.2023.12.18.14.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 14:34:40 -0800 (PST)
From: Benjamin Segall <bsegall@google.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@redhat.com>,  Juri Lelli <juri.lelli@redhat.com>,
  Vincent Guittot <vincent.guittot@linaro.org>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>,  Mel
 Gorman <mgorman@suse.de>,  Daniel Bristot de Oliveira
 <bristot@redhat.com>,  Phil Auld <pauld@redhat.com>,  Clark Williams
 <williams@redhat.com>,  Tomas Glozar <tglozar@redhat.com>
Subject: Re: [RFC PATCH 1/2] sched/fair: Only throttle CFS tasks on return
 to userspace
In-Reply-To: <xhsmhy1dr9ygf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	(Valentin Schneider's message of "Mon, 18 Dec 2023 19:07:12 +0100")
References: <20231130161245.3894682-1-vschneid@redhat.com>
	<20231130161245.3894682-2-vschneid@redhat.com>
	<xm26sf4n2ar6.fsf@google.com>
	<xhsmhfs0maw49.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	<xm26edfxpock.fsf@bsegall-linux.svl.corp.google.com>
	<xhsmhy1dr9ygf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date: Mon, 18 Dec 2023 14:34:38 -0800
Message-ID: <xm26edfj2l8h.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Valentin Schneider <vschneid@redhat.com> writes:

> On 07/12/23 15:47, Benjamin Segall wrote:
>> Alright, this took longer than I intended, but here's the basic version
>> with the duplicate "runqueue" just being a list rather than actual EEVDF
>> or anything sensible.
>>
>> I also wasn't actually able to adapt it to work via task_work like I
>> thought I could; flagging the entry to the relevant schedule() calls is
>> too critical.
>>
>
> Thanks for sharing this! Have a first set of comments.
>
>> --------
>>
>> Subject: [RFC PATCH] sched/fair: only throttle CFS tasks in userspace
>>
>> The basic idea of this implementation is to maintain duplicate runqueues
>> in each cfs_rq that contain duplicate pointers to sched_entitys which
>> should bypass throttling. Then we can skip throttling cfs_rqs that have
>> any such children, and when we pick inside any not-actually-throttled
>> cfs_rq, we only look at this duplicated list.
>>
>> "Which tasks should bypass throttling" here is "all schedule() calls
>> that don't set a special flag", but could instead involve the lockdep
>> markers (except for the problem of percpu-rwsem and similar) or explicit
>> flags around syscalls and faults, or something else.
>>
>> This approach avoids any O(tasks) loops, but leaves partially-throttled
>> cfs_rqs still contributing their full h_nr_running to their parents,
>> which might result in worse balancing. Also it adds more (generally
>> still small) overhead to the common enqueue/dequeue/pick paths.
>>
>> The very basic debug test added is to run a cpusoaker and "cat
>> /sys/kernel/debug/sched_locked_spin" pinned to the same cpu in the same
>> cgroup with a quota < 1 cpu.
>
> So if I'm trying to compare notes:
>
> The dual tree:
> - Can actually throttle cfs_rq's once all tasks are in userspace
> - Adds (light-ish) overhead to enqueue/dequeue
> - Doesn't keep *nr_running updated when not fully throttled
>
> Whereas dequeue via task_work:
> - Can never fully throttle a cfs_rq
> - Adds (not so light) overhead to unthrottle
> - Keeps *nr_running updated

Yeah, this sounds right. (Though for the task_work version once all the
tasks are throttled, the cfs_rq is dequeued like normal, so it doesn't
seem like a big deal to me)

>
> My thoughts right now are that there might be a way to mix both worlds: go
> with the dual tree, but subtract from h_nr_running at dequeue_kernel()
> (sort of doing the count update in throttle_cfs_rq() early) and keep track
> of in-user tasks via handle_kernel_task_prev() to add this back when
> unthrottling a not-fully-throttled cfs_rq. I need to actually think about
> it though :-)

Probably, but I had tons of trouble getting the accounting correct as it
was :P

>> +#ifdef CONFIG_CFS_BANDWIDTH
>> +	/*
>> +	 * TODO: This might trigger, I'm not sure/don't remember. Regardless,
>> +	 * while we do not explicitly handle the case where h_kernel_running
>> +	 * goes to 0, we will call account/check_cfs_rq_runtime at worst in
>> +	 * entity_tick and notice that we can now properly do the full
>> +	 * throttle_cfs_rq.
>> +	 */
>> +	WARN_ON_ONCE(list_empty(&cfs_rq->kernel_children));
>
> FWIW this triggers pretty much immediately in my environment (buildroot
> over QEMU).

Good to know; I feel like this should be avoidable (and definitely
should be avoided if it can be), but I might be forgetting some case
that's mostly unavoidable. I'll have to poke it when I have more time.

>> @@ -8316,15 +8471,44 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>>
>>  preempt:
>>       resched_curr(rq);
>>  }
>>
>> +static void handle_kernel_task_prev(struct task_struct *prev)
>> +{
>> +#ifdef CONFIG_CFS_BANDWIDTH
>> +	struct sched_entity *se = &prev->se;
>> +	bool new_kernel = is_kernel_task(prev);
>> +	bool prev_kernel = !list_empty(&se->kernel_node);
>> +	/*
>> +	 * These extra loops are bad and against the whole point of the merged
>> +	 * PNT, but it's a pain to merge, particularly since we want it to occur
>> +	 * before check_cfs_runtime.
>> +	 */
>> +	if (prev_kernel && !new_kernel) {
>> +		WARN_ON_ONCE(!se->on_rq); /* dequeue should have removed us */
>> +		for_each_sched_entity(se) {
>> +			dequeue_kernel(cfs_rq_of(se), se, 1);
>> +			if (cfs_rq_throttled(cfs_rq_of(se)))
>> +				break;
>> +		}
>> +	} else if (!prev_kernel && new_kernel && se->on_rq) {
>> +		for_each_sched_entity(se) {
>> +			enqueue_kernel(cfs_rq_of(se), se, 1);
>> +			if (cfs_rq_throttled(cfs_rq_of(se)))
>> +				break;
>> +		}
>> +	}
>> +#endif
>> +}
>
>
> I'm trying to grok what the implications of a second tasks_timeline would
> be on picking - we'd want a RBtree update equivalent to put_prev_entity()'s
> __enqueue_entity(), but that second tree doesn't follow the same
> enqueue/dequeue cycle as the first one. Would a __dequeue_entity() +
> __enqueue_entity() to force a rebalance make sense? That'd also take care
> of updating the min_vruntime.

Yeah, the most sensible thing to do would probably be to just have curr
not be in the queue, the same as the normal rbtree, and save the "on
kernel list" as an on_rq-equivalent bool instead of as !list_empty(kernel_node).


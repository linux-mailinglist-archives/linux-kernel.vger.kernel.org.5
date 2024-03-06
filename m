Return-Path: <linux-kernel+bounces-94615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2635187422C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DBD28216C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECE31B941;
	Wed,  6 Mar 2024 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="eczQGtpc"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E911B809
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709761631; cv=none; b=ZQKqIzrJK1ydbtmuVucoghyxN1RxVCsC3qkuDiS0Egh4bzeUGoSVR1nmRr99SRmA2pVWkx7s6xnqVHo9tWXlZAhTcxdTtd59HK8qUECD+kKWZs9qz3mlnUcKnjIB14SfDZxZTIU3gCjqLkodqdZAvz3SM6Y7gyGyh/QdfBsAG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709761631; c=relaxed/simple;
	bh=0J4qXccvFgGCjOEOnCpSsVMdTguZ7f/M79mE56gJ9Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlN188dyHz+m1C9xj6lZVE3yG0+yK7kLNS/2DO4jSUKWQ7ewAWoz6XrNNQCX/wqaSC/RjfosU3rWWUxSlUSS9FiPYTywZZEGbjrgWSeCF1pmGY+6fFGajHoQb//u8LIOAGDWfOT/daFCGA2rqooAxgFmj10bK0k7+7rmzyl4RKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=eczQGtpc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a45aa7cb2b3so31605466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 13:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1709761627; x=1710366427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7QPXOqgOng70ewhAPpxB4UYdb7bXFiVgrnrORLmjlP8=;
        b=eczQGtpcMhe8iWXeQCFGZyLYBiFgtUGw2hWdbRrqfkqPAOBEW7zJcDYVdWxhMvTZJ1
         sEX3fucrqOHzq6UsepjqOv8b9TNIZX/wqy9SjFyeg3Q1kUermQeZXH2Hj+dv2rXPr0d5
         1fI8wjYSHFFSTyy1TakE9vbWpmexF7fPHnQRMi2Xb8g0nnb4rZIvqeAkzYW6f9+QWfxQ
         LOR3I+eCu+YjMeMMFzkEbOPa1sWVm09m/lmbLQWf1w3eqvM6r9CntaYjZ4NXy9NjqYYU
         ylK3gj3MONvJpOd9pVUnEJzuRzWxa4K3nL/TcEEngtxCJk7GLPUkD9AwJtYHRqGfNHTs
         c1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709761627; x=1710366427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QPXOqgOng70ewhAPpxB4UYdb7bXFiVgrnrORLmjlP8=;
        b=en//ExBj9ir7BdKIy6iWdBF3Wprwrc9h4l3LfdnfGPSUD6azxaqG98A/vxmK02ZSWz
         h0SokG2+Wcic2ebafh8fZd3XJ4qsi6d0dFmdvsBAQLXxngjEfF2yBBdbk5jjs9/NpJ7k
         ADZ6pCgBbtHVj+6K5GSHYHG+PhVIsHDvOImJiRKk+Zi/mBHB7dxEiPR96fvwOvlaAtr9
         RrDQFH4wAX3EexQJjyrbuOiLwHFL7JzqmiGQKXTKH9nfyuoszPK68HUzNmFeHIK/hnRP
         qAjcCZKq0/pZj0MFr15LrI0HrckMH0Nu91zIMAOWkaZEYkfoFyebyWr7vgMBzap91y8m
         tq5A==
X-Forwarded-Encrypted: i=1; AJvYcCVBr9fkBzYUNMfuNqTfdsuWf6q+hdz5UZHblUUgZpUY3PRLALn7v9uK2GP+a8IeL/PBn3/AlT/+uzGeIoetBctiKt+JCUDTnItiQnNc
X-Gm-Message-State: AOJu0YyjlBOG2nWwyHt4OW7pzzFaLH1hti5vU9vKOXE1UQqPNnlb/zdU
	ryyPZdqMWSDU85utSyMr5lK1y1XnkEGNzJCusCmTh4/xcxAvcK2upTCPu5GCp/k=
X-Google-Smtp-Source: AGHT+IGURT2bLrj5XI+myPR1dPqQQbw8ji55GUvUR/xD8wb/ut+BQ6k7/BNu4EwZMPcDToSkU8zoIA==
X-Received: by 2002:a17:906:b20b:b0:a45:ad55:1db9 with SMTP id p11-20020a170906b20b00b00a45ad551db9mr3493370ejz.72.1709761627116;
        Wed, 06 Mar 2024 13:47:07 -0800 (PST)
Received: from airbuntu (92.40.198.105.threembb.co.uk. [92.40.198.105])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b00a45bf3a70a9sm891642ejq.215.2024.03.06.13.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 13:47:06 -0800 (PST)
Date: Wed, 6 Mar 2024 21:47:04 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v6 2/4] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240306214704.uditboboedut2lm2@airbuntu>
References: <20240220225622.2626569-1-qyousef@layalina.io>
 <20240220225622.2626569-3-qyousef@layalina.io>
 <d6699c3a-3df6-46a3-98db-e07c8722f106@arm.com>
 <20240303174416.7m3gv5wywcmedov4@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240303174416.7m3gv5wywcmedov4@airbuntu>

On 03/03/24 17:44, Qais Yousef wrote:

> 	diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> 	index 174687252e1a..b0e60a565945 100644
> 	--- a/kernel/sched/fair.c
> 	+++ b/kernel/sched/fair.c
> 	@@ -8260,6 +8260,8 @@ static void set_task_max_allowed_capacity(struct task_struct *p)
> 			cpumask_t *cpumask;
> 	 
> 			cpumask = cpu_capacity_span(entry);
> 	+		if (!cpumask_intersects(cpu_active_mask, cpumask))
> 	+			continue;
> 			if (!cpumask_intersects(p->cpus_ptr, cpumask))
> 				continue;
> 	 
> 	@@ -8269,6 +8271,53 @@ static void set_task_max_allowed_capacity(struct task_struct *p)
> 		rcu_read_unlock();
> 	 }
> 	 
> 	+static void __update_tasks_max_allowed_capacity(unsigned long capacity)
> 	+{
> 	+	struct task_struct *g, *p;
> 	+
> 	+	for_each_process_thread(g, p) {
> 	+		if (fair_policy(p->policy) && p->max_allowed_capacity == capacity)

This condition actually not good enough. We need to differentiate between going
online/offline. I didn't want to call set_task_max_allowed_capacity()
unconditionally and make hotplug even slower.

I'm doing more testing and will post v8 once done. I need to cater for a new
user when dynamic EM changes capacities too.. Small things can snow ball easily
hehe.

> 	+			set_task_max_allowed_capacity(p);
> 	+	}
> 	+}
> 	+
> 	+/*
> 	+ * Handle a cpu going online/offline changing the available capacity levels.
> 	+ */
> 	+static void update_tasks_max_allowed_capacity(int cpu, bool online)
> 	+{
> 	+	struct asym_cap_data *entry;
> 	+	bool do_update = false;
> 	+
> 	+	if (!sched_asym_cpucap_active())
> 	+		return;
> 	+
> 	+	if (cpuhp_tasks_frozen)
> 	+		return;
> 	+
> 	+	rcu_read_lock();
> 	+	/* Did a capacity level appear/disappear? */
> 	+	list_for_each_entry_rcu(entry, &asym_cap_list, link) {
> 	+		unsigned int nr_active;
> 	+		cpumask_t *cpumask;
> 	+
> 	+		cpumask = cpu_capacity_span(entry);
> 	+
> 	+		if (!cpumask_test_cpu(cpu, cpumask))
> 	+			continue;
> 	+
> 	+		nr_active = cpumask_weight_and(cpu_active_mask, cpumask);
> 	+		if (online)
> 	+			do_update = nr_active == 1;
> 	+		else
> 	+			do_update = !nr_active;
> 	+		break;
> 	+	}
> 	+	if (do_update)
> 	+		__update_tasks_max_allowed_capacity(entry->capacity);
> 	+	rcu_read_unlock();
> 	+}
> 	+
> 	 static void set_cpus_allowed_fair(struct task_struct *p, struct affinity_context *ctx)
> 	 {
> 		set_cpus_allowed_common(p, ctx);
> 	@@ -12500,6 +12549,8 @@ static void rq_online_fair(struct rq *rq)
> 		update_sysctl();
> 	 
> 		update_runtime_enabled(rq);
> 	+
> 	+	update_tasks_max_allowed_capacity(cpu_of(rq), true);
> 	 }
> 	 
> 	 static void rq_offline_fair(struct rq *rq)
> 	@@ -12511,6 +12562,8 @@ static void rq_offline_fair(struct rq *rq)
> 	 
> 		/* Ensure that we remove rq contribution to group share: */
> 		clear_tg_offline_cfs_rqs(rq);
> 	+
> 	+	update_tasks_max_allowed_capacity(cpu_of(rq), false);
> 	 }
> 	 
> 	 #endif /* CONFIG_SMP */
> -- 
> 2.34.1


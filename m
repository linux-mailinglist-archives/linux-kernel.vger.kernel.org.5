Return-Path: <linux-kernel+bounces-122813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2045F88FDBA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87A4AB25493
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1044C7D3F4;
	Thu, 28 Mar 2024 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwNPQfbJ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9343C7D414
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624076; cv=none; b=PAnlFr0oIo7mn49iGJwNpsIFMW6scjA0+uy+fLdp1HdaGLCgJpC5+S0f6orEC65/skQI2IOkXKbQQ9GB8M8m8sBIPxY5tCR6GEJQGcP8EsZJjHMRY7/bQDl9UfcwnhcsT0KbVV1MpUXyfGwkzdt0HU5tnJ5LDuk4tTpAJvFkmBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624076; c=relaxed/simple;
	bh=B5Z1hOrPzeIQcZGTVxoed36qKGJ8NJPS1lQ6iWBZamE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG8i4/KwDbuA+3SoMu5rRL1fjxBKEpIWOgNSs8udimrNHW0er4OvVJaGAQOIVpPO5wp07MVTexQA9/NMSJtAtxKki53PnWKXLhi1d43mKKDxJZPVCAQ0oAqe+oMqcznRhEsnswVjtwPgcmTfzb/7vtrbJwR6MMUCf8+kBiYOUUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwNPQfbJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c4ca65dc6so961503a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 04:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711624071; x=1712228871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7BqpoZ8kKeanKi6AwFQZmQ+r6VFheEms5r3TDOEkxM=;
        b=RwNPQfbJ+CoN70nmc/s7wMXzfmujcupHhHO//xk4usZ6poJ4k4cwB8z6N/HoeK6jE/
         96+yYrAcvrAKv5sO260F3yo3Mg1wCtFgt5gnVr/GFoLp/l7A00rKSPS2eqaCn7KRfaNP
         Na0reVp0ox3ppzdcYQDxvNnm/D1Dro1koPO6jLcWznIaUE5I3j6peTUwlKubdfFY4SLE
         8rF6HClspixbzMLQLuFj9fzmgXuIjxL3FJzbmXRo5s3FkDOM+V705kCTY1oQEYn7pyW3
         q6SdTnJzGKmbtefZt/+KY9PEjQi8tl4Z8Qvx09l7p2POkcKZhCnQNp8q9+L/InWHnOIw
         zgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711624071; x=1712228871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7BqpoZ8kKeanKi6AwFQZmQ+r6VFheEms5r3TDOEkxM=;
        b=TuTv9dWNWBn/UVMFDRyw68vn2chYy0oQ9fHaVmNE6xMKbaX4N+zwOKL+YS3KiGm5N9
         fwFPolXz0mqfxGe0HC+OkotBiLnYnwyDzaBkfwqmhL1hw0bbX0yVBw6wkVJ7JeXX3OkZ
         CAp/p6d6NmomRJM1tPcg3do35cZjBpmqgndsLNp3MZAjRWNuZelielG5roJ6Gvte9uSZ
         DX0yX6lQriLXGLJ+aD7uKrOjnNcyPuvQH2BFSA8+O5TlEjSXVUMWlZjJN0YeF+wZLjfH
         GgcgXdPYj8c6z0tzxapQglPiiAomW57bZDjs8xpXwp1Fai9Ct/85BtbV0GQDAzKeM2d0
         bVgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIYREsdwruiAJw/qfy7/N6fp7fX2NwKU/QCAHM77CgaPxpa4rWR6BMI+2/aZelhhs8TlRsp1OmoKoPrr2HFh4JGf08IckRJgHYdoh/
X-Gm-Message-State: AOJu0YysQSxF371Nt9RhPlP3bbB7Nr8GVFwzhMjuNefU1qhmPPajfIJK
	xNNYRNqGO9mew/oL4rE6pYzBLOKSI2oX0aI79Dh5PJRndid553Vn
X-Google-Smtp-Source: AGHT+IGUAS4z7jwjvXAgc6++PRtLN8fsIWbCjBqWw0R+rrOrtg/CI+xvmGsrDNivWZNBDGY1/XhRLA==
X-Received: by 2002:a17:906:375b:b0:a4e:1e28:14df with SMTP id e27-20020a170906375b00b00a4e1e2814dfmr1150715ejc.66.1711624070331;
        Thu, 28 Mar 2024 04:07:50 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id dr3-20020a170907720300b00a4a38d10801sm623467ejc.35.2024.03.28.04.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 04:07:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 28 Mar 2024 12:07:48 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, qyousef@layalina.io,
	linux-kernel@vger.kernel.org, vschneid@redhat.com
Subject: Re: [PATCH v3 0/2] sched: Minor changes for rd->overload access
Message-ID: <ZgVPhODZ8/nbsqbP@gmail.com>
References: <20240325054505.201995-1-sshegde@linux.ibm.com>
 <ZgFTtAOw39tIyfzR@gmail.com>
 <3c92c18b-6a19-4477-9972-1219c29b3d71@linux.ibm.com>
 <ZgKApcWeuwxc2+WO@gmail.com>
 <38c39ea6-21df-44e9-96e7-6f6fd35822a7@linux.ibm.com>
 <ZgVHq65XKsOZpfgK@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgVHq65XKsOZpfgK@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> Plus I've applied a patch to rename ::overload to ::overloaded. It is 
> silly to use an ambiguous noun instead of a clear adjective when naming 
> such a flag ...

Plus SG_OVERLOAD should be SG_OVERLOADED as well - it now looks in line 
with SG_OVERUTILIZED:

 /* Scheduling group status flags */
 #define SG_OVERLOADED           0x1 /* More than one runnable task on a CPU. */
 #define SG_OVERUTILIZED         0x2 /* One or more CPUs are over-utilized. */

My followup question is: why are these a bitmask, why not separate 
flags?

AFAICS we only ever set them separately:

 thule:~/tip> git grep SG_OVER kernel/sched/
 kernel/sched/fair.c:            set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
 kernel/sched/fair.c:                    *sg_status |= SG_OVERLOADED;
 kernel/sched/fair.c:                    *sg_status |= SG_OVERUTILIZED;
 kernel/sched/fair.c:                            *sg_status |= SG_OVERLOADED;
 kernel/sched/fair.c:            set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);
 kernel/sched/fair.c:                                       sg_status & SG_OVERUTILIZED);
 kernel/sched/fair.c:    } else if (sg_status & SG_OVERUTILIZED) {
 kernel/sched/fair.c:            set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
 kernel/sched/sched.h:#define SG_OVERLOADED              0x1 /* More than one runnable task on a CPU. */
 kernel/sched/sched.h:#define SG_OVERUTILIZED            0x2 /* One or more CPUs are over-utilized. */
 kernel/sched/sched.h:           set_rd_overloaded(rq->rd, SG_OVERLOADED);

In fact this results in suboptimal code:

                /* update overload indicator if we are at root domain */
                set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);
                        
                /* Update over-utilization (tipping point, U >= 0) indicator */
                set_rd_overutilized_status(env->dst_rq->rd,
                                           sg_status & SG_OVERUTILIZED);

Note how the bits that got mixed together in sg_status now have to be 
masked out individually.

The sg_status bitmask appears to make no sense at all to me.

By turning these into individual bool flags we could also do away with 
all the extra SG_OVERLOADED/SG_OVERUTILIZED abstraction.

Ie. something like the patch below? Untested.

Thanks,

	Ingo

=================>
From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 28 Mar 2024 12:00:14 +0100
Subject: [PATCH] sched/balancing: Simplify the sg_status bitmask and use separate ->overloaded and ->overutilized flags

SG_OVERLOADED and SG_OVERUTILIZED flags plus the sg_status bitmask are an
unnecessary complication that only make the code harder to read and slower.

We only ever set them separately:

 thule:~/tip> git grep SG_OVER kernel/sched/
 kernel/sched/fair.c:            set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
 kernel/sched/fair.c:                    *sg_status |= SG_OVERLOADED;
 kernel/sched/fair.c:                    *sg_status |= SG_OVERUTILIZED;
 kernel/sched/fair.c:                            *sg_status |= SG_OVERLOADED;
 kernel/sched/fair.c:            set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);
 kernel/sched/fair.c:                                       sg_status & SG_OVERUTILIZED);
 kernel/sched/fair.c:    } else if (sg_status & SG_OVERUTILIZED) {
 kernel/sched/fair.c:            set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
 kernel/sched/sched.h:#define SG_OVERLOADED              0x1 /* More than one runnable task on a CPU. */
 kernel/sched/sched.h:#define SG_OVERUTILIZED            0x2 /* One or more CPUs are over-utilized. */
 kernel/sched/sched.h:           set_rd_overloaded(rq->rd, SG_OVERLOADED);

And use them separately, which results in suboptimal code:

                /* update overload indicator if we are at root domain */
                set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);

                /* Update over-utilization (tipping point, U >= 0) indicator */
                set_rd_overutilized_status(env->dst_rq->rd,

Introduce separate sg_overloaded and sg_overutilized flags in update_sd_lb_stats()
and its lower level functions, and change all of them to 'bool'.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 33 ++++++++++++++++-----------------
 kernel/sched/sched.h | 17 ++++++-----------
 2 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f29efd5f19f6..ebc8d5f855de 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6688,19 +6688,18 @@ static inline bool cpu_overutilized(int cpu)
 /*
  * overutilized value make sense only if EAS is enabled
  */
-static inline int is_rd_overutilized(struct root_domain *rd)
+static inline bool is_rd_overutilized(struct root_domain *rd)
 {
 	return !sched_energy_enabled() || READ_ONCE(rd->overutilized);
 }
 
-static inline void set_rd_overutilized(struct root_domain *rd,
-					      unsigned int status)
+static inline void set_rd_overutilized(struct root_domain *rd, bool flag)
 {
 	if (!sched_energy_enabled())
 		return;
 
-	WRITE_ONCE(rd->overutilized, status);
-	trace_sched_overutilized_tp(rd, !!status);
+	WRITE_ONCE(rd->overutilized, flag);
+	trace_sched_overutilized_tp(rd, flag);
 }
 
 static inline void check_update_overutilized_status(struct rq *rq)
@@ -6711,7 +6710,7 @@ static inline void check_update_overutilized_status(struct rq *rq)
 	 */
 
 	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
-		set_rd_overutilized(rq->rd, SG_OVERUTILIZED);
+		set_rd_overutilized(rq->rd, 1);
 }
 #else
 static inline void check_update_overutilized_status(struct rq *rq) { }
@@ -9940,7 +9939,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				      struct sd_lb_stats *sds,
 				      struct sched_group *group,
 				      struct sg_lb_stats *sgs,
-				      int *sg_status)
+				      bool *sg_overloaded,
+				      bool *sg_overutilized)
 {
 	int i, nr_running, local_group;
 
@@ -9961,10 +9961,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->sum_nr_running += nr_running;
 
 		if (nr_running > 1)
-			*sg_status |= SG_OVERLOADED;
+			*sg_overloaded = 1;
 
 		if (cpu_overutilized(i))
-			*sg_status |= SG_OVERUTILIZED;
+			*sg_overutilized = 1;
 
 #ifdef CONFIG_NUMA_BALANCING
 		sgs->nr_numa_running += rq->nr_numa_running;
@@ -9986,7 +9986,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			/* Check for a misfit task on the cpu */
 			if (sgs->group_misfit_task_load < rq->misfit_task_load) {
 				sgs->group_misfit_task_load = rq->misfit_task_load;
-				*sg_status |= SG_OVERLOADED;
+				*sg_overloaded = 1;
 			}
 		} else if (env->idle && sched_reduced_capacity(rq, env->sd)) {
 			/* Check for a task running on a CPU with reduced capacity */
@@ -10612,7 +10612,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
 	unsigned long sum_util = 0;
-	int sg_status = 0;
+	bool sg_overloaded = 0, sg_overutilized = 0;
 
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
@@ -10628,7 +10628,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 				update_group_capacity(env->sd, env->dst_cpu);
 		}
 
-		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
+		update_sg_lb_stats(env, sds, sg, sgs, &sg_overloaded, &sg_overutilized);
 
 		if (!local_group && update_sd_pick_busiest(env, sds, sg, sgs)) {
 			sds->busiest = sg;
@@ -10657,13 +10657,12 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 	if (!env->sd->parent) {
 		/* update overload indicator if we are at root domain */
-		set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);
+		set_rd_overloaded(env->dst_rq->rd, sg_overloaded);
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
-		set_rd_overutilized(env->dst_rq->rd,
-					   sg_status & SG_OVERUTILIZED);
-	} else if (sg_status & SG_OVERUTILIZED) {
-		set_rd_overutilized(env->dst_rq->rd, SG_OVERUTILIZED);
+		set_rd_overutilized(env->dst_rq->rd, sg_overloaded);
+	} else if (sg_overutilized) {
+		set_rd_overutilized(env->dst_rq->rd, sg_overutilized);
 	}
 
 	update_idle_cpu_scan(env, sum_util);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 07c6669b8250..7c39dbf31f75 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -713,7 +713,7 @@ struct rt_rq {
 	} highest_prio;
 #endif
 #ifdef CONFIG_SMP
-	int			overloaded;
+	bool			overloaded;
 	struct plist_head	pushable_tasks;
 
 #endif /* CONFIG_SMP */
@@ -757,7 +757,7 @@ struct dl_rq {
 		u64		next;
 	} earliest_dl;
 
-	int			overloaded;
+	bool			overloaded;
 
 	/*
 	 * Tasks on this rq that can be pushed away. They are kept in
@@ -850,10 +850,6 @@ struct perf_domain {
 	struct rcu_head rcu;
 };
 
-/* Scheduling group status flags */
-#define SG_OVERLOADED		0x1 /* More than one runnable task on a CPU. */
-#define SG_OVERUTILIZED		0x2 /* One or more CPUs are over-utilized. */
-
 /*
  * We add the notion of a root-domain which will be used to define per-domain
  * variables. Each exclusive cpuset essentially defines an island domain by
@@ -874,10 +870,10 @@ struct root_domain {
 	 * - More than one runnable task
 	 * - Running task is misfit
 	 */
-	int			overloaded;
+	bool			overloaded;
 
 	/* Indicate one or more cpus over-utilized (tipping point) */
-	int			overutilized;
+	bool			overutilized;
 
 	/*
 	 * The bit corresponding to a CPU gets set here if such CPU has more
@@ -2540,9 +2536,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 	}
 
 #ifdef CONFIG_SMP
-	if (prev_nr < 2 && rq->nr_running >= 2) {
-		set_rd_overloaded(rq->rd, SG_OVERLOADED);
-	}
+	if (prev_nr < 2 && rq->nr_running >= 2)
+		set_rd_overloaded(rq->rd, 1);
 #endif
 
 	sched_update_tick_dependency(rq);


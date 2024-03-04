Return-Path: <linux-kernel+bounces-90348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0752E86FDF7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898061F2335E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527B5225CD;
	Mon,  4 Mar 2024 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJzpPPBG"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5131A224DE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545729; cv=none; b=o3Xqudn/Qwfxbl+eMQ/NmKtfHCIEX7newRa1fjrmt8/lrmnbru2HDcz1WSYZvz7i6E5lgsJ0EOzDXckeQro1VUgE1Eh8eHodfAsTt9WZ0ej9/RLlwbaIHDj5RLzzfp1np+wGjXtlY6iKWlRFZwg1vwlcgTYYn0OYd/N63aDRONc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545729; c=relaxed/simple;
	bh=wGnnv0R/i5/PFNWqQGKADyW9AWcXKqVYmEaB4jhEARo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uv2R86xryxpMtFNl4YIhpsJUEo6y8SQWm5faKJ7YB6AF4Mvr+8e4UMZapNKBc+WMAn5K6tE5n4dBp6Eow3zgwneFLZ9iNAecCgsQJNMGjvatyBfvq1AIVz4upveluLKBa756jKGaZj5KjTkDGK+U3XUYUra/eHXnY6zDU+w+mdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJzpPPBG; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a44665605f3so445951166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709545726; x=1710150526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqL84XLNVn0Cp5LtqkDs2ZJplR67S7lT/DN/daWYchI=;
        b=MJzpPPBGzzB+wocEiP2Lw1a22hifMTk0ye6X+OxnJHMTmWCRORlXrCqAznkQd5Wg/t
         svd4fH+q7+n9HSOH3zS8E5LFYlmWEX85BXUO9Mw47wjK2IMZSE9Ry12/Y3Wlwd9m2dwu
         /C3s3XePCGcXyEVE2WFwK2h/gTPj0I2R7WPC6hnYV1ysUngpaiecY7x1LPJYfBrs433a
         nh7CIojBtPmGIARiYiPY5SfJmPf7WhTZHwAHKdQ++VSM9htfqjqluEnLECU2jQADa0HF
         fqZZRValzIuvMZOB38WvxDzPnoQ74x2vJER1I72csJyXe1TSuRJD+OyULjFHW7qqthYs
         2Qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545726; x=1710150526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tqL84XLNVn0Cp5LtqkDs2ZJplR67S7lT/DN/daWYchI=;
        b=kLx/wNgwyVFW9DMYKarMwMNXxuoq1/kxYtrlCq+5rZ/m3xgKFnQ4M3IVaeqBf+Rwar
         G1PzRUpYXw0cMdqzLEW7amlueJVHJVdqHypaaU40fedOgg2WWFQKfbhAPhWXfXxuu1sv
         z/11N0iJWzJWU5ouNWvO9fhm2PpxBh/e6FFpOCf7NukJpHq2W5127ya82Zi7AT+3BmhT
         VkCILEgAT4XrzHiE2I6D2cBRwtiWi60doRA39Jt2amVgn1yrxF9+t2zmPCZIpe/pGH8X
         U9wrmqqhUIjgdelhnVl7kxnckkmysy3IBrJMWrq4w+bcSknDlr1029rykAEWeosAvanf
         TWxg==
X-Gm-Message-State: AOJu0YyrKfBWjvAen12XFFrurtO7XSRkSXGM/TbGnVjvvGM/cP1eNBkb
	JRbHbk3iTWlFYqJ7zsp07MdJXt/gZqVwQFgXjx3GaPKtqENjmpy1CGPofbtfrdU=
X-Google-Smtp-Source: AGHT+IHV0HTMqTVqrfr0L03RNRjP18egljCvxPlSy3wm30aYM2snihMa+ewSPAaFDShsElvpB+I4YQ==
X-Received: by 2002:a17:906:19cf:b0:a44:1f20:e6d6 with SMTP id h15-20020a17090619cf00b00a441f20e6d6mr5618226ejd.1.1709545725576;
        Mon, 04 Mar 2024 01:48:45 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id s22-20020a170906501600b00a42e2bc82dbsm4569839ejj.169.2024.03.04.01.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:48:45 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 3/9] sched/balancing: Change 'enum cpu_idle_type' to have more natural definitions
Date: Mon,  4 Mar 2024 10:48:25 +0100
Message-Id: <20240304094831.3639338-4-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240304094831.3639338-1-mingo@kernel.org>
References: <20240304094831.3639338-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpu_idle_type enum has the confusingly inverted property
that 'not idle' is 1, and 'idle' is '0'.

This resulted in a number of unnecessary complications in the code.

Reverse the order, remove the CPU_NOT_IDLE type, and convert
all code to a natural boolean form.

It's much more readable:

  -       enum cpu_idle_type idle = this_rq->idle_balance ?
  -                                               CPU_IDLE : CPU_NOT_IDLE;
  -
  +       enum cpu_idle_type idle = this_rq->idle_balance;

  --------------------------------

  -       if (env->idle == CPU_NOT_IDLE || !busiest->sum_nr_running)
  +       if (!env->idle || !busiest->sum_nr_running)

  --------------------------------

And gets rid of the double negation in these usages:

  -               if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1)
  +               if (env->idle && env->src_rq->nr_running <= 1)

Furthermore, this makes code much more obvious where there's
differentiation between CPU_IDLE and CPU_NEWLY_IDLE.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/sched/idle.h |  3 +--
 kernel/sched/fair.c        | 27 ++++++++++++---------------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 478084f9105e..4a6423700ffc 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -5,8 +5,7 @@
 #include <linux/sched.h>
 
 enum cpu_idle_type {
-	CPU_IDLE,
-	CPU_NOT_IDLE,
+	CPU_IDLE = 1,
 	CPU_NEWLY_IDLE,
 	CPU_MAX_IDLE_TYPES
 };
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 64ae3d8dc93b..f11fc6dd39b1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9070,7 +9070,7 @@ static int detach_tasks(struct lb_env *env)
 		 * We don't want to steal all, otherwise we may be treated likewise,
 		 * which could at worst lead to a livelock crash.
 		 */
-		if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1)
+		if (env->idle && env->src_rq->nr_running <= 1)
 			break;
 
 		env->loop++;
@@ -9803,7 +9803,7 @@ static inline bool smt_vs_nonsmt_groups(struct sched_group *sg1,
 static inline bool smt_balance(struct lb_env *env, struct sg_lb_stats *sgs,
 			       struct sched_group *group)
 {
-	if (env->idle == CPU_NOT_IDLE)
+	if (!env->idle)
 		return false;
 
 	/*
@@ -9827,7 +9827,7 @@ static inline long sibling_imbalance(struct lb_env *env,
 	int ncores_busiest, ncores_local;
 	long imbalance;
 
-	if (env->idle == CPU_NOT_IDLE || !busiest->sum_nr_running)
+	if (!env->idle || !busiest->sum_nr_running)
 		return 0;
 
 	ncores_busiest = sds->busiest->cores;
@@ -9927,8 +9927,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				sgs->group_misfit_task_load = rq->misfit_task_load;
 				*sg_status |= SG_OVERLOAD;
 			}
-		} else if ((env->idle != CPU_NOT_IDLE) &&
-			   sched_reduced_capacity(rq, env->sd)) {
+		} else if (env->idle && sched_reduced_capacity(rq, env->sd)) {
 			/* Check for a task running on a CPU with reduced capacity */
 			if (sgs->group_misfit_task_load < load)
 				sgs->group_misfit_task_load = load;
@@ -9940,7 +9939,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_weight = group->group_weight;
 
 	/* Check if dst CPU is idle and preferred to this group */
-	if (!local_group && env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
+	if (!local_group && env->idle && sgs->sum_h_nr_running &&
 	    sched_group_asym(env, sgs, group))
 		sgs->group_asym_packing = 1;
 
@@ -10698,7 +10697,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			 * waiting task in this overloaded busiest group. Let's
 			 * try to pull it.
 			 */
-			if (env->idle != CPU_NOT_IDLE && env->imbalance == 0) {
+			if (env->idle && env->imbalance == 0) {
 				env->migration_type = migrate_task;
 				env->imbalance = 1;
 			}
@@ -10913,7 +10912,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 		goto force_balance;
 
 	if (busiest->group_type != group_overloaded) {
-		if (env->idle == CPU_NOT_IDLE) {
+		if (!env->idle) {
 			/*
 			 * If the busiest group is not overloaded (and as a
 			 * result the local one too) but this CPU is already
@@ -11121,7 +11120,7 @@ asym_active_balance(struct lb_env *env)
 	 * the lower priority @env::dst_cpu help it. Do not follow
 	 * CPU priority.
 	 */
-	return env->idle != CPU_NOT_IDLE && sched_use_asym_prio(env->sd, env->dst_cpu) &&
+	return env->idle && sched_use_asym_prio(env->sd, env->dst_cpu) &&
 	       (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
 		!sched_use_asym_prio(env->sd, env->src_cpu));
 }
@@ -11159,7 +11158,7 @@ static int need_active_balance(struct lb_env *env)
 	 * because of other sched_class or IRQs if more capacity stays
 	 * available on dst_cpu.
 	 */
-	if ((env->idle != CPU_NOT_IDLE) &&
+	if (env->idle &&
 	    (env->src_rq->cfs.h_nr_running == 1)) {
 		if ((check_cpu_capacity(env->src_rq, sd)) &&
 		    (capacity_of(env->src_cpu)*sd->imbalance_pct < capacity_of(env->dst_cpu)*100))
@@ -11735,8 +11734,8 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 				 * env->dst_cpu, so we can't know our idle
 				 * state even if we migrated tasks. Update it.
 				 */
-				idle = idle_cpu(cpu) ? CPU_IDLE : CPU_NOT_IDLE;
-				busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
+				idle = idle_cpu(cpu);
+				busy = !idle && !sched_idle_cpu(cpu);
 			}
 			sd->last_balance = jiffies;
 			interval = get_sd_balance_interval(sd, busy);
@@ -12416,9 +12415,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
 {
 	struct rq *this_rq = this_rq();
-	enum cpu_idle_type idle = this_rq->idle_balance ?
-						CPU_IDLE : CPU_NOT_IDLE;
-
+	enum cpu_idle_type idle = this_rq->idle_balance;
 	/*
 	 * If this CPU has a pending nohz_balance_kick, then do the
 	 * balancing on behalf of the other idle CPUs whose ticks are
-- 
2.40.1



Return-Path: <linux-kernel+bounces-100221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5E38793A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2E41C20990
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D21B8002D;
	Tue, 12 Mar 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z22UkzfA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xa77iOTw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA447E119;
	Tue, 12 Mar 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244838; cv=none; b=MFX94Ol0dy9iXPBcoq4/Gj5Db+14rCoDquQitSExk28KePr6Zw7SivXo65VnlEJ3ex7gku5t4sAcdNODlCMSZdThptQtGizsksSGPTnHoQQZYitUlwcHPSbufYVokUC2HQc7k4ZDLvZJSk3gUfX3TEgOzoXSFuLrovmyImcOCqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244838; c=relaxed/simple;
	bh=yyYeHYZBueKP144TnOAZc2ZB9b7S1A8d+6M7LwHsntU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CKTEcZXqfDa6eaROfHtjWUWp3ZMjH2DP1p00t+GDtTA3mwfpjMMLJRwPUvLCL7d9N153HN6rqm9FFqtiA8v49j5gZhIcZZgAm74lnU/JdUVv9QIwwRs/JWUDuENGsmBVic+KHYaVVcpRex14cL7NVjvSOXHsaYvgkQghiwLDxpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z22UkzfA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xa77iOTw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244834;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGsnJkxiuDTrLJSj9ooSp1Zwaa9UFKn+9GLbz2Er8Ek=;
	b=Z22UkzfApMUfpc5mwv4MDhuj5ul/eIpnJPDV5O8AccR1lGrkRkpiTwzLH3yqTf1hG/zinY
	Zre7rzjemSs8CLqt4zI5EwsQaz3ZoLHDwpquO7tOaB46ig1/N6sN4QrHV+AOkh6RH9zCzV
	BPSL4vsebNkkmERHCTggqPZGw03xvRAvAMBBBBaOfsGN6gihumAM7L+RqWVn+2JRXAueXI
	65uMS93EF2fi33raWCmp4SrH2fSMTUPrUZqSgUMHRJE1/ffe6/psSYAF2UCO+HlODd6uMK
	mFqIJwXd3qSfXsrhEXg/Vj2OVmhHQTNytDzcoLxpHsdEX7USv0SBDdvYZwUk7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244834;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGsnJkxiuDTrLJSj9ooSp1Zwaa9UFKn+9GLbz2Er8Ek=;
	b=Xa77iOTw2XWOxomeC/etefPFLHdsum0Wc6IrlGBHhK7dxRR6sqRlMz/Bw/taDDphT7VmQZ
	9sP1Oyymp9nCYpAg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Change 'enum cpu_idle_type' to
 have more natural definitions
Cc: Ingo Molnar <mingo@kernel.org>, Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240308105901.1096078-4-mingo@kernel.org>
References: <20240308105901.1096078-4-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024483402.398.15168980495153981545.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     38d707c54df4ca58cd9ceae2ddcbd6f606b99e9f
Gitweb:        https://git.kernel.org/tip/38d707c54df4ca58cd9ceae2ddcbd6f606b99e9f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 11:58:54 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 11:03:40 +01:00

sched/balancing: Change 'enum cpu_idle_type' to have more natural definitions

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
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Link: https://lore.kernel.org/r/20240308105901.1096078-4-mingo@kernel.org
---
 include/linux/sched/idle.h |  2 +-
 kernel/sched/fair.c        | 27 ++++++++++++---------------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 478084f..e670ac2 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -5,8 +5,8 @@
 #include <linux/sched.h>
 
 enum cpu_idle_type {
+	__CPU_NOT_IDLE = 0,
 	CPU_IDLE,
-	CPU_NOT_IDLE,
 	CPU_NEWLY_IDLE,
 	CPU_MAX_IDLE_TYPES
 };
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2ef89b3..3a510cf 100644
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
@@ -12416,9 +12415,7 @@ out:
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


Return-Path: <linux-kernel+bounces-85752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C10A86BA57
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C394FB2716C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B15176EE7;
	Wed, 28 Feb 2024 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FC+Dv21u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yVOqGG6V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462B971EC6;
	Wed, 28 Feb 2024 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157617; cv=none; b=LtIjdpirhxFgJKUx++EHD6tDiagI2+MMdPoPNT/2hfU1rntHBF8S6uLo9pfCbTbvXzZm19Rl+udEYD9MnAZevIqI4F/rUR2K4o5lWlb2uaBmsj4wx8bnpimMEL9Ks/PANADq6MZird97ZQ5IyIFXq9LnJVWCCPF34zw5CsqzBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157617; c=relaxed/simple;
	bh=M7/t+vmuZUBNYlndvDjvtjkDrw/gZ7RkxZAMRtIdRQY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CqdSzFJEu7WXTocRQWF2+oszkY5N9oqaNgrVyR2NXsQwKXu8Z/nWnBJjca5PqmFsw6btxXfprcGS3WLWoTTzlsCa/ZBUh0UQGrr5oY+gE6fug2QxzeUEAhFoPhwT6c/yCs2eqBQBg5Ae4aHfcQhzGagS6zkURKyUS8aVE6AghRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FC+Dv21u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yVOqGG6V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 22:00:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709157607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kki+4CB7NfA7NzLJwtSRlpxyjoYz8tg8nb8RS1jFq1o=;
	b=FC+Dv21uzUXT9CDwddB/GvwWaq/ZczwFLHQckPWFULOXbhz5EBe56hc9ufG5/O76buDDLx
	3fOiIks1bHHvTtC83Jg5SW09fwnn5E1M0yUdPsyjxgodM/+TCw7HwX+dHkSWXAbEYcmohj
	Lcd6b/+KRinS0lXXdPPPJgwqOmaf2T4CuWnzU0//0J68m52XAqfYl0lJNOBIQsf4UIGq1U
	igWb0bsooau22x+rjFb5Rrj5+CpyuGHt0SG6PQt4ZT5VBbQiR04Yz1pH68AwKO7DyPLrBx
	ghQVD4PMNCqDBcFSKF6oyKQotVxpKzVOkBXf0XVF2wyPAE8Go6LZE/92Frmcsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709157607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kki+4CB7NfA7NzLJwtSRlpxyjoYz8tg8nb8RS1jFq1o=;
	b=yVOqGG6VQAFvXFnv23EHXV7ePutCXzQ56ptvUfhSx086fJD+tINCiGxClE0XhbfYTH5d9N
	26ykKHVcOJT+3cAQ==
From: "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Rework sched_use_asym_prio() and
 sched_asym_prefer()
Cc: Alex Shi <alexs@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240210113924.1130448-3-alexs@kernel.org>
References: <20240210113924.1130448-3-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170915760622.398.9618229339531688881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     45de20623475049c424bc0b89f42efca54995edd
Gitweb:        https://git.kernel.org/tip/45de20623475049c424bc0b89f42efca54995edd
Author:        Alex Shi <alexs@kernel.org>
AuthorDate:    Sat, 10 Feb 2024 19:39:21 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 15:43:17 +01:00

sched/fair: Rework sched_use_asym_prio() and sched_asym_prefer()

sched_use_asym_prio() and sched_asym_prefer() are used together in various
places. Consolidate them into a single function sched_asym().

The existing sched_asym() function is only used when collecting statistics
of a scheduling group. Rename it as sched_group_asym(), and remove the
obsolete function description.

This makes the code easier to read. No functional changes.

Signed-off-by: Alex Shi <alexs@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240210113924.1130448-3-alexs@kernel.org
---
 kernel/sched/fair.c | 45 +++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 300d1bf..475e2ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9750,8 +9750,18 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
 }
 
+static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu)
+{
+	/*
+	 * First check if @dst_cpu can do asym_packing load balance. Only do it
+	 * if it has higher priority than @src_cpu.
+	 */
+	return sched_use_asym_prio(sd, dst_cpu) &&
+		sched_asym_prefer(dst_cpu, src_cpu);
+}
+
 /**
- * sched_asym - Check if the destination CPU can do asym_packing load balance
+ * sched_group_asym - Check if the destination CPU can do asym_packing balance
  * @env:	The load balancing environment
  * @sgs:	Load-balancing statistics of the candidate busiest group
  * @group:	The candidate busiest group
@@ -9759,34 +9769,21 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
  * @env::dst_cpu can do asym_packing if it has higher priority than the
  * preferred CPU of @group.
  *
- * SMT is a special case. If we are balancing load between cores, @env::dst_cpu
- * can do asym_packing balance only if all its SMT siblings are idle. Also, it
- * can only do it if @group is an SMT group and has exactly on busy CPU. Larger
- * imbalances in the number of CPUS are dealt with in find_busiest_group().
- *
- * If we are balancing load within an SMT core, or at PKG domain level, always
- * proceed.
- *
  * Return: true if @env::dst_cpu can do with asym_packing load balance. False
  * otherwise.
  */
 static inline bool
-sched_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
+sched_group_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
 {
-	/* Ensure that the whole local core is idle, if applicable. */
-	if (!sched_use_asym_prio(env->sd, env->dst_cpu))
-		return false;
-
 	/*
-	 * CPU priorities does not make sense for SMT cores with more than one
+	 * CPU priorities do not make sense for SMT cores with more than one
 	 * busy sibling.
 	 */
-	if (group->flags & SD_SHARE_CPUCAPACITY) {
-		if (sgs->group_weight - sgs->idle_cpus != 1)
-			return false;
-	}
+	if ((group->flags & SD_SHARE_CPUCAPACITY) &&
+	    (sgs->group_weight - sgs->idle_cpus != 1))
+		return false;
 
-	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
+	return sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);
 }
 
 /* One group has more than one SMT CPU while the other group does not */
@@ -9942,7 +9939,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	/* Check if dst CPU is idle and preferred to this group */
 	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
 	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
-	    sched_asym(env, sgs, group)) {
+	    sched_group_asym(env, sgs, group)) {
 		sgs->group_asym_packing = 1;
 	}
 
@@ -11028,8 +11025,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * SMT cores with more than one busy sibling.
 		 */
 		if ((env->sd->flags & SD_ASYM_PACKING) &&
-		    sched_use_asym_prio(env->sd, i) &&
-		    sched_asym_prefer(i, env->dst_cpu) &&
+		    sched_asym(env->sd, i, env->dst_cpu) &&
 		    nr_running == 1)
 			continue;
 
@@ -11899,8 +11895,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * preferred CPU must be idle.
 		 */
 		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
-			if (sched_use_asym_prio(sd, i) &&
-			    sched_asym_prefer(i, cpu)) {
+			if (sched_asym(sd, i, cpu)) {
 				flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 				goto unlock;
 			}


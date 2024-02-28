Return-Path: <linux-kernel+bounces-85751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAAE86BA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4AF285085
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C0E72915;
	Wed, 28 Feb 2024 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2XjEvsDu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/UrAq7Cp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B316871ECC;
	Wed, 28 Feb 2024 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157615; cv=none; b=ZW0AngxJ5JRkrtyX3T1oNZhvJ+8G26apL4xANHzs8Md9ETzMcDpe89OBJFkarFyVGjES+3jXejOXtd2+LTlknrtM4jd09joatFzsHh0EWf/hGB/Y7uJaWQO7xIOuFa+jIFGdODk2Pz8daRJ/5eQ2wJRWxqEG1xAVLbeQLe5IYMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157615; c=relaxed/simple;
	bh=5lp/NbP0ANQPeyEBDi8R6ySWbCPdnYiNPagn3a2OrXg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oINlvOnI94dvTXIcsVzmtTTCfre5cT5HH8mUXSiUUpyT548vc58+MZY0qqmxJi57/06oJHXwk32UgZ5zYXiw0uCbH5xhLH6fbHbJ+UEA069Yw9lsh8PgDHBBCPCr7JEC0TPsIdWXYs6YoDUuxdyLStUYhL9+SC8rBz8j44dbU+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2XjEvsDu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/UrAq7Cp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 22:00:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709157606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/w85MqrNq8SXh7VO2a1H8eeiPa+skP+jL4mSuCxESp0=;
	b=2XjEvsDuZuUkPG0JCa2UDvEWltCmaedRNWWJezG1K6e86l8DfA2bMpJHfHtURrHX8/z1LP
	PjgJJZrgQJijjpRTyQL4bLNjiKSgAsihJVpGKoNsksjVtGtBt1WrCISblxjY8SjtyPFGIC
	AZMW5y7O0zS4wKIKV5IIK2lDEg9CPn3LPGl5j7shINGqCG99VuhGpm0tsgFyqIWw7sokaq
	/8iC2AZaGMf40DRJWPBuibh33B076+daxD3sFHfFE+kNUZacF8qYaCxFR+RCMJ8R5P7E0T
	dxuRX4kcR5Nu84bA9NqifpxxdTrE6rz1aMx3qLdsNBS6qPtpVuVEe3nj5CJ4Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709157606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/w85MqrNq8SXh7VO2a1H8eeiPa+skP+jL4mSuCxESp0=;
	b=/UrAq7Cp3IFcrKie38X+dy7ZmORusp3It1r5azeD8mBpd6CqnGITWJODurHMHJErgoPTZU
	Uj3PeHJdeg8Fq7DQ==
From: "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Check the SD_ASYM_PACKING flag in
 sched_use_asym_prio()
Cc: Alex Shi <alexs@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240210113924.1130448-4-alexs@kernel.org>
References: <20240210113924.1130448-4-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170915760555.398.490945038019686205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fbc449864e0d2ee2c16f3af2d1e9093b9b8d7ad0
Gitweb:        https://git.kernel.org/tip/fbc449864e0d2ee2c16f3af2d1e9093b9b8d7ad0
Author:        Alex Shi <alexs@kernel.org>
AuthorDate:    Sat, 10 Feb 2024 19:39:22 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 15:43:17 +01:00

sched/fair: Check the SD_ASYM_PACKING flag in sched_use_asym_prio()

sched_use_asym_prio() checks whether CPU priorities should be used. It
makes sense to check for the SD_ASYM_PACKING() inside the function.
Since both sched_asym() and sched_group_asym() use sched_use_asym_prio(),
remove the now superfluous checks for the flag in various places.

Signed-off-by: Alex Shi <alexs@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240210113924.1130448-4-alexs@kernel.org
---
 kernel/sched/fair.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 475e2ca..39781a6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9744,6 +9744,9 @@ group_type group_classify(unsigned int imbalance_pct,
  */
 static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 {
+	if (!(sd->flags & SD_ASYM_PACKING))
+		return false;
+
 	if (!sched_smt_active())
 		return true;
 
@@ -9937,11 +9940,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_weight = group->group_weight;
 
 	/* Check if dst CPU is idle and preferred to this group */
-	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
-	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
-	    sched_group_asym(env, sgs, group)) {
+	if (!local_group && env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
+	    sched_group_asym(env, sgs, group))
 		sgs->group_asym_packing = 1;
-	}
 
 	/* Check for loaded SMT group to be balanced to dst CPU */
 	if (!local_group && smt_balance(env, sgs, group))
@@ -11024,9 +11025,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * If balancing between cores, let lower priority CPUs help
 		 * SMT cores with more than one busy sibling.
 		 */
-		if ((env->sd->flags & SD_ASYM_PACKING) &&
-		    sched_asym(env->sd, i, env->dst_cpu) &&
-		    nr_running == 1)
+		if (sched_asym(env->sd, i, env->dst_cpu) && nr_running == 1)
 			continue;
 
 		switch (env->migration_type) {
@@ -11122,8 +11121,7 @@ asym_active_balance(struct lb_env *env)
 	 * the lower priority @env::dst_cpu help it. Do not follow
 	 * CPU priority.
 	 */
-	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
-	       sched_use_asym_prio(env->sd, env->dst_cpu) &&
+	return env->idle != CPU_NOT_IDLE && sched_use_asym_prio(env->sd, env->dst_cpu) &&
 	       (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
 		!sched_use_asym_prio(env->sd, env->src_cpu));
 }


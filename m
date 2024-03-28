Return-Path: <linux-kernel+bounces-122721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EB588FC0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470A11C2D195
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2D67B3FD;
	Thu, 28 Mar 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g9OfIYJm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eGAmxNV7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3924E657B7;
	Thu, 28 Mar 2024 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619424; cv=none; b=G6qZCmv60Y83nos9mIEG3jynaigZHixUOUnTEIvq8RE71ncLO/hE9IS5j+kXGShxwlyXtR428ANLy2xscvQxLT0EfA10droicTFocBJm7/kDDuIlPttPoDtcAtD0rAfM0ly0vnMLRcwVc2QdvhPcCIt0C3p3PO4ITfz9EUuLM+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619424; c=relaxed/simple;
	bh=SUi06SVhQ1CeX1M5/vaiDk/LDWppX360WfFjSq4XvIo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YS7/hOp2CxsD0J5l6Atrk1eeQYoWyC63nR0Di7Si6xUZ1PWOfhAzeXzLISX8/YH8YA2y4CEmUycbU709eErGurzNZ0a0VjXgd1N4Gbhfj1Ax9eoN6ZF1jfPsu4/Pqv8U/8J831JVVOoj7yfOvBjtB9oCsq/QiDSKdg72cqjl4kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g9OfIYJm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eGAmxNV7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 28 Mar 2024 09:50:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711619421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWBFk7E4e9RaDBUdcG0EGwI7Xono95rwLUx6jTGftV0=;
	b=g9OfIYJmWMtHHzHUsxOI/TPSgRZcCIk54Je4GZD6cDOgEyv7NdXcdnWIafcum0MAXRkk00
	m7nVn9KnSNzwUth+w5Rm259PQ1u/FXcNTFhAJaiIhqhD6VHj5FsfLYSCUDYyWkiL+EOE4G
	ftDGR1AZqi5J54TOQwZ+qTBesD+FilH+ntnRFPxjIe2QDS7LnL3FMbX9bbWqhldzaRaMPK
	EJHpgFVfoEBYJochZUqzmJvz8wsDV3jPQ168nO3nXdcC483RYSjN74oI4LPS4oRcqGL0ck
	5j1ttHVFP7bdfJ26BVkboFfcEhF0RpXhBpA/DVU/Gdg4zC4ym+CObA3RsdlzTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711619421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWBFk7E4e9RaDBUdcG0EGwI7Xono95rwLUx6jTGftV0=;
	b=eGAmxNV7jPGRRsDiiHxKbGdKQl6VZRw7imOvmWV+zkA+9wF+cfuvcU2c5Zjpc8kap6NnrO
	I8TPZq1xYSLsB1AA==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Combine EAS check with
 root_domain::overutilized access
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240326152616.380999-1-sshegde@linux.ibm.com>
References: <20240326152616.380999-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171161942000.10875.13585922975103561544.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     902e786c4a54a2c4f7462b9026bb56610888db3d
Gitweb:        https://git.kernel.org/tip/902e786c4a54a2c4f7462b9026bb56610888db3d
Author:        Shrikanth Hegde <sshegde@linux.ibm.com>
AuthorDate:    Tue, 26 Mar 2024 20:56:16 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 Mar 2024 10:39:18 +01:00

sched/fair: Combine EAS check with root_domain::overutilized access

Access to root_domainoverutilized is always used with sched_energy_enabled in
the pattern:

  if (sched_energy_enabled && !overutilized)
         do something

So modify the helper function to utilize this pattern. This is more
readable code as it would say, do something when root domain is not
overutilized. This function always return true when EAS is disabled.

No change in functionality intended.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240326152616.380999-1-sshegde@linux.ibm.com
---
 kernel/sched/fair.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1856e58..3846230 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6686,12 +6686,11 @@ static inline bool cpu_overutilized(int cpu)
 }
 
 /*
- * Ensure that caller can do EAS. overutilized value
- * make sense only if EAS is enabled
+ * overutilized value make sense only if EAS is enabled
  */
 static inline int is_rd_overutilized(struct root_domain *rd)
 {
-	return READ_ONCE(rd->overutilized);
+	return !sched_energy_enabled() || READ_ONCE(rd->overutilized);
 }
 
 static inline void set_rd_overutilized_status(struct root_domain *rd,
@@ -6710,8 +6709,6 @@ static inline void check_update_overutilized_status(struct rq *rq)
 	 * overutilized field is used for load balancing decisions only
 	 * if energy aware scheduler is being used
 	 */
-	if (!sched_energy_enabled())
-		return;
 
 	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
 		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
@@ -7999,7 +7996,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
-	if (!pd || is_rd_overutilized(rd))
+	if (!pd)
 		goto unlock;
 
 	/*
@@ -8202,7 +8199,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		    cpumask_test_cpu(cpu, p->cpus_ptr))
 			return cpu;
 
-		if (sched_energy_enabled()) {
+		if (!is_rd_overutilized(this_rq()->rd)) {
 			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
 			if (new_cpu >= 0)
 				return new_cpu;
@@ -10903,12 +10900,9 @@ static struct sched_group *sched_balance_find_src_group(struct lb_env *env)
 	if (busiest->group_type == group_misfit_task)
 		goto force_balance;
 
-	if (sched_energy_enabled()) {
-		struct root_domain *rd = env->dst_rq->rd;
-
-		if (rcu_dereference(rd->pd) && !is_rd_overutilized(rd))
-			goto out_balanced;
-	}
+	if (!is_rd_overutilized(env->dst_rq->rd) &&
+	    rcu_dereference(env->dst_rq->rd->pd))
+		goto out_balanced;
 
 	/* ASYM feature bypasses nice load balance check */
 	if (busiest->group_type == group_asym_packing)


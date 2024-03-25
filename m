Return-Path: <linux-kernel+bounces-116935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D752588A54B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618C81F3FA9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE928528D;
	Mon, 25 Mar 2024 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bi/Zi5Uf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R3bO6oUC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37281B676F;
	Mon, 25 Mar 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366106; cv=none; b=SNtt66BihB/k1j3ebeYAjMfW3fSmmPsfLCbG9JzFOVxf+Ld1paK1+kfliTAp3lIerJnEznf+2lERjzLkcmdxCjIkoZ7dCFUSGEX2rMFdKUpb6z756HiiSBumCeLgbaNFYEQ6WCPnHYhhfcFHtzEo+CODwqFwjWPSoLr5X5+1aaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366106; c=relaxed/simple;
	bh=Mevc//D5U/sk+zXFX3/K+36bG38aiGs+BHpJbYXpmRA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R1VAe5keL1wd9NMiKc597zne5HDiX1YLd+ETn8nQqXNB4uFB79k5z6fi1TOBBQk9w0LU2ce6gkQ6BuFIeDZxG8apacUksl0PUkw1Konas60VRqaRCILl23eYkc17tVrytEkrCUnSXurHNXY0TXQY11zhOdEXvdI0ojjNh66yY2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bi/Zi5Uf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R3bO6oUC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 11:28:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711366100;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ms6mUkcVHEEYMpiuLn5QgzJbpme7gxA9L9HoTZbG23s=;
	b=Bi/Zi5Ufz/CrKNHba2wpFvfBj+a3sVKBQemLf13XER/FN9Hb+gtnZNg+/KbHE2fISnk0Mo
	7Qek+oMZkLu3yEnTlSUndYSTTHXD5RaaQXpd2QMmHyspTzSnI+kovUBgxN4t0VuNvmdG7S
	m/+fboPYLpHXStdSipG3fref/Db8zlddFW1luJaYy1Zf2tfSj3e8KsKttNBD4rdDaTxaQt
	fdMJWlCsirRn94aSdTe6K1/B3IWK0YEhvG0sErw50bxZBnTbfshdOQ95ir4ROeRLDAVO0L
	HFeY9FaFVO2hKWJiYsh7qHx8UdxL8VLQQUGhj2Q2SCrfKYDciE2Zg0ZKimN0qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711366100;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ms6mUkcVHEEYMpiuLn5QgzJbpme7gxA9L9HoTZbG23s=;
	b=R3bO6oUCSg4a/IAl2annepkrrNdqMX3Jpz8Rt9GIrC8wAfxQNc0MSReQv/t3xvK2duSP+E
	xZsBVy5qLUoHBzAg==
From: "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Check if a task has a fitting CPU when
 updating misfit
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240324004552.999936-3-qyousef@layalina.io>
References: <20240324004552.999936-3-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171136609964.10875.15664415647004292164.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     22d5607400c62c72da9b60e3324744be83e147a4
Gitweb:        https://git.kernel.org/tip/22d5607400c62c72da9b60e3324744be83e147a4
Author:        Qais Yousef <qyousef@layalina.io>
AuthorDate:    Sun, 24 Mar 2024 00:45:50 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Mar 2024 12:09:54 +01:00

sched/fair: Check if a task has a fitting CPU when updating misfit

If a misfit task is affined to a subset of the possible CPUs, we need to
verify that one of these CPUs can fit it. Otherwise the load balancer
code will continuously trigger needlessly leading the balance_interval
to increase in return and eventually end up with a situation where real
imbalances take a long time to address because of this impossible
imbalance situation.

This can happen in Android world where it's common for background tasks
to be restricted to little cores.

Similarly if we can't fit the biggest core, triggering misfit is
pointless as it is the best we can ever get on this system.

To be able to detect that; we use asym_cap_list to iterate through
capacities in the system to see if the task is able to run at a higher
capacity level based on its p->cpus_ptr. We do that when the affinity
change, a fair task is forked, or when a task switched to fair policy.
We store the max_allowed_capacity in task_struct to allow for cheap
comparison in the fast path.

Improve check_misfit_status() function by removing redundant checks.
misfit_task_load will be 0 if the task can't move to a bigger CPU. And
nohz_balancer_kick() already checks for cpu_check_capacity() before
calling check_misfit_status().

Test:
=====

Add

	trace_printk("balance_interval = %lu\n", interval)

in get_sd_balance_interval().

run
	if [ "$MASK" != "0" ]; then
		adb shell "taskset -a $MASK cat /dev/zero > /dev/null"
	fi
	sleep 10
	// parse ftrace buffer counting the occurrence of each valaue

Where MASK is either:

	* 0: no busy task running
	* 1: busy task is pinned to 1 cpu; handled today to not cause
	  misfit
	* f: busy task pinned to little cores, simulates busy background
	  task, demonstrates the problem to be fixed

Results:
========

Note how occurrence of balance_interval = 128 overshoots for MASK = f.

BEFORE
------

	MASK=0

		   1 balance_interval = 175
		 120 balance_interval = 128
		 846 balance_interval = 64
		  55 balance_interval = 63
		 215 balance_interval = 32
		   2 balance_interval = 31
		   2 balance_interval = 16
		   4 balance_interval = 8
		1870 balance_interval = 4
		  65 balance_interval = 2

	MASK=1

		  27 balance_interval = 175
		  37 balance_interval = 127
		 840 balance_interval = 64
		 167 balance_interval = 63
		 449 balance_interval = 32
		  84 balance_interval = 31
		 304 balance_interval = 16
		1156 balance_interval = 8
		2781 balance_interval = 4
		 428 balance_interval = 2

	MASK=f

		   1 balance_interval = 175
		1328 balance_interval = 128
		  44 balance_interval = 64
		 101 balance_interval = 63
		  25 balance_interval = 32
		   5 balance_interval = 31
		  23 balance_interval = 16
		  23 balance_interval = 8
		4306 balance_interval = 4
		 177 balance_interval = 2

AFTER
-----

Note how the high values almost disappear for all MASK values. The
system has background tasks that could trigger the problem without
simulate it even with MASK=0.

	MASK=0

		 103 balance_interval = 63
		  19 balance_interval = 31
		 194 balance_interval = 8
		4827 balance_interval = 4
		 179 balance_interval = 2

	MASK=1

		 131 balance_interval = 63
		   1 balance_interval = 31
		  87 balance_interval = 8
		3600 balance_interval = 4
		   7 balance_interval = 2

	MASK=f

		   8 balance_interval = 127
		 182 balance_interval = 63
		   3 balance_interval = 31
		   9 balance_interval = 16
		 415 balance_interval = 8
		3415 balance_interval = 4
		  21 balance_interval = 2

Signed-off-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240324004552.999936-3-qyousef@layalina.io
---
 include/linux/sched.h |  1 +-
 init/init_task.c      |  1 +-
 kernel/sched/fair.c   | 66 +++++++++++++++++++++++++++++++-----------
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3ed40e9..c75fd46 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -835,6 +835,7 @@ struct task_struct {
 #endif
 
 	unsigned int			policy;
+	unsigned long			max_allowed_capacity;
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			*user_cpus_ptr;
diff --git a/init/init_task.c b/init/init_task.c
index 4daee6d..2558b71 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -77,6 +77,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
 	.cpus_mask	= CPU_MASK_ALL,
+	.max_allowed_capacity	= SCHED_CAPACITY_SCALE,
 	.nr_cpus_allowed= NR_CPUS,
 	.mm		= NULL,
 	.active_mm	= &init_mm,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e8270e2..c47c4f2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5098,15 +5098,19 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 {
+	int cpu = cpu_of(rq);
+
 	if (!sched_asym_cpucap_active())
 		return;
 
-	if (!p || p->nr_cpus_allowed == 1) {
-		rq->misfit_task_load = 0;
-		return;
-	}
+	/*
+	 * Affinity allows us to go somewhere higher?  Or are we on biggest
+	 * available CPU already? Or do we fit into this CPU ?
+	 */
+	if (!p || (p->nr_cpus_allowed == 1) ||
+	    (arch_scale_cpu_capacity(cpu) == p->max_allowed_capacity) ||
+	    task_fits_cpu(p, cpu)) {
 
-	if (task_fits_cpu(p, cpu_of(rq))) {
 		rq->misfit_task_load = 0;
 		return;
 	}
@@ -8253,6 +8257,36 @@ static void task_dead_fair(struct task_struct *p)
 	remove_entity_load_avg(&p->se);
 }
 
+/*
+ * Set the max capacity the task is allowed to run at for misfit detection.
+ */
+static void set_task_max_allowed_capacity(struct task_struct *p)
+{
+	struct asym_cap_data *entry;
+
+	if (!sched_asym_cpucap_active())
+		return;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &asym_cap_list, link) {
+		cpumask_t *cpumask;
+
+		cpumask = cpu_capacity_span(entry);
+		if (!cpumask_intersects(p->cpus_ptr, cpumask))
+			continue;
+
+		p->max_allowed_capacity = entry->capacity;
+		break;
+	}
+	rcu_read_unlock();
+}
+
+static void set_cpus_allowed_fair(struct task_struct *p, struct affinity_context *ctx)
+{
+	set_cpus_allowed_common(p, ctx);
+	set_task_max_allowed_capacity(p);
+}
+
 static int
 balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -8261,6 +8295,8 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	return sched_balance_newidle(rq, rf) != 0;
 }
+#else
+static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
 #endif /* CONFIG_SMP */
 
 static void set_next_buddy(struct sched_entity *se)
@@ -9610,16 +9646,10 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
 				(arch_scale_cpu_capacity(cpu_of(rq)) * 100));
 }
 
-/*
- * Check whether a rq has a misfit task and if it looks like we can actually
- * help that task: we can migrate the task to a CPU of higher capacity, or
- * the task's current CPU is heavily pressured.
- */
-static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
+/* Check if the rq has a misfit task */
+static inline bool check_misfit_status(struct rq *rq)
 {
-	return rq->misfit_task_load &&
-		(arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
-		 check_cpu_capacity(rq, sd));
+	return rq->misfit_task_load;
 }
 
 /*
@@ -11923,7 +11953,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * When ASYM_CPUCAPACITY; see if there's a higher capacity CPU
 		 * to run the misfit task on.
 		 */
-		if (check_misfit_status(rq, sd)) {
+		if (check_misfit_status(rq)) {
 			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
@@ -12648,6 +12678,8 @@ static void task_fork_fair(struct task_struct *p)
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
 
+	set_task_max_allowed_capacity(p);
+
 	cfs_rq = task_cfs_rq(current);
 	curr = cfs_rq->curr;
 	if (curr)
@@ -12771,6 +12803,8 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 {
 	attach_task_cfs_rq(p);
 
+	set_task_max_allowed_capacity(p);
+
 	if (task_on_rq_queued(p)) {
 		/*
 		 * We were most likely switched from sched_rt, so
@@ -13142,7 +13176,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.rq_offline		= rq_offline_fair,
 
 	.task_dead		= task_dead_fair,
-	.set_cpus_allowed	= set_cpus_allowed_common,
+	.set_cpus_allowed	= set_cpus_allowed_fair,
 #endif
 
 	.task_tick		= task_tick_fair,


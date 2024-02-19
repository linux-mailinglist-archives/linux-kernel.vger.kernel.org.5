Return-Path: <linux-kernel+bounces-71815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A3F85AB16
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78461C21EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3634879C;
	Mon, 19 Feb 2024 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k0y47IdG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n4YrBKlO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB727714;
	Mon, 19 Feb 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367848; cv=none; b=oUQMQNJ6+1PZ4l7ZLOuSc27vy+7GenPlVEXRROOI+bNyOiI7FgytM9jJwZRHHmGYBdk5CxbhUjJfs/fD3ntm42eC8tXZgEwNKtFiJpPIalLXGzgZGlVknT312JCQNPemDNIK7YFkUkio7IU9an3DALUC9SbxX2rT2P6XrAwTYIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367848; c=relaxed/simple;
	bh=sAq/KLRA1mXloA2tCUElkF+Vfo4xIMDhcufjNgVaMpE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gySQ29+cyN/g2Obkx3wWKbD0/HT6T8aOebJcWea6YDKe3hGt6lvdrx4yCVrFXiJzJ09+GWV3TtiwL5SojJzaaewbWRavZ6SqFvGCeBeQ56CgvFGW1Nxst4ASsmIm2j0/uIZtt5RGY206wmgjn9d7plDGaPo8l48Rt9xDAByuuho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k0y47IdG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n4YrBKlO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367844;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PNOmpyCMOjZFEGxaW0I5qTjV7BPqjMe02KrAKwETo4=;
	b=k0y47IdGB3/4uj+1kxoNFt7hNDSEGFZUGtz4daNfTAsxWdS7IcRbj4h1fBiIlUAIqbXh9O
	tGQ9reXjwc3wbhWm7q2I0vqflf62jdE+7iuqbxz2FHf89/iJTO/77joDBRQLjGjidrFQCq
	nV655NJpoeZzoNAwExXbOkABZZRu9mE55+v2qEtSwtSD20qYuQvatbQTLQqXykerY0LgNI
	QisjquU/zNrPBWQgU97P1GP7JFWogLeP5RSSBwZbA0OwfrfFJt9fP/sAsJoUvrVbGQHqHD
	5pnTqrlS8jrbrJsrVg/B8RNWKF4V4dBEGtTZ94Vm6m5Uuwd42eQ/Dk/31KSQYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367844;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PNOmpyCMOjZFEGxaW0I5qTjV7BPqjMe02KrAKwETo4=;
	b=n4YrBKlOe36hbDPWMLmRZomsHXE1QnoUfTl5UEmFJgpmKGnrqfkwUQb+faWowmlWtFSY9P
	RhbuJxMGRoxBXMAw==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Allow overflow/limbo handlers to be
 scheduled on any-but CPU
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>, Babu Moger <babu.moger@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-22-james.morse@arm.com>
References: <20240213184438.16675-22-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836784407.398.12089613810661383414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     978fcca954cb52249babbc14e53de53c88dd6433
Gitweb:        https://git.kernel.org/tip/978fcca954cb52249babbc14e53de53c88dd6433
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:35 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:33 +01:00

x86/resctrl: Allow overflow/limbo handlers to be scheduled on any-but CPU

When a CPU is taken offline resctrl may need to move the overflow or limbo
handlers to run on a different CPU.

Once the offline callbacks have been split, cqm_setup_limbo_handler() will be
called while the CPU that is going offline is still present in the CPU mask.

Pass the CPU to exclude to cqm_setup_limbo_handler() and
mbm_setup_overflow_handler(). These functions can use a variant of
cpumask_any_but() when selecting the CPU. -1 is used to indicate no CPUs need
excluding.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-22-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/resctrl/core.c        |  8 +++-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 33 +++++++++++++----
 arch/x86/kernel/cpu/resctrl/monitor.c     | 42 +++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  6 ++-
 include/linux/resctrl.h                   |  2 +-
 6 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4627d44..55322ba 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -584,12 +584,16 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
 		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
 			cancel_delayed_work(&d->mbm_over);
-			mbm_setup_overflow_handler(d, 0);
+			/*
+			 * temporary: exclude_cpu=-1 as this CPU has already
+			 * been removed by cpumask_clear_cpu()d
+			 */
+			mbm_setup_overflow_handler(d, 0, RESCTRL_PICK_ANY_CPU);
 		}
 		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
 		    has_busy_rmid(d)) {
 			cancel_delayed_work(&d->cqm_limbo);
-			cqm_setup_limbo_handler(d, 0);
+			cqm_setup_limbo_handler(d, 0, RESCTRL_PICK_ANY_CPU);
 		}
 	}
 }
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 52fa0e1..20b02d6 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -552,7 +552,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		return;
 	}
 
-	cpu = cpumask_any_housekeeping(&d->cpu_mask);
+	cpu = cpumask_any_housekeeping(&d->cpu_mask, RESCTRL_PICK_ANY_CPU);
 
 	/*
 	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 3ee855c..c99f26e 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -60,19 +60,36 @@
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
  * @mask:	The mask to pick a CPU from.
+ * @exclude_cpu:The CPU to avoid picking.
  *
- * Returns a CPU in @mask. If there are housekeeping CPUs that don't use
- * nohz_full, these are preferred.
+ * Returns a CPU from @mask, but not @exclude_cpu. If there are housekeeping
+ * CPUs that don't use nohz_full, these are preferred. Pass
+ * RESCTRL_PICK_ANY_CPU to avoid excluding any CPUs.
+ *
+ * When a CPU is excluded, returns >= nr_cpu_ids if no CPUs are available.
  */
-static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
+static inline unsigned int
+cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 {
 	unsigned int cpu, hk_cpu;
 
-	cpu = cpumask_any(mask);
-	if (!tick_nohz_full_cpu(cpu))
+	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
+		cpu = cpumask_any(mask);
+	else
+		cpu = cpumask_any_but(mask, exclude_cpu);
+
+	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
 		return cpu;
 
+	/* If the CPU picked isn't marked nohz_full nothing more needs doing. */
+	if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
+		return cpu;
+
+	/* Try to find a CPU that isn't nohz_full to use in preference */
 	hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
+	if (hk_cpu == exclude_cpu)
+		hk_cpu = cpumask_nth_andnot(1, mask, tick_nohz_full_mask);
+
 	if (hk_cpu < nr_cpu_ids)
 		cpu = hk_cpu;
 
@@ -573,11 +590,13 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first);
 void mbm_setup_overflow_handler(struct rdt_domain *dom,
-				unsigned long delay_ms);
+				unsigned long delay_ms,
+				int exclude_cpu);
 void mbm_handle_overflow(struct work_struct *work);
 void __init intel_rdt_mbm_apply_quirk(void);
 bool is_mba_sc(struct rdt_resource *r);
-void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
+void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
+			     int exclude_cpu);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 92d7ba6..67edd4c 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -481,7 +481,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 		 * setup up the limbo worker.
 		 */
 		if (!has_busy_rmid(d))
-			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL);
+			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL,
+						RESCTRL_PICK_ANY_CPU);
 		set_bit(idx, d->rmid_busy_llc);
 		entry->busy++;
 	}
@@ -784,7 +785,8 @@ void cqm_handle_limbo(struct work_struct *work)
 	__check_limbo(d, false);
 
 	if (has_busy_rmid(d)) {
-		d->cqm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask);
+		d->cqm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask,
+							   RESCTRL_PICK_ANY_CPU);
 		schedule_delayed_work_on(d->cqm_work_cpu, &d->cqm_limbo,
 					 delay);
 	}
@@ -792,15 +794,25 @@ void cqm_handle_limbo(struct work_struct *work)
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
+/**
+ * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
+ *                             domain.
+ * @dom:           The domain the limbo handler should run for.
+ * @delay_ms:      How far in the future the handler should run.
+ * @exclude_cpu:   Which CPU the handler should not run on,
+ *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
+ */
+void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
+			     int exclude_cpu)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
 
-	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
+	cpu = cpumask_any_housekeeping(&dom->cpu_mask, exclude_cpu);
 	dom->cqm_work_cpu = cpu;
 
-	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
+	if (cpu < nr_cpu_ids)
+		schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
 }
 
 void mbm_handle_overflow(struct work_struct *work)
@@ -838,14 +850,24 @@ void mbm_handle_overflow(struct work_struct *work)
 	 * Re-check for housekeeping CPUs. This allows the overflow handler to
 	 * move off a nohz_full CPU quickly.
 	 */
-	d->mbm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask);
+	d->mbm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask,
+						   RESCTRL_PICK_ANY_CPU);
 	schedule_delayed_work_on(d->mbm_work_cpu, &d->mbm_over, delay);
 
 out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
+/**
+ * mbm_setup_overflow_handler() - Schedule the overflow handler to run for this
+ *                                domain.
+ * @dom:           The domain the overflow handler should run for.
+ * @delay_ms:      How far in the future the handler should run.
+ * @exclude_cpu:   Which CPU the handler should not run on,
+ *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
+ */
+void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms,
+				int exclude_cpu)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
@@ -856,9 +878,11 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 	 */
 	if (!resctrl_mounted || !resctrl_arch_mon_capable())
 		return;
-	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
+	cpu = cpumask_any_housekeeping(&dom->cpu_mask, exclude_cpu);
 	dom->mbm_work_cpu = cpu;
-	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
+
+	if (cpu < nr_cpu_ids)
+		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
 }
 
 static int dom_data_init(struct rdt_resource *r)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 38d3b19..f5688c7 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2678,7 +2678,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 		list_for_each_entry(dom, &r->domains, list)
-			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
+			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
+						   RESCTRL_PICK_ANY_CPU);
 	}
 
 	goto out;
@@ -3989,7 +3990,8 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 
 	if (is_mbm_enabled()) {
 		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
-		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
+		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL,
+					   RESCTRL_PICK_ANY_CPU);
 	}
 
 	if (is_llc_occupancy_enabled())
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 4c4bad3..ccbbbe5 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -10,6 +10,8 @@
 #define RESCTRL_RESERVED_CLOSID		0
 #define RESCTRL_RESERVED_RMID		0
 
+#define RESCTRL_PICK_ANY_CPU		-1
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 int proc_resctrl_show(struct seq_file *m,


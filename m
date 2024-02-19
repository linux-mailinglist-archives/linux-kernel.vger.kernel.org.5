Return-Path: <linux-kernel+bounces-71830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB9A85AB35
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062FC1F20B53
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FA654659;
	Mon, 19 Feb 2024 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H3WSsD+/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YXCvjdor"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4050A4D58F;
	Mon, 19 Feb 2024 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367862; cv=none; b=F7jVcDGyFyZRYMNW4HpGEAPwEomMMGX5np+Y/x85uYy+pqlvIbWTHbNYCacED4friO2HP/WIEFlR1r3BA/fc8fZ81kRKSyMTTUYHYsStgEQFYjajL+0nzQYR9d6cXGQ1h4IXCV8l1N2Ly9yjuUhcWfwAfSsZ1hkgcy8UPj13TAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367862; c=relaxed/simple;
	bh=6Zyvb4xVGA256RLZJ/jhguQX5ZM88TotJBAsPjzNU/0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YNAtkEX1DouZDw4UWR0Xl+Wn/39Fz0i0+wHEpDLSiTftnfMVsR7RS3HUIolG9phSqZyq2nbdX1gspxwmoaQaEZe3m0o2UoDQLgNkHtqFXp1dKarTxTqWLwr7AjysSdCHAgUZkdy6NRG+wL1m/3iv3sjFV0CtoqBC/fvjJVJNnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H3WSsD+/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YXCvjdor; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367858;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDlfoRFYyo79fgGB1CT7+D4Mpud9BfOKLs8KCYKCKo8=;
	b=H3WSsD+/tOe4mK5/XmT/5ugGaqIf1eAbZWOOTZ/EikVLiUiEx2zPPX3KPzWIyVD7H2bcKV
	w90XvI4JEh4BO32gvX4p2b0l0pGEYa6bfqu/aDD88RlVDDzAJlJwffh3AvD6VXvAGnKVeO
	IPUngazsNeUZL7KoC7GvHQ5HodXK5Sm2FJN5wqdiuB2kHUcrL6KbCGbgSFGUZuyiUUdSw0
	97Xl8G6VIXyBafpFQPanw8KYskmojfOHTrd1OCUYEaOl+IacCYUN0pNsgfsPRIudkYG5R4
	CTdjbTWpcFT7ISXyJqVv45cNFC1qLgPK5cKCugINzQKiV6/qu1yBDz8HThzYgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367858;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDlfoRFYyo79fgGB1CT7+D4Mpud9BfOKLs8KCYKCKo8=;
	b=YXCvjdorEJ8IdbXLEbbZHKUdUAEfRDXR/9dQ/UXGUhfvjToRadW3dR2TYkdcIvaSVtClp1
	Lrtey2h6S3lIg9BA==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Access per-rmid structures by index
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>, Babu Moger <babu.moger@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-7-james.morse@arm.com>
References: <20240213184438.16675-7-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836785754.398.1236935479743864438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     6791e0ea30711b937d5cb6e2b17f59a2a2af5386
Gitweb:        https://git.kernel.org/tip/6791e0ea30711b937d5cb6e2b17f59a2a2af5386
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:20 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:31 +01:00

x86/resctrl: Access per-rmid structures by index

x86 systems identify traffic using the CLOSID and RMID. The CLOSID is
used to lookup the control policy, the RMID is used for monitoring. For
x86 these are independent numbers.
Arm's MPAM has equivalent features PARTID and PMG, where the PARTID is
used to lookup the control policy. The PMG in contrast is a small number
of bits that are used to subdivide PARTID when monitoring. The
cache-occupancy monitors require the PARTID to be specified when
monitoring.

This means MPAM's PMG field is not unique. There are multiple PMG-0, one
per allocated CLOSID/PARTID. If PMG is treated as equivalent to RMID, it
cannot be allocated as an independent number. Bitmaps like rmid_busy_llc
need to be sized by the number of unique entries for this resource.

Treat the combined CLOSID and RMID as an index, and provide architecture
helpers to pack and unpack an index. This makes the MPAM values unique.
The domain's rmid_busy_llc and rmid_ptrs[] are then sized by index, as
are domain mbm_local[] and mbm_total[].

x86 can ignore the CLOSID field when packing and unpacking an index, and
report as many indexes as RMID.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-7-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/resctrl.h         | 17 ++++-
 arch/x86/kernel/cpu/resctrl/core.c     | 13 +--
 arch/x86/kernel/cpu/resctrl/internal.h |  4 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 98 ++++++++++++++++---------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 13 +--
 5 files changed, 100 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index cc6e1bc..db4c84d 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -101,6 +101,23 @@ static inline void resctrl_sched_in(struct task_struct *tsk)
 		__resctrl_sched_in(tsk);
 }
 
+static inline u32 resctrl_arch_system_num_rmid_idx(void)
+{
+	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
+	return boot_cpu_data.x86_cache_max_rmid + 1;
+}
+
+static inline void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
+{
+	*rmid = idx;
+	*closid = X86_RESCTRL_EMPTY_CLOSID;
+}
+
+static inline u32 resctrl_arch_rmid_idx_encode(u32 ignored, u32 rmid)
+{
+	return rmid;
+}
+
 void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
 #else
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 9641c42..d1dc80a 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -587,7 +587,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 			mbm_setup_overflow_handler(d, 0);
 		}
 		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
-		    has_busy_rmid(r, d)) {
+		    has_busy_rmid(d)) {
 			cancel_delayed_work(&d->cqm_limbo);
 			cqm_setup_limbo_handler(d, 0);
 		}
@@ -598,11 +598,12 @@ static void clear_closid_rmid(int cpu)
 {
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
 
-	state->default_closid = 0;
-	state->default_rmid = 0;
-	state->cur_closid = 0;
-	state->cur_rmid = 0;
-	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
+	state->default_closid = RESCTRL_RESERVED_CLOSID;
+	state->default_rmid = RESCTRL_RESERVED_RMID;
+	state->cur_closid = RESCTRL_RESERVED_CLOSID;
+	state->cur_rmid = RESCTRL_RESERVED_RMID;
+	wrmsr(MSR_IA32_PQR_ASSOC, RESCTRL_RESERVED_RMID,
+	      RESCTRL_RESERVED_CLOSID);
 }
 
 static int resctrl_online_cpu(unsigned int cpu)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ae0e333..cbba782 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -8,6 +8,8 @@
 #include <linux/fs_context.h>
 #include <linux/jump_label.h>
 
+#include <asm/resctrl.h>
+
 #define L3_QOS_CDP_ENABLE		0x01ULL
 
 #define L2_QOS_CDP_ENABLE		0x01ULL
@@ -558,7 +560,7 @@ void __init intel_rdt_mbm_apply_quirk(void);
 bool is_mba_sc(struct rdt_resource *r);
 void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
-bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
+bool has_busy_rmid(struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init thread_throttle_mode_init(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 3dad413..bc5ceef 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -149,12 +149,29 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
 	return val;
 }
 
-static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
+/*
+ * x86 and arm64 differ in their handling of monitoring.
+ * x86's RMID are independent numbers, there is only one source of traffic
+ * with an RMID value of '1'.
+ * arm64's PMG extends the PARTID/CLOSID space, there are multiple sources of
+ * traffic with a PMG value of '1', one for each CLOSID, meaning the RMID
+ * value is no longer unique.
+ * To account for this, resctrl uses an index. On x86 this is just the RMID,
+ * on arm64 it encodes the CLOSID and RMID. This gives a unique number.
+ *
+ * The domain's rmid_busy_llc and rmid_ptrs[] are sized by index. The arch code
+ * must accept an attempt to read every index.
+ */
+static inline struct rmid_entry *__rmid_entry(u32 idx)
 {
 	struct rmid_entry *entry;
+	u32 closid, rmid;
+
+	entry = &rmid_ptrs[idx];
+	resctrl_arch_rmid_idx_decode(idx, &closid, &rmid);
 
-	entry = &rmid_ptrs[rmid];
-	WARN_ON(entry->rmid != rmid);
+	WARN_ON_ONCE(entry->closid != closid);
+	WARN_ON_ONCE(entry->rmid != rmid);
 
 	return entry;
 }
@@ -284,8 +301,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 void __check_limbo(struct rdt_domain *d, bool force_free)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry;
-	u32 crmid = 1, nrmid;
+	u32 idx, cur_idx = 1;
 	bool rmid_dirty;
 	u64 val = 0;
 
@@ -296,12 +314,11 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 	 * RMID and move it to the free list when the counter reaches 0.
 	 */
 	for (;;) {
-		nrmid = find_next_bit(d->rmid_busy_llc, r->num_rmid, crmid);
-		if (nrmid >= r->num_rmid)
+		idx = find_next_bit(d->rmid_busy_llc, idx_limit, cur_idx);
+		if (idx >= idx_limit)
 			break;
 
-		entry = __rmid_entry(X86_RESCTRL_EMPTY_CLOSID, nrmid);// temporary
-
+		entry = __rmid_entry(idx);
 		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
 					   QOS_L3_OCCUP_EVENT_ID, &val)) {
 			rmid_dirty = true;
@@ -310,19 +327,21 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 		}
 
 		if (force_free || !rmid_dirty) {
-			clear_bit(entry->rmid, d->rmid_busy_llc);
+			clear_bit(idx, d->rmid_busy_llc);
 			if (!--entry->busy) {
 				rmid_limbo_count--;
 				list_add_tail(&entry->list, &rmid_free_lru);
 			}
 		}
-		crmid = nrmid + 1;
+		cur_idx = idx + 1;
 	}
 }
 
-bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
+bool has_busy_rmid(struct rdt_domain *d)
 {
-	return find_first_bit(d->rmid_busy_llc, r->num_rmid) != r->num_rmid;
+	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
+
+	return find_first_bit(d->rmid_busy_llc, idx_limit) != idx_limit;
 }
 
 /*
@@ -352,6 +371,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	struct rdt_domain *d;
 	int cpu, err;
 	u64 val = 0;
+	u32 idx;
+
+	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
 
 	entry->busy = 0;
 	cpu = get_cpu();
@@ -369,9 +391,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 		 * For the first limbo RMID in the domain,
 		 * setup up the limbo worker.
 		 */
-		if (!has_busy_rmid(r, d))
+		if (!has_busy_rmid(d))
 			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL);
-		set_bit(entry->rmid, d->rmid_busy_llc);
+		set_bit(idx, d->rmid_busy_llc);
 		entry->busy++;
 	}
 	put_cpu();
@@ -384,14 +406,21 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 
 void free_rmid(u32 closid, u32 rmid)
 {
+	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
 	struct rmid_entry *entry;
 
-	if (!rmid)
-		return;
-
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	entry = __rmid_entry(closid, rmid);
+	/*
+	 * Do not allow the default rmid to be free'd. Comparing by index
+	 * allows architectures that ignore the closid parameter to avoid an
+	 * unnecessary check.
+	 */
+	if (idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
+						RESCTRL_RESERVED_RMID))
+		return;
+
+	entry = __rmid_entry(idx);
 
 	if (is_llc_occupancy_enabled())
 		add_rmid_to_limbo(entry);
@@ -402,11 +431,13 @@ void free_rmid(u32 closid, u32 rmid)
 static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 closid,
 				       u32 rmid, enum resctrl_event_id evtid)
 {
+	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
+
 	switch (evtid) {
 	case QOS_L3_MBM_TOTAL_EVENT_ID:
-		return &d->mbm_total[rmid];
+		return &d->mbm_total[idx];
 	case QOS_L3_MBM_LOCAL_EVENT_ID:
-		return &d->mbm_local[rmid];
+		return &d->mbm_local[idx];
 	default:
 		return NULL;
 	}
@@ -449,7 +480,8 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
  */
 static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
-	struct mbm_state *m = &rr->d->mbm_local[rmid];
+	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
+	struct mbm_state *m = &rr->d->mbm_local[idx];
 	u64 cur_bw, bytes, cur_bytes;
 
 	cur_bytes = rr->val;
@@ -538,9 +570,9 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	struct mbm_state *pmbm_data, *cmbm_data;
 	struct rdt_resource *r_mba;
 	struct rdt_domain *dom_mba;
+	u32 cur_bw, user_bw, idx;
 	struct list_head *head;
 	struct rdtgroup *entry;
-	u32 cur_bw, user_bw;
 
 	if (!is_mbm_local_enabled())
 		return;
@@ -549,7 +581,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
-	pmbm_data = &dom_mbm->mbm_local[rmid];
+	idx = resctrl_arch_rmid_idx_encode(closid, rmid);
+	pmbm_data = &dom_mbm->mbm_local[idx];
 
 	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
 	if (!dom_mba) {
@@ -638,17 +671,15 @@ void cqm_handle_limbo(struct work_struct *work)
 {
 	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
 	int cpu = smp_processor_id();
-	struct rdt_resource *r;
 	struct rdt_domain *d;
 
 	mutex_lock(&rdtgroup_mutex);
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	d = container_of(work, struct rdt_domain, cqm_limbo.work);
 
 	__check_limbo(d, false);
 
-	if (has_busy_rmid(r, d))
+	if (has_busy_rmid(d))
 		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
 
 	mutex_unlock(&rdtgroup_mutex);
@@ -713,19 +744,20 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 
 static int dom_data_init(struct rdt_resource *r)
 {
+	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry = NULL;
-	int i, nr_rmids;
+	u32 idx;
+	int i;
 
-	nr_rmids = r->num_rmid;
-	rmid_ptrs = kcalloc(nr_rmids, sizeof(struct rmid_entry), GFP_KERNEL);
+	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
 	if (!rmid_ptrs)
 		return -ENOMEM;
 
-	for (i = 0; i < nr_rmids; i++) {
+	for (i = 0; i < idx_limit; i++) {
 		entry = &rmid_ptrs[i];
 		INIT_LIST_HEAD(&entry->list);
 
-		entry->rmid = i;
+		resctrl_arch_rmid_idx_decode(i, &entry->closid, &entry->rmid);
 		list_add_tail(&entry->list, &rmid_free_lru);
 	}
 
@@ -734,7 +766,9 @@ static int dom_data_init(struct rdt_resource *r)
 	 * are always allocated. These are used for the rdtgroup_default
 	 * control group, which will be setup later in rdtgroup_init().
 	 */
-	entry = __rmid_entry(RESCTRL_RESERVED_CLOSID, RESCTRL_RESERVED_RMID);
+	idx = resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
+					   RESCTRL_RESERVED_RMID);
+	entry = __rmid_entry(idx);
 	list_del(&entry->list);
 
 	return 0;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ad7da72..a7dbc0e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3853,8 +3853,8 @@ static void __init rdtgroup_setup_default(void)
 {
 	mutex_lock(&rdtgroup_mutex);
 
-	rdtgroup_default.closid = 0;
-	rdtgroup_default.mon.rmid = 0;
+	rdtgroup_default.closid = RESCTRL_RESERVED_CLOSID;
+	rdtgroup_default.mon.rmid = RESCTRL_RESERVED_RMID;
 	rdtgroup_default.type = RDTCTRL_GROUP;
 	INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);
 
@@ -3889,7 +3889,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 
 	if (is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);
-	if (is_llc_occupancy_enabled() && has_busy_rmid(r, d)) {
+	if (is_llc_occupancy_enabled() && has_busy_rmid(d)) {
 		/*
 		 * When a package is going down, forcefully
 		 * decrement rmid->ebusy. There is no way to know
@@ -3907,16 +3907,17 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 
 static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 {
+	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	size_t tsize;
 
 	if (is_llc_occupancy_enabled()) {
-		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
+		d->rmid_busy_llc = bitmap_zalloc(idx_limit, GFP_KERNEL);
 		if (!d->rmid_busy_llc)
 			return -ENOMEM;
 	}
 	if (is_mbm_total_enabled()) {
 		tsize = sizeof(*d->mbm_total);
-		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
+		d->mbm_total = kcalloc(idx_limit, tsize, GFP_KERNEL);
 		if (!d->mbm_total) {
 			bitmap_free(d->rmid_busy_llc);
 			return -ENOMEM;
@@ -3924,7 +3925,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 	}
 	if (is_mbm_local_enabled()) {
 		tsize = sizeof(*d->mbm_local);
-		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
+		d->mbm_local = kcalloc(idx_limit, tsize, GFP_KERNEL);
 		if (!d->mbm_local) {
 			bitmap_free(d->rmid_busy_llc);
 			kfree(d->mbm_total);


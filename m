Return-Path: <linux-kernel+bounces-71824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AB085AB28
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B290283F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEDB50A88;
	Mon, 19 Feb 2024 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R00vFsGc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AgeeArYr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FD24F21E;
	Mon, 19 Feb 2024 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367856; cv=none; b=NBGv39O4ujy5SGfUZJ6h6pDWLGiJBm64Pnm+haDsTWwEOp0dv5fT+keNCNnCGndG/0V2KkHE7ZIaKhEhYM9DHNwSFBCvyRhpWzUCnWbWhpmVV6L3AqWe/kdb/ebmH3vQKeclT+pVdiXmhfWzPS4KXxCOeUMFqdQH09a6/I+0fRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367856; c=relaxed/simple;
	bh=3LhB2Cc32ycfwFgJCLASszVAtPO+bLG3GmucGwUAgKU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Tb9xL7wnrNe0N/5EtAucN2nXQt0htpeQ2Q/C1Oqwp8kHtAzM7UfGsNlHpsBd5JpdZgNnkSb6NmHpq/Yp1fktzReXCRcPRGgODXGq8LTCta8He/Ve0Lu4nAEY2fsfA3KnumejbsTZpxfyNVwf+frznAdZhPogqdOfXaCs1VBlZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R00vFsGc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AgeeArYr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367852;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/FSIoO734aKd8R09mkaakq4E7h8DwgoN3XWQpDso8M=;
	b=R00vFsGc1mZXPdtWkn0wSmZWZMnRAHqeyCjdjL7HmzEEFkiL0l1WN+awInIBRs+/525Yzm
	/evXt1H+0xn7bwmkfLEkx3GSE1M0FXNr6TLLpQPP7aEhIYi47Xzw6ZERJapxLZgheP2fJn
	fb1DX16WL1hJrffNLmhZqeMS1hicWPonnIUa7rquW8VQplUBwOhhCTbEDRvZFQsihalNhu
	ZsNnFNHmFVJ2uzQQndWXld5wUhFL88fKi7wq/CkBPyKOH6hFOhTuYADy8EZu/6LxYzO0Z3
	uQ84Z+k2NWdUYfHGA1qqtGhu5LYC1stJ36TWJ5FgpRRiVRvQX5FOWE41XsdGNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367852;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/FSIoO734aKd8R09mkaakq4E7h8DwgoN3XWQpDso8M=;
	b=AgeeArYrgld8ocLCHs0VZRMqJtcAUmEY1aAM++EQc/23h1TP1FcR/UkOLvGOuQWR2s82tq
	LyHN1OiaqaWjHlBQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add cpumask_any_housekeeping() for
 limbo/overflow
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-13-james.morse@arm.com>
References: <20240213184438.16675-13-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836785205.398.2136801348690724618.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     a4846aaf39455fe69fce3522b385319383666eef
Gitweb:        https://git.kernel.org/tip/a4846aaf39455fe69fce3522b385319383666eef
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:26 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:32 +01:00

x86/resctrl: Add cpumask_any_housekeeping() for limbo/overflow

The limbo and overflow code picks a CPU to use from the domain's list of online
CPUs. Work is then scheduled on these CPUs to maintain the limbo list and any
counters that may overflow.

cpumask_any() may pick a CPU that is marked nohz_full, which will either
penalise the work that CPU was dedicated to, or delay the processing of limbo
list or counters that may overflow. Perhaps indefinitely. Delaying the overflow
handling will skew the bandwidth values calculated by mba_sc, which expects to
be called once a second.

Add cpumask_any_housekeeping() as a replacement for cpumask_any() that prefers
housekeeping CPUs. This helper will still return a nohz_full CPU if that is the
only option. The CPU to use is re-evaluated each time the limbo/overflow work
runs. This ensures the work will move off a nohz_full CPU once a housekeeping
CPU is available.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-13-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 24 ++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 20 +++++++++++++-------
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index b7b9d92..81f5de9 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -7,6 +7,7 @@
 #include <linux/kernfs.h>
 #include <linux/fs_context.h>
 #include <linux/jump_label.h>
+#include <linux/tick.h>
 
 #include <asm/resctrl.h>
 
@@ -55,6 +56,29 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
+/**
+ * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
+ *			        aren't marked nohz_full
+ * @mask:	The mask to pick a CPU from.
+ *
+ * Returns a CPU in @mask. If there are housekeeping CPUs that don't use
+ * nohz_full, these are preferred.
+ */
+static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
+{
+	unsigned int cpu, hk_cpu;
+
+	cpu = cpumask_any(mask);
+	if (!tick_nohz_full_cpu(cpu))
+		return cpu;
+
+	hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
+	if (hk_cpu < nr_cpu_ids)
+		cpu = hk_cpu;
+
+	return cpu;
+}
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 101f1b1..38f85e5 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -761,7 +761,6 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
 void cqm_handle_limbo(struct work_struct *work)
 {
 	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
-	int cpu = smp_processor_id();
 	struct rdt_domain *d;
 
 	mutex_lock(&rdtgroup_mutex);
@@ -770,8 +769,11 @@ void cqm_handle_limbo(struct work_struct *work)
 
 	__check_limbo(d, false);
 
-	if (has_busy_rmid(d))
-		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
+	if (has_busy_rmid(d)) {
+		d->cqm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask);
+		schedule_delayed_work_on(d->cqm_work_cpu, &d->cqm_limbo,
+					 delay);
+	}
 
 	mutex_unlock(&rdtgroup_mutex);
 }
@@ -781,7 +783,7 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
 
-	cpu = cpumask_any(&dom->cpu_mask);
+	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
 	dom->cqm_work_cpu = cpu;
 
 	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
@@ -791,7 +793,6 @@ void mbm_handle_overflow(struct work_struct *work)
 {
 	unsigned long delay = msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
 	struct rdtgroup *prgrp, *crgrp;
-	int cpu = smp_processor_id();
 	struct list_head *head;
 	struct rdt_resource *r;
 	struct rdt_domain *d;
@@ -815,7 +816,12 @@ void mbm_handle_overflow(struct work_struct *work)
 			update_mba_bw(prgrp, d);
 	}
 
-	schedule_delayed_work_on(cpu, &d->mbm_over, delay);
+	/*
+	 * Re-check for housekeeping CPUs. This allows the overflow handler to
+	 * move off a nohz_full CPU quickly.
+	 */
+	d->mbm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask);
+	schedule_delayed_work_on(d->mbm_work_cpu, &d->mbm_over, delay);
 
 out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
@@ -828,7 +834,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 
 	if (!static_branch_likely(&rdt_mon_enable_key))
 		return;
-	cpu = cpumask_any(&dom->cpu_mask);
+	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
 	dom->mbm_work_cpu = cpu;
 	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
 }


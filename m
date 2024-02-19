Return-Path: <linux-kernel+bounces-71822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D5685AB23
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D427B282E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A2E50241;
	Mon, 19 Feb 2024 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yIgCnb6s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gNRuL1G9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8EB4C614;
	Mon, 19 Feb 2024 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367855; cv=none; b=UlBinjkUsPpHlcReqkICePtd41n6h52QBLo81w9jNAm9ZJT/LjHK/KK5YNIeYTbXftHBppKhSAyUusdkvvjMhFIK0A6UhFpiIoDnC+yvqSErdHa2PWginGMbncffJZKOxB4T1V0tpBsRexTgEPda6QWQNwDxldqFMbTYQb0VOUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367855; c=relaxed/simple;
	bh=dERyg6dO+4ycLfVjLTHvFboayL1QjHkPFoj6RM5IXes=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tc7iOy5VQo/ka4rmtABArPGApehbrlHWWXTLfpums1/T/RriY9wp4nJrCu5rWN01Y4B0lf+DxKH7C15+c74Rn4CVAcU3eXbw0C1g8aIxSb3o1GwOVg7bFjVLsYYc21cnRpo61bf0Nh5IcjE4jFbGKaSQkHm9OVXHJPxDWrGqTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yIgCnb6s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gNRuL1G9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tF0xJdReWFSeISxgPJZKE3xKhMYeUMpssby8KAf3+nQ=;
	b=yIgCnb6sL44BFO7qR2wwrBZsSGECLisGl78/eDxy2JMx8wj/Blcmiojy2ZBNsJpIb8I+G3
	3g/GxWjFeKxzONioiLXhuFe0CngEHKCTCCBCsRxkUF4ZPf3Cy2+vxLRF+vTPNtJHosgHwZ
	AbRvCOoK7pTSCcCcGswpSy1C3ROT78pntcA3a6zhI0rh1glVgUwSp6x4SIJXLjJi6yM3kB
	tlU2l39cjfxK9VAGtggd+mrooD5WtVWW9AEZdzYxdV4S3Siy4QFxgxf+xl7cRnYuXQd2gZ
	3aDwosuwNrL6I+Jwjgg7sqCGr81NJqpS9wSdUOlV2XDM9znMl4kIm4ALD02Nmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tF0xJdReWFSeISxgPJZKE3xKhMYeUMpssby8KAf3+nQ=;
	b=gNRuL1G9RCoSeVoBdhj/qlUEswmgmY81FPyWkcG+QOFZDC0q2GzgJEHUyqTwMP/yYEoiqB
	bAKnxaGyj4W89DAg==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Allow resctrl_arch_rmid_read() to sleep
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-15-james.morse@arm.com>
References: <20240213184438.16675-15-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836785031.398.9003793249218584345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     6fde1424f29b151b9dc8c660eecf4d1645facea5
Gitweb:        https://git.kernel.org/tip/6fde1424f29b151b9dc8c660eecf4d1645facea5
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:28 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:32 +01:00

x86/resctrl: Allow resctrl_arch_rmid_read() to sleep

MPAM's cache occupancy counters can take a little while to settle once the
monitor has been configured. The maximum settling time is described to the
driver via a firmware table. The value could be large enough that it makes
sense to sleep. To avoid exposing this to resctrl, it should be hidden behind
MPAM's resctrl_arch_rmid_read().

resctrl_arch_rmid_read() may be called via IPI meaning it is unable to sleep.
In this case, it should return an error if it needs to sleep. This will only
affect MPAM platforms where the cache occupancy counter isn't available
immediately, nohz_full is in use, and there are no housekeeping CPUs in the
necessary domain.

There are three callers of resctrl_arch_rmid_read(): __mon_event_count() and
__check_limbo() are both called from a non-migrateable context.
mon_event_read() invokes __mon_event_count() using smp_call_on_cpu(), which
adds work to the target CPUs workqueue.  rdtgroup_mutex() is held, meaning this
cannot race with the resctrl cpuhp callback. __check_limbo() is invoked via
schedule_delayed_work_on() also adds work to a per-cpu workqueue.

The remaining call is add_rmid_to_limbo() which is called in response to
a user-space syscall that frees an RMID. This opportunistically reads the LLC
occupancy counter on the current domain to see if the RMID is over the dirty
threshold. This has to disable preemption to avoid reading the wrong domain's
value. Disabling preemption here prevents resctrl_arch_rmid_read() from
sleeping.

add_rmid_to_limbo() walks each domain, but only reads the counter on one
domain. If the system has more than one domain, the RMID will always be added
to the limbo list. If the RMIDs usage was not over the threshold, it will be
removed from the list when __check_limbo() runs.  Make this the default
behaviour. Free RMIDs are always added to the limbo list for each domain.

The user visible effect of this is that a clean RMID is not available for
re-allocation immediately after 'rmdir()' completes. This behaviour was never
portable as it never happened on a machine with multiple domains.

Removing this path allows resctrl_arch_rmid_read() to sleep if its called with
interrupts unmasked. Document this is the expected behaviour, and add
a might_sleep() annotation to catch changes that won't work on arm64.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-15-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 25 +++++--------------------
 include/linux/resctrl.h               | 23 ++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index fd060ef..e8aeff6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -277,6 +277,8 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	u64 msr_val, chunks;
 	int ret;
 
+	resctrl_arch_rmid_read_context_check();
+
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
 		return -EINVAL;
 
@@ -455,8 +457,6 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	struct rdt_domain *d;
-	int cpu, err;
-	u64 val = 0;
 	u32 idx;
 
 	lockdep_assert_held(&rdtgroup_mutex);
@@ -464,17 +464,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
 
 	entry->busy = 0;
-	cpu = get_cpu();
 	list_for_each_entry(d, &r->domains, list) {
-		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
-			err = resctrl_arch_rmid_read(r, d, entry->closid,
-						     entry->rmid,
-						     QOS_L3_OCCUP_EVENT_ID,
-						     &val);
-			if (err || val <= resctrl_rmid_realloc_threshold)
-				continue;
-		}
-
 		/*
 		 * For the first limbo RMID in the domain,
 		 * setup up the limbo worker.
@@ -484,15 +474,10 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 		set_bit(idx, d->rmid_busy_llc);
 		entry->busy++;
 	}
-	put_cpu();
 
-	if (entry->busy) {
-		rmid_limbo_count++;
-		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
-			closid_num_dirty_rmid[entry->closid]++;
-	} else {
-		list_add_tail(&entry->list, &rmid_free_lru);
-	}
+	rmid_limbo_count++;
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
+		closid_num_dirty_rmid[entry->closid]++;
 }
 
 void free_rmid(u32 closid, u32 rmid)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index bd4ec22..8649fc8 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -236,7 +236,12 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
  * @eventid:		eventid to read, e.g. L3 occupancy.
  * @val:		result of the counter read in bytes.
  *
- * Call from process context on a CPU that belongs to domain @d.
+ * Some architectures need to sleep when first programming some of the counters.
+ * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
+ *  for a short period of time). Call from a non-migrateable process context on
+ * a CPU that belongs to domain @d. e.g. use smp_call_on_cpu() or
+ * schedule_work_on(). This function can be called with interrupts masked,
+ * e.g. using smp_call_function_any(), but may consistently return an error.
  *
  * Return:
  * 0 on success, or -EIO, -EINVAL etc on error.
@@ -245,6 +250,22 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
 			   u64 *val);
 
+/**
+ * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts
+ *
+ * When built with CONFIG_DEBUG_ATOMIC_SLEEP generate a warning when
+ * resctrl_arch_rmid_read() is called with preemption disabled.
+ *
+ * The contract with resctrl_arch_rmid_read() is that if interrupts
+ * are unmasked, it can sleep. This allows NOHZ_FULL systems to use an
+ * IPI, (and fail if the call needed to sleep), while most of the time
+ * the work is scheduled, allowing the call to sleep.
+ */
+static inline void resctrl_arch_rmid_read_context_check(void)
+{
+	if (!irqs_disabled())
+		might_sleep();
+}
 
 /**
  * resctrl_arch_reset_rmid() - Reset any private state associated with rmid


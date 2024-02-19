Return-Path: <linux-kernel+bounces-71825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B064585AB29
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279391F2319F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7784451C58;
	Mon, 19 Feb 2024 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XyMazSTt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CUN2XUuW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB24F614;
	Mon, 19 Feb 2024 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367857; cv=none; b=SJsQR+hJohCkyETjmupPqca3CS2hqqdEAqw1RjJKczdOWA12oYz2S5ho+69jgTvNlerBARZJvFWlMBtjn71oxMBozpEWJJNgbCJbhhynA+KjuEoaZxjji8TwNxs/D5CMjs55RZ0I61GeV3tAKwsJ6lxcF1/zDuBO0Bj+x+ONTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367857; c=relaxed/simple;
	bh=/Coh9B9e/+9sOhE/cBczBlL6rPUlggLHblAvJmk/3Zo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QfmDWe2jltrz5stE8I9NNhRDB6FRC8z2/HEX4jbZ9Ffhd5E9mC9m3l91vRdC0jKXktLTtC45V/GTpJiK7skRRD+qVls5qpD5BlgjpF4u4PlCdFkrhu64jKsZUnSMNnhGs14ZkJojzmXA9/0jhpwRzag0DHxLLOlb5//PpagnAI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XyMazSTt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CUN2XUuW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367853;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xq+cp78N7ktPvEdtNBvkVUcIcU1Az/LCnlKVNjOYBcI=;
	b=XyMazSTt6I7EW3RL3YQKz7z4DSM4D1aCWqXAVEU39K9Pa/0LNoFrozSwvAEbgn7XfTeK0y
	SM58G56qLHZWo26tOo1apBAMnMMa+oGNi+4gMOmJ8kctzv+39Vscl8HGFAnb8TPA8ad29Z
	w1yJubZjOyXyhA2WZaC9dua1rO8l9Qr/ESK1Gs0QUy93BjGSvRNMOBHYNASjHO/WfBQnzq
	K/iYTHB1+/FKzyydCbbd+cAmoyK4BIBL0vDAMPG52BAFApDdfiLN5pw4slKSmxPxhuA8r7
	qE3+7XEIfmH8Ucw3zk5zeSgPXFmiP7hUF1S7vbhL/U+j+s1NeUTzZaCknHSVew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367853;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xq+cp78N7ktPvEdtNBvkVUcIcU1Az/LCnlKVNjOYBcI=;
	b=CUN2XUuWyIgdt7xGPfAyjm/pj7rccxZD/zVKejeuShTc4aT9oncs/DhDnxI7ytFcQKIEEW
	VLqaAi3kpQv6YADw==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move CLOSID/RMID matching and setting
 to use helpers
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-12-james.morse@arm.com>
References: <20240213184438.16675-12-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836785295.398.6907526891385717623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     6eca639d8340b569ff78ffd753796e83ef7075ae
Gitweb:        https://git.kernel.org/tip/6eca639d8340b569ff78ffd753796e83ef7075ae
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:25 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:32 +01:00

x86/resctrl: Move CLOSID/RMID matching and setting to use helpers

When switching tasks, the CLOSID and RMID that the new task should use
are stored in struct task_struct. For x86 the CLOSID known by resctrl,
the value in task_struct, and the value written to the CPU register are
all the same thing.

MPAM's CPU interface has two different PARTIDs - one for data accesses
the other for instruction fetch. Storing resctrl's CLOSID value in
struct task_struct implies the arch code knows whether resctrl is using
CDP.

Move the matching and setting of the struct task_struct properties to
use helpers. This allows arm64 to store the hardware format of the
register, instead of having to convert it each time.

__rdtgroup_move_task()s use of READ_ONCE()/WRITE_ONCE() ensures torn
values aren't seen as another CPU may schedule the task being moved
while the value is being changed. MPAM has an additional corner-case
here as the PMG bits extend the PARTID space.

If the scheduler sees a new-CLOSID but old-RMID, the task will dirty an
RMID that the limbo code is not watching causing an inaccurate count.

x86's RMID are independent values, so the limbo code will still be
watching the old-RMID in this circumstance.

To avoid this, arm64 needs both the CLOSID/RMID WRITE_ONCE()d together.
Both values must be provided together.

Because MPAM's RMID values are not unique, the CLOSID must be provided
when matching the RMID.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-12-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/resctrl.h         | 18 +++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 62 +++++++++++++++----------
 2 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index db4c84d..1d274db 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -95,6 +95,24 @@ static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
 	return val * scale;
 }
 
+static inline void resctrl_arch_set_closid_rmid(struct task_struct *tsk,
+						u32 closid, u32 rmid)
+{
+	WRITE_ONCE(tsk->closid, closid);
+	WRITE_ONCE(tsk->rmid, rmid);
+}
+
+static inline bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid)
+{
+	return READ_ONCE(tsk->closid) == closid;
+}
+
+static inline bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 ignored,
+					   u32 rmid)
+{
+	return READ_ONCE(tsk->rmid) == rmid;
+}
+
 static inline void resctrl_sched_in(struct task_struct *tsk)
 {
 	if (static_branch_likely(&rdt_enable_key))
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 8fc4620..e42cbdf 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -102,7 +102,7 @@ void rdt_staged_configs_clear(void)
  *
  * Using a global CLOSID across all resources has some advantages and
  * some drawbacks:
- * + We can simply set "current->closid" to assign a task to a resource
+ * + We can simply set current's closid to assign a task to a resource
  *   group.
  * + Context switch code can avoid extra memory references deciding which
  *   CLOSID to load into the PQR_ASSOC MSR
@@ -574,14 +574,26 @@ static void update_task_closid_rmid(struct task_struct *t)
 		_update_task_closid_rmid(t);
 }
 
+static bool task_in_rdtgroup(struct task_struct *tsk, struct rdtgroup *rdtgrp)
+{
+	u32 closid, rmid = rdtgrp->mon.rmid;
+
+	if (rdtgrp->type == RDTCTRL_GROUP)
+		closid = rdtgrp->closid;
+	else if (rdtgrp->type == RDTMON_GROUP)
+		closid = rdtgrp->mon.parent->closid;
+	else
+		return false;
+
+	return resctrl_arch_match_closid(tsk, closid) &&
+	       resctrl_arch_match_rmid(tsk, closid, rmid);
+}
+
 static int __rdtgroup_move_task(struct task_struct *tsk,
 				struct rdtgroup *rdtgrp)
 {
 	/* If the task is already in rdtgrp, no need to move the task. */
-	if ((rdtgrp->type == RDTCTRL_GROUP && tsk->closid == rdtgrp->closid &&
-	     tsk->rmid == rdtgrp->mon.rmid) ||
-	    (rdtgrp->type == RDTMON_GROUP && tsk->rmid == rdtgrp->mon.rmid &&
-	     tsk->closid == rdtgrp->mon.parent->closid))
+	if (task_in_rdtgroup(tsk, rdtgrp))
 		return 0;
 
 	/*
@@ -592,19 +604,19 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	 * For monitor groups, can move the tasks only from
 	 * their parent CTRL group.
 	 */
-
-	if (rdtgrp->type == RDTCTRL_GROUP) {
-		WRITE_ONCE(tsk->closid, rdtgrp->closid);
-		WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
-	} else if (rdtgrp->type == RDTMON_GROUP) {
-		if (rdtgrp->mon.parent->closid == tsk->closid) {
-			WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
-		} else {
-			rdt_last_cmd_puts("Can't move task to different control group\n");
-			return -EINVAL;
-		}
+	if (rdtgrp->type == RDTMON_GROUP &&
+	    !resctrl_arch_match_closid(tsk, rdtgrp->mon.parent->closid)) {
+		rdt_last_cmd_puts("Can't move task to different control group\n");
+		return -EINVAL;
 	}
 
+	if (rdtgrp->type == RDTMON_GROUP)
+		resctrl_arch_set_closid_rmid(tsk, rdtgrp->mon.parent->closid,
+					     rdtgrp->mon.rmid);
+	else
+		resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid,
+					     rdtgrp->mon.rmid);
+
 	/*
 	 * Ensure the task's closid and rmid are written before determining if
 	 * the task is current that will decide if it will be interrupted.
@@ -626,14 +638,15 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 
 static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
 {
-	return (rdt_alloc_capable &&
-	       (r->type == RDTCTRL_GROUP) && (t->closid == r->closid));
+	return (rdt_alloc_capable && (r->type == RDTCTRL_GROUP) &&
+		resctrl_arch_match_closid(t, r->closid));
 }
 
 static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
 {
-	return (rdt_mon_capable &&
-	       (r->type == RDTMON_GROUP) && (t->rmid == r->mon.rmid));
+	return (rdt_mon_capable && (r->type == RDTMON_GROUP) &&
+		resctrl_arch_match_rmid(t, r->mon.parent->closid,
+					r->mon.rmid));
 }
 
 /**
@@ -884,7 +897,7 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
 		    rdtg->mode != RDT_MODE_EXCLUSIVE)
 			continue;
 
-		if (rdtg->closid != tsk->closid)
+		if (!resctrl_arch_match_closid(tsk, rdtg->closid))
 			continue;
 
 		seq_printf(s, "res:%s%s\n", (rdtg == &rdtgroup_default) ? "/" : "",
@@ -892,7 +905,8 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
 		seq_puts(s, "mon:");
 		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
 				    mon.crdtgrp_list) {
-			if (tsk->rmid != crg->mon.rmid)
+			if (!resctrl_arch_match_rmid(tsk, crg->mon.parent->closid,
+						     crg->mon.rmid))
 				continue;
 			seq_printf(s, "%s", crg->kn->name);
 			break;
@@ -2820,8 +2834,8 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 	for_each_process_thread(p, t) {
 		if (!from || is_closid_match(t, from) ||
 		    is_rmid_match(t, from)) {
-			WRITE_ONCE(t->closid, to->closid);
-			WRITE_ONCE(t->rmid, to->mon.rmid);
+			resctrl_arch_set_closid_rmid(t, to->closid,
+						     to->mon.rmid);
 
 			/*
 			 * Order the closid/rmid stores above before the loads


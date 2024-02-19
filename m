Return-Path: <linux-kernel+bounces-71817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1D385AB1B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2701C21DAE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F369839AC6;
	Mon, 19 Feb 2024 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wc36ARtv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EjkOIz+t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BD5482E3;
	Mon, 19 Feb 2024 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367850; cv=none; b=SMS8VDqcXtFhk+yJzgomORJHq4rCX5UeLA/h/Z21K0i4+TAwTacxR3gc+sSz82sQGv6ty7blu7oOFopq0BxAvx6DsFibbihD9tQBwRWqma29oX1R2i0PBlgQm+v20b4Znpn+fSDrJH/pKVeYLwi4Wrbm7V/YXuW458wF5HFgJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367850; c=relaxed/simple;
	bh=xc+z9jDKvdiz/KXJEbc5axMtXcct390vC2Lk99kNO9c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i049tuaMkh9FQpjC9LeGB7nBmc+xJilUqgyV4EmhVGlsNHYQGKNLgiK5lZaySIvs9Ij3WRkfTN0USkT1zhGBmJQRUzC6TgcnB0hu6W4wGhUE+TeGE6s47nQxQDCVDJp3wy4OiMcRYdlaOiCWCf4oW4wucI/ZISzf/IONhqD1uAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wc36ARtv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EjkOIz+t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQgoGJRnsx6y3XE1ijDM82YCYMuf072+B5AqLQECPfU=;
	b=Wc36ARtvvc/oRWjfiu/+My6wTEfPuYcBaauJVGRqWyXN0Yj9GuhGNVvmkBqVie+kunJ+3U
	mjbJNvL2cDuKWMZp+riQZraY4mnBFVzI5wsOQnBzhugBoiabUmx37VRg/qRmobChgpGhzO
	mLKpzuRgsk4nt9qcNHeBNYobXuoEawPiItIe/m2vJZXMCPAkE7zGfJ/z0nJLuW9FdAJMHY
	XrLbtCBtj3i7xlZmIRd6p+cKTmR1i31te3wLv5DHc8j8bvk0ZrMxnOXNSegwJIcLUVRzE6
	QhmK+Tdd/jjt3XwlcaJsVXmvJjpmSsRRNrkiGpHwGHTm3LyfREbyxYam5XH26w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQgoGJRnsx6y3XE1ijDM82YCYMuf072+B5AqLQECPfU=;
	b=EjkOIz+toO3UKWGLp+8gv8wXf3ry66R4coDDt1DnBJ4eurUfFI83M39L+uXN5s+OdAcN9L
	+YsCzZ6BDdWjy6Ag==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Add helpers for system wide mon/alloc capable
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-20-james.morse@arm.com>
References: <20240213184438.16675-20-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836784583.398.3014782432071880808.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     30017b60706c2ba72a0a4da7d5ef8f5fa95a2f01
Gitweb:        https://git.kernel.org/tip/30017b60706c2ba72a0a4da7d5ef8f5fa95a2f01
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:33 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:33 +01:00

x86/resctrl: Add helpers for system wide mon/alloc capable

resctrl reads rdt_alloc_capable or rdt_mon_capable to determine whether any of
the resources support the corresponding features.  resctrl also uses the
static keys that affect the architecture's context-switch code to determine the
same thing.

This forces another architecture to have the same static keys.

As the static key is enabled based on the capable flag, and none of the
filesystem uses of these are in the scheduler path, move the capable flags
behind helpers, and use these in the filesystem code instead of the static key.

After this change, only the architecture code manages and uses the static keys
to ensure __resctrl_sched_in() does not need runtime checks.

This avoids multiple architectures having to define the same static keys.

Cases where the static key implicitly tested if the resctrl filesystem was
mounted all have an explicit check now.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-20-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/resctrl.h            | 13 ++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     |  4 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 +--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 38 +++++++++++-----------
 5 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index b74aa34..12dbd25 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -38,10 +38,18 @@ struct resctrl_pqr_state {
 
 DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
 
+extern bool rdt_alloc_capable;
+extern bool rdt_mon_capable;
+
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 
+static inline bool resctrl_arch_alloc_capable(void)
+{
+	return rdt_alloc_capable;
+}
+
 static inline void resctrl_arch_enable_alloc(void)
 {
 	static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
@@ -54,6 +62,11 @@ static inline void resctrl_arch_disable_alloc(void)
 	static_branch_dec_cpuslocked(&rdt_enable_key);
 }
 
+static inline bool resctrl_arch_mon_capable(void)
+{
+	return rdt_mon_capable;
+}
+
 static inline void resctrl_arch_enable_mon(void)
 {
 	static_branch_enable_cpuslocked(&rdt_mon_enable_key);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 7858085..3ee855c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -137,8 +137,6 @@ struct rmid_read {
 	void			*arch_mon_ctx;
 };
 
-extern bool rdt_alloc_capable;
-extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
 extern struct list_head resctrl_schema_all;
 extern bool resctrl_mounted;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index d5d8a58..92d7ba6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -817,7 +817,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	 * If the filesystem has been unmounted this work no longer needs to
 	 * run.
 	 */
-	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
+	if (!resctrl_mounted || !resctrl_arch_mon_capable())
 		goto out_unlock;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
@@ -854,7 +854,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 	 * When a domain comes online there is no guarantee the filesystem is
 	 * mounted. If not, there is no need to catch counter overflow.
 	 */
-	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
+	if (!resctrl_mounted || !resctrl_arch_mon_capable())
 		return;
 	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
 	dom->mbm_work_cpu = cpu;
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index d8f4411..8056bed 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -581,7 +581,7 @@ static int rdtgroup_locksetup_user_restrict(struct rdtgroup *rdtgrp)
 	if (ret)
 		goto err_cpus;
 
-	if (rdt_mon_capable) {
+	if (resctrl_arch_mon_capable()) {
 		ret = rdtgroup_kn_mode_restrict(rdtgrp, "mon_groups");
 		if (ret)
 			goto err_cpus_list;
@@ -628,7 +628,7 @@ static int rdtgroup_locksetup_user_restore(struct rdtgroup *rdtgrp)
 	if (ret)
 		goto err_cpus;
 
-	if (rdt_mon_capable) {
+	if (resctrl_arch_mon_capable()) {
 		ret = rdtgroup_kn_mode_restore(rdtgrp, "mon_groups", 0777);
 		if (ret)
 			goto err_cpus_list;
@@ -776,7 +776,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
 {
 	int ret;
 
-	if (rdt_mon_capable) {
+	if (resctrl_arch_mon_capable()) {
 		ret = alloc_rmid(rdtgrp->closid);
 		if (ret < 0) {
 			rdt_last_cmd_puts("Out of RMIDs\n");
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7e57ac9..ed5fc67 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -641,13 +641,13 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 
 static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
 {
-	return (rdt_alloc_capable && (r->type == RDTCTRL_GROUP) &&
+	return (resctrl_arch_alloc_capable() && (r->type == RDTCTRL_GROUP) &&
 		resctrl_arch_match_closid(t, r->closid));
 }
 
 static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
 {
-	return (rdt_mon_capable && (r->type == RDTMON_GROUP) &&
+	return (resctrl_arch_mon_capable() && (r->type == RDTMON_GROUP) &&
 		resctrl_arch_match_rmid(t, r->mon.parent->closid,
 					r->mon.rmid));
 }
@@ -2632,7 +2632,7 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	closid_init();
 
-	if (rdt_mon_capable)
+	if (resctrl_arch_mon_capable())
 		flags |= RFTYPE_MON;
 
 	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
@@ -2645,7 +2645,7 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (ret < 0)
 		goto out_schemata_free;
 
-	if (rdt_mon_capable) {
+	if (resctrl_arch_mon_capable()) {
 		ret = mongroup_create_dir(rdtgroup_default.kn,
 					  &rdtgroup_default, "mon_groups",
 					  &kn_mongrp);
@@ -2667,12 +2667,12 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (ret < 0)
 		goto out_psl;
 
-	if (rdt_alloc_capable)
+	if (resctrl_arch_alloc_capable())
 		resctrl_arch_enable_alloc();
-	if (rdt_mon_capable)
+	if (resctrl_arch_mon_capable())
 		resctrl_arch_enable_mon();
 
-	if (rdt_alloc_capable || rdt_mon_capable)
+	if (resctrl_arch_alloc_capable() || resctrl_arch_mon_capable())
 		resctrl_mounted = true;
 
 	if (is_mbm_enabled()) {
@@ -2686,10 +2686,10 @@ static int rdt_get_tree(struct fs_context *fc)
 out_psl:
 	rdt_pseudo_lock_release();
 out_mondata:
-	if (rdt_mon_capable)
+	if (resctrl_arch_mon_capable())
 		kernfs_remove(kn_mondata);
 out_mongrp:
-	if (rdt_mon_capable)
+	if (resctrl_arch_mon_capable())
 		kernfs_remove(kn_mongrp);
 out_info:
 	kernfs_remove(kn_info);
@@ -2944,9 +2944,9 @@ static void rdt_kill_sb(struct super_block *sb)
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	schemata_list_destroy();
 	rdtgroup_destroy_root();
-	if (rdt_alloc_capable)
+	if (resctrl_arch_alloc_capable())
 		resctrl_arch_disable_alloc();
-	if (rdt_mon_capable)
+	if (resctrl_arch_mon_capable())
 		resctrl_arch_disable_mon();
 	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
@@ -3326,7 +3326,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 {
 	int ret;
 
-	if (!rdt_mon_capable)
+	if (!resctrl_arch_mon_capable())
 		return 0;
 
 	ret = alloc_rmid(rdtgrp->closid);
@@ -3348,7 +3348,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 
 static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
 {
-	if (rdt_mon_capable)
+	if (resctrl_arch_mon_capable())
 		free_rmid(rgrp->closid, rgrp->mon.rmid);
 }
 
@@ -3412,7 +3412,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 
 	if (rtype == RDTCTRL_GROUP) {
 		files = RFTYPE_BASE | RFTYPE_CTRL;
-		if (rdt_mon_capable)
+		if (resctrl_arch_mon_capable())
 			files |= RFTYPE_MON;
 	} else {
 		files = RFTYPE_BASE | RFTYPE_MON;
@@ -3521,7 +3521,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 
 	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
 
-	if (rdt_mon_capable) {
+	if (resctrl_arch_mon_capable()) {
 		/*
 		 * Create an empty mon_groups directory to hold the subset
 		 * of tasks and cpus to monitor.
@@ -3576,14 +3576,14 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
 	 * allocation is supported, add a control and monitoring
 	 * subdirectory
 	 */
-	if (rdt_alloc_capable && parent_kn == rdtgroup_default.kn)
+	if (resctrl_arch_alloc_capable() && parent_kn == rdtgroup_default.kn)
 		return rdtgroup_mkdir_ctrl_mon(parent_kn, name, mode);
 
 	/*
 	 * If RDT monitoring is supported and the parent directory is a valid
 	 * "mon_groups" directory, add a monitoring subdirectory.
 	 */
-	if (rdt_mon_capable && is_mon_groups(parent_kn, name))
+	if (resctrl_arch_mon_capable() && is_mon_groups(parent_kn, name))
 		return rdtgroup_mkdir_mon(parent_kn, name, mode);
 
 	return -EPERM;
@@ -3918,7 +3918,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 	 * If resctrl is mounted, remove all the
 	 * per domain monitor data directories.
 	 */
-	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
+	if (resctrl_mounted && resctrl_arch_mon_capable())
 		rmdir_mondata_subdir_allrdtgrp(r, d->id);
 
 	if (is_mbm_enabled())
@@ -4001,7 +4001,7 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 	 * by rdt_get_tree() calling mkdir_mondata_all().
 	 * If resctrl is mounted, add per domain monitor data directories.
 	 */
-	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
+	if (resctrl_mounted && resctrl_arch_mon_capable())
 		mkdir_mondata_subdir_allrdtgrp(r, d);
 
 	return 0;


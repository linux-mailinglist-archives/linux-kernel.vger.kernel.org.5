Return-Path: <linux-kernel+bounces-71819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BA685AB1D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D2E1C21D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219004CE0B;
	Mon, 19 Feb 2024 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aPf6zqO8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="669uNwPh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F5487AB;
	Mon, 19 Feb 2024 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367852; cv=none; b=uzbc7MyA7xAfpnnmDRBfWV6EFC2ZLCaBq2rBZd0AIOk0VfufYx/DxeIELU5gvcw2onMdVGt3LwQ8ns5+IHzMQIcp6gmGKBH9Kj1BTO/JtEXsPyeczxz65fqmjXVOOmuSeUJ2VV+OvG5jJxln35wv2e7AkXQZ2jP6wv08d70+76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367852; c=relaxed/simple;
	bh=dchmGdeqFbqsgbm7rB0kIZUnuQGr6qJapcitM86CdTw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dm6avPDuNt2NuwwiOY61krn9p6Ke0I+sCN/Uvzt20GrqtKf48puAHzDbmdqVZnuYXXQMGr0awbe1PoGbzOjm991Duo4vYXltb074hOWkJZYbYZZX5W4Uenfuy631HO7tiBLJFClVi6J0LCUEzGdpbp88MZ6Dx+h1IZKI1l75L4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aPf6zqO8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=669uNwPh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ViCTPdNdUqo6wu1L+NpE4RHFAXAmuyGCjDXHqk4tjT0=;
	b=aPf6zqO8O9aY4BplEYskvUaQKiW/3z0cECmkGycg0pV/MBoy8fYKfloeFeRBTfqH0KYoaX
	EPdKrWexJ17fXf9/ubxNVm7i+ejKoNWfAGcfs6BuN329gD1f8dxZ+UC/hp8fDT2rSMqDUQ
	qJAdVoNOIskQ2QCxxEgeBSsepso1p93Sn4ThBTKLFohvzpulsT8nas9vr6Eo7flQINCf05
	kHe6pEhap/+dYyEJTcxajKPD28HeLE0EwXyH5MyrykO83NfZiijdjKFOQCqDU9EN9wCEcX
	qb/ZPXEq+cJkZkWUtmMN6E/24/Hmmd/xHjnEYQ6HQKYdxp7tiBpxuAOUPomK/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ViCTPdNdUqo6wu1L+NpE4RHFAXAmuyGCjDXHqk4tjT0=;
	b=669uNwPh7XWAZreZPVpX99fXoitwUqax1HZ+o+bHHuLtJ+ldsu8SDJessE39LyVnsDL+Y/
	MbFgUidc0+b8z6DQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move alloc/mon static keys into helpers
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-18-james.morse@arm.com>
References: <20240213184438.16675-18-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836784765.398.11017471773718572549.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     5db6a4a75c95f6967d57906ba7b82756d1985d63
Gitweb:        https://git.kernel.org/tip/5db6a4a75c95f6967d57906ba7b82756d1985d63
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:31 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:32 +01:00

x86/resctrl: Move alloc/mon static keys into helpers

resctrl enables three static keys depending on the features it has enabled.
Another architecture's context switch code may look different, any static keys
that control it should be buried behind helpers.

Move the alloc/mon logic into arch-specific helpers as a preparatory step for
making the rdt_enable_key's status something the arch code decides.

This means other architectures don't have to mirror the static keys.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-18-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/resctrl.h         | 20 ++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  5 -----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  8 ++++----
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 29c4cc3..3c9137b 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -42,6 +42,26 @@ DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 
+static inline void resctrl_arch_enable_alloc(void)
+{
+	static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
+}
+
+static inline void resctrl_arch_disable_alloc(void)
+{
+	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
+}
+
+static inline void resctrl_arch_enable_mon(void)
+{
+	static_branch_enable_cpuslocked(&rdt_mon_enable_key);
+}
+
+static inline void resctrl_arch_disable_mon(void)
+{
+	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
+}
+
 /*
  * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
  *
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 9bfda69..7858085 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -94,9 +94,6 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
 	return container_of(kfc, struct rdt_fs_context, kfc);
 }
 
-DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
-DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
-
 /**
  * struct mon_evt - Entry in the event list of a resource
  * @evtid:		event id
@@ -452,8 +449,6 @@ extern struct mutex rdtgroup_mutex;
 
 extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
-DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
-
 extern struct dentry *debugfs_resctrl;
 
 enum resctrl_res_level {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 857fbbc..231207f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2668,9 +2668,9 @@ static int rdt_get_tree(struct fs_context *fc)
 		goto out_psl;
 
 	if (rdt_alloc_capable)
-		static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
+		resctrl_arch_enable_alloc();
 	if (rdt_mon_capable)
-		static_branch_enable_cpuslocked(&rdt_mon_enable_key);
+		resctrl_arch_enable_mon();
 
 	if (rdt_alloc_capable || rdt_mon_capable) {
 		static_branch_enable_cpuslocked(&rdt_enable_key);
@@ -2946,8 +2946,8 @@ static void rdt_kill_sb(struct super_block *sb)
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	schemata_list_destroy();
 	rdtgroup_destroy_root();
-	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
-	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
+	resctrl_arch_disable_alloc();
+	resctrl_arch_disable_mon();
 	static_branch_disable_cpuslocked(&rdt_enable_key);
 	resctrl_mounted = false;
 	kernfs_kill_sb(sb);


Return-Path: <linux-kernel+bounces-117597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A28D388AD05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBC91C604F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ADA12F396;
	Mon, 25 Mar 2024 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TuvO+Keb"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E612F36C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387659; cv=none; b=uTBdb37emeiD3FYxUEHUI4WR8KALu418Lrxx8bzMkg4dyLGwEXccpZJzH0EATvlqO4BRYuwVNCqEBQGvocNCaGp+3L3amcL8gM411+7tz1GEuG4Mdrv0+jkqZKZ1BIicn1SJ7VwNkgpDiWy2VGIbxmD39OsdG91gzvVXbuLknrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387659; c=relaxed/simple;
	bh=rZTT6QKzijjIvZzlnVr95xkP+9uKeuWzF2TLd4tBV9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dxHWcMtYaQnyEhcBLn9IfjdJBkOHpnoyjIFhQtVV9f2v5RP0JYtF58kxy+qFXnMYKgzEPLooaszXNn5AG0tOxAHLvWXENbk8P2q7B949jUPCtHjmBbgWhrmSz7WRiE6hghN3469QzJJAlkErDuV5bN1GKf/As0JqJBV/SmNKYmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TuvO+Keb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cbba6fa0bso87241757b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711387656; x=1711992456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6sYt0dTu69OKJjBkOi8XcK0GHNUcEvmVxw2SNet6n9M=;
        b=TuvO+KebtYe+ny6q7UXgOnE1Z3J8RvNae0xrTPevQeSHRvdTNsIAx68GgQHUIyI17K
         YWY/KDBthPlyl5BkE8bNMr7j7z6ZwrJsHm9g+OjCSVPUB+7lN9EYxazf+bTwmvJ6k0Y7
         zREVJwdAPqlj3Pm4WvNlDuHNKnvqecZjrS8hUWByMG5ACnp49dov1+DEqj9Ejdi8SWjT
         bnp0RtJOHYERknVsgecCazZ0CCZJx4xpfptV0f7njF6D+FZ4OKblmDuro3aEnKDaWFsi
         MeoxBxiweUBzxI6srGVv7SU6GMQRHYw9yqfRZ264dJf58/Hs/EYpQOOKS4MHRBXnCJ/L
         6FXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387656; x=1711992456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6sYt0dTu69OKJjBkOi8XcK0GHNUcEvmVxw2SNet6n9M=;
        b=qkyNLdzlJEaBtzysvXwwmVDjJdaaFBpkeFD+2StYaYESFStfCXM2PqL27QF6KkIAj1
         ITVRITVjOn00HanmS56sHkCsbiMYz5gF+WvuR2T8xR1/u+liur/5zfoGR6XY2juqv7gr
         L1cJmVdQX51y9p8ZFBlAA9lD8t5KJ+pFmIjpRewVH+SP0ytNziFCKZKL/KvvdOcW6kpX
         GbUGyLvmHMgGm4oqiI0rRqpNV+HnrWInLxZX0P42ZtEoDpDqlsfg7LNtG3SOltZ3C9lu
         1ptutyxWSQtumUGYqem3s/hwbsBWL52E/75kWr7bCanb6JM9WYAhOPApZnP7WuKZx8v1
         DJRA==
X-Forwarded-Encrypted: i=1; AJvYcCU0gitbbm35WK/B4bkt8CtgRKSml4l6HAVgR1NsUy+S8qoU+aqAlLcWs45hH9TPihTTIJIfeFCv4OE6V2jzSLxLcqrXx3TiwPBfn5CR
X-Gm-Message-State: AOJu0YzkvxKVI1UocPYRp5RJ9DgvE1JzDNjEw+tTqwGLzQ6TWXTPuLRl
	TSiihQEWngLvf1CFcqvk86Lyk/lLgw4utg37JL6iHqEZhFlwnXasGe31MWC9GOOPdscy5nMfmWM
	ApcYF/4qxlPQhaKccgZWgCA==
X-Google-Smtp-Source: AGHT+IFCmz5O/RuOvajFIq7LN16Esa34lGCVAS5nlSt3cqrYU+ynIulHUiqHNgktIJKEToOLbIKmQjfnm51kn3xugg==
X-Received: from peternewman-us.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3dcc])
 (user=peternewman job=sendgmr) by 2002:a05:6902:220a:b0:dc6:5396:c0d4 with
 SMTP id dm10-20020a056902220a00b00dc65396c0d4mr2368650ybb.1.1711387656606;
 Mon, 25 Mar 2024 10:27:36 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:27:02 -0700
In-Reply-To: <20240325172707.73966-1-peternewman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325172707.73966-1-peternewman@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325172707.73966-2-peternewman@google.com>
Subject: [PATCH v1 1/6] x86/resctrl: Move __resctrl_sched_in() out-of-line
From: Peter Newman <peternewman@google.com>
To: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	James Morse <james.morse@arm.com>
Cc: Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen <tandersen@netflix.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"

__resctrl_sched_in() is unable to dereference a struct rdtgroup pointer
when defined inline because rdtgroup is a private structure defined in
internal.h.

This function is defined inline to avoid impacting context switch
performance for the majority of users who aren't using resctrl at all.
These benefits can already be realized without access to internal
resctrl data structures.

The logic of performing an out-of-line call to __resctrl_sched_in() only
when resctrl is mounted is architecture-independent, so the inline
definition of resctrl_sched_in() can be moved into linux/resctrl.h.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/include/asm/resctrl.h         | 75 --------------------------
 arch/x86/kernel/cpu/resctrl/internal.h | 24 +++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 41 ++++++++++++++
 arch/x86/kernel/process_32.c           |  2 +-
 arch/x86/kernel/process_64.c           |  2 +-
 include/linux/resctrl.h                | 21 ++++++++
 6 files changed, 88 insertions(+), 77 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 12dbd2588ca7..99ba8c0dc155 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -14,30 +14,6 @@
  */
 #define X86_RESCTRL_EMPTY_CLOSID         ((u32)~0)
 
-/**
- * struct resctrl_pqr_state - State cache for the PQR MSR
- * @cur_rmid:		The cached Resource Monitoring ID
- * @cur_closid:	The cached Class Of Service ID
- * @default_rmid:	The user assigned Resource Monitoring ID
- * @default_closid:	The user assigned cached Class Of Service ID
- *
- * The upper 32 bits of MSR_IA32_PQR_ASSOC contain closid and the
- * lower 10 bits rmid. The update to MSR_IA32_PQR_ASSOC always
- * contains both parts, so we need to cache them. This also
- * stores the user configured per cpu CLOSID and RMID.
- *
- * The cache also helps to avoid pointless updates if the value does
- * not change.
- */
-struct resctrl_pqr_state {
-	u32			cur_rmid;
-	u32			cur_closid;
-	u32			default_rmid;
-	u32			default_closid;
-};
-
-DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
-
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
 
@@ -79,50 +55,6 @@ static inline void resctrl_arch_disable_mon(void)
 	static_branch_dec_cpuslocked(&rdt_enable_key);
 }
 
-/*
- * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
- *
- * Following considerations are made so that this has minimal impact
- * on scheduler hot path:
- * - This will stay as no-op unless we are running on an Intel SKU
- *   which supports resource control or monitoring and we enable by
- *   mounting the resctrl file system.
- * - Caches the per cpu CLOSid/RMID values and does the MSR write only
- *   when a task with a different CLOSid/RMID is scheduled in.
- * - We allocate RMIDs/CLOSids globally in order to keep this as
- *   simple as possible.
- * Must be called with preemption disabled.
- */
-static inline void __resctrl_sched_in(struct task_struct *tsk)
-{
-	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
-	u32 closid = state->default_closid;
-	u32 rmid = state->default_rmid;
-	u32 tmp;
-
-	/*
-	 * If this task has a closid/rmid assigned, use it.
-	 * Else use the closid/rmid assigned to this cpu.
-	 */
-	if (static_branch_likely(&rdt_alloc_enable_key)) {
-		tmp = READ_ONCE(tsk->closid);
-		if (tmp)
-			closid = tmp;
-	}
-
-	if (static_branch_likely(&rdt_mon_enable_key)) {
-		tmp = READ_ONCE(tsk->rmid);
-		if (tmp)
-			rmid = tmp;
-	}
-
-	if (closid != state->cur_closid || rmid != state->cur_rmid) {
-		state->cur_closid = closid;
-		state->cur_rmid = rmid;
-		wrmsr(MSR_IA32_PQR_ASSOC, rmid, closid);
-	}
-}
-
 static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
 {
 	unsigned int scale = boot_cpu_data.x86_cache_occ_scale;
@@ -150,12 +82,6 @@ static inline bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 ignored,
 	return READ_ONCE(tsk->rmid) == rmid;
 }
 
-static inline void resctrl_sched_in(struct task_struct *tsk)
-{
-	if (static_branch_likely(&rdt_enable_key))
-		__resctrl_sched_in(tsk);
-}
-
 static inline u32 resctrl_arch_system_num_rmid_idx(void)
 {
 	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
@@ -188,7 +114,6 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
 #else
 
-static inline void resctrl_sched_in(struct task_struct *tsk) {}
 static inline void resctrl_cpu_detect(struct cpuinfo_x86 *c) {}
 
 #endif /* CONFIG_X86_CPU_RESCTRL */
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c99f26ebe7a6..56a68e542572 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -331,6 +331,30 @@ struct rftype {
 			 char *buf, size_t nbytes, loff_t off);
 };
 
+/**
+ * struct resctrl_pqr_state - State cache for the PQR MSR
+ * @cur_rmid:		The cached Resource Monitoring ID
+ * @cur_closid:	The cached Class Of Service ID
+ * @default_rmid:	The user assigned Resource Monitoring ID
+ * @default_closid:	The user assigned cached Class Of Service ID
+ *
+ * The upper 32 bits of MSR_IA32_PQR_ASSOC contain closid and the
+ * lower 10 bits rmid. The update to MSR_IA32_PQR_ASSOC always
+ * contains both parts, so we need to cache them. This also
+ * stores the user configured per cpu CLOSID and RMID.
+ *
+ * The cache also helps to avoid pointless updates if the value does
+ * not change.
+ */
+struct resctrl_pqr_state {
+	u32			cur_rmid;
+	u32			cur_closid;
+	u32			default_rmid;
+	u32			default_closid;
+};
+
+DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
+
 /**
  * struct mbm_state - status for each MBM counter in each domain
  * @prev_bw_bytes: Previous bytes value read for bandwidth calculation
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 011e17efb1a6..5d599d99f94b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -334,6 +334,47 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+/*
+ * __resctrl_sched_in() - Writes the task's control and monitor IDs into the CPU
+ *
+ * Following considerations are made so that this has minimal impact
+ * on scheduler hot path:
+ * - Caches the per cpu CLOSid/RMID values and does the MSR write only
+ *   when a task with a different CLOSid/RMID is scheduled in.
+ * - We allocate RMIDs/CLOSids globally in order to keep this as
+ *   simple as possible.
+ * Must be called with preemption disabled.
+ */
+void __resctrl_sched_in(struct task_struct *tsk)
+{
+	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
+	u32 closid = state->default_closid;
+	u32 rmid = state->default_rmid;
+	u32 tmp;
+
+	/*
+	 * If this task has a closid/rmid assigned, use it.
+	 * Else use the closid/rmid assigned to this cpu.
+	 */
+	if (static_branch_likely(&rdt_alloc_enable_key)) {
+		tmp = READ_ONCE(tsk->closid);
+		if (tmp)
+			closid = tmp;
+	}
+
+	if (static_branch_likely(&rdt_mon_enable_key)) {
+		tmp = READ_ONCE(tsk->rmid);
+		if (tmp)
+			rmid = tmp;
+	}
+
+	if (closid != state->cur_closid || rmid != state->cur_rmid) {
+		state->cur_closid = closid;
+		state->cur_rmid = rmid;
+		wrmsr(MSR_IA32_PQR_ASSOC, rmid, closid);
+	}
+}
+
 /*
  * This is safe against resctrl_sched_in() called from __switch_to()
  * because __switch_to() is executed with interrupts disabled. A local call
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 0917c7f25720..8f92a87d381d 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -38,6 +38,7 @@
 #include <linux/io.h>
 #include <linux/kdebug.h>
 #include <linux/syscalls.h>
+#include <linux/resctrl.h>
 
 #include <asm/ldt.h>
 #include <asm/processor.h>
@@ -51,7 +52,6 @@
 #include <asm/debugreg.h>
 #include <asm/switch_to.h>
 #include <asm/vm86.h>
-#include <asm/resctrl.h>
 #include <asm/proto.h>
 
 #include "process.h"
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 7062b84dd467..d442269bb25b 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -40,6 +40,7 @@
 #include <linux/ftrace.h>
 #include <linux/syscalls.h>
 #include <linux/iommu.h>
+#include <linux/resctrl.h>
 
 #include <asm/processor.h>
 #include <asm/pkru.h>
@@ -53,7 +54,6 @@
 #include <asm/switch_to.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/vdso.h>
-#include <asm/resctrl.h>
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
 #include <asm/fred.h>
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a365f67131ec..62d607939a73 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -304,4 +304,25 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d);
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
+DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
+
+void __resctrl_sched_in(struct task_struct *tsk);
+
+/*
+ * resctrl_sched_in() - Assigns the incoming task's control/monitor IDs to the
+ *			current CPU
+ *
+ * To minimize impact to the scheduler hot path, this will stay as no-op unless
+ * running on a system supporting resctrl and the filesystem is mounted.
+ *
+ * Must be called with preemption disabled.
+ */
+static inline void resctrl_sched_in(struct task_struct *tsk)
+{
+#ifdef CONFIG_X86_CPU_RESCTRL
+	if (static_branch_likely(&rdt_enable_key))
+		__resctrl_sched_in(tsk);
+#endif
+}
+
 #endif /* _RESCTRL_H */
-- 
2.44.0.396.g6e790dbe36-goog



Return-Path: <linux-kernel+bounces-37942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A38D83B8A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5D9287BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C535A10A30;
	Thu, 25 Jan 2024 04:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="upgKgTEl"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1DC101E2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706156594; cv=none; b=KnHwUUpeisnKV+E0BHwl7qdrSyjvzC+Gh+s5cZq9D4zcTCKKkO+kFGdy61k/TkLRIKdPLSvd9NcxgYDnRkcDPk+bj2lvwF2JKP/W4jB7C7hkeMjrJPExXF2YwSKKM3jYxO2DkN7vKOSEaNNpD5TgjAWApBIPldxVSCpAodj+7FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706156594; c=relaxed/simple;
	bh=Wrbc2b6m69dlcwU7PwTcVPKZs3y4yvoSAGZnA9SbZ+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LhPWC2lHlIjVa3YkQOL+/If0nyWlCVrXiTGHrzFKAwp6imsMlGn3TuPRn12iVbX46UqjhEfoh7sxD67Yau1nztxAjT9QL3wvfPKB3nmBRev86eGqdLCLo56hs/XeQTpru/rCEAHs5sNht8dWmQ78eEd1VzOcLwfX01Pxp8rczJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=upgKgTEl; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e0a64d94d1so3740498a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 20:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706156591; x=1706761391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLIM72Z2vNh3qI4rsxyZGnimCgUZb6UoqNYsK+L6u4g=;
        b=upgKgTElGMUBjpLfQ9dPyt4Yt4BPjAFJj0CWZHjFvBUpiKwq0oFsj0H5Os2PExDqtb
         1ebklZ07dmH+xGuh9eVQ5/8Jbc9bs0iW/T6GqaqtFg8HCjhjfPzBK5ZEN2/niv0Hvz+a
         Oz9tujiUw8AxxRzgNjSli6LdRM0Eyl/ARGpEC5Iu2Dl14IIbm3DAlM8SRlJZty0hxkz7
         Xfl0+z3LRbsLXg30siiL/4c5tzwssmyJG8BONlJy99lT9uFnLZ3fBMEKg14/5xp6wjAy
         0GGbbKcVpgEPSysHUsvdBOG/GUvQ1agd8EWbUSJAufV1E3de8x5EGIbyESJIBFPaKCtn
         7FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706156591; x=1706761391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLIM72Z2vNh3qI4rsxyZGnimCgUZb6UoqNYsK+L6u4g=;
        b=b0BQNSp4Z4rIY3MLZqJ3Hu8IKF7CVYiXF3oYuwq0M7RNHAA71OpTbh+w8oWuwGtLVV
         K4l9J8fazY6KskLEPAFEFN1Gi5k6PFFGcmFUtuvaU/7eE3zuvIUfaS/4kEya743mohNI
         W2Pc64NgWYSH9rICWHvUJboaWGRHLfu04sA3mNy8Xvv0/8IGLHPUZf4pWRpjlhXt2NQy
         VXT3l8DRMgtbJbzcU7MedzpYFhgDWcGJ+uby36hKDln5l0smWiqNUXqjND41jXcw5QjG
         ik4WZiu4X2tfTx5FEalTP48VX5GkM/pB8/n3J0riZFBMC6AAzZBGEeisgJLxBP80fzq2
         d1fQ==
X-Gm-Message-State: AOJu0Yxc6vcoZsoKhE+Lsq4J/8J7aacATgOHnokjUDvknSQu+o8DfS66
	rEJXCX3UB6fnYfmjVfCw0CsvlRCXI/va3H/puL/rk/j9AJE2LNBN52wI12j8kUg=
X-Google-Smtp-Source: AGHT+IFUvnTdJaqbpQl1U0Dl7T4XtAAkQaiRxFqqbQs1mGklF/pj6r3xdCixdbHNU6ti4Yb2l95t4Q==
X-Received: by 2002:a9d:67c5:0:b0:6e1:37b:5678 with SMTP id c5-20020a9d67c5000000b006e1037b5678mr263383otn.34.1706156591404;
        Wed, 24 Jan 2024 20:23:11 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ko9-20020a056a00460900b006dab36287bfsm14549743pfb.207.2024.01.24.20.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 20:23:10 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jan 2024 20:23:08 -0800
Subject: [PATCH v10 1/2] riscv: Include riscv_set_icache_flush_ctx prctl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-fencei-v10-1-a25971f4301d@rivosinc.com>
References: <20240124-fencei-v10-0-a25971f4301d@rivosinc.com>
In-Reply-To: <20240124-fencei-v10-0-a25971f4301d@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706156588; l=9638;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=Wrbc2b6m69dlcwU7PwTcVPKZs3y4yvoSAGZnA9SbZ+w=;
 b=kyLw1DLApnIyBKT1LLGYGvjkOP+WNF2nzFLQiYvHqu4U+6xzKO/fSWEAG+F8eZ4l6jsGDUtH7
 E86CXf4VcL2CkLkW3ngNOLpdl7nTEid24bCcbzWRI9juEJBJZJEPUnB
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Support new prctl with key PR_RISCV_SET_ICACHE_FLUSH_CTX to enable
optimization of cross modifying code. This prctl enables userspace code
to use icache flushing instructions such as fence.i with the guarantee
that the icache will continue to be clean after thread migration.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/mmu.h       |  2 ++
 arch/riscv/include/asm/processor.h |  7 ++++
 arch/riscv/include/asm/switch_to.h | 13 ++++++++
 arch/riscv/mm/cacheflush.c         | 67 ++++++++++++++++++++++++++++++++++++++
 arch/riscv/mm/context.c            | 13 ++++++--
 include/uapi/linux/prctl.h         |  6 ++++
 kernel/sys.c                       |  6 ++++
 7 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index 355504b37f8e..60be458e94da 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -19,6 +19,8 @@ typedef struct {
 #ifdef CONFIG_SMP
 	/* A local icache flush is needed before user execution can resume. */
 	cpumask_t icache_stale_mask;
+	/* Force local icache flush on all migrations. */
+	bool force_icache_flush;
 #endif
 #ifdef CONFIG_BINFMT_ELF_FDPIC
 	unsigned long exec_fdpic_loadmap;
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index a8509cc31ab2..816cdc2395f4 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -123,6 +123,10 @@ struct thread_struct {
 	struct __riscv_v_ext_state vstate;
 	unsigned long align_ctl;
 	struct __riscv_v_ext_state kernel_vstate;
+#ifdef CONFIG_SMP
+	bool force_icache_flush;
+	unsigned int prev_cpu;
+#endif
 };
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
@@ -184,6 +188,9 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
 #define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
 #define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
 
+#define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)	riscv_set_icache_flush_ctx(arg1, arg2)
+extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 7efdb0584d47..ac99ab64499c 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -8,6 +8,7 @@
 
 #include <linux/jump_label.h>
 #include <linux/sched/task_stack.h>
+#include <linux/mm_types.h>
 #include <asm/vector.h>
 #include <asm/cpufeature.h>
 #include <asm/processor.h>
@@ -72,14 +73,26 @@ static __always_inline bool has_fpu(void) { return false; }
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
 
+static inline bool switch_to_should_flush_icache(struct task_struct *task)
+{
+	bool stale_mm = task->mm && (task->mm->context.force_icache_flush);
+	bool stale_thread = task->thread.force_icache_flush;
+	bool thread_migrated = smp_processor_id() != task->thread.prev_cpu;
+
+	return thread_migrated && (stale_mm || stale_thread);
+}
+
 #define switch_to(prev, next, last)			\
 do {							\
 	struct task_struct *__prev = (prev);		\
 	struct task_struct *__next = (next);		\
+	__next->thread.prev_cpu = smp_processor_id();	\
 	if (has_fpu())					\
 		__switch_to_fpu(__prev, __next);	\
 	if (has_vector())					\
 		__switch_to_vector(__prev, __next);	\
+	if (switch_to_should_flush_icache(__next))	\
+		local_flush_icache_all();		\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 55a34f2020a8..2d5e1575f6c1 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -5,6 +5,7 @@
 
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/prctl.h>
 #include <asm/acpi.h>
 #include <asm/cacheflush.h>
 
@@ -152,3 +153,69 @@ void __init riscv_init_cbo_blocksizes(void)
 	if (cboz_block_size)
 		riscv_cboz_block_size = cboz_block_size;
 }
+
+/**
+ * riscv_set_icache_flush_ctx() - Enable/disable icache flushing instructions in
+ * userspace.
+ * @ctx: Set the type of icache flushing instructions permitted/prohibited in
+ *	 userspace. Supported values described below.
+ *
+ * Supported values for ctx:
+ *
+ * * %PR_RISCV_CTX_SW_FENCEI_ON: Allow fence.i in userspace.
+ *
+ * * %PR_RISCV_CTX_SW_FENCEI_OFF: Disallow fence.i in userspace. All threads in
+ *   a process will be affected when ``scope == PR_RISCV_SCOPE_PER_PROCESS``.
+ *   Therefore, caution must be taken -- only use this flag when you can
+ *   guarantee that no thread in the process will emit fence.i from this point
+ *   onward.
+ *
+ * @scope: Set scope of where icache flushing instructions are allowed to be
+ *	   emitted. Supported values described below.
+ *
+ * Supported values for scope:
+ *
+ * * %PR_RISCV_SCOPE_PER_PROCESS: Ensure the icache of any thread in this process
+ *                               is coherent with instruction storage upon
+ *                               migration.
+ *
+ * * %PR_RISCV_SCOPE_PER_THREAD: Ensure the icache of the current thread is
+ *                              coherent with instruction storage upon
+ *                              migration.
+ *
+ * When ``scope == PR_RISCV_SCOPE_PER_PROCESS``, all threads in the process are
+ * permitted to emit icache flushing instructions. Whenever any thread in the
+ * process is migrated, the corresponding hart's icache will be guaranteed to be
+ * consistent with instruction storage. Note this does not enforce any
+ * guarantees outside of migration. If a thread modifies an instruction that
+ * another thread may attempt to execute, the other thread must still emit an
+ * icache flushing instruction before attempting to execute the potentially
+ * modified instruction. This must be performed by the userspace program.
+ *
+ * In per-thread context (eg. ``scope == PR_RISCV_SCOPE_PER_THREAD``), only the
+ * thread calling this function is permitted to emit icache flushing
+ * instructions. When the thread is migrated, the corresponding hart's icache
+ * will be guaranteed to be consistent with instruction storage.
+ *
+ * On kernels configured without SMP, this function is a nop as migrations
+ * across harts will not occur.
+ */
+int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long scope)
+{
+#ifdef CONFIG_SMP
+	switch (ctx) {
+	case PR_RISCV_CTX_SW_FENCEI_ON:
+		switch (scope) {
+		case PR_RISCV_SCOPE_PER_PROCESS:
+			current->mm->context.force_icache_flush = true;
+			break;
+		case PR_RISCV_SCOPE_PER_THREAD:
+			current->thread.force_icache_flush = true;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+#endif
+	return 0;
+}
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 217fd4de6134..5cabbc449080 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -15,6 +15,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
+#include <asm/switch_to.h>
 
 #ifdef CONFIG_MMU
 
@@ -297,7 +298,8 @@ static inline void set_mm(struct mm_struct *prev,
  *
  * The "cpu" argument must be the current local CPU number.
  */
-static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu)
+static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu,
+					 struct task_struct *task)
 {
 #ifdef CONFIG_SMP
 	cpumask_t *mask = &mm->context.icache_stale_mask;
@@ -309,7 +311,12 @@ static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu)
 		 * This pairs with a barrier in flush_icache_mm.
 		 */
 		smp_mb();
-		local_flush_icache_all();
+
+		/*
+		 * If cache will be flushed in switch_to, no need to flush here.
+		 */
+		if (!(task && switch_to_should_flush_icache(task)))
+			local_flush_icache_all();
 	}
 
 #endif
@@ -332,5 +339,5 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 	set_mm(prev, next, cpu);
 
-	flush_icache_deferred(next, cpu);
+	flush_icache_deferred(next, cpu, task);
 }
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 370ed14b1ae0..524d546d697b 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -306,4 +306,10 @@ struct prctl_mm_map {
 # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
 # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
 
+#define PR_RISCV_SET_ICACHE_FLUSH_CTX	71
+# define PR_RISCV_CTX_SW_FENCEI_ON	0
+# define PR_RISCV_CTX_SW_FENCEI_OFF	1
+# define PR_RISCV_SCOPE_PER_PROCESS	0
+# define PR_RISCV_SCOPE_PER_THREAD	1
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index e219fcfa112d..69afdd8b430f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -146,6 +146,9 @@
 #ifndef RISCV_V_GET_CONTROL
 # define RISCV_V_GET_CONTROL()		(-EINVAL)
 #endif
+#ifndef RISCV_SET_ICACHE_FLUSH_CTX
+# define RISCV_SET_ICACHE_FLUSH_CTX(a, b)	(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2743,6 +2746,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_RISCV_V_GET_CONTROL:
 		error = RISCV_V_GET_CONTROL();
 		break;
+	case PR_RISCV_SET_ICACHE_FLUSH_CTX:
+		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
+		break;
 	default:
 		error = -EINVAL;
 		break;

-- 
2.34.1



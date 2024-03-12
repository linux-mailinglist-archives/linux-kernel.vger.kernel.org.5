Return-Path: <linux-kernel+bounces-100942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B9D879FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAEE32836F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7931551C4F;
	Tue, 12 Mar 2024 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="S0vjrBBJ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C31482F4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287628; cv=none; b=syFMZsuAz2W409ArKVHZMw2HuJUGwRxwAUn8SNyP32Ym1usUHLP94aR5NWsIjRtIs05+E+TDBD2CGHwtQWWJGtf/57zDbVJkqrDyK8yTG4jWjDy0lEb0FDivYaJQ+6hguHBRwYitAjrDP8P7l9Uf/M+o3aumbyep2Egc7zlCUFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287628; c=relaxed/simple;
	bh=bPMWuHBVidRCQkFVpmuHBX4Sc3WAPY7g8gK9PzERpuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VCb/pMqEm0t7+1jkR5u4IOYsshXONbRvvgTLJ9Qyd1NMsaQqhTvWXNEjVrjJYizDYnNcqK2Nl6OGKkOU8eVsqjG+qArRJUEsCUBMHfUQh0lc6JtLleb3byOnZ/FU9uaftmZjRcCpv50Ba0LySeHOz21MmywxqK/0BR0dDHCTUyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=S0vjrBBJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dd8d586126so3984765ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710287625; x=1710892425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDs5jJiwefD5cp1JHl1YzkvSBJNf6t62DgRH44oyTg4=;
        b=S0vjrBBJn+d9kbupFoVyqeGffZlHkMbg9sTwUwJaDd+XiJWXtrx1M8iyztffbBTxcp
         zogv0/HETZB9+ecV1QrQIglISU2fasKny9eqQ6ohxJb20RQxNm2zWhb4XtR7UnFi01fc
         DI+qtiuQlDA/KyKLbECXOmcx6sYDYbOobWDSiTBQ3851AroLSfR2RI67caXltFj4vlTm
         6erT4fvF9t3kbiPI/Vl6bYqgcUQmAPUAAzYkse1NYOFkSMKbI5+s3SS5qBT+BnwCqdUi
         GbAtE/TO2xa/bXXBCZkkBkkh7wJGlE9hhSxE1GWjacyrZyZJxL8kH8XcGffXq41tMezW
         +Ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710287625; x=1710892425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDs5jJiwefD5cp1JHl1YzkvSBJNf6t62DgRH44oyTg4=;
        b=PtmXULubpEOxW4xib77Cw0XZWFObtlke8/MolKoBL3shCS3xjS2sXB9L6La3j/K8O4
         wTiuU2qBnEUWKmNFDOXWrE1AVtrSUbW5kPrSfqlt+Upsu2SZHirtXNeR2QfNw4sIPwaD
         UbODPIGbigf0T9czzih6KBgCjXtNOLfrm9mPhtmrWY1WrIli+XzkQZDCQKyMUFRN4Kl+
         RCtXb/q5uI4lpvm6hp+qCwjF02kERg+DU/2ud555mdU0j6E8tljPLA04q/NIy0im/ow2
         puDV5Ksk89VXZDvrgE5df7ofTzFezJOtFkLN+niIYklWa9h0gRR8dXF3uBmgDTwz4A+Q
         zVag==
X-Forwarded-Encrypted: i=1; AJvYcCXNe8d/vuxa9Bj6V2Bh9rTu5nhLe0GsiTBuPkPA/05l9rl5i8aRSSVF+OIrZpGBmR5vd/VjdNJa2N2FgWHJOtfgsYnb5TPrS3+j+K2p
X-Gm-Message-State: AOJu0YxCmKb4Docbe2ZsZg3zOIvRbyM0lZCwo7HqrXbrPgdmgHD7ufkv
	ZaEqDg5MXmOc2001pWCm4qSyOYhouNP6tUJloPb6vZnD7fYU4iOPRYQr8ITlfoU=
X-Google-Smtp-Source: AGHT+IEZxFddJ5NHERzedf2RtnqyZKDQTP5bX3sBa03SK/f20P2yWSUg0iH/VPgRC5fq5b8mtnn17w==
X-Received: by 2002:a17:902:ecd2:b0:1d8:f129:a0bc with SMTP id a18-20020a170902ecd200b001d8f129a0bcmr6362778plh.13.1710287625625;
        Tue, 12 Mar 2024 16:53:45 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001dcad9cbf8bsm7282844plw.239.2024.03.12.16.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 16:53:44 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 12 Mar 2024 16:53:41 -0700
Subject: [PATCH v13 2/4] riscv: Include riscv_set_icache_flush_ctx prctl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240312-fencei-v13-2-4b6bdc2bbf32@rivosinc.com>
References: <20240312-fencei-v13-0-4b6bdc2bbf32@rivosinc.com>
In-Reply-To: <20240312-fencei-v13-0-4b6bdc2bbf32@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710287621; l=11349;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=bPMWuHBVidRCQkFVpmuHBX4Sc3WAPY7g8gK9PzERpuY=;
 b=N5FgfruthBOoAEkL/FveG1Y29jZQlU3mPda/HRFAR0/9ZRArrkwUOn0HWq+WOHjFEEA+zoWuE
 eenyY1M0tn1BdFThfgnRLJeblj51R1T5WXu+CFTZ7JWJjzbpbGhbYyN
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Support new prctl with key PR_RISCV_SET_ICACHE_FLUSH_CTX to enable
optimization of cross modifying code. This prctl enables userspace code
to use icache flushing instructions such as fence.i with the guarantee
that the icache will continue to be clean after thread migration.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/mmu.h       |   2 +
 arch/riscv/include/asm/processor.h |  10 ++++
 arch/riscv/include/asm/switch_to.h |  23 ++++++++
 arch/riscv/mm/cacheflush.c         | 111 +++++++++++++++++++++++++++++++++++++
 arch/riscv/mm/context.c            |  19 ++++---
 include/uapi/linux/prctl.h         |   6 ++
 kernel/sys.c                       |   6 ++
 7 files changed, 169 insertions(+), 8 deletions(-)

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
index a8509cc31ab2..cca62013c3c0 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -69,6 +69,7 @@
 #endif
 
 #ifndef __ASSEMBLY__
+#include <linux/cpumask.h>
 
 struct task_struct;
 struct pt_regs;
@@ -123,6 +124,12 @@ struct thread_struct {
 	struct __riscv_v_ext_state vstate;
 	unsigned long align_ctl;
 	struct __riscv_v_ext_state kernel_vstate;
+#ifdef CONFIG_SMP
+	/* Flush the icache on migration */
+	bool force_icache_flush;
+	/* A forced icache flush is not needed if migrating to the previous cpu. */
+	unsigned int prev_cpu;
+#endif
 };
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
@@ -184,6 +191,9 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
 #define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
 #define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
 
+#define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)	riscv_set_icache_flush_ctx(arg1, arg2)
+extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 7efdb0584d47..7594df37cc9f 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -8,6 +8,7 @@
 
 #include <linux/jump_label.h>
 #include <linux/sched/task_stack.h>
+#include <linux/mm_types.h>
 #include <asm/vector.h>
 #include <asm/cpufeature.h>
 #include <asm/processor.h>
@@ -72,14 +73,36 @@ static __always_inline bool has_fpu(void) { return false; }
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
 
+static inline bool switch_to_should_flush_icache(struct task_struct *task)
+{
+#ifdef CONFIG_SMP
+	bool stale_mm = task->mm && task->mm->context.force_icache_flush;
+	bool stale_thread = task->thread.force_icache_flush;
+	bool thread_migrated = smp_processor_id() != task->thread.prev_cpu;
+
+	return thread_migrated && (stale_mm || stale_thread);
+#else
+	return false;
+#endif
+}
+
+#ifdef CONFIG_SMP
+#define __set_prev_cpu(thread) ((thread).prev_cpu = smp_processor_id())
+#else
+#define __set_prev_cpu(thread)
+#endif
+
 #define switch_to(prev, next, last)			\
 do {							\
 	struct task_struct *__prev = (prev);		\
 	struct task_struct *__next = (next);		\
+	__set_prev_cpu(__prev->thread);			\
 	if (has_fpu())					\
 		__switch_to_fpu(__prev, __next);	\
 	if (has_vector())					\
 		__switch_to_vector(__prev, __next);	\
+	if (switch_to_should_flush_icache(__next))	\
+		local_flush_icache_all();		\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 55a34f2020a8..9b74861000ae 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -5,6 +5,7 @@
 
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/prctl.h>
 #include <asm/acpi.h>
 #include <asm/cacheflush.h>
 
@@ -152,3 +153,113 @@ void __init riscv_init_cbo_blocksizes(void)
 	if (cboz_block_size)
 		riscv_cboz_block_size = cboz_block_size;
 }
+
+static void set_icache_stale_mask(void)
+{
+	cpumask_t *mask;
+	bool stale_cpu;
+
+	/*
+	 * Mark every other hart's icache as needing a flush for
+	 * this MM. Maintain the previous value of the current
+	 * cpu to handle the case when this function is called
+	 * concurrently on different harts.
+	 */
+	mask = &current->mm->context.icache_stale_mask;
+	stale_cpu = cpumask_test_cpu(smp_processor_id(), mask);
+
+	cpumask_setall(mask);
+	assign_bit(cpumask_check(smp_processor_id()), cpumask_bits(mask), stale_cpu);
+}
+
+/**
+ * riscv_set_icache_flush_ctx() - Enable/disable icache flushing instructions in
+ * userspace.
+ * @ctx: Set the type of icache flushing instructions permitted/prohibited in
+ *	 userspace. Supported values described below.
+ *
+ * Supported values for ctx:
+ *
+ * * %PR_RISCV_CTX_SW_FENCEI_ON: Allow fence.i in user space.
+ *
+ * * %PR_RISCV_CTX_SW_FENCEI_OFF: Disallow fence.i in user space. All threads in
+ *   a process will be affected when ``scope == PR_RISCV_SCOPE_PER_PROCESS``.
+ *   Therefore, caution must be taken; use this flag only when you can guarantee
+ *   that no thread in the process will emit fence.i from this point onward.
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
+ * consistent with instruction storage. This does not enforce any guarantees
+ * outside of migration. If a thread modifies an instruction that another thread
+ * may attempt to execute, the other thread must still emit an icache flushing
+ * instruction before attempting to execute the potentially modified
+ * instruction. This must be performed by the user-space program.
+ *
+ * In per-thread context (eg. ``scope == PR_RISCV_SCOPE_PER_THREAD``) only the
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
+		break;
+	case PR_RISCV_CTX_SW_FENCEI_OFF:
+		switch (scope) {
+		case PR_RISCV_SCOPE_PER_PROCESS:
+			current->mm->context.force_icache_flush = false;
+
+			set_icache_stale_mask();
+			break;
+		case PR_RISCV_SCOPE_PER_THREAD:
+			current->thread.force_icache_flush = false;
+
+			set_icache_stale_mask();
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+#else
+	switch (ctx) {
+	case PR_RISCV_CTX_SW_FENCEI_ON:
+	case PR_RISCV_CTX_SW_FENCEI_OFF:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+#endif
+}
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 217fd4de6134..beef30f42d5c 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -15,6 +15,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
+#include <asm/switch_to.h>
 
 #ifdef CONFIG_MMU
 
@@ -297,21 +298,23 @@ static inline void set_mm(struct mm_struct *prev,
  *
  * The "cpu" argument must be the current local CPU number.
  */
-static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu)
+static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu,
+					 struct task_struct *task)
 {
 #ifdef CONFIG_SMP
-	cpumask_t *mask = &mm->context.icache_stale_mask;
-
-	if (cpumask_test_cpu(cpu, mask)) {
-		cpumask_clear_cpu(cpu, mask);
+	if (cpumask_test_and_clear_cpu(cpu, &mm->context.icache_stale_mask)) {
 		/*
 		 * Ensure the remote hart's writes are visible to this hart.
 		 * This pairs with a barrier in flush_icache_mm.
 		 */
 		smp_mb();
-		local_flush_icache_all();
-	}
 
+		/*
+		 * If cache will be flushed in switch_to, no need to flush here.
+		 */
+		if (!(task && switch_to_should_flush_icache(task)))
+			local_flush_icache_all();
+	}
 #endif
 }
 
@@ -332,5 +335,5 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
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
2.43.2



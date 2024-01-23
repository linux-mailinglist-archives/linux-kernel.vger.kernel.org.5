Return-Path: <linux-kernel+bounces-36188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506AE839D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2CC1F24180
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691BC55C37;
	Tue, 23 Jan 2024 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Pt0PsWys"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC855C30
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706052685; cv=none; b=fYIOjM4hIAaLbzBhYZzbm81Lebzt0oPQSChycTjsoXCAqB+1YMxentsfIWRVgwwnMq+tYrU+sswK0S4DIsc5uPR1qMwj3btEvLmRiKlxMERW34HqADzIUMhDoWhBvI02JXF0RFAMHx0+JpTOg05g9q+UdvnqaE8FeSqnohjezsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706052685; c=relaxed/simple;
	bh=TgPJhtuS5elB9x3qkOYRijPzfqXeMZFnxGkigghx8VE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZn37dziNT1CtuJGFvbuZfzQYRfhr02/D354oQmn08wiHk/ZwPGRnH6MW9gYgU76km4sfvJHWXJHHLP/zZV4+6LT7WBv02PItjyKBa5vddmy70oJNzjN5uyHjohRWcfk3GPlpW8pU7zRhKhtHLRLMq1PzSW3+BvlhtjFYCBe72s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Pt0PsWys; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-290449c30d4so2183895a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706052683; x=1706657483; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFBy5Jhev5nWWdDTHxl/l5SJEKa5TSeb5KKT2dQQAj4=;
        b=Pt0PsWysWfHvtNw1HIU/m2ayy3skQtoJaKh63X9d8hkPxrTzwmZel7q5jbDGF+BIax
         nfI8HM6aYyyOsdTAgDz4bYRuBb77mT0OziYUE286NkDLCGIg2Xj5S9e93bqJr1PXLcmh
         NKNfuN3sIHsI9r4RQCJ4P16315VnpRvRS2UwRc70fuWYWHrvvRZIkTPKFSzLz34UeaSJ
         y6bY5ecxQThUiOj64IG5hdqbMSi3Cq+g/Uo9u9eRscdLyftHmJuaIAI602Cx/iAsiZwk
         x4RK4XFi0VSZVYIRIGOnVOgXfnwrcrhVgPu8PLAInFTzd0M0YzDXh5j5LEeL86jWi+JG
         DmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706052683; x=1706657483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFBy5Jhev5nWWdDTHxl/l5SJEKa5TSeb5KKT2dQQAj4=;
        b=C/tsg3Z5xox0DsCLYAqYHPWQnub8CUsBpGC3jjnVrb8elHIooqtnLEQCP41uYse5UN
         64be8hU7zm6EkbK1gMqaw2Pm7c1RtoOpQGey5vrci2u74Pau6WAh3Km5vEnzxwU4B69d
         p6SCthzg66iRJM9VmE6YrEvIi/YjDcu3L5cAtwoBKh7Z/M4vhj7mDMuwb2pHhLC5JeQz
         jRtCGql5NKysOiJaiYLkN0iD4VgWQdzpSsH9iiAmhO6xLDE44nBKnQzIe1tiTT95/IYD
         UAzBJUsGXWZP9AYL3XbyrLVzfZJ8avmW5N56ZHp7Ob47Wuska28rJ+Os0ZPwULnd5VFk
         XpIA==
X-Gm-Message-State: AOJu0YxA/7ZR0yI1T2DwFDZOUa19TfUoAEssML6WOnNnTohYyNOEhW66
	q+rSXMKcU6ZHFzY+NtjOv0tQvlcVY3J13f6K0oi8DQa0N53fQdwwe/dd67/97qEvp5m+j+/i659
	3
X-Google-Smtp-Source: AGHT+IEi37Pa/gG7czUf85R7YXWtq6tKYHXwQ5zNNZ7Tfn61NcbfM5AiSRDOlUtQgCW4kytOLIzsXQ==
X-Received: by 2002:a17:90b:153:b0:28e:8c11:e042 with SMTP id em19-20020a17090b015300b0028e8c11e042mr3142760pjb.56.1706052682945;
        Tue, 23 Jan 2024 15:31:22 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id eu15-20020a17090af94f00b0028d19ddb1afsm12150698pjb.33.2024.01.23.15.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 15:31:22 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 23 Jan 2024 15:29:51 -0800
Subject: [PATCH v9 1/2] riscv: Include riscv_set_icache_flush_ctx prctl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-fencei-v9-1-71411bfe8d71@rivosinc.com>
References: <20240123-fencei-v9-0-71411bfe8d71@rivosinc.com>
In-Reply-To: <20240123-fencei-v9-0-71411bfe8d71@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706052680; l=9638;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=TgPJhtuS5elB9x3qkOYRijPzfqXeMZFnxGkigghx8VE=;
 b=H+VOHsPIUKHl1VzT+mYCChtEjWh5nkPnxepWSSs8XNMkqozEj3RkHTI/IFCW6O/cSWgzrAW2d
 rfDaQBhPCcuBkkcAm/i/+8HxKJM6aBTDA66Dh2ciyvJvLSerQheAyMo
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
 arch/riscv/mm/context.c            | 14 ++++++--
 include/uapi/linux/prctl.h         |  6 ++++
 kernel/sys.c                       |  6 ++++
 7 files changed, 112 insertions(+), 3 deletions(-)

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
index f19f861cda54..1cad05f579ad 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -84,6 +84,10 @@ struct thread_struct {
 	unsigned long vstate_ctrl;
 	struct __riscv_v_ext_state vstate;
 	unsigned long align_ctl;
+#ifdef CONFIG_SMP
+	bool force_icache_flush;
+	unsigned int prev_cpu;
+#endif
 };
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
@@ -145,6 +149,9 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
 #define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
 #define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
 
+#define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)	riscv_set_icache_flush_ctx(arg1, arg2)
+extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index f90d8e42f3c7..72c032d4277e 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -8,6 +8,7 @@
 
 #include <linux/jump_label.h>
 #include <linux/sched/task_stack.h>
+#include <linux/mm_types.h>
 #include <asm/vector.h>
 #include <asm/cpufeature.h>
 #include <asm/processor.h>
@@ -73,6 +74,15 @@ static __always_inline bool has_fpu(void) { return false; }
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
 
+static inline bool switch_to_should_flush_icache(struct task_struct *task)
+{
+	bool stale_mm = task->mm && (task->mm->context.force_icache_flush);
+	bool stale_thread = task->thread.force_icache_flush &&
+			    (smp_processor_id() != task->thread.prev_cpu);
+
+	return stale_mm || stale_thread;
+}
+
 #define switch_to(prev, next, last)			\
 do {							\
 	struct task_struct *__prev = (prev);		\
@@ -81,7 +91,10 @@ do {							\
 		__switch_to_fpu(__prev, __next);	\
 	if (has_vector())					\
 		__switch_to_vector(__prev, __next);	\
+	if (switch_to_should_flush_icache(__next))	\
+		local_flush_icache_all();		\
 	((last) = __switch_to(__prev, __next));		\
+	__next->thread.prev_cpu = smp_processor_id();	\
 } while (0)
 
 #endif /* _ASM_RISCV_SWITCH_TO_H */
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 55a34f2020a8..ff545f19f07a 100644
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
+ * * %PR_RISCV_CTX_SW_FENCEI_OFF: Disallow fence.i in userspace. When ``scope ==
+ *   PR_RISCV_SCOPE_PER_PROCESS``, this will effect all threads in a process.
+ *   Therefore, caution must be taken -- only use this flag when you can
+ *   guarantee that no thread in the process will emit fence.i from this point
+ *   onward.
+ *
+ * @scope: Set scope of where icache flushing instructions are allowed to be
+ *	   emitted. Supported values described below.
+ *
+ * Supported values for scope:
+ *
+ * * PR_RISCV_SCOPE_PER_PROCESS: Ensure the icache of any thread in this process
+ *                               is coherent with instruction storage upon
+ *                               migration.
+ *
+ * * PR_RISCV_SCOPE_PER_THREAD: Ensure the icache of the current thread is
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
index 217fd4de6134..b059dc0fae91 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -15,6 +15,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
+#include <asm/switch_to.h>
 
 #ifdef CONFIG_MMU
 
@@ -297,19 +298,26 @@ static inline void set_mm(struct mm_struct *prev,
  *
  * The "cpu" argument must be the current local CPU number.
  */
-static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu)
+static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu,
+					 struct task_struct *task)
 {
 #ifdef CONFIG_SMP
 	cpumask_t *mask = &mm->context.icache_stale_mask;
 
 	if (cpumask_test_cpu(cpu, mask)) {
 		cpumask_clear_cpu(cpu, mask);
+
 		/*
 		 * Ensure the remote hart's writes are visible to this hart.
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
@@ -332,5 +340,5 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
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
index 420d9cb9cc8e..e806a8a67c36 100644
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
@@ -2739,6 +2742,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
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
2.43.0



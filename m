Return-Path: <linux-kernel+bounces-25120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BFE82C827
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791761F21CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4B91A71B;
	Fri, 12 Jan 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SFOqFyIp"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23B81A5AC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3606e69ec67so45007155ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705103784; x=1705708584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZPrT6/9y7GTRJXEMx1tnKXDzgpl8nPp7oBDsTEm8Wc=;
        b=SFOqFyIpJc08sirFK1gwy7/Qe5fHvOHapnEwh26GPZoHY9pTBUkdZGElXgw7Qo8CLv
         99fB+FdfT9F1Fq03XTM63Go/l6oLCEsAxh/nTdkui92FNfpLM/DEzLrQoMs4TiUnvKpS
         ikPIGqIjzgVaBo4tWuaMWvBGNDKn8EbWCfqmogUygAQ/5U9zSZRREwuVsZn5m4SpMMsa
         QCFMKaicgENFKDXENDiZgJLxUxH+ukDFDQx4u+7WIHWFhbEk+SWRf09P9ItAK5wGqU8+
         Lonk63IH0tPRBWqarLUWGmw6JPLMhgjUuyNpxC3BYo8vUtKjvW4PfRQsJLPFM9XoGQo+
         Fy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705103784; x=1705708584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZPrT6/9y7GTRJXEMx1tnKXDzgpl8nPp7oBDsTEm8Wc=;
        b=YMWfgHS6GZ9D1LYMiCAsUQ5vihbCuAA8IjZfkuJBdPG3c5ifa/GsG60/aeA8mE7dS7
         Z+iOZH2AU/N6fxG2Z9FVrCCv8z8yB1RllPpZ+ON8mM4s2SGny/vMP6N3OlbGB5VwxabS
         kDyDWARcbj3bP+Auxs8lwnA8+ufvM/dt6boPIMoSBCZtTvYz3iRtBkpUpIKgo+jR2NOi
         DLWOyI2uWv0COt8rMU4R8QN44ckBUsDHGfOs5J1sBYy7zd86fPRU2mm2FajBv5QbLEPv
         RvD2PgOwr4pcFxclw2TbVQElNC0n53CfPJ+iZ+90VhsIh38pVTfcTq++lw30H3UDrV+/
         R3vw==
X-Gm-Message-State: AOJu0YyDP1ppcr0dKsD3DZam+37P+baSWqSPPCLqgozFc7BKu/LBYzrw
	ZRhEo8R18jbPVFRwEoZl4VHiU9Y7bqXG/g==
X-Google-Smtp-Source: AGHT+IHdFa0Z2vYPcCoDiJ3LsRWm/16BT/G+otM7tI1aKuDPn6A2GBUo8z6t3tR2U6vN86wYJYEnFQ==
X-Received: by 2002:a92:d642:0:b0:35f:aba9:1031 with SMTP id x2-20020a92d642000000b0035faba91031mr2026091ilp.126.1705103783744;
        Fri, 12 Jan 2024 15:56:23 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id jc14-20020a17090325ce00b001d3b3ac2d7bsm3725537plb.245.2024.01.12.15.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 15:56:23 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 12 Jan 2024 15:56:20 -0800
Subject: [PATCH v7 1/2] riscv: Include riscv_set_icache_flush_ctx prctl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240112-fencei-v7-1-78f0614e1db0@rivosinc.com>
References: <20240112-fencei-v7-0-78f0614e1db0@rivosinc.com>
In-Reply-To: <20240112-fencei-v7-0-78f0614e1db0@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705103781; l=7834;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=IdbTkc3Q5t6sA8vLkrqSjebg3h+Stp0xkerv0GwEwco=;
 b=DFljA3ELwjm7M3ykiqZxlt6bGcQv8rzhZHSg/zi0qtVve1L7ETJZfuIxnYwlcJfFB4Uq9IHgt
 PFfuzrwL+8sDzjWUUZPkqIiowj+kAlIg28wSiK9URyZ6p/IrZR2H/en
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
 arch/riscv/include/asm/processor.h |  6 ++++
 arch/riscv/mm/cacheflush.c         | 67 ++++++++++++++++++++++++++++++++++++++
 arch/riscv/mm/context.c            |  8 +++--
 include/uapi/linux/prctl.h         |  6 ++++
 kernel/sys.c                       |  6 ++++
 6 files changed, 92 insertions(+), 3 deletions(-)

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
index f19f861cda54..7eda6c75e0f2 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -84,6 +84,9 @@ struct thread_struct {
 	unsigned long vstate_ctrl;
 	struct __riscv_v_ext_state vstate;
 	unsigned long align_ctl;
+#ifdef CONFIG_SMP
+	bool force_icache_flush;
+#endif
 };
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
@@ -145,6 +148,9 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
 #define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
 #define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
 
+#define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)	riscv_set_icache_flush_ctx(arg1, arg2)
+extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
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
index 217fd4de6134..0146c61be0ab 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -297,12 +297,14 @@ static inline void set_mm(struct mm_struct *prev,
  *
  * The "cpu" argument must be the current local CPU number.
  */
-static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu)
+static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu,
+					 struct task_struct *task)
 {
 #ifdef CONFIG_SMP
 	cpumask_t *mask = &mm->context.icache_stale_mask;
 
-	if (cpumask_test_cpu(cpu, mask)) {
+	if (cpumask_test_cpu(cpu, mask) || mm->context.force_icache_flush ||
+	    (task && task->thread.force_icache_flush)) {
 		cpumask_clear_cpu(cpu, mask);
 		/*
 		 * Ensure the remote hart's writes are visible to this hart.
@@ -332,5 +334,5 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
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



Return-Path: <linux-kernel+bounces-21272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3361B828CDF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF66B24EFC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A836F3D393;
	Tue,  9 Jan 2024 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wCM5Oe9E"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C653C68E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-204dfd7a89aso1518999fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704825809; x=1705430609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3cjpRu3f6zFWz4uAdg2rrkRvvrYXJuhrMLKUoKpeZs=;
        b=wCM5Oe9ESrXiGwEOMbXsHdnbYUOFOvlyuVkUPtlJmXNlm5GYSIAI1qqLD2lC20f43n
         NNO2S402b/5IKOFDZWLHN0I/qCszOmqQXRGCUu2Q0iFEgA5j1Pna/DTg/ptYeRSOy2At
         im1ekGelPjwbULT5c/s0dC11rle20jEQ6nDMEOtRX5A3/hgnPblaW8oTrfSeJdcRSOSm
         k4xc0aphlGG00TMgg0GEYG6WpKDJwGP261ol+dGLfciAy3aEHJhIcnGRjIRfxZ4cJqWN
         M7kyob6mgCKErZiaRScl9hBuhj07wO5CWkL+quXZ3GkRcl+F/HXXTyXdoNnoGWYntdA2
         2ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704825809; x=1705430609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3cjpRu3f6zFWz4uAdg2rrkRvvrYXJuhrMLKUoKpeZs=;
        b=QzuEfhGvvXkMKrWmpY1uHPT3Z4qe9iFjTyCVTl9puc7QTcHJgFkHpj5aPr8FQvDviu
         5z3QXQSPzD/PJRsMmD9Nrk7B/L+th5DCDhc8Fz8uPlg7oIVtRzy2OVTfAK+oIG+Hn0K+
         4+AXe5MLUR1THT+0qY/7jhUiv8oAfch8tJLlpXZBQynKFYpvnwFifGN4Z0uP20rMGYLo
         2vWryxSlfp0fYbDB7HN1MQoM4PWOcmeJ+SI863JfL0ft7uIZErKe/GLKVUrHaqYY4Boi
         APYehAEvyyQsIHydRGk5LFZBjjgC4g2FPGvxBF2PNq6BXdOL296EYWdHKuTpf7wsGORs
         R3ag==
X-Gm-Message-State: AOJu0YzuYN+xJC+1yMjBq6JHbmW+il97RGO/dxbsLQunWzKqZ6H08cZx
	ViV5CpZTdwZC9pcprL5AofR3+sCqYxt0BA==
X-Google-Smtp-Source: AGHT+IHrDB4IIs7ZxA0Z2AenxMPpG0+0F7QsUHERMVXYyG83tPDIOZuKSGt04ux7GFAVItckjOT4vQ==
X-Received: by 2002:a05:6870:40cf:b0:206:d2a:c042 with SMTP id l15-20020a05687040cf00b002060d2ac042mr539386oal.14.1704825809224;
        Tue, 09 Jan 2024 10:43:29 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j2-20020a9d7682000000b006ce2c31dd9bsm450423otl.20.2024.01.09.10.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:43:28 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 09 Jan 2024 10:43:25 -0800
Subject: [PATCH v6 1/2] riscv: Include riscv_set_icache_flush_ctx prctl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240109-fencei-v6-1-04116e51445c@rivosinc.com>
References: <20240109-fencei-v6-0-04116e51445c@rivosinc.com>
In-Reply-To: <20240109-fencei-v6-0-04116e51445c@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704825806; l=7286;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=TMJhxlQFfyupgZvbn02F0jv2sXrFhaiDb8k1RNetu6U=;
 b=9lGgqCoRZPt9fueeDpMrOQWRVLbrg/AMAOvXBWfG+XzK9uC34gHT5GdZMdrtwG8nVc4IK61Xq
 s6uC+NcVJRzCS8IpMYRbZYm7ZIvVf0syLZhcssA7oKLw+NUBTWj07vE
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
 arch/riscv/mm/cacheflush.c         | 58 ++++++++++++++++++++++++++++++++++++++
 arch/riscv/mm/context.c            |  8 ++++--
 include/uapi/linux/prctl.h         |  4 +++
 kernel/sys.c                       |  6 ++++
 6 files changed, 81 insertions(+), 3 deletions(-)

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
index 55a34f2020a8..bac7737b0f47 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -5,6 +5,7 @@
 
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/prctl.h>
 #include <asm/acpi.h>
 #include <asm/cacheflush.h>
 
@@ -152,3 +153,60 @@ void __init riscv_init_cbo_blocksizes(void)
 	if (cboz_block_size)
 		riscv_cboz_block_size = cboz_block_size;
 }
+
+/**
+ * riscv_set_icache_flush_ctx() - Enable/disable icache flushing instructions in userspace.
+ * @ctx: Set the type of icache flushing instructions permitted/prohibited.
+ *
+ * Supported values for ctx:
+ *
+ * * %PR_RISCV_CTX_SW_FENCEI_ON: Allow fence.i in userspace.
+ *
+ * * %PR_RISCV_CTX_SW_FENCEI_OFF: Disallow fence.i in userspace. When
+ *   ``per_thread == 0``, this will effect all threads in a process. Therefore,
+ *   caution must be taken -- only use this flag when you can guarantee that no
+ *   thread in the process will emit fence.i from this point onward.
+ *
+ * @per_thread: When set to 0, will perform operation on process migration. When
+ *		set to 1, will perform operation on thread migration.
+ *
+ * When ``per_thread == 0``, all threads in the process are permitted to emit
+ * icache flushing instructions. Whenever any thread in the process is migrated,
+ * the corresponding hart's icache will be guaranteed to be consistent with
+ * instruction storage. Note this does not enforce any guarantees outside of
+ * migration. If a thread modifies an instruction that another thread may
+ * attempt to execute, the other thread must still emit an icache flushing
+ * instruction before attempting to execute the potentially modified
+ * instruction. This must be performed by the userspace program.
+ *
+ * In per-thread context (eg. ``per_thread == 1``), only the thread calling this
+ * function is permitted to emit icache flushing instructions. When the thread
+ * is migrated, the corresponding hart's icache will be guaranteed to be
+ * consistent with instruction storage.
+ *
+ * On kernels configured without SMP, this function is a nop as migrations
+ * across harts will not occur.
+ */
+int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread)
+{
+#ifdef CONFIG_SMP
+	switch (ctx) {
+	case PR_RISCV_CTX_SW_FENCEI_ON:
+		if (per_thread)
+			current->thread.force_icache_flush = true;
+		else
+			current->mm->context.force_icache_flush = true;
+		break;
+	case PR_RISCV_CTX_SW_FENCEI_OFF:
+		if (per_thread)
+			current->thread.force_icache_flush = false;
+		else
+			current->mm->context.force_icache_flush = false;
+		break;
+
+	default:
+		break;
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
index 370ed14b1ae0..ec731dda5b8e 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -306,4 +306,8 @@ struct prctl_mm_map {
 # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
 # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
 
+#define PR_RISCV_SET_ICACHE_FLUSH_CTX	71
+# define PR_RISCV_CTX_SW_FENCEI_ON	0
+# define PR_RISCV_CTX_SW_FENCEI_OFF	1
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



Return-Path: <linux-kernel+bounces-25144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5919D82C873
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB251F233CB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A5DF503;
	Sat, 13 Jan 2024 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dbTojp6t"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E7BA5F
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 00:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28cb3bc3fe7so5005087a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705106613; x=1705711413; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4o4pwExuTvBGSqYDWoEY3sdN9C01qfQwRSnwdPuH0Sc=;
        b=dbTojp6tQsSiFzcDBPSge34WgBvJQky88TT2BfLcl2yFqwD2bGbFAuNmOFgnpQXfpU
         wHNDeDf5e4xeAhTohUJlUOw0M/iBRq1NZo0I0OVfrYXD0DMHVp3w7Q7pSfyxxyJWsRdB
         u/3gWWsJrDn18U0IQ/PMLNgLlXVexHqRm7AIC9ucKHGtPzjC993uOJQs7LXcUjDHo9et
         UKE9dqnDMRqXSp0BN/wr+9VDO1avWv55Ye95BCvSA5JbQ1vTX/73QqUJ9Dcz+0bNiv79
         GD6DhaxaAX/M/zKGFstZ7EtSQ65CoZGJjOE2am33AiVDNxhzhBuFNXPUsBm8vI5/o7tO
         WFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705106613; x=1705711413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4o4pwExuTvBGSqYDWoEY3sdN9C01qfQwRSnwdPuH0Sc=;
        b=o62/+B9oIEZLfEHkh2nXTBZme7nHxdsXddW6pX90gx1ur89ycqImvDal4lX32vt2AJ
         zOgXZ8s+PUxMywcFeDb/k6IOOlCnzyNT5knTk00PMLp2TNuiuWMLiwaTJwEM6XHtw8uQ
         iJK49+8sBiYbv36EP+vNwlgku10XIgpnYDeJhUTKbioSRQlQxyJKcK6L8UxuFE/ERqsm
         IaE+Fy5kLedXGiHylMZRgGrpVvzIJVcvghRW6gc5AZP0UL1kTpOyJZPfPcpyOT/61ZGD
         kiJPKHtMno81zf+xZNIX7atwga5bFcHYbpduAYCeV6IrqumbSrV6Ty/dwv7l5WIzjIE6
         MbRg==
X-Gm-Message-State: AOJu0YypvE83F2yKAlarVV8xCIG/bHzIQDrWI0ZrT4mhZNt5ldOgJZPg
	hbzuUqwHfNMDfXNEMqSkb2ivRN8MeI/8+A==
X-Google-Smtp-Source: AGHT+IGSjnPAR/BiHH2B6rOGVBx8JBI2q9Cg3trg2sz/YiNRcwwRparFtcSe+ZvxdO69fM+KIigOaw==
X-Received: by 2002:a17:90b:1c8b:b0:28d:9238:71bf with SMTP id oo11-20020a17090b1c8b00b0028d923871bfmr3414943pjb.18.1705106613486;
        Fri, 12 Jan 2024 16:43:33 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d3-20020a17090b004300b0028ceeca04a1sm4972615pjt.19.2024.01.12.16.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 16:43:32 -0800 (PST)
Date: Fri, 12 Jan 2024 16:43:30 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <apatel@ventanamicro.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: Re: [RFC PATCH v2 2/3] riscv: add support for SBI Supervisor
 Software Events extension
Message-ID: <ZaHcsh40zuoQOq/h@debug.ba.rivosinc.com>
References: <20240112111720.2975069-1-cleger@rivosinc.com>
 <20240112111720.2975069-3-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240112111720.2975069-3-cleger@rivosinc.com>

On Fri, Jan 12, 2024 at 12:17:14PM +0100, Clément Léger wrote:
>The SBI SSE extension allows the supervisor software to be notified by
>the SBI of specific events that are not maskable. The context switch is
>handled partially by the firmware which will save registers a0, a6, a7.
>When entering kernel we can rely on these 3 registers to setup the stack
>and save all the registers.
>
>Since each events (and each CPU for local events) have their own
>context and can preempt each other, allocate a stack for each of them
>(and for each cpu for local events).
>
>When completing the event, if we were coming from kernel with interrupts
>disabled, simply return there. If coming from userspace or kernel with
>interrupts enabled, simulate an interrupt exception to allow delivery of
>signal to user task. For instance this can happen, when a RAS event has
>been generated and a SIGBUS has been sent to a task.
>
>Signed-off-by: Clément Léger <cleger@rivosinc.com>
>---
> arch/riscv/include/asm/asm-prototypes.h |   4 +
> arch/riscv/include/asm/asm.h            |  42 +-
> arch/riscv/include/asm/scs.h            |   7 +
> arch/riscv/include/asm/sse.h            |  12 +
> arch/riscv/include/asm/thread_info.h    |   1 +
> arch/riscv/kernel/Makefile              |   1 +
> arch/riscv/kernel/asm-offsets.c         |  26 ++
> arch/riscv/kernel/entry.S               | 202 +++++++++
> arch/riscv/kernel/sse.c                 | 130 ++++++
> arch/riscv/kernel/stacktrace.c          |  13 +
> arch/riscv/kernel/vmlinux.lds.S         |   6 +
> drivers/firmware/Kconfig                |  10 +
> drivers/firmware/Makefile               |   1 +
> drivers/firmware/riscv_sse.c            | 567 ++++++++++++++++++++++++
> include/linux/riscv_sse.h               |  76 ++++
> 15 files changed, 1089 insertions(+), 9 deletions(-)
> create mode 100644 arch/riscv/include/asm/sse.h
> create mode 100644 arch/riscv/kernel/sse.c
> create mode 100644 drivers/firmware/riscv_sse.c
> create mode 100644 include/linux/riscv_sse.h
>
>diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
>index 36b955c762ba..d163912166d4 100644
>--- a/arch/riscv/include/asm/asm-prototypes.h
>+++ b/arch/riscv/include/asm/asm-prototypes.h
>@@ -3,6 +3,8 @@
> #define _ASM_RISCV_PROTOTYPES_H
>
> #include <linux/ftrace.h>
>+#include <linux/riscv_sse.h>
>+#include <asm/sse.h>
> #include <asm-generic/asm-prototypes.h>
>
> long long __lshrti3(long long a, int b);
>@@ -28,5 +30,7 @@ DECLARE_DO_ERROR_INFO(do_trap_break);
> asmlinkage void handle_bad_stack(struct pt_regs *regs);
> asmlinkage void do_page_fault(struct pt_regs *regs);
> asmlinkage void do_irq(struct pt_regs *regs);
>+asmlinkage void do_sse(struct sse_registered_event *reg_evt,
>+				struct pt_regs *reg);
>
> #endif /* _ASM_RISCV_PROTOTYPES_H */
>diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
>index b0487b39e674..b5cdd791fc26 100644
>--- a/arch/riscv/include/asm/asm.h
>+++ b/arch/riscv/include/asm/asm.h
>@@ -123,20 +123,16 @@
> .endm
> #endif /* CONFIG_SHADOW_CALL_STACK */
>
>-	/* save all GPs except x1 ~ x5 */
>-	.macro save_from_x6_to_x31
>+	.macro save_x6_to_x31_except_x10_x16_x17
> 	REG_S x6,  PT_T1(sp)
> 	REG_S x7,  PT_T2(sp)
> 	REG_S x8,  PT_S0(sp)
> 	REG_S x9,  PT_S1(sp)
>-	REG_S x10, PT_A0(sp)
> 	REG_S x11, PT_A1(sp)
> 	REG_S x12, PT_A2(sp)
> 	REG_S x13, PT_A3(sp)
> 	REG_S x14, PT_A4(sp)
> 	REG_S x15, PT_A5(sp)
>-	REG_S x16, PT_A6(sp)
>-	REG_S x17, PT_A7(sp)
> 	REG_S x18, PT_S2(sp)
> 	REG_S x19, PT_S3(sp)
> 	REG_S x20, PT_S4(sp)
>@@ -153,20 +149,33 @@
> 	REG_S x31, PT_T6(sp)
> 	.endm
>
>+	/* save all GPs except x1 ~ x5 */
>+	.macro save_from_x6_to_x31
>+	save_x6_to_x31_except_x10_x16_x17
>+	REG_S x10, PT_A0(sp)
>+	REG_S x16, PT_A6(sp)
>+	REG_S x17, PT_A7(sp)
>+	.endm
>+
>+	.macro save_regs_for_sse
>+	save_x6_to_x31_except_x10_x16_x17
>+	REG_S ra,  PT_RA(sp)
>+	REG_S gp,  PT_GP(sp)
>+	REG_S tp,  PT_TP(sp)
>+	REG_S t0,  PT_T0(sp)
>+	.endm
>+
> 	/* restore all GPs except x1 ~ x5 */
>-	.macro restore_from_x6_to_x31
>+	.macro restore_from_x6_to_x31_except_x10_x16_x17
> 	REG_L x6,  PT_T1(sp)
> 	REG_L x7,  PT_T2(sp)
> 	REG_L x8,  PT_S0(sp)
> 	REG_L x9,  PT_S1(sp)
>-	REG_L x10, PT_A0(sp)
> 	REG_L x11, PT_A1(sp)
> 	REG_L x12, PT_A2(sp)
> 	REG_L x13, PT_A3(sp)
> 	REG_L x14, PT_A4(sp)
> 	REG_L x15, PT_A5(sp)
>-	REG_L x16, PT_A6(sp)
>-	REG_L x17, PT_A7(sp)
> 	REG_L x18, PT_S2(sp)
> 	REG_L x19, PT_S3(sp)
> 	REG_L x20, PT_S4(sp)
>@@ -183,6 +192,21 @@
> 	REG_L x31, PT_T6(sp)
> 	.endm
>
>+	.macro restore_from_x6_to_x31
>+	restore_from_x6_to_x31_except_x10_x16_x17
>+	REG_L x10, PT_A0(sp)
>+	REG_L x16, PT_A6(sp)
>+	REG_L x17, PT_A7(sp)
>+	.endm
>+
>+	.macro restore_regs_for_sse
>+	restore_from_x6_to_x31_except_x10_x16_x17
>+	REG_L ra,  PT_RA(sp)
>+	REG_L gp,  PT_GP(sp)
>+	REG_L tp,  PT_TP(sp)
>+	REG_L t0,  PT_T0(sp)
>+	.endm
>+
> #endif /* __ASSEMBLY__ */
>
> #endif /* _ASM_RISCV_ASM_H */
>diff --git a/arch/riscv/include/asm/scs.h b/arch/riscv/include/asm/scs.h
>index 0e45db78b24b..62344daad73d 100644
>--- a/arch/riscv/include/asm/scs.h
>+++ b/arch/riscv/include/asm/scs.h
>@@ -18,6 +18,11 @@
> 	load_per_cpu gp, irq_shadow_call_stack_ptr, \tmp
> .endm
>
>+/* Load the per-CPU IRQ shadow call stack to gp. */
>+.macro scs_load_sse_stack reg_evt
>+	REG_L gp, SSE_REG_EVT_SHADOW_STACK(\reg_evt)
>+.endm
>+
> /* Load task_scs_sp(current) to gp. */
> .macro scs_load_current
> 	REG_L	gp, TASK_TI_SCS_SP(tp)
>@@ -41,6 +46,8 @@
> .endm
> .macro scs_load_irq_stack tmp
> .endm
>+.macro scs_load_sse_stack reg_evt
>+.endm
> .macro scs_load_current
> .endm
> .macro scs_load_current_if_task_changed prev
>diff --git a/arch/riscv/include/asm/sse.h b/arch/riscv/include/asm/sse.h
>new file mode 100644
>index 000000000000..7f8e6f09085c
>--- /dev/null
>+++ b/arch/riscv/include/asm/sse.h
>@@ -0,0 +1,12 @@
>+/* SPDX-License-Identifier: GPL-2.0-only */
>+/*
>+ * Copyright (C) 2023 Rivos Inc.
>+ */
>+#ifndef __ASM_SSE_H
>+#define __ASM_SSE_H
>+
>+struct sse_registered_event;
>+int sse_init_event(int cpu, struct sse_registered_event *reg_evt);
>+void sse_free_event(struct sse_registered_event *reg_evt);
>+
>+#endif
>diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>index 574779900bfb..90f357dc5bf3 100644
>--- a/arch/riscv/include/asm/thread_info.h
>+++ b/arch/riscv/include/asm/thread_info.h
>@@ -31,6 +31,7 @@
> #define SHADOW_OVERFLOW_STACK_SIZE (1024)
>
> #define IRQ_STACK_SIZE		THREAD_SIZE
>+#define SSE_STACK_SIZE		THREAD_SIZE
>
> #ifndef __ASSEMBLY__
>
>diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>index fee22a3d1b53..a2febdc1618b 100644
>--- a/arch/riscv/kernel/Makefile
>+++ b/arch/riscv/kernel/Makefile
>@@ -80,6 +80,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
> obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
> obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
> obj-$(CONFIG_RISCV_SBI)		+= sbi.o
>+obj-$(CONFIG_RISCV_SSE)		+= sse.o
> ifeq ($(CONFIG_RISCV_SBI), y)
> obj-$(CONFIG_SMP)		+= sbi-ipi.o
> obj-$(CONFIG_SMP) += cpu_ops_sbi.o
>diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
>index a03129f40c46..eee99c0fbd27 100644
>--- a/arch/riscv/kernel/asm-offsets.c
>+++ b/arch/riscv/kernel/asm-offsets.c
>@@ -10,12 +10,16 @@
> #include <linux/mm.h>
> #include <linux/sched.h>
> #include <linux/suspend.h>
>+#include <linux/riscv_sse.h>
> #include <asm/kvm_host.h>
> #include <asm/thread_info.h>
> #include <asm/ptrace.h>
> #include <asm/cpu_ops_sbi.h>
> #include <asm/stacktrace.h>
>+#include <asm/sbi.h>
>+#include <asm/sse.h>
> #include <asm/suspend.h>
>+#include <asm/stacktrace.h>
>
> void asm_offsets(void);
>
>@@ -488,4 +492,26 @@ void asm_offsets(void)
> 	DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe), STACK_ALIGN));
> 	OFFSET(STACKFRAME_FP, stackframe, fp);
> 	OFFSET(STACKFRAME_RA, stackframe, ra);
>+
>+#ifdef CONFIG_RISCV_SSE
>+	OFFSET(SSE_REG_EVT_STACK, sse_registered_event, stack);
>+	OFFSET(SSE_REG_EVT_SHADOW_STACK, sse_registered_event, shadow_stack);
>+	OFFSET(SSE_REG_EVT_EVT_ID, sse_registered_event, evt_id);
>+	OFFSET(SSE_REG_EVT_STATE, sse_registered_event, state);
>+	OFFSET(SSE_REG_EVT_STATE_PHYS, sse_registered_event, state_phys);
>+	OFFSET(SSE_REG_EVT_STATE_MODE, sse_registered_event, state.mode);
>+	OFFSET(SSE_REG_EVT_STATE_PC, sse_registered_event, state.pc);
>+	OFFSET(SSE_REG_EVT_STATE_A0, sse_registered_event, state.a0);
>+	OFFSET(SSE_REG_EVT_STATE_A6, sse_registered_event, state.a6);
>+	OFFSET(SSE_REG_EVT_STATE_A7, sse_registered_event, state.a7);
>+
>+	DEFINE(SBI_EXT_SSE, SBI_EXT_SSE);
>+	DEFINE(SBI_SSE_EVENT_COMPLETE, SBI_SSE_EVENT_COMPLETE);
>+	DEFINE(SBI_SSE_EVENT_ATTR_READ, SBI_SSE_EVENT_ATTR_READ);


>+	DEFINE(SBI_SSE_ATTR_INTERRUPTED_MODE, SBI_SSE_ATTR_INTERRUPTED_MODE);
>+	DEFINE(SBI_SSE_ATTR_INTERRUPTED_SIZE, SBI_SSE_ATTR_INTERRUPTED_A7 -
>+					      SBI_SSE_ATTR_INTERRUPTED_MODE);
>+#endif
>+
>+	DEFINE(ASM_PAGE_OFFSET, CONFIG_PAGE_OFFSET);
> }
>diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>index 54ca4564a926..c9046c59e06c 100644
>--- a/arch/riscv/kernel/entry.S
>+++ b/arch/riscv/kernel/entry.S
>@@ -19,17 +19,49 @@
>
> 	.section .irqentry.text, "ax"
>
>+#ifdef CONFIG_RISCV_SSE
>+#define IN_TP			0
>+#define IN_SSCRATCH		1
>+#define PRV_U_TASK_LOC(loc)	(loc << 0)
>+#define PRV_S_TASK_LOC(loc)	(loc << 1)
>+#define TASK_LOC(s_loc, u_loc)	(PRV_U_TASK_LOC(u_loc) | PRV_S_TASK_LOC(s_loc))
>+#define TASK_LOC_ENTRY_SIZE	(RISCV_SZPTR + 1)
>+
>+/* __SSE_TASK_LOC - Annotate e'xception code with the location of current task
>+ *		    struct when coming from S/U mode
>+ *
>+ * When entering handle_exception(), the current task struct is located either
>+ * in tp or sscratch depending on interrupted mode. Since SSE handlers can be
>+ * triggered at any time during the execution of the kernel, we need to be able
>+ * to retrieve the current task struct even if in handle_exception. This macro
>+ * create an entry into the __task_loc section that holds the location of
>+ * the current task struct for the subsequent assembly located after that up to
>+ * .Lret_from_exception_end or the next __TASK_LOC.
>+ */
>+#define __SSE_TASK_LOC(s_loc, u_loc)			\
>+	.pushsection __task_loc,"a";	\
>+	RISCV_PTR 99f;				\
>+	.byte TASK_LOC(s_loc, u_loc);		\
>+	.popsection;				\
>+	99:
>+#else
>+#define __SSE_TASK_LOC(s_loc, u_loc)
>+#endif
>+
> SYM_CODE_START(handle_exception)
> 	/*
> 	 * If coming from userspace, preserve the user thread pointer and load
> 	 * the kernel thread pointer.  If we came from the kernel, the scratch
> 	 * register will contain 0, and we should continue on the current TP.
> 	 */
>+__SSE_TASK_LOC(IN_TP, IN_SSCRATCH)
> 	csrrw tp, CSR_SCRATCH, tp
>+__SSE_TASK_LOC(IN_SSCRATCH, IN_TP)
> 	bnez tp, .Lsave_context
>
> .Lrestore_kernel_tpsp:
> 	csrr tp, CSR_SCRATCH
>+__SSE_TASK_LOC(IN_TP, IN_TP)
> 	REG_S sp, TASK_TI_KERNEL_SP(tp)
>
> #ifdef CONFIG_VMAP_STACK
>@@ -160,6 +192,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
> 	REG_SC x0, a2, PT_EPC(sp)
>
> 	csrw CSR_STATUS, a0
>+__SSE_TASK_LOC(IN_TP, IN_SSCRATCH)
> 	csrw CSR_EPC, a2
>
> 	REG_L x1,  PT_RA(sp)
>@@ -175,6 +208,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
> #else
> 	sret
> #endif
>+.Lret_from_exception_end:
> SYM_CODE_END(ret_from_exception)
>
> #ifdef CONFIG_VMAP_STACK
>@@ -262,6 +296,171 @@ SYM_FUNC_START(call_on_irq_stack)
> SYM_FUNC_END(call_on_irq_stack)
> #endif /* CONFIG_IRQ_STACKS */
>
>+#ifdef CONFIG_RISCV_SSE
>+
>+/* When entering handle_sse, the following registers are set:
>+ * a0: contains struct sse_registered_event pointer.
>+ *
>+ * See sse_entry_init().
>+ */
>+SYM_CODE_START(handle_sse)
>+	/* Save stack temporarily */
>+	move a7, sp
>+	/* Set entry stack */
>+	REG_L sp, SSE_REG_EVT_STACK(a0)
>+	li a6, IRQ_STACK_SIZE

SSE_STACK_SIZE ?

>+	add sp, sp, a6
>+
>+	addi sp, sp, -(PT_SIZE_ON_STACK)
>+	REG_S a7,  PT_SP(sp)
>+	save_regs_for_sse
>+
>+	load_global_pointer
>+	scs_load_sse_stack a0
>+
>+	REG_L s3, SSE_REG_EVT_EVT_ID(a0)
>+	/* a0 is clobbered by sbi calls return, save it for later (reg_event)*/
>+	move s2, a0
>+	/* event id */
>+	move a0, s3
>+	/* base_attr_id */
>+	li a1, SBI_SSE_ATTR_INTERRUPTED_MODE
>+	/* attr_count */
>+	li a2, SBI_SSE_ATTR_INTERRUPTED_SIZE
>+	/* phys_lo */
>+	REG_L a3, SSE_REG_EVT_STATE_PHYS(s2)
>+	/* phys_hi */
>+	move a4, zero
>+	li a7, SBI_EXT_SSE
>+	li a6, SBI_SSE_EVENT_ATTR_READ

Doesn't this interface allow kernel to perform writes to any physical location
using sbi as proxy? or sbi fw will perform some sort of whitelisting and actually
will write to physical location belonging to kernel and will exclude physical
memory location belonging to opensbi firmware. If it doesn't then using this interface
kernel can use sbi fw as a proxy to perform some controlled writes in fw memory.
Let me know if my understanding is incorrect here.

>+	ecall
>+
>+	REG_L t2, SSE_REG_EVT_STATE_MODE(s2)
>+
>+	/*
>+	 * Depending on where the sse event interrupted the kernel execution,
>+	 * sscratch content might be 0 or not even if kernel was interrupted.
>+	 * This might happen if the sse event was triggered while in
>+	 * handle_exception() right after entry. In that case, sscratch might
>+	 * contain 0 if coming from kernel. In order to handle that easily,
>+	 * simply save sscratch content and restore it when returning from sse
>+	 * event.
>+	 */
>+	csrr s4, CSR_SSCRATCH
>+	/*
>+	 * Save CAUSE and TVAL in case of nested exceptions, EPC/STATUS are
>+	 * already saved/restored by handle_exception() for nested exceptions.
>+	 */
>+	csrr a2, CSR_SCAUSE
>+	csrr a3, CSR_STVAL
>+	REG_S a2, PT_CAUSE(sp)
>+	REG_S a3, PT_BADADDR(sp)
>+	andi s5, t2, 0x1
>+
>+	move a0, s2 /* reg_evt for do_sse() */
>+	move a1, sp /* pt_regs for do_sse() */
>+
>+	/* Userspace was interrupted, simply restore TP from scratch */
>+	bnez s5, .Lsse_from_kernel
>+	/* Set tp to point to sscratch content */
>+	move tp, s4
>+	j .Lcall_do_sse
>+
>+.Lsse_from_kernel:
>+	REG_L t0, SSE_REG_EVT_STATE_PC(s2)
>+#ifdef CONFIG_FRAME_POINTER
>+	/*
>+	 * Else, kernel was interrupted and we will create a correct stack frame
>+	 * from interrupted context.
>+	 */
>+	addi sp, sp, -STACKFRAME_SIZE_ON_STACK
>+	REG_S s0, STACKFRAME_FP(sp)
>+	REG_S t0, STACKFRAME_RA(sp)
>+	addi s0, sp, STACKFRAME_SIZE_ON_STACK
>+#endif
>+
>+	/*
>+	 * If interrupting the kernel during exception handling
>+	 * (see handle_exception), then, we might have tp either in SSCRATCH or
>+	 * in tp, this part is non regular and requires some more work to
>+	 * determine were is located the current task.
>+	 */
>+	la t1, handle_exception
>+	la t2, .Lret_from_exception_end

Since SSE events are nested, is below possible ?

Event 1 happened when `handle_exception` < PC < `ret_from_exception` and `tp = 0`
`handle_see` is called and this code hasn't reached a point of obtaining correct `tp`
Firmware is triggered again on this or another hart.
Firmware decides to inject another event on this hart (either global or local) i.e. Event 2

Now `handle_sse` for Event 2 will think I am good because PC is outside the range of `handle_exception`
and `ret_from_exception`. And go ahead and call `do_sse` which will lead to crash eventually.


>+	bltu t0, t1, .Lcall_do_sse
>+	bltu t0, t2, .Lsse_exception_slow_path
>+
>+.Lcall_do_sse:
>+	/* In-kernel scratch is 0 */
>+	csrw CSR_SCRATCH, x0
>+	la ra, ret_from_sse
>+	tail do_sse
>+
>+.global ret_from_sse
>+ret_from_sse:
>+	/* Restore saved CSRs */
>+	csrw CSR_SSCRATCH, s4
>+	/* Preserve event_id before restoring registers */
>+	move a6, s3
>+
>+#ifdef CONFIG_FRAME_POINTER
>+	/* Frame pointer is created only when kernel is interrupted */
>+	beqz s5, .Lret_from_sse_to_user
>+	addi sp, sp, STACKFRAME_SIZE_ON_STACK
>+.Lret_from_sse_to_user:
>+#endif
>+
>+	REG_L a2, PT_CAUSE(sp)
>+	REG_L a3, PT_BADADDR(sp)
>+	csrw CSR_SCAUSE, a2
>+	csrw CSR_STVAL, a3
>+
>+	restore_regs_for_sse
>+	REG_L sp,  PT_SP(sp)
>+
>+	/* prepare ecall with event_id */
>+	move a0, a6
>+	li a7, SBI_EXT_SSE
>+	li a6, SBI_SSE_EVENT_COMPLETE
>+	ecall
>+
>+/*
>+ * t0 contains interrupted pc
>+ * When called, t0 must be in [handle_exception, .Lret_from_exception_end[
>+ */
>+.Lsse_exception_slow_path:
>+	la t3, __stop___task_loc
>+	add t3, t3, -TASK_LOC_ENTRY_SIZE
>+	la t4, __start___task_loc
>+	/*
>+	 * Reverse iterate the task location section to find where is located
>+	 * the task struct
>+	 */
>+1:
>+	REG_L	t2, 0(t3)
>+	bgeu t0, t2, 2f
>+	add t3, t3, -TASK_LOC_ENTRY_SIZE
>+	bgeu t3, t4, 1b
>+
>+2:
>+	lbu t2, RISCV_SZPTR(t3)
>+
>+	/* Get the value of SR_SPP */
>+	csrr t1, CSR_SSTATUS
>+	andi t1, t1, SR_SPP
>+	snez t1, t1
>+
>+	srl t2, t2, t1
>+	andi t2, t2, 1
>+	beqz t2, .Lcall_do_sse
>+
>+_restore_tp_from_sscratch:
>+	csrr tp, CSR_SCRATCH
>+	j .Lcall_do_sse
>+
>+SYM_CODE_END(handle_sse)
>+#endif
>+
> /*
>  * Integer register context switch
>  * The callee-saved registers must be saved and restored.
>@@ -348,3 +547,6 @@ SYM_DATA_START(__user_rt_sigreturn)
> 	ecall
> SYM_DATA_END(__user_rt_sigreturn)
> #endif
>+
>+sse_panic_string:
>+    .ascii "SSE TP is invalid, last state %px"
Is this string used somewhere? I don't see it in this commit.

>diff --git a/arch/riscv/kernel/sse.c b/arch/riscv/kernel/sse.c
>new file mode 100644
>index 000000000000..a1b27d122644
>--- /dev/null
>+++ b/arch/riscv/kernel/sse.c
>@@ -0,0 +1,130 @@
>+// SPDX-License-Identifier: GPL-2.0-or-later
>+/*
>+ * Copyright (C) 2023 Rivos Inc.
>+ */
>+#include <linux/nmi.h>
>+#include <linux/scs.h>
>+#include <linux/bitfield.h>
>+#include <linux/riscv_sse.h>
>+
>+#include <asm/asm-prototypes.h>
>+#include <asm/irq_stack.h>
>+#include <asm/sbi.h>
>+#include <asm/sse.h>
>+
>+#define SSE_PRIVILEGE_MODE_BIT			BIT(0)
>+#define SSE_SPIE_BIT				BIT(2)
>+
>+#define sse_privilege_mode(exec_mode)	FIELD_GET(SSE_PRIVILEGE_MODE_BIT, exec_mode)
>+#define sse_spie(exec_mode)		FIELD_GET(SSE_SPIE_BIT, exec_mode)
>+
>+struct sse_registered_event;
>+
>+extern asmlinkage void handle_sse(void);
>+
>+void do_sse(struct sse_registered_event *reg_evt, struct pt_regs *regs)
>+{
>+	unsigned long exec_mode;
>+
>+	nmi_enter();
>+
>+	/*
>+	 * To avoid handling that in assembly, we retrieved the state but we did
>+	 * not fully stored in it pt_regs.
>+	 */
>+	regs->a0 = reg_evt->state.a0;
>+	regs->a6 = reg_evt->state.a6;
>+	regs->a7 = reg_evt->state.a7;
>+	regs->epc = reg_evt->state.pc;
>+
>+	exec_mode = reg_evt->state.mode;
>+	regs->status = FIELD_PREP(SR_SPP, sse_privilege_mode(exec_mode));
>+	regs->status |= FIELD_PREP(SR_SPIE, sse_spie(exec_mode));
>+
>+	sse_handle_event(reg_evt, regs);
>+
>+	/* The SSE delivery path does not uses the "standard" exception path and
>+	 * thus does not process any pending signal/softirqs. Some drivers might
>+	 * enqueue pending work that needs to be handled as soon as possible.
>+	 * For that purpose, set the software interrupt pending bit
>+	 */
>+	csr_set(CSR_IP, IE_SIE);
>+
>+	nmi_exit();
>+}
>+
>+#ifdef CONFIG_VMAP_STACK
>+unsigned long *sse_stack_alloc(unsigned int cpu, unsigned int size)
>+{
>+	return arch_alloc_vmap_stack(size, cpu_to_node(cpu));
>+}
>+
>+void sse_stack_free(unsigned long *stack)
>+{
>+	vfree(stack);
>+}
>+#else /* CONFIG_VMAP_STACK */
>+
>+unsigned long *sse_stack_alloc(unsigned int cpu, unsigned int size)
>+{
>+	return kmalloc(size, GFP_KERNEL);
>+}
>+
>+void sse_stack_free(unsigned long *stack)
>+{
>+	kfree(stack);
>+}
>+
>+#endif /* CONFIG_VMAP_STACK */
>+
>+static int sse_init_scs(int cpu, struct sse_registered_event *reg_evt)
>+{
>+	void *stack;
>+
>+	if (!scs_is_enabled())
>+		return 0;
>+
>+	stack = scs_alloc(cpu_to_node(cpu));
>+	if (!stack)
>+		return 1;
>+
>+	reg_evt->shadow_stack = stack;
>+
>+	return 0;
>+}
>+
>+int sse_init_event(int cpu, struct sse_registered_event *reg_evt)
>+{
>+	void *stack;
>+
>+	stack = sse_stack_alloc(cpu, SSE_STACK_SIZE);
>+	if (!stack)
>+		return -ENOMEM;
>+
>+	reg_evt->stack = stack;
>+
>+	if (sse_init_scs(cpu, reg_evt))
>+		goto free_stack;
>+
>+	reg_evt->state.pc = (unsigned long)handle_sse;
>+	reg_evt->state.a0 = (unsigned long)reg_evt;
>+
>+	return 0;
>+
>+free_stack:
>+	sse_stack_free(reg_evt->stack);
>+
>+	return -ENOMEM;
>+}
>+
>+void sse_free_event(struct sse_registered_event *reg_evt)
>+{
>+	scs_free(reg_evt->shadow_stack);
>+	sse_stack_free(reg_evt->stack);
>+}
>+
>+void sse_entry_init(struct sse_registered_event *reg_evt)
>+{
>+	reg_evt->state.pc = (unsigned long)handle_sse;
>+	reg_evt->state.a0 = (unsigned long)reg_evt;
>+}
>diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
>index 64a9c093aef9..a3d08792e3b5 100644
>--- a/arch/riscv/kernel/stacktrace.c
>+++ b/arch/riscv/kernel/stacktrace.c
>@@ -17,6 +17,7 @@
> #ifdef CONFIG_FRAME_POINTER
>
> extern asmlinkage void ret_from_exception(void);
>+extern asmlinkage void ret_from_sse(void);
>
> void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
> 			     bool (*fn)(void *, unsigned long), void *arg)
>@@ -68,6 +69,18 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>
> 				pc = ((struct pt_regs *)sp)->epc;
> 				fp = ((struct pt_regs *)sp)->s0;
>+			} else if (pc == (unsigned long)ret_from_sse) {
>+				if (unlikely(!fn(arg, pc)))
>+					break;
>+				/* We don't have pt_regs when handling SSE
>+				 * events but we build a custom stackframe,
>+				 * moreover, the stack changes across boundaries
>+				 * so update it to avoid failing the checks above
>+				 */
>+				frame = (struct stackframe *)fp - 1;
>+				fp = frame->fp;
>+				pc = frame->ra;
>+				sp = fp - sizeof(struct stackframe);
> 			}
> 		}
>
>diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
>index 492dd4b8f3d6..f7e9cde2e832 100644
>--- a/arch/riscv/kernel/vmlinux.lds.S
>+++ b/arch/riscv/kernel/vmlinux.lds.S
>@@ -120,6 +120,12 @@ SECTIONS
> 	/* Start of data section */
> 	_sdata = .;
> 	RO_DATA(SECTION_ALIGN)
>+
>+#ifdef CONFIG_RISCV_SSE
>+	__task_loc : {
>+		BOUNDED_SECTION_BY(__task_loc, ___task_loc)
>+	}
>+#endif
> 	.srodata : {
> 		*(.srodata*)
> 	}
>diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>index 4a98a859d44d..ccd066b46d33 100644
>--- a/drivers/firmware/Kconfig
>+++ b/drivers/firmware/Kconfig
>@@ -188,6 +188,16 @@ config MTK_ADSP_IPC
> 	  ADSP exists on some mtk processors.
> 	  Client might use shared memory to exchange information with ADSP.
>
>+config RISCV_SSE
>+	bool
>+	depends on RISCV_SBI
>+	default y
>+	help
>+	  The Supervisor Software Events support allow the SBI to deliver
>+	  NMI-like notifications to the supervisor mode software. When enable,
>+	  this option provides support to register callbacks on specific SSE
>+	  events.
>+
> config SYSFB
> 	bool
> 	select BOOT_VESA_SUPPORT
>diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
>index 5f9dab82e1a0..127b6440823e 100644
>--- a/drivers/firmware/Makefile
>+++ b/drivers/firmware/Makefile
>@@ -17,6 +17,7 @@ obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
> obj-$(CONFIG_MTK_ADSP_IPC)	+= mtk-adsp-ipc.o
> obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
> obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
>+obj-$(CONFIG_RISCV_SSE)		+= riscv_sse.o
> obj-$(CONFIG_SYSFB)		+= sysfb.o
> obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
> obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
>diff --git a/drivers/firmware/riscv_sse.c b/drivers/firmware/riscv_sse.c
>new file mode 100644
>index 000000000000..45d7064a1b62
>--- /dev/null
>+++ b/drivers/firmware/riscv_sse.c
>@@ -0,0 +1,567 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/*
>+ * Copyright (C) 2023 Rivos Inc.
>+ */
>+
>+#define pr_fmt(fmt) "sse: " fmt
>+
>+#include <linux/cpu.h>
>+#include <linux/cpuhotplug.h>
>+#include <linux/hardirq.h>
>+#include <linux/list.h>
>+#include <linux/percpu-defs.h>
>+#include <linux/riscv_sse.h>
>+#include <linux/slab.h>
>+
>+#include <asm/sbi.h>
>+#include <asm/sse.h>
>+
>+struct sse_event {
>+	struct list_head list;
>+	u32 evt;
>+	u32 priority;
>+	unsigned int cpu;
>+	sse_event_handler *handler;
>+	void *handler_arg;
>+	bool is_enabled;
>+
>+	union {
>+		struct sse_registered_event *global;
>+		struct sse_registered_event __percpu *local;
>+	};
>+};
>+
>+static bool sse_available;
>+static DEFINE_SPINLOCK(events_list_lock);
>+static LIST_HEAD(events);
>+static DEFINE_MUTEX(sse_mutex);
>+
>+void sse_handle_event(struct sse_registered_event *reg_evt, struct pt_regs *regs)
>+{
>+	int ret;
>+	struct sse_event *evt = reg_evt->evt;
>+
>+	ret = evt->handler(evt->evt, evt->handler_arg, regs);
>+	if (ret)
>+		pr_warn("event %x handler failed with error %d\n", reg_evt->evt_id, ret);
>+}
>+
>+static bool sse_event_is_global(u32 evt)
>+{
>+	return !!(evt & SBI_SSE_EVENT_GLOBAL);
>+}
>+
>+static
>+struct sse_event *sse_event_get(u32 evt)
>+{
>+	struct sse_event *sse_evt = NULL, *tmp;
>+
>+	spin_lock(&events_list_lock);
>+	list_for_each_entry(tmp, &events, list) {
>+		if (tmp->evt == evt) {
>+			sse_evt = tmp;
>+			break;
>+		}
>+	}
>+	spin_unlock(&events_list_lock);
>+
>+	return sse_evt;
>+}
>+
>+static phys_addr_t sse_event_get_phys(struct sse_registered_event *reg_evt, void *addr)
>+{
>+	phys_addr_t phys;
>+
>+	if (sse_event_is_global(reg_evt->evt_id))
>+		phys = virt_to_phys(addr);
>+	else
>+		phys = per_cpu_ptr_to_phys(addr);
>+
>+	return phys;
>+}
>+
>+static int sse_event_attr_set_nolock(struct sse_registered_event *reg_evt,
>+				     unsigned long attr_id, unsigned long val)
>+{
>+	struct sbiret sret;
>+	u32 evt = reg_evt->evt_id;
>+	unsigned long phys;
>+
>+	reg_evt->attr_buf = val;
>+	phys = sse_event_get_phys(reg_evt, &reg_evt->attr_buf);
>+
>+	sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_WRITE, evt,
>+				     attr_id, 1, phys, 0, 0);
>+	if (sret.error && sret.error != SBI_ERR_BUSY) {
>+		pr_err("Failed to set event %x hart id, error %ld\n", evt,
>+			sret.error);
>+		return sbi_err_map_linux_errno(sret.error);
>+	}
>+
>+	return 0;
>+}
>+
>+static int sse_event_set_target_cpu_nolock(struct sse_event *event,
>+					   unsigned int cpu)
>+{
>+	unsigned int hart_id = cpuid_to_hartid_map(cpu);
>+	u32 evt = event->evt;
>+	int ret;
>+
>+	if (!sse_event_is_global(evt))
>+		return -EINVAL;
>+
>+	do {
>+		ret = sse_event_attr_set_nolock(event->global,
>+						SBI_SSE_ATTR_PREFERRED_HART,
>+						hart_id);
>+	} while (ret == -EBUSY);
>+
>+	event->cpu = cpu;
>+
>+	return 0;
>+}
>+
>+int sse_event_set_target_cpu(struct sse_event *event, unsigned int cpu)
>+{
>+	int ret;
>+
>+	mutex_lock(&sse_mutex);
>+	ret = sse_event_set_target_cpu_nolock(event, cpu);
>+	mutex_unlock(&sse_mutex);
>+
>+	return ret;
>+}
>+
>+static int sse_event_init_registered(unsigned int cpu,
>+				     struct sse_registered_event *reg_evt,
>+				     struct sse_event *event)
>+{
>+	reg_evt->evt_id = event->evt;
>+	reg_evt->evt = event;
>+	reg_evt->state_phys = sse_event_get_phys(reg_evt, &reg_evt->state);
>+
>+	sse_init_event(cpu, reg_evt);
>+
>+	return 0;
>+}
>+
>+static void sse_event_free_registered(struct sse_registered_event *reg_evt)
>+{
>+	sse_free_event(reg_evt);
>+}
>+
>+static int sse_event_alloc_global(struct sse_event *event)
>+{
>+	int err;
>+	struct sse_registered_event *reg_evt;
>+
>+	reg_evt = kzalloc(sizeof(*reg_evt), GFP_KERNEL);
>+	if (!reg_evt)
>+		return -ENOMEM;
>+
>+	event->global = reg_evt;
>+	err = sse_event_init_registered(smp_processor_id(), reg_evt,
>+					event);
>+	if (err)
>+		kfree(reg_evt);
>+
>+	return err;
>+}
>+
>+static int sse_event_alloc_local(struct sse_event *event)
>+{
>+	int err;
>+	unsigned int cpu, err_cpu;
>+	struct sse_registered_event *reg_evt;
>+	struct sse_registered_event __percpu *reg_evts;
>+
>+	reg_evts = alloc_percpu(struct sse_registered_event);
>+	if (!reg_evts)
>+		return -ENOMEM;
>+
>+	event->local = reg_evts;
>+
>+	for_each_possible_cpu(cpu) {
>+		reg_evt = per_cpu_ptr(reg_evts, cpu);
>+		err = sse_event_init_registered(cpu, reg_evt, event);
>+		if (err) {
>+			err_cpu = cpu;
>+			goto err_free_per_cpu;
>+		}
>+	}
>+
>+	return 0;
>+
>+err_free_per_cpu:
>+	for_each_possible_cpu(cpu) {
>+		if (cpu == err_cpu)
>+			break;
>+		reg_evt = per_cpu_ptr(reg_evts, cpu);
>+		sse_event_free_registered(reg_evt);
>+	}
>+
>+	free_percpu(reg_evts);
>+
>+	return err;
>+}
>+
>+static struct sse_event *sse_event_alloc(u32 evt,
>+					 u32 priority,
>+					 sse_event_handler *handler, void *arg)
>+{
>+	int err;
>+	struct sse_event *event;
>+
>+	event = kzalloc(sizeof(*event), GFP_KERNEL);
>+	if (!event)
>+		return ERR_PTR(-ENOMEM);
>+
>+	event->evt = evt;
>+	event->priority = priority;
>+	event->handler_arg = arg;
>+	event->handler = handler;
>+
>+	if (sse_event_is_global(evt)) {
>+		err = sse_event_alloc_global(event);
>+		if (err)
>+			goto err_alloc_reg_evt;
>+	} else {
>+		err = sse_event_alloc_local(event);
>+		if (err)
>+			goto err_alloc_reg_evt;
>+	}
>+
>+	return event;
>+
>+err_alloc_reg_evt:
>+	kfree(event);
>+
>+	return ERR_PTR(err);
>+}
>+
>+static int sse_sbi_register_event(struct sse_event *event,
>+				  struct sse_registered_event *reg_evt)
>+{
>+	int ret;
>+	struct sbiret sret;
>+	u32 evt = event->evt;
>+
>+	ret = sse_event_attr_set_nolock(reg_evt, SBI_SSE_ATTR_PRIO,
>+					     event->priority);
>+	if (ret)
>+		return ret;
>+
>+	sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_REGISTER, evt, reg_evt->state.pc,
>+			    reg_evt->state.a0, reg_evt->state.a6,
>+			    reg_evt->state.a7, 0);
>+	if (sret.error)
>+		pr_err("Failed to register event %d, error %ld\n", evt,
>+		       sret.error);
>+
>+	return sbi_err_map_linux_errno(sret.error);
>+}
>+
>+static int sse_sbi_event_func(struct sse_event *event, unsigned long func)
>+{
>+	struct sbiret ret;
>+	u32 evt = event->evt;
>+
>+	ret = sbi_ecall(SBI_EXT_SSE, func, evt, 0, 0, 0, 0, 0);
>+	if (ret.error)
>+		pr_err("Failed to execute func %lx, event %d, error %ld\n", func,
>+		       evt, ret.error);
>+
>+	return sbi_err_map_linux_errno(ret.error);
>+}
>+
>+static int sse_event_register_local(struct sse_event *event)
>+{
>+	int ret;
>+	struct sse_registered_event *reg_evt = per_cpu_ptr(event->local,
>+							   smp_processor_id());
>+
>+	ret = sse_sbi_register_event(event, reg_evt);
>+	if (ret)
>+		pr_err("Failed to register event %x: err %d\n", event->evt,
>+		       ret);
>+
>+	return ret;
>+}
>+
>+static int sse_sbi_disable_event(struct sse_event *event)
>+{
>+	return sse_sbi_event_func(event, SBI_SSE_EVENT_DISABLE);
>+}
>+
>+static int sse_sbi_enable_event(struct sse_event *event)
>+{
>+	return sse_sbi_event_func(event, SBI_SSE_EVENT_ENABLE);
>+}
>+
>+static int sse_sbi_unregister_event(struct sse_event *event)
>+{
>+	return sse_sbi_event_func(event, SBI_SSE_EVENT_UNREGISTER);
>+}
>+
>+struct sse_per_cpu_evt {
>+	struct sse_event *event;
>+	unsigned long func;
>+	int error;
>+};
>+
>+static void sse_event_per_cpu_func(void *info)
>+{
>+	int ret;
>+	struct sse_per_cpu_evt *cpu_evt = info;
>+
>+	if (cpu_evt->func == SBI_SSE_EVENT_REGISTER)
>+		ret = sse_event_register_local(cpu_evt->event);
>+	else
>+		ret = sse_sbi_event_func(cpu_evt->event, cpu_evt->func);
>+
>+	if (ret)
>+		WRITE_ONCE(cpu_evt->error, 1);
>+}
>+
>+static void sse_event_free(struct sse_event *event)
>+{
>+	unsigned int cpu;
>+	struct sse_registered_event *reg_evt;
>+
>+	if (sse_event_is_global(event->evt)) {
>+		sse_event_free_registered(event->global);
>+		kfree(event->global);
>+	} else {
>+		for_each_possible_cpu(cpu) {
>+			reg_evt = per_cpu_ptr(event->local, cpu);
>+			sse_event_free_registered(reg_evt);
>+		}
>+		free_percpu(event->local);
>+	}
>+
>+	kfree(event);
>+}
>+
>+int sse_event_enable(struct sse_event *event)
>+{
>+	int ret = 0;
>+	struct sse_per_cpu_evt cpu_evt;
>+
>+	mutex_lock(&sse_mutex);
>+
>+	cpus_read_lock();
>+	if (sse_event_is_global(event->evt)) {
>+		/* Global events can only be unregister from target hart */
>+		ret = sse_event_set_target_cpu_nolock(event, smp_processor_id());
>+		if (ret)
>+			goto out;
>+
>+		ret = sse_sbi_enable_event(event);
>+		if (ret)
>+			goto out;
>+
>+	} else {
>+		cpu_evt.event = event;
>+		cpu_evt.error = 0;
>+		cpu_evt.func = SBI_SSE_EVENT_ENABLE;
>+		on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
>+		if (READ_ONCE(cpu_evt.error)) {
>+			cpu_evt.func = SBI_SSE_EVENT_DISABLE;
>+			on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
>+			goto out;
>+		}
>+	}
>+	event->is_enabled = true;
>+	cpus_read_unlock();
>+out:
>+	mutex_unlock(&sse_mutex);
>+
>+	return ret;
>+}
>+
>+void sse_event_disable(struct sse_event *event)
>+{
>+	struct sse_per_cpu_evt cpu_evt;
>+
>+	mutex_lock(&sse_mutex);
>+
>+	cpus_read_lock();
>+	if (sse_event_is_global(event->evt)) {
>+		sse_sbi_disable_event(event);
>+	} else {
>+		cpu_evt.event = event;
>+		cpu_evt.func = SBI_SSE_EVENT_DISABLE;
>+		on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
>+	}
>+	event->is_enabled = false;
>+	cpus_read_unlock();
>+
>+	mutex_unlock(&sse_mutex);
>+}
>+
>+struct sse_event *sse_event_register(u32 evt, u32 priority,
>+				     sse_event_handler *handler, void *arg)
>+{
>+	struct sse_per_cpu_evt cpu_evt;
>+	struct sse_event *event;
>+	int ret = 0;
>+
>+	if (!sse_available)
>+		return ERR_PTR(-EOPNOTSUPP);
>+
>+	mutex_lock(&sse_mutex);
>+	if (sse_event_get(evt)) {
>+		pr_err("Event %x already registered\n", evt);
>+		ret = -EEXIST;
>+		goto out_unlock;
>+	}
>+
>+	event = sse_event_alloc(evt, priority, handler, arg);
>+	if (IS_ERR(event)) {
>+		ret = PTR_ERR(event);
>+		goto out_unlock;
>+	}
>+
>+	cpus_read_lock();
>+	if (sse_event_is_global(evt)) {
>+		/* SSE spec mandates that the CPU registering the global event be the
>+		 * one set as the target hart, plus we don't know initial value
>+		 */
>+		ret = sse_event_set_target_cpu_nolock(event, smp_processor_id());
>+		if (ret)
>+			goto err_event_free;
>+
>+		ret = sse_sbi_register_event(event, event->global);
>+		if (ret)
>+			goto err_event_free;
>+
>+	} else {
>+		cpu_evt.event = event;
>+		cpu_evt.error = 0;
>+		cpu_evt.func = SBI_SSE_EVENT_REGISTER;
>+		on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
>+		if (READ_ONCE(cpu_evt.error)) {
>+			cpu_evt.func = SBI_SSE_EVENT_UNREGISTER;
>+			on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
>+			goto err_event_free;
>+		}
>+	}
>+	cpus_read_unlock();
>+
>+	spin_lock(&events_list_lock);
>+	list_add(&event->list, &events);
>+	spin_unlock(&events_list_lock);
>+
>+	mutex_unlock(&sse_mutex);
>+
>+	return event;
>+
>+err_event_free:
>+	cpus_read_unlock();
>+	sse_event_free(event);
>+out_unlock:
>+	mutex_unlock(&sse_mutex);
>+
>+	return ERR_PTR(ret);
>+}
>+
>+void sse_event_unregister(struct sse_event *event)
>+{
>+	int ret;
>+	struct sse_per_cpu_evt cpu_evt;
>+
>+	if (!sse_available)
>+		return;
>+
>+	mutex_lock(&sse_mutex);
>+
>+	if (sse_event_is_global(event->evt)) {
>+		/* Global events can only be unregister from target hart */
>+		ret = sse_event_set_target_cpu_nolock(event, smp_processor_id());
>+		WARN_ON(ret);
>+		sse_sbi_unregister_event(event);
>+	} else {
>+		cpu_evt.event = event;
>+		cpu_evt.func = SBI_SSE_EVENT_UNREGISTER;
>+		on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
>+	}
>+
>+	spin_lock(&events_list_lock);
>+	list_del(&event->list);
>+	spin_unlock(&events_list_lock);
>+
>+	sse_event_free(event);
>+
>+	mutex_unlock(&sse_mutex);
>+}
>+
>+static int sse_cpu_online(unsigned int cpu)
>+{
>+	struct sse_event *sse_evt;
>+
>+	spin_lock(&events_list_lock);
>+	list_for_each_entry(sse_evt, &events, list) {
>+		if (sse_event_is_global(sse_evt->evt))
>+			continue;
>+
>+		sse_event_register_local(sse_evt);
>+		if (sse_evt->is_enabled)
>+			sse_sbi_enable_event(sse_evt);
>+	}
>+
>+	spin_unlock(&events_list_lock);
>+
>+	return 0;
>+}
>+
>+static int sse_cpu_teardown(unsigned int cpu)
>+{
>+	unsigned int next_cpu;
>+	struct sse_event *sse_evt;
>+
>+	spin_lock(&events_list_lock);
>+	list_for_each_entry(sse_evt, &events, list) {
>+		if (!sse_event_is_global(sse_evt->evt)) {
>+
>+			if (sse_evt->is_enabled)
>+				sse_sbi_disable_event(sse_evt);
>+			sse_sbi_unregister_event(sse_evt);
>+			continue;
>+		}
>+
>+		if (sse_evt->cpu != smp_processor_id())
>+			continue;
>+
>+		/* Update destination hart for global event */
>+		next_cpu = cpumask_any_but(cpu_online_mask, cpu);
>+		sse_event_set_target_cpu(sse_evt, next_cpu);
>+	}
>+	spin_unlock(&events_list_lock);
>+
>+	return 0;
>+}
>+
>+static int __init sse_init(void)
>+{
>+	int cpu, ret;
>+
>+	if (sbi_probe_extension(SBI_EXT_SSE) <= 0) {
>+		pr_err("Missing SBI SSE extension\n");
>+		return -EOPNOTSUPP;
>+	}
>+	pr_info("SBI SSE extension detected\n");
>+
>+	for_each_possible_cpu(cpu)
>+		INIT_LIST_HEAD(&events);
>+
>+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv/sse:online",
>+					sse_cpu_online, sse_cpu_teardown);
>+	if (ret < 0)
>+		return ret;
>+
>+	sse_available = true;
>+
>+	return 0;
>+}
>+device_initcall(sse_init);
>diff --git a/include/linux/riscv_sse.h b/include/linux/riscv_sse.h
>new file mode 100644
>index 000000000000..58357441ce5b
>--- /dev/null
>+++ b/include/linux/riscv_sse.h
>@@ -0,0 +1,76 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+/*
>+ * Copyright (C) 2023 Rivos Inc.
>+ */
>+
>+#ifndef __LINUX_RISCV_SSE_H
>+#define __LINUX_RISCV_SSE_H
>+
>+#include <linux/types.h>
>+#include <linux/linkage.h>
>+
>+struct sse_event;
>+struct pt_regs;
>+
>+typedef int (sse_event_handler)(u32 event_num, void *arg, struct pt_regs *regs);
>+
>+#ifdef CONFIG_RISCV_SSE
>+
>+struct sse_event_state {
>+	unsigned long mode;
>+	unsigned long pc;
>+	unsigned long a0;
>+	unsigned long a6;
>+	unsigned long a7;
>+};
>+
>+struct sse_registered_event {
>+	struct sse_event_state state;
>+	unsigned long state_phys;
>+	void *stack;
>+	void *shadow_stack;
>+	unsigned long attr_buf;
>+	u32 evt_id;
>+	struct sse_event *evt;
>+};
>+
>+void sse_handle_event(struct sse_registered_event *reg_evt,
>+			       struct pt_regs *regs);
>+
>+struct sse_event *sse_event_register(u32 event_num, u32 priority,
>+				     sse_event_handler *handler, void *arg);
>+
>+void sse_event_unregister(struct sse_event *evt);
>+
>+int sse_event_set_target_cpu(struct sse_event *sse_evt, unsigned int cpu);
>+
>+int sse_event_enable(struct sse_event *sse_evt);
>+
>+void sse_event_disable(struct sse_event *sse_evt);
>+
>+#else
>+static inline int sse_event_register(struct sse_event *evt, u32 priority,
>+				     sse_event_handler *handler, void *arg)
>+{
>+	return -EOPNOTSUPP;
>+}
>+
>+static inline void sse_event_unregister(struct sse_event *evt) {}
>+
>+static inline int sse_event_set_target_cpu(struct sse_event *sse_evt,
>+					   unsigned int cpu)
>+{
>+	return -EOPNOTSUPP;
>+}
>+
>+static inline int sse_event_enable(struct sse_event *sse_evt)
>+{
>+	return -EOPNOTSUPP;
>+}
>+
>+static inline void sse_event_disable(struct sse_event *sse_evt) {}
>+
>+
>+#endif
>+
>+#endif /* __LINUX_RISCV_SSE_H */
>-- 
>2.43.0
>
>


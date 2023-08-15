Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0CE77D433
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbjHOUfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238060AbjHOUe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:34:56 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D109FF7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:34:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-586bd766310so59362797b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692131694; x=1692736494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N3ibQG9kPTeaqq1uk119WhHtvGpC05ARPoe95r4WB3Q=;
        b=ii3NiBwjW2S4FrV7yjM64htaZ/K+xMTAe8C3FjqVBGt9E6qnK9LrJmBelNkdwUPq0S
         /u8xXLY/b2D0v9G+ODd2yoH2w0MBi7+xjG488iodmtTpyqSxuJWj17X4fZWhEmWIX+fR
         wjELHT7fOZ01fKMWI8/otfmtTHXgHB8Fq+wgPvPcWxYFNX4dnVbEX57BoPyZuUGCDZWR
         1O51jehCVbCgc9APBR35NAd6nxRB0SailOkfeWnWCnEHaQWkyZhKxC/zwlFuL/DZOHhC
         N3u254/fONTgoNDkrUS6Iwkbg/W8KeV4athdOLQ3LmKxCTJeJrUnNXykkj6KSDMpHum5
         ICCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692131694; x=1692736494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3ibQG9kPTeaqq1uk119WhHtvGpC05ARPoe95r4WB3Q=;
        b=FbKQ6CVbhVqKNZzToHBzZDwbxMePT0T+rhS0MEdaWX6PWq8kCAS94soZK4cH9Ypdk4
         BrZBV/ErxAS695OsC1+TTSWLSVcN5aPgBjfDaKgne4O0kPZe7ow2Rcdd/7fMkrzMlZjl
         v2ESBvHM9djiDghK/HgKBVBTAsbcq78Is/LDmlg913iGFl1+4q0FT5xNArDK+/cCO5G4
         5mB9P5hs7EimK9tEFsKqMhNiRKFz9wK4gSSkkPyWKujtidFArkC7H5Gvw0NVCqFcmF+w
         PSns8a996JIpfQSvDZinXFTe0jQs/SOW5pbjHM3hRoIXWr52L7nPQ1b6yZG+HuYghiiZ
         9rcQ==
X-Gm-Message-State: AOJu0YyrewIfyjA6gABu4myFl6qpx4Co3EzHZvA+o1xnCAUQym3yiAtd
        K9flrf+pddeeSYxo8blK+h6WgKpM55v/FPqHsfU=
X-Google-Smtp-Source: AGHT+IFOBtAfOTGqgJAn+DcvcJUfpiueeWWzkqYoVx3UNQD79ntr/Mc1j91DYQQN2fSTiPkbFkjokwMeqbqG2PDHuNw=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a81:b60d:0:b0:58c:6ddd:d27c with SMTP
 id u13-20020a81b60d000000b0058c6dddd27cmr5856ywh.6.1692131694123; Tue, 15 Aug
 2023 13:34:54 -0700 (PDT)
Date:   Tue, 15 Aug 2023 20:34:47 +0000
In-Reply-To: <20230815203442.1608773-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230815203442.1608773-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=9645; i=samitolvanen@google.com;
 h=from:subject; bh=e0JAEbcNV8QaCejgu3nDKo0gvZQXOTr0vBP/0yqZP/Q=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBk2+FiTMC3KO4Q7y58NU00sySutTm4Un6tjcRZM
 NE+DfEzpYyJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZNvhYgAKCRBMtfaEi7xW
 7omFDACbtMcHmBN0cplT0k67u1z6qmmA2zIU82etEYjowZNjt2dLorEXMhCUCsSGBB+WOfE8wdK
 T1Ic5tQpvOODjDM1gAr0DzGeI4zHBtdL35iFmGDHe/K4JAihBOPM9ukDaPBywSyWMp7PwOT3R3E
 dpTpGqVyZCAz+ggnRAItZlj9hr1xlBPwi0Lgga40mOUDi0A83mhYPFar290fiu3bHBFHSkWWkEZ
 bE/cB9jlBzaDLK9fE7B2um3TvkudWYaCpimIbKNJhDGBrBr3Zk98tW4+jHe4VIu7SUc3i5JJcc7
 jqK/+9Tl8CLtFl1lHwAqYHCz9esWAPVyWQtAQtyZd+bd8ZK+JUa5QpEso9V+8vl+/ntd8bl+5Te
 faYUB+jUrc5PH2ROCiBNrQYem3x8ezSXhtS6j5xHs0YoGWCQWNZFA2NqtOeZNDejk/2TFYbLSPl y7/WihDsjDhucR7Td+gZSUJ0WSB288e8icuCoB2C7SfPlj7zn6m7ktq/naHzMqTDS4c2c=
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815203442.1608773-12-samitolvanen@google.com>
Subject: [PATCH v2 4/6] riscv: Implement Shadow Call Stack
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Guo Ren <guoren@kernel.org>, Deepak Gupta <debug@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement CONFIG_SHADOW_CALL_STACK for RISC-V. When enabled, the
compiler injects instructions to all non-leaf C functions to
store the return address to the shadow stack and unconditionally
load it again before returning, which makes it harder to corrupt
the return address through a stack overflow, for example.

The active shadow call stack pointer is stored in the gp
register, which makes SCS incompatible with gp relaxation. Use
--no-relax-gp to ensure gp relaxation is disabled and disable
global pointer loading.  Add SCS pointers to struct thread_info,
implement SCS initialization, and task switching

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/riscv/Kconfig                   |  6 ++++
 arch/riscv/Makefile                  |  4 +++
 arch/riscv/include/asm/asm.h         |  6 ++++
 arch/riscv/include/asm/scs.h         | 47 ++++++++++++++++++++++++++++
 arch/riscv/include/asm/thread_info.h | 13 ++++++++
 arch/riscv/kernel/asm-offsets.c      |  3 ++
 arch/riscv/kernel/entry.S            | 11 +++++++
 arch/riscv/kernel/head.S             |  4 +++
 arch/riscv/kernel/vdso/Makefile      |  2 +-
 arch/riscv/purgatory/Makefile        |  4 +++
 10 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/scs.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4c07b9189c86..8fe31ec59da4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -46,6 +46,7 @@ config RISCV
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
 	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
+	select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
@@ -169,6 +170,11 @@ config GCC_SUPPORTS_DYNAMIC_FTRACE
 	def_bool CC_IS_GCC
 	depends on $(cc-option,-fpatchable-function-entry=8)
 
+config HAVE_SHADOW_CALL_STACK
+	def_bool $(cc-option,-fsanitize=shadow-call-stack)
+	# https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a484e843e6eeb51f0cb7b8819e50da6d2444d769
+	depends on $(ld-option,--no-relax-gp)
+
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
 	default 8
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 6ec6d52a4180..e518a74640fb 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -55,6 +55,10 @@ endif
 endif
 endif
 
+ifeq ($(CONFIG_SHADOW_CALL_STACK),y)
+	KBUILD_LDFLAGS += --no-relax-gp
+endif
+
 # ISA string setting
 riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
 riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index f34dd1a526a1..b0487b39e674 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -109,6 +109,11 @@
 	REG_L \dst, 0(\dst)
 .endm
 
+#ifdef CONFIG_SHADOW_CALL_STACK
+/* gp is used as the shadow call stack pointer instead */
+.macro load_global_pointer
+.endm
+#else
 /* load __global_pointer to gp */
 .macro load_global_pointer
 .option push
@@ -116,6 +121,7 @@
 	la gp, __global_pointer$
 .option pop
 .endm
+#endif /* CONFIG_SHADOW_CALL_STACK */
 
 	/* save all GPs except x1 ~ x5 */
 	.macro save_from_x6_to_x31
diff --git a/arch/riscv/include/asm/scs.h b/arch/riscv/include/asm/scs.h
new file mode 100644
index 000000000000..94726ea773e3
--- /dev/null
+++ b/arch/riscv/include/asm/scs.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_SCS_H
+#define _ASM_SCS_H
+
+#ifdef __ASSEMBLY__
+#include <asm/asm-offsets.h>
+
+#ifdef CONFIG_SHADOW_CALL_STACK
+
+/* Load init_shadow_call_stack to gp. */
+.macro scs_load_init_stack
+	la	gp, init_shadow_call_stack
+	XIP_FIXUP_OFFSET gp
+.endm
+
+/* Load task_scs_sp(current) to gp. */
+.macro scs_load_current
+	REG_L	gp, TASK_TI_SCS_SP(tp)
+.endm
+
+/* Load task_scs_sp(current) to gp, but only if tp has changed. */
+.macro scs_load_current_if_task_changed prev
+	beq	\prev, tp, _skip_scs
+	scs_load_current
+_skip_scs:
+.endm
+
+/* Save gp to task_scs_sp(current). */
+.macro scs_save_current
+	REG_S	gp, TASK_TI_SCS_SP(tp)
+.endm
+
+#else /* CONFIG_SHADOW_CALL_STACK */
+
+.macro scs_load_init_stack
+.endm
+.macro scs_load_current
+.endm
+.macro scs_load_current_if_task_changed prev
+.endm
+.macro scs_save_current
+.endm
+
+#endif /* CONFIG_SHADOW_CALL_STACK */
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_SCS_H */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index d18ce0113ca1..574779900bfb 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -57,8 +57,20 @@ struct thread_info {
 	long			user_sp;	/* User stack pointer */
 	int			cpu;
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
+#ifdef CONFIG_SHADOW_CALL_STACK
+	void			*scs_base;
+	void			*scs_sp;
+#endif
 };
 
+#ifdef CONFIG_SHADOW_CALL_STACK
+#define INIT_SCS							\
+	.scs_base	= init_shadow_call_stack,			\
+	.scs_sp		= init_shadow_call_stack,
+#else
+#define INIT_SCS
+#endif
+
 /*
  * macros/functions for gaining access to the thread information structure
  *
@@ -68,6 +80,7 @@ struct thread_info {
 {						\
 	.flags		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
+	INIT_SCS				\
 }
 
 void arch_release_task_struct(struct task_struct *tsk);
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 9f535d5de33f..177cef43a2ee 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -38,6 +38,9 @@ void asm_offsets(void)
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
+#ifdef CONFIG_SHADOW_CALL_STACK
+	OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
+#endif
 
 	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 2b4248c6b0a9..ad34507d3c96 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -9,6 +9,7 @@
 
 #include <asm/asm.h>
 #include <asm/csr.h>
+#include <asm/scs.h>
 #include <asm/unistd.h>
 #include <asm/page.h>
 #include <asm/thread_info.h>
@@ -77,6 +78,9 @@ _save_context:
 	/* Load the global pointer */
 	load_global_pointer
 
+	/* Load the kernel shadow call stack pointer if coming from userspace */
+	scs_load_current_if_task_changed s5
+
 	move a0, sp /* pt_regs */
 	la ra, ret_from_exception
 
@@ -123,6 +127,9 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	addi s0, sp, PT_SIZE_ON_STACK
 	REG_S s0, TASK_TI_KERNEL_SP(tp)
 
+	/* Save the kernel shadow call stack pointer */
+	scs_save_current
+
 	/*
 	 * Save TP into the scratch register , so we can find the kernel data
 	 * structures again.
@@ -277,6 +284,8 @@ SYM_FUNC_START(__switch_to)
 	REG_S s9,  TASK_THREAD_S9_RA(a3)
 	REG_S s10, TASK_THREAD_S10_RA(a3)
 	REG_S s11, TASK_THREAD_S11_RA(a3)
+	/* Save the kernel shadow call stack pointer */
+	scs_save_current
 	/* Restore context from next->thread */
 	REG_L ra,  TASK_THREAD_RA_RA(a4)
 	REG_L sp,  TASK_THREAD_SP_RA(a4)
@@ -294,6 +303,8 @@ SYM_FUNC_START(__switch_to)
 	REG_L s11, TASK_THREAD_S11_RA(a4)
 	/* The offset of thread_info in task_struct is zero. */
 	move tp, a1
+	/* Switch to the next shadow call stack */
+	scs_load_current
 	ret
 SYM_FUNC_END(__switch_to)
 
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 79b5a863c782..c3d0ee77483b 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -14,6 +14,7 @@
 #include <asm/cpu_ops_sbi.h>
 #include <asm/hwcap.h>
 #include <asm/image.h>
+#include <asm/scs.h>
 #include <asm/xip_fixup.h>
 #include "efi-header.S"
 
@@ -153,6 +154,7 @@ secondary_start_sbi:
 	XIP_FIXUP_OFFSET a3
 	add a3, a3, a1
 	REG_L sp, (a3)
+	scs_load_current
 
 .Lsecondary_start_common:
 
@@ -293,6 +295,7 @@ clear_bss_done:
 	la sp, init_thread_union + THREAD_SIZE
 	XIP_FIXUP_OFFSET sp
 	addi sp, sp, -PT_SIZE_ON_STACK
+	scs_load_init_stack
 #ifdef CONFIG_BUILTIN_DTB
 	la a0, __dtb_start
 	XIP_FIXUP_OFFSET a0
@@ -311,6 +314,7 @@ clear_bss_done:
 	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	addi sp, sp, -PT_SIZE_ON_STACK
+	scs_load_init_stack
 
 #ifdef CONFIG_KASAN
 	call kasan_early_init
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 6b1dba11bf6d..48c362c0cb3d 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -36,7 +36,7 @@ CPPFLAGS_vdso.lds += -DHAS_VGETTIMEOFDAY
 endif
 
 # Disable -pg to prevent insert call site
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
 
 # Disable profiling and instrumentation for VDSO code
 GCOV_PROFILE := n
diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index dc20e166983e..d5d60c040560 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -77,6 +77,10 @@ ifdef CONFIG_STACKPROTECTOR_STRONG
 PURGATORY_CFLAGS_REMOVE		+= -fstack-protector-strong
 endif
 
+ifdef CONFIG_SHADOW_CALL_STACK
+PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_SCS)
+endif
+
 CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
 
-- 
2.41.0.694.ge786442a9b-goog


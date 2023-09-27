Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6907B0F13
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjI0WsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjI0WsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:48:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09D512A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:48:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f4c72c66fso200565567b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695854889; x=1696459689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UjogArc4Ol2Tu2wVu5HYhWlgdLzR2HyaaCEJTIGL1ME=;
        b=h7/RsBSUmj32JdZ+FogGrCwfCTHK7mwnykUORGQAmK687LXWOXzDTdBjmf8MQ5qql4
         rwI7ee2EdEmvgPaq6DmsADOdzrdizV+K5Tq3Fso4CDavjq/q/HwTWbfZuHnXKtLEEsQf
         iEoTBp0kh7tOPUDnJmKbviBvwc38d7OuDhwplRxOPmI/J/wD4posYBTsuF2IdqlIv4oJ
         9cKzSDGmgMixnPPLlULHOn/bE2c4Sg4Gcg+DCrVA2X0ywm1UwmB2np1TacbkvlRWfq/g
         1Hux3+s6HWQosuRFzCepqtOPSUi57Wu7+TJAFqPaGGvI9JotYBFdpwzILPMrEIVxvNvi
         Gp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695854889; x=1696459689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjogArc4Ol2Tu2wVu5HYhWlgdLzR2HyaaCEJTIGL1ME=;
        b=mi2Ew7kpAvHem7mtkwoolt4OO7L9WH5VAg18gb/acmW4pxeNHj2+rNJawRO8H6WIZp
         WGzWCz3StpWzA/vKuOSPfI4n2PaoP2ZYytFvgdMwDM5rJt933vEB3wbpgd+fMovVlB/Z
         LSybeSTshyL5ApgaQwFidsIgcCxKsbGhMeC/2/e6WtM/rU6hhzXkePt3cFiXrPcwMt/N
         LGMzKkNjaPTji9E3UCPffAfFibeaxDQ1mK39U9mNgD5SkxSZmbntQKBKy9yqlrc+136u
         pVr9oMlcerSampDTwwoTV7+HMJcCpbfNZyMFpC7l3rRCdUNOZ6YTvzcVc7Y5LXzJM3zM
         znDQ==
X-Gm-Message-State: AOJu0YzoJWvnzQSXcaxej6y03LmcLHfNwEayes6OaMl9WxCQLVnc/Cf8
        NKxamWDlgx+nPbJ5IfHJ7WCI1/OZfDOidJyOiTc=
X-Google-Smtp-Source: AGHT+IGuLzBBzEnk//HcBoJ99TCQ7ov8zQaT/zHqVxs9oyov7vsbiXFCeQcHtqa+bclScLfUtyRWNFqZfXid3mMRvZU=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a25:4dc6:0:b0:d81:90b6:cedc with SMTP
 id a189-20020a254dc6000000b00d8190b6cedcmr45254ybb.3.1695854888882; Wed, 27
 Sep 2023 15:48:08 -0700 (PDT)
Date:   Wed, 27 Sep 2023 22:48:02 +0000
In-Reply-To: <20230927224757.1154247-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230927224757.1154247-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=9659; i=samitolvanen@google.com;
 h=from:subject; bh=yw/kz6qVoLV9/zzAHdEXeH4UXswKqFcfKUE7jb2zKUk=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBlFLEds/VsrP50aF0lwBOaJwOiBeaGJNlMIHWXo
 wP23QvFjeiJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZRSxHQAKCRBMtfaEi7xW
 7sGeC/sFu6YRgLELFq8ildZNtq5ri2wh4h9UBxspPil3xG3H36TktsRnR9jN1ccehLwGW+wBlWq
 nEKL3mAp8N18Y3rQoaCpUi2cfT9TfKf6DbmtAxsvvfeeg9UhSXlolr3XwtwX2+roATGNZeYhoNE
 59CEcqS8CxiObRZZqPmtFyGqMvWYxfK/Zbxmq56jjGdAKy9SWmzDJRGEakAlg9AQSf4s0AIkvAN
 2TLqF2dHl2q/DW0omjsRQdE/peSPZwhwitfGh4VTcSsH5EudR+R50jDNp3cGdyfmwMIAzTdlK0C
 dTI3uGWf9zkVd9xPvT6AGpAynfAdv2Txrha2bEG8WY191seBtnjWuQDgn0ggno6kdGe0P3PGGp1
 wucGs64jnPo+i3opdERML+XpfWhjwSNgCVtbEStQJkrA9O7o2hbuC/cfGEBryOpOjYhfv9FLRNc Bj8DSGKv+cCvmY+ULbeW3oo1Mv1nSvvJM0B2V/fUWIGMhzWmylMvB0Md8n1zzQoGzfuvQ=
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230927224757.1154247-12-samitolvanen@google.com>
Subject: [PATCH v4 4/6] riscv: Implement Shadow Call Stack
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Clement Leger <cleger@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
Tested-by: Nathan Chancellor <nathan@kernel.org>
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
index d607ab0f7c6d..2f14ccb5fb01 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -48,6 +48,7 @@ config RISCV
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
 	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
+	select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USES_CFI_TRAPS if CFI_CLANG
@@ -174,6 +175,11 @@ config GCC_SUPPORTS_DYNAMIC_FTRACE
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
index 1329e060c548..304b94446507 100644
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
index 0af8860f9d68..a03129f40c46 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -39,6 +39,9 @@ void asm_offsets(void)
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
+#ifdef CONFIG_SHADOW_CALL_STACK
+	OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
+#endif
 
 	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 6215dcf2e83b..52793193a763 100644
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
@@ -275,6 +282,8 @@ SYM_FUNC_START(__switch_to)
 	REG_S s9,  TASK_THREAD_S9_RA(a3)
 	REG_S s10, TASK_THREAD_S10_RA(a3)
 	REG_S s11, TASK_THREAD_S11_RA(a3)
+	/* Save the kernel shadow call stack pointer */
+	scs_save_current
 	/* Restore context from next->thread */
 	REG_L ra,  TASK_THREAD_RA_RA(a4)
 	REG_L sp,  TASK_THREAD_SP_RA(a4)
@@ -292,6 +301,8 @@ SYM_FUNC_START(__switch_to)
 	REG_L s11, TASK_THREAD_S11_RA(a4)
 	/* The offset of thread_info in task_struct is zero. */
 	move tp, a1
+	/* Switch to the next shadow call stack */
+	scs_load_current
 	ret
 SYM_FUNC_END(__switch_to)
 
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index a0484d95d8fb..18f97ec0f7ed 100644
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
 
@@ -289,6 +291,7 @@ clear_bss_done:
 	la sp, init_thread_union + THREAD_SIZE
 	XIP_FIXUP_OFFSET sp
 	addi sp, sp, -PT_SIZE_ON_STACK
+	scs_load_init_stack
 #ifdef CONFIG_BUILTIN_DTB
 	la a0, __dtb_start
 	XIP_FIXUP_OFFSET a0
@@ -307,6 +310,7 @@ clear_bss_done:
 	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	addi sp, sp, -PT_SIZE_ON_STACK
+	scs_load_current
 
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
index 9e6476719abb..6a3c16bd5ca3 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -81,6 +81,10 @@ ifdef CONFIG_CFI_CLANG
 PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_CFI)
 endif
 
+ifdef CONFIG_SHADOW_CALL_STACK
+PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_SCS)
+endif
+
 CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
 
-- 
2.42.0.515.g380fc7ccd1-goog


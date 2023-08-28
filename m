Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5BD78B8DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjH1T70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjH1T6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:58:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F503189
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:58:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7493fcd829so4440101276.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693252725; x=1693857525;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHEpjDWpZKheS5AgI4FhMURxdLRiA7f+7eI6PSwoShs=;
        b=oU7u4yIwCqEfIEncvirifpc8jGp8C2PonLKbfLyys1pYIlGszZDoAooaF/rA0xipsa
         tGEdMGobqAe00UCFtvQUmb7m/LoLfLDhGkakB7CJCf2UzXywKzO4OGDJx36TWR6p1UpO
         gH+CFvy2T/d4aEliQy8VqP+pcWw0DQUKphP1cBN2b9Cr6KoXrSCWy2xSHa4O70TgLTtV
         kcouhP3xTN66BUOTos30E+RKqDSHDRJfp+8zYKZh20qXio3GEQ7TFh7/q3ws6NvVxZiO
         9DkaSSJqea9knPB9Fi+KfetI4RjF02r8Q43oiZstz6SsA+TRNeaIoRtwg6FkO64uo7DC
         3gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693252725; x=1693857525;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHEpjDWpZKheS5AgI4FhMURxdLRiA7f+7eI6PSwoShs=;
        b=HcS1PnfFN11lFEUGQKEnbbrMfdEL0ybW62OFNNjJ61pVAFw+n1qERFK04ukRUSqisH
         INh9UlKTDRvlLHQyZH/eATWyddmAGC90xaJyQBA3e3t9+/panaYChk8mJ5gqVncVLsWi
         638iZ4DeZUDzYYzLCpHlEsscpRSm5DipwXIeCYEYrOqri0j/KarfP2UYvNQ57ZFovBvU
         wdzBlhHTtL1k7B+ok2KXQupeq7jXt289uHwcN2fVhCuj5r9D0WQgTHKfrpkJlTjmv6Mx
         Iu6un+NmcJBSk89YcfcyVaZHzf4GNzQEHfgF1qG5ekGghujcgKBZVNWi1JY0I6/bZotH
         hJHA==
X-Gm-Message-State: AOJu0Yx+X1cL8eZ4DlMIU8YGh9MQdVK/pH5xzFfC/tcgS1fq/T5d3gqy
        XqsOdkVTQgOqYm0fFmiUxi9inQt4a6sSBOXawkI=
X-Google-Smtp-Source: AGHT+IFPe1xW/cZcqMnEmhJXa9gkio6zfEjjBVIssP4qY8EDsEHxCzdXB9iRA0bQANGRB+YXwQYzP941dcW/ssXB124=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a25:d750:0:b0:d7a:bfcf:2d7 with SMTP
 id o77-20020a25d750000000b00d7abfcf02d7mr386698ybg.6.1693252725580; Mon, 28
 Aug 2023 12:58:45 -0700 (PDT)
Date:   Mon, 28 Aug 2023 19:58:38 +0000
In-Reply-To: <20230828195833.756747-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230828195833.756747-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=9699; i=samitolvanen@google.com;
 h=from:subject; bh=yzq9X6lovJwCj7M3MxLTb+ZbxWOKAC+68l1vG/LS5Go=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBk7PxqnP8GY39pSf11gSk0fB0bvEpXRF2ZEN/E+
 G3d+76nn0OJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZOz8agAKCRBMtfaEi7xW
 7gsfC/9z0ZHF2b9t4rZr3ySGuRBhgmJMEDj1qu+NhecypGTqBV+8Cf+bL2247doUWGkApt+72LI
 Pie3DKwp/m/VGmPDKi5q/CHYiJLP8680OGP1+bTrgYosZW8hyJ9IhiKBiO1KBRy47o/T50jlhIc
 VLTG0/pv3Y+jeXP0qgdkSrHZlTv7QZPhn289pObdT/2Ec0VHRVw53yDsfnirmd1Z2H+N5PkP/6f
 1xreDmv6SydopVQvfabiJYbA2ISjihl6rFRDqU2ArU8zwBiuubsGlLXzPpeoKDiqvBWN86lYmXY
 X2DoWBrpXBLJwxNGk+gdnntxZXM5+hHaCh1D1a5jW2C9OajMf4lqHP9lG/XUDynL1Gmxxrid5JG
 xgY811eAOdQva10xkT5N8Zv/OzuURC3GqI2P2Dhr0c3G4WTomuJ13WFUOPg5QDhJsU3a5B9DZv/ f1ZMyp4Vr2IT2tV5madananCzjiSG8k+hxqtfu1tvhCKQ4SOJW10fDi80IvVzGfHZqXy8=
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230828195833.756747-12-samitolvanen@google.com>
Subject: [PATCH v3 4/6] riscv: Implement Shadow Call Stack
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
index bea7b73e895d..93122634f9c2 100644
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
2.42.0.rc2.253.gd59a3bf2b4-goog


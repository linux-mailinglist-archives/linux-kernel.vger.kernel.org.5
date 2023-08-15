Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAC477D42F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbjHOUfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238042AbjHOUev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:34:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C113DF7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:34:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583d1d0de65so75735517b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692131689; x=1692736489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2g9kzHqhSNJwgBBDx7OBACW2GSQNvlkcjq1gGBNV2Bo=;
        b=5fhSxlGCoP9eFSdFtRHiL4qRSdSwqPd7gzbVSPTiAU38g2wOHlOIpVYbOfieO8z/+X
         IEpl6nfntGQWgA924+5Z5nTBocRQ7FPksFYyL4EZCQja00MCxhy36o2za0FYibqRE21z
         fhQVudLJ+ihYNMXZnwK0rM1AI6CbD6GzVHb8KRBMJvZZVXLvVusxB3MJII05LCR7ksRN
         PYnsC/MjI2Tcyl2WcvR8r3fx2Vi+tJ1PCApbwyEgQcH+auQ7/GUCjqEaAjfE2WA22rZc
         CubL4Er4FcAbsDiTz/MAVkn6/HhJ3YMRAc+duqqYw/4Ml47tNzlvl2g4SmXazUrX9UGJ
         H+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692131689; x=1692736489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2g9kzHqhSNJwgBBDx7OBACW2GSQNvlkcjq1gGBNV2Bo=;
        b=JrrAXSwkxAVHA7yyjE6v13UCUn3WS6S96dXTCgYwwZ5YjyZbBh/m7orlhr9jwvTzJn
         lXZIRakqwfNauZdwTwC501zc+UCYEQfh1BH0QyFN9odoF4RQ6gCt+WUZfNkNd5FVCw1w
         9oc9lLLtJEQKsAmye4Kqf4cUWaW8k67zoHbQrGmoma4oQUN27lWyJWQOh26N/qC5ct+K
         /j2bqrt6364NjzLBBS5Z8AgpFFZD1CJSpYgUai142V1TZPS3qQZbE9BRzrLgXinPHvL0
         DVrNoF1jN9G6Dhi6pt7i9ErJd4IFEHKq/hcaBQ+P/lQiGMgCutZSiEVkr6LkmFoevKZu
         awIA==
X-Gm-Message-State: AOJu0Yx2knYs73Wn48eFR04e1k+p+NipXenjBB0YOoOoVWHdpjO7+3Tn
        MnH0NuWKAqjXjR7C/quWS9gQCLjJzM4JDAFzJpk=
X-Google-Smtp-Source: AGHT+IGivQ4nxBqRW7/5l/sAoV4/vI2cYX6H54kXeR8lMldcoVTYpg5DO9jfP7O9CrkY98boxli26xltNMvid9T8YFI=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a81:af1f:0:b0:56d:647:664b with SMTP
 id n31-20020a81af1f000000b0056d0647664bmr196328ywh.5.1692131689073; Tue, 15
 Aug 2023 13:34:49 -0700 (PDT)
Date:   Tue, 15 Aug 2023 20:34:44 +0000
In-Reply-To: <20230815203442.1608773-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230815203442.1608773-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=10263; i=samitolvanen@google.com;
 h=from:subject; bh=ZSehk0HlS5lFssHilJirKHoqNUMKSxbPAfpprDSxzWc=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBk2+FiY/LmC6Mrof2Ek0FECg4Lyrb602OprdqPv
 Z36fbNfcwKJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZNvhYgAKCRBMtfaEi7xW
 7mndC/0bMg+3a2jsWzVZKgcRI3wlt+nRTUv0WtQprozA0ki2lLlThz02RnGre6VdcJGWDs2NOTt
 ES5Mvq6ZCaP40k/y1vg293dS4YTr9axfndkManB9r3jzd+46U+nbQPpqvBUCeDJm2kuPNft/q9I
 SuubRVgtai/4nbcZXB7QrsYWW3Lek10TYFv+6sCU7NLij5hPrKN/NvDqJie0mVeZzvQO8hd/he0
 C/vRSL6xNpExXTskKfQamDInoer/hiOiLI5OhAZSi+5Ov+W2uO+6zP5dUGTJ0OkOXj4Yd06IKcB
 hh16MhU5PVBJUPfQUL3OC8hCPaqJN5p6mPquadLTO0YZD3P6CTCjenY1Of0PBz4Zgo01fOIb+c6
 U1XeBHSUBI4dbMW7VzXngTAkYd09OV+JNLJtsg3Rz0zTtsYRCr7oVmq8WQbPB8sBujzWJ36CKPF AOY17PAK2ebKmBDAss2umHOFq2t+7DF3bxncYTA1g/IKXLt66QJ2pZQ/1Ws0Mywoykmxs=
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815203442.1608773-9-samitolvanen@google.com>
Subject: [PATCH v2 1/6] riscv: VMAP_STACK overflow detection thread-safe
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
        linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deepak Gupta <debug@rivosinc.com>

commit 31da94c25aea ("riscv: add VMAP_STACK overflow detection") added
support for CONFIG_VMAP_STACK. If overflow is detected, CPU switches to
`shadow_stack` temporarily before switching finally to per-cpu
`overflow_stack`.

If two CPUs/harts are racing and end up in over flowing kernel stack, one
or both will end up corrupting each other state because `shadow_stack` is
not per-cpu. This patch optimizes per-cpu overflow stack switch by
directly picking per-cpu `overflow_stack` and gets rid of `shadow_stack`.

Following are the changes in this patch

 - Defines an asm macro to obtain per-cpu symbols in destination
   register.
 - In entry.S, when overflow is detected, per-cpu overflow stack is
   located using per-cpu asm macro. Computing per-cpu symbol requires
   a temporary register. x31 is saved away into CSR_SCRATCH
   (CSR_SCRATCH is anyways zero since we're in kernel).

Please see Links for additional relevant disccussion and alternative
solution.

Tested by `echo EXHAUST_STACK > /sys/kernel/debug/provoke-crash/DIRECT`
Kernel crash log below

 Insufficient stack space to handle exception!/debug/provoke-crash/DIRECT
 Task stack:     [0xff20000010a98000..0xff20000010a9c000]
 Overflow stack: [0xff600001f7d98370..0xff600001f7d99370]
 CPU: 1 PID: 205 Comm: bash Not tainted 6.1.0-rc2-00001-g328a1f96f7b9 #34
 Hardware name: riscv-virtio,qemu (DT)
 epc : __memset+0x60/0xfc
  ra : recursive_loop+0x48/0xc6 [lkdtm]
 epc : ffffffff808de0e4 ra : ffffffff0163a752 sp : ff20000010a97e80
  gp : ffffffff815c0330 tp : ff600000820ea280 t0 : ff20000010a97e88
  t1 : 000000000000002e t2 : 3233206874706564 s0 : ff20000010a982b0
  s1 : 0000000000000012 a0 : ff20000010a97e88 a1 : 0000000000000000
  a2 : 0000000000000400 a3 : ff20000010a98288 a4 : 0000000000000000
  a5 : 0000000000000000 a6 : fffffffffffe43f0 a7 : 00007fffffffffff
  s2 : ff20000010a97e88 s3 : ffffffff01644680 s4 : ff20000010a9be90
  s5 : ff600000842ba6c0 s6 : 00aaaaaac29e42b0 s7 : 00fffffff0aa3684
  s8 : 00aaaaaac2978040 s9 : 0000000000000065 s10: 00ffffff8a7cad10
  s11: 00ffffff8a76a4e0 t3 : ffffffff815dbaf4 t4 : ffffffff815dbaf4
  t5 : ffffffff815dbab8 t6 : ff20000010a9bb48
 status: 0000000200000120 badaddr: ff20000010a97e88 cause: 000000000000000f
 Kernel panic - not syncing: Kernel stack overflow
 CPU: 1 PID: 205 Comm: bash Not tainted 6.1.0-rc2-00001-g328a1f96f7b9 #34
 Hardware name: riscv-virtio,qemu (DT)
 Call Trace:
 [<ffffffff80006754>] dump_backtrace+0x30/0x38
 [<ffffffff808de798>] show_stack+0x40/0x4c
 [<ffffffff808ea2a8>] dump_stack_lvl+0x44/0x5c
 [<ffffffff808ea2d8>] dump_stack+0x18/0x20
 [<ffffffff808dec06>] panic+0x126/0x2fe
 [<ffffffff800065ea>] walk_stackframe+0x0/0xf0
 [<ffffffff0163a752>] recursive_loop+0x48/0xc6 [lkdtm]
 SMP: stopping secondary CPUs
 ---[ end Kernel panic - not syncing: Kernel stack overflow ]---

Cc: Guo Ren <guoren@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>
Link: https://lore.kernel.org/linux-riscv/Y347B0x4VUNOd6V7@xhacker/T/#t
Link: https://lore.kernel.org/lkml/20221124094845.1907443-1-debug@rivosinc.com/
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/asm.h         | 22 +++++++++
 arch/riscv/include/asm/thread_info.h |  3 --
 arch/riscv/kernel/asm-offsets.c      |  1 +
 arch/riscv/kernel/entry.S            | 70 ++++------------------------
 arch/riscv/kernel/traps.c            | 36 +-------------
 5 files changed, 34 insertions(+), 98 deletions(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index 114bbadaef41..bfb4c26f113c 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -82,6 +82,28 @@
 	.endr
 .endm
 
+#ifdef CONFIG_SMP
+#ifdef CONFIG_32BIT
+#define PER_CPU_OFFSET_SHIFT 2
+#else
+#define PER_CPU_OFFSET_SHIFT 3
+#endif
+
+.macro asm_per_cpu dst sym tmp
+	REG_L \tmp, TASK_TI_CPU_NUM(tp)
+	slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
+	la    \dst, __per_cpu_offset
+	add   \dst, \dst, \tmp
+	REG_L \tmp, 0(\dst)
+	la    \dst, \sym
+	add   \dst, \dst, \tmp
+.endm
+#else /* CONFIG_SMP */
+.macro asm_per_cpu dst sym tmp
+	la    \dst, \sym
+.endm
+#endif /* CONFIG_SMP */
+
 	/* save all GPs except x1 ~ x5 */
 	.macro save_from_x6_to_x31
 	REG_S x6,  PT_T1(sp)
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 1833beb00489..d18ce0113ca1 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -34,9 +34,6 @@
 
 #ifndef __ASSEMBLY__
 
-extern long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE / sizeof(long)];
-extern unsigned long spin_shadow_stack;
-
 #include <asm/processor.h>
 #include <asm/csr.h>
 
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index d6a75aac1d27..9f535d5de33f 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -39,6 +39,7 @@ void asm_offsets(void)
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
 
+	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
 	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 143a2bb3e697..3d11aa3af105 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -10,9 +10,11 @@
 #include <asm/asm.h>
 #include <asm/csr.h>
 #include <asm/unistd.h>
+#include <asm/page.h>
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
 #include <asm/errata_list.h>
+#include <linux/sizes.h>
 
 SYM_CODE_START(handle_exception)
 	/*
@@ -170,67 +172,15 @@ SYM_CODE_END(ret_from_exception)
 
 #ifdef CONFIG_VMAP_STACK
 SYM_CODE_START_LOCAL(handle_kernel_stack_overflow)
-	/*
-	 * Takes the psuedo-spinlock for the shadow stack, in case multiple
-	 * harts are concurrently overflowing their kernel stacks.  We could
-	 * store any value here, but since we're overflowing the kernel stack
-	 * already we only have SP to use as a scratch register.  So we just
-	 * swap in the address of the spinlock, as that's definately non-zero.
-	 *
-	 * Pairs with a store_release in handle_bad_stack().
-	 */
-1:	la sp, spin_shadow_stack
-	REG_AMOSWAP_AQ sp, sp, (sp)
-	bnez sp, 1b
-
-	la sp, shadow_stack
-	addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
-
-	//save caller register to shadow stack
-	addi sp, sp, -(PT_SIZE_ON_STACK)
-	REG_S x1,  PT_RA(sp)
-	REG_S x5,  PT_T0(sp)
-	REG_S x6,  PT_T1(sp)
-	REG_S x7,  PT_T2(sp)
-	REG_S x10, PT_A0(sp)
-	REG_S x11, PT_A1(sp)
-	REG_S x12, PT_A2(sp)
-	REG_S x13, PT_A3(sp)
-	REG_S x14, PT_A4(sp)
-	REG_S x15, PT_A5(sp)
-	REG_S x16, PT_A6(sp)
-	REG_S x17, PT_A7(sp)
-	REG_S x28, PT_T3(sp)
-	REG_S x29, PT_T4(sp)
-	REG_S x30, PT_T5(sp)
-	REG_S x31, PT_T6(sp)
-
-	la ra, restore_caller_reg
-	tail get_overflow_stack
-
-restore_caller_reg:
-	//save per-cpu overflow stack
-	REG_S a0, -8(sp)
-	//restore caller register from shadow_stack
-	REG_L x1,  PT_RA(sp)
-	REG_L x5,  PT_T0(sp)
-	REG_L x6,  PT_T1(sp)
-	REG_L x7,  PT_T2(sp)
-	REG_L x10, PT_A0(sp)
-	REG_L x11, PT_A1(sp)
-	REG_L x12, PT_A2(sp)
-	REG_L x13, PT_A3(sp)
-	REG_L x14, PT_A4(sp)
-	REG_L x15, PT_A5(sp)
-	REG_L x16, PT_A6(sp)
-	REG_L x17, PT_A7(sp)
-	REG_L x28, PT_T3(sp)
-	REG_L x29, PT_T4(sp)
-	REG_L x30, PT_T5(sp)
-	REG_L x31, PT_T6(sp)
+	/* we reach here from kernel context, sscratch must be 0 */
+	csrrw x31, CSR_SCRATCH, x31
+	asm_per_cpu sp, overflow_stack, x31
+	li x31, OVERFLOW_STACK_SIZE
+	add sp, sp, x31
+	/* zero out x31 again and restore x31 */
+	xor x31, x31, x31
+	csrrw x31, CSR_SCRATCH, x31
 
-	//load per-cpu overflow stack
-	REG_L sp, -8(sp)
 	addi sp, sp, -(PT_SIZE_ON_STACK)
 
 	//save context to overflow stack
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f910dfccbf5d..deb2144d9143 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -397,48 +397,14 @@ int is_valid_bugaddr(unsigned long pc)
 #endif /* CONFIG_GENERIC_BUG */
 
 #ifdef CONFIG_VMAP_STACK
-/*
- * Extra stack space that allows us to provide panic messages when the kernel
- * has overflowed its stack.
- */
-static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
+DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
 		overflow_stack)__aligned(16);
-/*
- * A temporary stack for use by handle_kernel_stack_overflow.  This is used so
- * we can call into C code to get the per-hart overflow stack.  Usage of this
- * stack must be protected by spin_shadow_stack.
- */
-long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)] __aligned(16);
-
-/*
- * A pseudo spinlock to protect the shadow stack from being used by multiple
- * harts concurrently.  This isn't a real spinlock because the lock side must
- * be taken without a valid stack and only a single register, it's only taken
- * while in the process of panicing anyway so the performance and error
- * checking a proper spinlock gives us doesn't matter.
- */
-unsigned long spin_shadow_stack;
-
-asmlinkage unsigned long get_overflow_stack(void)
-{
-	return (unsigned long)this_cpu_ptr(overflow_stack) +
-		OVERFLOW_STACK_SIZE;
-}
 
 asmlinkage void handle_bad_stack(struct pt_regs *regs)
 {
 	unsigned long tsk_stk = (unsigned long)current->stack;
 	unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
 
-	/*
-	 * We're done with the shadow stack by this point, as we're on the
-	 * overflow stack.  Tell any other concurrent overflowing harts that
-	 * they can proceed with panicing by releasing the pseudo-spinlock.
-	 *
-	 * This pairs with an amoswap.aq in handle_kernel_stack_overflow.
-	 */
-	smp_store_release(&spin_shadow_stack, 0);
-
 	console_verbose();
 
 	pr_emerg("Insufficient stack space to handle exception!\n");
-- 
2.41.0.694.ge786442a9b-goog


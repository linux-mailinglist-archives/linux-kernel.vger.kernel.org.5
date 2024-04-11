Return-Path: <linux-kernel+bounces-141450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5738A1E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB6A28AA52
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959BF137915;
	Thu, 11 Apr 2024 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajT89B8r"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D9A4C601;
	Thu, 11 Apr 2024 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858848; cv=none; b=QU8SI48TRDB9RGwfATMzsuAfqK/ppS5O1k8ghRF0MGD6s+wb7ERwF6RF7v4ZnzIA9WLEptET6VvA790pBBy46qE2hqgkWDhFgjmn0EI1RdBhHTzPnjy+O7xRxICj+nCkaQ9EHE7Hdj7bZS1kXlQHblHONmEn8k2CCThYP667rN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858848; c=relaxed/simple;
	bh=uoypgfILpOV53u+PqSpW90h3uRnnMDs8RrJ/fNVLPnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5EB09V56EPWeFOzAuotneZJxhBWtHEzXJSKePqcJzGVoACTy5MHxhkyceXqBhmVbF0NcfhsK7hgKdsX4+MPnEyOwH6sVhmgROHPuyNkokdEf2Dix3Y18ACBHacV/f4wBMxsxFVv2GdSKaEegDayqY7UiuALMcBPLeimVX37Cso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajT89B8r; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-343d7ff2350so23045f8f.0;
        Thu, 11 Apr 2024 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712858844; x=1713463644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVHctDY4yjRyI0xciRRAMqYJCTVTs5KhPgdzO+9ACCE=;
        b=ajT89B8rHNGbzB1XUvgsD/Tq4SAiPyCKHq4QKSXnasD/cbUf+feJgbRU72XYB9jz12
         1t8F9njzjnG3IuNnBY8M3Lc7oD2zSH3vNpbRP073aV1pGbxwbkJtvbZRIQLYOJtal53i
         nE/Xhg1gFOi9eNpm1xAcYUOEirFb1FTDuunr/s8agrTxwqDB7cTj7pWEe9JSArZZVIKg
         88CVxkuv+o5FT/b+/j1owHiubBaqKUVZze87yId+Htqfy7+OEjo6aKk0SJxonPFea4A+
         M5KlwOJYeTxVYMFLMlWGmkwqakTM1YC+a/nHi+r1cGTMQAOOq+vnc/kei0IwkjMW9Xa1
         32cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858844; x=1713463644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVHctDY4yjRyI0xciRRAMqYJCTVTs5KhPgdzO+9ACCE=;
        b=GPvoKzc9oPhbaDgfeJIemoMs3+PBBfxhlLwHCHYDc+tcfRVPD18BOZ61mq6NHQ8ZVJ
         nxmO0XId0CfAb+DxZpbQbqxEd7zG7IJ9rG/2wAnLT+g/9DWmd/r8bXDB7zFHadFC8QXG
         V1BVubVvF83gyEWGSCinoES6JIpn/SLr3CL1Iqy/AY3HZbKbyPK+n2UssusY6Z2V9/lE
         yUCX8i1B7WnxMryzqvergariFvkIGftogr9O/rvOqFbM+soLReHx698cSjjJM+OSmHQl
         YwSwZR2rzEz3pxtJyrynlJQ5m3r9JiIH0PLpZcHsjZlUfPpt4+ZrpRUAoqN2Ii/tU40z
         g/Cg==
X-Gm-Message-State: AOJu0Yyfmv+Tc4mYbWANNG9/2QGIcErpDYIXgIXCxjvJsjbDa/9oD3Yy
	Hp1f0s8JVwQzVs7qVFYIyrNDl4DTDEL3dlCW9p3dNcE3au/Gl29bJ54OhA==
X-Google-Smtp-Source: AGHT+IFzK4yl38sBR9rXf+9DqkqXC7YWeTg82+WE1s85TEPotZSV5CMnwrwvhHNPuJ3kGX0IqOPjwA==
X-Received: by 2002:a5d:4e0c:0:b0:346:f906:f6c1 with SMTP id p12-20020a5d4e0c000000b00346f906f6c1mr13823wrt.0.1712858844244;
        Thu, 11 Apr 2024 11:07:24 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d6709000000b00343956e8852sm2309447wru.42.2024.04.11.11.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 11:07:23 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 5/5] openrisc: Move FPU state out of pt_regs
Date: Thu, 11 Apr 2024 19:06:32 +0100
Message-ID: <20240411180644.2023991-6-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411180644.2023991-1-shorne@gmail.com>
References: <20240411180644.2023991-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My original, naive, FPU support patch had the FPCSR register stored
during both the *mode switch* and *context switch*.  This is wasteful.

Also, the original patches did not save the FPU state when handling
signals during the system call fast path.

We fix this by moving the FPCSR state to thread_struct in task_struct.
We also introduce new helper functions save_fpu and restore_fpu which
can be used to sync the FPU with thread_struct.  These functions are now
called when needed:

 - Setting up and restoring sigcontext when handling signals
 - Before and after __switch_to during context switches
 - When handling FPU exceptions
 - When reading and writing FPU register sets

In the future we can further optimize this by doing lazy FPU save and
restore.  For example, FPU sync is not needed when switching to and from
kernel threads (x86 does this).  FPU save and restore does not need to
be done two times if we have both rescheduling and signal work to do.
However, since OpenRISC FPU state is a single register, I leave these
optimizations for future consideration.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/fpu.h       | 22 ++++++++++++++++
 arch/openrisc/include/asm/processor.h |  1 +
 arch/openrisc/include/asm/ptrace.h    |  3 +--
 arch/openrisc/kernel/entry.S          | 15 +----------
 arch/openrisc/kernel/process.c        |  5 ++++
 arch/openrisc/kernel/ptrace.c         | 12 +++------
 arch/openrisc/kernel/signal.c         | 36 +++++++++++++++++++++++++--
 arch/openrisc/kernel/traps.c          | 14 +++++++----
 8 files changed, 76 insertions(+), 32 deletions(-)
 create mode 100644 arch/openrisc/include/asm/fpu.h

diff --git a/arch/openrisc/include/asm/fpu.h b/arch/openrisc/include/asm/fpu.h
new file mode 100644
index 000000000000..57bc44d80d53
--- /dev/null
+++ b/arch/openrisc/include/asm/fpu.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_OPENRISC_FPU_H
+#define __ASM_OPENRISC_FPU_H
+
+struct task_struct;
+
+#ifdef CONFIG_FPU
+static inline void save_fpu(struct task_struct *task)
+{
+	task->thread.fpcsr = mfspr(SPR_FPCSR);
+}
+
+static inline void restore_fpu(struct task_struct *task)
+{
+	mtspr(SPR_FPCSR, task->thread.fpcsr);
+}
+#else
+#define save_fpu(tsk)			do { } while (0)
+#define restore_fpu(tsk)		do { } while (0)
+#endif
+
+#endif /* __ASM_OPENRISC_FPU_H */
diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
index 3b736e74e6ed..e05d1b59e24e 100644
--- a/arch/openrisc/include/asm/processor.h
+++ b/arch/openrisc/include/asm/processor.h
@@ -44,6 +44,7 @@
 struct task_struct;
 
 struct thread_struct {
+	long fpcsr;		/* Floating point control status register. */
 };
 
 /*
diff --git a/arch/openrisc/include/asm/ptrace.h b/arch/openrisc/include/asm/ptrace.h
index 375147ff71fc..1da3e66292e2 100644
--- a/arch/openrisc/include/asm/ptrace.h
+++ b/arch/openrisc/include/asm/ptrace.h
@@ -59,7 +59,7 @@ struct pt_regs {
 	 * -1 for all other exceptions.
 	 */
 	long  orig_gpr11;	/* For restarting system calls */
-	long fpcsr;		/* Floating point control status register. */
+	long dummy;		/* Cheap alignment fix */
 	long dummy2;		/* Cheap alignment fix */
 };
 
@@ -115,6 +115,5 @@ static inline long regs_return_value(struct pt_regs *regs)
 #define PT_GPR31      124
 #define PT_PC	      128
 #define PT_ORIG_GPR11 132
-#define PT_FPCSR      136
 
 #endif /* __ASM_OPENRISC_PTRACE_H */
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index c9f48e750b72..440711d7bf40 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -106,8 +106,6 @@
 	l.mtspr r0,r3,SPR_EPCR_BASE				;\
 	l.lwz   r3,PT_SR(r1)					;\
 	l.mtspr r0,r3,SPR_ESR_BASE				;\
-	l.lwz	r3,PT_FPCSR(r1)					;\
-	l.mtspr	r0,r3,SPR_FPCSR					;\
 	l.lwz   r2,PT_GPR2(r1)					;\
 	l.lwz   r3,PT_GPR3(r1)					;\
 	l.lwz   r4,PT_GPR4(r1)					;\
@@ -177,8 +175,6 @@ handler:							;\
 	/* r30 already save */					;\
 	l.sw    PT_GPR31(r1),r31					;\
 	TRACE_IRQS_OFF_ENTRY						;\
-	l.mfspr	r30,r0,SPR_FPCSR				;\
-	l.sw	PT_FPCSR(r1),r30				;\
 	/* Store -1 in orig_gpr11 for non-syscall exceptions */	;\
 	l.addi	r30,r0,-1					;\
 	l.sw	PT_ORIG_GPR11(r1),r30
@@ -219,8 +215,6 @@ handler:							;\
 	/* Store -1 in orig_gpr11 for non-syscall exceptions */	;\
 	l.addi	r30,r0,-1					;\
 	l.sw	PT_ORIG_GPR11(r1),r30				;\
-	l.mfspr	r30,r0,SPR_FPCSR				;\
-	l.sw	PT_FPCSR(r1),r30				;\
 	l.addi	r3,r1,0						;\
 	/* r4 is exception EA */				;\
 	l.addi	r5,r0,vector					;\
@@ -852,6 +846,7 @@ _syscall_badsys:
 
 EXCEPTION_ENTRY(_fpe_trap_handler)
 	CLEAR_LWA_FLAG(r3)
+
 	/* r4: EA of fault (set by EXCEPTION_HANDLE) */
 	l.jal   do_fpe_trap
 	 l.addi  r3,r1,0 /* pt_regs */
@@ -1100,10 +1095,6 @@ ENTRY(_switch)
 	l.sw    PT_GPR28(r1),r28
 	l.sw    PT_GPR30(r1),r30
 
-	/* Store the old FPU state to new pt_regs */
-	l.mfspr	r29,r0,SPR_FPCSR
-	l.sw	PT_FPCSR(r1),r29
-
 	l.addi	r11,r10,0			/* Save old 'current' to 'last' return value*/
 
 	/* We use thread_info->ksp for storing the address of the above
@@ -1126,10 +1117,6 @@ ENTRY(_switch)
 	l.lwz	r29,PT_SP(r1)
 	l.sw	TI_KSP(r10),r29
 
-	/* Restore the old value of FPCSR */
-	l.lwz	r29,PT_FPCSR(r1)
-	l.mtspr	r0,r29,SPR_FPCSR
-
 	/* ...and restore the registers, except r11 because the return value
 	 * has already been set above.
 	 */
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 3c27d1c72718..eef99fee2110 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -36,6 +36,7 @@
 #include <linux/reboot.h>
 
 #include <linux/uaccess.h>
+#include <asm/fpu.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/spr_defs.h>
@@ -244,6 +245,8 @@ struct task_struct *__switch_to(struct task_struct *old,
 
 	local_irq_save(flags);
 
+	save_fpu(current);
+
 	/* current_set is an array of saved current pointers
 	 * (one for each cpu). we need them at user->kernel transition,
 	 * while we save them at kernel->user transition
@@ -256,6 +259,8 @@ struct task_struct *__switch_to(struct task_struct *old,
 	current_thread_info_set[smp_processor_id()] = new_ti;
 	last = (_switch(old_ti, new_ti))->task;
 
+	restore_fpu(current);
+
 	local_irq_restore(flags);
 
 	return last;
diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index cf410193095f..5091b18eab4c 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -98,9 +98,7 @@ static int fpregs_get(struct task_struct *target,
 		       const struct user_regset *regset,
 		       struct membuf to)
 {
-	const struct pt_regs *regs = task_pt_regs(target);
-
-	return membuf_store(&to, regs->fpcsr);
+	return membuf_store(&to, target->thread.fpcsr);
 }
 
 static int fpregs_set(struct task_struct *target,
@@ -108,13 +106,9 @@ static int fpregs_set(struct task_struct *target,
 		       unsigned int pos, unsigned int count,
 		       const void *kbuf, const void __user *ubuf)
 {
-	struct pt_regs *regs = task_pt_regs(target);
-	int ret;
-
 	/* FPCSR */
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 &regs->fpcsr, 0, 4);
-	return ret;
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.fpcsr, 0, 4);
 }
 #endif
 
diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index e2f21a5d8ad9..c7ab42e2cb7a 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -23,6 +23,7 @@
 #include <linux/stddef.h>
 #include <linux/resume_user_mode.h>
 
+#include <asm/fpu.h>
 #include <asm/processor.h>
 #include <asm/syscall.h>
 #include <asm/ucontext.h>
@@ -39,6 +40,37 @@ asmlinkage long _sys_rt_sigreturn(struct pt_regs *regs);
 asmlinkage int do_work_pending(struct pt_regs *regs, unsigned int thread_flags,
 			       int syscall);
 
+#ifdef CONFIG_FPU
+static long restore_fp_state(struct sigcontext __user *sc)
+{
+	long err;
+
+	err = __copy_from_user(&current->thread.fpcsr, &sc->fpcsr, sizeof(unsigned long));
+	if (unlikely(err))
+		return err;
+
+	/* Restore the FPU state */
+	restore_fpu(current);
+
+	return 0;
+}
+
+static long save_fp_state(struct sigcontext __user *sc)
+{
+	long err;
+
+	/* Sync the user FPU state so we can copy to sigcontext */
+	save_fpu(current);
+
+	err = __copy_to_user(&sc->fpcsr, &current->thread.fpcsr, sizeof(unsigned long));
+
+	return err;
+}
+#else
+#define save_fp_state(sc) (0)
+#define restore_fp_state(sc) (0)
+#endif
+
 static int restore_sigcontext(struct pt_regs *regs,
 			      struct sigcontext __user *sc)
 {
@@ -55,7 +87,7 @@ static int restore_sigcontext(struct pt_regs *regs,
 	err |= __copy_from_user(regs, sc->regs.gpr, 32 * sizeof(unsigned long));
 	err |= __copy_from_user(&regs->pc, &sc->regs.pc, sizeof(unsigned long));
 	err |= __copy_from_user(&regs->sr, &sc->regs.sr, sizeof(unsigned long));
-	err |= __copy_from_user(&regs->fpcsr, &sc->fpcsr, sizeof(unsigned long));
+	err |= restore_fp_state(sc);
 
 	/* make sure the SM-bit is cleared so user-mode cannot fool us */
 	regs->sr &= ~SPR_SR_SM;
@@ -118,7 +150,7 @@ static int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 	err |= __copy_to_user(sc->regs.gpr, regs, 32 * sizeof(unsigned long));
 	err |= __copy_to_user(&sc->regs.pc, &regs->pc, sizeof(unsigned long));
 	err |= __copy_to_user(&sc->regs.sr, &regs->sr, sizeof(unsigned long));
-	err |= __copy_to_user(&sc->fpcsr, &regs->fpcsr, sizeof(unsigned long));
+	err |= save_fp_state(sc);
 
 	return err;
 }
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 57e0d674eb04..c195be9cc9fc 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -31,6 +31,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/bug.h>
+#include <asm/fpu.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/unwinder.h>
@@ -84,9 +85,8 @@ void show_registers(struct pt_regs *regs)
 		in_kernel = 0;
 
 	pr_info("CPU #: %d\n"
-		"   PC: %08lx    SR: %08lx    SP: %08lx FPCSR: %08lx\n",
-		smp_processor_id(), regs->pc, regs->sr, regs->sp,
-		regs->fpcsr);
+		"   PC: %08lx    SR: %08lx    SP: %08lx\n",
+		smp_processor_id(), regs->pc, regs->sr, regs->sp);
 	pr_info("GPR00: %08lx GPR01: %08lx GPR02: %08lx GPR03: %08lx\n",
 		0L, regs->gpr[1], regs->gpr[2], regs->gpr[3]);
 	pr_info("GPR04: %08lx GPR05: %08lx GPR06: %08lx GPR07: %08lx\n",
@@ -183,7 +183,10 @@ asmlinkage void do_fpe_trap(struct pt_regs *regs, unsigned long address)
 	if (user_mode(regs)) {
 		int code = FPE_FLTUNK;
 #ifdef CONFIG_FPU
-		unsigned long fpcsr = regs->fpcsr;
+		unsigned long fpcsr;
+
+		save_fpu(current);
+		fpcsr = current->thread.fpcsr;
 
 		if (fpcsr & SPR_FPCSR_IVF)
 			code = FPE_FLTINV;
@@ -197,7 +200,8 @@ asmlinkage void do_fpe_trap(struct pt_regs *regs, unsigned long address)
 			code = FPE_FLTRES;
 
 		/* Clear all flags */
-		regs->fpcsr &= ~SPR_FPCSR_ALLF;
+		current->thread.fpcsr &= ~SPR_FPCSR_ALLF;
+		restore_fpu(current);
 #endif
 		force_sig_fault(SIGFPE, code, (void __user *)regs->pc);
 	} else {
-- 
2.44.0



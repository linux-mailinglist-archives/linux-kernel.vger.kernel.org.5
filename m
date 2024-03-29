Return-Path: <linux-kernel+bounces-124363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB55989163E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5FC1C23D64
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029EF4CE05;
	Fri, 29 Mar 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQaUX9M9"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2912A41740
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705530; cv=none; b=DrEw8hFoDmR6IRiPmiwco1siDiuYhdMBWsH8N89OqgaQzUtI1wtNr7qc6ZnfjRuw8Ope1lLNNZQdTuk+QBWt2bLFIIdnJcidufTehG7lJCmBKN3wIxmLeLUGm9innXkrT/6dmvUQiVyaAYF6C1kCJJFBXtHdr+F3Fh73zhkUW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705530; c=relaxed/simple;
	bh=8ZqBDLqkzJhOIDLl8Y/8H56UOEL0dMMW+7eTzILboGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiiefrnYg3GLGeuNgkpcg4PaHMzi5ujT/SKIk22zgATV3eyvWKtY+nkrKeC8H6TINcv+nUTDTNbJodfoIfuSvZEpGwQTz0NgEszR3C6n277eUw0WK07LrFoHctE3c0F2JxcokTtmE2C/ct6Ad11PgLvirA0BB+97lSW66eRrW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQaUX9M9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4715991c32so232031366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711705526; x=1712310326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVGBLTjuVkklUYAT72ev6atT+zlvs6+r6Kq12ydIqsA=;
        b=gQaUX9M9iNvpr+EE4I6iLdg2Z118UTDi513Thuiq/RUJUHGEK0Ji6I10aiJuvkRUt6
         JHFULl7iHcZcay6N+tw/rn5l15OLI1tYJk4kGyksptlAqn5RvyRxu1/JdAdaN4QON8Q+
         f8U54ZjJeqMQ+7/gwfreKIGaD1Y8lTmJ+ljRBSx97neZDiGj3gSKRb8VnNwYBrgV1KJo
         6VWPktVoII3ED+WJsS04H4psfhRt0J5o57V7O5GqxIyIu+w5d48r6ZFbZBf65NhQzLoM
         iy/FUawWNGHKAD8b1/BA0GcdbaYU113HxGWHrfhUun7/ZEn8oSVPeNYhgy9PR4NonpEo
         A5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711705526; x=1712310326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVGBLTjuVkklUYAT72ev6atT+zlvs6+r6Kq12ydIqsA=;
        b=Yk+6nu1nhUS1zsv/OUkVzrIYzFn+0mNRuub24rREbrNZrccyUFIZrZNmt/UKRMwuvD
         JLrKgaU6+TTILPrpKfLoRhcLb/Bic58Qbm3aqECT9lZB8ovn5QDV+wTXmN1FUf1V6Di5
         ScqbYGwRMkK1YFkEJhwahWC21MXl4pW7rlSxyvMPQXC7Q6ra5whk/wi4f1nOcZz8aevt
         HweDBecictHNXPCKUU9jE0+lCoG7Y4st5Xxd6DJfXv3xbdrXLKPfvNoLPwLAEEqLc1p8
         hS299g3NAPorfgkAclqP0RbJfREhOMhCjjU8bVj1rRofuH1r8GLb1ylQAZNPedV9nyHw
         ykng==
X-Gm-Message-State: AOJu0YzeAKvyBocDzW1F1rPNEx5MH7Qe63yx8wDSivfPy/A8v0eSqlwC
	lECOTtDUoJVi2eIDIh3A3wmL03NPorTwhqFkmfab3WGJsFVv3CyR
X-Google-Smtp-Source: AGHT+IG76f6RVe0idvqL/fOsu74E8xg/KxDQ58Q2nT5EqDFfeejdmTO8rQax5OGbVbf7p2X1T+KvJA==
X-Received: by 2002:a17:906:6092:b0:a4e:15f9:f167 with SMTP id t18-20020a170906609200b00a4e15f9f167mr1021703ejj.11.1711705526050;
        Fri, 29 Mar 2024 02:45:26 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id b22-20020a170906d11600b00a46f95f5849sm1733003ejz.106.2024.03.29.02.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:45:25 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 29 Mar 2024 10:45:23 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 3/1] x86/fpu: Remove init_task FPU state dependencies, add
 debugging warning
Message-ID: <ZgaNs1lC2Y+AnRG4@gmail.com>
References: <20240320131908.2708438-1-mingo@kernel.org>
 <20240320131908.2708438-2-mingo@kernel.org>
 <20240326174903.GA4539@redhat.com>
 <ZgMeH9p0BTnMfmOM@gmail.com>
 <20240326215435.GB4539@redhat.com>
 <ZgaFfyHMOdLHEKm+@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgaFfyHMOdLHEKm+@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> >    	- exit_thread() - trivial
> > 
> > 	- arch_dup_task_struct() clears thread.fpu, but I guess this is unnecessary
> > 
> > 	- fpu_clone() initializes dst->thread.fpu, no longer needed
> > 
> > 	- finally, fpu__init_system_early_generic() which initializes the
> > 	  init_task.thread.fpu pointer.
> > 
> > 	  But this doesn't look difficult? Although I don't understand the magic in
> > 	  arch/x86/kernel/vmlinux.lds.S ...
> 
> Yeah.
> 
> Something like the patch below, on top of my previous patch.
> 
> The main/only fishy bit left is:
> 
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -172,6 +172,10 @@ SECTIONS
>                 /* init_task */
>                 INIT_TASK_DATA(THREAD_SIZE)
>  
> +               __x86_init_fpu_begin = .;
> +               . = __x86_init_fpu_begin + 128*PAGE_SIZE;
> +               __x86_init_fpu_end = .;
> 
> ... as we don't know the FPU context switch size in advance, and modern 
> vector CPUs can be huge. Plus CPU vendors like to push more crap into 
> the FPU context area (XSAVE area), because the rather opaque 
> enumeration and variable-size format makes OS support easier for them. 
> :-/
> 
> And in principle init_task should never use its task-fpu context switch 
> area for real, but I couldn't convince myself (yet) whether that's true 
> under all circumstances - and getting this wrong would be a memory 
> corruptor ...
> 
> kernel_fpu_begin_mask() has this:
> 
>         this_cpu_write(in_kernel_fpu, true);
> 
>         if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
>             !test_thread_flag(TIF_NEED_FPU_LOAD)) {
>                 set_thread_flag(TIF_NEED_FPU_LOAD);
>                 save_fpregs_to_fpstate(x86_task_fpu(current));
>         }
>         __cpu_invalidate_fpregs_state();
> 
> and the save_fpregs_to_fpstate() inside the branch should never execute 
> for init_task.

So there were a few places, the patch below should cure all warnings 
that I was able to trigger.

 - x86_64 boots to user-space in KVM/qemu
 - i386 math-emu boots to init (not sure if it works though)

Note that we weren't actually using src_fpu for anything useful in 
fpu_clone() anymore.

So this now looks like something that looks useful and clean, but the 
changes are quite a bit more scary than I wanted them to be ...

Thanks,

	Ingo


======================>
From: Ingo Molnar <mingo@kernel.org>
Date: Fri, 29 Mar 2024 10:33:27 +0100
Subject: [PATCH] x86/fpu: Remove init_task FPU state dependencies, add debugging warning

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/processor.h |  6 +++++-
 arch/x86/kernel/fpu/core.c       | 12 +++++++++---
 arch/x86/kernel/fpu/init.c       |  5 ++---
 arch/x86/kernel/fpu/xstate.c     |  3 ---
 arch/x86/kernel/vmlinux.lds.S    |  4 ----
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index fb78720774ea..d90c31e87b96 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -491,7 +491,11 @@ struct thread_struct {
 #endif
 };
 
-#define x86_task_fpu(task) ((struct fpu *)((void *)task + sizeof(*task)))
+#ifdef CONFIG_X86_DEBUG_FPU
+extern struct fpu *x86_task_fpu(struct task_struct *task);
+#else
+# define x86_task_fpu(task) ((struct fpu *)((void *)task + sizeof(*task)))
+#endif
 
 /*
  * X86 doesn't need any embedded-FPU-struct quirks:
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 0ccabcd3bf62..fdc3b227800d 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -51,6 +51,15 @@ static DEFINE_PER_CPU(bool, in_kernel_fpu);
  */
 DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
+#ifdef CONFIG_X86_DEBUG_FPU
+struct fpu *x86_task_fpu(struct task_struct *task)
+{
+	WARN_ON_ONCE(task == &init_task);
+
+	return (void *)task + sizeof(*task);
+}
+#endif
+
 /*
  * Can we use the FPU in kernel mode with the
  * whole "kernel_fpu_begin/end()" sequence?
@@ -591,10 +600,8 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	 * This is safe because task_struct size is a multiple of cacheline size.
 	 */
 	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
-	struct fpu *src_fpu = x86_task_fpu(current);
 
 	BUILD_BUG_ON(sizeof(*dst) % SMP_CACHE_BYTES != 0);
-	BUG_ON(!src_fpu);
 
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
@@ -657,7 +664,6 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	if (update_fpu_shstk(dst, ssp))
 		return 1;
 
-	trace_x86_fpu_copy_src(src_fpu);
 	trace_x86_fpu_copy_dst(dst_fpu);
 
 	return 0;
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 11aa31410df2..53580e59e5db 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -38,7 +38,7 @@ static void fpu__init_cpu_generic(void)
 	/* Flush out any pending x87 state: */
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU))
-		fpstate_init_soft(&x86_task_fpu(current)->fpstate->regs.soft);
+		;
 	else
 #endif
 		asm volatile ("fninit");
@@ -164,7 +164,7 @@ static void __init fpu__init_task_struct_size(void)
 	 * Subtract off the static size of the register state.
 	 * It potentially has a bunch of padding.
 	 */
-	task_size -= sizeof(x86_task_fpu(current)->__fpstate.regs);
+	task_size -= sizeof(union fpregs_state);
 
 	/*
 	 * Add back the dynamically-calculated register state
@@ -209,7 +209,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	fpu_kernel_cfg.default_size = size;
 	fpu_user_cfg.max_size = size;
 	fpu_user_cfg.default_size = size;
-	fpstate_reset(x86_task_fpu(current));
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index dade16d92484..75196e4d40bd 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -844,9 +844,6 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	if (err)
 		goto out_disable;
 
-	/* Reset the state for the current task */
-	fpstate_reset(x86_task_fpu(current));
-
 	/*
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index d21331187b20..56451fd2099e 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -172,10 +172,6 @@ SECTIONS
 		/* init_task */
 		INIT_TASK_DATA(THREAD_SIZE)
 
-		__x86_init_fpu_begin = .;
-		. = __x86_init_fpu_begin + 128*PAGE_SIZE;
-		__x86_init_fpu_end = .;
-
 #ifdef CONFIG_X86_32
 		/* 32 bit has nosave before _edata */
 		NOSAVE_DATA


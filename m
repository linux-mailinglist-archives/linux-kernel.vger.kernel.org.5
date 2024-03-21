Return-Path: <linux-kernel+bounces-110588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FED8860F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3831A283669
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C778A13440B;
	Thu, 21 Mar 2024 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J5hTRsz2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sbo62S3D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45130383A4;
	Thu, 21 Mar 2024 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049334; cv=none; b=L2mX/wjnEKNuEzA0hnDs5ieLnO3+575z69R4ALsEtcYNGULUU6E2rk4fbzRDKAwFa4rNYfoGY2SThAeX2L24uc6qi7r5N2ZX8YV4dCO+SxSKG4tD+kSFBX3Cl5JAhoB8+NklUfNTk8xFzrUFL4y0g2JiscXxT2qTLD96jsNyuKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049334; c=relaxed/simple;
	bh=+HfeYKVj40c/2f1PLoMFV40ylLLkAUWKHF/jm55a6ks=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aGadZzzsx2Dm3pphx5Pde1zMr/eq1AszT3lSoqeZj0xkVLBVaKm/9fSCQJV00XvkTashEmhnJhsvckBOADQtfOcjw2cYYazhOncJt/jqnFfFkgNqb8bi3i00IPAAp2aw20wD3OxcCtzKnVfFgKWVss3Zz75lekQ+AhT4PQRbKbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J5hTRsz2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sbo62S3D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Mar 2024 19:28:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711049329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJo4O80+v+kL2DH6Bjx3amWedhVg5KvDDDWnG1/kmDY=;
	b=J5hTRsz232CvVoG+IeI/qQDdE0a90l1+WWyDqYYsSq6nx+8bVD9OKxtRC3IFq/bssSsQ2+
	wX/GC+QftgbiqPtOk1m3gAGBZ7wqRoNIbncfzxmhyuXYFfZU6Tfsugl4aJesZcttIjAIRm
	AIwBy+bml4E8gTWQ9wOa7aDBXRO0IqtqkW6MxM9DPRNU49E84XwOiwPowIUDsozQO7ofba
	Gm0atHaN7cD2VIbphUwqmgBerA2wNePdluh9GJcvRB6uxXbXBuMpU278BOsMvSFd8g8AQF
	84L2dsbhiDKPFrx7nj5xRvBItup3BD+tyVTQYfKhKJaKUdI9PwAsTEgdVlANaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711049329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJo4O80+v+kL2DH6Bjx3amWedhVg5KvDDDWnG1/kmDY=;
	b=sbo62S3DnDiowNfCTMGsepGVaw+2OneGnBhGesdXxobQw17tcA4IJIpt4KZeqpquNbX49R
	97Sw9w6DLOrTWKCw==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Simplify boot stack setup
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <keescook@chromium.org>, Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240321180506.89030-1-brgerst@gmail.com>
References: <20240321180506.89030-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171104932866.10875.947190714531211341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     2cb16181a1d1f93a88f2b4640e7638fc0549da93
Gitweb:        https://git.kernel.org/tip/2cb16181a1d1f93a88f2b4640e7638fc0549da93
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 21 Mar 2024 14:05:06 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Mar 2024 20:17:54 +01:00

x86/boot: Simplify boot stack setup

Define the symbol __top_init_kernel_stack instead of duplicating
the offset from __end_init_task in multiple places.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20240321180506.89030-1-brgerst@gmail.com
---
 arch/x86/include/asm/processor.h |  6 ++----
 arch/x86/kernel/head_32.S        | 11 +----------
 arch/x86/kernel/head_64.S        |  2 +-
 arch/x86/kernel/vmlinux.lds.S    |  3 +++
 arch/x86/xen/xen-head.S          |  2 +-
 5 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 811548f..7fa01d9 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -636,12 +636,10 @@ static __always_inline void prefetchw(const void *x)
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
 
 #else
-extern unsigned long __end_init_task[];
+extern unsigned long __top_init_kernel_stack[];
 
 #define INIT_THREAD {							\
-	.sp	= (unsigned long)&__end_init_task -			\
-		  TOP_OF_KERNEL_STACK_PADDING -				\
-		  sizeof(struct pt_regs),				\
+	.sp	= (unsigned long)&__top_init_kernel_stack,		\
 }
 
 extern unsigned long KSTK_ESP(struct task_struct *task);
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index b50f364..a9de527 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -44,9 +44,6 @@
 #define X86_CAPABILITY	new_cpu_data+CPUINFO_x86_capability
 #define X86_VENDOR_ID	new_cpu_data+CPUINFO_x86_vendor_id
 
-
-#define SIZEOF_PTREGS 17*4
-
 /*
  * Worst-case size of the kernel mapping we need to make:
  * a relocatable kernel can live anywhere in lowmem, so we need to be able
@@ -488,13 +485,7 @@ SYM_DATA_END(initial_page_table)
 
 .data
 .balign 4
-/*
- * The SIZEOF_PTREGS gap is a convention which helps the in-kernel unwinder
- * reliably detect the end of the stack.
- */
-SYM_DATA(initial_stack,
-		.long init_thread_union + THREAD_SIZE -
-		SIZEOF_PTREGS - TOP_OF_KERNEL_STACK_PADDING)
+SYM_DATA(initial_stack, .long __top_init_kernel_stack)
 
 __INITRODATA
 int_msg:
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d8198fb..b115268 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -66,7 +66,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	mov	%rsi, %r15
 
 	/* Set up the stack for verify_cpu() */
-	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %rsp
+	leaq	__top_init_kernel_stack(%rip), %rsp
 
 	/* Setup GSBASE to allow stack canary access for C code */
 	movl	$MSR_GS_BASE, %ecx
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 56451fd..91085c3 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -172,6 +172,9 @@ SECTIONS
 		/* init_task */
 		INIT_TASK_DATA(THREAD_SIZE)
 
+		/* equivalent to task_pt_regs(&init_task) */
+		__top_init_kernel_stack = __end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
+
 #ifdef CONFIG_X86_32
 		/* 32 bit has nosave before _edata */
 		NOSAVE_DATA
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 04101b9..758bcd4 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -49,7 +49,7 @@ SYM_CODE_START(startup_xen)
 	ANNOTATE_NOENDBR
 	cld
 
-	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %rsp
+	leaq	__top_init_kernel_stack(%rip), %rsp
 
 	/* Set up %gs.
 	 *


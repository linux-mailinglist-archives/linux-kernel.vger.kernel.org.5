Return-Path: <linux-kernel+bounces-95374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA7F874CF2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FEAFB2105A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42C31272D0;
	Thu,  7 Mar 2024 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wSj6yqwI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mABmpsMR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB9125DC;
	Thu,  7 Mar 2024 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809504; cv=none; b=MCO3oaUDf59n8VaGTZn8upgnFJgJFUOgRZIwrvttsjJA6344hfdNgdowqCLMD1Fgq/TcluMYeikn4zt9kYcOBHCeMFR2x0c+zb21c4LR9NalhfFPX9amq+p6JtgNkY0uRYZdOJiODBi1CbWs3dNepJpaspVN1cwtYng1u33fbo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809504; c=relaxed/simple;
	bh=F3t8FaPQ09tQDMQog6mg69yl7F1+FtKNnDjllV7epLE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZqQPfUxg1oAdecqRBhtrLc1YG89tXOwrFUVKUmwYgL5SbS9Gqn9F5TD6VaR90qZVM5Pr5zVs+3qwJjObI7m6GbNs/f0V5UTVEJK0MbE5FlP1CLaJLEopswblJiQiPv/uR39qC0azNUWUgxPky8g02UZOZcS48Sew2sGgSGPzubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wSj6yqwI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mABmpsMR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Mar 2024 11:04:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709809500;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vdyP2JtRhbiv6tYNm/WH+U05mCm+Ipea64ow94GYdIw=;
	b=wSj6yqwIdwPSoQICbU0XwTTLxnHNwdTKrNg28WqGuzs8bJ2LV3StZSbabNJBmPhgFu8eTH
	xdhGZaGGXPdqVRk7sfrsYVEBxUARyj1mQ1L/iSLVmQNTVpLNtpnJP3YO6WNy9WeJ4KvYFh
	Do5thwA3qFWz5i2cugdZ5/NuI1Z6Ox27MSwAo6zZOiv8JGAfWeY/E3C+w0wu05AXs9pJhK
	EpMJMUFAiDnrCmMJuifiauVAVAQtu7cjEikMAXdNCddRHimL5qxLgcsfcJitsmd+J9/8Dp
	sUELTMwtPyz/W87mVu/7BiYM84RKwscoOizpMsMaSUm/henztfnUfIiHeTg8vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709809500;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vdyP2JtRhbiv6tYNm/WH+U05mCm+Ipea64ow94GYdIw=;
	b=mABmpsMRfq1/ykpXNLGyr8rSOEWH9HWQnqp9DGMDrQtrFFEo2+zj9/nGwa4jppdX9FG0JD
	n2yExLotoYYqR5BA==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fred] x86/fred: Fix init_task thread stack pointer initialization
Cc: kernel test robot <oliver.sang@intel.com>,
 "Xin Li (Intel)" <xin@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240304083333.449322-1-xin@zytor.com>
References: <20240304083333.449322-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170980949947.398.16492968721974685258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     c416b5bac6ad6ffe21e36225553b82ff2ec1558c
Gitweb:        https://git.kernel.org/tip/c416b5bac6ad6ffe21e36225553b82ff2ec1558c
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Mon, 04 Mar 2024 00:33:33 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Mar 2024 11:55:36 +01:00

x86/fred: Fix init_task thread stack pointer initialization

As TOP_OF_KERNEL_STACK_PADDING was defined as 0 on x86_64, it went
unnoticed that the initialization of the .sp field in INIT_THREAD and some
calculations in the low level startup code do not take the padding into
account.

FRED enabled kernels require a 16 byte padding, which means that the init
task initialization and the low level startup code use the wrong stack
offset.

Subtract TOP_OF_KERNEL_STACK_PADDING in all affected places to adjust for
this.

Fixes: 65c9cc9e2c14 ("x86/fred: Reserve space for the FRED stack frame")
Fixes: 3adee777ad0d ("x86/smpboot: Remove initial_stack on 64-bit")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Closes: https://lore.kernel.org/oe-lkp/202402262159.183c2a37-lkp@intel.com
Link: https://lore.kernel.org/r/20240304083333.449322-1-xin@zytor.com
---
 arch/x86/include/asm/processor.h | 6 ++++--
 arch/x86/kernel/head_64.S        | 3 ++-
 arch/x86/xen/xen-head.S          | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 26620d7..17fe819 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -664,8 +664,10 @@ static __always_inline void prefetchw(const void *x)
 #else
 extern unsigned long __end_init_task[];
 
-#define INIT_THREAD {							    \
-	.sp	= (unsigned long)&__end_init_task - sizeof(struct pt_regs), \
+#define INIT_THREAD {							\
+	.sp	= (unsigned long)&__end_init_task -			\
+		  TOP_OF_KERNEL_STACK_PADDING -				\
+		  sizeof(struct pt_regs),				\
 }
 
 extern unsigned long KSTK_ESP(struct task_struct *task);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d4918d0..c38e435 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -26,6 +26,7 @@
 #include <asm/apicdef.h>
 #include <asm/fixmap.h>
 #include <asm/smp.h>
+#include <asm/thread_info.h>
 
 /*
  * We are not able to switch in one step to the final KERNEL ADDRESS SPACE
@@ -66,7 +67,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	mov	%rsi, %r15
 
 	/* Set up the stack for verify_cpu() */
-	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
+	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %rsp
 
 	leaq	_text(%rip), %rdi
 
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index a0ea285..04101b9 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -49,7 +49,7 @@ SYM_CODE_START(startup_xen)
 	ANNOTATE_NOENDBR
 	cld
 
-	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
+	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %rsp
 
 	/* Set up %gs.
 	 *


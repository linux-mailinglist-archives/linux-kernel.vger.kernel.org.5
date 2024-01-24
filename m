Return-Path: <linux-kernel+bounces-36822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B2383A762
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC10B2B9FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91101AACF;
	Wed, 24 Jan 2024 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2DcGhpOH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="07fimyZK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B88517C77;
	Wed, 24 Jan 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093971; cv=none; b=j/r0rSziJgmuYQ4uI6d9GclZyTS7tbPdkk4+XG4JUYYkDE+a79S83T6yYVgMEVyt78d6OtpaFg892CnvWZka0rle9WZDiGJ15DbqHEHGa/MxqsLsHSvaeiD2T2c3H+TaTKR5SwYf/r6tV/ilJiT6A/1BlicD0wpg3X5yi64Z2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093971; c=relaxed/simple;
	bh=iANTKlkk8kboCZHGDwmiDI19Ll50/82WGLR5pyIiZLU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PzNBcgFiUDYTEF63IGZZPJELF7U7HDYb3aoGSGdb/wO8jx3Y7RMWRL9TGuvqDBx8KyO5oA+0pkyWAWhRuWooHkdyQ5H7AoLVTEF1EiFEpknOpt3SmP+2OzcWYzviFx8wGxn+rzgw4pNgiqy8Cw347TKOamTLW0rcgNTuL22nY7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2DcGhpOH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=07fimyZK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Jan 2024 10:59:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706093967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLlO4ku6OA4dToBd4MX789ltiTlW+kyLL+eTVIinh/4=;
	b=2DcGhpOHrocxse4ocDc5FRQDYUwHhJDE7JJkcfXkMl5MknAdxyZI9l59SQO18vzlcOehtw
	rnHRB+nwWGXtFyj6EIF1VlSbxPQvd6X6kN6NiXstIUsM9wSSzl2Ehp7RxoYyIgU//X86IB
	o0XD1Hf1MDvaUVZ498ijo3HV14Z6/Fp6wiPLwOQEAZDbgahrPuMWr/iYZNbq93AoCWxjaR
	ZCmgOgwHcVQpn2ZqaMSa7Im+5NdADAQf+Srwd9c7t8+EZZq8ekLXgFJePzzigKSQbmzAgV
	ZdhbOtENijlb4kfuJGghW4aXN2aV0hIULLEw+9nNOSR8tuTxVP4GubiEbpKe+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706093967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLlO4ku6OA4dToBd4MX789ltiTlW+kyLL+eTVIinh/4=;
	b=07fimyZKO16BomOcKz+4JJy+2W8+uPbbz7826wkbXnnkk004L+KWkHeX7siuPn2AprmzfB
	KAELLrY5xTw7exAg==
From: "tip-bot2 for Richard Palethorpe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry/ia32: Ensure s32 is sign extended to s64
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Palethorpe <rpalethorpe@suse.com>,
 Nikolay Borisov <nik.borisov@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240110130122.3836513-1-nik.borisov@suse.com>
References: <20240110130122.3836513-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170609396629.398.14744181776916062395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     56062d60f117dccfb5281869e0ab61e090baf864
Gitweb:        https://git.kernel.org/tip/56062d60f117dccfb5281869e0ab61e090baf864
Author:        Richard Palethorpe <rpalethorpe@suse.com>
AuthorDate:    Wed, 10 Jan 2024 15:01:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Jan 2024 11:49:19 +01:00

x86/entry/ia32: Ensure s32 is sign extended to s64

Presently ia32 registers stored in ptregs are unconditionally cast to
unsigned int by the ia32 stub. They are then cast to long when passed to
__se_sys*, but will not be sign extended.

This takes the sign of the syscall argument into account in the ia32
stub. It still casts to unsigned int to avoid implementation specific
behavior. However then casts to int or unsigned int as necessary. So that
the following cast to long sign extends the value.

This fixes the io_pgetevents02 LTP test when compiled with -m32. Presently
the systemcall io_pgetevents_time64() unexpectedly accepts -1 for the
maximum number of events.

It doesn't appear other systemcalls with signed arguments are effected
because they all have compat variants defined and wired up.

Fixes: ebeb8c82ffaf ("syscalls/x86: Use 'struct pt_regs' based syscall calling for IA32_EMULATION and x32")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240110130122.3836513-1-nik.borisov@suse.com
Link: https://lore.kernel.org/ltp/20210921130127.24131-1-rpalethorpe@suse.com/
---
 arch/x86/include/asm/syscall_wrapper.h | 25 +++++++++++++++++++++----
 include/linux/syscalls.h               |  1 +-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 21f9407..7e88705 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -58,12 +58,29 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 		,,regs->di,,regs->si,,regs->dx				\
 		,,regs->r10,,regs->r8,,regs->r9)			\
 
+
+/* SYSCALL_PT_ARGS is Adapted from s390x */
+#define SYSCALL_PT_ARG6(m, t1, t2, t3, t4, t5, t6)			\
+	SYSCALL_PT_ARG5(m, t1, t2, t3, t4, t5), m(t6, (regs->bp))
+#define SYSCALL_PT_ARG5(m, t1, t2, t3, t4, t5)				\
+	SYSCALL_PT_ARG4(m, t1, t2, t3, t4),  m(t5, (regs->di))
+#define SYSCALL_PT_ARG4(m, t1, t2, t3, t4)				\
+	SYSCALL_PT_ARG3(m, t1, t2, t3),  m(t4, (regs->si))
+#define SYSCALL_PT_ARG3(m, t1, t2, t3)					\
+	SYSCALL_PT_ARG2(m, t1, t2), m(t3, (regs->dx))
+#define SYSCALL_PT_ARG2(m, t1, t2)					\
+	SYSCALL_PT_ARG1(m, t1), m(t2, (regs->cx))
+#define SYSCALL_PT_ARG1(m, t1) m(t1, (regs->bx))
+#define SYSCALL_PT_ARGS(x, ...) SYSCALL_PT_ARG##x(__VA_ARGS__)
+
+#define __SC_COMPAT_CAST(t, a)						\
+	(__typeof(__builtin_choose_expr(__TYPE_IS_L(t), 0, 0U)))	\
+	(unsigned int)a
+
 /* Mapping of registers to parameters for syscalls on i386 */
 #define SC_IA32_REGS_TO_ARGS(x, ...)					\
-	__MAP(x,__SC_ARGS						\
-	      ,,(unsigned int)regs->bx,,(unsigned int)regs->cx		\
-	      ,,(unsigned int)regs->dx,,(unsigned int)regs->si		\
-	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
+	SYSCALL_PT_ARGS(x, __SC_COMPAT_CAST,				\
+			__MAP(x, __SC_TYPE, __VA_ARGS__))		\
 
 #define __SYS_STUB0(abi, name)						\
 	long __##abi##_##name(const struct pt_regs *regs);		\
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index cdba4d0..77eb9b0 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -128,6 +128,7 @@ struct mnt_id_req;
 #define __TYPE_IS_LL(t) (__TYPE_AS(t, 0LL) || __TYPE_AS(t, 0ULL))
 #define __SC_LONG(t, a) __typeof(__builtin_choose_expr(__TYPE_IS_LL(t), 0LL, 0L)) a
 #define __SC_CAST(t, a)	(__force t) a
+#define __SC_TYPE(t, a)	t
 #define __SC_ARGS(t, a)	a
 #define __SC_TEST(t, a) (void)BUILD_BUG_ON_ZERO(!__TYPE_IS_LL(t) && sizeof(t) > sizeof(long))
 


Return-Path: <linux-kernel+bounces-108869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228BD88111D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432651C22AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AA43F9D2;
	Wed, 20 Mar 2024 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EHLSjC1N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LqQqa1kk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C60B3CF6A;
	Wed, 20 Mar 2024 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934764; cv=none; b=ZUpVgESa8qOTIJSXYmLWBloBFfI+4LQo01lqyrWiD5P2a3IpJXObR4nhUl6cuJ/3hM+v0O1RaAk+BatMbOqbIWbi1BNMjjQFyJVODUnz6cdD4Bw4RyPB+peXksK76RFHjKHwnN8/HQvMYSeNQIAp915CuQZcko7tRyVRUJvCAs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934764; c=relaxed/simple;
	bh=jIgEtsF7ZyIMIxyuNTCdT3L6w4xlOz2tkLW4F+UoDQ8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XuI+gQeSnNhRszwhNagRBx/wivVqHawv6qb9wfvPZJmBGR15m06bYaiGToyNczRRpGmQfsuTZ72YEormKcWN+8z6AddS/XZRPQ0ukMukBZUFvZkUt1cz7SEiOch8AJ4s9XS5Q/W96UKypLriryOEDfm5dP7GVjACJPnSOrA+Myw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EHLSjC1N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LqQqa1kk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Mar 2024 11:39:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710934760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FmKrlwo6K+OzVjE/c/n5/6AUV9qxvSPCEYbMNQmUmjc=;
	b=EHLSjC1N4lQLGsZpGhj0B9/PqrzCRvNa4nkJcI/SoudX1sZKQcIROKzoEDm0q+6LzNiKek
	HW2GbjGP6IEWrxVGFccj/ldDw9nYrIxz8XAM04E3h/UmNbqT7ngpb8TqzNOJP+ElbaGt1p
	oQ8l1PK1dlaQX8RrPIu1W2Tu7l+EUh0s6KCfRgUCx0zGbcN5G3P2XVFbtLLY8lwb/4FdHm
	amWfJD7oo5nsKzxrERtUNb6VMnRLc5MvarD7/HHUOF11iax6jqTc8GZ4cg/CFdkcUmne1a
	8vwlA2l4s73L3sGwnpgooziYGEPOc6lz7EeBgAcrrmEajLJPeQhKQlzpOiQHpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710934760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FmKrlwo6K+OzVjE/c/n5/6AUV9qxvSPCEYbMNQmUmjc=;
	b=LqQqa1kkbysomm45bM68zN9aDz4QomY50M5IlCRpE6fwCRhfnOGUfVr0eL4wY6Dez0U6nm
	2FGFtwSo1HMeDJBw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Convert this_percpu_xchg_op() from
 asm() to C code, to generate better code
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240320083127.493250-1-ubizjak@gmail.com>
References: <20240320083127.493250-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171093476000.10875.14076471223590027773.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     0539084639f3835c8d0b798e6659ec14a266b4f1
Gitweb:        https://git.kernel.org/tip/0539084639f3835c8d0b798e6659ec14a266b4f1
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 20 Mar 2024 09:30:40 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 20 Mar 2024 12:29:02 +01:00

x86/percpu: Convert this_percpu_xchg_op() from asm() to C code, to generate better code

Rewrite percpu_xchg_op() using generic percpu primitives instead
of using asm. The new implementation is similar to local_xchg() and
allows the compiler to perform various optimizations: e.g. the
compiler is able to create fast path through the loop, according
to likely/unlikely annotations in percpu_try_cmpxchg_op().

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240320083127.493250-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 44958eb..de991e6 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -230,25 +230,15 @@ do {									\
 })
 
 /*
- * xchg is implemented using cmpxchg without a lock prefix. xchg is
- * expensive due to the implied lock prefix.  The processor cannot prefetch
- * cachelines if xchg is used.
+ * this_cpu_xchg() is implemented using cmpxchg without a lock prefix.
+ * xchg is expensive due to the implied lock prefix. The processor
+ * cannot prefetch cachelines if xchg is used.
  */
-#define percpu_xchg_op(size, qual, _var, _nval)				\
+#define this_percpu_xchg_op(_var, _nval)				\
 ({									\
-	__pcpu_type_##size pxo_old__;					\
-	__pcpu_type_##size pxo_new__ = __pcpu_cast_##size(_nval);	\
-	asm qual (__pcpu_op2_##size("mov", __percpu_arg([var]),		\
-				    "%[oval]")				\
-		  "\n1:\t"						\
-		  __pcpu_op2_##size("cmpxchg", "%[nval]",		\
-				    __percpu_arg([var]))		\
-		  "\n\tjnz 1b"						\
-		  : [oval] "=&a" (pxo_old__),				\
-		    [var] "+m" (__my_cpu_var(_var))			\
-		  : [nval] __pcpu_reg_##size(, pxo_new__)		\
-		  : "memory");						\
-	(typeof(_var))(unsigned long) pxo_old__;			\
+	typeof(_var) pxo_old__ = this_cpu_read(_var);			\
+	do { } while (!this_cpu_try_cmpxchg(_var, &pxo_old__, _nval));	\
+	pxo_old__;							\
 })
 
 /*
@@ -534,9 +524,9 @@ do {									\
 #define this_cpu_or_1(pcp, val)		percpu_to_op(1, volatile, "or", (pcp), val)
 #define this_cpu_or_2(pcp, val)		percpu_to_op(2, volatile, "or", (pcp), val)
 #define this_cpu_or_4(pcp, val)		percpu_to_op(4, volatile, "or", (pcp), val)
-#define this_cpu_xchg_1(pcp, nval)	percpu_xchg_op(1, volatile, pcp, nval)
-#define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(2, volatile, pcp, nval)
-#define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(4, volatile, pcp, nval)
+#define this_cpu_xchg_1(pcp, nval)	this_percpu_xchg_op(pcp, nval)
+#define this_cpu_xchg_2(pcp, nval)	this_percpu_xchg_op(pcp, nval)
+#define this_cpu_xchg_4(pcp, nval)	this_percpu_xchg_op(pcp, nval)
 
 #define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, , pcp, val)
 #define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, , pcp, val)
@@ -575,7 +565,7 @@ do {									\
 #define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
 #define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
-#define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(8, volatile, pcp, nval)
+#define this_cpu_xchg_8(pcp, nval)		this_percpu_xchg_op(pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
 #define this_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, volatile, pcp, ovalp, nval)
 #endif


Return-Path: <linux-kernel+bounces-111338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A509886ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C801F2353E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743B53FE52;
	Fri, 22 Mar 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vGe67JcL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kGrOyUqt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AD13F9E7;
	Fri, 22 Mar 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105165; cv=none; b=lOEiZSSBJm+fVZiBwpRw/fTIj5p+sHNwErVWmYoeqYE3r4DDVTHPmo/+MDmsVB6JNiZSAVFAesZqrKN0QqIpoEIFOiDyIWbF5sAZDKwdhoyEYigK175FpRhjNe9H6YCwAVWdIaf1MQK3i7z3QloGPdOr4nHitCCCSkNlzGwu+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105165; c=relaxed/simple;
	bh=6y0SKQP3yg6vtCvcWYd+vp+JKLb8VWhaYpIGqyabjVU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m6NxfVR1aIQZaKIy/F73cYQg4THyWr8mB1F/FhRC1UCtDqcrA5Gw6wmjCi9maWWpgGjie9yj8DYgKiqHAgu8eAspjd2wL4uUQCFODNwaHtOf6AfeHbVbNfZ4I7CPmCFhm3NDXquM3pDaH7WVI11KleH7DcAX15NQKdV2t08LyZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vGe67JcL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kGrOyUqt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 10:59:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711105162;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vEhqtTPlY1TvYFcXQO0SZFnOE9PzEWsix7+imOWO1w=;
	b=vGe67JcLFJCYQqmooohRfmyHainVE5yfJ5xnTU36TY4u+33OzzVs9ZksFT2lTwdClQr6/j
	qCOjbwmHtbjvZ9Z8+9Az9YC11olegr6rO1jmkvi3Eyl3DOLroAhrQs6pMWKF0cT3kywYC0
	R0Rsit1KdnrYFPVjznZlupfi4vBZ8g6TGYmCoG+7DBIgvfWH1NAfStKclpmZifIdmstsCj
	M1qSVRBA1k0CaIqGswPn36ks+FMADE2wPwGOdgZwAgIJ4wxEvy2xPDD/cK+jStd0xcfb25
	gOrtVahBZH48mzj76l5qPB/Vhbr7tHHoekoDupkMiKWMei3vJ1kuh5E4tvyxpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711105162;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vEhqtTPlY1TvYFcXQO0SZFnOE9PzEWsix7+imOWO1w=;
	b=kGrOyUqti5y5HY78ZYmB4cI3qKJXRR4hzafY8qBVkqRJKIiPAaydopSiiNb7ajx95xZKss
	05/huNv6NCuFA0Bg==
From: "tip-bot2 for Alexey Dobriyan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm/64: Clean up memset16(), memset32(),
 memset64() assembly constraints in <asm/string_64.h>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240314165715.31831-1-adobriyan@gmail.com>
References: <20240314165715.31831-1-adobriyan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171110516145.10875.12682506155345317874.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     4c9a93800121e90484cd07c8e5bde70e31cdb996
Gitweb:        https://git.kernel.org/tip/4c9a93800121e90484cd07c8e5bde70e31cdb996
Author:        Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate:    Thu, 14 Mar 2024 19:57:15 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 11:47:34 +01:00

x86/asm/64: Clean up memset16(), memset32(), memset64() assembly constraints in <asm/string_64.h>

- Use "+" constraint modifier,
  simplify inputs and output lists,
  delete dummy variables with meaningless names,

  "&" only makes sense in complex assembly creating constraints on
  intermediate registers. But 1 instruction assemblies don't have
  inner body so to speak.

- Write "rep stos*" on one line:
  Rep prefix is integral part of x86 instruction.  I'm not sure why
  people separate "rep" with newline.

  Uros Bizjak adds context: "some archaic assemblers rejected 'rep
  insn' on one line. I have checked that the minimum required
  binutils-2.25 assembles this without problems."

- Use __auto_type for maximum copy pasta experience,

- Reformat a bit to make everything looks nicer.

Note that "memory" clobber is too much if "n" is known at compile time.
However,

	"=m" (*(T(*)[n])s)

doesn't work because -Wvla even if "n" is compile time constant:

	if (BCP(n)) {
		rep stos
		: "=m" (*(T(*)[n])s)
	} else {
		rep stosw
		: "memory"
	}

The above doesn't work.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20240314165715.31831-1-adobriyan@gmail.com
---
 arch/x86/include/asm/string_64.h | 45 ++++++++++++++++---------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 857d364..9d0b324 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -30,37 +30,40 @@ void *__memset(void *s, int c, size_t n);
 #define __HAVE_ARCH_MEMSET16
 static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
 {
-	long d0, d1;
-	asm volatile("rep\n\t"
-		     "stosw"
-		     : "=&c" (d0), "=&D" (d1)
-		     : "a" (v), "1" (s), "0" (n)
-		     : "memory");
-	return s;
+	const __auto_type s0 = s;
+	asm volatile (
+		"rep stosw"
+		: "+D" (s), "+c" (n)
+		: "a" (v)
+		: "memory"
+	);
+	return s0;
 }
 
 #define __HAVE_ARCH_MEMSET32
 static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
 {
-	long d0, d1;
-	asm volatile("rep\n\t"
-		     "stosl"
-		     : "=&c" (d0), "=&D" (d1)
-		     : "a" (v), "1" (s), "0" (n)
-		     : "memory");
-	return s;
+	const __auto_type s0 = s;
+	asm volatile (
+		"rep stosl"
+		: "+D" (s), "+c" (n)
+		: "a" (v)
+		: "memory"
+	);
+	return s0;
 }
 
 #define __HAVE_ARCH_MEMSET64
 static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
 {
-	long d0, d1;
-	asm volatile("rep\n\t"
-		     "stosq"
-		     : "=&c" (d0), "=&D" (d1)
-		     : "a" (v), "1" (s), "0" (n)
-		     : "memory");
-	return s;
+	const __auto_type s0 = s;
+	asm volatile (
+		"rep stosq"
+		: "+D" (s), "+c" (n)
+		: "a" (v)
+		: "memory"
+	);
+	return s0;
 }
 #endif
 


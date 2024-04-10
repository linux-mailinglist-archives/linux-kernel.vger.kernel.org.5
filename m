Return-Path: <linux-kernel+bounces-138649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8051789F8A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201C51F31B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B9816C6BE;
	Wed, 10 Apr 2024 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XeZ9MEUL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZR4q1wq/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8BE160794;
	Wed, 10 Apr 2024 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756448; cv=none; b=J8uanHfxyZehGP8Bmt01XmJFlOlPc3gDeKfKXgLZyfkPF7YZp/pHRhgOkqgE+9itcgrNFiQZKCliyQYvZoMPFBm0y94vCgPcx0s0oRLgXsA5l+aTFOA6HJtaCir2/dKNTc98vQgHQ//UMte4QvE5NqKYz66yOfLyp+55n4jeLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756448; c=relaxed/simple;
	bh=lS2wAJlv9vHs26aEAM5WtMattKCVBOHwOMNqQcFbpM0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vD3WwryTnQxDR0xFzbP9cjKbbuYC+8Er2HRzcyAlyR4WaC0Otxm2Tg1I62ZSfrl8J4IGIBbzCewu2Qf+Ub/spCNNv9jqtTeO6EosxGZyotseTRqVvLFCJVRBF18UFUwAO3O8q3Y7W2hFIehdeYtyx/HWdQ82jtbIJ6j33rSfKJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XeZ9MEUL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZR4q1wq/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 13:40:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712756445;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yv26R+87wEE+nKst0Y+g1S8z9zoX2tfido4QcbH1Ep4=;
	b=XeZ9MEULrBTyjQoSiBU+LkkgP8uZSEfyWaDK2wtLH5WkX2BWqIEn9l5jY/gqy8XWqYoSd1
	FMf3gK2rG9HLM9WWZ+vohB4TDyDB7IJ4o4WVq5HwBvwH4GJYgoCFzItlJxRuGKRaAiAWjX
	uK8wIxonEghWQlmvrKlwULA9l+Az+kYejri7+vaHBUlLjSSh/J/ZDtdz0QzHdgYgXNsdnk
	Y/AnboJBRiCRci+NjGdhOxaoon47ghQtiKUE6zFKiC4LcM2OrlhA0EjQUkkUg44RIKT0Vw
	tA6IvYQl99g0hPd4wm3G1L39eg5STCigVFK57zSAjmkDch9hPYxASnfi3H2Juw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712756445;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yv26R+87wEE+nKst0Y+g1S8z9zoX2tfido4QcbH1Ep4=;
	b=ZR4q1wq/xt6lSIdlemcavFI5H9f9N1YnZQwjbyvVlWDI4bRyIzIA1z58eVdcfYQvWIWNjB
	+hnnVQRNWVrPL9Dw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic/x86: Introduce
 arch_atomic64_try_cmpxchg() to x86_32
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240410062957.322614-1-ubizjak@gmail.com>
References: <20240410062957.322614-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171275644458.10875.1545164334846847591.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     276b893049e4cdc2f33c009706a75ec18a114485
Gitweb:        https://git.kernel.org/tip/276b893049e4cdc2f33c009706a75ec18a114485
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 10 Apr 2024 08:29:33 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 15:04:54 +02:00

locking/atomic/x86: Introduce arch_atomic64_try_cmpxchg() to x86_32

Introduce arch_atomic64_try_cmpxchg() for 32-bit targets to use
optimized target specific implementation instead of a generic one.
This implementation eliminates dual-word compare after
cmpxchg8b instruction and improves generated asm code from:

    2273:	f0 0f c7 0f          	lock cmpxchg8b (%edi)
    2277:	8b 74 24 2c          	mov    0x2c(%esp),%esi
    227b:	89 d3                	mov    %edx,%ebx
    227d:	89 c2                	mov    %eax,%edx
    227f:	89 5c 24 10          	mov    %ebx,0x10(%esp)
    2283:	8b 7c 24 30          	mov    0x30(%esp),%edi
    2287:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    228b:	31 f2                	xor    %esi,%edx
    228d:	89 d0                	mov    %edx,%eax
    228f:	89 da                	mov    %ebx,%edx
    2291:	31 fa                	xor    %edi,%edx
    2293:	09 d0                	or     %edx,%eax
    2295:	0f 85 a5 00 00 00    	jne    2340 <...>

to:

    2270:	f0 0f c7 0f          	lock cmpxchg8b (%edi)
    2274:	0f 85 a6 00 00 00    	jne    2320 <...>

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240410062957.322614-1-ubizjak@gmail.com
---
 arch/x86/include/asm/atomic64_32.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 3486d91..ec217aa 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -61,12 +61,18 @@ ATOMIC64_DECL(add_unless);
 #undef __ATOMIC64_DECL
 #undef ATOMIC64_EXPORT
 
-static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
+static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
-	return arch_cmpxchg64(&v->counter, o, n);
+	return arch_cmpxchg64(&v->counter, old, new);
 }
 #define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
 
+static __always_inline bool arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	return arch_try_cmpxchg64(&v->counter, old, new);
+}
+#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
+
 static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
 {
 	s64 o;


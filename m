Return-Path: <linux-kernel+bounces-136451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E8689D42D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDC228338A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDCB7E771;
	Tue,  9 Apr 2024 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F2mcTU0f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="huHaCY7Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204107E57F;
	Tue,  9 Apr 2024 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651199; cv=none; b=te8OhExapjUNr+akbcMKuUwh/2fLSU5Cd9wyiLG1VeMlO/fP8ADlWQTrvkO3am9faHqcvb+dB6k7UVcZ24JNXlnfl7MG1+LFXKLJi9ODemfPvlruNlZ5oTO4cF/WHPYy1d2L7zibirR7PuYlr5jDsjJJ2rkrnIYsc0fiZtXGpv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651199; c=relaxed/simple;
	bh=y7Hdc8CIKymFFlxQ+P0ZbjSbM1SIMMlRpvkobw7V4K4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MUYVQcJW62F3XuiJ1pLuBLT3668ss0LQDpZ8qHsVZ045tkHhI+Ot9TMSSoWPl1PQjvH7TYKpK5wA3/dMJC2xalt8knJwp8+vykKNefq3KEBfKNdaNZnW5b4c2JYBpWqv46ezdiXIFF4EMProh4ditRyN0tHQfUSxj8JsnNpW2ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F2mcTU0f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=huHaCY7Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 08:26:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712651196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzeKglEuprUW0bEz9+MBpsvB8AZtkFzWDRLtCSu/l14=;
	b=F2mcTU0f5mbNXDSDqGTZtc6UOVzDxiiVEm9VgBoaZL0eJXg7XarKmLq254fJmLMLEGdWoS
	iMlvnK6BD0tiByexOEWiOEvOVDyAjarJodZhf/hM1xrc3NzbALOIF48cZGLsD7GGxJ9mVS
	iYzuuL30oIQlunaZdAg1ddUHHyPNuMeRczahJUZPMka8kEQB3j7MUE9nfgIS8hSSkUHvJ0
	NcVhZE790omFk8gmwexelZqenjU98+nBGSECFYC2cq6sx4eGztHvQfY1gndxY8sRnY9AzP
	fsQ1h0Vju8qWXpM+WzcgOT0IQGsLWHcms05kA+KUH0ZSbZnZRUz8DrfZFqwttg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712651196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzeKglEuprUW0bEz9+MBpsvB8AZtkFzWDRLtCSu/l14=;
	b=huHaCY7Y1I78kZG+KH2RgHPTeBKIWfHLppkCH9EzvoJ5pFeNcntY0E81LLDrlFkEmQN3O3
	AFk+d8pxUcinIGBQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic/x86: Introduce
 arch_try_cmpxchg64() for !CONFIG_X86_CMPXCHG64
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240408091547.90111-4-ubizjak@gmail.com>
References: <20240408091547.90111-4-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171265119516.10875.17878292059342759156.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     aef95dac9ce4f271cc43195ffc175114ed934cbe
Gitweb:        https://git.kernel.org/tip/aef95dac9ce4f271cc43195ffc175114ed934cbe
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 08 Apr 2024 11:13:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 09 Apr 2024 09:51:03 +02:00

locking/atomic/x86: Introduce arch_try_cmpxchg64() for !CONFIG_X86_CMPXCHG64

Commit:

  6d12c8d308e68 ("percpu: Wire up cmpxchg128")

improved emulated cmpxchg8b_emu() library function to return
success/failure in a ZF flag.

Define arch_try_cmpxchg64() for !CONFIG_X86_CMPXCHG64 targets
to override the generic archy_try_cmpxchg() with an optimized
target specific implementation that handles ZF flag.

The assembly code at the call sites improves from:

   bf56d:	e8 fc ff ff ff       	call   cmpxchg8b_emu
   bf572:	8b 74 24 28          	mov    0x28(%esp),%esi
   bf576:	89 c3                	mov    %eax,%ebx
   bf578:	89 d1                	mov    %edx,%ecx
   bf57a:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
   bf57e:	89 f0                	mov    %esi,%eax
   bf580:	89 fa                	mov    %edi,%edx
   bf582:	31 d8                	xor    %ebx,%eax
   bf584:	31 ca                	xor    %ecx,%edx
   bf586:	09 d0                	or     %edx,%eax
   bf588:	0f 84 e3 01 00 00    	je     bf771 <...>

to:

   bf572:	e8 fc ff ff ff       	call   cmpxchg8b_emu
   bf577:	0f 84 b6 01 00 00    	je     bf733 <...>

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20240408091547.90111-4-ubizjak@gmail.com
---
 arch/x86/include/asm/cmpxchg_32.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index fe40d06..9e0d330 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -122,6 +122,34 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64 
 }
 #define arch_cmpxchg64_local arch_cmpxchg64_local
 
+#define __arch_try_cmpxchg64_emu(_ptr, _oldp, _new)			\
+({									\
+	union __u64_halves o = { .full = *(_oldp), },			\
+			   n = { .full = (_new), };			\
+	bool ret;							\
+									\
+	asm volatile(ALTERNATIVE(LOCK_PREFIX_HERE			\
+				 "call cmpxchg8b_emu",			\
+				 "lock; cmpxchg8b %[ptr]", X86_FEATURE_CX8) \
+		     CC_SET(e)						\
+		     : CC_OUT(e) (ret),					\
+		       [ptr] "+m" (*(_ptr)),				\
+		       "+a" (o.low), "+d" (o.high)			\
+		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
+		     : "memory");					\
+									\
+	if (unlikely(!ret))						\
+		*(_oldp) = o.full;					\
+									\
+	likely(ret);							\
+})
+
+static __always_inline bool arch_try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 new)
+{
+	return __arch_try_cmpxchg64_emu(ptr, oldp, new);
+}
+#define arch_try_cmpxchg64 arch_try_cmpxchg64
+
 #endif
 
 #define system_has_cmpxchg64()		boot_cpu_has(X86_FEATURE_CX8)


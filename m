Return-Path: <linux-kernel+bounces-144397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A65B8A456E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4932280FF4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BF3136985;
	Sun, 14 Apr 2024 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TgU2dkTk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UP9jHp7j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998E638F83;
	Sun, 14 Apr 2024 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713127604; cv=none; b=eT+YdWZP8lL+Mi3mLiHVv/noizLCzogS0sWY0BdlPYpykJlFJgTgiODE36ORR1rmPX/6dsqgtNAWc1rUjhGAtBKeYSL8vJ0dH5uLHCyvYFOd7G/1KrJBGTMgDicQuxyTDu7R8CIJS1jvHDofuJsJWwM10oKUlpFQMLsnYe60ZBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713127604; c=relaxed/simple;
	bh=XDvQz8Cb3JriCvXnVGnz6ggpgm/OLowXPtVOYaRL0fw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zahow7xV7Y2cHr3SB1Ro77S9UGWfbf0a1FibOAfFzzJhFxq4Lzt2IOTsvWB/lHJoHyotU0rmgbC5Yl4T/CYZ2X+1lhPwGmu6+fT7NW4jiMzHXRD/DdqVhBbQAwL0qch9CWzfEPMIf2ICe42DsuO0uaBhXvbLHVlhk6xAZqhjUeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TgU2dkTk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UP9jHp7j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Apr 2024 20:46:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713127600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Zq2qNCG7YYCKkCBpYl3nPheD8UbaNfedd0Pr1nDN0o=;
	b=TgU2dkTkrj/04ljsW/tpyq67LfTvCle2gxEwrRj8ppTeQ3KlKEUK4ZYkIGlFHzEWFa8i9x
	d86dQ+YPep9yZuukbMAzQpwKHepONmaal1W1AqGny0/cGBIv9z+/pIs4R8v2dTtkbkX8oN
	Yc9vr/Ri1SAivF8dAeNFkbAdq/ErNfdklTju2Alyry1+dvotCnmE6CvZoQYzyXDNdF4Imx
	RL+rs06NujDCowqgcvrYxFsksWE26827W7hVcFc63XpfzsZZREjdMVuGJbsFaMfX+oUXoi
	1g8Ae+DzOyEEezyfAHeWuG8WEX9q9lPfP3tTNxKhXDbsVlxN5daZwGdt98oQmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713127600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Zq2qNCG7YYCKkCBpYl3nPheD8UbaNfedd0Pr1nDN0o=;
	b=UP9jHp7jopD7I/XP2Ypu1bKs/RcIz2fQidjDlKy0OaWmxApEjiqRxb3KUo3CIs+0m6w+Oo
	7XqC1Okf82rUF+CQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] locking/atomic/x86: Introduce arch_try_cmpxchg64_local()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Waiman Long <longman@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240414161257.49145-1-ubizjak@gmail.com>
References: <20240414161257.49145-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171312759954.10875.1385994404712358986.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d26e46f6bf329cfcc469878709baa41d3bfc7cc3
Gitweb:        https://git.kernel.org/tip/d26e46f6bf329cfcc469878709baa41d3bfc7cc3
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 14 Apr 2024 18:12:43 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Apr 2024 22:40:54 +02:00

locking/atomic/x86: Introduce arch_try_cmpxchg64_local()

Introduce arch_try_cmpxchg64_local() for 64-bit and 32-bit targets
to improve code using cmpxchg64_local().  On 64-bit targets, the
generated assembly improves from:

    3e28:	31 c0                	xor    %eax,%eax
    3e2a:	4d 0f b1 7d 00       	cmpxchg %r15,0x0(%r13)
    3e2f:	48 85 c0             	test   %rax,%rax
    3e32:	0f 85 9f 00 00 00    	jne    3ed7 <...>

to:

    3e28:	31 c0                	xor    %eax,%eax
    3e2a:	4d 0f b1 7d 00       	cmpxchg %r15,0x0(%r13)
    3e2f:	0f 85 9f 00 00 00    	jne    3ed4 <...>

where a TEST instruction after CMPXCHG is saved.  The improvements
for 32-bit targets are even more noticeable, because double-word
compare after CMPXCHG8B gets eliminated.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20240414161257.49145-1-ubizjak@gmail.com
---
 arch/x86/include/asm/cmpxchg_32.h | 34 ++++++++++++++++++++++++++++++-
 arch/x86/include/asm/cmpxchg_64.h |  6 +++++-
 2 files changed, 40 insertions(+)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 9e0d330..9dedc13 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -64,6 +64,11 @@ static __always_inline bool __try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 ne
 	return __arch_try_cmpxchg64(ptr, oldp, new, LOCK_PREFIX);
 }
 
+static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp, u64 new)
+{
+	return __arch_try_cmpxchg64(ptr, oldp, new,);
+}
+
 #ifdef CONFIG_X86_CMPXCHG64
 
 #define arch_cmpxchg64 __cmpxchg64
@@ -72,6 +77,8 @@ static __always_inline bool __try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 ne
 
 #define arch_try_cmpxchg64 __try_cmpxchg64
 
+#define arch_try_cmpxchg64_local __try_cmpxchg64_local
+
 #else
 
 /*
@@ -150,6 +157,33 @@ static __always_inline bool arch_try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64
 }
 #define arch_try_cmpxchg64 arch_try_cmpxchg64
 
+#define __arch_try_cmpxchg64_emu_local(_ptr, _oldp, _new)		\
+({									\
+	union __u64_halves o = { .full = *(_oldp), },			\
+			   n = { .full = (_new), };			\
+	bool ret;							\
+									\
+	asm volatile(ALTERNATIVE("call cmpxchg8b_emu",			\
+				 "cmpxchg8b %[ptr]", X86_FEATURE_CX8)	\
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
+static __always_inline bool arch_try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp, u64 new)
+{
+	return __arch_try_cmpxchg64_emu_local(ptr, oldp, new);
+}
+#define arch_try_cmpxchg64_local arch_try_cmpxchg64_local
+
 #endif
 
 #define system_has_cmpxchg64()		boot_cpu_has(X86_FEATURE_CX8)
diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index c1d6cd5..5e24130 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -20,6 +20,12 @@
 	arch_try_cmpxchg((ptr), (po), (n));				\
 })
 
+#define arch_try_cmpxchg64_local(ptr, po, n)				\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	arch_try_cmpxchg_local((ptr), (po), (n));			\
+})
+
 union __u128_halves {
 	u128 full;
 	struct {


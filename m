Return-Path: <linux-kernel+bounces-138647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5A889F89E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0E31F31B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD0C160885;
	Wed, 10 Apr 2024 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rhFViKRS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hW6946aq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918B415F3F2;
	Wed, 10 Apr 2024 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756447; cv=none; b=iRHzcHSE/fkP8WAWP8x0+uzBKaunA58kpeSpOeo5HfhN58Uv6rdiKM8pFlD3+rwhE2pkNxcojHN983i6p8KcHmek47RHC6MnXM39n7kqNQCyxcLFCihMOfbmaANZKpwMyrifbtAWLg6IMn4XDyFMlUKT1z7Xe4BJ9OSDDrti4dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756447; c=relaxed/simple;
	bh=r+YL/s4TO2w8eDSHzE746jw/Jqq9LchRmN1sUgRfVDI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pcSSrNA5H/I62IyV8gadmHxlR+2sMS4rZK5q8ZqXfnaUbpGesRqePrDlBic+2MofJESx0lNX1ZtXFfNxcLkBBAZjjkMTSyUVjc7s1RqM4mMu1U+Dk9Tl6M/16JTmBv9oyKJn43M2eR49QwswNYxKZzYRtUjLI2Mh7h0THVJBMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rhFViKRS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hW6946aq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 13:40:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712756443;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7UKQ4mEOM6UiOSUJ++bzGCRJzOETaASMTzibHrJaA0=;
	b=rhFViKRSVqTbqRYEPBRsra3GligdoaVfllRMtS2epuOSLSQAXU8zpp3nZ/AuBz6j8Wo1K9
	sQC2cj7Owq382ZtjbP1MKRTzDu8227SznFboV5rj2qS1PCDluFPS0UdZYM5W+QL3fO4duC
	fwkrrcq6ca4EXII2iIIbXtjqitIwaiqQGbR5U/PHWspDGxqjEh/sv3BWcWQojfxavGRBef
	vC5A3lgE9nj1UBnFl+p6C/pacGQmcm+YBCwDJTYj5RYwnZ14710wtOMX5BOn3AiNGdcGNQ
	0697+UFJgsvgktYyAqVdFt3LBVQKnqgjdlWHfYiMFYg31wb87KougSkyfHPtDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712756443;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7UKQ4mEOM6UiOSUJ++bzGCRJzOETaASMTzibHrJaA0=;
	b=hW6946aqQiXDld3M/HjGfw0Y94KM+oIPHORnuvO/ZEJ2DPR5KOM5ZZL7omEz3XrcVYLYwr
	TwZi62heQp0E/WCQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic/x86: Rewrite x86_32
 arch_atomic64_{,fetch}_{and,or,xor}() functions
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240410062957.322614-3-ubizjak@gmail.com>
References: <20240410062957.322614-3-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171275644304.10875.8866491281215486852.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     95ece48165c136b96fae0f6144f55cbf8b24aeb9
Gitweb:        https://git.kernel.org/tip/95ece48165c136b96fae0f6144f55cbf8b24aeb9
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 10 Apr 2024 08:29:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 15:04:55 +02:00

locking/atomic/x86: Rewrite x86_32 arch_atomic64_{,fetch}_{and,or,xor}() functions

Rewrite x86_32 arch_atomic64_{,fetch}_{and,or,xor}() functions to
use arch_atomic64_try_cmpxchg().  This implementation avoids one extra
trip through the CMPXCHG loop.

The value preload before the cmpxchg loop does not need to be atomic.
Use arch_atomic64_read_nonatomic(v) to load the value from atomic_t
location in a non-atomic way.

The generated code improves from:

  1917d5:	31 c9                	xor    %ecx,%ecx
  1917d7:	31 db                	xor    %ebx,%ebx
  1917d9:	89 4c 24 3c          	mov    %ecx,0x3c(%esp)
  1917dd:	8b 74 24 24          	mov    0x24(%esp),%esi
  1917e1:	89 c8                	mov    %ecx,%eax
  1917e3:	89 5c 24 34          	mov    %ebx,0x34(%esp)
  1917e7:	8b 7c 24 28          	mov    0x28(%esp),%edi
  1917eb:	21 ce                	and    %ecx,%esi
  1917ed:	89 74 24 4c          	mov    %esi,0x4c(%esp)
  1917f1:	21 df                	and    %ebx,%edi
  1917f3:	89 de                	mov    %ebx,%esi
  1917f5:	89 7c 24 50          	mov    %edi,0x50(%esp)
  1917f9:	8b 54 24 4c          	mov    0x4c(%esp),%edx
  1917fd:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
  191801:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  191805:	89 d3                	mov    %edx,%ebx
  191807:	89 f2                	mov    %esi,%edx
  191809:	f0 0f c7 0f          	lock cmpxchg8b (%edi)
  19180d:	89 c1                	mov    %eax,%ecx
  19180f:	8b 74 24 34          	mov    0x34(%esp),%esi
  191813:	89 d3                	mov    %edx,%ebx
  191815:	89 44 24 4c          	mov    %eax,0x4c(%esp)
  191819:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  19181d:	89 df                	mov    %ebx,%edi
  19181f:	89 54 24 44          	mov    %edx,0x44(%esp)
  191823:	89 ca                	mov    %ecx,%edx
  191825:	31 de                	xor    %ebx,%esi
  191827:	31 c8                	xor    %ecx,%eax
  191829:	09 f0                	or     %esi,%eax
  19182b:	75 ac                	jne    1917d9 <...>

to:

  1912ba:	8b 06                	mov    (%esi),%eax
  1912bc:	8b 56 04             	mov    0x4(%esi),%edx
  1912bf:	89 44 24 3c          	mov    %eax,0x3c(%esp)
  1912c3:	89 c1                	mov    %eax,%ecx
  1912c5:	23 4c 24 34          	and    0x34(%esp),%ecx
  1912c9:	89 d3                	mov    %edx,%ebx
  1912cb:	23 5c 24 38          	and    0x38(%esp),%ebx
  1912cf:	89 54 24 40          	mov    %edx,0x40(%esp)
  1912d3:	89 4c 24 2c          	mov    %ecx,0x2c(%esp)
  1912d7:	89 5c 24 30          	mov    %ebx,0x30(%esp)
  1912db:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
  1912df:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  1912e3:	f0 0f c7 0e          	lock cmpxchg8b (%esi)
  1912e7:	0f 85 f3 02 00 00    	jne    1915e0 <...>

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240410062957.322614-3-ubizjak@gmail.com
---
 arch/x86/include/asm/atomic64_32.h | 43 ++++++++++++-----------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index bbdf174..40ff73b 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -227,69 +227,62 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 
 static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_nonatomic(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c & i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
 }
 
 static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_nonatomic(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c & i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
 
-	return old;
+	return val;
 }
 #define arch_atomic64_fetch_and arch_atomic64_fetch_and
 
 static __always_inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_nonatomic(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c | i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
 }
 
 static __always_inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_nonatomic(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c | i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
 
-	return old;
+	return val;
 }
 #define arch_atomic64_fetch_or arch_atomic64_fetch_or
 
 static __always_inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_nonatomic(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c ^ i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
 }
 
 static __always_inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_nonatomic(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c ^ i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
 
-	return old;
+	return val;
 }
 #define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
 
 static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_nonatomic(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c + i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val + i));
 
-	return old;
+	return val;
 }
 #define arch_atomic64_fetch_add arch_atomic64_fetch_add
 


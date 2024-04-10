Return-Path: <linux-kernel+bounces-138646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 276C389F98E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54449B2DA28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6352F160791;
	Wed, 10 Apr 2024 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jvFi/zyq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QVxF36Uo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEAF15F414;
	Wed, 10 Apr 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756446; cv=none; b=WIKARD9dXZDIbduY60fPX7ExZuuKn/wS1dyRZwrwYrBHH4WRuNcEapESC2kat9LztRDWSXZjkS1Qcy2kdWNNykP7pB4qgYKAmewsBWT9wIGpbLm8ShjwKXdXazGWzUqnAeIiIWuDfyATESAXI7nOxHsRSD+CRKh8w1pUjm2ysxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756446; c=relaxed/simple;
	bh=Oz89WHzjw+FTm8xOgOWva8jNJyhAzC2obZxCBzvZ6s0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BFEJihLKIkvEe9RsoRVZgyWhoxjNdsDzQTHJB87yxdK9IThGH2KvLC2LbTcGY+lW/a8a7rMYreh6XO0lnka/BvFb+jUlbPHU+6NwxsXMRafeUkL5IaJy2uiuAmjupN2shLtUVMFW1uqBW9i+ry4sQnFf0eftIDJamMHzzrEu38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jvFi/zyq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QVxF36Uo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 13:40:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712756443;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4a/0iPTh25XDi18Dad2RBs8rPcG18kGqADItpnM1dM=;
	b=jvFi/zyqpCav7lj1ZibHci8i17mpuD/0x0x2dk70N5fvYz+v0DVno//MCxIufI2j5V8D1z
	HA8uDXivB7hSu6LFfNgTg+GaHi9aUvUfm4gPR9ZUsvELbOcFHNZR+XJz0fQp0preOB+glZ
	iuGBhKIykUcaMpwq1R1PhjmjEzs3QjT8mG/2L9piYiZLK1bfB+NL+ozXoonsVfId097CML
	N4a0rzvO3GnfJKBGxdppaj0w9Ct+Ldt7w6Q6F4hFdmLXBhMFkFj5DM0qTZ1Q8Rkue75e8Z
	oeRVBnmrg/90PiOsngo4268iay1f+Z6S+0y18uQEB/Ys0TQw+rbD/0xEOt3ohA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712756443;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4a/0iPTh25XDi18Dad2RBs8rPcG18kGqADItpnM1dM=;
	b=QVxF36Uogv1rG335+gjn/WeN/phUNhd7G8ctHriWRv1AVxUXzPeilE1dh7wm26/ChRKqPw
	Kh7Xe4q+cEC4MaDw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic/x86: Define arch_atomic_sub()
 family using arch_atomic_add() functions
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240410062957.322614-4-ubizjak@gmail.com>
References: <20240410062957.322614-4-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171275644218.10875.6269916472621161567.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     21689e4bfb9ae8f8b45279c53faecaa5a056ffa5
Gitweb:        https://git.kernel.org/tip/21689e4bfb9ae8f8b45279c53faecaa5a056ffa5
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 10 Apr 2024 08:29:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 15:04:55 +02:00

locking/atomic/x86: Define arch_atomic_sub() family using arch_atomic_add() functions

There is no need to implement arch_atomic_sub() family of inline
functions, corresponding macros can be directly implemented using
arch_atomic_add() inlines with negated argument.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240410062957.322614-4-ubizjak@gmail.com
---
 arch/x86/include/asm/atomic.h      | 12 ++----------
 arch/x86/include/asm/atomic64_64.h | 12 ++----------
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 55a55ec..55b4d24 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -86,11 +86,7 @@ static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
 }
 #define arch_atomic_add_return arch_atomic_add_return
 
-static __always_inline int arch_atomic_sub_return(int i, atomic_t *v)
-{
-	return arch_atomic_add_return(-i, v);
-}
-#define arch_atomic_sub_return arch_atomic_sub_return
+#define arch_atomic_sub_return(i, v) arch_atomic_add_return(-(i), v)
 
 static __always_inline int arch_atomic_fetch_add(int i, atomic_t *v)
 {
@@ -98,11 +94,7 @@ static __always_inline int arch_atomic_fetch_add(int i, atomic_t *v)
 }
 #define arch_atomic_fetch_add arch_atomic_fetch_add
 
-static __always_inline int arch_atomic_fetch_sub(int i, atomic_t *v)
-{
-	return xadd(&v->counter, -i);
-}
-#define arch_atomic_fetch_sub arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub(i, v) arch_atomic_fetch_add(-(i), v)
 
 static __always_inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 3165c0f..ae12aca 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -80,11 +80,7 @@ static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_add_return arch_atomic64_add_return
 
-static __always_inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_add_return(-i, v);
-}
-#define arch_atomic64_sub_return arch_atomic64_sub_return
+#define arch_atomic64_sub_return(i, v) arch_atomic64_add_return(-(i), v)
 
 static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
@@ -92,11 +88,7 @@ static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_fetch_add arch_atomic64_fetch_add
 
-static __always_inline s64 arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
-{
-	return xadd(&v->counter, -i);
-}
-#define arch_atomic64_fetch_sub arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub(i, v) arch_atomic64_fetch_add(-(i), v)
 
 static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {


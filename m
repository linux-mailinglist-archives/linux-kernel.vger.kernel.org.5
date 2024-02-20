Return-Path: <linux-kernel+bounces-72660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 494B985B6CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE6D2848B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650E95FDC6;
	Tue, 20 Feb 2024 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DjSjmbkt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nu92yMkg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7305F550;
	Tue, 20 Feb 2024 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420089; cv=none; b=kaiZvgmVHTacxr11EQ0KoN3c+jqnaLh6HI+1ZYnXe2aTHtv5rjHpCKU0BI83NhsVucZUPimzrjO9hSvFVEctdbwazOuIgtFFb0vKwgEVzW2G6lwhljmWIdVOnByjoRgrdlMYK9RtKapJ/yWXEzZW08AEyT5kKHLfmysWrxANjV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420089; c=relaxed/simple;
	bh=Djr7OvT0LeTiN+aNu2jpX1T7Tugm9AMi84tG+N/OMBA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fx1k95b8HFfmIj6TVTuqanQSbusenZBMiSTwy6/R2jSoTA+xsuyFlpoYXVdK8i+qfRYUF74eXxJe2DyS2vbWMzGfFx7gjpQPb4FzCyF282etqVEJNhEv9f9YPFt6jPPVEIXilgh1aczQHctLCeKiK2qS6L3OKvTBZQE1mRz1R2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DjSjmbkt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nu92yMkg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 09:08:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708420084;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SxTE6zxkrMJ6ptiyZuh/sa+6vpn72x1Poj1KTgEY3qc=;
	b=DjSjmbktL4NslpQfFIohYeng2Wb0+QNVBJtQ28u3tFlIHhnSwA4sxJM34juhHFct9lRECA
	7LT2kutcITSeVrJuiVzPmGy79RN2Red3qZZsoKjY2Lkas5vOoeCdfQ4o/pePSJMY72ffyh
	6AaewUlVVwBuFPRsiMXDvz1lcxODa5l9JEXhLAuAqb6MXSnGbzmEvVpD+0pPlaZqG665Am
	0f8q8HozrmxP1TgYj8jIs6PLOFQcM29laAsk0L1Mm7MTpThiLegx03oYflhEq3IQ66zWkt
	0uX1GVvbxyAk+rtHL26Sw29Ejoaj3nt29CbSeRBe7wKBWE4mLU6npj2/nW9UJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708420084;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SxTE6zxkrMJ6ptiyZuh/sa+6vpn72x1Poj1KTgEY3qc=;
	b=Nu92yMkggy576Dxk0uqxbT8so9/s5KZkPq2WJReBQEcpvXqHoMYhKB1KcOzViC2+mACx2H
	Fnga/nhbm79CWGCA==
From: "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: scripts: Clarify ordering of
 conditional atomics
Cc: Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240209124010.2096198-1-mark.rutland@arm.com>
References: <20240209124010.2096198-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170842008342.398.1840342475536652899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6dfee110c6cc7a6c3c1f45a07428c15820b87c1d
Gitweb:        https://git.kernel.org/tip/6dfee110c6cc7a6c3c1f45a07428c15820b87c1d
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Fri, 09 Feb 2024 12:40:10 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 20 Feb 2024 09:55:09 +01:00

locking/atomic: scripts: Clarify ordering of conditional atomics

Conditional atomic operations (e.g. cmpxchg()) only provide ordering
when the condition holds; when the condition does not hold, the location
is not modified and relaxed ordering is provided. Where ordering is
needed for failed conditional atomics, it is necessary to use
smp_mb__before_atomic() and/or smp_mb__after_atomic().

This is explained tersely in memory-barriers.txt, and is implied but not
explicitly stated in the kerneldoc comments for the conditional
operations. The lack of an explicit statement has lead to some off-list
queries about the ordering semantics of failing conditional operations,
so evidently this is confusing.

Update the kerneldoc comments to explicitly describe the lack of ordering
for failed conditional atomic operations.

For most conditional atomic operations, this is written as:

  | If (${condition}), atomically updates @v to (${new}) with ${desc_order} ordering.
  | Otherwise, @v is not modified and relaxed ordering is provided.

For the try_cmpxchg() operations, this is written as:

  | If (${condition}), atomically updates @v to @new with ${desc_order} ordering.
  | Otherwise, @v is not modified, @old is updated to the current value of @v,
  | and relaxed ordering is provided.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Link: https://lore.kernel.org/r/20240209124010.2096198-1-mark.rutland@arm.com
---
 include/linux/atomic/atomic-arch-fallback.h  | 46 ++++++++++---
 include/linux/atomic/atomic-instrumented.h   | 68 +++++++++++++++----
 include/linux/atomic/atomic-long.h           | 24 +++++--
 scripts/atomic/kerneldoc/add_unless          |  1 +-
 scripts/atomic/kerneldoc/cmpxchg             |  1 +-
 scripts/atomic/kerneldoc/dec_if_positive     |  1 +-
 scripts/atomic/kerneldoc/dec_unless_positive |  1 +-
 scripts/atomic/kerneldoc/inc_not_zero        |  1 +-
 scripts/atomic/kerneldoc/inc_unless_negative |  1 +-
 scripts/atomic/kerneldoc/try_cmpxchg         |  3 +-
 10 files changed, 119 insertions(+), 28 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 5e95faa..956bcba 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -2005,6 +2005,7 @@ raw_atomic_xchg_relaxed(atomic_t *v, int new)
  * @new: int value to assign
  *
  * If (@v == @old), atomically updates @v to @new with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_cmpxchg() elsewhere.
  *
@@ -2033,6 +2034,7 @@ raw_atomic_cmpxchg(atomic_t *v, int old, int new)
  * @new: int value to assign
  *
  * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_cmpxchg_acquire() elsewhere.
  *
@@ -2061,6 +2063,7 @@ raw_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
  * @new: int value to assign
  *
  * If (@v == @old), atomically updates @v to @new with release ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_cmpxchg_release() elsewhere.
  *
@@ -2088,6 +2091,7 @@ raw_atomic_cmpxchg_release(atomic_t *v, int old, int new)
  * @new: int value to assign
  *
  * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_cmpxchg_relaxed() elsewhere.
  *
@@ -2112,7 +2116,8 @@ raw_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
  * @new: int value to assign
  *
  * If (@v == @old), atomically updates @v to @new with full ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_try_cmpxchg() elsewhere.
  *
@@ -2145,7 +2150,8 @@ raw_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
  * @new: int value to assign
  *
  * If (@v == @old), atomically updates @v to @new with acquire ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_try_cmpxchg_acquire() elsewhere.
  *
@@ -2178,7 +2184,8 @@ raw_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
  * @new: int value to assign
  *
  * If (@v == @old), atomically updates @v to @new with release ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_try_cmpxchg_release() elsewhere.
  *
@@ -2210,7 +2217,8 @@ raw_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
  * @new: int value to assign
  *
  * If (@v == @old), atomically updates @v to @new with relaxed ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_try_cmpxchg_relaxed() elsewhere.
  *
@@ -2403,6 +2411,7 @@ raw_atomic_add_negative_relaxed(int i, atomic_t *v)
  * @u: int value to compare with
  *
  * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_fetch_add_unless() elsewhere.
  *
@@ -2432,6 +2441,7 @@ raw_atomic_fetch_add_unless(atomic_t *v, int a, int u)
  * @u: int value to compare with
  *
  * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_add_unless() elsewhere.
  *
@@ -2452,6 +2462,7 @@ raw_atomic_add_unless(atomic_t *v, int a, int u)
  * @v: pointer to atomic_t
  *
  * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_inc_not_zero() elsewhere.
  *
@@ -2472,6 +2483,7 @@ raw_atomic_inc_not_zero(atomic_t *v)
  * @v: pointer to atomic_t
  *
  * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_inc_unless_negative() elsewhere.
  *
@@ -2499,6 +2511,7 @@ raw_atomic_inc_unless_negative(atomic_t *v)
  * @v: pointer to atomic_t
  *
  * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_dec_unless_positive() elsewhere.
  *
@@ -2526,6 +2539,7 @@ raw_atomic_dec_unless_positive(atomic_t *v)
  * @v: pointer to atomic_t
  *
  * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_dec_if_positive() elsewhere.
  *
@@ -4117,6 +4131,7 @@ raw_atomic64_xchg_relaxed(atomic64_t *v, s64 new)
  * @new: s64 value to assign
  *
  * If (@v == @old), atomically updates @v to @new with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic64_cmpxchg() elsewhere.
  *
@@ -4145,6 +4160,7 @@ raw_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
  * @new: s64 value to assign
  *
  * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic64_cmpxchg_acquire() elsewhere.
  *
@@ -4173,6 +4189,7 @@ raw_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
  * @new: s64 value to assign
  *
  * If (@v == @old), atomically updates @v to @new with release ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic64_cmpxchg_release() elsewhere.
  *
@@ -4200,6 +4217,7 @@ raw_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
  * @new: s64 value to assign
  *
  * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic64_cmpxchg_relaxed() elsewhere.
  *
@@ -4224,7 +4242,8 @@ raw_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
  * @new: s64 value to assign
  *
  * If (@v == @old), atomically updates @v to @new with full ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic64_try_cmpxchg() elsewhere.
  *
@@ -4257,7 +4276,8 @@ raw_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
  * @new: s64 value to assign
  *
  * If (@v == @old), atomically updates @v to @new with acquire ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic64_try_cmpxchg_acquire() elsewhere.
  *
@@ -4290,7 +4310,8 @@ raw_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
  * @new: s64 value to assign
  *
  * If (@v == @old), atomically updates @v to @new with release ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic64_try_cmpxchg_release() elsewhere.
  *
@@ -4322,7 +4343,8 @@ raw_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
  * @new: s64 value to assign
  *
  * If (@v == @old), atomically updates @v to @new with relaxed ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic64_try_cmpxchg_relaxed() elsewhere.
  *
@@ -4515,6 +4537,7 @@ raw_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
  * @u: s64 value to compare with
  *
  * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic64_fetch_add_unless() elsewhere.
  *
@@ -4544,6 +4567,7 @@ raw_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
  * @u: s64 value to compare with
  *
  * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic64_add_unless() elsewhere.
  *
@@ -4564,6 +4588,7 @@ raw_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
  * @v: pointer to atomic64_t
  *
  * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic64_inc_not_zero() elsewhere.
  *
@@ -4584,6 +4609,7 @@ raw_atomic64_inc_not_zero(atomic64_t *v)
  * @v: pointer to atomic64_t
  *
  * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic64_inc_unless_negative() elsewhere.
  *
@@ -4611,6 +4637,7 @@ raw_atomic64_inc_unless_negative(atomic64_t *v)
  * @v: pointer to atomic64_t
  *
  * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic64_dec_unless_positive() elsewhere.
  *
@@ -4638,6 +4665,7 @@ raw_atomic64_dec_unless_positive(atomic64_t *v)
  * @v: pointer to atomic64_t
  *
  * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic64_dec_if_positive() elsewhere.
  *
@@ -4662,4 +4690,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// eec048affea735b8464f58e6d96992101f8f85f1
+// 14850c0b0db20c62fdc78ccd1d42b98b88d76331
diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index 54d7bbe..debd487 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -1182,6 +1182,7 @@ atomic_xchg_relaxed(atomic_t *v, int new)
  * @new: int value to assign
  *
  * If (@v == @old), atomically updates @v to @new with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_cmpxchg() there.
  *
@@ -1202,6 +1203,7 @@ atomic_cmpxchg(atomic_t *v, int old, int new)
  * @new: int value to assign
  *
  * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_cmpxchg_acquire() there.
  *
@@ -1221,6 +1223,7 @@ atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
  * @new: int value to assign
  *
  * If (@v == @old), atomically updates @v to @new with release ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_cmpxchg_release() there.
  *
@@ -1241,6 +1244,7 @@ atomic_cmpxchg_release(atomic_t *v, int old, int new)
  * @new: int value to assign
  *
  * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_cmpxchg_relaxed() there.
  *
@@ -1260,7 +1264,8 @@ atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
  * @new: int value to assign
  *
  * If (@v == @old), atomically updates @v to @new with full ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg() there.
  *
@@ -1282,7 +1287,8 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
  * @new: int value to assign
  *
  * If (@v == @old), atomically updates @v to @new with acquire ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg_acquire() there.
  *
@@ -1303,7 +1309,8 @@ atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
  * @new: int value to assign
  *
  * If (@v == @old), atomically updates @v to @new with release ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg_release() there.
  *
@@ -1325,7 +1332,8 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
  * @new: int value to assign
  *
  * If (@v == @old), atomically updates @v to @new with relaxed ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg_relaxed() there.
  *
@@ -1475,6 +1483,7 @@ atomic_add_negative_relaxed(int i, atomic_t *v)
  * @u: int value to compare with
  *
  * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_fetch_add_unless() there.
  *
@@ -1495,6 +1504,7 @@ atomic_fetch_add_unless(atomic_t *v, int a, int u)
  * @u: int value to compare with
  *
  * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_add_unless() there.
  *
@@ -1513,6 +1523,7 @@ atomic_add_unless(atomic_t *v, int a, int u)
  * @v: pointer to atomic_t
  *
  * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_inc_not_zero() there.
  *
@@ -1531,6 +1542,7 @@ atomic_inc_not_zero(atomic_t *v)
  * @v: pointer to atomic_t
  *
  * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_inc_unless_negative() there.
  *
@@ -1549,6 +1561,7 @@ atomic_inc_unless_negative(atomic_t *v)
  * @v: pointer to atomic_t
  *
  * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_dec_unless_positive() there.
  *
@@ -1567,6 +1580,7 @@ atomic_dec_unless_positive(atomic_t *v)
  * @v: pointer to atomic_t
  *
  * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_dec_if_positive() there.
  *
@@ -2746,6 +2760,7 @@ atomic64_xchg_relaxed(atomic64_t *v, s64 new)
  * @new: s64 value to assign
  *
  * If (@v == @old), atomically updates @v to @new with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic64_cmpxchg() there.
  *
@@ -2766,6 +2781,7 @@ atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
  * @new: s64 value to assign
  *
  * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic64_cmpxchg_acquire() there.
  *
@@ -2785,6 +2801,7 @@ atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
  * @new: s64 value to assign
  *
  * If (@v == @old), atomically updates @v to @new with release ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic64_cmpxchg_release() there.
  *
@@ -2805,6 +2822,7 @@ atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
  * @new: s64 value to assign
  *
  * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic64_cmpxchg_relaxed() there.
  *
@@ -2824,7 +2842,8 @@ atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
  * @new: s64 value to assign
  *
  * If (@v == @old), atomically updates @v to @new with full ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic64_try_cmpxchg() there.
  *
@@ -2846,7 +2865,8 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
  * @new: s64 value to assign
  *
  * If (@v == @old), atomically updates @v to @new with acquire ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic64_try_cmpxchg_acquire() there.
  *
@@ -2867,7 +2887,8 @@ atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
  * @new: s64 value to assign
  *
  * If (@v == @old), atomically updates @v to @new with release ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic64_try_cmpxchg_release() there.
  *
@@ -2889,7 +2910,8 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
  * @new: s64 value to assign
  *
  * If (@v == @old), atomically updates @v to @new with relaxed ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic64_try_cmpxchg_relaxed() there.
  *
@@ -3039,6 +3061,7 @@ atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
  * @u: s64 value to compare with
  *
  * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic64_fetch_add_unless() there.
  *
@@ -3059,6 +3082,7 @@ atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
  * @u: s64 value to compare with
  *
  * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic64_add_unless() there.
  *
@@ -3077,6 +3101,7 @@ atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
  * @v: pointer to atomic64_t
  *
  * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic64_inc_not_zero() there.
  *
@@ -3095,6 +3120,7 @@ atomic64_inc_not_zero(atomic64_t *v)
  * @v: pointer to atomic64_t
  *
  * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic64_inc_unless_negative() there.
  *
@@ -3113,6 +3139,7 @@ atomic64_inc_unless_negative(atomic64_t *v)
  * @v: pointer to atomic64_t
  *
  * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic64_dec_unless_positive() there.
  *
@@ -3131,6 +3158,7 @@ atomic64_dec_unless_positive(atomic64_t *v)
  * @v: pointer to atomic64_t
  *
  * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic64_dec_if_positive() there.
  *
@@ -4310,6 +4338,7 @@ atomic_long_xchg_relaxed(atomic_long_t *v, long new)
  * @new: long value to assign
  *
  * If (@v == @old), atomically updates @v to @new with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_cmpxchg() there.
  *
@@ -4330,6 +4359,7 @@ atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
  * @new: long value to assign
  *
  * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_cmpxchg_acquire() there.
  *
@@ -4349,6 +4379,7 @@ atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
  * @new: long value to assign
  *
  * If (@v == @old), atomically updates @v to @new with release ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_cmpxchg_release() there.
  *
@@ -4369,6 +4400,7 @@ atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
  * @new: long value to assign
  *
  * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_cmpxchg_relaxed() there.
  *
@@ -4388,7 +4420,8 @@ atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
  * @new: long value to assign
  *
  * If (@v == @old), atomically updates @v to @new with full ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_try_cmpxchg() there.
  *
@@ -4410,7 +4443,8 @@ atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
  * @new: long value to assign
  *
  * If (@v == @old), atomically updates @v to @new with acquire ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_try_cmpxchg_acquire() there.
  *
@@ -4431,7 +4465,8 @@ atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
  * @new: long value to assign
  *
  * If (@v == @old), atomically updates @v to @new with release ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_try_cmpxchg_release() there.
  *
@@ -4453,7 +4488,8 @@ atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
  * @new: long value to assign
  *
  * If (@v == @old), atomically updates @v to @new with relaxed ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_try_cmpxchg_relaxed() there.
  *
@@ -4603,6 +4639,7 @@ atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
  * @u: long value to compare with
  *
  * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_fetch_add_unless() there.
  *
@@ -4623,6 +4660,7 @@ atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
  * @u: long value to compare with
  *
  * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_add_unless() there.
  *
@@ -4641,6 +4679,7 @@ atomic_long_add_unless(atomic_long_t *v, long a, long u)
  * @v: pointer to atomic_long_t
  *
  * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_inc_not_zero() there.
  *
@@ -4659,6 +4698,7 @@ atomic_long_inc_not_zero(atomic_long_t *v)
  * @v: pointer to atomic_long_t
  *
  * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_inc_unless_negative() there.
  *
@@ -4677,6 +4717,7 @@ atomic_long_inc_unless_negative(atomic_long_t *v)
  * @v: pointer to atomic_long_t
  *
  * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_dec_unless_positive() there.
  *
@@ -4695,6 +4736,7 @@ atomic_long_dec_unless_positive(atomic_long_t *v)
  * @v: pointer to atomic_long_t
  *
  * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_dec_if_positive() there.
  *
@@ -5008,4 +5050,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 2cc4bc990fef44d3836ec108f11b610f3f438184
+// ce5b65e0f1f8a276268b667194581d24bed219d4
diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index c829471..3ef844b 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -1352,6 +1352,7 @@ raw_atomic_long_xchg_relaxed(atomic_long_t *v, long new)
  * @new: long value to assign
  *
  * If (@v == @old), atomically updates @v to @new with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_long_cmpxchg() elsewhere.
  *
@@ -1374,6 +1375,7 @@ raw_atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
  * @new: long value to assign
  *
  * If (@v == @old), atomically updates @v to @new with acquire ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_long_cmpxchg_acquire() elsewhere.
  *
@@ -1396,6 +1398,7 @@ raw_atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
  * @new: long value to assign
  *
  * If (@v == @old), atomically updates @v to @new with release ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_long_cmpxchg_release() elsewhere.
  *
@@ -1418,6 +1421,7 @@ raw_atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
  * @new: long value to assign
  *
  * If (@v == @old), atomically updates @v to @new with relaxed ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_long_cmpxchg_relaxed() elsewhere.
  *
@@ -1440,7 +1444,8 @@ raw_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
  * @new: long value to assign
  *
  * If (@v == @old), atomically updates @v to @new with full ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_long_try_cmpxchg() elsewhere.
  *
@@ -1463,7 +1468,8 @@ raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
  * @new: long value to assign
  *
  * If (@v == @old), atomically updates @v to @new with acquire ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_long_try_cmpxchg_acquire() elsewhere.
  *
@@ -1486,7 +1492,8 @@ raw_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
  * @new: long value to assign
  *
  * If (@v == @old), atomically updates @v to @new with release ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_long_try_cmpxchg_release() elsewhere.
  *
@@ -1509,7 +1516,8 @@ raw_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
  * @new: long value to assign
  *
  * If (@v == @old), atomically updates @v to @new with relaxed ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_long_try_cmpxchg_relaxed() elsewhere.
  *
@@ -1677,6 +1685,7 @@ raw_atomic_long_add_negative_relaxed(long i, atomic_long_t *v)
  * @u: long value to compare with
  *
  * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_long_fetch_add_unless() elsewhere.
  *
@@ -1699,6 +1708,7 @@ raw_atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
  * @u: long value to compare with
  *
  * If (@v != @u), atomically updates @v to (@v + @a) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_long_add_unless() elsewhere.
  *
@@ -1719,6 +1729,7 @@ raw_atomic_long_add_unless(atomic_long_t *v, long a, long u)
  * @v: pointer to atomic_long_t
  *
  * If (@v != 0), atomically updates @v to (@v + 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_long_inc_not_zero() elsewhere.
  *
@@ -1739,6 +1750,7 @@ raw_atomic_long_inc_not_zero(atomic_long_t *v)
  * @v: pointer to atomic_long_t
  *
  * If (@v >= 0), atomically updates @v to (@v + 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_long_inc_unless_negative() elsewhere.
  *
@@ -1759,6 +1771,7 @@ raw_atomic_long_inc_unless_negative(atomic_long_t *v)
  * @v: pointer to atomic_long_t
  *
  * If (@v <= 0), atomically updates @v to (@v - 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_long_dec_unless_positive() elsewhere.
  *
@@ -1779,6 +1792,7 @@ raw_atomic_long_dec_unless_positive(atomic_long_t *v)
  * @v: pointer to atomic_long_t
  *
  * If (@v > 0), atomically updates @v to (@v - 1) with full ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * Safe to use in noinstr code; prefer atomic_long_dec_if_positive() elsewhere.
  *
@@ -1795,4 +1809,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_LONG_H */
-// 4ef23f98c73cff96d239896175fd26b10b88899e
+// 1c4a26fc77f345342953770ebe3c4d08e7ce2f9a
diff --git a/scripts/atomic/kerneldoc/add_unless b/scripts/atomic/kerneldoc/add_unless
index f828e5f..fbc2fad 100644
--- a/scripts/atomic/kerneldoc/add_unless
+++ b/scripts/atomic/kerneldoc/add_unless
@@ -10,6 +10,7 @@ cat <<EOF
  * @u: ${int} value to compare with
  *
  * If (@v != @u), atomically updates @v to (@v + @a) with ${desc_order} ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * ${desc_noinstr}
  *
diff --git a/scripts/atomic/kerneldoc/cmpxchg b/scripts/atomic/kerneldoc/cmpxchg
index 3bce328..02b24ee 100644
--- a/scripts/atomic/kerneldoc/cmpxchg
+++ b/scripts/atomic/kerneldoc/cmpxchg
@@ -6,6 +6,7 @@ cat <<EOF
  * @new: ${int} value to assign
  *
  * If (@v == @old), atomically updates @v to @new with ${desc_order} ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * ${desc_noinstr}
  *
diff --git a/scripts/atomic/kerneldoc/dec_if_positive b/scripts/atomic/kerneldoc/dec_if_positive
index 04f1aed..9468b4a 100644
--- a/scripts/atomic/kerneldoc/dec_if_positive
+++ b/scripts/atomic/kerneldoc/dec_if_positive
@@ -4,6 +4,7 @@ cat <<EOF
  * @v: pointer to ${atomic}_t
  *
  * If (@v > 0), atomically updates @v to (@v - 1) with ${desc_order} ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * ${desc_noinstr}
  *
diff --git a/scripts/atomic/kerneldoc/dec_unless_positive b/scripts/atomic/kerneldoc/dec_unless_positive
index ee73612..06a6786 100644
--- a/scripts/atomic/kerneldoc/dec_unless_positive
+++ b/scripts/atomic/kerneldoc/dec_unless_positive
@@ -4,6 +4,7 @@ cat <<EOF
  * @v: pointer to ${atomic}_t
  *
  * If (@v <= 0), atomically updates @v to (@v - 1) with ${desc_order} ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * ${desc_noinstr}
  *
diff --git a/scripts/atomic/kerneldoc/inc_not_zero b/scripts/atomic/kerneldoc/inc_not_zero
index 618be08..c1a30fc 100644
--- a/scripts/atomic/kerneldoc/inc_not_zero
+++ b/scripts/atomic/kerneldoc/inc_not_zero
@@ -4,6 +4,7 @@ cat <<EOF
  * @v: pointer to ${atomic}_t
  *
  * If (@v != 0), atomically updates @v to (@v + 1) with ${desc_order} ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * ${desc_noinstr}
  *
diff --git a/scripts/atomic/kerneldoc/inc_unless_negative b/scripts/atomic/kerneldoc/inc_unless_negative
index 597f23d..ece0d2c 100644
--- a/scripts/atomic/kerneldoc/inc_unless_negative
+++ b/scripts/atomic/kerneldoc/inc_unless_negative
@@ -4,6 +4,7 @@ cat <<EOF
  * @v: pointer to ${atomic}_t
  *
  * If (@v >= 0), atomically updates @v to (@v + 1) with ${desc_order} ordering.
+ * Otherwise, @v is not modified and relaxed ordering is provided.
  *
  * ${desc_noinstr}
  *
diff --git a/scripts/atomic/kerneldoc/try_cmpxchg b/scripts/atomic/kerneldoc/try_cmpxchg
index 2965532..3ccff29 100644
--- a/scripts/atomic/kerneldoc/try_cmpxchg
+++ b/scripts/atomic/kerneldoc/try_cmpxchg
@@ -6,7 +6,8 @@ cat <<EOF
  * @new: ${int} value to assign
  *
  * If (@v == @old), atomically updates @v to @new with ${desc_order} ordering.
- * Otherwise, updates @old to the current value of @v.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
  *
  * ${desc_noinstr}
  *


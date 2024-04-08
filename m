Return-Path: <linux-kernel+bounces-135552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8100E89C77A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D303284D61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A9613F006;
	Mon,  8 Apr 2024 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mf3Vn5ND";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K9Bd285U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA561CD21;
	Mon,  8 Apr 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587758; cv=none; b=jU4iBcA/Ulu4xaRyhbNVHnhxWsFwnnrkutL4YjEzsIKyeXZP8AnPSAUsQwikjgL+V/wprfzRZSrfTexco5Abzmz8FzgmW3k2LrQimt86m2Obq9QdQI4Hv0Ks6A+vbWiNwTSzCaVSfDOaIAYSW5dRrOEQc63FMQzo53w+jt9wuFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587758; c=relaxed/simple;
	bh=jNMK47ZUmrpZUfLl5QCOPVV6yzsTpHyaMvQaLUlYv5g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oRgYkl5ER06+VHc5zDfDBbPLuSrFcUz/Ckna3/JtceIXHeW9eb27EP24JiTRmZK3wJDfouSjgxRmPAUOPKYpRcHRhXHsSEV5B+gvRimW3CA22nx2FHxhyuqMxBOZuDDaCh23VnZ68azdT9RaDLbC+VbK6wLoF1OcH8zUgqxULpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mf3Vn5ND; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K9Bd285U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 14:49:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712587755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSBZKxVagqSyyqgX5YL8fRhaTlaaIEoJrClKUTvlErk=;
	b=mf3Vn5NDuJQaN/lzB3cxTV21tWLhq4nqO2rjNs5u8ywZYm7Q0j8MEbQ5mMloNtLiyI1oT8
	VCm0+qgTT/wU+4Qnuwn2No/loTglgPF3lRmoq92u8rp1sk1JZq7lj2cY91prFiGxKTnU+y
	DCkU1Wm6sVvIo/32pZKCJu8VYyZ5gkynnMaIeB43YdfrpQRZqm7k+rLn5VDXHwl+zADkWZ
	+Peh80RDl4q3pF+WHaJlezboxXOWTG+XsgVXxN7s4XLSpmZSv1TYU7WeJufRZbVimWdUpq
	QQ0uzwteolFlZJunhzNnSDCiWrQLsqqY2Yd9tJHjhnXLcx+hAJyZZcMy08MGzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712587755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSBZKxVagqSyyqgX5YL8fRhaTlaaIEoJrClKUTvlErk=;
	b=K9Bd285UeNBWe0e8XhNipjtbIFhfgTUv5qil1ZKXm1TqRLlQ3Rf/mT1VoJWZjqj9p1+EdF
	rbVsE42+DmuJNQCg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking: Make
 rwsem_assert_held_write_nolockdep() build with PREEMPT_RT=y
Cc: Clark Williams <williams@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240319182050.U4AzUF3I@linutronix.de>
References: <20240319182050.U4AzUF3I@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258775408.10875.1006562089920074677.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     fa1f51162338b3e2f520d4bfedc42b3b2e00da6d
Gitweb:        https://git.kernel.org/tip/fa1f51162338b3e2f520d4bfedc42b3b2e00da6d
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 19 Mar 2024 19:20:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 16:39:16 +02:00

locking: Make rwsem_assert_held_write_nolockdep() build with PREEMPT_RT=y

The commit cited below broke the build for PREEMPT_RT because
rwsem_assert_held_write_nolockdep() passes a struct rw_semaphore but
rw_base_assert_held_write() expects struct rwbase_rt. Fixing the type alone
leads to the problem that WARN_ON() is not found because bug.h is missing.

In order to resolve this:

 - Keep the assert (WARN_ON()) in rwsem.h (not rwbase_rt.h)

 - Make rwsem_assert_held_write_nolockdep() do the implementation
   specific (rw_base) writer check.

 - Replace the "inline" with __always_inline which was used before.

Fixes: f70405afc99b1 ("locking: Add rwsem_assert_held() and rwsem_assert_held_write()")
Reported-by: Clark Williams <williams@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20240319182050.U4AzUF3I@linutronix.de
---
 include/linux/rwbase_rt.h | 4 ++--
 include/linux/rwsem.h     | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
index 29c4e4f..f2394a4 100644
--- a/include/linux/rwbase_rt.h
+++ b/include/linux/rwbase_rt.h
@@ -31,9 +31,9 @@ static __always_inline bool rw_base_is_locked(const struct rwbase_rt *rwb)
 	return atomic_read(&rwb->readers) != READER_BIAS;
 }
 
-static inline void rw_base_assert_held_write(const struct rwbase_rt *rwb)
+static __always_inline bool rw_base_is_write_locked(const struct rwbase_rt *rwb)
 {
-	WARN_ON(atomic_read(&rwb->readers) != WRITER_BIAS);
+	return atomic_read(&rwb->readers) == WRITER_BIAS;
 }
 
 static __always_inline bool rw_base_is_contended(const struct rwbase_rt *rwb)
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 4f1c189..c8b543d 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -167,14 +167,14 @@ static __always_inline int rwsem_is_locked(const struct rw_semaphore *sem)
 	return rw_base_is_locked(&sem->rwbase);
 }
 
-static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
+static __always_inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
 {
 	WARN_ON(!rwsem_is_locked(sem));
 }
 
-static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
+static __always_inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
 {
-	rw_base_assert_held_write(sem);
+	WARN_ON(!rw_base_is_write_locked(&sem->rwbase));
 }
 
 static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)


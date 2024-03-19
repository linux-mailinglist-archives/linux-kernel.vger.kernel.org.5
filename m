Return-Path: <linux-kernel+bounces-107149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F62A87F825
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417111C21A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6422A537FA;
	Tue, 19 Mar 2024 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v4o+wILb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c6Zvcnrd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C650A97
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831955; cv=none; b=GcgzxjadBpBsQZ492dzlIMfI0X8Vf4ntlJ2nFubVobir2qmGJcXY37IDnd2zX7wI7fvneL8z0TVFpQj3d2pVEIm0MRj9HoroYlAMeVlWB/xvyqi2pHue4VunAqVd9D0JO48PWGbxGCn+bQmdAFmcp5eBgNBi84oxvq/kfqnl8FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831955; c=relaxed/simple;
	bh=SMC53HP4py1br5aAuhfS6sBbuhypMvRPEcFuFgGNcao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lwkYmrsxKjjjtkPGUhnuSOu/Ka845cOJ2/RU5/hqnmnUMKlnswr5iDXjzMrP9oe1VzIoSLO558emDYsZ5Ph/PCtZAWlKROuHFkPK4aIeSBE8yJakpmBJjGDi4W06SryLHnxQIpjH8Emt+I/XvbuRvNZ6CtzSv5Jo4QIOfWy7MDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v4o+wILb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c6Zvcnrd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Mar 2024 08:05:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710831952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=pC/wpDRJZDRfQKX/eRdqlrCvgp6Dahbk2I2pygprEIk=;
	b=v4o+wILbSUlY+1B/gbnNZM+cnQaBsvUZkfayrjRorA2mXVRlcTWjwE6wWvvIZq7X1TFJN2
	iKkddvw+11MGsqYJazcqHFrusJSH0PT4BGRLynkY2FcdbF0Hw4JMoz6t4mvChYKpH8CjW8
	rArQAc1jDmJlSADRBW6qp66++Gi4ENfAR+qNzdTEJxuKSZVy05ecdK3eFATbCH4XDSQQDO
	ZKdLZ+V4Ge8WXy5Ddjrjn6HPtRKYm3Zi/7oW1ZsQIy8MBSoM4YTwziN4JsiIcskRhNkjGt
	2DbXfvTrSwj27JsihVPeoDIxc5x3pEgj3eC3n1SnUl77dKhWUq7bqW5VYAh6aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710831952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=pC/wpDRJZDRfQKX/eRdqlrCvgp6Dahbk2I2pygprEIk=;
	b=c6Zvcnrd00VAwnkmooSeUK+OmtSAdV5Qr3VymbdMXOtEyfpeIR63jzQrfMT1n46fHYm0lV
	s3gpflFXAoWiDHBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH] Locking: Let PREEMPT_RT compile again with new rwsem asserts.
Message-ID: <20240319070550.ws_uO21-@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The commit cited below broke the build for PREEMPT_RT because
rwsem_assert_held_write_nolockdep() passes a struct rw_semaphore but
rw_base_assert_held_write() expects struct rwbase_rt. Fixing the type
alone leads to the problem that WARN_ON() is not found because bug.h is
missing.

In order to resolve this:
- Keep the assert (WARN_ON()) in rwsem.h (not rwbase_rt.h)
- Add the rwsem_held_write() which returns true if the lock is already
  write-locked and no reader are around.
- Make rw_base_is_write_locked() do the implementation specific
  (rw_base) writer check.
- Replace the "inline" with __always_inline which was used before.

Fixes: f70405afc99b1 ("locking: Add rwsem_assert_held() and rwsem_assert_held_write()")
Reported-by: Clark Williams <williams@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/rwbase_rt.h |  4 ++--
 include/linux/rwsem.h     | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
index 29c4e4f243e47..f2394a409c9d5 100644
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
index 4f1c18992f768..c81630d81018d 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -167,14 +167,19 @@ static __always_inline int rwsem_is_locked(const struct rw_semaphore *sem)
 	return rw_base_is_locked(&sem->rwbase);
 }
 
-static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
+static __always_inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
 {
 	WARN_ON(!rwsem_is_locked(sem));
 }
 
-static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
+static __always_inline bool rwsem_held_write(const struct rw_semaphore *sem)
 {
-	rw_base_assert_held_write(sem);
+	return rw_base_is_write_locked(&sem->rwbase);
+}
+
+static __always_inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
+{
+	WARN_ON(!rwsem_held_write(sem));
 }
 
 static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
-- 
2.43.0



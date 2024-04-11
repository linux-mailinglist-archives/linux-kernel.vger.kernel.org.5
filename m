Return-Path: <linux-kernel+bounces-141530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23A38A1F72
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C901C236E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32EE3A8D8;
	Thu, 11 Apr 2024 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKpeiYRa"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783253613C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863415; cv=none; b=uzrFNhpGWCvGMmC56tDTztMpIC8Gf71MRIVbOZg1ZOCHpKmOnyrOmRxB/WrBV385NBlibvBXXvpm4gtn1fzgvDvv6YzWQyclf36RRZb+1WzVB2JhEEsl3wQsUP1GU2K+8rWMLHjD/DOhzYgFAUrSbKWCJTADYXi7J8ZK7zU41vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863415; c=relaxed/simple;
	bh=4qF8LVg03IpZBigtPGrJsn6WXzeLjF3rCWk0/VL3jgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTUPtyyIXCwObc5g/NkyEDolkO6Us4jYVh3cpjZdZC4liJXB9R00SoGvEv/d3q6URaWihujrAyF8Hd2uZ3DrVkoFITSvvxoBntAOHqpnLjDPwWiADrktVtP8kP6IN8WT4NzLaGN2R0ghMZE6pmlKddDBjSoGBpjTn3UWm1ctUng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKpeiYRa; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e2ac1c16aso183610a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712863411; x=1713468211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+0zEhyNCy29nBwGx3biGzoNsU5jpKW6uCTMA8YgqkA=;
        b=TKpeiYRa+fSOeo9B8/CXmNIh+yB/PnMsA2G7ag1Hfz8/gmQa7Vr++gBv5zOb33GRKB
         Edv7zWHhcPTArv9THTzJMCfipna2Xe2mVy+vviRe8fH/5p8rZzPka+4s7s12x5Tci7uL
         OpgcWGivtaufEw6HhBx0f38SsO9rFEoszla1qhI3RQ7sNgWIjEdAhi+OZn3VNrZmDOit
         Fyk6cfRlAoffch5jflXpElxj6Svhusa0uiabxZZ/mRFSFZsWtebxY973y2+bg3DeFVKg
         Z3wgWBTYYKw3TErxltmR4H76IukBf4K966LKQlSTcBhJa0870bF2aHJEkvr02zbOE2/y
         cyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863411; x=1713468211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+0zEhyNCy29nBwGx3biGzoNsU5jpKW6uCTMA8YgqkA=;
        b=TFKYRKn1daNokQFfUgzj0f8D8HpNkHw6cU4SI3iwx+bdaCNYIFsV8hS51yvc3N9Xsn
         267i16HxFL5R5o8PKcKWiIUU7pWhrfXSqgcCeluByWcIQUq/XAMWCsPzkJiEsUf86Oxx
         XmH2vMuYAAz6pguI4Kk6Umbx6iKYSYrR24hWAoS4vGx9VsEHdsu+RUnZ2czy0Vtbcexf
         iFUIErU/JIX9M1CKoe4zdZcM8r9cKHiq1n1cQOsk7SoAzzdiWv8JuGCiZ8Cagci2rnzL
         X3Fka7XMhVQjk7T+AegrB5g7IJGrM4O4uxuNJTD1eECanNaqnWWmE7WeqQcQ+2F2lT5C
         qRdA==
X-Forwarded-Encrypted: i=1; AJvYcCV0o3M5OBuHgHyvSVmbu4LZ8lAT4DhlhwN3C4/fYDGtSHD0k8unB1OvsuCHbqodP06HGFAURcBEfQraZSx0lnzkV+QA2juqBVDPdPRz
X-Gm-Message-State: AOJu0YzQWRN4zrMmRVEMVZNzk/OhjCn6Edg41xDX6ZXgRJpmz7VYu/3s
	7MeCuBQ4yY2+Ey5aiM/vtfr8pIp2IN88SZkG6rzDB+ZpKzZY5csf
X-Google-Smtp-Source: AGHT+IHcj5LLRcrVHG4N2iiyTX8OxoujFrcXL1dvqmf5qwrsRyLa49sVVlTzIfor4bPf4keif1NzDg==
X-Received: by 2002:a17:906:ae99:b0:a51:9438:af01 with SMTP id md25-20020a170906ae9900b00a519438af01mr308401ejb.76.1712863410548;
        Thu, 11 Apr 2024 12:23:30 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id dk5-20020a170907940500b00a518b14d6cesm1026406ejc.172.2024.04.11.12.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 12:23:29 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/2] locking/pvqspinlock: Use try_cmpxchg() in qspinlock_paravirt.h
Date: Thu, 11 Apr 2024 21:22:55 +0200
Message-ID: <20240411192317.25432-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240411192317.25432-1-ubizjak@gmail.com>
References: <20240411192317.25432-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use try_cmpxchg(*ptr, &old, new) instead of
cmpxchg(*ptr, old, new) == old in qspinlock_paravirt.h
x86 CMPXCHG instruction returns success in ZF flag, so
this change saves a compare after cmpxchg.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Waiman Long <longman@redhat.com>
---
v2: Correct a build error in __pv_queued_spin_unlock().
---
 kernel/locking/qspinlock_paravirt.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 77ba80bd95f9..f5a36e67b593 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -86,9 +86,10 @@ static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
 	 */
 	for (;;) {
 		int val = atomic_read(&lock->val);
+		u8 old = 0;
 
 		if (!(val & _Q_LOCKED_PENDING_MASK) &&
-		   (cmpxchg_acquire(&lock->locked, 0, _Q_LOCKED_VAL) == 0)) {
+		    try_cmpxchg_acquire(&lock->locked, &old, _Q_LOCKED_VAL)) {
 			lockevent_inc(pv_lock_stealing);
 			return true;
 		}
@@ -211,8 +212,9 @@ static struct qspinlock **pv_hash(struct qspinlock *lock, struct pv_node *node)
 	int hopcnt = 0;
 
 	for_each_hash_entry(he, offset, hash) {
+		struct qspinlock *old = NULL;
 		hopcnt++;
-		if (!cmpxchg(&he->lock, NULL, lock)) {
+		if (try_cmpxchg(&he->lock, &old, lock)) {
 			WRITE_ONCE(he->node, node);
 			lockevent_pv_hop(hopcnt);
 			return &he->lock;
@@ -355,7 +357,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 {
 	struct pv_node *pn = (struct pv_node *)node;
-
+	enum vcpu_state old = vcpu_halted;
 	/*
 	 * If the vCPU is indeed halted, advance its state to match that of
 	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will
@@ -372,8 +374,7 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 	 * subsequent writes.
 	 */
 	smp_mb__before_atomic();
-	if (cmpxchg_relaxed(&pn->state, vcpu_halted, vcpu_hashed)
-	    != vcpu_halted)
+	if (!try_cmpxchg_relaxed(&pn->state, &old, vcpu_hashed))
 		return;
 
 	/*
@@ -541,15 +542,14 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 #ifndef __pv_queued_spin_unlock
 __visible __lockfunc void __pv_queued_spin_unlock(struct qspinlock *lock)
 {
-	u8 locked;
+	u8 locked = _Q_LOCKED_VAL;
 
 	/*
 	 * We must not unlock if SLOW, because in that case we must first
 	 * unhash. Otherwise it would be possible to have multiple @lock
 	 * entries, which would be BAD.
 	 */
-	locked = cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
-	if (likely(locked == _Q_LOCKED_VAL))
+	if (try_cmpxchg_release(&lock->locked, &locked, 0))
 		return;
 
 	__pv_queued_spin_unlock_slowpath(lock, locked);
-- 
2.42.0



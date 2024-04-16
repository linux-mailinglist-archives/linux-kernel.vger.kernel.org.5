Return-Path: <linux-kernel+bounces-146788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFAC8A6AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131E1283A36
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066FD41C76;
	Tue, 16 Apr 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ehNdWA8V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EateKPP+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE61D1E527;
	Tue, 16 Apr 2024 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270666; cv=none; b=ekA8HthJZ9zS4rB5AXRbYdu7LTwEK43hshOhRWDE8V7F5qtzDrf1DvQNtf6ax1K/hgTQ9foe+xMMKkLNOlVOul0iPPxJdo6Xwl4z43CnxVHx3Esn+xeHNUnRc3MhdYqYo2DpAXQMFfNkwL0IiWt6UzxNpPiE9oKEdB+5dKp69VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270666; c=relaxed/simple;
	bh=YjkSOnY7MOYoI4u8ZX/26NHgoThl++miHa+iTTsZVe0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P26yVsci+TiquarKwvv/I8svyhe1AzY/BKdp6CkyDIlMo0rf1BfDuv400U2iNr2V/z/yAr1wkrRMDtVgkAhD/GP2R/CCJfjr0FSHCTe9Z6GY1rNSLCrv2el5QtNU7bypNiGcuXPvCFhNH5+5YT9idmQPeTPgDOYe9SGJDlpS97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ehNdWA8V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EateKPP+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Apr 2024 12:30:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713270655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOhenMrd56U68JRoB6aXqA+Ecvh9dj00xNKDtxgfKF8=;
	b=ehNdWA8V20neHEqejl6B6czC/R1NG/J8ugSwpj4pjPDuXnZplBhdE7MG1TLU6yydtBWeqj
	Zyq0sWdWNaFB36tQoevaa/aOvFyzZ7hM1Gqwy7oe0EectHyo28zWyBW0c+sXEfOFgGCCQo
	1gV2Rk8eikT84zgG6eZGMl+uAYGGWZvJThVaU6LN45MYwUl+UHshD5RacH0fbr+rwsdGBH
	OGeQnvYbzDCX6DpUQcx5rCNxTEUWWlxK+wsdSvEm13wTANrxfcpVicsv4guK9w/5Dm1Vjk
	qp6Fn4dZm6Uk6zYMpSHIUcZ0sLSl95imHnvcrIP+8MwvcSNaIea5BDVd4sAhUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713270655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOhenMrd56U68JRoB6aXqA+Ecvh9dj00xNKDtxgfKF8=;
	b=EateKPP+Kv/G/Oi+J3rXMvoYko+aBNaZGvPs7dqi8Bgm/KIagiKynxT/YcC7x4RdJmgSXy
	kcHQzF+s69sDJzBQ==
From: "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched: Add missing memory barrier in switch_mm_cid
Cc: "levi.yun" <yeoreum.yun@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,  <stable@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240415152114.59122-2-mathieu.desnoyers@efficios.com>
References: <20240415152114.59122-2-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171327065441.10875.11466673774953138493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     fe90f3967bdb3e13f133e5f44025e15f943a99c5
Gitweb:        https://git.kernel.org/tip/fe90f3967bdb3e13f133e5f44025e15f943a99c5
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Mon, 15 Apr 2024 11:21:13 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 16 Apr 2024 13:59:45 +02:00

sched: Add missing memory barrier in switch_mm_cid

Many architectures' switch_mm() (e.g. arm64) do not have an smp_mb()
which the core scheduler code has depended upon since commit:

    commit 223baf9d17f25 ("sched: Fix performance regression introduced by mm_cid")

If switch_mm() doesn't call smp_mb(), sched_mm_cid_remote_clear() can
unset the actively used cid when it fails to observe active task after it
sets lazy_put.

There *is* a memory barrier between storing to rq->curr and _return to
userspace_ (as required by membarrier), but the rseq mm_cid has stricter
requirements: the barrier needs to be issued between store to rq->curr
and switch_mm_cid(), which happens earlier than:

  - spin_unlock(),
  - switch_to().

So it's fine when the architecture switch_mm() happens to have that
barrier already, but less so when the architecture only provides the
full barrier in switch_to() or spin_unlock().

It is a bug in the rseq switch_mm_cid() implementation. All architectures
that don't have memory barriers in switch_mm(), but rather have the full
barrier either in finish_lock_switch() or switch_to() have them too late
for the needs of switch_mm_cid().

Introduce a new smp_mb__after_switch_mm(), defined as smp_mb() in the
generic barrier.h header, and use it in switch_mm_cid() for scheduler
transitions where switch_mm() is expected to provide a memory barrier.

Architectures can override smp_mb__after_switch_mm() if their
switch_mm() implementation provides an implicit memory barrier.
Override it with a no-op on x86 which implicitly provide this memory
barrier by writing to CR3.

Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
Reported-by: levi.yun <yeoreum.yun@arm.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com> # for arm64
Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # for x86
Cc: <stable@vger.kernel.org> # 6.4.x
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240415152114.59122-2-mathieu.desnoyers@efficios.com
---
 arch/x86/include/asm/barrier.h |  3 +++
 include/asm-generic/barrier.h  |  8 ++++++++
 kernel/sched/sched.h           | 20 ++++++++++++++------
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index fe1e7e3..63bdc6b 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -79,6 +79,9 @@ do {									\
 #define __smp_mb__before_atomic()	do { } while (0)
 #define __smp_mb__after_atomic()	do { } while (0)
 
+/* Writing to CR3 provides a full memory barrier in switch_mm(). */
+#define smp_mb__after_switch_mm()	do { } while (0)
+
 #include <asm-generic/barrier.h>
 
 #endif /* _ASM_X86_BARRIER_H */
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 0c06957..d4f581c 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -294,5 +294,13 @@ do {									\
 #define io_stop_wc() do { } while (0)
 #endif
 
+/*
+ * Architectures that guarantee an implicit smp_mb() in switch_mm()
+ * can override smp_mb__after_switch_mm.
+ */
+#ifndef smp_mb__after_switch_mm
+# define smp_mb__after_switch_mm()	smp_mb()
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d224267..ae50f21 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -79,6 +79,8 @@
 # include <asm/paravirt_api_clock.h>
 #endif
 
+#include <asm/barrier.h>
+
 #include "cpupri.h"
 #include "cpudeadline.h"
 
@@ -3445,13 +3447,19 @@ static inline void switch_mm_cid(struct rq *rq,
 		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
 		 * Provide it here.
 		 */
-		if (!prev->mm)                          // from kernel
+		if (!prev->mm) {                        // from kernel
 			smp_mb();
-		/*
-		 * user -> user transition guarantees a memory barrier through
-		 * switch_mm() when current->mm changes. If current->mm is
-		 * unchanged, no barrier is needed.
-		 */
+		} else {				// from user
+			/*
+			 * user->user transition relies on an implicit
+			 * memory barrier in switch_mm() when
+			 * current->mm changes. If the architecture
+			 * switch_mm() does not have an implicit memory
+			 * barrier, it is emitted here.  If current->mm
+			 * is unchanged, no barrier is needed.
+			 */
+			smp_mb__after_switch_mm();
+		}
 	}
 	if (prev->mm_cid_active) {
 		mm_cid_snapshot_time(rq, prev->mm);


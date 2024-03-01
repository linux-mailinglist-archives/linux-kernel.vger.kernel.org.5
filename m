Return-Path: <linux-kernel+bounces-88405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1686E12A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FFC91F25C66
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CD21EB3B;
	Fri,  1 Mar 2024 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WioeGyKY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wTU3GIET"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF8A3FB83;
	Fri,  1 Mar 2024 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296732; cv=none; b=Q1dDW7qcBbEv+eqD49msYCjey2v0w4qPQe3lgPLgijErkW85LpDprlp4wFW6FZkdLSVrGv5WH2D0tEGb1CEP3XrGcV+jEqLCxsWBOto2g5GePvECA5fWjade8fyar0y8XGRDRJgAnddyo5I9OKi/PkQPETfPrxC1dDUy+9JjmhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296732; c=relaxed/simple;
	bh=3hJsk2U/SNP5TG0kNRfPTL8kuultS+lkSu1yYxZDFPo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tf/y93prroe0NLH9zAIVXS/BjiBK8cdQZOLwMUn3SZYKUN01u2aXE96L04lC0zX+lxuR6Vz6nhJJzYouyU2xGtSkFBU7QyBd28tv5wPb1Hcu0yK/PpxV+RKQw3dME/1gE0PFYVJh28Px3CCU2yLTt3zsojqFEAOcNSUTdHOgFvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WioeGyKY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wTU3GIET; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Mar 2024 12:38:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709296729;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvQzYqM2/IhbJhv4vYl/ejMCNx3rv85KanRhSSdY2Vw=;
	b=WioeGyKYM8+RPOfuVZrYSQjLCIpy4/cL9B8AepgepOY8yoP45TZa01Rh6lfWhx+psiyXct
	3s4vT3KAScyR+Bd0Mmo9xO4d86Vb89aELDC5J7LZCwgwZs9KYMGnmXZeOsNMo14Bturu17
	wgpQmvtQv5wjzRkCLdDpUpfVtly0u+txgJnR/aYscU3GsQLTR3pg5/tsghmcLqSaDHFs0g
	zQS8lHCpMeH4y0F6ppGC4n5bLwpi9+OmbgMl3SBPz8NMPaIRj9DVX3k8l8c7YMNZToy+EI
	6UF0XY1jG2v1EFcCfW82nbHBabUU2LeYDrJ33wf50XRryaQM00Cwahk4G8pVig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709296729;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvQzYqM2/IhbJhv4vYl/ejMCNx3rv85KanRhSSdY2Vw=;
	b=wTU3GIETyNUfwdSFShM5R7G+7ZdX0zz7UqQizds7t1fe9Al92WfYsnTJdK9V3ycUIEPLcE
	uA0GxNj4gFWW3hDw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Use try_cmpxchg_relaxed() in
 mark_rt_mutex_waiters()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240124104953.612063-1-ubizjak@gmail.com>
References: <20240124104953.612063-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170929672826.398.6495674800219372460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ce3576ebd62d99f79c1dc98824e2ef6d6ab68434
Gitweb:        https://git.kernel.org/tip/ce3576ebd62d99f79c1dc98824e2ef6d6ab68434
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 24 Jan 2024 11:49:53 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 01 Mar 2024 13:02:05 +01:00

locking/rtmutex: Use try_cmpxchg_relaxed() in mark_rt_mutex_waiters()

Use try_cmpxchg() instead of cmpxchg(*ptr, old, new) == old.

The x86 CMPXCHG instruction returns success in the ZF flag, so this change
saves a compare after CMPXCHG (and related move instruction in front of CMPXCHG).

Also, try_cmpxchg() implicitly assigns old *ptr value to "old" when CMPXCHG
fails. There is no need to re-read the value in the loop.

Note that the value from *ptr should be read using READ_ONCE() to prevent
the compiler from merging, refetching or reordering the read.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20240124104953.612063-1-ubizjak@gmail.com
---
 kernel/locking/rtmutex.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4a10e8c..88d08ee 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -237,12 +237,13 @@ static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *lock,
  */
 static __always_inline void mark_rt_mutex_waiters(struct rt_mutex_base *lock)
 {
-	unsigned long owner, *p = (unsigned long *) &lock->owner;
+	unsigned long *p = (unsigned long *) &lock->owner;
+	unsigned long owner, new;
 
+	owner = READ_ONCE(*p);
 	do {
-		owner = *p;
-	} while (cmpxchg_relaxed(p, owner,
-				 owner | RT_MUTEX_HAS_WAITERS) != owner);
+		new = owner | RT_MUTEX_HAS_WAITERS;
+	} while (!try_cmpxchg_relaxed(p, &owner, new));
 
 	/*
 	 * The cmpxchg loop above is relaxed to avoid back-to-back ACQUIRE


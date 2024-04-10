Return-Path: <linux-kernel+bounces-139470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5F58A039E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF23628361E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1FC50275;
	Wed, 10 Apr 2024 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C01lQgvn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1S9lztVW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9504F5EA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789205; cv=none; b=er5IjfrzO+Ara+F3xnu77EeUtZ79ZCaWdDv/a92ifcLEcRJel6oYLhLTHlOQZkN1RikymoXcH6Ex+HLRIJtUWuP4cK/XQSvu2HDdXHpRGvW1CxnVf8yMDzN8Fw1WVqxQpoqMpcgtMbjyicX9Hg5EAfe84y+hTOEwoDfwwFyIJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789205; c=relaxed/simple;
	bh=M9Q7ax6L6HgZ2sYcMaynew0ayWNP6jxDDhPzY9nkD8E=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=UsyrI5lpWVVWaBGoK2ambXpD+x4pm2EnG3UUUIO7V0zvQgj7WkUXjniwHcyFstlFFCOEkEt1kf3vlT2NHJt94hnr2jw8qR9aKZupdiiXMgPs4XNKpU0JcptC8SSlwMnzFWae8g8fNinvtMGHViRqgknuDqvx+8JDdKG+OTd1WRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C01lQgvn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1S9lztVW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165552.006883398@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=a4kBoLxoimUoUZk3ev7GSbKQUyXJ3UwY85qwVJP4oio=;
	b=C01lQgvnpJfKiWn4HWNf7Sv/QhuG1SRBw6FdV/B0Agr60V6KbpT7YrMuIL/cZM25UFPClm
	rJTx5ssCYKQLh9HiVlL8h6Ythh6i0GHyjapo0AxxlcLNpLeGEYtWUaxfdn0UZFw4mx1ELR
	AOIZYzL7+IcQwDucOaGQQcUAs0LpkdR5hO1t4wG/sfvdXX+g7RK1CaK/G3c3drgojlpjWR
	tdQYsjV0w7Biy9Qhx1DxCdVeDuwAGDycEBZpkrDtbpDH4NbnyumfMyG1essOCZas/V0gfi
	Ms4ApNoawa9EFvwtNvLD6nQknODJ8nUBCG27MY0NA+ZYXfR4GXr7ZtoCL92LOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=a4kBoLxoimUoUZk3ev7GSbKQUyXJ3UwY85qwVJP4oio=;
	b=1S9lztVWxLgK1OLkPLMZ26JATwvZaSWE9lLqTLHm73YPwWss7AwpGc+1+m0h5iYVXlLPUP
	J4ouymcsEEifd/BQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V2 17/50] posix-timers: Retrieve interval in common
 timer_settime() code
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:41 +0200 (CEST)

No point in doing this all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Removed the timer_gettime() part - Frederic
---
 kernel/time/posix-cpu-timers.c |   10 ++--------
 kernel/time/posix-timers.c     |    5 ++++-
 2 files changed, 6 insertions(+), 9 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -622,8 +622,8 @@ static int posix_cpu_timer_set(struct k_
 {
 	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	u64 old_expires, new_expires, old_incr, now;
 	struct cpu_timer *ctmr = &timer->it.cpu;
+	u64 old_expires, new_expires, now;
 	struct sighand_struct *sighand;
 	struct task_struct *p;
 	unsigned long flags;
@@ -660,10 +660,7 @@ static int posix_cpu_timer_set(struct k_
 		return -ESRCH;
 	}
 
-	/*
-	 * Disarm any old timer after extracting its expiry time.
-	 */
-	old_incr = timer->it_interval;
+	/* Retrieve the current expiry time before disarming the timer */
 	old_expires = cpu_timer_getexpires(ctmr);
 
 	if (unlikely(timer->it.cpu.firing)) {
@@ -742,9 +739,6 @@ static int posix_cpu_timer_set(struct k_
 		cpu_timer_fire(timer);
 out:
 	rcu_read_unlock();
-	if (old)
-		old->it_interval = ns_to_timespec64(old_incr);
-
 	return ret;
 }
 
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -904,7 +904,7 @@ static int do_timer_settime(timer_t time
 	const struct k_clock *kc;
 	struct k_itimer *timr;
 	unsigned long flags;
-	int error = 0;
+	int error;
 
 	if (!timespec64_valid(&new_spec64->it_interval) ||
 	    !timespec64_valid(&new_spec64->it_value))
@@ -918,6 +918,9 @@ static int do_timer_settime(timer_t time
 	if (!timr)
 		return -EINVAL;
 
+	if (old_spec64)
+		old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
+
 	kc = timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;



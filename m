Return-Path: <linux-kernel+bounces-139465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0F88A0399
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7791C21173
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FFE4AEC7;
	Wed, 10 Apr 2024 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="to5uQCzb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IKnaH5ee"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB62481A0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789196; cv=none; b=kCs8NgRLjZ1V6PKFRBRJhdgMyZGyPP9GJewrhFZDHGcatWgsg5u2U7mxMKVgj5FS1E740GYpkYPul1vywGOqU1yYfZ8VKiTPn5Iaek0vDm1efrjkNhlbEIEu9TTWmRIJZjn1EoKff6w3Pmze6pnBjJ3azg86BRAMhoswsgXFOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789196; c=relaxed/simple;
	bh=UGVZy9yiNtE3R/qqXfALDVUSsmVr1T6CsA5jtA7JuEI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tWr8JNooFS8YV6LXoi4U36qxerJIvDUu5XxKEPwfkhKEI6rvqd14lr1g33n8tkpaKzLZc+7AqfJeNje5K4cJsNtRVj3uc6qkJ1AD3qXjgvaDpWTaQ0TX7CE9o8hPCPDAblzTX41nPZLKFc4XrJM97mUmkwnP/EwEz3fcwqM5IhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=to5uQCzb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IKnaH5ee; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165551.696591376@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IjZXK69CXPSZdDcaR3Lrs+m7BfPVp6Q5CnwMmPhWl8E=;
	b=to5uQCzbmFKdomBLmv3NP7ql54Ca08WkprguSTAXcy7Z0KV6QEETqqCuobT8Xe11Ejyd1V
	jjo6KdBnvCjhNgBPTOFlJqS1QpahiOJIwqGn9+CmhJTekx+J0wHF3SFi12JhYmsfeVSz3l
	Pc0uOBSbDNIn9sbBgPLGI9luIGcJqSzB0Md0I9r8xBIzANYwTKVuHdT1WuJwAtptbmWDEC
	h1U0/jeAuTH5o89FRsQAUkMMd2IfQgS5xY53Hs3z/UPoE0NtnZ+XjVPSiWkhtJ4wnqLlYJ
	sjuk8nVRRDki3quH+z9fjvOff0cwVGoerKO9JxhjmjJznJfsJqHDQAW07o5FnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IjZXK69CXPSZdDcaR3Lrs+m7BfPVp6Q5CnwMmPhWl8E=;
	b=IKnaH5eeEkqdTNKYcQVmE8boxuVc4upmvjSu73JY/z8bqDPen2BZJQU9tx4kfNsbJQhHII
	UlkVvYUW/cSK2aCA==
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
Subject: [patch V2 12/50] posix-cpu-timers: Replace old expiry retrieval in
 posix_cpu_timer_set()
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:33 +0200 (CEST)

Reuse the split out __posix_cpu_timer_get() function which does already the
right thing.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Adopted to previous changes
---
 kernel/time/posix-cpu-timers.c |   36 ++++++------------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -614,6 +614,8 @@ static void cpu_timer_fire(struct k_itim
 	}
 }
 
+static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now);
+
 /*
  * Guts of sys_timer_settime for CPU timers.
  * This is called with the timer locked and interrupts disabled.
@@ -688,37 +690,11 @@ static int posix_cpu_timer_set(struct k_
 	else
 		val = cpu_clock_sample_group(clkid, p, true);
 
+	/* Retrieve the previous expiry value if requested. */
 	if (old) {
-		if (old_expires == 0) {
-			old->it_value.tv_sec = 0;
-			old->it_value.tv_nsec = 0;
-		} else {
-			/*
-			 * Update the timer in case it has overrun already.
-			 * If it has, we'll report it as having overrun and
-			 * with the next reloaded timer already ticking,
-			 * though we are swallowing that pending
-			 * notification here to install the new setting.
-			 */
-			u64 exp = bump_cpu_timer(timer, val);
-
-			if (val < exp) {
-				old_expires = exp - val;
-				old->it_value = ns_to_timespec64(old_expires);
-			} else {
-				/*
-				 * A single shot SIGEV_NONE timer must return 0, when it is
-				 * expired! Timers which have a real signal delivery mode
-				 * must return a remaining time greater than 0 because the
-				 * signal has not yet been delivered.
-				 */
-				if (sigev_none)
-					old->it_value.tv_nsec = 0;
-				else
-					old->it_value.tv_nsec = 1;
-				old->it_value.tv_sec = 0;
-			}
-		}
+		old->it_value = (struct timespec64){ };
+		if (old_expires)
+			__posix_cpu_timer_get(timer, old, val);
 	}
 
 	if (unlikely(ret)) {



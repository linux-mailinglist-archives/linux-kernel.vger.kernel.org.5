Return-Path: <linux-kernel+bounces-139461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8C88A0394
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04E31F23C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709404503F;
	Wed, 10 Apr 2024 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k3J8Iis4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lsgHz7XW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F6E41C61
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789189; cv=none; b=eID62gg3cEHfVt2ea1pl76okz4H1xi/uqRrDQmENkz6sRJvrhNeyVpgqq4Qs1adIpiP+9S4PzmwM0+j8/WvTGHcFx7dytLAbZrNlCtEgzZSGMNuDSSfBJ5m5M+ldXsFgBXPPUOTYWSAQ++wGxJZCpso7VtkXS2DNSXUwiFXxPP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789189; c=relaxed/simple;
	bh=gUItmgDH5rsS1e6yVmaYPpvSzF4y549YIibjLNxq98E=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=NFCYRdIlaQheqmcHfz7Z/obO1G5MVP3zDChsdL9vzkShf1ijMYJR8+5jtVAQigKP7pz9xEfLipmvQWGlaoeaGtfvHqMHRpzPb77G9w3OQiHoR9vTF4qwR6c+Q/QuM0RJOEPINy7P9pWChlXInM0RBKzVM7Ufak0es7/RLKeLWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k3J8Iis4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lsgHz7XW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165551.442678509@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=AfHYSU/HugM7h61r392aP8dR7dmyLHuDBcUa2xZEhTQ=;
	b=k3J8Iis4UlCEz7ouQzMEVjnMpqbka+RyNovjeI8aMklnVdHDeXDeuJOAsK8CKGSiUaYXRu
	p319ipNtFrkW8B4FkNSODjp9yWBC18lHf5Etwd6DcKrJfwHNo8k0WjZXYK/kNHoO6x06Jq
	znwaNA51jlKRQXRtDWLg1hcBBAZ6y/AnVg3i70ZBrn0vsqBXIDAIS7Wc/drUIsTt7RwOPI
	DdtiRfeiMMBU801yoaLMb1n6NFZGqKYOAsobsy50Jzux3g66vK32R1rUuMpKi37o6PAn+N
	aYN7lcE/Rt8T+RibDHnavHbTTSN1c83/EOkJwWkAEWOtqRTma9aUbhJTo8pONQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=AfHYSU/HugM7h61r392aP8dR7dmyLHuDBcUa2xZEhTQ=;
	b=lsgHz7XWUuyEN3c9+lGzFckBDC+HrPIbvO/LBtiP8ihJet9FKA4TQGmyR23O7VM9XWD0LY
	GrevTs8eMP3acTBw==
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
Subject: [patch V2 08/50] posix-cpu-timers: Save interval only for armed
 timers
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:26 +0200 (CEST)

There is no point to return the interval for timers which have been
disarmed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Split out into new patch to make review simpler - Frederic
---
 kernel/time/posix-cpu-timers.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -809,17 +809,15 @@ static void posix_cpu_timer_get(struct k
 
 	rcu_read_lock();
 	p = cpu_timer_task_rcu(timer);
-	if (p) {
+	if (p && cpu_timer_getexpires(&timer->it.cpu)) {
 		itp->it_interval = ktime_to_timespec64(timer->it_interval);
 
-		if (cpu_timer_getexpires(&timer->it.cpu)) {
-			if (CPUCLOCK_PERTHREAD(timer->it_clock))
-				now = cpu_clock_sample(clkid, p);
-			else
-				now = cpu_clock_sample_group(clkid, p, false);
+		if (CPUCLOCK_PERTHREAD(timer->it_clock))
+			now = cpu_clock_sample(clkid, p);
+		else
+			now = cpu_clock_sample_group(clkid, p, false);
 
-			__posix_cpu_timer_get(timer, itp, now);
-		}
+		__posix_cpu_timer_get(timer, itp, now);
 	}
 	rcu_read_unlock();
 }



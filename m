Return-Path: <linux-kernel+bounces-139474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D5F8A03A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7941F26D21
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814EB3D55B;
	Wed, 10 Apr 2024 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n0xnL1QA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TvDSjwNs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4C524D6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789212; cv=none; b=Ipfu1oikJaUUR7VK5iDd+pEvgWs8fR5mhPP+QmI5d9a36L5R3F7jXx5kOEX5tuV2mfVJIJwbVYf2acV4LxRNdZfR/98Dcb+sgVxlmC2GuADkCo6ZotgyigG4LPagrte7s/Lj59C9Gx3F8sGhdcg+kYF2Gyt4VCQ3mRRIpY2QmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789212; c=relaxed/simple;
	bh=vhFqJQGzuzFxet5n8aXmRbKfqxdROxlKhbpES6yLgrw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=En8uITqZj243jotODJpxZ1f9h8NacWV6Jl6IMO63BSPJ0aSk9b3lG2C/206NvH0KrLmyguAWIMn7OuFe3xr0gk6lZbOltzEOJ0wD8t3T6pQOrhBKo3B7+CKpZbx8M1yaYVZq3e25kIFYaPQar9wOZwyQkSryZXygHkzpgOZMzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n0xnL1QA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TvDSjwNs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165552.256162566@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ftWWtT5tkPA9yVyOVqrZETMprBLvt80uYl9BSpWJ448=;
	b=n0xnL1QAZmGNIlBKmm5arU5JQ8EByh6Z8pzopn+PzlDB8DVN/rrHfFRVhysvd3GxxbZAOF
	yfK/BhFt9b8C0VR8XMhL5i6uwoMEpvIIh+Bb3tuW5jUeqpKkIjzU6JKcCUAsJ5+n6++sqZ
	01KSkyzPWn8mQsUi422bDWabuYRfnQOXPQUhnWl2PvzAVUbEc+k9f0MA/1RgZkPdUkg4m1
	gRzapxLU7BkbhRgPEuNlotXHQIkaa5iLw/2zrAFMBGlSkF6CMm/7SOwrCxx+yXk2m1PXVL
	GklRu8d5SMDPqWULVvkYK3Z/OqpBffflp4xnDVlRFqCZL5m8KMUJjcxqfY2AXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ftWWtT5tkPA9yVyOVqrZETMprBLvt80uYl9BSpWJ448=;
	b=TvDSjwNsrAIUqpDrYI/G4XS8W+WaEhBJ0yKCEifTAo82F9+E+09y1F0LfrSlpfEEwxAgrz
	w9ByE4gpnpXu9eDg==
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
Subject: [patch V2 21/50] posix-cpu-timers: Make k_itimer::it_active
 consistent
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:49 +0200 (CEST)

Posix CPU timers are not updating k_itimer::it_active which makes it
impossible to base decisions in the common posix timer code on it.

Update it when queueing or dequeueing posix CPU timers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Move the clearing to cpu_timer_fire() - Frederic
---
 kernel/time/posix-cpu-timers.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -453,6 +453,7 @@ static void disarm_timer(struct k_itimer
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	struct posix_cputimer_base *base;
 
+	timer->it_active = 0;
 	if (!cpu_timer_dequeue(ctmr))
 		return;
 
@@ -559,6 +560,7 @@ static void arm_timer(struct k_itimer *t
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	u64 newexp = cpu_timer_getexpires(ctmr);
 
+	timer->it_active = 1;
 	if (!cpu_timer_enqueue(&base->tqhead, ctmr))
 		return;
 
@@ -584,6 +586,7 @@ static void cpu_timer_fire(struct k_itim
 {
 	struct cpu_timer *ctmr = &timer->it.cpu;
 
+	timer->it_active = 0;
 	if (unlikely(timer->sigq == NULL)) {
 		/*
 		 * This a special case for clock_nanosleep,
@@ -668,6 +671,7 @@ static int posix_cpu_timer_set(struct k_
 		ret = TIMER_RETRY;
 	} else {
 		cpu_timer_dequeue(ctmr);
+		timer->it_active = 0;
 	}
 
 	/*



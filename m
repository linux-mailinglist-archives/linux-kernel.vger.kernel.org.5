Return-Path: <linux-kernel+bounces-135388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5134189C0A5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C4B1F204E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0BC7BB0A;
	Mon,  8 Apr 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WN0ejX3q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CWTJ2yy2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0326F53D;
	Mon,  8 Apr 2024 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581836; cv=none; b=ZCimXZx12vk+N4wMcar2SRYnsGPDGi/A3DCsEgrOOFgheHwXc/N441pfSbXUIZlPgk+JX6zXy8yjd+ObNkbDJEMlgFksRS8szerW/YOvcSLpvr00u6RwYZDn0aDMqPLknBB3T38XVX1/kDY2Wz4M7FvUT0DrwI7Kn+0BRXHiSvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581836; c=relaxed/simple;
	bh=ehfM08F8G8GalYQi33tLGk96rjZg/xqEsQAEde77Egw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oDnU4UeQ/nhtlMml3N3eDGFOrL9UEsr+hN75AZAOYsb117E0Mqdoc4hPXc701xtcdooh8a6rYuLtmSeTU9o4Aj22RurGhlFb8ekMNsoSJlls8/IIqtpZUoPIOWLD+cCQpxzcquWMX1SJW+Bnqr7Q+PuzfifLeE0PndDzzpjWwrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WN0ejX3q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CWTJ2yy2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581831;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h60IW2RWoFZOyVC0OOXOaSetMYb3Er2LDyf1I9S474c=;
	b=WN0ejX3qbv8xgtfAJ9lLjKHKHj3N2CGR3XZjTJ1lYGYu1Gxrx0ZiZ5qwXVopcH7KMe4lNB
	9R7vGSbjo0QAOny+fDvymoaLdlBuE9ffRIg1sbXD16s3GCUQpmOpGZxkR136MDrO/jfimD
	MFBX957y4l0/T8duD4m3J2MsJlA7F7/Fi4Ad0zpAkzrxbNc76tmrCy0VHHHzvx1+F9tAgw
	f5Pi17eAE5luyfG+p+SYwsHKHJPIW2rgppFoKUwjyOWaJUROgxrcKg4ENKdY/kjfF6pJ1F
	+NLhhvfoXEOdgxHc7tD2az5O92FjuqOPOPFp3+5zkAsXL/ov3V2sjNo27zLBUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581831;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h60IW2RWoFZOyVC0OOXOaSetMYb3Er2LDyf1I9S474c=;
	b=CWTJ2yy2EosHXmy8rlifFs3qGbWBXdyCee5hF5Q8YkJrD3uo7PpodDYmSgtd4YadVvwPr5
	5Fm8St5LdDtywJBQ==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Make watchdog and suspend-timing
 multiplication overflow safe
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-20-adrian.hunter@intel.com>
References: <20240325064023.2997-20-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258182982.10875.4615365619574424131.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d0304569fb019d1bcfbbbce1ce6df6b96f04079b
Gitweb:        https://git.kernel.org/tip/d0304569fb019d1bcfbbbce1ce6df6b96f04079b
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:08 +02:00

clocksource: Make watchdog and suspend-timing multiplication overflow safe

Kernel timekeeping is designed to keep the change in cycles (since the last
timer interrupt) below max_cycles, which prevents multiplication overflow
when converting cycles to nanoseconds. However, if timer interrupts stop,
the clocksource_cyc2ns() calculation will eventually overflow.

Add protection against that. Simplify by folding together
clocksource_delta() and clocksource_cyc2ns() into cycles_to_nsec_safe().
Check against max_cycles, falling back to a slower higher precision
calculation.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-20-adrian.hunter@intel.com

---
 kernel/time/clocksource.c | 42 ++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index e5b260a..4d50d53 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -20,6 +20,16 @@
 #include "tick-internal.h"
 #include "timekeeping_internal.h"
 
+static noinline u64 cycles_to_nsec_safe(struct clocksource *cs, u64 start, u64 end)
+{
+	u64 delta = clocksource_delta(end, start, cs->mask);
+
+	if (likely(delta < cs->max_cycles))
+		return clocksource_cyc2ns(delta, cs->mult, cs->shift);
+
+	return mul_u64_u32_shr(delta, cs->mult, cs->shift);
+}
+
 /**
  * clocks_calc_mult_shift - calculate mult/shift factors for scaled math of clocks
  * @mult:	pointer to mult variable
@@ -222,8 +232,8 @@ enum wd_read_status {
 static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 {
 	unsigned int nretries, max_retries;
-	u64 wd_end, wd_end2, wd_delta;
 	int64_t wd_delay, wd_seq_delay;
+	u64 wd_end, wd_end2;
 
 	max_retries = clocksource_get_max_watchdog_retry();
 	for (nretries = 0; nretries <= max_retries; nretries++) {
@@ -234,9 +244,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, 
 		wd_end2 = watchdog->read(watchdog);
 		local_irq_enable();
 
-		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
-		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
-					      watchdog->shift);
+		wd_delay = cycles_to_nsec_safe(watchdog, *wdnow, wd_end);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
 			if (nretries > 1 || nretries >= max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
@@ -254,8 +262,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, 
 		 * report system busy, reinit the watchdog and skip the current
 		 * watchdog test.
 		 */
-		wd_delta = clocksource_delta(wd_end2, wd_end, watchdog->mask);
-		wd_seq_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
+		wd_seq_delay = cycles_to_nsec_safe(watchdog, wd_end, wd_end2);
 		if (wd_seq_delay > WATCHDOG_MAX_SKEW/2)
 			goto skip_test;
 	}
@@ -366,8 +373,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 		delta = (csnow_end - csnow_mid) & cs->mask;
 		if (delta < 0)
 			cpumask_set_cpu(cpu, &cpus_ahead);
-		delta = clocksource_delta(csnow_end, csnow_begin, cs->mask);
-		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
+		cs_nsec = cycles_to_nsec_safe(cs, csnow_begin, csnow_end);
 		if (cs_nsec > cs_nsec_max)
 			cs_nsec_max = cs_nsec;
 		if (cs_nsec < cs_nsec_min)
@@ -398,8 +404,8 @@ static inline void clocksource_reset_watchdog(void)
 
 static void clocksource_watchdog(struct timer_list *unused)
 {
-	u64 csnow, wdnow, cslast, wdlast, delta;
 	int64_t wd_nsec, cs_nsec, interval;
+	u64 csnow, wdnow, cslast, wdlast;
 	int next_cpu, reset_pending;
 	struct clocksource *cs;
 	enum wd_read_status read_ret;
@@ -456,12 +462,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 		}
 
-		delta = clocksource_delta(wdnow, cs->wd_last, watchdog->mask);
-		wd_nsec = clocksource_cyc2ns(delta, watchdog->mult,
-					     watchdog->shift);
-
-		delta = clocksource_delta(csnow, cs->cs_last, cs->mask);
-		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
+		wd_nsec = cycles_to_nsec_safe(watchdog, cs->wd_last, wdnow);
+		cs_nsec = cycles_to_nsec_safe(cs, cs->cs_last, csnow);
 		wdlast = cs->wd_last; /* save these in case we print them */
 		cslast = cs->cs_last;
 		cs->cs_last = csnow;
@@ -832,7 +834,7 @@ void clocksource_start_suspend_timing(struct clocksource *cs, u64 start_cycles)
  */
 u64 clocksource_stop_suspend_timing(struct clocksource *cs, u64 cycle_now)
 {
-	u64 now, delta, nsec = 0;
+	u64 now, nsec = 0;
 
 	if (!suspend_clocksource)
 		return 0;
@@ -847,12 +849,8 @@ u64 clocksource_stop_suspend_timing(struct clocksource *cs, u64 cycle_now)
 	else
 		now = suspend_clocksource->read(suspend_clocksource);
 
-	if (now > suspend_start) {
-		delta = clocksource_delta(now, suspend_start,
-					  suspend_clocksource->mask);
-		nsec = mul_u64_u32_shr(delta, suspend_clocksource->mult,
-				       suspend_clocksource->shift);
-	}
+	if (now > suspend_start)
+		nsec = cycles_to_nsec_safe(suspend_clocksource, suspend_start, now);
 
 	/*
 	 * Disable the suspend timer to save power if current clocksource is


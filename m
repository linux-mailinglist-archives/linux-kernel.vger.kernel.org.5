Return-Path: <linux-kernel+bounces-135389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EC489C0A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6977E28195F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1C27BB15;
	Mon,  8 Apr 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uYPqh8a2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3V8GlySB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF470CDA;
	Mon,  8 Apr 2024 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581836; cv=none; b=ODWjxZ2FUhVjyy72g2iNA9NnFQcx08deZskPLkNqLLpdr+H1grP8IhjtRVP8av9CIWu/nDx2QTvPnk7EE5Nto5KR7laQs5Bdqnq8YyzwuGhZNhGxLjFzC6iZDIqI5lAWGbOeYRXKLwC+mXRNpkCov+9G1K/1yAjQSNWdDGuyPmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581836; c=relaxed/simple;
	bh=LzmhERQWz0JauYfVzZg0eerqc98SEgrPoVm+gvrV/Uk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fpSKYywhdMmT75C5Ly9MNUkWBudl+xADujR/nuRh+utpNIoNYO/JQnK4LRtZAoGU7N5RBFwS6589AuRYZoqgIMrztmwTZECSVt6xZ9VWyBph/9Ow80a6cfWQ+YhGb9arAdsaAWuIbtLoHDUYzKSnmgvyL5B6DMO3qlh7UvKOnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uYPqh8a2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3V8GlySB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/DcHe2oN/vWLAEYglDVT0qLoZqRQK1arLCcijlMBko=;
	b=uYPqh8a2LS0t7gvlPq6XFUDtcWykkkNyHWjTIdGYyq4lmaR5n0h3BsArBEUv798WLFMU/+
	Q3Ao0EMsMecYRqqV/0H7MGHaib2JFkLFAbvN38twsIAPziFQBYIYQQhxeM23D3JzFeie+p
	+s3ludvJVi8xh8V0Hb/P0L7UCK5pElWu4EPhBmHak95tZojMj2XjnnCZFK+cKglyvl8oq1
	f52jsRawZiy/0ImXa2xoOAnGdJ7CU6iB3ZYxIHO8V4s/QaBqAnIjABORuGZYuX6LeyWdEl
	6OhHMqL/NzdQkWeUTbwghlpPoeSoU2PiA2FMVJzJN35X+yOn4s4NX0Mtim9CDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/DcHe2oN/vWLAEYglDVT0qLoZqRQK1arLCcijlMBko=;
	b=3V8GlySBrNWM51iwF2R+ysnI6cVM9QmLGr7qkkgn8b+TH2PwYKzv763apvITrinZi5CSSZ
	M8yiITRqqruSNKBg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Make delta calculation overflow safe
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-18-adrian.hunter@intel.com>
References: <20240325064023.2997-18-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258183251.10875.11815766189423599401.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     fcf190c369149c3b04539797cedf28741eb14164
Gitweb:        https://git.kernel.org/tip/fcf190c369149c3b04539797cedf28741eb14164
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:08 +02:00

timekeeping: Make delta calculation overflow safe

Kernel timekeeping is designed to keep the change in cycles (since the last
timer interrupt) below max_cycles, which prevents multiplication overflow
when converting cycles to nanoseconds. However, if timer interrupts stop,
the calculation will eventually overflow.

Add protection against that. In timekeeping_cycles_to_ns() calculation,
check against max_cycles, falling back to a slower higher precision
calculation. In timekeeping_forward_now(), process delta in chunks of at
most max_cycles.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-18-adrian.hunter@intel.com

---
 kernel/time/timekeeping.c | 40 +++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d174840..111dfdb 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -364,19 +364,32 @@ static void tk_setup_internals(struct timekeeper *tk, struct clocksource *clock)
 }
 
 /* Timekeeper helper functions. */
+static noinline u64 delta_to_ns_safe(const struct tk_read_base *tkr, u64 delta)
+{
+	return mul_u64_u32_add_u64_shr(delta, tkr->mult, tkr->xtime_nsec, tkr->shift);
+}
+
 static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles)
 {
 	/* Calculate the delta since the last update_wall_time() */
 	u64 mask = tkr->mask, delta = (cycles - tkr->cycle_last) & mask;
 
-	if (IS_ENABLED(CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE)) {
-		/*
-		 * Handle clocksource inconsistency between CPUs to prevent
-		 * time from going backwards by checking for the MSB of the
-		 * mask being set in the delta.
-		 */
-		if (unlikely(delta & ~(mask >> 1)))
-			return tkr->xtime_nsec >> tkr->shift;
+	/*
+	 * This detects the case where the delta overflows the multiplication
+	 * with tkr->mult.
+	 */
+	if (unlikely(delta > tkr->clock->max_cycles)) {
+		if (IS_ENABLED(CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE)) {
+			/*
+			 * Handle clocksource inconsistency between CPUs to prevent
+			 * time from going backwards by checking for the MSB of the
+			 * mask being set in the delta.
+			 */
+			if (unlikely(delta & ~(mask >> 1)))
+				return tkr->xtime_nsec >> tkr->shift;
+		}
+
+		return delta_to_ns_safe(tkr, delta);
 	}
 
 	return ((delta * tkr->mult) + tkr->xtime_nsec) >> tkr->shift;
@@ -789,10 +802,15 @@ static void timekeeping_forward_now(struct timekeeper *tk)
 	tk->tkr_mono.cycle_last = cycle_now;
 	tk->tkr_raw.cycle_last  = cycle_now;
 
-	tk->tkr_mono.xtime_nsec += delta * tk->tkr_mono.mult;
-	tk->tkr_raw.xtime_nsec += delta * tk->tkr_raw.mult;
+	while (delta > 0) {
+		u64 max = tk->tkr_mono.clock->max_cycles;
+		u64 incr = delta < max ? delta : max;
 
-	tk_normalize_xtime(tk);
+		tk->tkr_mono.xtime_nsec += incr * tk->tkr_mono.mult;
+		tk->tkr_raw.xtime_nsec += incr * tk->tkr_raw.mult;
+		tk_normalize_xtime(tk);
+		delta -= incr;
+	}
 }
 
 /**


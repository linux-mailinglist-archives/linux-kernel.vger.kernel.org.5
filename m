Return-Path: <linux-kernel+bounces-71687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A2785A906
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E314283CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD923FE4C;
	Mon, 19 Feb 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fd5pl+gp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hL9/S4dy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2EA3F8DA;
	Mon, 19 Feb 2024 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360520; cv=none; b=pPWTKRQXSAp4X2AybWUZhYs9TKK8bJXaD2sjK4FFINE/AN0eRJEK3eK5njODBF4IXNzlxezw/BeWVn+Knx4U0auzDObJgvz02zWg/VHtQVIg4ndOLC1MfXC1BQRuUY9Bu6k0ZlyYHAUlHb1/I4xlGFTd8mG2TeROmwFLenq2vyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360520; c=relaxed/simple;
	bh=A7kkVstefmy/G8B3QJ5+gmq/tloozB0WcNaV/YC4/Sw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X2ddckyBPrymPZwrpnfhbPHxHuSqoFKUDahYTDK+u22eUKpL8LgQppl/Oaf/LIf+yJP5VH601xWJQsXc+mF3Av3DPxmAo31UTkLMplnnHUPPpWJhfIklL/CXi2edagBG8fk7qzaHyeSH+LSJCf8qPfoOuWQya3ub5RyqkuYMNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fd5pl+gp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hL9/S4dy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 16:35:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708360517;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9CTE6txggKbm42VGWt32hCnmGwsNogqpM5Wl2vVBq8=;
	b=fd5pl+gpmswO0nicu766KBiuNOPygF5xbNWjMu28TEB4NXbWnKJiET9ODkZulQiIddMpjM
	t7lsTlgZXkrlJ+SscOMSAxUejz76JSIrHE70VHXd30Gn5ijljehuMhH+o9Xprvv0RRSEOF
	AN0+ZEFfplJdVLbSwcVcm8d6PVaLei4+cCQAqMCEM4957agnHkMjo1eibKlZGytulD4mhP
	vTNfXn2r8TiA4vv6LWjWlmWeYF/MOFpCu8pmEIYn0+lnsUUzKUiVsBFJryW56xnxuiX3/G
	1StauiljM+FeIF7P8brPiwhtylScT14fhiea5ntreXMjGG0Qw/QOla3Hof0nHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708360517;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9CTE6txggKbm42VGWt32hCnmGwsNogqpM5Wl2vVBq8=;
	b=hL9/S4dyuaJSDE5iuZ9xftE6fzzDUjubplgV34tNj5e/DqRZjNscmUdNGJE4iGMZFr9Gpb
	UV75kbgKgjnCCmDg==
From: "tip-bot2 for Peter Hilber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Fix cross-timestamp interpolation
 corner case decision
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231218073849.35294-3-peter.hilber@opensynergy.com>
References: <20231218073849.35294-3-peter.hilber@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836051645.398.6755085884635470259.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     87a41130881995f82f7adbafbfeddaebfb35f0ef
Gitweb:        https://git.kernel.org/tip/87a41130881995f82f7adbafbfeddaebfb35f0ef
Author:        Peter Hilber <peter.hilber@opensynergy.com>
AuthorDate:    Mon, 18 Dec 2023 08:38:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Feb 2024 12:18:51 +01:00

timekeeping: Fix cross-timestamp interpolation corner case decision

The cycle_between() helper checks if parameter test is in the open interval
(before, after). Colloquially speaking, this also applies to the counter
wrap-around special case before > after. get_device_system_crosststamp()
currently uses cycle_between() at the first call site to decide whether to
interpolate for older counter readings.

get_device_system_crosststamp() has the following problem with
cycle_between() testing against an open interval: Assume that, by chance,
cycles == tk->tkr_mono.cycle_last (in the following, "cycle_last" for
brevity). Then, cycle_between() at the first call site, with effective
argument values cycle_between(cycle_last, cycles, now), returns false,
enabling interpolation. During interpolation,
get_device_system_crosststamp() will then call cycle_between() at the
second call site (if a history_begin was supplied). The effective argument
values are cycle_between(history_begin->cycles, cycles, cycles), since
system_counterval.cycles == interval_start == cycles, per the assumption.
Due to the test against the open interval, cycle_between() returns false
again. This causes get_device_system_crosststamp() to return -EINVAL.

This failure should be avoided, since get_device_system_crosststamp() works
both when cycles follows cycle_last (no interpolation), and when cycles
precedes cycle_last (interpolation). For the case cycles == cycle_last,
interpolation is actually unneeded.

Fix this by changing cycle_between() into timestamp_in_interval(), which
now checks against the closed interval, rather than the open interval.

This changes the get_device_system_crosststamp() behavior for three corner
cases:

1. Bypass interpolation in the case cycles == tk->tkr_mono.cycle_last,
   fixing the problem described above.

2. At the first timestamp_in_interval() call site, cycles == now no longer
   causes failure.

3. At the second timestamp_in_interval() call site, history_begin->cycles
   == system_counterval.cycles no longer causes failure.
   adjust_historical_crosststamp() also works for this corner case,
   where partial_history_cycles == total_history_cycles.

These behavioral changes should not cause any problems.

Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231218073849.35294-3-peter.hilber@opensynergy.com

---
 kernel/time/timekeeping.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 8f35455..4e9f2f8 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1180,13 +1180,15 @@ static int adjust_historical_crosststamp(struct system_time_snapshot *history,
 }
 
 /*
- * cycle_between - true if test occurs chronologically between before and after
+ * timestamp_in_interval - true if ts is chronologically in [start, end]
+ *
+ * True if ts occurs chronologically at or after start, and before or at end.
  */
-static bool cycle_between(u64 before, u64 test, u64 after)
+static bool timestamp_in_interval(u64 start, u64 end, u64 ts)
 {
-	if (test > before && test < after)
+	if (ts >= start && ts <= end)
 		return true;
-	if (before > after && (test > before || test < after))
+	if (start > end && (ts >= start || ts <= end))
 		return true;
 	return false;
 }
@@ -1246,7 +1248,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		 */
 		now = tk_clock_read(&tk->tkr_mono);
 		interval_start = tk->tkr_mono.cycle_last;
-		if (!cycle_between(interval_start, cycles, now)) {
+		if (!timestamp_in_interval(interval_start, now, cycles)) {
 			clock_was_set_seq = tk->clock_was_set_seq;
 			cs_was_changed_seq = tk->cs_was_changed_seq;
 			cycles = interval_start;
@@ -1277,13 +1279,13 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		bool discontinuity;
 
 		/*
-		 * Check that the counter value occurs after the provided
+		 * Check that the counter value is not before the provided
 		 * history reference and that the history doesn't cross a
 		 * clocksource change
 		 */
 		if (!history_begin ||
-		    !cycle_between(history_begin->cycles,
-				   system_counterval.cycles, cycles) ||
+		    !timestamp_in_interval(history_begin->cycles,
+					   cycles, system_counterval.cycles) ||
 		    history_begin->cs_was_changed_seq != cs_was_changed_seq)
 			return -EINVAL;
 		partial_history_cycles = cycles - system_counterval.cycles;


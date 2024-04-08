Return-Path: <linux-kernel+bounces-135391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D80FA89C0AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BD0281963
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B017C0BF;
	Mon,  8 Apr 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lEF+fO4K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b41N6bNg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B77317D;
	Mon,  8 Apr 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581837; cv=none; b=M+1t1OqQ5xnmToTEaCCWXUpVXcnVI2vPOD+yqzIMwFefOawl4yGwIbMBJddjCtN7BCNNuJy3qLcqJjt0iTM08WKAjJh6pN/qx2f6k5x7f4ivLP1wWcwJvqPdVlEirhpLJraIhQh4VQAA98qexMd6oL7EBwnMIFxNhfAFWGiL6l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581837; c=relaxed/simple;
	bh=FjPL6CatV/Y4na7vOOXtnfbJL77oK9XRYpZ8AX5Vj18=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QVoNUAmdRzyKZhCYv2hA+7W34fLLdjwaRx1Xsf7cfh21uu4x8TI4QrGg7l9ltMh/ui+m+BIXYzzlQTtxqRbm4ZCuBqpuUwhaG4f9cRDbStWmZ4FatzFrm8PVeMJ3i8Y9y3NwaaaXgOdtteq47RWgOHkGVL8Lp48bMKpj9X54E68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lEF+fO4K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b41N6bNg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581834;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rVdAt5QbB8Evfb6exw131d2h7rvMCM7Gb4D0X+czEQ=;
	b=lEF+fO4K6k620QBpK2qqm6tKK7T9uusFFLGgNZiw1GJiyCjnhQtL3PyYRTfgPXRF12/BDc
	oBKY9UXKwGZF7cjkDMpn0+IVg6H6mfuXT/fvyk3rNtJywSOUFdW/M4ge42ZF7f7U24Oiyg
	VSH7n8J7sEf4p1iVuA5zLfeloMYgBwIdbG3ISvChxLpR8h6itfehPOwGvx0lUh5o1eljJ/
	xZwInZduQrAQLfA6UM0dx5Pna9npXft1KzWXH8XiXUWNeoFsvcrHVILc2Iaw/cnDl87waI
	ICSsZbbv33FJka2ofFnY8Kgnqb0BiDrSxDOSag1UFfCEVCZE05C7LIKwCcpUcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581834;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rVdAt5QbB8Evfb6exw131d2h7rvMCM7Gb4D0X+czEQ=;
	b=b41N6bNgpjBXVbDjYuLqi79yyb5hRfSmOvwzmlOKIzt1aWvsaUFmDL8GRu4d9ikodWufoQ
	k+LbDQ5xMBTMHrAg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Prepare timekeeping_cycles_to_ns()
 for overflow safety
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-17-adrian.hunter@intel.com>
References: <20240325064023.2997-17-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258183338.10875.7234337183877644800.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e809a80aa0bcf802f99407c23fd6be6fd4eb250a
Gitweb:        https://git.kernel.org/tip/e809a80aa0bcf802f99407c23fd6be6fd4eb250a
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:08 +02:00

timekeeping: Prepare timekeeping_cycles_to_ns() for overflow safety

Open code clocksource_delta() in timekeeping_cycles_to_ns() so that
overflow safety can be added efficiently.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-17-adrian.hunter@intel.com

---
 kernel/time/timekeeping.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 749387f..d174840 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -367,7 +367,17 @@ static void tk_setup_internals(struct timekeeper *tk, struct clocksource *clock)
 static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles)
 {
 	/* Calculate the delta since the last update_wall_time() */
-	u64 delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
+	u64 mask = tkr->mask, delta = (cycles - tkr->cycle_last) & mask;
+
+	if (IS_ENABLED(CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE)) {
+		/*
+		 * Handle clocksource inconsistency between CPUs to prevent
+		 * time from going backwards by checking for the MSB of the
+		 * mask being set in the delta.
+		 */
+		if (unlikely(delta & ~(mask >> 1)))
+			return tkr->xtime_nsec >> tkr->shift;
+	}
 
 	return ((delta * tkr->mult) + tkr->xtime_nsec) >> tkr->shift;
 }


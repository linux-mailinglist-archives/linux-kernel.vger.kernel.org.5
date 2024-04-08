Return-Path: <linux-kernel+bounces-135390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749CA89C0AE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162A71F21728
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279037C09F;
	Mon,  8 Apr 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qdynl7UV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jWWEtgr6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6812C6FE1A;
	Mon,  8 Apr 2024 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581837; cv=none; b=L90FMBhRXDMBLuydwzNr/S3Gt1m2qiKK7W6fzVfwy2F/p9YO0kKEK9502KiUESlCXNGJM1yCTFZnNvkH7zVRhQ5pHc6h1k9iatNC5yPKhPGlxZGR10Cm239oqnCXqgRnk4FWQc5tuhY+pHWeEtmRnyAFWhCLbrYKRX2JuA9d6S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581837; c=relaxed/simple;
	bh=P7uI6J64hpyeAInnp3Pe7O7zF+FZCbW0gQ8CsYZoSfQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PUu7H7wxlVqrkU06Z/0A2QfKEM+RhuC1ZaKo6hSXTgJm/4pvANYcWimxAHgWulltMLfh5cmmO8mljJOFLIixM4KRApuy/KsBtSZEXvVAe5BkKTmkmJaog2zJ3Qx7ouSGZFDNL6Sf1a8OnZgSy2Z1vJ8KnIStmbbogjnH+FmY8MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qdynl7UV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jWWEtgr6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581832;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScL8mJAlf3I0rDv2s0BuY8SdwWQxz0AIpq6YoEVg2tc=;
	b=qdynl7UVcrptl3JfPemhc1j6Fs1ACcUXiPIG9i0+beAyMQxx9D9VTSbSHYHtsDk1UhK0+5
	rF0XD/Yx2W9N8wPAoECEQN+xWXczDOSyI28W2nFD4PHBxt8g4hVI2odOGM4UMCg5vM31oX
	B0f7faye3wscwgrKtvE9pbXcFp5Se0FLWQDCGiHv4FpI0jYb39uz/cl0p6uuvlYHrRakGx
	e5GWdIyumtIq0C5uBMIXkr5wRP1GPiDS1A6Rs28HJrgNxGWfJmIcL/2QtgUKAcBJcCQGvW
	bwyZcWDz+F/LXO3MD6cQJx0Seu051tCNmslEg2ToQygUd95mnGMVBwCAZafZ8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581832;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScL8mJAlf3I0rDv2s0BuY8SdwWQxz0AIpq6YoEVg2tc=;
	b=jWWEtgr60liRmnNiPTnf4W5s4zzgYWLdahb0qCVr/PwWyjsdsRrCSTwjGFVXxKWi+yIKA1
	nu2kfwTtMqEy0kBg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Let timekeeping_cycles_to_ns() handle
 both under and overflow
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-19-adrian.hunter@intel.com>
References: <20240325064023.2997-19-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258183149.10875.16808842183811957786.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     135225a363ae67bc90bde7a2cbbe1ea0f152ba22
Gitweb:        https://git.kernel.org/tip/135225a363ae67bc90bde7a2cbbe1ea0f152ba22
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:08 +02:00

timekeeping: Let timekeeping_cycles_to_ns() handle both under and overflow

For the case !CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE, forego overflow
protection in the range (mask << 1) < delta <= mask, and interpret it
always as an inconsistency between CPU clock values. That allows
slightly neater code, and it is on a slow path so has no effect on
performance.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-19-adrian.hunter@intel.com

---
 kernel/time/timekeeping.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 111dfdb..4e18db1 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -266,17 +266,14 @@ static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
 	 * Try to catch underflows by checking if we are seeing small
 	 * mask-relative negative values.
 	 */
-	if (unlikely((~delta & mask) < (mask >> 3))) {
+	if (unlikely((~delta & mask) < (mask >> 3)))
 		tk->underflow_seen = 1;
-		now = last;
-	}
 
-	/* Cap delta value to the max_cycles values to avoid mult overflows */
-	if (unlikely(delta > max)) {
+	/* Check for multiplication overflows */
+	if (unlikely(delta > max))
 		tk->overflow_seen = 1;
-		now = last + max;
-	}
 
+	/* timekeeping_cycles_to_ns() handles both under and overflow */
 	return timekeeping_cycles_to_ns(tkr, now);
 }
 #else
@@ -375,19 +372,17 @@ static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 c
 	u64 mask = tkr->mask, delta = (cycles - tkr->cycle_last) & mask;
 
 	/*
-	 * This detects the case where the delta overflows the multiplication
-	 * with tkr->mult.
+	 * This detects both negative motion and the case where the delta
+	 * overflows the multiplication with tkr->mult.
 	 */
 	if (unlikely(delta > tkr->clock->max_cycles)) {
-		if (IS_ENABLED(CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE)) {
-			/*
-			 * Handle clocksource inconsistency between CPUs to prevent
-			 * time from going backwards by checking for the MSB of the
-			 * mask being set in the delta.
-			 */
-			if (unlikely(delta & ~(mask >> 1)))
-				return tkr->xtime_nsec >> tkr->shift;
-		}
+		/*
+		 * Handle clocksource inconsistency between CPUs to prevent
+		 * time from going backwards by checking for the MSB of the
+		 * mask being set in the delta.
+		 */
+		if (delta & ~(mask >> 1))
+			return tkr->xtime_nsec >> tkr->shift;
 
 		return delta_to_ns_safe(tkr, delta);
 	}


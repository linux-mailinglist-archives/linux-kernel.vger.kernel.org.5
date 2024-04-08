Return-Path: <linux-kernel+bounces-135393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6BA89C0C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBB01C217F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BEC7E572;
	Mon,  8 Apr 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g7CcQfgB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HcBogRps"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC06F7C086;
	Mon,  8 Apr 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581839; cv=none; b=gYBkNe8njp57lh7kZORnbckIVqmn+XwJuJnR0uBfxV2sqUlA31eb0y6UP0HhoDdyvYSlaFialG8Fkfw8p/auZezlH0XvN5qb5re0CcNsiSrIrqB9qj9456NO9QW0BUnKqHj0obkFZMECoFbsmQpcIHN2kbD3OTU94TeyPJ6wI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581839; c=relaxed/simple;
	bh=mN5ZU1h56JdUGSuqshA5rsJr+mVDacGc9R/xyT4xlMQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Lef/PhGt//UjSkzqPuVg8TaiLeKQuKbMZw0gJY2qPt21IR0LhvEJw5aL2QeAYLB2WiyRygGdj5GDW/NPSnVIh0QUpTnfBaXzFoQMpFsvuvXZObPo2MldCUoo1nsBOyDhNUUttZaVNT1HuMOtRUR/FJYo3alARyhlUHFVGhL5xIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g7CcQfgB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HcBogRps; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581835;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQ/OGDtp2giMcT/fWcbolb0miqgxlYVyiLtUTykBXr8=;
	b=g7CcQfgBdFCrxRISrVfF02XDd3FGM5dynAB1KcOxT6KWX6/eQeegYW26g3we2xcFNzs/RN
	qi1BSMLXT0ZVaaVWIkzuTMPRr7Lokup98VrThLRjTrBa1ITaSP/kTOOxOATmPjAnVlrbAv
	KlHdUb5yH70ntV0TnaookaZTtsD6ylxkMq/KeOOToRPozdXTNgfKv073bwJWsmxkmMrR7d
	4RJG7z9798Pi/X7lisRQRt/CGXmL1OLPm1AmZ0sBRN1yhG/Dwm7A9Xe3tG+OZvKWp/+oYM
	/lIMR/pv8iAbrzGhl30BpmgaJPSvyLf8zHXBkHc5BrvFMir4m+Mjh6w+RWx8iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581835;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQ/OGDtp2giMcT/fWcbolb0miqgxlYVyiLtUTykBXr8=;
	b=HcBogRpsTuQrt/qBQ/qYG8QzLzmirExsJCp/6Z1KVD5/IhV9sqd6qxLe9Ilmasoh6gXVgI
	9ghlI0g/7drQeMCg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Consolidate timekeeping helpers
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-15-adrian.hunter@intel.com>
References: <20240325064023.2997-15-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258183490.10875.3885868540516414539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e84f43e34faf85816587f80594541ec978449d6e
Gitweb:        https://git.kernel.org/tip/e84f43e34faf85816587f80594541ec978449d6e
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:08 +02:00

timekeeping: Consolidate timekeeping helpers

Consolidate timekeeping helpers, making use of timekeeping_cycles_to_ns()
in preference to directly using timekeeping_delta_to_ns().

No functional change.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-15-adrian.hunter@intel.com

---
 kernel/time/timekeeping.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 618328c..1bbfe1f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -237,7 +237,9 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 }
 
-static inline u64 timekeeping_debug_get_delta(const struct tk_read_base *tkr)
+static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles);
+
+static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	u64 now, last, mask, max, delta;
@@ -266,22 +268,22 @@ static inline u64 timekeeping_debug_get_delta(const struct tk_read_base *tkr)
 	 */
 	if (unlikely((~delta & mask) < (mask >> 3))) {
 		tk->underflow_seen = 1;
-		delta = 0;
+		now = last;
 	}
 
 	/* Cap delta value to the max_cycles values to avoid mult overflows */
 	if (unlikely(delta > max)) {
 		tk->overflow_seen = 1;
-		delta = tkr->clock->max_cycles;
+		now = last + max;
 	}
 
-	return delta;
+	return timekeeping_cycles_to_ns(tkr, now);
 }
 #else
 static inline void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 {
 }
-static inline u64 timekeeping_debug_get_delta(const struct tk_read_base *tkr)
+static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
 {
 	BUG();
 }
@@ -389,7 +391,7 @@ static __always_inline u64 __timekeeping_get_ns(const struct tk_read_base *tkr)
 static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_TIMEKEEPING))
-		return timekeeping_delta_to_ns(tkr, timekeeping_debug_get_delta(tkr));
+		return timekeeping_debug_get_ns(tkr);
 
 	return __timekeeping_get_ns(tkr);
 }


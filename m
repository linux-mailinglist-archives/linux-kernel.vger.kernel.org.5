Return-Path: <linux-kernel+bounces-135394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07D689C0C0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4761C21885
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D5E7E574;
	Mon,  8 Apr 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HrizNykE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cAqvAf0t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483C27C0B2;
	Mon,  8 Apr 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581839; cv=none; b=YJWqNLKg3rgb4JlvT64WTCrc/gWIynjmVXtDRZA5c6y/aEVMwO/aRotEsg9R8G/QPm9edi+WBSkNJvo6Owke95GTSbKiGD2ku3l+oBJpu/An5n4GqjAv6Qrn9GenVuN2qOdqYhAxVL9MPdaxmWy35VWP/I4KjugB1pB2mImseOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581839; c=relaxed/simple;
	bh=4gM/Iv/rbyjNy9WqpUKprlpYSxvO1553AjA0FyyGbpk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gFu20Dtqm7+zvsmRYI/6AUbRtnxTATfMVZ+AZd038+yBJM7WycQmVPzKM8K+q937NE9/V+jQH0KtmHQ7mVsRM1yffscwG5zivXs9UN5n6Nuu98f3CwRwoQue457JI6qtjlYYQP5YIQcyDsXuVerudoEGL5pCXCth/wpjn7bHXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HrizNykE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cAqvAf0t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581836;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=El2P6M3UbgU8GlrwKYiLLfttFyI/yFV90aR5IWNJtCA=;
	b=HrizNykEcUYSIGr3NDm+7jx6j22RU5OZkhITuxRhcYseO1jpKcWYZA6WcLa3GrxWQ//Avb
	EnsNdlAannPbTZewpdUC+6VbwNyShcWsrP1vxSCqcmcH2WDdH6jyBOfZtUaZ30tiv0DrF9
	b6QY6nBQkUujDm/Ui02hF8RS5yWheEk1K9V+Fgyo+B7YP5AznEQ6VwslCWXUT7SQ1YR0PH
	yLeZbp3ncsM7VsmVMnTLQnxXGxuAyui5bComMf7fhekEcBRDiUhWFS/uubOwiz8t3hDiAT
	RussXnkxlbHAy38hekR/Lfo4YB/JktlPbPmK1Cxhh85gBK2iXtCK2eD8ryL0Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581836;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=El2P6M3UbgU8GlrwKYiLLfttFyI/yFV90aR5IWNJtCA=;
	b=cAqvAf0tLbOiXLPz7rIdTo88pL3bIFBnvg/L8rVoIe+KfVhKGzJnkeNPiy1O0MwWGudijU
	2ovdDKvLyy/IirBw==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Refactor timekeeping helpers
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-14-adrian.hunter@intel.com>
References: <20240325064023.2997-14-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258183570.10875.9052005206326992801.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e8e9d21a5df655a62ab4611fd437fb7510d2f85c
Gitweb:        https://git.kernel.org/tip/e8e9d21a5df655a62ab4611fd437fb7510d2f85c
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:17 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:08 +02:00

timekeeping: Refactor timekeeping helpers

Simplify the usage of timekeeping sanity checking, in preparation for
consolidating timekeeping helpers. This works towards eliminating
timekeeping_delta_to_ns() in favour of timekeeping_cycles_to_ns().

No functional change.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-14-adrian.hunter@intel.com

---
 kernel/time/timekeeping.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f81d675..618328c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -237,7 +237,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 }
 
-static inline u64 timekeeping_get_delta(const struct tk_read_base *tkr)
+static inline u64 timekeeping_debug_get_delta(const struct tk_read_base *tkr)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	u64 now, last, mask, max, delta;
@@ -281,17 +281,9 @@ static inline u64 timekeeping_get_delta(const struct tk_read_base *tkr)
 static inline void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 {
 }
-static inline u64 timekeeping_get_delta(const struct tk_read_base *tkr)
+static inline u64 timekeeping_debug_get_delta(const struct tk_read_base *tkr)
 {
-	u64 cycle_now, delta;
-
-	/* read clocksource */
-	cycle_now = tk_clock_read(tkr);
-
-	/* calculate the delta since the last update_wall_time */
-	delta = clocksource_delta(cycle_now, tkr->cycle_last, tkr->mask);
-
-	return delta;
+	BUG();
 }
 #endif
 
@@ -396,10 +388,10 @@ static __always_inline u64 __timekeeping_get_ns(const struct tk_read_base *tkr)
 
 static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
 {
-	u64 delta;
+	if (IS_ENABLED(CONFIG_DEBUG_TIMEKEEPING))
+		return timekeeping_delta_to_ns(tkr, timekeeping_debug_get_delta(tkr));
 
-	delta = timekeeping_get_delta(tkr);
-	return timekeeping_delta_to_ns(tkr, delta);
+	return __timekeeping_get_ns(tkr);
 }
 
 /**


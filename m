Return-Path: <linux-kernel+bounces-135392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7100A89C0B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29931C21BB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ACB7D06E;
	Mon,  8 Apr 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VvGt46c5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="doFzDD9K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BE67BAFF;
	Mon,  8 Apr 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581838; cv=none; b=G6bJY3dBSJHSPj8KkapyoHNRRyGJbnhmLzAQq/E9oUiWK8EylOeEvQO5xfkRfFISLyqEUxdRwBzGQqZB5O24tL1H4HDsTy2THJEOqRvTP/vnwqD9CE8npfwm8QnpNwc/DP0/FlYvfao/o5LnTvl4xhmrogbbA26YYxrlVnF0HJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581838; c=relaxed/simple;
	bh=Uqr4kevpJcVttYuqx7arACqw5Nu+AyZH0jTEPng0isQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HIKF9rMpm0jR3C9ArYY7/Kn/7WHaHNqFk/l5JfL4JXb9BMQArKgb2QOJo40l4J2pQtsouo5b6/NcD0hPuLtFpCkHKswLjw5WQreFq5QuP9FKH5CBDmMAQZoCQeIlDWPbKQZl+0KPmyd+/lwwamKVtu/bCJSH5CNLCzvxOo4nEs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VvGt46c5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=doFzDD9K; arc=none smtp.client-ip=193.142.43.55
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
	bh=RkAy0SkmM4aNxUEvm9Tz+iqysuIWNfHVFtWRm6hbNiI=;
	b=VvGt46c5qSnM43n0W1C8iyTo1g9DyvGqqMR2ImlbSY9bpTo9olkxb+Bx937OwP7RmkGO8F
	1wc9aMXVT52WI3xmm/7UL2qJmCP+mmwkVG2/BfWNnXkLMJDfwdEJghLJr9ymtF0G2kb1dF
	uhLRYOFV+9E54hVzQszcmg2mobDtEGSejq+1QsqZ0VryJENwFkF1xs08TFk6XdDOiXlSwq
	CvLnB0PXye3XfZNLgw4DBTsiqzVcopAIreIsfW2zA5iuGllorn2zgHattK2cDvRyDqmgwV
	0MOoycjCpffMJFlSjEJr8xSVilEasqGhZCgyK2MJImlLTY8D2GsBtnOC8iKuWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581835;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkAy0SkmM4aNxUEvm9Tz+iqysuIWNfHVFtWRm6hbNiI=;
	b=doFzDD9K5muKujKk/iNMGr76cU9iUdiPsUMbnGsXwIUPluGhmsvzJt6HyC4A3j2xXLeA+X
	dGHYdYogPlC9jtDg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Fold in timekeeping_delta_to_ns()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-16-adrian.hunter@intel.com>
References: <20240325064023.2997-16-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258183416.10875.7897346415236970427.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3094c6db1cba0bbca6ea19c777762c26fee747d7
Gitweb:        https://git.kernel.org/tip/3094c6db1cba0bbca6ea19c777762c26fee747d7
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:08 +02:00

timekeeping: Fold in timekeeping_delta_to_ns()

timekeeping_delta_to_ns() is now called only from
timekeeping_cycles_to_ns(), and it is not useful otherwise.

Simplify the code by folding it into timekeeping_cycles_to_ns().

No functional change.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-16-adrian.hunter@intel.com

---
 kernel/time/timekeeping.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 1bbfe1f..749387f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -364,23 +364,12 @@ static void tk_setup_internals(struct timekeeper *tk, struct clocksource *clock)
 }
 
 /* Timekeeper helper functions. */
-
-static inline u64 timekeeping_delta_to_ns(const struct tk_read_base *tkr, u64 delta)
-{
-	u64 nsec;
-
-	nsec = delta * tkr->mult + tkr->xtime_nsec;
-	nsec >>= tkr->shift;
-
-	return nsec;
-}
-
 static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles)
 {
 	/* Calculate the delta since the last update_wall_time() */
 	u64 delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
 
-	return timekeeping_delta_to_ns(tkr, delta);
+	return ((delta * tkr->mult) + tkr->xtime_nsec) >> tkr->shift;
 }
 
 static __always_inline u64 __timekeeping_get_ns(const struct tk_read_base *tkr)


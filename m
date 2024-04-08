Return-Path: <linux-kernel+bounces-135398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C27089C0D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12591F21270
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2947F7E5;
	Mon,  8 Apr 2024 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="25c1YJ+G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h0qfD6k7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C5D7E772;
	Mon,  8 Apr 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581843; cv=none; b=QOeokV3zeBOLneSuDaJqGgQOf1O721mVggZvFpNdaIqzrMTzU4a3K5MNnuKTMg2yWujfiL/Tnrsr6vTunwgpBGrPFk2NnZtbi1YfTO2k8sgrtN9O3ZtcYPYxk9vsYDar2JUqF21tonQ97bLryziZDtcw/ey+R63uhNRjaAi8/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581843; c=relaxed/simple;
	bh=kcdcasg4HaSBEhxHxzwPiNfUiM18+7rnpObeoF5pT7Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EoneXsVS7vSzOnD0dK3Go5+XCsl2DTAZfH8BF920V0/tOP9I61ixafa6X7h65DaM5TtKX55IcJcyQ9lhK/zD3grnR2N2jtbVmzv43Vx5PjHq5tNV1ZA3PhbodGb0gCkxhCKe/WYMU4gUi86nxvJDFFLEMIxeLvHdUMsMOXjseWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=25c1YJ+G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h0qfD6k7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeXPe8gQog6JIW9GW2kibBQc1KRF2vtnIvQehR82aJw=;
	b=25c1YJ+GHLIHZnEC1ABJXEN571ly+P4vb12Ql/dcdowEjz3pBZ7XC4q2OeRGAWkNfvjosv
	V17sIQfdDtTe/H7PjNQqTQoSQAkrF1wuqxkRWPYVS0xVLn5XLepplEW38dvPkIpYk1Ktm9
	g1QcsRkIJa/nGJsR+wZJToSJcgR89tnQTH6052j/6BOiiFq+39yXV4Krp86k+4O8nSzfUp
	aLBVpuPRJ/49InvqckICinek0UY6gxVyYJo1zFTIBPFBtdcgKqtF+gQ8OWbuxShlnYKOD0
	rH+LMMOpHYTERDqKMHEWd2bjUMZzGNXywJV5QL7eW/iIv/18R4WyxBkTo62/gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeXPe8gQog6JIW9GW2kibBQc1KRF2vtnIvQehR82aJw=;
	b=h0qfD6k7v9aAPZNxC2TYoKfRhcYHxqMD3XbgQagHLC1pj5g9wp6CIlq+ZOd2q5QWaSJLq0
	JCIgnoj3/ra0WkDQ==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Move timekeeping helper functions
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-10-adrian.hunter@intel.com>
References: <20240325064023.2997-10-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258183894.10875.8545999016373889170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e98ab3d4159e6bab4e391f376a1e548dd4d32524
Gitweb:        https://git.kernel.org/tip/e98ab3d4159e6bab4e391f376a1e548dd4d32524
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:07 +02:00

timekeeping: Move timekeeping helper functions

Move timekeeping helper functions to prepare for their reuse.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-10-adrian.hunter@intel.com

---
 kernel/time/timekeeping.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b58dffc..3375f0a 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -381,23 +381,31 @@ static inline u64 timekeeping_delta_to_ns(const struct tk_read_base *tkr, u64 de
 	return nsec;
 }
 
-static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
+static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles)
 {
 	u64 delta;
 
-	delta = timekeeping_get_delta(tkr);
+	/* calculate the delta since the last update_wall_time */
+	delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
 	return timekeeping_delta_to_ns(tkr, delta);
 }
 
-static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles)
+static __always_inline u64 fast_tk_get_delta_ns(struct tk_read_base *tkr)
 {
-	u64 delta;
+	u64 delta, cycles = tk_clock_read(tkr);
 
-	/* calculate the delta since the last update_wall_time */
 	delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
 	return timekeeping_delta_to_ns(tkr, delta);
 }
 
+static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
+{
+	u64 delta;
+
+	delta = timekeeping_get_delta(tkr);
+	return timekeeping_delta_to_ns(tkr, delta);
+}
+
 /**
  * update_fast_timekeeper - Update the fast and NMI safe monotonic timekeeper.
  * @tkr: Timekeeping readout base from which we take the update
@@ -431,14 +439,6 @@ static void update_fast_timekeeper(const struct tk_read_base *tkr,
 	memcpy(base + 1, base, sizeof(*base));
 }
 
-static __always_inline u64 fast_tk_get_delta_ns(struct tk_read_base *tkr)
-{
-	u64 delta, cycles = tk_clock_read(tkr);
-
-	delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
-	return timekeeping_delta_to_ns(tkr, delta);
-}
-
 static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
 {
 	struct tk_read_base *tkr;


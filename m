Return-Path: <linux-kernel+bounces-76941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B0885FEE7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEB328B5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CE41586CF;
	Thu, 22 Feb 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WlCOpq6C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1XaUvkyt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690E4156964;
	Thu, 22 Feb 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621934; cv=none; b=hyr0W6hrBomxa5HaISvfV8gTsJ+oJ5t0aROOzzcRq+t7pW9G20Dr5MEju4IbHRcdjSFuRZKT0LMc20ALOT2D4Z3iSd+3UgsygiGt0VNak5j+3G+qLU6KlekwCju2spjGvX06UTPOZhwUF4+2XG39q90dGf+yiGZGHTO5YR0CJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621934; c=relaxed/simple;
	bh=bHo3N8pSGTtL54DC9vq8NLSOtHmWS9A6ALUxMKH889Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E4UwS11JC2Bw1PK6b4HjlcTyIbulstzE6RUCWV9SF18zoVxKwEu4qJWGXw9YZaTN3+pYDTG1uwc9sgKk2dc8Hd3ZIBGsQQ4dVdpq1AEoOLCSO9U/TAOnoeBR3gaErd49UL8VClc/Rd5AZwRlPaOX7prKINqlQtSKm3CIg21MdLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WlCOpq6C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1XaUvkyt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=px5LyAuKJjcfS0HIu2Lf8/m8POQVpLIx1GaMHOluEBw=;
	b=WlCOpq6Ctuivg+Qv4ziy2oyAY31jG6IrHe4pDt+KVJJmRsZOrnGGOvdrd1NT1kzVGiSb54
	gf5S3Ha8qqLK/SjXoVo34snd3ucQQVX4YRltd1HBR2Lr2/YHjTfgwzGtTszX806ECB2Eh5
	+wifWqjlWWetJI1C0TDfHUjNrUL0XChmiJEVu80b/xNhfDZEex9O3WeYcy9vUfyb5PXz6A
	Ewa/V4LZyOYyLXUi3KgqA+y6KPKrXFk8nlp4kFOxqcZ7ia1tjVopu7qOiuXnHP/nyxMAfZ
	MfBmRoZfB9mQTEkyyNSvwwbOj2YqDzRR1BdQZc8qJT3w898zrE31BamrfRkGmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=px5LyAuKJjcfS0HIu2Lf8/m8POQVpLIx1GaMHOluEBw=;
	b=1XaUvkytxREWBr8p3fOqN+ueToh64oE3V+uE1daz60LI87h4CSRZVb3yhuITB205YuhqUN
	n3FBgAHE5fNAD8Cw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timers: Split out "get next timer interrupt" functionality
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-13-anna-maria@linutronix.de>
References: <20240221090548.36600-13-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862192990.398.2951423495692125480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     70b4cf84f3acd9e72c9ea9064d82577b6f29a60b
Gitweb:        https://git.kernel.org/tip/70b4cf84f3acd9e72c9ea9064d82577b6f29a60b
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 21 Feb 2024 10:05:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:31 +01:00

timers: Split out "get next timer interrupt" functionality

The functionality for getting the next timer interrupt in
get_next_timer_interrupt() is split into a separate function
fetch_next_timer_interrupt() to be usable by other call sites.

This is preparatory work for the conversion of the NOHZ timer
placement to a pull at expiry time model. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-13-anna-maria@linutronix.de

---
 kernel/time/timer.c | 64 ++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 38becd2..b10e97c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2033,30 +2033,13 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 	return base->next_expiry;
 }
 
-static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
-					     bool *idle)
+static unsigned long fetch_next_timer_interrupt(unsigned long basej, u64 basem,
+						struct timer_base *base_local,
+						struct timer_base *base_global,
+						struct timer_events *tevt)
 {
-	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
 	unsigned long nextevt, nextevt_local, nextevt_global;
-	struct timer_base *base_local, *base_global;
 	bool local_first;
-	u64 expires;
-
-	/*
-	 * Pretend that there is no timer pending if the cpu is offline.
-	 * Possible pending timers will be migrated later to an active cpu.
-	 */
-	if (cpu_is_offline(smp_processor_id())) {
-		if (idle)
-			*idle = true;
-		return tevt.local;
-	}
-
-	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
-	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
-
-	raw_spin_lock(&base_local->lock);
-	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
 
 	nextevt_local = next_timer_interrupt(base_local, basej);
 	nextevt_global = next_timer_interrupt(base_global, basej);
@@ -2074,8 +2057,8 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
-		tevt.local = basem + (u64)(nextevt - basej) * TICK_NSEC;
-		goto forward;
+		tevt->local = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		return nextevt;
 	}
 
 	/*
@@ -2085,12 +2068,41 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	 * ignored. If the global queue is empty, nothing to do either.
 	 */
 	if (!local_first && base_global->timers_pending)
-		tevt.global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
+		tevt->global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
 
 	if (base_local->timers_pending)
-		tevt.local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+		tevt->local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+
+	return nextevt;
+}
+
+static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
+					     bool *idle)
+{
+	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
+	struct timer_base *base_local, *base_global;
+	unsigned long nextevt;
+	u64 expires;
+
+	/*
+	 * Pretend that there is no timer pending if the cpu is offline.
+	 * Possible pending timers will be migrated later to an active cpu.
+	 */
+	if (cpu_is_offline(smp_processor_id())) {
+		if (idle)
+			*idle = true;
+		return tevt.local;
+	}
+
+	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
+	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
+
+	raw_spin_lock(&base_local->lock);
+	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
+
+	nextevt = fetch_next_timer_interrupt(basej, basem, base_local,
+					     base_global, &tevt);
 
-forward:
 	/*
 	 * We have a fresh next event. Check whether we can forward the
 	 * base.


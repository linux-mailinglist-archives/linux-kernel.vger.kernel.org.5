Return-Path: <linux-kernel+bounces-74361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076DE85D315
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842F1B24785
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF9F405E8;
	Wed, 21 Feb 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZKiwyV2z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eIB2QWWz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65903E468
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506382; cv=none; b=GmSCiox3g8nc0OnBrYNi6sOBNHb5WoH0oo8CZ96D1EIUsZhn096hCJW3Ia3sGVcW+iUDjWaMRvZLVY3LveI5MvG2j50vS78DBQUYfFpPl0rgFolcxYGGfB0Qk4RMU8SbZpRNJTaiYFBUIsldQV7CyKgR9fnbBcbY7fW7PXSecYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506382; c=relaxed/simple;
	bh=Ud9pgOn2B/0m50aOpIF31SSVvpgQRaOUxbGunhq51UI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGMoyrZOuJddnwOWCFilyaEROf5iqNNiGYFJmp2bbBiR9uf85kj42iynxSLRBQyxYOxUnC5+0vs0C0CGsIo1A7cqyrj5bBEtQnBZtBNtmCipXK2BiDdhExlyWLavWp1oYaY1A6/Usa58EjaYtoq1qtscYbuwvPPBchhI86nyFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZKiwyV2z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eIB2QWWz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84mTYhbxH69oUoy6SwRp7poh6N58HyKxHp1SCrdM7O4=;
	b=ZKiwyV2zkZ+h+SdEAzRyGq5O9LN9CHu1eeIzWsHowWJu6xsGLtpPL44lQ4YBsCFe8D8cwy
	zrenZpCWFkeb9u4ZxmK2v+tJNJ9J2qmrOY5jyCHgWcf8zBZGh+nsPVcERkERUy+TWpWT/m
	YQruHpAStbSFmkVs8rkOd3Rs7KQF6LOSmpubfL2ukplL/lVvaKcd8HoceXpy3Pujk9nKcC
	udmHmsSrpVB7uNBPmNXUEk/W9YoiMguuEdhDkPXqC8Q2R4NoARbheI7LEQC5179OikwtqY
	RWWy6jTQuiqsmpNFvQBxkB3NJA4KOyhSXnWIVgvYwQM2LfjyhiKaVPvBBQkIZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84mTYhbxH69oUoy6SwRp7poh6N58HyKxHp1SCrdM7O4=;
	b=eIB2QWWzcZQPTgaK4YkWqHopYbdU70bbtzBJsBK1v6l+WFLnw8dlk2GujZTaEKWDnqOHqp
	RC7nGW6K89ngf5AQ==
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v11 15/20] timers: Check if timers base is handled already
Date: Wed, 21 Feb 2024 10:05:43 +0100
Message-Id: <20240221090548.36600-16-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the conversion of the NOHZ timer placement to a pull at expiry
time model, the per CPU timer bases with non pinned timers are no
longer handled only by the local CPU. In case a remote CPU already
expires the non pinned timers base of the local CPU, nothing more
needs to be done by the local CPU. A check at the begin of the expire
timers routine is required, because timer base lock is dropped before
executing the timer callback function.

This is a preparatory work, but has no functional impact right now.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v10: s/cpu/CPU/ in commit message

v6: Drop double negation
---
 kernel/time/timer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 52af50d00ae6..7b9f9ed25fc2 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2240,6 +2240,9 @@ static inline void __run_timers(struct timer_base *base)
 
 	lockdep_assert_held(&base->lock);
 
+	if (base->running_timer)
+		return;
+
 	while (time_after_eq(jiffies, base->clk) &&
 	       time_after_eq(jiffies, base->next_expiry)) {
 		levels = collect_expired_timers(base, heads);
-- 
2.39.2



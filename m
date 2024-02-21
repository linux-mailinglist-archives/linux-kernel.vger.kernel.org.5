Return-Path: <linux-kernel+bounces-74347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3C385D306
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568A51C223EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC423D386;
	Wed, 21 Feb 2024 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bW6c6uDK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NS4V0cz9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A58F3CF7C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506377; cv=none; b=JABC1poGEa3Mj0h6IWjHvYtQUDWUFsmwMTL/QKkQ8Z62gsCycSGQLFkbp4Y+YCG+zw0krU2IdASj8Q4AIxOZ6M3JW/O4LUaeh5miZd4JhcuacrXUOd7l7h8e+J9imP30sFKClF0YBd17c7Bo/lnNfLesgFJx4t0b8yQvW2x/NcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506377; c=relaxed/simple;
	bh=cx7W79/0JOWapdXA61gJNfkyrPTg/Tmal7MREy72obs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hJtnK4S2PnqIMip9I5ZLMDkFjzkV2SRMwJtojivOexWGcvxMAS5VXtnxiunVEJQJ+gLzpn+ApnHvF/0wQ/6TgX8s5ljpdAaBImRBjkxWxRjn4KMc2sWX56N1lLw5sA0gSA2UDKjavxkFmco73QKZM009xJBde7/iEcWbgDPrZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bW6c6uDK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NS4V0cz9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnbOpzCKzJr8GVlvDiuyFIftQ7kDyRb60zxIswiDeKE=;
	b=bW6c6uDKTlx+T/vPLW1QjAk5/ewWlAA3hBGqgC9UyIcgRmbVKwt8YMB1ME9UbPI1X+adBZ
	bpZNeGpLBPsv8hISm32Ex5iKN1Us0mBVRcPt/s0dx9I2FAF2sRKwfWdnHTKadaJu2Sq9MQ
	NU8svm0LqSj+jtzDp3/Nr5a9zdBYsuQ9JqvFk/98VfqLWmOAelKS1Cylt8SQP01uAHuRhy
	6le2M5D/nGeoo9tZltDBWE/OOfxfFEx6DR+/RPUKhgEjiSrGqt7PVbJRyxnd/AYwXTTZYG
	DmYgq/08QwA3BlV9qooRhwlLTMai0bsDEgRUf8BPorQNXpO8wWzuLkFsgc+7nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnbOpzCKzJr8GVlvDiuyFIftQ7kDyRb60zxIswiDeKE=;
	b=NS4V0cz9P1b+jOQ8gLhCmi/ndTdsC5DQxDsMA7Yt/YaXthsygD5Ayo469VqNwBqmfIiZTO
	j4SdOyTl0bcTMUAQ==
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
Subject: [PATCH v11 02/20] timers: Split out get next timer interrupt
Date: Wed, 21 Feb 2024 10:05:30 +0100
Message-Id: <20240221090548.36600-3-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split out get_next_timer_interrupt() to be able to extend it and make it
reusable for other call sites.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 5f21db4fa3ca..2aea55d53416 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1911,15 +1911,7 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
-/**
- * get_next_timer_interrupt - return the time (clock mono) of the next timer
- * @basej:	base time jiffies
- * @basem:	base time clock monotonic
- *
- * Returns the tick aligned clock monotonic time of the next pending
- * timer or KTIME_MAX if no timer is pending.
- */
-u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
+static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 	unsigned long nextevt = basej + NEXT_TIMER_MAX_DELTA;
@@ -1978,6 +1970,19 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	return cmp_next_hrtimer_event(basem, expires);
 }
 
+/**
+ * get_next_timer_interrupt() - return the time (clock mono) of the next timer
+ * @basej:	base time jiffies
+ * @basem:	base time clock monotonic
+ *
+ * Returns the tick aligned clock monotonic time of the next pending
+ * timer or KTIME_MAX if no timer is pending.
+ */
+u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
+{
+	return __get_next_timer_interrupt(basej, basem);
+}
+
 /**
  * timer_clear_idle - Clear the idle state of the timer base
  *
-- 
2.39.2



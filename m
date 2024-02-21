Return-Path: <linux-kernel+bounces-74360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6579385D316
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 079A0B22AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD5D405F8;
	Wed, 21 Feb 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QJvHFeIS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yvbnrV+A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67883E46D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506382; cv=none; b=knk0ZleVpAQeT//aenlplHpnkm1npuEpkyFowJbHl5Eq6hc3gm5i3IStEbCkLbzTnmq1DVQgYebuWgiPzHuMy/H6x+bdjJ5xoEDLN8kRC/NMeG4BbwtuW7eZ2h+bsxQgy84gPki/D49NC+nUAXH7YjBMoggsIFI7SHY2oQibpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506382; c=relaxed/simple;
	bh=9uucUzWlPsh+XllbURepFkpBIfJjjTcmG/VWFvI4CmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2cfufiTcKCGIyv4D05M0Qt4DKZAWWmIneTCa2J7DphNIFW1M0QW/8pLAY8HUVniJjTREtZLJdg/LhwbwUa29bEk6Td2Y8b9qfIYrYvdmPc/pyBCuQg7mMT17KstTrqCb8M7T6VLWlJXogDiXzDom2auSuyxIglm4Nzyt0BKvgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QJvHFeIS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yvbnrV+A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=be6MfeAvNPKcsJz3AUGh7ZqxvewZ3xXmvk3rMk/0KI0=;
	b=QJvHFeISZgLzbY1jZ3y0IhU8jkZ+0LhZmq+s7G4/AOekOCTZi1/wjN22VXOsJNliK6tuLm
	0wHvb3iSi339wRsPYOJ3gzW2Ebd6qSQFXmkKmWDD6ckd41Lo9PeVnE4pvjvpLieNA1oYfp
	dR5EEpvbQ0FYE3yoBodOAbO8XErwmdtGdHxEAahYx1YbTyE4XTRB3ZbRe9y/6xfZ3ph4yk
	mbrJbtm5OtB61r5TEVW1aODJmxdotz6lFUmxcAKI/B8MqEPnNqdJ/BugG2N92tluwCVHsU
	aeOvtjEmcu1Aaqd77R7EDvSQzyUbSzo2xK1UMe+rukjN21sRO0simJzyGOmpDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=be6MfeAvNPKcsJz3AUGh7ZqxvewZ3xXmvk3rMk/0KI0=;
	b=yvbnrV+AKWKKUEos8S13cg3G2cgGT4GYWmL6cQXXFWozXgPfEEyUq/AeL0nBSa8rZjfz/H
	PGGS/MoyPAq9hOCA==
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
	"Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v11 16/20] tick/sched: Split out jiffies update helper function
Date: Wed, 21 Feb 2024 10:05:44 +0100
Message-Id: <20240221090548.36600-17-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>

The logic to get the time of the last jiffies update will be needed by
the timer pull model as well.

Move the code into a global function in anticipation of the new caller.

No functional change.

Signed-off-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-internal.h |  1 +
 kernel/time/tick-sched.c    | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 8b0c28edbd09..ccf39befde85 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -157,6 +157,7 @@ static inline void tick_nohz_init(void) { }
 #ifdef CONFIG_NO_HZ_COMMON
 extern unsigned long tick_nohz_active;
 extern void timers_update_nohz(void);
+extern u64 get_jiffies_update(unsigned long *basej);
 # ifdef CONFIG_SMP
 extern struct static_key_false timers_migration_enabled;
 extern void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 384723314c1f..c4d80d73bcfb 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -799,18 +799,30 @@ static inline bool local_timer_softirq_pending(void)
 	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
 }
 
-static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
+/*
+ * Read jiffies and the time when jiffies were updated last
+ */
+u64 get_jiffies_update(unsigned long *basej)
 {
-	u64 basemono, next_tick, delta, expires;
 	unsigned long basejiff;
 	unsigned int seq;
+	u64 basemono;
 
-	/* Read jiffies and the time when jiffies were updated last */
 	do {
 		seq = read_seqcount_begin(&jiffies_seq);
 		basemono = last_jiffies_update;
 		basejiff = jiffies;
 	} while (read_seqcount_retry(&jiffies_seq, seq));
+	*basej = basejiff;
+	return basemono;
+}
+
+static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
+{
+	u64 basemono, next_tick, delta, expires;
+	unsigned long basejiff;
+
+	basemono = get_jiffies_update(&basejiff);
 	ts->last_jiffies = basejiff;
 	ts->timer_expires_base = basemono;
 
-- 
2.39.2



Return-Path: <linux-kernel+bounces-74349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82D885D309
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4883EB213F7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10E73D561;
	Wed, 21 Feb 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hx8+Knr8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tf7n+Sll"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D68D3D0B4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506378; cv=none; b=MWgKu9LMEJHDy6uRQxViUyLk7zV59o+EpAJxujkbQ0yL8Tiw+liT7MSGT3jbzTR0BeOPW+hjoPr/ybLtjKZ/uz5SGoHibore1PqBxnYb341eA+WpaSoLv7rWQn/LEMA4Zm/4D349nKrLQoDjHd0lzRioqN+XZkjzOzN07o2ubZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506378; c=relaxed/simple;
	bh=ws4UsvqTVPEJwlRcuRRnPZASwZHWSXxgj2cFVwZJl0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VuhR7wKrB2ogeC8svnWDZA969Ac2KTroZ9zaZxUSqhD/zPTgReGocAlYgXsB2FPfvRyMyOKjN3YyYLWNJyRGrCjqI509gY6Np/VOOhsZt5Iq9ReenyFPbEDEA677Kzc3GLDKLcfy/aG2YgTShYpR82yoMmmIE+0PVr3D01Lb1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hx8+Knr8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tf7n+Sll; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8x8V66oedAQdLiHPaHBR+VdwFWZt1XkVYVwYivWxpoM=;
	b=Hx8+Knr8Z4dJ4chBC2NafZksHEPbKTCpR5IGhR5LRCe/JaVTRP1EVRAFVm/VJOl7MBivfe
	CPlw95EYEMRha70OszFXL+AVP8hFXZvntTYUYhybEgjSL5i3kmhQp7jFVcIZXwns/6tYGk
	q41Akso+7a0DWowVMQ3bmFU9ahEdtwN0UzW39j5mrSGuZrYeWnqnaMPlbWS3/e5rMXTftv
	vUPeQ9XL5zaV5IPOK+3s4AZJH2yqCvgWtbAoJ8ZbUQf2ROC3DW22hZe2oqukjmo/F3ggA6
	Tncb3XnmNgp98CMmz3BrCv7Q9FsIO9MNd7eAnYKhhIOGIRlWbnXmRRiLeltMkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8x8V66oedAQdLiHPaHBR+VdwFWZt1XkVYVwYivWxpoM=;
	b=tf7n+SllvBHbEQu6a0UoCrngxBM8lQ8i8OnvMAJYCfZztbbKhMtwZZwKcgArYXicK4Ufuj
	Q4BGYcmQOmDy/TAw==
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
Subject: [PATCH v11 04/20] timers: Optimization for timer_base_try_to_set_idle()
Date: Wed, 21 Feb 2024 10:05:32 +0100
Message-Id: <20240221090548.36600-5-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tick is stopped also the timer base is_idle flag is set. When
reentering the timer_base_try_to_set_idle() with the tick stopped, there is
no need to check whether the timer base needs to be set idle again. When a
timer was enqueued in the meantime, this is already handled by the
tick_nohz_next_event() call which was executed before
tick_nohz_stop_tick().

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c |  2 +-
 kernel/time/timer.c      | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 72c80f6e7bed..384723314c1f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -886,7 +886,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	unsigned long basejiff = ts->last_jiffies;
 	u64 basemono = ts->timer_expires_base;
-	bool timer_idle;
+	bool timer_idle = ts->tick_stopped;
 	u64 expires;
 
 	/* Make sure we won't be trying to stop it twice in a row. */
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 3a668060692e..2f69a485a070 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1999,13 +1999,18 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
  * timer_base_try_to_set_idle() - Try to set the idle state of the timer bases
  * @basej:	base time jiffies
  * @basem:	base time clock monotonic
- * @idle:	pointer to store the value of timer_base->is_idle
+ * @idle:	pointer to store the value of timer_base->is_idle on return;
+ *		*idle contains the information whether tick was already stopped
  *
- * Returns the tick aligned clock monotonic time of the next pending
- * timer or KTIME_MAX if no timer is pending.
+ * Returns the tick aligned clock monotonic time of the next pending timer or
+ * KTIME_MAX if no timer is pending. When tick was already stopped KTIME_MAX is
+ * returned as well.
  */
 u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle)
 {
+	if (*idle)
+		return KTIME_MAX;
+
 	return __get_next_timer_interrupt(basej, basem, idle);
 }
 
-- 
2.39.2



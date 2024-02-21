Return-Path: <linux-kernel+bounces-74352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26FD85D30D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35E0AB213B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7713EA80;
	Wed, 21 Feb 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N+iH1EA+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s9SUakEH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689143D547
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506380; cv=none; b=Z2F4luefy8t3l8If0tenMcCrA1X54ewKs7/AKFmFWiaJTvzytCn9lb8nucOGA9Jt2NzXeG9PDtI9vIXOVST3Uflm8jm8fSDL76cIcK5odCcqyzFdWb4WzB9PpGb7MJOdjQbq8OWgzT+VcBX9FKZmiT3UKf+TA8HGI9p7pY0KkEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506380; c=relaxed/simple;
	bh=V1CbKsW0rcYBYg8RiJijs3cSGDAOjzbv3oQTZO9JY7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NNQwv1mLzutSYh+uwH7KVym7ryAM8vEXn/+AOIl9lWsSOi0vqUMkY4sXInJ8WsfrvunGzIlhBcoBSkVtzBeKlarGaQFcuknqDjTkKmyhTgssEiNfRKJUlNP/iJSgMY2AXQZo7ixVNnAXKw6uAR6dNIS+92Q93YE/ARKloXCU8jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N+iH1EA+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s9SUakEH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSKskFBA3hNZnL8AqDErkBhwO140lD1i26cDtauIZEw=;
	b=N+iH1EA+Q9CrW9USEa9Lre+aORR0RMKuhVcaHRNSEUiOMsemgtGOAfodGmv1rzBpTfvXgT
	6qusX02SD9UMY2rZ4g0bQ3pcedlUjJWAnrF3XB5osCHnOGtkn6CCIPRW782IZdOLbLlhWm
	eqNfp/mmcACeg3FPdt8VAa8ODhXhyJn4ZEgfnp2m/9mSL7d308dYaUbjcT1RngK13Kkv0G
	uVtf7UE0TBCL+w+xHSwF0LqPo7Zrn/QRuTMR3oML7qUAKvksGJfLUc9vkG9piZgMhAQeaN
	s3J9JlGdO8sA1S0dFEh8nSSVVGOGykitdu/jsMkV0IKd/RLJa95EzQyOgS1EJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSKskFBA3hNZnL8AqDErkBhwO140lD1i26cDtauIZEw=;
	b=s9SUakEHFB8KfG5IVhDcJfSAriaMylPMWg2po4rwWWAUBOw3GaG0+PNTrQjlt9gOeIdBKO
	pi8ytFiJk4eY3VBw==
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
Subject: [PATCH v11 07/20] timers: add_timer_on(): Make sure TIMER_PINNED flag is set
Date: Wed, 21 Feb 2024 10:05:35 +0100
Message-Id: <20240221090548.36600-8-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding a timer to the timer wheel using add_timer_on(), it is an
implicitly pinned timer. With the timer pull at expiry time model in place,
TIMER_PINNED flag is required to make sure timers end up in proper base.

Add TIMER_PINNED flag unconditionally when add_timer_on() is executed.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 3cf016d6fa59..fc4c406c9ec7 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1284,7 +1284,10 @@ EXPORT_SYMBOL(add_timer_global);
  * @timer:	The timer to be started
  * @cpu:	The CPU to start it on
  *
- * Same as add_timer() except that it starts the timer on the given CPU.
+ * Same as add_timer() except that it starts the timer on the given CPU and
+ * the TIMER_PINNED flag is set. When timer shouldn't be a pinned timer in
+ * the next round, add_timer_global() should be used instead as it unsets
+ * the TIMER_PINNED flag.
  *
  * See add_timer() for further details.
  */
@@ -1298,6 +1301,9 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	if (WARN_ON_ONCE(timer_pending(timer)))
 		return;
 
+	/* Make sure timer flags have TIMER_PINNED flag set */
+	timer->flags |= TIMER_PINNED;
+
 	new_base = get_timer_cpu_base(timer->flags, cpu);
 
 	/*
-- 
2.39.2



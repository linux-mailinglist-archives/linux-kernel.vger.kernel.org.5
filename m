Return-Path: <linux-kernel+bounces-76947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7885FEF4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F7228B578
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2BE15958C;
	Thu, 22 Feb 2024 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e4RWX3wf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wq3LoQ+J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40447154437;
	Thu, 22 Feb 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621939; cv=none; b=jLkwg5uMQQFFTvTs+FLY6KU7mQQF7/tw2eltam2VdDaHxx95/dTjGDZOtm4e0L1KTOIrUxqAJTY0e39aOU6648thcIBANBjUiPvj9yoOHU/eIuSGxeyS13xwGX0kLN3BP5PaGSF0Map/AlvmyUmQGoqezIiLbn/szwaDLBJkids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621939; c=relaxed/simple;
	bh=KyObLGDK1YnMUXhpsfB4N2YAemwv6qOfMW2eFfWrzTA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EukPEFQ6HZRUydlrqVwdz0LaJBPoSyb+dhid5XRYEvsMOTvsB0gwTzGLC9Pv+tIzZZp2WYXef1EpnPTYpcTHB+dQinr6RPygpGqpkuGiCYjTSIJsJ3+BTmDtD4/YpUa9GPKFL+847UUmzHNqPsC0GOtMjfu0ZK0lF7gkOOHU7Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e4RWX3wf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wq3LoQ+J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RK0qYO9+yNFcwFD0u5TmenVmJgzi25sDpsK8zBYC7g=;
	b=e4RWX3wff2Inaxj2eVwC+XL0hUbXjJberl0i9k8jBV0rtK2PfWceX8FwpyjKio7NPOaQh9
	AcQpchFKS3+COtSzrdGVlJw/2Vl5kzz182Ahac7MtRmuOPSXEBP6xLMxv0YqrM3Q9BImXQ
	ojIhXbXbDYxWHRZjd00Xcl4ipC3Kd/s6QlQn3jI7rEnu6tWQTaO3+50+Q2On4rwyXv1YX8
	xqQG5xCpUOCLsa/RWcbYbfH2Tk7ubDHizRwKR0Fa479nMg7ug0iu7Hky5TX7X6jra7Fbir
	uKvdnJfxsVO1BJ0By77YX1JFVbu++lVhUPqrGVkm6zh1yCbCFNjFGnoQge7epA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RK0qYO9+yNFcwFD0u5TmenVmJgzi25sDpsK8zBYC7g=;
	b=wq3LoQ+JDDfmhZuomUmbJWpOSdh2z0Z/aKVB/ykdbnvMVb1xSSs+NbZHWn3b0sL28ndUcS
	rLw29nFqFiMjv4CA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Introduce add_timer() variants which
 modify timer flags
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-6-anna-maria@linutronix.de>
References: <20240221090548.36600-6-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862193464.398.9124526357138582797.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8e7e247f64a1e0fee430aba28d9108f7598eb237
Gitweb:        https://git.kernel.org/tip/8e7e247f64a1e0fee430aba28d9108f7598eb237
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 21 Feb 2024 10:05:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:30 +01:00

timers: Introduce add_timer() variants which modify timer flags

A timer might be used as a pinned timer (using add_timer_on()) and later on
as non-pinned timer using add_timer(). When the "NOHZ timer pull at expiry
model" is in place, the TIMER_PINNED flag is required to be used whenever a
timer needs to expire on a dedicated CPU. Otherwise the flag must not be
set if expiration on a dedicated CPU is not required.

add_timer_on()'s behavior will be changed during the preparation patches
for the "NOHZ timer pull at expiry model" to unconditionally set the
TIMER_PINNED flag. To be able to clear/ set the flag when queueing a
timer, two variants of add_timer() are introduced.

This is a preparatory step and has no functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-6-anna-maria@linutronix.de

---
 include/linux/timer.h |  2 ++
 kernel/time/timer.c   | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index f18a2f1..2be8be6 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -165,6 +165,8 @@ extern int timer_reduce(struct timer_list *timer, unsigned long expires);
 #define NEXT_TIMER_MAX_DELTA	((1UL << 30) - 1)
 
 extern void add_timer(struct timer_list *timer);
+extern void add_timer_local(struct timer_list *timer);
+extern void add_timer_global(struct timer_list *timer);
 
 extern int try_to_del_timer_sync(struct timer_list *timer);
 extern int timer_delete_sync(struct timer_list *timer);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 74cfe21..bef8cb8 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1291,6 +1291,40 @@ void add_timer(struct timer_list *timer)
 EXPORT_SYMBOL(add_timer);
 
 /**
+ * add_timer_local() - Start a timer on the local CPU
+ * @timer:	The timer to be started
+ *
+ * Same as add_timer() except that the timer flag TIMER_PINNED is set.
+ *
+ * See add_timer() for further details.
+ */
+void add_timer_local(struct timer_list *timer)
+{
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
+	timer->flags |= TIMER_PINNED;
+	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
+}
+EXPORT_SYMBOL(add_timer_local);
+
+/**
+ * add_timer_global() - Start a timer without TIMER_PINNED flag set
+ * @timer:	The timer to be started
+ *
+ * Same as add_timer() except that the timer flag TIMER_PINNED is unset.
+ *
+ * See add_timer() for further details.
+ */
+void add_timer_global(struct timer_list *timer)
+{
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
+	timer->flags &= ~TIMER_PINNED;
+	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
+}
+EXPORT_SYMBOL(add_timer_global);
+
+/**
  * add_timer_on - Start a timer on a particular CPU
  * @timer:	The timer to be started
  * @cpu:	The CPU to start it on


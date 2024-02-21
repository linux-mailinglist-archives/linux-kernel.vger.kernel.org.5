Return-Path: <linux-kernel+bounces-74351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCAF85D30B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949351F21BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9883DBBA;
	Wed, 21 Feb 2024 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cxbjYNYY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sc1xvsMr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D870E3D3A0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506379; cv=none; b=A3EJSyW5mC/USX1/Mv3EFRiJSFP61jjgLOSN8FsASmSCosgiB1FvuPSTcJ/JJYTnVslMlc8gCJ2UReF6lDX8i9wEaLo+Qtu35yob7Iy5rAKBMtyhNFciEHOtJ7+bwnjmrCRllPZU5kOR1kGUYHR+myO5AU5vIFqV6hKh5xkb5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506379; c=relaxed/simple;
	bh=fAB5xEIJhUT2xY7i5T7pqKYPBAt3GNmgTzm/jf5bOqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nPloMWIQcl+0i6pcCp1uSmpLkoV+3m1wRxuK9rgkEQDlSBe0BQxPoArVQBJL0Cc4LHRypgsVEtRASp9kfLJFru9/NFEM22cxoj6f0Ajui/aL9UumljXwUsC4FrbE3bD1ky7XzfHq4YQvHs2MwnAFWgIiQf9xPgj4EJkK0kqqIcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cxbjYNYY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sc1xvsMr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QisrBEswo4w1Tqs9XJzYOTpU4VJaqEco1Cayy0t85z0=;
	b=cxbjYNYYvJE7nTIXnHt66nKWJdXP5gSGl1ZHzbW7WkQraHBGShczZFlaWC8cCHv0Nlal1u
	Fgamecy9zmNMhW2C0uGmgDvM69iP/PZMvYe2bvDUdZ08ArHoNyjsPaehvmFa/0QBvxF6iS
	xOUURNmNr2dh+yA2+0/MaUVZKJltKwceAY4+JdI1yCxjeo16RZRhbE9tH7KIV/PCW2YvZx
	sFQoYjOCGp/mMBCgUTlccfwSKqlvkWxIyO6PRn0Ic7SDK26DnHSkLJD2EXet6/LPX7QUZ7
	riN0pjbWCiDzxPCOwMrkoQwFfaCn+onpcsvvD4zfpZdl997LzAQlqnAU5HHBXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QisrBEswo4w1Tqs9XJzYOTpU4VJaqEco1Cayy0t85z0=;
	b=Sc1xvsMrcCn5y3enYMmEDN21px5+dzmS0F3umaqNg/3PyQcflgyKmwhjWEo13yzGEfeU1K
	lFRuIkDk5XebubDQ==
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
Subject: [PATCH v11 05/20] timers: Introduce add_timer() variants which modify timer flags
Date: Wed, 21 Feb 2024 10:05:33 +0100
Message-Id: <20240221090548.36600-6-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A timer might be used as a pinned timer (using add_timer_on()) and later on
as non-pinned timer using add_timer(). When the "NOHZ timer pull at expiry
model" is in place, the TIMER_PINNED flag is required to be used whenever a
timer needs to expire on a dedicated CPU. Otherwise the flag must not be
set if expiration on a dedicated CPU is not required.

add_timer_on()'s behavior will be changed during the preparation patches
for the "NOHZ timer pull at expiry model" to unconditionally set
TIMER_PINNED flag. To be able to clear/ set the flag when queueing a
timer, two variants of add_timer() are introduced.

This is a preparatory patch and has no functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v10: Commit message reworded as suggested by bigeasy

v9: Update documentation to match kernel-doc style (missing brackets after
    function names)

New in v6
---
 include/linux/timer.h |  2 ++
 kernel/time/timer.c   | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index f18a2f1eb79e..2be8be6dd317 100644
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
index 2f69a485a070..3cf016d6fa59 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1245,6 +1245,40 @@ void add_timer(struct timer_list *timer)
 }
 EXPORT_SYMBOL(add_timer);
 
+/**
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
 /**
  * add_timer_on - Start a timer on a particular CPU
  * @timer:	The timer to be started
-- 
2.39.2



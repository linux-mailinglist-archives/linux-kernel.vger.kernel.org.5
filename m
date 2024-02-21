Return-Path: <linux-kernel+bounces-74362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6A285D317
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05458284E38
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454144122D;
	Wed, 21 Feb 2024 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hLXk0gF4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BCTijobW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBAB3C6AC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506383; cv=none; b=Etz5KuowYNPEvRanB598RN4rrn8zywTeWdcvlboy0dAsx3CecT9ddIzil4Aq/YmDjeek5I2RMp9QqLpWUQDAo80aYkp0XFQzN4axZptAbPYU+W2PZ9W6mkLLzrbNWa9JlW5pSEmoIimCRacSYLeR3ZTJIPhKlNjPvUxtgbLto/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506383; c=relaxed/simple;
	bh=mYpTTHDiPnAjk6i2Zz3Vido8E6MS2R/eipR3R6cwMmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qzeyLj0pDFsw6Qc/1E37gkfC0WiUvynxA5ZgLrHH2XDqiDqhBQ4V9Rv4m6ycjYce9FFx8rDb/o2UDZ0moS8nq27ac3pUcc6uota0Nit5meLgLT/BYJmeOFQ0OMAN3Ts6YtfUznPRmXuafKk8GB3ONZa79sW4FIxzBZZkrTDSDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hLXk0gF4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BCTijobW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEgEniDt+i600hdl6sVMoPHqdN5DurBPCgTXgC6Hb5c=;
	b=hLXk0gF4IuRTJS+9uUgPogjJFyNzDfUNvkSKriQpARBOh30P8VO2ouGuBfxZ/JiWw0wxi6
	Dvoaz2podQ57TjNf2qCsDxrKWF2BMBXaOg7GCIPHJYND2vZFnXV4wujD0zyYmk0qiCnYdq
	0E2Q7fvHZC9YetINuOoVpCc2CSIU0/RShJ3NN48SBvEooM4KD9rxxRnWnRYqVSkqlQYvdu
	tKTKuFdQTJcAKxgOO9z3YX4Do7Sxj8abAUnqzV8eh8M4FMIa95fZNRdACCtAZKmjLCeu5+
	p3M9wt2nGcTqq67jKezzF/V3v2Y7fKMsz+hsZrLOo0gc8ovOMjTaZmAK7JrLTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEgEniDt+i600hdl6sVMoPHqdN5DurBPCgTXgC6Hb5c=;
	b=BCTijobWit1AkWSXjv1qMwGTLE5QKTde/y5krj2WFmv1C2QMSXVoBAb3C3CxnXEmNbrXiS
	Xl5ghdy5RHvYZHAQ==
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
Subject: [PATCH v11 17/20] timers: Introduce function to check timer base is_idle flag
Date: Wed, 21 Feb 2024 10:05:45 +0100
Message-Id: <20240221090548.36600-18-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for the conversion of the NOHZ timer placement to a pull at
expiry time model it's required to have a function that returns the value
of the is_idle flag of the timer base to keep the hierarchy states during
online in sync with timer base state.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v10: Fix fallout of 0day: Move function definition of timer_base_is_idle()
     into SMP && NO_HZ_COMMON ifdef section

v9: new in v9
---
 kernel/time/tick-internal.h |  1 +
 kernel/time/timer.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index ccf39befde85..7e3090109e33 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -165,6 +165,7 @@ extern void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
 					      unsigned int cpu);
 extern void timer_lock_remote_bases(unsigned int cpu);
 extern void timer_unlock_remote_bases(unsigned int cpu);
+extern bool timer_base_is_idle(void);
 # endif
 #else /* CONFIG_NO_HZ_COMMON */
 static inline void timers_update_nohz(void) { }
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 7b9f9ed25fc2..3f618ee39763 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2114,6 +2114,16 @@ void timer_lock_remote_bases(unsigned int cpu)
 	raw_spin_lock(&base_local->lock);
 	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
 }
+
+/**
+ * timer_base_is_idle() - Return whether timer base is set idle
+ *
+ * Returns value of local timer base is_idle value.
+ */
+bool timer_base_is_idle(void)
+{
+	return __this_cpu_read(timer_bases[BASE_LOCAL].is_idle);
+}
 # endif /* CONFIG_SMP */
 
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
-- 
2.39.2



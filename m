Return-Path: <linux-kernel+bounces-166975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F158BA288
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC93B24F03
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC7C205E33;
	Thu,  2 May 2024 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="McMfiB04";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AlqHHyq0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97EC1C9EA4
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685937; cv=none; b=B+JTCZd+sQgMfWaycxo64+D1J7NllGKWYUIf41VkfNAFeCchZZGOWRZSDJzOzbgDX/NJ11IztYj1tn+HP9S5BLw5lYjk9EbIAURQeGzwx4wndkVcbw9A/V0k6MnqiXXQbIzoo/6aJugl/E4sVPB+Kajv/MIgRIcEaPD1pr6yA/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685937; c=relaxed/simple;
	bh=aFuXsM0PQjxnhe9BJyWGcDKlPrKO7Y8pNeIWcZD7jCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oOuRFUp9m2WvZSDcYayLTxEaVIsOWSXStlYFT1UScbpkVZFf1duTQpCNbLoAhRHJ9itqz0UUQQUGS3UDD08fXPTLzE84yMGeQ/PBpgzeTwBp/ZdOQ5ZhMkUd8TGnOf0i7uuLl/rjXa9zDY/TE6x4LMj8xTz7SsunzB9hy/hQ0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=McMfiB04; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AlqHHyq0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6sRFHbv8z6woNAyIM/Oyrbcgnr8C2ODc2QwVRv1j5w=;
	b=McMfiB04rn24IsAutxYT1GsJAzE3mzo3MXpqVQ85WBPXUaOAs9xiJmaq1cYu5CYOovtp0e
	7QmBZRLuM7k+ZHDsXhmdQf8yak3u/U4rs7zsvri7FwN00GjUuoETe+uFA4fuQ4zPu6YBMd
	7JrQx8d8wCUjWQpoyd7f7WYLGHudroR514Sxcfr+wvjnlA0LmzqGXpmJvVJOLlSteS1N8k
	f8aOi0pTKlBpHsCyA9HRfYiMoeqExMDDrWcoKRX1pM/fgNt6CgUCDk/RIrgmtEuVBT+Emy
	r8YnML6r+Iwf79KSAPZ3aIqs678NaEmhyRPKP2YMFlRraTFvDXA01JL42g6KWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6sRFHbv8z6woNAyIM/Oyrbcgnr8C2ODc2QwVRv1j5w=;
	b=AlqHHyq0TxBaYm71rt5dUQMlms4BRaHq6uqSG6hVzQ78vp/3ONJoVwZ2nV7AMDM+YwtVIg
	rOYaOeTe9CHGHJCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 23/30] printk: Avoid console_lock dance if no legacy or boot consoles
Date: Thu,  2 May 2024 23:44:32 +0206
Message-Id: <20240502213839.376636-24-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the console lock is used to attempt legacy-type
printing even if there are no legacy or boot consoles registered.
If no such consoles are registered, the console lock does not
need to be taken.

Add tracking of legacy console registration and use it with
boot console tracking to avoid unnecessary code paths, i.e.
do not use the console lock if there are no boot consoles
and no legacy consoles.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 78 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 15 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d17b0e057e22..0cb6ae5fd7e3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -463,6 +463,13 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 /* syslog_lock protects syslog_* variables and write access to clear_seq. */
 static DEFINE_MUTEX(syslog_lock);
 
+/*
+ * Specifies if a legacy console is registered. If legacy consoles are
+ * present, it is necessary to perform the console lock/unlock dance
+ * whenever console flushing should occur.
+ */
+static bool have_legacy_console;
+
 /*
  * Specifies if a boot console is registered. If boot consoles are present,
  * nbcon consoles cannot print simultaneously and must be synchronized by
@@ -471,6 +478,14 @@ static DEFINE_MUTEX(syslog_lock);
  */
 static bool have_boot_console;
 
+/*
+ * Specifies if the console lock/unlock dance is needed for console
+ * printing. If @have_boot_console is true, the nbcon consoles will
+ * be printed serially along with the legacy consoles because nbcon
+ * consoles cannot print simultaneously with boot consoles.
+ */
+#define printing_via_unlock (have_legacy_console || have_boot_console)
+
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
@@ -2339,7 +2354,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched) {
+	if (!in_sched && printing_via_unlock) {
 		/*
 		 * The caller may be holding system-critical or
 		 * timing-sensitive locks. Disable preemption during
@@ -2648,7 +2663,7 @@ void resume_console(void)
  */
 static int console_cpu_notify(unsigned int cpu)
 {
-	if (!cpuhp_tasks_frozen) {
+	if (!cpuhp_tasks_frozen && printing_via_unlock) {
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
@@ -3189,7 +3204,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
 
 	nbcon_atomic_flush_pending();
 
-	console_flush_all(false, &next_seq, &handover);
+	if (printing_via_unlock)
+		console_flush_all(false, &next_seq, &handover);
 }
 
 /*
@@ -3523,6 +3539,7 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_NBCON) {
 		nbcon_init(newcon, init_seq);
 	} else {
+		have_legacy_console = true;
 		newcon->seq = init_seq;
 	}
 
@@ -3598,6 +3615,7 @@ EXPORT_SYMBOL(register_console);
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {
+	bool found_legacy_con = false;
 	bool found_boot_con = false;
 	unsigned long flags;
 	struct console *c;
@@ -3665,9 +3683,13 @@ static int unregister_console_locked(struct console *console)
 	for_each_console(c) {
 		if (c->flags & CON_BOOT)
 			found_boot_con = true;
+		if (!(c->flags & CON_NBCON))
+			found_legacy_con = true;
 	}
 	if (!found_boot_con)
 		have_boot_console = found_boot_con;
+	if (!found_legacy_con)
+		have_legacy_console = found_legacy_con;
 
 	return res;
 }
@@ -3828,22 +3850,34 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	seq = prb_next_reserve_seq(prb);
 
 	/* Flush the consoles so that records up to @seq are printed. */
-	console_lock();
-	console_unlock();
+	if (printing_via_unlock) {
+		console_lock();
+		console_unlock();
+	}
 
 	for (;;) {
 		unsigned long begin_jiffies;
 		unsigned long slept_jiffies;
-
-		diff = 0;
+		bool use_console_lock = printing_via_unlock;
 
 		/*
-		 * Hold the console_lock to guarantee safe access to
-		 * console->seq. Releasing console_lock flushes more
-		 * records in case @seq is still not printed on all
-		 * usable consoles.
+		 * Ensure the compiler does not optimize @use_console_lock to
+		 * be @printing_via_unlock since the latter can change at any
+		 * time.
 		 */
-		console_lock();
+		barrier();
+
+		diff = 0;
+
+		if (use_console_lock) {
+			/*
+			 * Hold the console_lock to guarantee safe access to
+			 * console->seq. Releasing console_lock flushes more
+			 * records in case @seq is still not printed on all
+			 * usable consoles.
+			 */
+			console_lock();
+		}
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(c) {
@@ -3863,6 +3897,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (flags & CON_NBCON) {
 				printk_seq = nbcon_seq_read(c);
 			} else {
+				WARN_ON_ONCE(!use_console_lock);
 				printk_seq = c->seq;
 			}
 
@@ -3874,7 +3909,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		if (diff != last_diff && reset_on_progress)
 			remaining_jiffies = timeout_jiffies;
 
-		console_unlock();
+		if (use_console_lock)
+			console_unlock();
 
 		/* Note: @diff is 0 if there are no usable consoles. */
 		if (diff == 0 || remaining_jiffies == 0)
@@ -3944,6 +3980,7 @@ static void __wake_up_klogd(int val)
 		return;
 
 	preempt_disable();
+
 	/*
 	 * Guarantee any new records can be seen by tasks preparing to wait
 	 * before this context checks if the wait queue is empty.
@@ -3955,11 +3992,22 @@ static void __wake_up_klogd(int val)
 	 *
 	 * This pairs with devkmsg_read:A and syslog_print:A.
 	 */
-	if (wq_has_sleeper(&log_wait) || /* LMM(__wake_up_klogd:A) */
-	    (val & PRINTK_PENDING_OUTPUT)) {
+	if (!wq_has_sleeper(&log_wait)) /* LMM(__wake_up_klogd:A) */
+		val &= ~PRINTK_PENDING_WAKEUP;
+
+	/*
+	 * Simple read is safe. register_console() would flush a newly
+	 * registered legacy console when writing the message about it
+	 * being enabled.
+	 */
+	if (!printing_via_unlock)
+		val &= ~PRINTK_PENDING_OUTPUT;
+
+	if (val) {
 		this_cpu_or(printk_pending, val);
 		irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	}
+
 	preempt_enable();
 }
 
-- 
2.39.2



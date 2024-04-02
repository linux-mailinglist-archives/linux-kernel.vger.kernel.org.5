Return-Path: <linux-kernel+bounces-128781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1798A895F80
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1ECC28468B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6B5163AA7;
	Tue,  2 Apr 2024 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OHTaL5Il";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ygWHRd95"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4368161308
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095908; cv=none; b=j/Y3KkgAFTZmEhD/wbO5zGkikhJ7KCU8mz38batTOvEAE3qWQx2oXyegnNl9LLp5vAUdCznKxzf/pSLtdDEDfbkOBfsTB2MZcHeGGh9Tlat2uUadeiQHG3QnZ09xTU/U8ZJYs7V9TR2pjFBv0fV23FkHLVakhjxIh7UuNWzW/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095908; c=relaxed/simple;
	bh=gTqx/v0rb2tHlQCiMAUpXZKcD6qWubYj3ZattR525Fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n3BzaG8ldZIGX8lrQO9No6r8lnQ4jff+wMpAjsbHpXdQoAgKOWfaxwX3kCelH+dEwFPx5vNudZehaHErsCTfyD04pBE+qL0f9fZ0bjAxo+w9cydGcCoBfNALu24arK2cWTXDwWLog4o7ZHrgm8uXjhCiUE4f0ekd+VkHe3YqK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OHTaL5Il; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ygWHRd95; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EjQ48cpkb+zaV+h93O06qb7/bP9cVz61JUJsepicz6Q=;
	b=OHTaL5Ilg30j42YJBi4UTS2HxzE4cOrPD8OgyKMyaWGZVq72kef/m4ELHfUmxISwYyv8nP
	C/R/6vtc1fOASeQ9mVzgBrAJedgVCKY6uk1s8/eErIGSJk1rQ3IbiufhQ/q1azpVFOpy4g
	r8HJYhrBDku+BYY1oplRzMb9HssHkoVRQGK0L89IMIh7OB86xq3258ySMMJ7DtndFRbxpc
	LRR5HhPwPBxm3SG4hq48G9opcKAZB0G+Gazk/NSIBwmptKue+U6Wqds/xyBxtv/3RwCmB0
	Pb5SO2o4MUPcCrXM1MoBArWDQoCOjsP16Z3+86a0KsipkBtkWy/dBJHOs607mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EjQ48cpkb+zaV+h93O06qb7/bP9cVz61JUJsepicz6Q=;
	b=ygWHRd95QUs3aU+sNNj2E43ofcfyAQC9j8uihbB+2x7aBxS+u59lfntAGlC9f8djp8cCHR
	f6uDNuiBAwNwnfBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 20/27] printk: Avoid console_lock dance if no legacy or boot consoles
Date: Wed,  3 Apr 2024 00:17:22 +0206
Message-Id: <20240402221129.2613843-21-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
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
---
 kernel/printk/printk.c | 77 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 13 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index df84c6bfbb2d..4ff3800e8e8e 100644
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
@@ -3526,6 +3542,8 @@ void register_console(struct console *newcon)
 		 */
 		nbcon_seq_force(newcon, newcon->seq);
 		newcon->seq = 0;
+	} else {
+		have_legacy_console = true;
 	}
 
 	if (newcon->flags & CON_BOOT)
@@ -3600,6 +3618,7 @@ EXPORT_SYMBOL(register_console);
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {
+	bool found_legacy_con = false;
 	bool found_boot_con = false;
 	struct console *c;
 	int res;
@@ -3656,9 +3675,13 @@ static int unregister_console_locked(struct console *console)
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
@@ -3810,6 +3833,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	u64 last_diff = 0;
 	u64 printk_seq;
 	short flags;
+	bool locked;
 	int cookie;
 	u64 diff;
 	u64 seq;
@@ -3819,22 +3843,35 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
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
 
+		locked = false;
 		diff = 0;
 
+		if (printing_via_unlock) {
+			/*
+			 * Hold the console_lock to guarantee safe access to
+			 * console->seq. Releasing console_lock flushes more
+			 * records in case @seq is still not printed on all
+			 * usable consoles.
+			 */
+			console_lock();
+			locked = true;
+		}
+
 		/*
-		 * Hold the console_lock to guarantee safe access to
-		 * console->seq. Releasing console_lock flushes more
-		 * records in case @seq is still not printed on all
-		 * usable consoles.
+		 * Ensure the compiler does not optimize @locked to be
+		 * @printing_via_unlock since the latter can change at any
+		 * time.
 		 */
-		console_lock();
+		barrier();
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(c) {
@@ -3854,6 +3891,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (flags & CON_NBCON) {
 				printk_seq = nbcon_seq_read(c);
 			} else {
+				WARN_ON_ONCE(!locked);
 				printk_seq = c->seq;
 			}
 
@@ -3865,7 +3903,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		if (diff != last_diff && reset_on_progress)
 			remaining_jiffies = timeout_jiffies;
 
-		console_unlock();
+		if (locked)
+			console_unlock();
 
 		/* Note: @diff is 0 if there are no usable consoles. */
 		if (diff == 0 || remaining_jiffies == 0)
@@ -3935,6 +3974,7 @@ static void __wake_up_klogd(int val)
 		return;
 
 	preempt_disable();
+
 	/*
 	 * Guarantee any new records can be seen by tasks preparing to wait
 	 * before this context checks if the wait queue is empty.
@@ -3946,11 +3986,22 @@ static void __wake_up_klogd(int val)
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



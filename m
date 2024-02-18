Return-Path: <linux-kernel+bounces-70513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6079B8598C7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBABB281C1E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB776039;
	Sun, 18 Feb 2024 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mjJqDNK5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G5yGs3GU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1572B71B38
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282678; cv=none; b=bLKuVVeqPeH+SyLFZ7iixn1Fi2aSJjOnfDDReA+am4t7ENjV4mhTjLludCnCQ2bz9N2F6JZVUVwG1pa9X0B7m1WgxyrW0f+UGOGr8kvwJO3ENmZyKtnczHzmu7SuCyUoArtba77KsPCmrmhhNamYu8yh7hSN7cFkQmFaoAltAZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282678; c=relaxed/simple;
	bh=MSC0yqFA6MdNJ32n25Ewi0S5rdt3EruLjFiW5QHefOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EsAIrrXpXwMaGkEG76BtnDf5qim/DgOUyUuzOgMbuLTgH12frpHMMka0k4cdjKWjHYsU3UvNux9M07m+A1Wx6i+d0v8fPyuzC3Q2/uamQWzVMuW94hFOcGr7pfH+z4+tOqw6XcRKBLOF6E8w/guSyVUuq/WoGEwbUVodo3aUZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mjJqDNK5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G5yGs3GU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OotBUrgxQCK8IqOMKIc8OhTnB4TB5YG6MBjdk6yC3WQ=;
	b=mjJqDNK5XCubYFdP056JtAZ04KsiV7Wk86CvvOfY+crckzRYKpiugcbGviQBzTNGVrijWt
	19sbo16TQj7aQihMxIbDCyl7D5xYL8/MREaX5AQ/KkizNb+2e/SGoxVXzV/jVRxgR6prmc
	VbT+4J8w5mbBKFXAKVV69TvNrwhJb1gSVjxXZDEvV7UyOXWEHm55fkL5FUGeJVCbzxmNpV
	r25ozsl7yIb3rqJdDcsxfjNgfW755XFsGsDjwBoppaz2+gOVFzGOkB51UVA3pAzjBvfXFv
	6o2jgsAtAAi+6uhHzM5W5s5TCWcl5FmLtd1KzyM488ITX4sN92pcHgGXDW908g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OotBUrgxQCK8IqOMKIc8OhTnB4TB5YG6MBjdk6yC3WQ=;
	b=G5yGs3GUU0mAY87B/KytgBTfHgHysjBH+QIsv42gny1YAb8pS7ureudbJ1tyjF4DHEH3xi
	e6D3hDWWrHtK5iCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 19/26] printk: Avoid console_lock dance if no legacy or boot consoles
Date: Sun, 18 Feb 2024 20:03:19 +0106
Message-Id: <20240218185726.1994771-20-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
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
 kernel/printk/internal.h | 12 ++++++++
 kernel/printk/printk.c   | 59 ++++++++++++++++++++++++++++++----------
 2 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 70e9a1ea75be..74181c71776f 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -44,6 +44,16 @@ enum printk_info_flags {
 };
 
 extern struct printk_ringbuffer *prb;
+extern bool have_legacy_console;
+extern bool have_boot_console;
+
+/*
+ * Specifies if the console lock/unlock dance is needed for console
+ * printing. If @have_boot_console is true, the nbcon consoles will
+ * be printed serially along with the legacy consoles because nbcon
+ * consoles cannot print simultaneously with boot consoles.
+ */
+#define printing_via_unlock (have_legacy_console || have_boot_console)
 
 __printf(4, 0)
 int vprintk_store(int facility, int level,
@@ -123,6 +133,8 @@ static inline bool console_is_usable(struct console *con, short flags)
 #define PRINTK_MESSAGE_MAX	0
 #define PRINTKRB_RECORD_MAX	0
 
+#define printing_via_unlock (false)
+
 /*
  * In !PRINTK builds we still export console_sem
  * semaphore and some of console functions (console_unlock()/etc.), so
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d91771fb306e..336dad179b99 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -463,6 +463,13 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 /* syslog_lock protects syslog_* variables and write access to clear_seq. */
 static DEFINE_MUTEX(syslog_lock);
 
+/*
+ * Specifies if a legacy console is registered. If legacy consoles are
+ * present, it is necessary to perform the console_lock/console_unlock dance
+ * whenever console flushing should occur.
+ */
+bool have_legacy_console;
+
 /*
  * Specifies if a boot console is registered. If boot consoles are present,
  * nbcon consoles cannot print simultaneously and must be synchronized by
@@ -2344,7 +2351,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched) {
+	if (!in_sched && printing_via_unlock) {
 		/*
 		 * The caller may be holding system-critical or
 		 * timing-sensitive locks. Disable preemption during
@@ -2645,7 +2652,7 @@ void resume_console(void)
  */
 static int console_cpu_notify(unsigned int cpu)
 {
-	if (!cpuhp_tasks_frozen) {
+	if (!cpuhp_tasks_frozen && printing_via_unlock) {
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
@@ -3188,7 +3195,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
 
 	nbcon_atomic_flush_all();
 
-	console_flush_all(false, &next_seq, &handover);
+	if (printing_via_unlock)
+		console_flush_all(false, &next_seq, &handover);
 }
 
 /*
@@ -3513,8 +3521,11 @@ void register_console(struct console *newcon)
 	newcon->dropped = 0;
 	console_init_seq(newcon, bootcon_registered);
 
-	if (newcon->flags & CON_NBCON)
+	if (newcon->flags & CON_NBCON) {
 		nbcon_init(newcon);
+	} else {
+		have_legacy_console = true;
+	}
 
 	if (newcon->flags & CON_BOOT)
 		have_boot_console = true;
@@ -3571,6 +3582,7 @@ EXPORT_SYMBOL(register_console);
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {
+	bool found_legacy_con = false;
 	bool found_boot_con = false;
 	struct console *c;
 	int res;
@@ -3627,9 +3639,13 @@ static int unregister_console_locked(struct console *console)
 	for_each_console(c) {
 		if (c->flags & CON_BOOT)
 			found_boot_con = true;
+		if (!(c->flags & CON_NBCON))
+			found_legacy_con = true;
 	}
 	if (!found_boot_con)
 		have_boot_console = false;
+	if (!found_legacy_con)
+		have_legacy_console = false;
 
 	return res;
 }
@@ -3781,6 +3797,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	u64 last_diff = 0;
 	u64 printk_seq;
 	short flags;
+	bool locked;
 	int cookie;
 	u64 diff;
 	u64 seq;
@@ -3790,22 +3807,28 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
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
 
-		/*
-		 * Hold the console_lock to guarantee safe access to
-		 * console->seq. Releasing console_lock flushes more
-		 * records in case @seq is still not printed on all
-		 * usable consoles.
-		 */
-		console_lock();
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
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(c) {
@@ -3825,6 +3848,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (flags & CON_NBCON) {
 				printk_seq = nbcon_seq_read(c);
 			} else {
+				WARN_ON_ONCE(!locked);
 				printk_seq = c->seq;
 			}
 
@@ -3836,7 +3860,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		if (diff != last_diff && reset_on_progress)
 			remaining_jiffies = timeout_jiffies;
 
-		console_unlock();
+		if (locked)
+			console_unlock();
 
 		/* Note: @diff is 0 if there are no usable consoles. */
 		if (diff == 0 || remaining_jiffies == 0)
@@ -3958,7 +3983,11 @@ void defer_console_output(void)
 	 * New messages may have been added directly to the ringbuffer
 	 * using vprintk_store(), so wake any waiters as well.
 	 */
-	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
+	int val = PRINTK_PENDING_WAKEUP;
+
+	if (printing_via_unlock)
+		val |= PRINTK_PENDING_OUTPUT;
+	__wake_up_klogd(val);
 }
 
 void printk_trigger_flush(void)
-- 
2.39.2



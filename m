Return-Path: <linux-kernel+bounces-128783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4BC895F83
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556E1283D80
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB916A1F9;
	Tue,  2 Apr 2024 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RiI+QERh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ml+zxwoF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0126016192B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095911; cv=none; b=bg9a9Y+ipac5XQw8Bf4IzByF47q+zzP7dIEdJz6/evvsCvX7PaqZDnXh6hGOeW7p8MkXqzSbL8jCc6g+O3Z66k6q7vBe6s4yaOIYTSiWHTQHPQ02f0GLep0mBTaLCb396xTSQeqwpFbn5cmV62/V0nBxD+/WmhSdyGbihDuCz68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095911; c=relaxed/simple;
	bh=PgiKWKAgmNvz35ONRrpILBxwpuOVIu85979RvgYSqls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YrrYFUJGZ/inz5QAHYqGNW2ILfJMGmyaBONDUPOl4cJF1Fga/iEQNUghHdKPlmOUmE51SLhJPpg0TmiWnmendCWwB1VF+J3rqSYdme7GHkx5vIc9/awrQ3jqpwUX0Q9Yz7IUSu1LKoFpi/pZ8QAkow1QnZ+xoW/7KOvhVzGhCPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RiI+QERh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ml+zxwoF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YYD1HrU/gCuCLj4UZrPD3LcgwMCesrdxGaUJGV8It8=;
	b=RiI+QERhnKuEHzcV0IYrB14l/EJjriZYlDOvZdH7oBD8k10U0UJ4b37jgxnzQIYvrqk2zN
	n1/V8JLxO1qul49bFGz9ZdXuDQg3kwlbJSENhm2+ALd4dFIRvjmsmtbgsDiSdT3FQk/2Za
	fPQ50S7SLsygepBhZCyLRvn/8Skm6wwMDFpU+33NApkOn3tA0bjhOl3ZYiu65zxqLeOE2u
	f/ix5JOxXW5OOv/JUgKtgII5sNdEzl3Z0KuAJlecHFib4U1IFAuR4eIJOVY/esDG/OJYrY
	NolEwmVPoK2pTJwrGgUUgwQ/X26VxA781x6+jL7TJFqWaxc5rOOzEvh3aVqzuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YYD1HrU/gCuCLj4UZrPD3LcgwMCesrdxGaUJGV8It8=;
	b=Ml+zxwoFpCrwkCl8czM0t6TAxS8PDFYb0ZRJIrJevbkB08tTkcIwxwc3e2OW2Ukr7WKdRH
	BsrOidIyP1/BgIBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v4 23/27] printk: nbcon: Implement emergency sections
Date: Wed,  3 Apr 2024 00:17:25 +0206
Message-Id: <20240402221129.2613843-24-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

In emergency situations (something has gone wrong but the
system continues to operate), usually important information
(such as a backtrace) is generated via printk(). Each
individual printk record has little meaning. It is the
collection of printk messages that is most often needed by
developers and users.

In order to help ensure that the collection of printk messages
in an emergency situation are all stored to the ringbuffer as
quickly as possible, disable console output for that CPU while
it is in the emergency situation. The consoles need to be
flushed when exiting the emergency situation.

Add per-CPU emergency nesting tracking because an emergency
can arise while in an emergency situation.

Add functions to mark the beginning and end of emergency
sections where the urgent messages are generated.

Do not print if the current CPU is in an emergency state.

When exiting all emergency nesting, flush nbcon consoles
directly using their atomic callback. Legacy consoles are
triggered for flushing via irq_work because it is not known
if the context was safe for a trylock on the console lock.

Note that the emergency state is not system-wide. While one CPU
is in an emergency state, another CPU may continue to print
console messages.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h |  4 ++
 kernel/printk/nbcon.c   | 83 +++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c  | 13 ++++++-
 3 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 5f1758891aec..7712e4145164 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -559,10 +559,14 @@ static inline bool console_is_registered(const struct console *con)
 	hlist_for_each_entry(con, &console_list, node)
 
 #ifdef CONFIG_PRINTK
+extern void nbcon_cpu_emergency_enter(void);
+extern void nbcon_cpu_emergency_exit(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
 #else
+static inline void nbcon_cpu_emergency_enter(void) { }
+static inline void nbcon_cpu_emergency_exit(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 47f39402a22b..4c852c2e8d89 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -936,6 +936,29 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	return nbcon_context_exit_unsafe(ctxt);
 }
 
+/* Track the nbcon emergency nesting per CPU. */
+static DEFINE_PER_CPU(unsigned int, nbcon_pcpu_emergency_nesting);
+static unsigned int early_nbcon_pcpu_emergency_nesting __initdata;
+
+/**
+ * nbcon_get_cpu_emergency_nesting - Get the per CPU emergency nesting pointer
+ *
+ * Return:	Either a pointer to the per CPU emergency nesting counter of
+ *		the current CPU or to the init data during early boot.
+ */
+static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
+{
+	/*
+	 * The value of __printk_percpu_data_ready gets set in normal
+	 * context and before SMP initialization. As a result it could
+	 * never change while inside an nbcon emergency section.
+	 */
+	if (!printk_percpu_data_ready())
+		return &early_nbcon_pcpu_emergency_nesting;
+
+	return this_cpu_ptr(&nbcon_pcpu_emergency_nesting);
+}
+
 /**
  * nbcon_atomic_emit_one - Print one record for an nbcon console using the
  *				write_atomic() callback
@@ -977,9 +1000,15 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
  */
 enum nbcon_prio nbcon_get_default_prio(void)
 {
+	unsigned int *cpu_emergency_nesting;
+
 	if (this_cpu_in_panic())
 		return NBCON_PRIO_PANIC;
 
+	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
+	if (*cpu_emergency_nesting)
+		return NBCON_PRIO_EMERGENCY;
+
 	return NBCON_PRIO_NORMAL;
 }
 
@@ -1146,6 +1175,60 @@ void nbcon_atomic_flush_unsafe(void)
 	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), true);
 }
 
+/**
+ * nbcon_cpu_emergency_enter - Enter an emergency section where printk()
+ *	messages for that CPU are only stored
+ *
+ * Upon exiting the emergency section, all stored messages are flushed.
+ *
+ * Context:	Any context. Disables preemption.
+ *
+ * When within an emergency section, no printing occurs on that CPU. This
+ * is to allow all emergency messages to be dumped into the ringbuffer before
+ * flushing the ringbuffer. The actual printing occurs when exiting the
+ * outermost emergency section.
+ */
+void nbcon_cpu_emergency_enter(void)
+{
+	unsigned int *cpu_emergency_nesting;
+
+	preempt_disable();
+
+	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
+	(*cpu_emergency_nesting)++;
+}
+
+/**
+ * nbcon_cpu_emergency_exit - Exit an emergency section and flush the
+ *	stored messages
+ *
+ * Flushing only occurs when exiting all nesting for the CPU.
+ *
+ * Context:	Any context. Enables preemption.
+ */
+void nbcon_cpu_emergency_exit(void)
+{
+	unsigned int *cpu_emergency_nesting;
+	bool do_trigger_flush = false;
+
+	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
+
+	WARN_ON_ONCE(*cpu_emergency_nesting == 0);
+
+	if (*cpu_emergency_nesting == 1) {
+		nbcon_atomic_flush_pending();
+		do_trigger_flush = true;
+	}
+
+	/* Undo the nesting count of nbcon_cpu_emergency_enter(). */
+	(*cpu_emergency_nesting)--;
+
+	preempt_enable();
+
+	if (do_trigger_flush)
+		printk_trigger_flush();
+}
+
 /**
  * nbcon_alloc - Allocate buffers needed by the nbcon console
  * @con:	Console to allocate buffers for
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e3fd157d7ba3..ab5dade1352d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2412,16 +2412,25 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 * printing of all remaining records to all consoles so that
 		 * this context can return as soon as possible. Hopefully
 		 * another printk() caller will take over the printing.
+		 *
+		 * Also, nbcon_get_default_prio() requires migration disabled.
 		 */
 		preempt_disable();
+
 		/*
 		 * Try to acquire and then immediately release the console
 		 * semaphore. The release will print out buffers. With the
 		 * spinning variant, this context tries to take over the
 		 * printing from another printing context.
+		 *
+		 * Skip it in EMERGENCY priority. The console will be
+		 * explicitly flushed when exiting the emergency section.
 		 */
-		if (console_trylock_spinning())
-			console_unlock();
+		if (nbcon_get_default_prio() != NBCON_PRIO_EMERGENCY) {
+			if (console_trylock_spinning())
+				console_unlock();
+		}
+
 		preempt_enable();
 	}
 
-- 
2.39.2



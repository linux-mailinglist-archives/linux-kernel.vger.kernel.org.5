Return-Path: <linux-kernel+bounces-166978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAFA8BA28B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB1828CE5D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE7820FABC;
	Thu,  2 May 2024 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fqRnxaYU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cuMCWKgm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0711CB30A
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685938; cv=none; b=t3gu2W+bHBz2ojVf4RsbTrDrotpYojLtmq6oUrwKGW4P1l0nW7n6vY8f6bTthUgRpbiKs/Gn8rfVpNb1nsqSdr4/29XRmjvfmUND5Q/XC4zMQ/9XfHH+UfU38imESHy7XCk+Q1ej6dOuktFEcjs+5A2bUF0+DFvjuqDqiiRRR7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685938; c=relaxed/simple;
	bh=ngbrYVMExdcOV1ngJsRT+LpRpt5L9EbM6fx8Jr4AdgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WF+jVtneLdlYtcRdvKUoaVTfTmgdMNQOaGWZrPX8NkpVr0162C6QaF2xaYtdxPcg1U8WZ+z4RsHDiwszbC1xfj3x9maw9HAs0HgObbT7r7IIJ7EpAxR0OBv4fKhchRAfqBBqXGmVUzrlko/EjoUb8lad0KukPAmQTKwoy0s4op0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fqRnxaYU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cuMCWKgm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eq+dcRV+xTsqG/y9TJ22b7EZvwkA/4uLrtusf4n1LA=;
	b=fqRnxaYUq3tSAbxeQzt661qvGpLBsFdSJxYYn2iiKEKmPmX4GTVVgVbP/EIaWr7u5dUjff
	Eiso9sC3XOzMUZd1BA65rwk++YkMbWnW++IuFh0e5o/sa7/Kp19wDF/mYT49OViNYlJs35
	cwlrAgZ2Z4+hXYH7VCPaw0nEW+L3PhKm9f0dd8kkd0GeCPzf1JFtX4M8gayw0LJCZIkLtS
	OGeiu6Ke/tuBAwAk2QJzrsqmuB5P0YLl22xyvxbrN/FL33V2QW4SmQ2iDt0BBreHk6TjHv
	kYm5XeiMYSTWC2GyvLOmd4ywLKKzwGlw/KgOIajaN/9AAt1a/ECWXE1dy8p3Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eq+dcRV+xTsqG/y9TJ22b7EZvwkA/4uLrtusf4n1LA=;
	b=cuMCWKgmJjt6HcxyRHAO+HrnpG6P/xitqnMtdVA52w/SLC4wAVwMhvU/cq3oHCPZIF7d4i
	JhnVhvhN9GZq5yDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v5 26/30] printk: nbcon: Implement emergency sections
Date: Thu,  2 May 2024 23:44:35 +0206
Message-Id: <20240502213839.376636-27-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
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
 include/linux/console.h  |   6 ++
 kernel/printk/internal.h |  11 ++++
 kernel/printk/nbcon.c    | 116 +++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c   |  25 +++++----
 4 files changed, 146 insertions(+), 12 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 71d0638aa818..1b25eda4e7c2 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -535,10 +535,16 @@ static inline bool console_is_registered(const struct console *con)
 	hlist_for_each_entry(con, &console_list, node)
 
 #ifdef CONFIG_PRINTK
+extern void nbcon_cpu_emergency_enter(void);
+extern void nbcon_cpu_emergency_exit(void);
+extern void nbcon_cpu_emergency_flush(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
 #else
+static inline void nbcon_cpu_emergency_enter(void) { }
+static inline void nbcon_cpu_emergency_exit(void) { }
+static inline void nbcon_cpu_emergency_flush(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 91bc0ee43f8d..5519239fa5d2 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -153,6 +153,17 @@ static inline bool console_is_usable(struct console *con, short flags) { return
 
 #endif /* CONFIG_PRINTK */
 
+extern bool have_boot_console;
+extern bool have_legacy_console;
+
+/*
+ * Specifies if the console lock/unlock dance is needed for console
+ * printing. If @have_boot_console is true, the nbcon consoles will
+ * be printed serially along with the legacy consoles because nbcon
+ * consoles cannot print simultaneously with boot consoles.
+ */
+#define printing_via_unlock (have_legacy_console || have_boot_console)
+
 extern struct printk_buffers printk_shared_pbufs;
 
 /**
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 8f6b3858ab27..991e2702915c 100644
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
  * nbcon_get_default_prio - The appropriate nbcon priority to use for nbcon
  *				printing on the current CPU
@@ -946,9 +969,15 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
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
 
@@ -1199,6 +1228,93 @@ void nbcon_atomic_flush_unsafe(void)
 	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), true);
 }
 
+/**
+ * nbcon_cpu_emergency_enter - Enter an emergency section where printk()
+ *				messages for that CPU are only stored
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
+ *				stored messages
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
+	/*
+	 * Flush the messages before enabling preemtion to see them ASAP.
+	 *
+	 * Reduce the risk of potential softlockup by using the
+	 * flush_pending() variant which ignores messages added later. It is
+	 * called before decrementing the counter so that the printing context
+	 * for the emergency messages is NBCON_PRIO_EMERGENCY.
+	 */
+	if (*cpu_emergency_nesting == 1) {
+		nbcon_atomic_flush_pending();
+		do_trigger_flush = true;
+	}
+
+	(*cpu_emergency_nesting)--;
+
+	if (WARN_ON_ONCE(*cpu_emergency_nesting < 0))
+		*cpu_emergency_nesting = 0;
+
+	preempt_enable();
+
+	if (do_trigger_flush)
+		printk_trigger_flush();
+}
+
+/**
+ * nbcon_cpu_emergency_flush - Explicitly flush consoles while
+ *				within emergency context
+ *
+ * Both nbcon and legacy consoles are flushed.
+ *
+ * It should be used only when there are too many messages printed
+ * in emergency context, for example, printing backtraces of all
+ * CPUs or processes. It is typically needed when the watchdogs
+ * need to be touched as well.
+ */
+void nbcon_cpu_emergency_flush(void)
+{
+	/* The explicit flush is needed only in the emergency context. */
+	if (*(nbcon_get_cpu_emergency_nesting()) == 0)
+		return;
+
+	nbcon_atomic_flush_pending();
+
+	if (printing_via_unlock && !in_nmi()) {
+		if (console_trylock())
+			console_unlock();
+	}
+}
+
 /**
  * nbcon_alloc - Allocate buffers needed by the nbcon console
  * @con:	Console to allocate buffers for
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index eb1d7f0b10bf..487742eeacf3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -468,7 +468,7 @@ static DEFINE_MUTEX(syslog_lock);
  * present, it is necessary to perform the console lock/unlock dance
  * whenever console flushing should occur.
  */
-static bool have_legacy_console;
+bool have_legacy_console;
 
 /*
  * Specifies if an nbcon console is registered. If nbcon consoles are present,
@@ -483,15 +483,7 @@ static bool have_nbcon_console;
  * the console lock. This is because boot consoles and nbcon consoles may
  * have mapped the same hardware.
  */
-static bool have_boot_console;
-
-/*
- * Specifies if the console lock/unlock dance is needed for console
- * printing. If @have_boot_console is true, the nbcon consoles will
- * be printed serially along with the legacy consoles because nbcon
- * consoles cannot print simultaneously with boot consoles.
- */
-#define printing_via_unlock (have_legacy_console || have_boot_console)
+bool have_boot_console;
 
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
@@ -2412,16 +2404,25 @@ asmlinkage int vprintk_emit(int facility, int level,
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



Return-Path: <linux-kernel+bounces-70515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A188598CB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB411F2167C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31033763E3;
	Sun, 18 Feb 2024 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xc6CwIuS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6uoS2Ttx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A51A73163
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282679; cv=none; b=hOM2HIW6AwfQBPw6d3+4vJffe1XqCRfUeiwlcpN6L+9c5jFg1jaHqOKhsDVIp+OatbV6Z9R/1FBb+qR1pGfIX9gHZO/xBFE+n2uCNGpcd7ui6Q+gmwFKPcLMkNgIoJK/k/dE9Gm5WPIt5DYLvySPJMrbPMr+/qOXA4+PWZP/zu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282679; c=relaxed/simple;
	bh=e7GbIKGogj5AP6ontVh7TIYkL2C0F+okj8XJlpL+1uE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NijXI4qtPuYeZIgLtkCbodndp3LIf1bf34QvzTLzpC6a6jKqyiTXOASDnLlp/zaI1s3B995pMw8dfPCpIPBPmP1qgNMYGVtL1+mh04n7bIJnIu5L1mPZXIdvFgs0p7HcE65W5xqSA9zsI64LSVJXH+FXDrR2ERoat13voRWP0tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xc6CwIuS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6uoS2Ttx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=chNxmh0c/kNKxyDg+4LUMVdYUn+cMPiAIaQ2mbvqe3U=;
	b=Xc6CwIuSRTv33zta/xRJXtT995IlWZr+PW3IHK3NmPPkzQRlqeczv9xIUVQHzHdt6zWkck
	j+eSKHmhgiC3U2ixwJV/dsAGrvFq3Y61E+pqtbjUdQ/o6PKcyKo8034xNb7Ws8U0oqBitM
	BTfQnrNH4ZsVwVAJcyBuQsjk5TPpVz4UtVIv6r237wSB4l9sLvm/ojK414w0fk7vShQIho
	l3+O+D7tg7DgL7lZrpNwq24wY64WYt8NLSFYADeurj8xqiI281FQBmJn8KooIFhn3f1vX3
	Undq8eHZ62YqCnIWv1lwALk/wrFHR0ci5e6ZNSiNwie7h9hzHAeidLYfk9jrCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=chNxmh0c/kNKxyDg+4LUMVdYUn+cMPiAIaQ2mbvqe3U=;
	b=6uoS2TtxoVJ82xFQcHORU233rpeZS6laROejmkz/b3nXsD/uFUQPj7lJrTjRfxK5DSLrtW
	ULed0kxJ4VUf8XDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 22/26] printk: nbcon: Implement emergency sections
Date: Sun, 18 Feb 2024 20:03:22 +0106
Message-Id: <20240218185726.1994771-23-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
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
it is in the emergency situation. When exiting the emergency
situation, trigger the consoles to be flushed.

Add per-CPU emergency nesting tracking because an emergency
can arise while in an emergency situation.

Add functions to mark the beginning and end of emergency
sections where the urgent messages are generated.

Do not print if the current CPU is in an emergency state.

Trigger console flushing when exiting all emergency nesting.

Note that the emergency state is not system-wide. While one CPU
is in an emergency state, another CPU may continue to print
console messages.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h |  4 ++
 kernel/printk/nbcon.c   | 81 +++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c  | 25 ++++++++++---
 3 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index d8922282efa1..b1c870898181 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -478,10 +478,14 @@ static inline bool console_is_registered(const struct console *con)
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
index 64dedd79e880..ce556c1f4dc5 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -929,6 +929,29 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
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
@@ -971,9 +994,15 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
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
 
@@ -1105,6 +1134,58 @@ void nbcon_atomic_flush_unsafe(void)
 	__nbcon_atomic_flush_all(prb_next_reserve_seq(prb), true);
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
+	if (*cpu_emergency_nesting == 1)
+		do_trigger_flush = true;
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
index 109cfdd988aa..c8ad2b6ffe63 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2404,16 +2404,29 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 * printing of all remaining records to all consoles so that
 		 * this context can return as soon as possible. Hopefully
 		 * another printk() caller will take over the printing.
+		 *
+		 * Also, nbcon_get_default_prio() requires migration disabled.
 		 */
 		preempt_disable();
+
 		/*
-		 * Try to acquire and then immediately release the console
-		 * semaphore. The release will print out buffers. With the
-		 * spinning variant, this context tries to take over the
-		 * printing from another printing context.
+		 * Do not emit for EMERGENCY priority. The console will be
+		 * explicitly flushed when exiting the emergency section.
 		 */
-		if (console_trylock_spinning())
-			console_unlock();
+		if (nbcon_get_default_prio() == NBCON_PRIO_EMERGENCY) {
+			do_trylock_unlock = false;
+		} else {
+			/*
+			 * Try to acquire and then immediately release the
+			 * console semaphore. The release will print out
+			 * buffers. With the spinning variant, this context
+			 * tries to take over the printing from another
+			 * printing context.
+			 */
+			if (console_trylock_spinning())
+				console_unlock();
+		}
+
 		preempt_enable();
 	}
 
-- 
2.39.2



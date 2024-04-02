Return-Path: <linux-kernel+bounces-128775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03504895F79
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843731F22441
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E089815F3F5;
	Tue,  2 Apr 2024 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ns2wHTj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UvHj88+3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C446C15FCEC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095905; cv=none; b=CzRcxwCfwBnsFe17wH3uGiVtpXabtQHbmJfwyIbunkyqyaGjowSHuXxA2ZM+M4PxCRsO9F1/2U6yQXVFeLXfYbTtmaHnQ6wGtHGo/t0tj9mjKlUXHHLxTi6k3Auosqdghn/MSPf7frQunJICz/h8DU0dItP+Fe4CwpE6ortPa0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095905; c=relaxed/simple;
	bh=PVJ+rhXeGE3ArSPWyipgCCjhGauuCodgDEyKuljedLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=myPs81BHSgRc8RuoWfYoOQ8W2RCv7j+XByGmcUthpECqZIP8igF4qCPETh0iQfz0qVU8mH3rQqKcPwOfVu5CbBG9KPA66cI9dfaSlqh6Pfe/ZW1eiJZIccHlNZ09jZLFOW/PtTLAfDweFIVPrw+l/BjuUpTY7enE+h6yRw1GVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ns2wHTj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UvHj88+3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OiBtbPe76V5QyDUwRqi5gzdP2C/dYecf5xSN7mqsJdE=;
	b=1ns2wHTjKxICz+BSk22mCfbRCZ7s0419iM9Qyd3uSdL04U5W+1ofIbtJUUwtYQEQl01dnX
	zpP1sdKchxlEBKICG1f3nphgJ1c1li4rw3ot8ydB5Nk0zVXBinkyI5CQ6iZxVjppJB7JpD
	rQmi11zqISKcQPHcjEDnYFxGzT309PqXUUWbaLso1Kck+2aaeYSJVWciMuPquobkOswBDk
	ynwxQuO5bGYdW78HS+2O5wRMTm8m6PITJb9iixZw8EMCgx5lie1sj9/Pmyshw4h27ueHX3
	EY+vvD25lYNlivelqPeJ5vHfgIFbYExdh7j5B/VgfpqsPGJwJpBk0tvsmAUEEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OiBtbPe76V5QyDUwRqi5gzdP2C/dYecf5xSN7mqsJdE=;
	b=UvHj88+34uhQWNw2nFmwAiCaTYzqBTuGLWP27lfxks1Ws/EV34BGeVXfVjxx7ZVkId48Ll
	AAcFlqSANyGIHWCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 15/27] printk: nbcon: Provide function to flush using write_atomic()
Date: Wed,  3 Apr 2024 00:17:17 +0206
Message-Id: <20240402221129.2613843-16-john.ogness@linutronix.de>
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

Provide nbcon_atomic_flush_pending() to perform flushing of all
registered nbcon consoles using their write_atomic() callback.

Unlike console_flush_all(), nbcon_atomic_flush_pending() will
only flush up through the newest record at the time of the
call. This prevents a CPU from printing unbounded when other
CPUs are adding records.

Also unlike console_flush_all(), nbcon_atomic_flush_pending()
will fully flush one console before flushing the next. This
helps to guarantee that a block of pending records (such as
a stack trace in an emergency situation) can be printed
atomically at once before releasing console ownership.

nbcon_atomic_flush_pending() is safe in any context because it
uses write_atomic() and acquires with unsafe_takeover disabled.

Use it in console_flush_on_panic() before flushing legacy
consoles. The legacy write() callbacks are not fully safe when
oops_in_progress is set.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 kernel/printk/internal.h |   2 +
 kernel/printk/nbcon.c    | 104 ++++++++++++++++++++++++++++++++++++++-
 kernel/printk/printk.c   |   2 +
 3 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index b7a0072eb2a4..a8df764fd0c5 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -84,6 +84,7 @@ void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con);
 void nbcon_free(struct console *con);
+void nbcon_atomic_flush_pending(void);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -138,6 +139,7 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
+static inline void nbcon_atomic_flush_pending(void) { }
 
 static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 1de6062d4ce3..fcdab2eaaedb 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -548,7 +548,6 @@ static struct printk_buffers panic_nbcon_pbufs;
  * in an unsafe state. Otherwise, on success the caller may assume
  * the console is not in an unsafe state.
  */
-__maybe_unused
 static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 {
 	unsigned int cpu = smp_processor_id();
@@ -850,7 +849,6 @@ EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
  * When true is returned, @wctxt->ctxt.backlog indicates whether there are
  * still records pending in the ringbuffer,
  */
-__maybe_unused
 static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
@@ -937,6 +935,108 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	return nbcon_context_exit_unsafe(ctxt);
 }
 
+/**
+ * __nbcon_atomic_flush_pending_con - Flush specified nbcon console using its
+ *					write_atomic() callback
+ * @con:			The nbcon console to flush
+ * @stop_seq:			Flush up until this record
+ *
+ * Return:	True if taken over while printing. Otherwise false.
+ *
+ * If flushing up to @stop_seq was not successful, it only makes sense for the
+ * caller to try again when true was returned. When false is returned, either
+ * there are no more records available to read or this context is not allowed
+ * to acquire the console.
+ */
+static bool __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
+{
+	struct nbcon_write_context wctxt = { };
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
+
+	ctxt->console			= con;
+	ctxt->spinwait_max_us		= 2000;
+	ctxt->prio			= NBCON_PRIO_NORMAL;
+
+	if (!nbcon_context_try_acquire(ctxt))
+		return false;
+
+	while (nbcon_seq_read(con) < stop_seq) {
+		/*
+		 * nbcon_emit_next_record() returns false when the console was
+		 * handed over or taken over. In both cases the context is no
+		 * longer valid.
+		 */
+		if (!nbcon_emit_next_record(&wctxt))
+			return true;
+
+		if (!ctxt->backlog)
+			break;
+	}
+
+	nbcon_context_release(ctxt);
+
+	return false;
+}
+
+/**
+ * __nbcon_atomic_flush_pending - Flush all nbcon consoles using their
+ *					write_atomic() callback
+ * @stop_seq:			Flush up until this record
+ */
+static void __nbcon_atomic_flush_pending(u64 stop_seq)
+{
+	struct console *con;
+	bool should_retry;
+	int cookie;
+
+	do {
+		should_retry = false;
+
+		cookie = console_srcu_read_lock();
+		for_each_console_srcu(con) {
+			short flags = console_srcu_read_flags(con);
+			unsigned long irq_flags;
+
+			if (!(flags & CON_NBCON))
+				continue;
+
+			if (!console_is_usable(con, flags))
+				continue;
+
+			if (nbcon_seq_read(con) >= stop_seq)
+				continue;
+
+			/*
+			 * Atomic flushing does not use console driver
+			 * synchronization (i.e. it does not hold the port
+			 * lock for uart consoles). Therefore IRQs must be
+			 * disabled to avoid being interrupted and then
+			 * calling into a driver that will deadlock trying
+			 * to acquire console ownership.
+			 */
+			local_irq_save(irq_flags);
+
+			should_retry |= __nbcon_atomic_flush_pending_con(con, stop_seq);
+
+			local_irq_restore(irq_flags);
+		}
+		console_srcu_read_unlock(cookie);
+	} while (should_retry);
+}
+
+/**
+ * nbcon_atomic_flush_pending - Flush all nbcon consoles using their
+ *				write_atomic() callback
+ *
+ * Flush the backlog up through the currently newest record. Any new
+ * records added while flushing will not be flushed. This is to avoid
+ * one CPU printing unbounded because other CPUs continue to add records.
+ */
+void nbcon_atomic_flush_pending(void)
+{
+	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb));
+}
+
 /**
  * nbcon_alloc - Allocate buffers needed by the nbcon console
  * @con:	Console to allocate buffers for
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fe06856f7653..6404f2044ceb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3172,6 +3172,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		console_srcu_read_unlock(cookie);
 	}
 
+	nbcon_atomic_flush_pending();
+
 	console_flush_all(false, &next_seq, &handover);
 }
 
-- 
2.39.2



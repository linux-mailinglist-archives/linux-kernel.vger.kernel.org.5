Return-Path: <linux-kernel+bounces-70509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4858598C2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931A11F2308A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9FE745C4;
	Sun, 18 Feb 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QP9FA40Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FhOTMESp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B956F520
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282677; cv=none; b=OJseM3BEauP2lSo8Ys7Wd/NUTf8IdNHsgmhSGXWJoU97l0iPdBehceeR4CZf45zTzuehCj13B4PNDXTYSakU1VmvFA5Hm3e4/IZudCMeJijxU+Xj132xB0amLBWeKbgSO7ZELZY7LchKLc04aDbrmQXg9rHMHXjgAsd94diuRP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282677; c=relaxed/simple;
	bh=aVOu1/bqDAARdrnRU5+DODTSrgXpJ65t9RLdNz7m7TU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZQzItlAGpVE8bUo+Gye7NxtglewX8vomZEQktW7GCjhbY4OZCdG6kP/wNGMnl9LMJy8Tlh45T9wNWcMKsv2TXkWMoQvGfQH+0V6JIDzlgUBntiBm1ACqiTsYnGKG+BonfKuR8Mx82NCCuzgPzu3MWzBwcQEVX4deDQO6RRlj7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QP9FA40Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FhOTMESp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glYrKDUJ7lHx0vPgFl5st9OXHzyL6p/mgGcT2k0j/yc=;
	b=QP9FA40YAYELeVxUBZi0Zk2entx086hATCdFn7fwEWkwoePQdmQY0Zj0BaqefkCK4vyKhE
	yRkaQCR/GZDq+3tMY85Aso10KSnz9ewFoQR0uzw5xX7UEx2kQvU6snT7OpbrX6IUFeAuZ8
	fOSXwvqW+QtcEVp3Oojb3qIw7rd/+Txlt4JS0gailqcqmpWZNwOF1AWvEl9rg0nLp1KJuz
	pO222FA/6ucaoV7cZ+z7J+PSOdW/EK/nUEaEJzVNFX95ipdWO4CLM5FJhy2oe4RcPyY6zw
	JrZHmJEV1me0Qx4e7u6kZE3qICmMgHtfiV/CuPCLnfNVRHS1Rgz5ka538z3gfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glYrKDUJ7lHx0vPgFl5st9OXHzyL6p/mgGcT2k0j/yc=;
	b=FhOTMESp09Y0esdlb4LAnktBJn/wIjVMQZnSHidLDRzBe14BT9TOvFuRuyAZ4oZ7T1ZDDm
	/HeXGmslX87eNKBg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 14/26] printk: nbcon: Provide function to flush using write_atomic()
Date: Sun, 18 Feb 2024 20:03:14 +0106
Message-Id: <20240218185726.1994771-15-john.ogness@linutronix.de>
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

Provide nbcon_atomic_flush_all() to perform flushing of all
registered nbcon consoles using their write_atomic() callback.
Like with legacy consoles, the nbcon consoles are flushed one
record per console. This allows all nbcon consoles to print
lines pseudo-simultaneously, rather than one console waiting
for the full ringbuffer to dump to another console before
printing anything.

Unlike console_flush_all(), nbcon_atomic_flush_all() will only
flush up through the newest record at the time of the call.
This prevents a CPU from printing unbounded when other CPUs are
adding records.

Perform nbcon console atomic flushing in
console_flush_on_panic(). This function is not only used in
panic() but also other locations where there may be stored
messages that need to be flushed.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 kernel/printk/internal.h |   2 +
 kernel/printk/nbcon.c    | 100 ++++++++++++++++++++++++++++++++++++++-
 kernel/printk/printk.c   |   2 +
 3 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6780911fa8f2..d9a5205692fc 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -77,6 +77,7 @@ void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con);
 void nbcon_free(struct console *con);
+void nbcon_atomic_flush_all(void);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -131,6 +132,7 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
+static inline void nbcon_atomic_flush_all(void) { }
 
 static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 02e8fdc1ea43..2eb2929c1027 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -539,7 +539,6 @@ static struct printk_buffers panic_nbcon_pbufs;
  * in an unsafe state. Otherwise, on success the caller may assume
  * the console is not in an unsafe state.
  */
-__maybe_unused
 static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 {
 	unsigned int cpu = smp_processor_id();
@@ -841,7 +840,6 @@ EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
  * When true is returned, @wctxt->ctxt.backlog indicates whether there are
  * still records pending in the ringbuffer,
  */
-__maybe_unused
 static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
@@ -930,6 +928,104 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	return nbcon_context_exit_unsafe(ctxt);
 }
 
+/**
+ * nbcon_atomic_emit_one - Print one record for an nbcon console using the
+ *				write_atomic() callback
+ * @wctxt:	An initialized write context struct to use
+ *		for this context
+ *
+ * Return:	False if the given console could not print a record or there
+ *		are no more records to print, otherwise true.
+ *
+ * This is an internal helper to handle the locking of the console before
+ * calling nbcon_emit_next_record().
+ */
+static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	if (!nbcon_context_try_acquire(ctxt))
+		return false;
+
+	/*
+	 * nbcon_emit_next_record() returns false when the console was
+	 * handed over or taken over. In both cases the context is no
+	 * longer valid.
+	 */
+	if (!nbcon_emit_next_record(wctxt))
+		return false;
+
+	nbcon_context_release(ctxt);
+
+	return ctxt->backlog;
+}
+
+/**
+ * __nbcon_atomic_flush_all - Flush all nbcon consoles using their
+ *					write_atomic() callback
+ * @stop_seq:			Flush up until this record
+ */
+static void __nbcon_atomic_flush_all(u64 stop_seq)
+{
+	struct nbcon_write_context wctxt = { };
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
+	struct console *con;
+	bool any_progress;
+	int cookie;
+
+	do {
+		any_progress = false;
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
+			memset(ctxt, 0, sizeof(*ctxt));
+			ctxt->console			= con;
+			ctxt->spinwait_max_us		= 2000;
+			ctxt->prio			= NBCON_PRIO_NORMAL;
+
+			/*
+			 * Atomic flushing does not use console driver
+			 * synchronization (i.e. it does not hold the port
+			 * lock for uart consoles). Therefore IRQs must be
+			 * disabled to avoid being interrupted and then
+			 * calling into a driver that will deadlock trying
+			 * acquire console ownership.
+			 */
+			local_irq_save(irq_flags);
+
+			any_progress |= nbcon_atomic_emit_one(&wctxt);
+
+			local_irq_restore(irq_flags);
+		}
+		console_srcu_read_unlock(cookie);
+	} while (any_progress);
+}
+
+/**
+ * nbcon_atomic_flush_all - Flush all nbcon consoles using their
+ *				write_atomic() callback
+ *
+ * Flush the backlog up through the currently newest record. Any new
+ * records added while flushing will not be flushed. This is to avoid
+ * one CPU printing unbounded because other CPUs continue to add records.
+ */
+void nbcon_atomic_flush_all(void)
+{
+	__nbcon_atomic_flush_all(prb_next_reserve_seq(prb));
+}
+
 /**
  * nbcon_alloc - Allocate buffers needed by the nbcon console
  * @con:	Console to allocate buffers for
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9d56ce5837f9..ea170ade4d42 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3169,6 +3169,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		console_srcu_read_unlock(cookie);
 	}
 
+	nbcon_atomic_flush_all();
+
 	console_flush_all(false, &next_seq, &handover);
 }
 
-- 
2.39.2



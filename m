Return-Path: <linux-kernel+bounces-70511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5404B8598C3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8F6281C53
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E13745EA;
	Sun, 18 Feb 2024 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ct5W9yD3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bUykeJ6U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB9371B2F
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282677; cv=none; b=Y9mYu8xAWujFVHJL4YN45dcPm66F9YSqrRq/0uknJZazR7BDCC3xLdcyfXesUt5MLf7OlClVDuW+3bsgathwn/sq+uhKXsautDhq8kOOGvO3HCr9R113agEFc0npg1GsJuZtXmKpj2Po27X5qcQw15/BNB7++7fRr6vBojzCwK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282677; c=relaxed/simple;
	bh=cFmrlN6+bjkYvopWH2Q6A0YP81LxOASzKK6Wrrcc1LQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZqveQ+1skRgw8If4+KeMTOF0wIiYzgaUwwN/GTTR8EbWpcSaUPL1R2zUdCrj7y83FFyVW5AZPO05buv+BK3g8X4qcJ9fSiOX5W/03DFVpNf/2Sq0MiOwmsKpqeQXBS+ICdv3kp6T3eAaOuByrW353Mj4JLIHoH4AyEYymul3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ct5W9yD3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bUykeJ6U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8tKxZn6xYxnbLSfcQWQs6Fl73klYk0DkiEPSmtK48M=;
	b=ct5W9yD3PDE9b+waw7Odwy0FtNYmwplTQMHj7vKc38guEZ6Q2ZlG5ci0CehFfccgGPgjg1
	xZqnIMdEJjovy2Okdt4hNLdtviWsJkQMQN0n2nbQhErdFGOYg9ZzTMrM0pi4amHME0hrye
	OH2RgT8hoFRLlY/Y8Z0zhTm4rclmFiZfaEFNwdyqZlXrtPDR3/GYFGD/x5ITcjV5KRtdfo
	vOiXdA4PZ4vk9m9eKs6Ttp/l3XIPTrOwAH5o3V5aZ/fZia2chddSqPEWmtjRNtdHyudDrf
	4p+ewt98SR4bpsirn1cFSPTvkL3eaCPv3WXTHg2oz33OW7u5fbqc+gYE7z2jag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8tKxZn6xYxnbLSfcQWQs6Fl73klYk0DkiEPSmtK48M=;
	b=bUykeJ6UlUC/VGxARJe/pHOyyjNV24ASEP11nA7i+rlF5J42Ds+TgwQLCsZcgLTvvgadip
	yi/pkG1662XnHSDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 17/26] printk: nbcon: Assign priority based on CPU state
Date: Sun, 18 Feb 2024 20:03:17 +0106
Message-Id: <20240218185726.1994771-18-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the current state of the CPU to determine which priority to
assign to the printing context.

Note: The uart_port wrapper, which is responsible for non-console-
      printing activities, will always use NORMAL priority.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/nbcon.c    | 30 ++++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index b34847ec6b0d..70e9a1ea75be 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -79,6 +79,7 @@ void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con);
 void nbcon_free(struct console *con);
+enum nbcon_prio nbcon_get_default_prio(void);
 void nbcon_atomic_flush_all(void);
 bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 				   int cookie);
@@ -136,6 +137,7 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
+static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 static inline void nbcon_atomic_flush_all(void) { }
 static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 						 int cookie) { return false; }
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 747f5cbfe5ee..1a18549e43b8 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -961,6 +961,22 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
 	return ctxt->backlog;
 }
 
+/**
+ * nbcon_get_default_prio - The appropriate nbcon priority to use for nbcon
+ *				printing on the current CPU
+ *
+ * Context:	Any context which could not be migrated to another CPU.
+ * Return:	The nbcon_prio to use for acquiring an nbcon console in this
+ *		context for printing.
+ */
+enum nbcon_prio nbcon_get_default_prio(void)
+{
+	if (this_cpu_in_panic())
+		return NBCON_PRIO_PANIC;
+
+	return NBCON_PRIO_NORMAL;
+}
+
 /**
  * nbcon_legacy_emit_next_record - Print one record for an nbcon console
  *					in legacy contexts
@@ -994,7 +1010,7 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 	stop_critical_timings();
 
 	ctxt->console	= con;
-	ctxt->prio	= NBCON_PRIO_NORMAL;
+	ctxt->prio	= nbcon_get_default_prio();
 
 	progress = nbcon_atomic_emit_one(&wctxt);
 
@@ -1038,7 +1054,6 @@ static void __nbcon_atomic_flush_all(u64 stop_seq)
 			memset(ctxt, 0, sizeof(*ctxt));
 			ctxt->console			= con;
 			ctxt->spinwait_max_us		= 2000;
-			ctxt->prio			= NBCON_PRIO_NORMAL;
 
 			/*
 			 * Atomic flushing does not use console driver
@@ -1047,9 +1062,14 @@ static void __nbcon_atomic_flush_all(u64 stop_seq)
 			 * disabled to avoid being interrupted and then
 			 * calling into a driver that will deadlock trying
 			 * acquire console ownership.
+			 *
+			 * This also disables migration in order to get the
+			 * current CPU priority.
 			 */
 			local_irq_save(irq_flags);
 
+			ctxt->prio = nbcon_get_default_prio();
+
 			any_progress |= nbcon_atomic_emit_one(&wctxt);
 
 			local_irq_restore(irq_flags);
@@ -1161,6 +1181,9 @@ static inline bool uart_is_nbcon(struct uart_port *up)
  *
  * If @up is an nbcon console, this console will be acquired and marked as
  * unsafe. Otherwise this function does nothing.
+ *
+ * nbcon consoles acquired via the port lock wrapper always use priority
+ * NBCON_PRIO_NORMAL.
  */
 void uart_nbcon_acquire(struct uart_port *up)
 {
@@ -1195,6 +1218,9 @@ EXPORT_SYMBOL_GPL(uart_nbcon_acquire);
  *
  * If @up is an nbcon console, the console will be marked as safe and
  * released. Otherwise this function does nothing.
+ *
+ * nbcon consoles acquired via the port lock wrapper always use priority
+ * NBCON_PRIO_NORMAL.
  */
 void uart_nbcon_release(struct uart_port *up)
 {
-- 
2.39.2



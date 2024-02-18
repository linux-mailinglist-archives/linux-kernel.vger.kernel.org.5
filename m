Return-Path: <linux-kernel+bounces-70510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A644F8598C4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC41A1C20FCE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6E2745EC;
	Sun, 18 Feb 2024 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X1pn8gUl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uRlGqUPm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F86FB84
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282677; cv=none; b=DEGltN6YM9rIBkIlNY64Fek8hAZlWb29rTBsdvYT6UmFMGp+vOAjV/SaHd81kjJFbcQvwK5YScO+n/q15vMZeBIMSoxcPvg+6Pdvm3ScLuzSZOXA8IqyFHXkd5PYGQaogFIiDgPlDDEgNmr34AsJa87vnxlRV/JDR5yB5EsD/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282677; c=relaxed/simple;
	bh=XNAFOxzMyR2DiCX23eg6uCGQcbosdfuXh1/QvXBV+3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JRqiAAdJ7N95ew4LdmxCwK69cSShxTUxsdM9AoCw26HOqT+aYJG2BLX/BwWRWuGZpY7HasekPRSzU4Ax7ftWlpmPgq4rMwnJqqbPjVv2/kDKZ8Y1tcVNinwke1bk8HBpSvDHjuw2yDSZCR8+Y9sK7HVRpvllKD68AbV8/xojtDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X1pn8gUl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uRlGqUPm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WpRiuHUchJ8PUhBQPppc9wlrZ+BaiMWpumcr51nxKc=;
	b=X1pn8gUlKUoMEiWMnaptlfxcDZ/fGoV6vTRapTZO3rzlah99nQ7MUPx+Ha+jrZN1cvTGZK
	JrPWwd+KnMJUZjxwwHxTkgZVzelM+KIUL80N/0gM6KtqB55uszHNyVCyXY/pQk0wvOMwkK
	N6sB+qCR2oVPZG6QvDCPvmLZ57GaYjSgXdCKjpF4NqvFXXlZsZqnR2BmuZf9AIg8n8iGUl
	S8LlAegzwnddOuEvKG4KlklwB/76QjbzJ5Wyth4ktGSyyjuLFureb94qasBM6jQBt0Zwl7
	aOLDzHlfdM2jKBlHAaa6J73DIx02d5aN2C4UQXkBVqFDNc0DtFwIBf7GnVdWRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WpRiuHUchJ8PUhBQPppc9wlrZ+BaiMWpumcr51nxKc=;
	b=uRlGqUPmvzNMGbcXT8nTGeSPZO0Nk1Wof15ZY2YyL6MAW1gTwVA2JE+R49msvY6HL7XMAh
	Ch1jTVfhrX2veLBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 16/26] printk: nbcon: Use nbcon consoles in console_flush_all()
Date: Sun, 18 Feb 2024 20:03:16 +0106
Message-Id: <20240218185726.1994771-17-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow nbcon consoles to print messages in the legacy printk()
caller context (printing via unlock) by integrating them into
console_flush_all(). The write_atomic() callback is used for
printing.

Provide nbcon_legacy_emit_next_record(), which acts as the
nbcon variant of console_emit_next_record(). Call this variant
within console_flush_all() for nbcon consoles. Since nbcon
consoles use their own @nbcon_seq variable to track the next
record to print, this also must be appropriately handled.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  6 ++++++
 kernel/printk/nbcon.c    | 45 ++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c   | 19 ++++++++++++-----
 3 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index d9a5205692fc..b34847ec6b0d 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -71,6 +71,8 @@ void defer_console_output(void);
 
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
+void console_lock_spinning_enable(void);
+int console_lock_spinning_disable_and_check(int cookie);
 
 u64 nbcon_seq_read(struct console *con);
 void nbcon_seq_force(struct console *con, u64 seq);
@@ -78,6 +80,8 @@ bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con);
 void nbcon_free(struct console *con);
 void nbcon_atomic_flush_all(void);
+bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
+				   int cookie);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -133,6 +137,8 @@ static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
 static inline void nbcon_atomic_flush_all(void) { }
+static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
+						 int cookie) { return false; }
 
 static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 2eb2929c1027..747f5cbfe5ee 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -532,6 +532,7 @@ static struct printk_buffers panic_nbcon_pbufs;
  * nbcon_context_try_acquire - Try to acquire nbcon console
  * @ctxt:	The context of the caller
  *
+ * Context:	Any context which could not be migrated to another CPU.
  * Return:	True if the console was acquired. False otherwise.
  *
  * If the caller allowed an unsafe hostile takeover, on success the
@@ -960,6 +961,50 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
 	return ctxt->backlog;
 }
 
+/**
+ * nbcon_legacy_emit_next_record - Print one record for an nbcon console
+ *					in legacy contexts
+ * @con:	The console to print on
+ * @handover:	Will be set to true if a printk waiter has taken over the
+ *		console_lock, in which case the caller is no longer holding
+ *		both the console_lock and the SRCU read lock. Otherwise it
+ *		is set to false.
+ * @cookie:	The cookie from the SRCU read lock.
+ *
+ * Context:	Any context which could not be migrated to another CPU.
+ * Return:	True if a record could be printed, otherwise false.
+ *
+ * This function is meant to be called by console_flush_all() to print records
+ * on nbcon consoles from legacy context (printing via console unlocking).
+ * Essentially it is the nbcon version of console_emit_next_record().
+ */
+bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
+				   int cookie)
+{
+	struct nbcon_write_context wctxt = { };
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
+	bool progress = false;
+	unsigned long flags;
+
+	*handover = false;
+
+	/* Use the same procedure as console_emit_next_record(). */
+	printk_safe_enter_irqsave(flags);
+	console_lock_spinning_enable();
+	stop_critical_timings();
+
+	ctxt->console	= con;
+	ctxt->prio	= NBCON_PRIO_NORMAL;
+
+	progress = nbcon_atomic_emit_one(&wctxt);
+
+	start_critical_timings();
+	*handover = console_lock_spinning_disable_and_check(cookie);
+	printk_safe_exit_irqrestore(flags);
+
+	return progress;
+}
+
 /**
  * __nbcon_atomic_flush_all - Flush all nbcon consoles using their
  *					write_atomic() callback
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1b14159990ba..d91771fb306e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1871,7 +1871,7 @@ static bool console_waiter;
  * there may be a waiter spinning (like a spinlock). Also it must be
  * ready to hand over the lock at the end of the section.
  */
-static void console_lock_spinning_enable(void)
+void console_lock_spinning_enable(void)
 {
 	/*
 	 * Do not use spinning in panic(). The panic CPU wants to keep the lock.
@@ -1910,7 +1910,7 @@ static void console_lock_spinning_enable(void)
  *
  * Return: 1 if the lock rights were passed, 0 otherwise.
  */
-static int console_lock_spinning_disable_and_check(int cookie)
+int console_lock_spinning_disable_and_check(int cookie)
 {
 	int waiter;
 
@@ -2948,13 +2948,22 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
 			short flags = console_srcu_read_flags(con);
+			u64 printk_seq;
 			bool progress;
 
 			if (!console_is_usable(con, flags))
 				continue;
 			any_usable = true;
 
-			progress = console_emit_next_record(con, handover, cookie);
+			if (flags & CON_NBCON) {
+				progress = nbcon_legacy_emit_next_record(con, handover, cookie);
+
+				printk_seq = nbcon_seq_read(con);
+			} else {
+				progress = console_emit_next_record(con, handover, cookie);
+
+				printk_seq = con->seq;
+			}
 
 			/*
 			 * If a handover has occurred, the SRCU read lock
@@ -2964,8 +2973,8 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 				return false;
 
 			/* Track the next of the highest seq flushed. */
-			if (con->seq > *next_seq)
-				*next_seq = con->seq;
+			if (printk_seq > *next_seq)
+				*next_seq = printk_seq;
 
 			if (!progress)
 				continue;
-- 
2.39.2



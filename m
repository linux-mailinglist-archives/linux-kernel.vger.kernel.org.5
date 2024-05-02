Return-Path: <linux-kernel+bounces-166973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EEC8BA282
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E35ACB24E8D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162FB201267;
	Thu,  2 May 2024 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Si0FjGbT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xnV/4eWX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7A1C8FC0
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685936; cv=none; b=EJt1Th0Rnd5I03kTT6kfzX7KMnNgWKdw9JUJn89MPjp11tVJ0HTnHY+ik4Qih7zYycD+hoKItaNjVMFu4QAuCzIhE5WmqP/N5uqw259702Po4bj6XMR6hi5EVRK3tgb9qGgKpvIaVnAMwlbTSGUxRcKliNQn1bTDHBYtq/II4/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685936; c=relaxed/simple;
	bh=gARkG73eQRU8V9yDFnYjNtWOHoOUrDG/qMyvfb3FT5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tjyk738mDNh2D6iJIxDvIxBbkbUW+yaGzzC2rzIDVslceDdUyHUo6+yoqFnAz3bhLylVEzfTg2vJZE3njDvBFQUSM+xaDEjeIvTFTjiHBvVvaE3PNnLYXWMc4HpFJEY+2oi281D9wNIhCwlw4osOhQYkaTs2qNgFrNlhvm+gfz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Si0FjGbT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xnV/4eWX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjNzD/P9+1HhwBtJEEAC1hhuGU7StxseV5FY0ZUbzxw=;
	b=Si0FjGbTfDhLWv8n4XGqxMj3pt5CGJsUa7NODCfBt1fLhXdaksNkS4LIeZZhcjLPwJ9Qne
	ZA9dv7PlliiVAx0MpOsr4OA9zMAoeOdn2UlqDBqnV2CCFcj1P7vEKReGeYc/TtFRt5gY2A
	3XkgZUUUBHcDPKrEeWm7/uxjSFxGkmiZR6siXvwc53JM9EyZsSdE6yHc9YJpjvq5H8f677
	SqbhWDOZ4MRPqCpTCwDjcy60KCtA7XDu/eWXHzbW/cZmt/eB/x8+PWCnNTtP5XKSeppvR0
	Bro+Mk4CCA3pTN0BnhEvBvOcTJnMnuIKcTQ4Si6KCajydApAC37JLokHd3SsYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjNzD/P9+1HhwBtJEEAC1hhuGU7StxseV5FY0ZUbzxw=;
	b=xnV/4eWXwKv4Woewc7X7tsHGY1gfoaKnp1aglMCfqd9UcUz5F4epk5o8Yo4P0ZfC4MMqRx
	jRD7gjfDsWunmdAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH printk v5 22/30] printk: nbcon: Add unsafe flushing on panic
Date: Thu,  2 May 2024 23:44:31 +0206
Message-Id: <20240502213839.376636-23-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nbcon_atomic_flush_unsafe() to flush all nbcon consoles
using the write_atomic() callback and allowing unsafe hostile
takeovers. Call this at the end of panic() as a final attempt
to flush any pending messages.

Note that legacy consoles use unsafe methods for flushing
from the beginning of panic (see bust_spinlocks()). Therefore,
systems using both legacy and nbcon consoles may still fail to
see panic messages due to unsafe legacy console usage.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/printk.h |  5 +++++
 kernel/panic.c         |  1 +
 kernel/printk/nbcon.c  | 32 +++++++++++++++++++++++++-------
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index d0a1106388d1..439decc792b6 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -197,6 +197,7 @@ extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
 extern bool nbcon_driver_try_acquire(struct console *con);
 extern void nbcon_driver_release(struct console *con);
+void nbcon_atomic_flush_unsafe(void);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -286,6 +287,10 @@ static inline void nbcon_driver_release(struct console *con)
 {
 }
 
+static inline void nbcon_atomic_flush_unsafe(void)
+{
+}
+
 #endif
 
 bool this_cpu_in_panic(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index f22d8f33ea14..c039f8e1ddae 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -453,6 +453,7 @@ void panic(const char *fmt, ...)
 	 * Explicitly flush the kernel log buffer one last time.
 	 */
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+	nbcon_atomic_flush_unsafe();
 
 	local_irq_enable();
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index abd3835a3466..8f6b3858ab27 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1044,6 +1044,7 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
  *					write_atomic() callback
  * @con:			The nbcon console to flush
  * @stop_seq:			Flush up until this record
+ * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
  *
  * Return:	0 if @con was flushed up to @stop_seq Otherwise, error code on
  *		failure.
@@ -1062,7 +1063,8 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
  * returned, it cannot be expected that the unfinalized record will become
  * available.
  */
-static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
+static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
+					    bool allow_unsafe_takeover)
 {
 	struct nbcon_write_context wctxt = { };
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
@@ -1071,6 +1073,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
 	ctxt->console			= con;
 	ctxt->spinwait_max_us		= 2000;
 	ctxt->prio			= nbcon_get_default_prio();
+	ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
 
 	if (!nbcon_context_try_acquire(ctxt))
 		return -EPERM;
@@ -1100,13 +1103,15 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
  *					write_atomic() callback
  * @con:			The nbcon console to flush
  * @stop_seq:			Flush up until this record
+ * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
  *
  * This will stop flushing before @stop_seq if another context has ownership.
  * That context is then responsible for the flushing. Likewise, if new records
  * are added while this context was flushing and there is no other context
  * to handle the printing, this context must also flush those records.
  */
-static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
+static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
+					   bool allow_unsafe_takeover)
 {
 	unsigned long flags;
 	int err;
@@ -1120,7 +1125,7 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
 	 */
 	local_irq_save(flags);
 
-	err = __nbcon_atomic_flush_pending_con(con, stop_seq);
+	err = __nbcon_atomic_flush_pending_con(con, stop_seq, allow_unsafe_takeover);
 
 	local_irq_restore(flags);
 
@@ -1144,8 +1149,9 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
  * __nbcon_atomic_flush_pending - Flush all nbcon consoles using their
  *					write_atomic() callback
  * @stop_seq:			Flush up until this record
+ * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
  */
-static void __nbcon_atomic_flush_pending(u64 stop_seq)
+static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeover)
 {
 	struct console *con;
 	int cookie;
@@ -1163,7 +1169,7 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
 		if (nbcon_seq_read(con) >= stop_seq)
 			continue;
 
-		nbcon_atomic_flush_pending_con(con, stop_seq);
+		nbcon_atomic_flush_pending_con(con, stop_seq, allow_unsafe_takeover);
 	}
 	console_srcu_read_unlock(cookie);
 }
@@ -1178,7 +1184,19 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
  */
 void nbcon_atomic_flush_pending(void)
 {
-	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb));
+	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), false);
+}
+
+/**
+ * nbcon_atomic_flush_unsafe - Flush all nbcon consoles using their
+ *	write_atomic() callback and allowing unsafe hostile takeovers
+ *
+ * Flush the backlog up through the currently newest record. Unsafe hostile
+ * takeovers will be performed, if necessary.
+ */
+void nbcon_atomic_flush_unsafe(void)
+{
+	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), true);
 }
 
 /**
@@ -1307,7 +1325,7 @@ void nbcon_driver_release(struct console *con)
 	cookie = console_srcu_read_lock();
 	if (console_is_usable(con, console_srcu_read_flags(con)) &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
-		__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb));
+		__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
 	}
 	console_srcu_read_unlock(cookie);
 }
-- 
2.39.2



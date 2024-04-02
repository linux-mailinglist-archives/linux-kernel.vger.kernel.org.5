Return-Path: <linux-kernel+bounces-128779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E795895F7D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B2DEB2792A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149DC16192D;
	Tue,  2 Apr 2024 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bs5z6lCt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JtVI6yVM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5431607BF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095908; cv=none; b=t0Yj/GNeeGIRyCniTMyEQ1H+Qev4kemh5QOed6pdWGSfmkYcGKzTS9WwGtjAF1OiDE3ra5q//qa4AKdvIeSPvLkQUAtrYUlnRWn3I5hrAWuNDPqccfMn7Gefmt+edHvbKbGbdk8IfvfHz0avlntVHjz0ERZDQFKT6L7oEfIAt00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095908; c=relaxed/simple;
	bh=vknBybsjEs93x4cnJ5nN/M/uvYkr0NDGiVf9T/dwPxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ilT3E/GuDlbAhJh+/uLRBM45DRG5Xw2vrzO0pHHn7Dkj1I9djzoLCOc3790nUir0iGbBDWwOT2OpSWSysFh2RFMk3gtJ8qFiksS/sEd/K+6ZT1qTJ9roao9JYzTIqfbKuilRcVwk+sTJhzkOJBbJ3tbyfTyYH9UnbnRLwWW1mLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bs5z6lCt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JtVI6yVM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlH5Xlqmpyf6Et7+NQWZIZIzLlU2T3ZP6VsVzNw72mg=;
	b=Bs5z6lCtmnNc5XRPHCnYQsQr9aG+m3hMM5gVtuaaqvnX277wxTBV3Ohmwel+mP49sQR38M
	sO7n/93qbiQG5FZRI2eiItg5pIZOGyYIPhs42Hi9GlppjzefnbkF0MG2v8wfICQmrKKgqW
	3VCoqBqKtJsJVCIV3MkwilmLPCjX4Ns5WMJcUB7vE/ZXDz6PDfkcSI1SDb2raChMKWJx2O
	uyxD0J2EZJ02wCPbuG8/jjari/P9pXSSqB0RwBhQ5pX3Fc6SgJzfEvRVMruveWqxwEn/67
	b8uTjf1nrhZ/YepPG/tAWPob/8OaEp9dwoYkKnlfdrog7qtZrTOK4Y0NaKNRYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlH5Xlqmpyf6Et7+NQWZIZIzLlU2T3ZP6VsVzNw72mg=;
	b=JtVI6yVMNrELdLxgZ0YH2PNE9ECFwujqpVs58sZ65U+8+Z0KRpO5pAd/SMhxjEHWqcmN9u
	l5+ci4ri6AH3uNBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Lukas Wunner <lukas@wunner.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH printk v4 19/27] printk: nbcon: Add unsafe flushing on panic
Date: Wed,  3 Apr 2024 00:17:21 +0206
Message-Id: <20240402221129.2613843-20-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
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
---
 include/linux/printk.h |  5 +++++
 kernel/panic.c         |  1 +
 kernel/printk/nbcon.c  | 26 +++++++++++++++++++++-----
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 0ad3ee752635..866683a293af 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -197,6 +197,7 @@ extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
 extern void nbcon_driver_acquire(struct console *con);
 extern void nbcon_driver_release(struct console *con);
+void nbcon_atomic_flush_unsafe(void);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -285,6 +286,10 @@ static inline void nbcon_driver_release(struct console *con)
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
index fe5a96ab1f40..47f39402a22b 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1033,6 +1033,7 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
  *					write_atomic() callback
  * @con:			The nbcon console to flush
  * @stop_seq:			Flush up until this record
+ * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
  *
  * Return:	True if taken over while printing. Otherwise false.
  *
@@ -1041,7 +1042,8 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
  * there are no more records available to read or this context is not allowed
  * to acquire the console.
  */
-static bool __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
+static bool __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
+					     bool allow_unsafe_takeover)
 {
 	struct nbcon_write_context wctxt = { };
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
@@ -1049,6 +1051,7 @@ static bool __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
 	ctxt->console			= con;
 	ctxt->spinwait_max_us		= 2000;
 	ctxt->prio			= nbcon_get_default_prio();
+	ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
 
 	if (!nbcon_context_try_acquire(ctxt))
 		return false;
@@ -1075,8 +1078,9 @@ static bool __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
  * __nbcon_atomic_flush_pending - Flush all nbcon consoles using their
  *					write_atomic() callback
  * @stop_seq:			Flush up until this record
+ * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
  */
-static void __nbcon_atomic_flush_pending(u64 stop_seq)
+static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeover)
 {
 	struct console *con;
 	bool should_retry;
@@ -1109,8 +1113,8 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
 			 */
 			local_irq_save(irq_flags);
 
-			should_retry |= __nbcon_atomic_flush_pending_con(con, stop_seq);
-
+			should_retry |= __nbcon_atomic_flush_pending_con(con, stop_seq,
+									 allow_unsafe_takeover);
 			local_irq_restore(irq_flags);
 		}
 		console_srcu_read_unlock(cookie);
@@ -1127,7 +1131,19 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
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
-- 
2.39.2



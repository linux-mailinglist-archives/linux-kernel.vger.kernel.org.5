Return-Path: <linux-kernel+bounces-70514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 280578598C8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAFF6B210AB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D7D762F1;
	Sun, 18 Feb 2024 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FXZwC3OF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xzyu0Cxe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC36F091
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282678; cv=none; b=Miht3BAc8cu6YvwqSrL0YndnZdiGwNoGLPB1GaxXKhKuGhTjxKHFOWDrtkoaivOGyxinWNxSzi2Z4/x8g+8I2ojsNHFeVDQpJBkge4/1Mi9WR5YRqU0hlnrwe49bSyyzhwvgJF5dDEXgxA7Abi38d7FYOG6Ajv+724agfYPInzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282678; c=relaxed/simple;
	bh=81eO5T4mRHN1U1zZes/KHjNFY37KXcnTqwj3ihqj47c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5KVFe1WHb+Y25CNsKZTtUSHpVBNMOugyJV+9Yw2K4BV6QAVnwvHaQYNzJnujrN4tFAGlQnCv5JuXrT06m3sH4vFBZ3O2QDOzeQ4BBH12W3gyUzu6GPJWMVWU2p33eGpUy7UbJKiFAfqRwRB6/6W1ep2Orj8npOkjZwXXCumeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FXZwC3OF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xzyu0Cxe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bzed56TBLrwPGrN35dvYqd3cTuWFkQirwReZT+CtxsI=;
	b=FXZwC3OFc25rzIrHikF4WtdBv2APWCF5VEmZ2scnH8HpzoR0dg4QM35v9Ua/AvOJKwkSPg
	THLEn5wdfOtxt0QIcDei+R59stZHcg5rB2mVzBiyQ5VtElXAAqf7EtAEJkdF8EziTDXF8I
	DNcTA52EkfWu8F29D2aq6RdaSElN8M+S6rjvlLTkhZ9XDBCQ/xspUVVPGh0Z/u7dCwNCEK
	HDo3YielB5lvVcH5N0jUymejn9XbGl3M4ne16/6+5y34jYUIDaO4Hm1lI/q8yuBzObKYLE
	BbO2oNQA1RVGAC33fMqMSK28dm6w5Oax8qBX3bPFiL28ehk7ZjMEd4t7kxCIzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bzed56TBLrwPGrN35dvYqd3cTuWFkQirwReZT+CtxsI=;
	b=Xzyu0CxexcMZiEDy4gQzCjfvKEd0rZp1n39XpIQTaMfLxZmfj0urMk/8z9PuagwSCHywl6
	WDAJh5fw296pSIBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Lukas Wunner <lukas@wunner.de>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH printk v2 18/26] printk: nbcon: Add unsafe flushing on panic
Date: Sun, 18 Feb 2024 20:03:18 +0106
Message-Id: <20240218185726.1994771-19-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
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
 kernel/printk/nbcon.c  | 18 ++++++++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index ef57a4d93ae2..fe37395af9e2 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -199,6 +199,7 @@ extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
 extern void uart_nbcon_acquire(struct uart_port *up);
 extern void uart_nbcon_release(struct uart_port *up);
+void nbcon_atomic_flush_unsafe(void);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -287,6 +288,10 @@ static inline void uart_nbcon_release(struct uart_port *up)
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
index 1a18549e43b8..64dedd79e880 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1025,8 +1025,9 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
  * __nbcon_atomic_flush_all - Flush all nbcon consoles using their
  *					write_atomic() callback
  * @stop_seq:			Flush up until this record
+ * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
  */
-static void __nbcon_atomic_flush_all(u64 stop_seq)
+static void __nbcon_atomic_flush_all(u64 stop_seq, bool allow_unsafe_takeover)
 {
 	struct nbcon_write_context wctxt = { };
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
@@ -1054,6 +1055,7 @@ static void __nbcon_atomic_flush_all(u64 stop_seq)
 			memset(ctxt, 0, sizeof(*ctxt));
 			ctxt->console			= con;
 			ctxt->spinwait_max_us		= 2000;
+			ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
 
 			/*
 			 * Atomic flushing does not use console driver
@@ -1088,7 +1090,19 @@ static void __nbcon_atomic_flush_all(u64 stop_seq)
  */
 void nbcon_atomic_flush_all(void)
 {
-	__nbcon_atomic_flush_all(prb_next_reserve_seq(prb));
+	__nbcon_atomic_flush_all(prb_next_reserve_seq(prb), false);
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
+	__nbcon_atomic_flush_all(prb_next_reserve_seq(prb), true);
 }
 
 /**
-- 
2.39.2



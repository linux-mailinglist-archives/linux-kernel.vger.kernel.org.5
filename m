Return-Path: <linux-kernel+bounces-1181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D22E814B63
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96752B20F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E603E476;
	Fri, 15 Dec 2023 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Vqt1LyQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3myDaELf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8008746424;
	Fri, 15 Dec 2023 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Dec 2023 16:09:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702652985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=uU9y32udg0gE80/DPZvLdSMnmpu0dhe+V1zkwS/R9PQ=;
	b=3Vqt1LyQlMMAfzrQZtAyvyNgzOm9WLdla9Lpl8PyZ7a+iq0sYgmNp4Aex/pnA0j1cpQnK5
	8EvSI6zisSiGitQDSZftoGQcdxtQFmcXFGgTxjTDKBEhZedHD/zSl4Oz3D61wzH9F/6ppN
	wCdFnjcNK7noRHvbU1OxgRAx7un5PV7xOXckFDuIc9gwY607k/NYModH0Bss5jo6Qe8i8j
	ILANTD8O8soTYjaNbQejIJRgDv5U/8zDYZHxY+NLkwkK0E+lcVQwqwRsdNr8/SO9qyTmzo
	DaQSnPsFBfMHpHtqestXdYi5+3IaFog8wgQTqHzUMdBNAuf9XcuykIgBHO9ZOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702652985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=uU9y32udg0gE80/DPZvLdSMnmpu0dhe+V1zkwS/R9PQ=;
	b=3myDaELfqnW5X+b1OHHpspXcjEaSWyhXuL+LDhJ7mL/E4NIlCRJrq5sFPw/FnqqVtz9sGU
	LAa1hJKLoVbP01Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.6.7-rt18
Message-ID: <20231215150944.nDRV_91j@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.6.7-rt18 patch set. 

Changes since v6.6.7-rt17:

  - Update the printk code to the latest version which has been posted
    upstream for review.

Known issues
     Pierre Gondois reported crashes on ARM64 together with "rtla timerlat
     hist" as trigger. It is not yet understood. The report is at
	https://lore.kernel.org/70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com

The delta patch against v6.6.7-rt17 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/incr/patch-6.6.7-rt17-rt18.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.6.7-rt18

The RT patch against v6.6.7 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patch-6.6.7-rt18.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patches-6.6.7-rt18.tar.xz

Sebastian

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index eab9b37344a5e..30434718fad80 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -617,9 +617,18 @@ static bool univ8250_console_write_thread(struct console *co,
 	return serial8250_console_write_thread(up, wctxt);
 }
 
-static struct uart_port *univ8250_console_uart_port(struct console *con)
+static void univ8250_console_driver_enter(struct console *con, unsigned long *flags)
 {
-	return &serial8250_ports[con->index].port;
+	struct uart_port *up = &serial8250_ports[con->index].port;
+
+	__uart_port_lock_irqsave(up, flags);
+}
+
+static void univ8250_console_driver_exit(struct console *con, unsigned long flags)
+{
+	struct uart_port *up = &serial8250_ports[con->index].port;
+
+	__uart_port_unlock_irqrestore(up, flags);
 }
 #endif /* CONFIG_SERIAL_8250_LEGACY_CONSOLE */
 
@@ -727,8 +736,9 @@ static struct console univ8250_console = {
 #else
 	.write_atomic	= univ8250_console_write_atomic,
 	.write_thread	= univ8250_console_write_thread,
+	.driver_enter	= univ8250_console_driver_enter,
+	.driver_exit	= univ8250_console_driver_exit,
 	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_NBCON,
-	.uart_port	= univ8250_console_uart_port,
 #endif
 	.device		= uart_console_device,
 	.setup		= univ8250_console_setup,
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 478b23c207169..437a7d3d34cde 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3517,13 +3517,11 @@ bool serial8250_console_write_thread(struct uart_8250_port *up,
 	if (!nbcon_enter_unsafe(wctxt))
 		return false;
 
-	/*
-	 *	First save the IER then disable the interrupts
-	 */
+	/* First save IER then disable the interrupts. */
 	ier = serial_port_in(port, UART_IER);
 	serial8250_clear_IER(up);
 
-	/* check scratch reg to see if port powered off during system sleep */
+	/* Check scratch reg if port powered off during system sleep. */
 	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
 		serial8250_console_restore(up);
 		up->canary = 0;
@@ -3571,30 +3569,25 @@ bool serial8250_console_write_thread(struct uart_8250_port *up,
 	while (!nbcon_enter_unsafe(wctxt))
 		nbcon_reacquire(wctxt);
 
-	/*
-	 *	Finally, wait for transmitter to become empty
-	 *	and restore the IER
-	 */
+	/* Finally, wait for transmitter to become empty and restore IER. */
 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
-
 	if (em485) {
 		mdelay(port->rs485.delay_rts_after_send);
 		if (em485->tx_stopped)
 			up->rs485_stop_tx(up);
 	}
-
 	serial_port_out(port, UART_IER, ier);
 
 	/*
-	 *	The receive handling will happen properly because the
-	 *	receive ready bit will still be set; it is not cleared
-	 *	on read.  However, modem control will not, we must
-	 *	call it if we have saved something in the saved flags
-	 *	while processing with interrupts off.
+	 * The receive handling will happen properly because the receive ready
+	 * bit will still be set; it is not cleared on read.  However, modem
+	 * control will not, we must call it if we have saved something in the
+	 * saved flags while processing with interrupts off.
 	 */
 	if (up->msr_saved_flags)
 		serial8250_modem_status(up);
 
+	/* Success if no handover/takeover and message fully printed. */
 	return (nbcon_exit_unsafe(wctxt) && done);
 }
 
@@ -3614,12 +3607,14 @@ bool serial8250_console_write_atomic(struct uart_8250_port *up,
 		return false;
 
 	/*
-	 *	First save the IER then disable the interrupts
+	 * First save IER then disable the interrupts. The special variant to
+	 * clear IER is used because atomic printing may occur without holding
+	 * the port lock.
 	 */
 	ier = serial_port_in(port, UART_IER);
 	__serial8250_clear_IER(up);
 
-	/* check scratch reg to see if port powered off during system sleep */
+	/* Check scratch reg if port powered off during system sleep. */
 	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
 		serial8250_console_restore(up);
 		up->canary = 0;
@@ -3629,14 +3624,11 @@ bool serial8250_console_write_atomic(struct uart_8250_port *up,
 		uart_console_write(port, "\n", 1, serial8250_console_putchar);
 	uart_console_write(port, wctxt->outbuf, wctxt->len, serial8250_console_putchar);
 
-	/*
-	 *	Finally, wait for transmitter to become empty
-	 *	and restore the IER
-	 */
+	/* Finally, wait for transmitter to become empty and restore IER. */
 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
-
 	serial_port_out(port, UART_IER, ier);
 
+	/* Success if no handover/takeover. */
 	return nbcon_exit_unsafe(wctxt);
 }
 #endif /* CONFIG_SERIAL_8250_LEGACY_CONSOLE */
diff --git a/include/linux/console.h b/include/linux/console.h
index 87e787ffb6531..f8a0628678886 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -299,7 +299,8 @@ struct nbcon_write_context {
  *
  * @write_atomic:	Write callback for atomic context
  * @write_thread:	Write callback for non-atomic context
- * @uart_port:		Callback to provide the associated uart port
+ * @driver_enter:	Callback to begin synchronization with driver code
+ * @driver_exit:	Callback to finish synchronization with driver code
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @pbufs:		Pointer to nbcon private buffer
@@ -332,7 +333,8 @@ struct console {
 						struct nbcon_write_context *wctxt);
 	bool			(*write_thread)(struct console *con,
 						struct nbcon_write_context *wctxt);
-	struct uart_port *	(*uart_port)(struct console *con);
+	void			(*driver_enter)(struct console *con, unsigned long *flags);
+	void			(*driver_exit)(struct console *con, unsigned long flags);
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 196a4cf3ccb76..7a942e987b165 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -197,8 +197,9 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
-extern void nbcon_handle_port_lock(struct uart_port *up);
-extern void nbcon_handle_port_unlock(struct uart_port *up);
+void printk_legacy_allow_panic_sync(void);
+extern void nbcon_acquire(struct uart_port *up);
+extern void nbcon_release(struct uart_port *up);
 void nbcon_atomic_flush_unsafe(void);
 #else
 static inline __printf(1, 0)
@@ -280,11 +281,15 @@ static inline void printk_trigger_flush(void)
 {
 }
 
-static inline void nbcon_handle_port_lock(struct uart_port *up)
+static inline void printk_legacy_allow_panic_sync(void)
 {
 }
 
-static inline void nbcon_handle_port_unlock(struct uart_port *up)
+static inline void nbcon_acquire(struct uart_port *up)
+{
+}
+
+static inline void nbcon_release(struct uart_port *up)
 {
 }
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 18ce60b40f1ed..245c11753effd 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -595,7 +595,7 @@ struct uart_port {
 static inline void uart_port_lock(struct uart_port *up)
 {
 	spin_lock(&up->lock);
-	nbcon_handle_port_lock(up);
+	nbcon_acquire(up);
 }
 
 /**
@@ -605,7 +605,7 @@ static inline void uart_port_lock(struct uart_port *up)
 static inline void uart_port_lock_irq(struct uart_port *up)
 {
 	spin_lock_irq(&up->lock);
-	nbcon_handle_port_lock(up);
+	nbcon_acquire(up);
 }
 
 /**
@@ -616,7 +616,7 @@ static inline void uart_port_lock_irq(struct uart_port *up)
 static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
 {
 	spin_lock_irqsave(&up->lock, *flags);
-	nbcon_handle_port_lock(up);
+	nbcon_acquire(up);
 }
 
 /**
@@ -630,7 +630,7 @@ static inline bool uart_port_trylock(struct uart_port *up)
 	if (!spin_trylock(&up->lock))
 		return false;
 
-	nbcon_handle_port_lock(up);
+	nbcon_acquire(up);
 	return true;
 }
 
@@ -646,7 +646,7 @@ static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long
 	if (!spin_trylock_irqsave(&up->lock, *flags))
 		return false;
 
-	nbcon_handle_port_lock(up);
+	nbcon_acquire(up);
 	return true;
 }
 
@@ -656,7 +656,7 @@ static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long
  */
 static inline void uart_port_unlock(struct uart_port *up)
 {
-	nbcon_handle_port_unlock(up);
+	nbcon_release(up);
 	spin_unlock(&up->lock);
 }
 
@@ -666,7 +666,7 @@ static inline void uart_port_unlock(struct uart_port *up)
  */
 static inline void uart_port_unlock_irq(struct uart_port *up)
 {
-	nbcon_handle_port_unlock(up);
+	nbcon_release(up);
 	spin_unlock_irq(&up->lock);
 }
 
@@ -677,7 +677,19 @@ static inline void uart_port_unlock_irq(struct uart_port *up)
  */
 static inline void uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
 {
-	nbcon_handle_port_unlock(up);
+	nbcon_release(up);
+	spin_unlock_irqrestore(&up->lock, flags);
+}
+
+/* Only for use in the console->driver_enter() callback. */
+static inline void __uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
+{
+	spin_lock_irqsave(&up->lock, *flags);
+}
+
+/* Only for use in the console->driver_exit() callback. */
+static inline void __uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
+{
 	spin_unlock_irqrestore(&up->lock, flags);
 }
 
diff --git a/kernel/panic.c b/kernel/panic.c
index 42890ffc7ae98..9215df21d8c2c 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -366,6 +366,8 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
+	printk_legacy_allow_panic_sync();
+
 	panic_print_sys_info(false);
 
 	kmsg_dump(KMSG_DUMP_PANIC);
@@ -443,6 +445,12 @@ void panic(const char *fmt, ...)
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
 
+	/*
+	 * The final messages may not have been printed if in a context that
+	 * defers printing (such as NMI) and irq_work is not available.
+	 * Explicitly flush the kernel log buffer one last time.
+	 */
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 	nbcon_atomic_flush_unsafe();
 
 	local_irq_enable();
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index a3ae0710346cd..7db6992c54f38 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -82,6 +82,8 @@ void defer_console_output(void);
 
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
+void console_lock_spinning_enable(void);
+int console_lock_spinning_disable_and_check(int cookie);
 
 u64 nbcon_seq_read(struct console *con);
 void nbcon_seq_force(struct console *con, u64 seq);
@@ -90,7 +92,7 @@ void nbcon_init(struct console *con);
 void nbcon_free(struct console *con);
 enum nbcon_prio nbcon_get_default_prio(void);
 void nbcon_atomic_flush_all(void);
-bool nbcon_atomic_emit_next_record(struct console *con);
+bool nbcon_atomic_emit_next_record(struct console *con, bool *handover, int cookie);
 void nbcon_kthread_create(struct console *con);
 void nbcon_wake_threads(void);
 void nbcon_legacy_kthread_create(void);
@@ -143,7 +145,7 @@ static inline void nbcon_kthread_wake(struct console *con)
 	 * Guarantee any new records can be seen by tasks preparing to wait
 	 * before this context checks if the rcuwait is empty.
 	 *
-	 * The full memory barrier in rcuwait_wake_up()  pairs with the full
+	 * The full memory barrier in rcuwait_wake_up() pairs with the full
 	 * memory barrier within set_current_state() of
 	 * ___rcuwait_wait_event(), which is called after prepare_to_rcuwait()
 	 * adds the waiter but before it has checked the wait condition.
@@ -180,9 +182,11 @@ static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
 static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 static inline void nbcon_atomic_flush_all(void) { }
-static bool nbcon_atomic_emit_next_record(struct console *con) { return false; }
+static inline bool nbcon_atomic_emit_next_record(struct console *con, bool *handover,
+						 int cookie) { return false; }
 
-static inline bool console_is_usable(struct console *con, short flags, bool use_atomic) { return false; }
+static inline bool console_is_usable(struct console *con, short flags,
+				     bool use_atomic) { return false; }
 
 #endif /* CONFIG_PRINTK */
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index a9be219673dbf..1b1b585b1675b 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -144,39 +144,6 @@ static inline bool nbcon_state_try_cmpxchg(struct console *con, struct nbcon_sta
 	return atomic_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_state), &cur->atom, new->atom);
 }
 
-#ifdef CONFIG_64BIT
-
-#define __seq_to_nbcon_seq(seq) (seq)
-#define __nbcon_seq_to_seq(seq) (seq)
-
-#else /* CONFIG_64BIT */
-
-#define __seq_to_nbcon_seq(seq) ((u32)seq)
-
-static inline u64 __nbcon_seq_to_seq(u32 nbcon_seq)
-{
-	u64 seq;
-	u64 rb_next_seq;
-
-	/*
-	 * The provided sequence is only the lower 32 bits of the ringbuffer
-	 * sequence. It needs to be expanded to 64bit. Get the next sequence
-	 * number from the ringbuffer and fold it.
-	 *
-	 * Having a 32bit representation in the console is sufficient.
-	 * If a console ever gets more than 2^31 records behind
-	 * the ringbuffer then this is the least of the problems.
-	 *
-	 * Also the access to the ring buffer is always safe.
-	 */
-	rb_next_seq = prb_next_seq(prb);
-	seq = rb_next_seq - ((u32)rb_next_seq - nbcon_seq);
-
-	return seq;
-}
-
-#endif /* CONFIG_64BIT */
-
 /**
  * nbcon_seq_read - Read the current console sequence
  * @con:	Console to read the sequence of
@@ -187,7 +154,7 @@ u64 nbcon_seq_read(struct console *con)
 {
 	unsigned long nbcon_seq = atomic_long_read(&ACCESS_PRIVATE(con, nbcon_seq));
 
-	return __nbcon_seq_to_seq(nbcon_seq);
+	return __ulseq_to_u64seq(prb, nbcon_seq);
 }
 
 /**
@@ -208,17 +175,12 @@ void nbcon_seq_force(struct console *con, u64 seq)
 	 */
 	u64 valid_seq = max_t(u64, seq, prb_first_valid_seq(prb));
 
-	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __seq_to_nbcon_seq(valid_seq));
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __u64seq_to_ulseq(valid_seq));
 
 	/* Clear con->seq since nbcon consoles use con->nbcon_seq instead. */
 	con->seq = 0;
 }
 
-static void nbcon_context_seq_set(struct nbcon_context *ctxt)
-{
-	ctxt->seq = nbcon_seq_read(ctxt->console);
-}
-
 /**
  * nbcon_seq_try_update - Try to update the console sequence number
  * @ctxt:	Pointer to an acquire context that contains
@@ -232,11 +194,11 @@ static void nbcon_context_seq_set(struct nbcon_context *ctxt)
  */
 static void nbcon_seq_try_update(struct nbcon_context *ctxt, u64 new_seq)
 {
-	unsigned long nbcon_seq = __seq_to_nbcon_seq(ctxt->seq);
+	unsigned long nbcon_seq = __u64seq_to_ulseq(ctxt->seq);
 	struct console *con = ctxt->console;
 
 	if (atomic_long_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_seq), &nbcon_seq,
-				    __seq_to_nbcon_seq(new_seq))) {
+				    __u64seq_to_ulseq(new_seq))) {
 		ctxt->seq = new_seq;
 	} else {
 		ctxt->seq = nbcon_seq_read(con);
@@ -575,6 +537,7 @@ static struct printk_buffers panic_nbcon_pbufs;
  * nbcon_context_try_acquire - Try to acquire nbcon console
  * @ctxt:	The context of the caller
  *
+ * Context:	Any context which could not be migrated to another CPU.
  * Return:	True if the console was acquired. False otherwise.
  *
  * If the caller allowed an unsafe hostile takeover, on success the
@@ -867,6 +830,22 @@ bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt)
 }
 EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
 
+/**
+ * nbcon_reacquire - Reacquire a console after losing ownership
+ * @wctxt:	The write context that was handed to the write function
+ *
+ * Since ownership can be lost at any time due to handover or takeover, a
+ * printing context _should_ be prepared to back out immediately and
+ * carefully. However, there are many scenarios where the context _must_
+ * reacquire ownership in order to finalize or revert hardware changes.
+ *
+ * This function allows a context to reacquire ownership using the same
+ * priority as its previous ownership.
+ *
+ * Note that for printing contexts, after a successful reacquire the
+ * context will have no output buffer because that has been lost. This
+ * function cannot be used to resume printing.
+ */
 void nbcon_reacquire(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
@@ -911,7 +890,7 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	unsigned long con_dropped;
 	struct nbcon_state cur;
 	unsigned long dropped;
-	bool done;
+	bool done = false;
 
 	/*
 	 * The printk buffers are filled within an unsafe section. This
@@ -959,16 +938,13 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 		   con->kthread) {
 		WARN_ON_ONCE(con->kthread != current);
 		done = con->write_thread(con, wctxt);
-
-	} else {
-		WARN_ON_ONCE(1);
-		done = false;
 	}
 
 	if (!done) {
 		/*
-		 * The emit was aborted. This may have been due to a loss
-		 * of ownership. Explicitly release ownership to be sure.
+		 * The emit was aborted, probably due to a loss of ownership.
+		 * Ensure ownership was lost or released before reporting the
+		 * loss.
 		 */
 		nbcon_context_release(ctxt);
 		return false;
@@ -1013,36 +989,23 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
  */
 static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_context *ctxt)
 {
-	struct nbcon_state cur;
 	bool is_usable;
 	short flags;
 	int cookie;
 
-	do {
-		if (kthread_should_stop())
-			return true;
+	if (kthread_should_stop())
+		return true;
 
-		cookie = console_srcu_read_lock();
-		flags = console_srcu_read_flags(con);
-		is_usable = console_is_usable(con, flags, false);
-		console_srcu_read_unlock(cookie);
+	cookie = console_srcu_read_lock();
+	flags = console_srcu_read_flags(con);
+	is_usable = console_is_usable(con, flags, false);
+	console_srcu_read_unlock(cookie);
 
-		if (!is_usable)
-			return false;
-
-		nbcon_state_read(con, &cur);
-
-		/*
-		 * Some other CPU is using the console. Patiently poll
-		 * to see if it becomes available. This is more efficient
-		 * than having every release trigger an irq_work to wake
-		 * the kthread.
-		 */
-		msleep(1);
-	} while (cur.prio != NBCON_PRIO_NONE);
+	if (!is_usable)
+		return false;
 
 	/* Bring the sequence in @ctxt up to date */
-	nbcon_context_seq_set(ctxt);
+	ctxt->seq = nbcon_seq_read(con);
 
 	return prb_read_valid(prb, ctxt->seq, NULL);
 }
@@ -1059,16 +1022,12 @@ static int nbcon_kthread_func(void *__console)
 		.ctxt.prio	= NBCON_PRIO_NORMAL,
 	};
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
-	struct uart_port *port = NULL;
 	unsigned long flags;
 	short con_flags;
 	bool backlog;
 	int cookie;
 	int ret;
 
-	if (con->uart_port)
-		port = con->uart_port(con);
-
 wait_for_event:
 	/*
 	 * Guarantee this task is visible on the rcuwait before
@@ -1099,14 +1058,13 @@ static int nbcon_kthread_func(void *__console)
 		con_flags = console_srcu_read_flags(con);
 
 		if (console_is_usable(con, con_flags, false)) {
+			con->driver_enter(con, &flags);
+
 			/*
 			 * Ensure this stays on the CPU to make handover and
 			 * takeover possible.
 			 */
-			if (port)
-				spin_lock_irqsave(&port->lock, flags);
-			else
-				migrate_disable();
+			cant_migrate();
 
 			if (nbcon_context_try_acquire(ctxt)) {
 				/*
@@ -1119,16 +1077,11 @@ static int nbcon_kthread_func(void *__console)
 				}
 			}
 
-			if (port)
-				spin_unlock_irqrestore(&port->lock, flags);
-			else
-				migrate_enable();
+			con->driver_exit(con, flags);
 		}
 
 		console_srcu_read_unlock(cookie);
 
-		cond_resched();
-
 	} while (backlog);
 
 	goto wait_for_event;
@@ -1214,9 +1167,9 @@ static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
 
 /**
  * nbcon_atomic_emit_one - Print one record for an nbcon console using the
- *					write_atomic() callback
- * @wctxt:			An initialized write context struct to use
- *				for this context
+ *				write_atomic() callback
+ * @wctxt:	An initialized write context struct to use
+ *		for this context
  *
  * Return:	False if the given console could not print a record or there
  *		are no more records to print, otherwise true.
@@ -1248,6 +1201,7 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
  * nbcon_get_default_prio - The appropriate nbcon priority to use for nbcon
  *				printing on the current CPU
  *
+ * Context:	Any context which could not be migrated to another CPU.
  * Return:	The nbcon_prio to use for acquiring an nbcon console in this
  *		context for printing.
  */
@@ -1269,51 +1223,51 @@ enum nbcon_prio nbcon_get_default_prio(void)
  * nbcon_atomic_emit_next_record - Print one record for an nbcon console
  *					using the write_atomic() callback
  * @con:	The console to print on
+ * @handover:	Will be set to true if a printk waiter has taken over the
+ *		console_lock, in which case the caller is no longer holding
+ *		both the console_lock and the SRCU read lock. Otherwise it
+ *		is set to false.
+ * @cookie:	The cookie from the SRCU read lock.
  *
- * Return:	True if a record could be printed, otherwise false.
  * Context:	Any context which could not be migrated to another CPU.
+ * Return:	True if a record could be printed, otherwise false.
  *
  * This function is meant to be called by console_flush_all() to print records
  * on nbcon consoles using the write_atomic() callback. Essentially it is the
  * nbcon version of console_emit_next_record().
  */
-bool nbcon_atomic_emit_next_record(struct console *con)
+bool nbcon_atomic_emit_next_record(struct console *con, bool *handover, int cookie)
 {
-	struct uart_port *port = con->uart_port(con);
-	static DEFINE_SPINLOCK(shared_spinlock);
+	struct nbcon_write_context wctxt = { };
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
+	unsigned long driver_flags;
 	bool progress = false;
-	enum nbcon_prio prio;
 	unsigned long flags;
 
-	/*
-	 * If there is no port lock available, fallback to a shared
-	 * spinlock. This serves to provide the necessary type of
-	 * migration/preemption disabling while printing.
-	 */
-	if (port)
-		spin_lock_irqsave(&port->lock, flags);
-	else
-		spin_lock_irqsave(&shared_spinlock, flags);
+	*handover = false;
 
-	/*
-	 * Do not emit for EMERGENCY priority. The console will be
-	 * explicitly flushed when exiting the emergency section.
-	 */
-	prio = nbcon_get_default_prio();
-	if (prio != NBCON_PRIO_EMERGENCY) {
-		struct nbcon_write_context wctxt = { };
-		struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
-
-		ctxt->console	= con;
-		ctxt->prio	= prio;
-
-		progress = nbcon_atomic_emit_one(&wctxt);
+	/* Use the same locking order as console_emit_next_record(). */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		printk_safe_enter_irqsave(flags);
+		console_lock_spinning_enable();
+		stop_critical_timings();
 	}
 
-	if (port)
-		spin_unlock_irqrestore(&port->lock, flags);
-	else
-		spin_unlock_irqrestore(&shared_spinlock, flags);
+	con->driver_enter(con, &driver_flags);
+	cant_migrate();
+
+	ctxt->console	= con;
+	ctxt->prio	= nbcon_get_default_prio();
+
+	progress = nbcon_atomic_emit_one(&wctxt);
+
+	con->driver_exit(con, driver_flags);
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		start_critical_timings();
+		*handover = console_lock_spinning_disable_and_check(cookie);
+		printk_safe_exit_irqrestore(flags);
+	}
 
 	return progress;
 }
@@ -1328,7 +1282,6 @@ static void __nbcon_atomic_flush_all(u64 stop_seq, bool allow_unsafe_takeover)
 {
 	struct nbcon_write_context wctxt = { };
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
-	enum nbcon_prio prio = nbcon_get_default_prio();
 	struct console *con;
 	bool any_progress;
 	int cookie;
@@ -1339,6 +1292,7 @@ static void __nbcon_atomic_flush_all(u64 stop_seq, bool allow_unsafe_takeover)
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
 			short flags = console_srcu_read_flags(con);
+			unsigned long irq_flags;
 
 			if (!(flags & CON_NBCON))
 				continue;
@@ -1352,10 +1306,26 @@ static void __nbcon_atomic_flush_all(u64 stop_seq, bool allow_unsafe_takeover)
 			memset(ctxt, 0, sizeof(*ctxt));
 			ctxt->console			= con;
 			ctxt->spinwait_max_us		= 2000;
-			ctxt->prio			= prio;
 			ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
 
+			/*
+			 * Atomic flushing does not use console driver
+			 * synchronization (i.e. it does not hold the port
+			 * lock for uart consoles). Therefore IRQs must be
+			 * disabled to avoid being interrupted and then
+			 * calling into a driver that will deadlock trying
+			 * acquire console ownership.
+			 *
+			 * This also disables migration in order to get the
+			 * current CPU priority.
+			 */
+			local_irq_save(irq_flags);
+
+			ctxt->prio = nbcon_get_default_prio();
+
 			any_progress |= nbcon_atomic_emit_one(&wctxt);
+
+			local_irq_restore(irq_flags);
 		}
 		console_srcu_read_unlock(cookie);
 	} while (any_progress);
@@ -1368,8 +1338,6 @@ static void __nbcon_atomic_flush_all(u64 stop_seq, bool allow_unsafe_takeover)
  * Flush the backlog up through the currently newest record. Any new
  * records added while flushing will not be flushed. This is to avoid
  * one CPU printing unbounded because other CPUs continue to add records.
- *
- * Context:	Any context which could not be migrated to another CPU.
  */
 void nbcon_atomic_flush_all(void)
 {
@@ -1382,8 +1350,6 @@ void nbcon_atomic_flush_all(void)
  *
  * Flush the backlog up through the currently newest record. Unsafe hostile
  * takeovers will be performed, if necessary.
- *
- * Context:	Any context which could not be migrated to another CPU.
  */
 void nbcon_atomic_flush_unsafe(void)
 {
@@ -1424,18 +1390,22 @@ void nbcon_cpu_emergency_enter(void)
 void nbcon_cpu_emergency_exit(void)
 {
 	unsigned int *cpu_emergency_nesting;
+	bool do_trigger_flush = false;
 
 	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
 
 	WARN_ON_ONCE(*cpu_emergency_nesting == 0);
 
 	if (*cpu_emergency_nesting == 1)
-		printk_trigger_flush();
+		do_trigger_flush = true;
 
 	/* Undo the nesting count of nbcon_cpu_emergency_enter(). */
 	(*cpu_emergency_nesting)--;
 
 	preempt_enable();
+
+	if (do_trigger_flush)
+		printk_trigger_flush();
 }
 
 /**
@@ -1596,7 +1566,7 @@ static inline bool uart_is_nbcon(struct uart_port *up)
 }
 
 /**
- * nbcon_handle_port_lock - The second half of the port locking wrapper
+ * nbcon_acquire - The second half of the port locking wrapper
  * @up:		The uart port whose @lock was locked
  *
  * The uart_port_lock() wrappers will first lock the spin_lock @up->lock.
@@ -1608,7 +1578,7 @@ static inline bool uart_is_nbcon(struct uart_port *up)
  * nbcon consoles acquired via the port lock wrapper always use priority
  * NBCON_PRIO_NORMAL.
  */
-void nbcon_handle_port_lock(struct uart_port *up)
+void nbcon_acquire(struct uart_port *up)
 {
 	struct console *con = up->cons;
 	struct nbcon_context ctxt;
@@ -1629,10 +1599,10 @@ void nbcon_handle_port_lock(struct uart_port *up)
 
 	con->locked_port = true;
 }
-EXPORT_SYMBOL_GPL(nbcon_handle_port_lock);
+EXPORT_SYMBOL_GPL(nbcon_acquire);
 
 /**
- * nbcon_handle_port_unlock - The first half of the port unlocking wrapper
+ * nbcon_release - The first half of the port unlocking wrapper
  * @up:		The uart port whose @lock is about to be unlocked
  *
  * The uart_port_unlock() wrappers will first call this function to implement
@@ -1645,7 +1615,7 @@ EXPORT_SYMBOL_GPL(nbcon_handle_port_lock);
  * nbcon consoles acquired via the port lock wrapper always use priority
  * NBCON_PRIO_NORMAL.
  */
-void nbcon_handle_port_unlock(struct uart_port *up)
+void nbcon_release(struct uart_port *up)
 {
 	struct console *con = up->cons;
 	struct nbcon_context ctxt = {
@@ -1653,17 +1623,15 @@ void nbcon_handle_port_unlock(struct uart_port *up)
 		.prio		= NBCON_PRIO_NORMAL,
 	};
 
-	if (!uart_is_nbcon(up))
+	if (!con->locked_port)
 		return;
 
-	WARN_ON_ONCE(!con->locked_port);
-
 	if (nbcon_context_exit_unsafe(&ctxt))
 		nbcon_context_release(&ctxt);
 
 	con->locked_port = false;
 }
-EXPORT_SYMBOL_GPL(nbcon_handle_port_unlock);
+EXPORT_SYMBOL_GPL(nbcon_release);
 
 /**
  * printk_kthread_shutdown - shutdown all threaded printers
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index cff34b06fabfa..ddf79752c80cf 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -470,6 +470,13 @@ static DEFINE_MUTEX(syslog_lock);
  */
 bool have_legacy_console;
 
+/*
+ * Specifies if an nbcon console is registered. If nbcon consoles are present,
+ * synchronous printing of legacy consoles will not occur during panic until
+ * the backtrace has been stored to the ringbuffer.
+ */
+bool have_nbcon_console;
+
 /*
  * Specifies if a boot console is registered. If boot consoles are present,
  * nbcon consoles cannot print simultaneously and must be synchronized by
@@ -479,12 +486,6 @@ bool have_legacy_console;
 bool have_boot_console;
 
 #ifdef CONFIG_PRINTK
-/*
- * During panic, heavy printk by other CPUs can delay the
- * panic and risk deadlock on console resources.
- */
-static int __read_mostly suppress_panic_printk;
-
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 
 static DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
@@ -1888,7 +1889,7 @@ static bool console_waiter;
  * there may be a waiter spinning (like a spinlock). Also it must be
  * ready to hand over the lock at the end of the section.
  */
-static void console_lock_spinning_enable(void)
+void console_lock_spinning_enable(void)
 {
 	/*
 	 * Do not use spinning in panic(). The panic CPU wants to keep the lock.
@@ -1927,7 +1928,7 @@ static void console_lock_spinning_enable(void)
  *
  * Return: 1 if the lock rights were passed, 0 otherwise.
  */
-static int console_lock_spinning_disable_and_check(int cookie)
+int console_lock_spinning_disable_and_check(int cookie)
 {
 	int waiter;
 
@@ -2332,35 +2333,36 @@ int vprintk_store(int facility, int level,
 	return ret;
 }
 
+static bool legacy_allow_panic_sync;
+
+/*
+ * This acts as a one-way switch to allow legacy consoles to print from
+ * the printk() caller context on a panic CPU.
+ */
+void printk_legacy_allow_panic_sync(void)
+{
+	legacy_allow_panic_sync = true;
+}
+
 asmlinkage int vprintk_emit(int facility, int level,
 			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
 {
-	static atomic_t panic_noise_count = ATOMIC_INIT(0);
-
-	bool do_trylock_unlock = printing_via_unlock && !IS_ENABLED(CONFIG_PREEMPT_RT);
+	bool do_trylock_unlock = printing_via_unlock &&
+				 !IS_ENABLED(CONFIG_PREEMPT_RT);
 	int printed_len;
 
 	/* Suppress unimportant messages after panic happens */
 	if (unlikely(suppress_printk))
 		return 0;
 
-	if (other_cpu_in_panic()) {
-		if (unlikely(suppress_panic_printk))
-			return 0;
-
-		/*
-		 * The messages on the panic CPU are the most important. If
-		 * non-panic CPUs are generating many messages, the panic
-		 * messages could get lost. Limit the number of non-panic
-		 * messages to approximately 1/4 of the ringbuffer.
-		 */
-		if (atomic_inc_return_relaxed(&panic_noise_count) >
-		    (1 << (prb->desc_ring.count_bits - 2))) {
-			suppress_panic_printk = 1;
-			return 0;
-		}
-	}
+	/*
+	 * The messages on the panic CPU are the most important. If
+	 * non-panic CPUs are generating any messages, they will be
+	 * silently dropped.
+	 */
+	if (other_cpu_in_panic())
+		return 0;
 
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
@@ -2372,29 +2374,40 @@ asmlinkage int vprintk_emit(int facility, int level,
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
-	/*
-	 * There are 3 situations where nbcon atomic printing should happen in
-	 * the printk() caller context:
-	 *
-	 * 1. When booting, before the printing threads have been started.
-	 *
-	 * 2. During shutdown, since the printing threads may not get a
-	 *    chance to print the final messages.
-	 *
-	 * 3. When this CPU is in panic.
-	 *
-	 * Note that if boot consoles are registered (have_boot_console), the
-	 * console_lock/console_unlock dance must be relied upon instead
-	 * because nbcon consoles cannot print simultaneously with boot
-	 * consoles.
-	 */
-	if (!have_boot_console) {
-		if (!printk_threads_enabled ||
-		    (system_state > SYSTEM_RUNNING) ||
-		    this_cpu_in_panic()) {
-			preempt_disable();
+	if (!have_boot_console && have_nbcon_console) {
+		bool is_panic_context = this_cpu_in_panic();
+
+		/*
+		 * In panic, the legacy consoles are not allowed to print from
+		 * the printk calling context unless explicitly allowed. This
+		 * gives the safe nbcon consoles a chance to print out all the
+		 * panic messages first. This restriction only applies if
+		 * there are nbcon consoles registered.
+		 */
+		if (is_panic_context)
+			do_trylock_unlock &= legacy_allow_panic_sync;
+
+		/*
+		 * There are situations where nbcon atomic printing should
+		 * happen in the printk() caller context:
+		 *
+		 * - When this CPU is in panic.
+		 *
+		 * - When booting, before the printing threads have been
+		 *   started.
+		 *
+		 * - During shutdown, since the printing threads may not get
+		 *   a chance to print the final messages.
+		 *
+		 * Note that if boot consoles are registered, the
+		 * console_lock/console_unlock dance must be relied upon
+		 * instead because nbcon consoles cannot print simultaneously
+		 * with boot consoles.
+		 */
+		if (is_panic_context ||
+		    !printk_threads_enabled ||
+		    (system_state > SYSTEM_RUNNING)) {
 			nbcon_atomic_flush_all();
-			preempt_enable();
 		}
 	}
 
@@ -2407,9 +2420,18 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 * printing of all remaining records to all consoles so that
 		 * this context can return as soon as possible. Hopefully
 		 * another printk() caller will take over the printing.
+		 *
+		 * Also, nbcon_get_default_prio() requires migration disabled.
 		 */
 		preempt_disable();
-		if (nbcon_get_default_prio() != NBCON_PRIO_EMERGENCY) {
+
+		/*
+		 * Do not emit for EMERGENCY priority. The console will be
+		 * explicitly flushed when exiting the emergency section.
+		 */
+		if (nbcon_get_default_prio() == NBCON_PRIO_EMERGENCY) {
+			do_trylock_unlock = false;
+		} else {
 			/*
 			 * Try to acquire and then immediately release the
 			 * console semaphore. The release will print out
@@ -2420,13 +2442,15 @@ asmlinkage int vprintk_emit(int facility, int level,
 			if (console_trylock_spinning())
 				console_unlock();
 		}
-		preempt_enable();
 
-		wake_up_klogd();
-	} else {
-		defer_console_output();
+		preempt_enable();
 	}
 
+	if (do_trylock_unlock)
+		wake_up_klogd();
+	else
+		defer_console_output();
+
 	return printed_len;
 }
 EXPORT_SYMBOL(vprintk_emit);
@@ -2473,6 +2497,7 @@ static u64 syslog_seq;
 
 static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
+
 static inline void nbcon_legacy_kthread_create(void) { }
 static inline void wake_up_legacy_kthread(void) { }
 #endif /* CONFIG_PRINTK */
@@ -2704,7 +2729,6 @@ void resume_console(void)
 	 * Since this runs in task context, wake the threaded printers
 	 * directly rather than scheduling irq_work to do it.
 	 */
-
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(con) {
 		flags = console_srcu_read_flags(con);
@@ -2793,6 +2817,8 @@ static void __console_unlock(void)
 	up_console_sem();
 }
 
+static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
+
 #ifdef CONFIG_PRINTK
 
 /*
@@ -2955,7 +2981,18 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 		con->dropped = 0;
 	}
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	/* Write everything out to the hardware. */
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		/*
+		 * On PREEMPT_RT this function is either in a thread or
+		 * panic context. So there is no need for concern about
+		 * printk reentrance, handovers, or lockdep complaints.
+		 */
+
+		con->write(con, outbuf, pmsg.outbuf_len);
+		con->seq = pmsg.seq + 1;
+	} else {
 		/*
 		 * While actively printing out messages, if another printk()
 		 * were to occur on another CPU, it may wait for this one to
@@ -2971,20 +3008,16 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 
 		/* Do not trace print latency. */
 		stop_critical_timings();
-	}
 
-	/* Write everything out to the hardware. */
-	con->write(con, outbuf, pmsg.outbuf_len);
+		lock_map_acquire_try(&printk_legacy_map);
+		con->write(con, outbuf, pmsg.outbuf_len);
+		lock_map_release(&printk_legacy_map);
 
-	con->seq = pmsg.seq + 1;
-
-	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		*handover = false;
-	} else {
 		start_critical_timings();
 
-		*handover = console_lock_spinning_disable_and_check(cookie);
+		con->seq = pmsg.seq + 1;
 
+		*handover = console_lock_spinning_disable_and_check(cookie);
 		printk_safe_exit_irqrestore(flags);
 	}
 skip:
@@ -3055,21 +3088,25 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			any_usable = true;
 
 			if (flags & CON_NBCON) {
-				progress = nbcon_atomic_emit_next_record(con);
+
+				lock_map_acquire_try(&printk_legacy_map);
+				progress = nbcon_atomic_emit_next_record(con, handover, cookie);
+				lock_map_release(&printk_legacy_map);
+
 				printk_seq = nbcon_seq_read(con);
 			} else {
 				progress = console_emit_next_record(con, handover, cookie);
 
-				/*
-				 * If a handover has occurred, the SRCU read
-				 * lock is already released.
-				 */
-				if (*handover)
-					return false;
-
 				printk_seq = con->seq;
 			}
 
+			/*
+			 * If a handover has occurred, the SRCU read lock
+			 * is already released.
+			 */
+			if (*handover)
+				return false;
+
 			/* Track the next of the highest seq flushed. */
 			if (printk_seq > *next_seq)
 				*next_seq = printk_seq;
@@ -3095,7 +3132,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	return false;
 }
 
-static u64 console_flush_and_unlock(void)
+static void console_flush_and_unlock(void)
 {
 	bool do_cond_resched;
 	bool handover;
@@ -3138,8 +3175,6 @@ static u64 console_flush_and_unlock(void)
 		 * fails, another context is already handling the printing.
 		 */
 	} while (prb_read_valid(prb, next_seq, NULL) && console_trylock());
-
-	return next_seq;
 }
 
 /**
@@ -3300,8 +3335,7 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		console_srcu_read_unlock(cookie);
 	}
 
-	if (!have_boot_console)
-		nbcon_atomic_flush_all();
+	nbcon_atomic_flush_all();
 
 	if (printing_via_unlock)
 		console_flush_all(false, &next_seq, &handover);
@@ -3385,7 +3419,7 @@ void console_start(struct console *console)
 EXPORT_SYMBOL(console_start);
 
 #ifdef CONFIG_PRINTK
-static bool printer_should_wake(u64 seq)
+static bool printer_should_wake(void)
 {
 	bool available = false;
 	struct console *con;
@@ -3431,11 +3465,10 @@ static bool printer_should_wake(u64 seq)
 
 static int nbcon_legacy_kthread_func(void *unused)
 {
-	u64 seq = 0;
 	int error;
 
 	for (;;) {
-		error = wait_event_interruptible(legacy_wait, printer_should_wake(seq));
+		error = wait_event_interruptible(legacy_wait, printer_should_wake());
 
 		if (kthread_should_stop())
 			break;
@@ -3444,8 +3477,9 @@ static int nbcon_legacy_kthread_func(void *unused)
 			continue;
 
 		console_lock();
-		seq = console_flush_and_unlock();
+		console_flush_and_unlock();
 	}
+
 	return 0;
 }
 
@@ -3608,11 +3642,20 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 
 				newcon->seq = prb_next_seq(prb);
 				for_each_console(con) {
-					if ((con->flags & CON_BOOT) &&
-					    (con->flags & CON_ENABLED) &&
-					    con->seq < newcon->seq) {
-						newcon->seq = con->seq;
+					u64 seq;
+
+					if (!((con->flags & CON_BOOT) &&
+					      (con->flags & CON_ENABLED))) {
+						continue;
 					}
+
+					if (con->flags & CON_NBCON)
+						seq = nbcon_seq_read(con);
+					else
+						seq = con->seq;
+
+					if (seq < newcon->seq)
+						newcon->seq = seq;
 				}
 			}
 
@@ -3730,6 +3773,7 @@ void register_console(struct console *newcon)
 	console_init_seq(newcon, bootcon_registered);
 
 	if (newcon->flags & CON_NBCON) {
+		have_nbcon_console = true;
 		nbcon_init(newcon);
 	} else {
 		have_legacy_console = true;
@@ -3791,8 +3835,10 @@ EXPORT_SYMBOL(register_console);
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {
-	bool is_legacy_con = !(console->flags & CON_NBCON);
 	bool is_boot_con = (console->flags & CON_BOOT);
+	bool found_legacy_con = false;
+	bool found_nbcon_con = false;
+	bool found_boot_con = false;
 	struct console *c;
 	int res;
 
@@ -3842,24 +3888,24 @@ static int unregister_console_locked(struct console *console)
 		res = console->exit(console);
 
 	/*
-	 * If this console was a boot and/or legacy console, the
-	 * related global flags might need to be updated.
+	 * With this console gone, the global flags tracking registered
+	 * console types may have changed. Update them.
 	 */
-	if (is_boot_con || is_legacy_con) {
-		bool found_legacy_con = false;
-		bool found_boot_con = false;
+	for_each_console(c) {
+		if (c->flags & CON_BOOT)
+			found_boot_con = true;
 
-		for_each_console(c) {
-			if (c->flags & CON_BOOT)
-				found_boot_con = true;
-			if (!(c->flags & CON_NBCON))
-				found_legacy_con = true;
-		}
-		if (!found_boot_con)
-			have_boot_console = false;
-		if (!found_legacy_con)
-			have_legacy_console = false;
+		if (c->flags & CON_NBCON)
+			found_nbcon_con = true;
+		else
+			found_legacy_con = true;
 	}
+	if (!found_boot_con)
+		have_boot_console = false;
+	if (!found_legacy_con)
+		have_legacy_console = false;
+	if (!found_nbcon_con)
+		have_nbcon_console = false;
 
 	/*
 	 * When the last boot console unregisters, start up the
@@ -4233,22 +4279,8 @@ void defer_console_output(void)
 	__wake_up_klogd(val);
 }
 
-/**
- * printk_trigger_flush() - Make sure that the consoles will get flushed
- *
- * Try to flush consoles when possible or queue flushing consoles like
- * in the deferred printk.
- *
- * Context: Can be used in any context
- */
 void printk_trigger_flush(void)
 {
-	if (!have_boot_console) {
-		preempt_disable();
-		nbcon_atomic_flush_all();
-		preempt_enable();
-	}
-
 	nbcon_wake_threads();
 	defer_console_output();
 }
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 2b2a85222d19d..e7b808b829a04 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1457,33 +1457,6 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
 	return false;
 }
 
-#ifdef CONFIG_64BIT
-
-#define __u64seq_to_ulseq(u64seq) (u64seq)
-#define __ulseq_to_u64seq(ulseq) (ulseq)
-
-#else /* CONFIG_64BIT */
-
-static u64 prb_first_seq(struct printk_ringbuffer *rb);
-
-#define __u64seq_to_ulseq(u64seq) ((u32)u64seq)
-static inline u64 __ulseq_to_u64seq(u32 ulseq)
-{
-	u64 rb_first_seq = prb_first_seq(prb);
-	u64 seq;
-
-	/*
-	 * The provided sequence is only the lower 32 bits of the ringbuffer
-	 * sequence. It needs to be expanded to 64bit. Get the first sequence
-	 * number from the ringbuffer and fold it.
-	 */
-	seq = rb_first_seq - ((s32)((u32)rb_first_seq - ulseq));
-
-	return seq;
-}
-
-#endif /* CONFIG_64BIT */
-
 /*
  * @last_finalized_seq value guarantees that all records up to and including
  * this sequence number are finalized and can be read. The only exception are
@@ -1501,8 +1474,9 @@ static inline u64 __ulseq_to_u64seq(u32 ulseq)
  * directly print or trigger deferred printing of all available unprinted
  * records, all printk() messages will get printed.
  */
-static u64 desc_last_finalized_seq(struct prb_desc_ring *desc_ring)
+static u64 desc_last_finalized_seq(struct printk_ringbuffer *rb)
 {
+	struct prb_desc_ring *desc_ring = &rb->desc_ring;
 	unsigned long ulseq;
 
 	/*
@@ -1513,7 +1487,7 @@ static u64 desc_last_finalized_seq(struct prb_desc_ring *desc_ring)
 	ulseq = atomic_long_read_acquire(&desc_ring->last_finalized_seq
 					); /* LMM(desc_last_finalized_seq:A) */
 
-	return __ulseq_to_u64seq(ulseq);
+	return __ulseq_to_u64seq(rb, ulseq);
 }
 
 static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
@@ -1527,7 +1501,7 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 static void desc_update_last_finalized(struct printk_ringbuffer *rb)
 {
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
-	u64 old_seq = desc_last_finalized_seq(desc_ring);
+	u64 old_seq = desc_last_finalized_seq(rb);
 	unsigned long oldval;
 	unsigned long newval;
 	u64 finalized_seq;
@@ -1576,7 +1550,7 @@ static void desc_update_last_finalized(struct printk_ringbuffer *rb)
 	 */
 	if (!atomic_long_try_cmpxchg_release(&desc_ring->last_finalized_seq,
 				&oldval, newval)) { /* LMM(desc_update_last_finalized:A) */
-		old_seq = __ulseq_to_u64seq(oldval);
+		old_seq = __ulseq_to_u64seq(rb, oldval);
 		goto try_again;
 	}
 }
@@ -1883,6 +1857,8 @@ static bool copy_data(struct prb_data_ring *data_ring,
  * descriptor. However, it also verifies that the record is finalized and has
  * the sequence number @seq. On success, 0 is returned.
  *
+ * For the panic CPU, committed descriptors are also considered finalized.
+ *
  * Error return values:
  * -EINVAL: A finalized record with sequence number @seq does not exist.
  * -ENOENT: A finalized record with sequence number @seq exists, but its data
@@ -1901,16 +1877,25 @@ static int desc_read_finalized_seq(struct prb_desc_ring *desc_ring,
 
 	/*
 	 * An unexpected @id (desc_miss) or @seq mismatch means the record
-	 * does not exist. A descriptor in the reserved or committed state
-	 * means the record does not yet exist for the reader.
+	 * does not exist. A descriptor in the reserved state means the
+	 * record does not yet exist for the reader.
 	 */
 	if (d_state == desc_miss ||
 	    d_state == desc_reserved ||
-	    d_state == desc_committed ||
 	    s != seq) {
 		return -EINVAL;
 	}
 
+	/*
+	 * A descriptor in the committed state means the record does not yet
+	 * exist for the reader. However, for the panic CPU, committed
+	 * records are also handled as finalized records since they contain
+	 * message data in a consistent state and may contain additional
+	 * hints as to the cause of the panic.
+	 */
+	if (d_state == desc_committed && !this_cpu_in_panic())
+		return -EINVAL;
+
 	/*
 	 * A descriptor in the reusable state may no longer have its data
 	 * available; report it as existing but with lost data. Or the record
@@ -1969,7 +1954,7 @@ static int prb_read(struct printk_ringbuffer *rb, u64 seq,
 }
 
 /* Get the sequence number of the tail descriptor. */
-static u64 prb_first_seq(struct printk_ringbuffer *rb)
+u64 prb_first_seq(struct printk_ringbuffer *rb)
 {
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
 	enum desc_state d_state;
@@ -2047,7 +2032,7 @@ u64 prb_next_reserve_seq(struct printk_ringbuffer *rb)
 	 */
 
 try_again:
-	last_finalized_seq = desc_last_finalized_seq(desc_ring);
+	last_finalized_seq = desc_last_finalized_seq(rb);
 
 	/*
 	 * @head_id is loaded after @last_finalized_seq to ensure that it is
@@ -2088,14 +2073,22 @@ u64 prb_next_reserve_seq(struct printk_ringbuffer *rb)
 			 * value. Probably no record has been finalized yet.
 			 * This means the ringbuffer is not yet full and the
 			 * @head_id value can be used directly (subtracting
-			 * off its initial value).
-			 *
+			 * off the id value corresponding to seq=0).
+			 */
+
+			/*
 			 * Because of hack#2 of the bootstrapping phase, the
 			 * @head_id initial value must be handled separately.
 			 */
 			if (head_id == DESC0_ID(desc_ring->count_bits))
 				return 0;
 
+			/*
+			 * The @head_id is initialized such that the first
+			 * increment will yield the first record (seq=0).
+			 * Therefore use the initial value +1 as the base to
+			 * subtract from @head_id.
+			 */
 			last_finalized_id = DESC0_ID(desc_ring->count_bits) + 1;
 		} else {
 			/* Record must have been overwritten. Try again. */
@@ -2103,8 +2096,17 @@ u64 prb_next_reserve_seq(struct printk_ringbuffer *rb)
 		}
 	}
 
+	/*
+	 * @diff is the number of records beyond the last record available
+	 * to readers.
+	 */
 	diff = head_id - last_finalized_id;
 
+	/*
+	 * @head_id points to the most recently reserved record, but this
+	 * function returns the sequence number that will be assigned to the
+	 * next (not yet reserved) record. Thus +1 is needed.
+	 */
 	return (last_finalized_seq + diff + 1);
 }
 
@@ -2153,6 +2155,12 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			 * non-existent/non-finalized record unless it is
 			 * at or beyond the head, in which case it is not
 			 * possible to continue.
+			 *
+			 * Note that new messages printed on panic CPU are
+			 * finalized when we are here. The only exception
+			 * might be the last message without trailing newline.
+			 * But it would have the sequence number returned
+			 * by "prb_next_reserve_seq() - 1".
 			 */
 			if (this_cpu_in_panic() && ((*seq + 1) < prb_next_reserve_seq(rb)))
 				(*seq)++;
@@ -2271,10 +2279,9 @@ u64 prb_first_valid_seq(struct printk_ringbuffer *rb)
  */
 u64 prb_next_seq(struct printk_ringbuffer *rb)
 {
-	struct prb_desc_ring *desc_ring = &rb->desc_ring;
 	u64 seq;
 
-	seq = desc_last_finalized_seq(desc_ring);
+	seq = desc_last_finalized_seq(rb);
 
 	/*
 	 * Begin searching after the last finalized record.
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index b48b44ecbe6da..52626d0f1fa37 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -392,8 +392,41 @@ bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
 bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 			 struct printk_info *info, unsigned int *line_count);
 
+u64 prb_first_seq(struct printk_ringbuffer *rb);
 u64 prb_first_valid_seq(struct printk_ringbuffer *rb);
 u64 prb_next_seq(struct printk_ringbuffer *rb);
 u64 prb_next_reserve_seq(struct printk_ringbuffer *rb);
 
+#ifdef CONFIG_64BIT
+
+#define __u64seq_to_ulseq(u64seq) (u64seq)
+#define __ulseq_to_u64seq(rb, ulseq) (ulseq)
+
+#else /* CONFIG_64BIT */
+
+#define __u64seq_to_ulseq(u64seq) ((u32)u64seq)
+
+static inline u64 __ulseq_to_u64seq(struct printk_ringbuffer *rb, u32 ulseq)
+{
+	u64 rb_first_seq = prb_first_seq(rb);
+	u64 seq;
+
+	/*
+	 * The provided sequence is only the lower 32 bits of the ringbuffer
+	 * sequence. It needs to be expanded to 64bit. Get the first sequence
+	 * number from the ringbuffer and fold it.
+	 *
+	 * Having a 32bit representation in the console is sufficient.
+	 * If a console ever gets more than 2^31 records behind
+	 * the ringbuffer then this is the least of the problems.
+	 *
+	 * Also the access to the ring buffer is always safe.
+	 */
+	seq = rb_first_seq - (s32)((u32)rb_first_seq - ulseq);
+
+	return seq;
+}
+
+#endif /* CONFIG_64BIT */
+
 #endif /* _KERNEL_PRINTK_RINGBUFFER_H */
diff --git a/localversion-rt b/localversion-rt
index 1e584b47c987e..9e7cd66d9f44f 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt17
+-rt18


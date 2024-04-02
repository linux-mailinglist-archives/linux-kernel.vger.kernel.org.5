Return-Path: <linux-kernel+bounces-128218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1115B8957D0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DCF1F2238D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680C412BF1A;
	Tue,  2 Apr 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iyq2tbwW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Zn7Koxo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49008126F16;
	Tue,  2 Apr 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070538; cv=none; b=BmVZkX6+5L8r4vLyyp2k+VW1FAgXH1r7acW/x/mNNoNu1TySqkokNORaLTRtOnS37+nIQdy7wbB28K07y2OLSgvnLkicNSG7g/mGBsfX8bp77mnCPyeFsZN0wb/kBTj1Gzxn5nkDrRDL/DZD2Yez8O8rzd94KikO9u0brwL0ysQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070538; c=relaxed/simple;
	bh=kkFsLeXE34/n0kUK6N/w/hcBiNmgolXog8JvLJO1Skg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PV2VePvwqSvVG5JITyfnaoEtzTcgiXDiqo8DhAht8tqIt3UGtPNXhsSUOa09MZRUhXPCZNk3EDjI+FaLq4/FWhIFdxEjJ8TJu1i+jIUKOD4K5pl/aze/n6pEFreJ1pDjW1ynLoiE1gJ9V4+s4a+nmFdp5Zj7yIM9jm5XVZYMrxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iyq2tbwW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Zn7Koxo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 2 Apr 2024 17:08:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712070532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RTEczz/h3EadLT+0SGxv6Q+6uh3ZlSKpDV+Uq3HrLwU=;
	b=Iyq2tbwWOeP3A/SPoh/7YwtN+SMD4TggnxfFjKCZDKS0sBqRjatz+FS9Mm9K5NiFeVpQmw
	HNzwVDUx0OAVO4Adw8rfJtX0X1spHb9tLMORFn9Na2kmha1l+Ud/p2vq+4HLrrG2M40DXS
	E43OWmzLhR3Ut0QwHP07rjyT0ZdZZ5HN3FFSAYDpMqyLLCViyrFofWg8vLBQva0uUjtgeE
	kCzit13M9BrGB+IHk+blYz/fkkRm3IlhwbFR3pClYUiVBTelhg00NHZnV3mU4qpBLxkcqO
	ou5rkzRwMm0KaadGc+qN3yWtoo+vnEiBPv0/GdcZLZffgnFhNjkTgF8LFF0PEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712070532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RTEczz/h3EadLT+0SGxv6Q+6uh3ZlSKpDV+Uq3HrLwU=;
	b=9Zn7KoxopUxVC0zt9BrWWrkAim1NYPsjq29b5TqdhTY2OnLSgARU4DyfBoFohD/+QGFkO6
	yHkBZxU/oPgmKhBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.8.2-rt10
Message-ID: <20240402150851.UCzI_vtV@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.8.2-rt10 patch set. 

Changes since v6.8.2-rt9:

  - Update of the printk series by John Ogness:

    - remove return value for write_thread()/write_atomic() nbcon callbacks
      (use struct nbcon_write_context @outbuf to determine if ownership was
      lost while in a nbcon printing callback).
    
    - rename driver_enter()/driver_exit() nbcon callbacks to
      device_lock()/device_unlock().
    
    - add a WARN_ON_ONCE if 8250 console is running in rs485 mode.
    
    - introduce a new struct nbcon_drvdata to track nbcon ownership for
      non-printing activities (and remove the @nbcon_locked_port flag that
      was used for this purpose in a racy way).
    
    - synchronize setting of struct uart_port @cons to avoid possible races
      when handling uart ports that may be in the process of registering or
      unregistering.
    
    - print a message "** replaying previous printk message **" if a console
      printer is interrupted by a higher priority printer and the
      interrupted message is reprinted.
    
    - mark all lockdep splats as emergency sections.
    
    - mark all rcu stall splats as emergency sections.
    
    - fixup nbcon sequence number initialization.
    
    - for atomic flushing, flush an nbcon completely before flushing the
      next console (and maintain console ownership throughout the atomic
      flushing).
    
    - when exiting the emergency state, flush the nbcon atomic consoles
      directly.
    
    - during panic, try to flush the legacy consoles directly rather than
      relying on irq_work.
    
    - for nbcon atomic consoles, lock the device when transitioning to
      registered status.
    
    - add a compiler barrier to pr_flush() to ensure the compiler does not
      optimize variable usage in a racy way.

Known issues
    None.

The delta patch against v6.8.2-rt9 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/incr/patch-6.8.2-rt9-rt10.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.8.2-rt10

The RT patch against v6.8.2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/older/patch-6.8.2-rt10.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/older/patches-6.8.2-rt10.tar.xz

Sebastian

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ae637155fe7cd..4e4f5501d81da 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -601,35 +601,37 @@ static void univ8250_console_write(struct console *co, const char *s,
 	serial8250_console_write(up, s, count);
 }
 #else
-static bool univ8250_console_write_atomic(struct console *co,
+static void univ8250_console_write_atomic(struct console *co,
 					  struct nbcon_write_context *wctxt)
 {
 	struct uart_8250_port *up = &serial8250_ports[co->index];
 
-	return serial8250_console_write_atomic(up, wctxt);
+	serial8250_console_write_atomic(up, wctxt);
 }
 
-static bool univ8250_console_write_thread(struct console *co,
+static void univ8250_console_write_thread(struct console *co,
 					  struct nbcon_write_context *wctxt)
 {
 	struct uart_8250_port *up = &serial8250_ports[co->index];
 
-	return serial8250_console_write_thread(up, wctxt);
+	serial8250_console_write_thread(up, wctxt);
 }
 
-static void univ8250_console_driver_enter(struct console *con, unsigned long *flags)
+static void univ8250_console_device_lock(struct console *con, unsigned long *flags)
 {
 	struct uart_port *up = &serial8250_ports[con->index].port;
 
 	__uart_port_lock_irqsave(up, flags);
 }
 
-static void univ8250_console_driver_exit(struct console *con, unsigned long flags)
+static void univ8250_console_device_unlock(struct console *con, unsigned long flags)
 {
 	struct uart_port *up = &serial8250_ports[con->index].port;
 
 	__uart_port_unlock_irqrestore(up, flags);
 }
+
+static struct nbcon_drvdata serial8250_nbcon_drvdata;
 #endif /* CONFIG_SERIAL_8250_LEGACY_CONSOLE */
 
 static int univ8250_console_setup(struct console *co, char *options)
@@ -659,11 +661,11 @@ static int univ8250_console_setup(struct console *co, char *options)
 
 	port = &serial8250_ports[co->index].port;
 	/* link port to console */
-	port->cons = co;
+	uart_port_set_cons(port, co);
 
 	retval = serial8250_console_setup(port, options, false);
 	if (retval != 0)
-		port->cons = NULL;
+		uart_port_set_cons(port, NULL);
 	return retval;
 }
 
@@ -721,7 +723,7 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 			continue;
 
 		co->index = i;
-		port->cons = co;
+		uart_port_set_cons(port, co);
 		return serial8250_console_setup(port, options, true);
 	}
 
@@ -736,9 +738,10 @@ static struct console univ8250_console = {
 #else
 	.write_atomic	= univ8250_console_write_atomic,
 	.write_thread	= univ8250_console_write_thread,
-	.driver_enter	= univ8250_console_driver_enter,
-	.driver_exit	= univ8250_console_driver_exit,
+	.device_lock	= univ8250_console_device_lock,
+	.device_unlock	= univ8250_console_device_unlock,
 	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_NBCON,
+	.nbcon_drvdata	= &serial8250_nbcon_drvdata,
 #endif
 	.device		= uart_console_device,
 	.setup		= univ8250_console_setup,
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f799c34f1603c..ed50b434d8c80 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -551,8 +551,10 @@ static int serial8250_em485_init(struct uart_8250_port *p)
 		return -ENOMEM;
 
 #ifndef CONFIG_SERIAL_8250_LEGACY_CONSOLE
-	if (uart_console(&p->port))
+	if (uart_console(&p->port)) {
 		dev_warn(p->port.dev, "no atomic printing for rs485 consoles\n");
+		p->port.cons->write_atomic = NULL;
+	}
 #endif
 
 	hrtimer_init(&p->em485->stop_tx_timer, CLOCK_MONOTONIC,
@@ -3293,7 +3295,6 @@ void serial8250_init_port(struct uart_8250_port *up)
 	struct uart_port *port = &up->port;
 
 	spin_lock_init(&port->lock);
-	port->nbcon_locked_port = false;
 	port->ctrl_id = 0;
 	port->pm = NULL;
 	port->ops = &serial8250_pops;
@@ -3497,18 +3498,17 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		uart_port_unlock_irqrestore(port, flags);
 }
 #else
-bool serial8250_console_write_thread(struct uart_8250_port *up,
+void serial8250_console_write_thread(struct uart_8250_port *up,
 				     struct nbcon_write_context *wctxt)
 {
 	struct uart_8250_em485 *em485 = up->em485;
 	struct uart_port *port = &up->port;
-	bool done = false;
 	unsigned int ier;
 
 	touch_nmi_watchdog();
 
 	if (!nbcon_enter_unsafe(wctxt))
-		return false;
+		return;
 
 	/* First save IER then disable the interrupts. */
 	ier = serial_port_in(port, UART_IER);
@@ -3554,7 +3554,6 @@ bool serial8250_console_write_thread(struct uart_8250_port *up,
 				break;
 			}
 		}
-		done = (i == len);
 	} else {
 		nbcon_reacquire(wctxt);
 	}
@@ -3580,24 +3579,23 @@ bool serial8250_console_write_thread(struct uart_8250_port *up,
 	if (up->msr_saved_flags)
 		serial8250_modem_status(up);
 
-	/* Success if no handover/takeover and message fully printed. */
-	return (nbcon_exit_unsafe(wctxt) && done);
+	nbcon_exit_unsafe(wctxt);
 }
 
-bool serial8250_console_write_atomic(struct uart_8250_port *up,
+void serial8250_console_write_atomic(struct uart_8250_port *up,
 				     struct nbcon_write_context *wctxt)
 {
 	struct uart_port *port = &up->port;
 	unsigned int ier;
 
 	/* Atomic console not supported for rs485 mode. */
-	if (up->em485)
-		return false;
+	if (WARN_ON_ONCE(up->em485))
+		return;
 
 	touch_nmi_watchdog();
 
 	if (!nbcon_enter_unsafe(wctxt))
-		return false;
+		return;
 
 	/*
 	 * First save IER then disable the interrupts. The special variant to
@@ -3621,8 +3619,7 @@ bool serial8250_console_write_atomic(struct uart_8250_port *up,
 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
 	serial_port_out(port, UART_IER, ier);
 
-	/* Success if no handover/takeover. */
-	return nbcon_exit_unsafe(wctxt);
+	nbcon_exit_unsafe(wctxt);
 }
 #endif /* CONFIG_SERIAL_8250_LEGACY_CONSOLE */
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 2fa3fb30dc6c7..7618a5783adbc 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2488,7 +2488,7 @@ static int pl011_console_match(struct console *co, char *name, int idx,
 			continue;
 
 		co->index = i;
-		port->cons = co;
+		uart_port_set_cons(port, co);
 		return pl011_console_setup(co, options);
 	}
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d6a58a9e072a1..2652b4d5c944d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3146,7 +3146,7 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	uport->state = state;
 
 	state->pm_state = UART_PM_STATE_UNDEFINED;
-	uport->cons = drv->cons;
+	uart_port_set_cons(uport, drv->cons);
 	uport->minor = drv->tty_driver->minor_start + uport->line;
 	uport->name = kasprintf(GFP_KERNEL, "%s%d", drv->dev_name,
 				drv->tty_driver->name_base + uport->line);
diff --git a/include/linux/console.h b/include/linux/console.h
index 02d6cabbe5009..0b6c122918174 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -284,6 +284,25 @@ struct nbcon_write_context {
 	bool			unsafe_takeover;
 };
 
+/**
+ * struct nbcon_drvdata - Data to allow nbcon acquire in non-print context
+ * @ctxt:		The core console context
+ * @srcu_cookie:	Storage for a console_srcu_lock cookie, if needed
+ * @owner_index:	Storage for the owning console index, if needed
+ * @locked:		Storage for the locked state, if needed
+ *
+ * All fields (except for @ctxt) are available exclusively to the driver to
+ * use as needed. They are not used by the printk subsystem.
+ */
+struct nbcon_drvdata {
+	struct nbcon_context	__private ctxt;
+
+	/* reserved for driver use */
+	int			srcu_cookie;
+	short			owner_index;
+	bool			locked;
+};
+
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
@@ -306,6 +325,7 @@ struct nbcon_write_context {
  *
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
+ * @nbcon_prev_seq:	Seq num the previous nbcon owner was assigned to print
  * @pbufs:		Pointer to nbcon private buffer
  * @kthread:		Printer kthread for this console
  * @rcuwait:		RCU-safe wait object for @kthread waking
@@ -335,7 +355,7 @@ struct console {
 	/**
 	 * @write_atomic:
 	 *
-	 * NBCON callback to write out text in any context. (Optional)
+	 * NBCON callback to write out text in any context.
 	 *
 	 * This callback is called with the console already acquired. The
 	 * callback can use nbcon_can_proceed() at any time to verify that
@@ -359,11 +379,8 @@ struct console {
 	 * This callback can be called from any context (including NMI).
 	 * Therefore it must avoid usage of any locking and instead rely
 	 * on the console ownership for synchronization.
-	 *
-	 * Returns true if all text was successfully written out and
-	 * ownership was never lost, otherwise false.
 	 */
-	bool (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
+	void (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
 
 	/**
 	 * @write_thread:
@@ -372,7 +389,7 @@ struct console {
 	 *
 	 * This callback is called with the console already acquired. Any
 	 * additional driver synchronization should have been performed by
-	 * driver_enter().
+	 * device_lock().
 	 *
 	 * This callback is always called from task context but with migration
 	 * disabled.
@@ -383,60 +400,70 @@ struct console {
 	 * during normal operation and is always called from task context.
 	 * This provides drivers with a relatively relaxed locking context
 	 * for synchronizing output to the hardware.
-	 *
-	 * Returns true if all text was successfully written out, otherwise
-	 * false.
 	 */
-	bool (*write_thread)(struct console *con, struct nbcon_write_context *wctxt);
+	void (*write_thread)(struct console *con, struct nbcon_write_context *wctxt);
 
 	/**
-	 * @driver_enter:
+	 * @device_lock:
 	 *
 	 * NBCON callback to begin synchronization with driver code.
-	 * (Required for NBCON if write_thread is provided)
 	 *
 	 * Console drivers typically must deal with access to the hardware
 	 * via user input/output (such as an interactive login shell) and
 	 * output of kernel messages via printk() calls. This callback is
-	 * called before the kernel begins output via the write_thread()
-	 * callback due to printk() calls. The driver can use this
-	 * callback to acquire some driver lock in order to synchronize
-	 * against user input/output (or any other driver functionality).
+	 * called by the printk-subsystem whenever it needs to synchronize
+	 * with hardware access by the driver. It should be implemented to
+	 * use whatever synchronization mechanism the driver is using for
+	 * itself (for example, the port lock for uart serial consoles).
 	 *
 	 * This callback is always called from task context. It may use any
 	 * synchronization method required by the driver. BUT this callback
-	 * MUST disable migration. The console driver may be using a
-	 * sychronization mechanism that already takes care of this (such as
+	 * MUST also disable migration. The console driver may be using a
+	 * synchronization mechanism that already takes care of this (such as
 	 * spinlocks). Otherwise this function must explicitly call
 	 * migrate_disable().
 	 *
 	 * The flags argument is provided as a convenience to the driver. It
-	 * will be passed again to driver_exit() when printing is completed
+	 * will be passed again to device_unlock() when printing is completed
 	 * (for example, if spin_lock_irqsave() was used). It can be ignored
 	 * if the driver does not need it.
 	 */
-	void (*driver_enter)(struct console *con, unsigned long *flags);
+	void (*device_lock)(struct console *con, unsigned long *flags);
 
 	/**
-	 * @driver_exit:
+	 * @device_unlock:
 	 *
 	 * NBCON callback to finish synchronization with driver code.
-	 * (Required for NBCON if write_thread is provided)
 	 *
-	 * This callback is called after the kernel has finished printing a
-	 * printk message. It is the counterpart to driver_enter().
+	 * It is the counterpart to device_lock().
 	 *
 	 * This callback is always called from task context. It must
-	 * appropriately re-enable migration (depending on how driver_enter()
+	 * appropriately re-enable migration (depending on how device_lock()
 	 * disabled migration).
 	 *
 	 * The flags argument is the value of the same variable that was
-	 * passed to driver_enter().
+	 * passed to device_lock().
 	 */
-	void (*driver_exit)(struct console *con, unsigned long flags);
+	void (*device_unlock)(struct console *con, unsigned long flags);
 
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
+	atomic_long_t           __private nbcon_prev_seq;
+
+	/**
+	 * @nbcon_drvdata:
+	 *
+	 * Data for nbcon ownership tracking to allow acquiring nbcon consoles
+	 * in non-printing contexts.
+	 *
+	 * Drivers may need to acquire nbcon consoles in non-printing
+	 * contexts. This is achieved by providing a struct nbcon_drvdata.
+	 * Then the driver can call nbcon_driver_acquire() and
+	 * nbcon_driver_release(). The struct does not require any special
+	 * initialization.
+	 */
+	struct nbcon_drvdata	*nbcon_drvdata;
+
 	struct printk_buffers	*pbufs;
 	struct task_struct	*kthread;
 	struct rcuwait		rcuwait;
@@ -469,28 +496,29 @@ extern void console_list_unlock(void) __releases(console_mutex);
 extern struct hlist_head console_list;
 
 /**
- * console_srcu_read_flags - Locklessly read the console flags
+ * console_srcu_read_flags - Locklessly read flags of a possibly registered
+ *				console
  * @con:	struct console pointer of console to read flags from
  *
- * This function provides the necessary READ_ONCE() and data_race()
- * notation for locklessly reading the console flags. The READ_ONCE()
- * in this function matches the WRITE_ONCE() when @flags are modified
- * for registered consoles with console_srcu_write_flags().
+ * Locklessly reading @con->flags provides a consistent read value because
+ * there is at most one CPU modifying @con->flags and that CPU is using only
+ * read-modify-write operations to do so.
  *
- * Only use this function to read console flags when locklessly
- * iterating the console list via srcu.
+ * Requires console_srcu_read_lock to be held, which implies that @con might
+ * be a registered console. If the caller is holding the console_list_lock or
+ * it is certain that the console is not registered, the caller may read
+ * @con->flags directly instead.
  *
  * Context: Any context.
+ * Return: The current value of the @con->flags field.
  */
 static inline short console_srcu_read_flags(const struct console *con)
 {
 	WARN_ON_ONCE(!console_srcu_read_lock_is_held());
 
 	/*
-	 * Locklessly reading console->flags provides a consistent
-	 * read value because there is at most one CPU modifying
-	 * console->flags and that CPU is using only read-modify-write
-	 * operations to do so.
+	 * The READ_ONCE() matches the WRITE_ONCE() when @flags are modified
+	 * for registered consoles with console_srcu_write_flags().
 	 */
 	return data_race(READ_ONCE(con->flags));
 }
diff --git a/include/linux/printk.h b/include/linux/printk.h
index a2d40a6372266..f2074b458d801 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -9,7 +9,7 @@
 #include <linux/ratelimit_types.h>
 #include <linux/once_lite.h>
 
-struct uart_port;
+struct console;
 
 extern const char linux_banner[];
 extern const char linux_proc_banner[];
@@ -159,8 +159,6 @@ int _printk(const char *fmt, ...);
  */
 __printf(1, 2) __cold int _printk_deferred(const char *fmt, ...);
 
-extern void __printk_safe_enter(void);
-extern void __printk_safe_exit(void);
 extern void __printk_deferred_enter(void);
 extern void __printk_deferred_exit(void);
 
@@ -198,8 +196,8 @@ extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
 void printk_legacy_allow_panic_sync(void);
-extern void uart_nbcon_acquire(struct uart_port *up);
-extern void uart_nbcon_release(struct uart_port *up);
+extern void nbcon_driver_acquire(struct console *con);
+extern void nbcon_driver_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
 #else
 static inline __printf(1, 0)
@@ -285,11 +283,11 @@ static inline void printk_legacy_allow_panic_sync(void)
 {
 }
 
-static inline void uart_nbcon_acquire(struct uart_port *up)
+static inline void nbcon_driver_acquire(struct console *con)
 {
 }
 
-static inline void uart_nbcon_release(struct uart_port *up)
+static inline void nbcon_driver_release(struct console *con)
 {
 }
 
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index ec46e3b49ee99..ff445a5fca281 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -206,9 +206,9 @@ void serial8250_init_port(struct uart_8250_port *up);
 void serial8250_set_defaults(struct uart_8250_port *up);
 void serial8250_console_write(struct uart_8250_port *up, const char *s,
 			      unsigned int count);
-bool serial8250_console_write_atomic(struct uart_8250_port *up,
+void serial8250_console_write_atomic(struct uart_8250_port *up,
 				     struct nbcon_write_context *wctxt);
-bool serial8250_console_write_thread(struct uart_8250_port *up,
+void serial8250_console_write_thread(struct uart_8250_port *up,
 				     struct nbcon_write_context *wctxt);
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe);
 int serial8250_console_exit(struct uart_port *port);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b003e658bb39e..9a73dee32ad9a 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -8,10 +8,13 @@
 #define LINUX_SERIAL_CORE_H
 
 #include <linux/bitops.h>
+#include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/console.h>
 #include <linux/interrupt.h>
 #include <linux/circ_buf.h>
+#include <linux/lockdep.h>
+#include <linux/printk.h>
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/tty.h>
@@ -488,7 +491,6 @@ struct uart_port {
 	struct uart_icount	icount;			/* statistics */
 
 	struct console		*cons;			/* struct console, if any */
-	bool			nbcon_locked_port;	/* True, if the port is locked by nbcon */
 	/* flags must be updated while holding port mutex */
 	upf_t			flags;
 
@@ -589,6 +591,101 @@ struct uart_port {
 	void			*private_data;		/* generic platform data pointer */
 };
 
+/*
+ * Only for console->device_lock()/_unlock() callbacks and internal
+ * port lock wrapper synchronization.
+ */
+static inline void __uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
+{
+	spin_lock_irqsave(&up->lock, *flags);
+}
+
+/*
+ * Only for console->device_lock()/_unlock() callbacks and internal
+ * port lock wrapper synchronization.
+ */
+static inline void __uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
+{
+	spin_unlock_irqrestore(&up->lock, flags);
+}
+
+/**
+ * uart_port_set_cons - Safely set the @cons field for a uart
+ * @up:		The uart port to set
+ * @con:	The new console to set to
+ *
+ * This function must be used to set @up->cons. It uses the port lock to
+ * synchronize with the port lock wrappers in order to ensure that the console
+ * cannot change or disappear while another context is holding the port lock.
+ */
+static inline void uart_port_set_cons(struct uart_port *up, struct console *con)
+{
+	unsigned long flags;
+
+	__uart_port_lock_irqsave(up, &flags);
+	up->cons = con;
+	__uart_port_unlock_irqrestore(up, flags);
+}
+
+/* Only for internal port lock wrapper usage. */
+static inline void __uart_port_nbcon_acquire(struct uart_port *up)
+{
+	lockdep_assert_held_once(&up->lock);
+
+	if (likely(!uart_console(up)))
+		return;
+
+	if (up->cons->nbcon_drvdata) {
+		/*
+		 * If @up->cons is registered, prevent it from fully
+		 * unregistering until this context releases the nbcon.
+		 */
+		int cookie = console_srcu_read_lock();
+
+		/* Ensure console is registered and is an nbcon console. */
+		if (!hlist_unhashed_lockless(&up->cons->node) &&
+		    (console_srcu_read_flags(up->cons) & CON_NBCON)) {
+			WARN_ON_ONCE(up->cons->nbcon_drvdata->locked);
+
+			nbcon_driver_acquire(up->cons);
+
+			/*
+			 * Record @up->line to be used during release because
+			 * @up->cons->index can change while the port and
+			 * nbcon are locked.
+			 */
+			up->cons->nbcon_drvdata->owner_index = up->line;
+			up->cons->nbcon_drvdata->srcu_cookie = cookie;
+			up->cons->nbcon_drvdata->locked = true;
+		} else {
+			console_srcu_read_unlock(cookie);
+		}
+	}
+}
+
+/* Only for internal port lock wrapper usage. */
+static inline void __uart_port_nbcon_release(struct uart_port *up)
+{
+	lockdep_assert_held_once(&up->lock);
+
+	/*
+	 * uart_console() cannot be used here because @up->cons->index might
+	 * have changed. Check against @up->cons->nbcon_drvdata->owner_index
+	 * instead.
+	 */
+
+	if (unlikely(up->cons &&
+		     up->cons->nbcon_drvdata &&
+		     up->cons->nbcon_drvdata->locked &&
+		     up->cons->nbcon_drvdata->owner_index == up->line)) {
+		WARN_ON_ONCE(!up->cons->nbcon_drvdata->locked);
+
+		up->cons->nbcon_drvdata->locked = false;
+		nbcon_driver_release(up->cons);
+		console_srcu_read_unlock(up->cons->nbcon_drvdata->srcu_cookie);
+	}
+}
+
 /**
  * uart_port_lock - Lock the UART port
  * @up:		Pointer to UART port structure
@@ -596,7 +693,7 @@ struct uart_port {
 static inline void uart_port_lock(struct uart_port *up)
 {
 	spin_lock(&up->lock);
-	uart_nbcon_acquire(up);
+	__uart_port_nbcon_acquire(up);
 }
 
 /**
@@ -606,7 +703,7 @@ static inline void uart_port_lock(struct uart_port *up)
 static inline void uart_port_lock_irq(struct uart_port *up)
 {
 	spin_lock_irq(&up->lock);
-	uart_nbcon_acquire(up);
+	__uart_port_nbcon_acquire(up);
 }
 
 /**
@@ -617,7 +714,7 @@ static inline void uart_port_lock_irq(struct uart_port *up)
 static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
 {
 	spin_lock_irqsave(&up->lock, *flags);
-	uart_nbcon_acquire(up);
+	__uart_port_nbcon_acquire(up);
 }
 
 /**
@@ -631,7 +728,7 @@ static inline bool uart_port_trylock(struct uart_port *up)
 	if (!spin_trylock(&up->lock))
 		return false;
 
-	uart_nbcon_acquire(up);
+	__uart_port_nbcon_acquire(up);
 	return true;
 }
 
@@ -647,7 +744,7 @@ static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long
 	if (!spin_trylock_irqsave(&up->lock, *flags))
 		return false;
 
-	uart_nbcon_acquire(up);
+	__uart_port_nbcon_acquire(up);
 	return true;
 }
 
@@ -657,7 +754,7 @@ static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long
  */
 static inline void uart_port_unlock(struct uart_port *up)
 {
-	uart_nbcon_release(up);
+	__uart_port_nbcon_release(up);
 	spin_unlock(&up->lock);
 }
 
@@ -667,7 +764,7 @@ static inline void uart_port_unlock(struct uart_port *up)
  */
 static inline void uart_port_unlock_irq(struct uart_port *up)
 {
-	uart_nbcon_release(up);
+	__uart_port_nbcon_release(up);
 	spin_unlock_irq(&up->lock);
 }
 
@@ -678,19 +775,7 @@ static inline void uart_port_unlock_irq(struct uart_port *up)
  */
 static inline void uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
 {
-	uart_nbcon_release(up);
-	spin_unlock_irqrestore(&up->lock, flags);
-}
-
-/* Only for use in the console->driver_enter() callback. */
-static inline void __uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
-{
-	spin_lock_irqsave(&up->lock, *flags);
-}
-
-/* Only for use in the console->driver_exit() callback. */
-static inline void __uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
-{
+	__uart_port_nbcon_release(up);
 	spin_unlock_irqrestore(&up->lock, flags);
 }
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5c21ba41e3087..80cfbe7b340e3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -575,8 +575,10 @@ static struct lock_trace *save_trace(void)
 		if (!debug_locks_off_graph_unlock())
 			return NULL;
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_STACK_TRACE_ENTRIES too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 
 		return NULL;
 	}
@@ -783,6 +785,8 @@ static void lockdep_print_held_locks(struct task_struct *p)
 {
 	int i, depth = READ_ONCE(p->lockdep_depth);
 
+	nbcon_cpu_emergency_enter();
+
 	if (!depth)
 		printk("no locks held by %s/%d.\n", p->comm, task_pid_nr(p));
 	else
@@ -793,11 +797,13 @@ static void lockdep_print_held_locks(struct task_struct *p)
 	 * and it's not the current task.
 	 */
 	if (p != current && task_is_running(p))
-		return;
+		goto out;
 	for (i = 0; i < depth; i++) {
 		printk(" #%d: ", i);
 		print_lock(p->held_locks + i);
 	}
+out:
+	nbcon_cpu_emergency_exit();
 }
 
 static void print_kernel_ident(void)
@@ -889,11 +895,13 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 	if (unlikely(subclass >= MAX_LOCKDEP_SUBCLASSES)) {
 		instrumentation_begin();
 		debug_locks_off();
+		nbcon_cpu_emergency_enter();
 		printk(KERN_ERR
 			"BUG: looking up invalid subclass: %u\n", subclass);
 		printk(KERN_ERR
 			"turning off the locking correctness validator.\n");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		instrumentation_end();
 		return NULL;
 	}
@@ -970,11 +978,13 @@ static bool assign_lock_key(struct lockdep_map *lock)
 	else {
 		/* Debug-check: all keys must be persistent! */
 		debug_locks_off();
+		nbcon_cpu_emergency_enter();
 		pr_err("INFO: trying to register non-static key.\n");
 		pr_err("The code is fine but needs lockdep annotation, or maybe\n");
 		pr_err("you didn't initialize this object before use?\n");
 		pr_err("turning off the locking correctness validator.\n");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return false;
 	}
 
@@ -1318,8 +1328,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 			return NULL;
 		}
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCKDEP_KEYS too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return NULL;
 	}
 	nr_lock_classes++;
@@ -1351,11 +1363,13 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	if (verbose(class)) {
 		graph_unlock();
 
+		nbcon_cpu_emergency_enter();
 		printk("\nnew class %px: %s", class->key, class->name);
 		if (class->name_version > 1)
 			printk(KERN_CONT "#%d", class->name_version);
 		printk(KERN_CONT "\n");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 
 		if (!graph_lock()) {
 			return NULL;
@@ -1394,8 +1408,10 @@ static struct lock_list *alloc_list_entry(void)
 		if (!debug_locks_off_graph_unlock())
 			return NULL;
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCKDEP_ENTRIES too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return NULL;
 	}
 	nr_list_entries++;
@@ -2041,6 +2057,8 @@ static noinline void print_circular_bug(struct lock_list *this,
 
 	depth = get_lock_depth(target);
 
+	nbcon_cpu_emergency_enter();
+
 	print_circular_bug_header(target, depth, check_src, check_tgt);
 
 	parent = get_lock_parent(target);
@@ -2059,6 +2077,8 @@ static noinline void print_circular_bug(struct lock_list *this,
 
 	printk("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static noinline void print_bfs_bug(int ret)
@@ -2571,6 +2591,8 @@ print_bad_irq_dependency(struct task_struct *curr,
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=====================================================\n");
 	pr_warn("WARNING: %s-safe -> %s-unsafe lock order detected\n",
@@ -2620,11 +2642,13 @@ print_bad_irq_dependency(struct task_struct *curr,
 	pr_warn(" and %s-irq-unsafe lock:\n", irqclass);
 	next_root->trace = save_trace();
 	if (!next_root->trace)
-		return;
+		goto out;
 	print_shortest_lock_dependencies(forwards_entry, next_root);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+out:
+	nbcon_cpu_emergency_exit();
 }
 
 static const char *state_names[] = {
@@ -2989,6 +3013,8 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("============================================\n");
 	pr_warn("WARNING: possible recursive locking detected\n");
@@ -3011,6 +3037,8 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 /*
@@ -3608,6 +3636,8 @@ static void print_collision(struct task_struct *curr,
 			struct held_lock *hlock_next,
 			struct lock_chain *chain)
 {
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("============================\n");
 	pr_warn("WARNING: chain_key collision\n");
@@ -3624,6 +3654,8 @@ static void print_collision(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 #endif
 
@@ -3714,8 +3746,10 @@ static inline int add_chain_cache(struct task_struct *curr,
 		if (!debug_locks_off_graph_unlock())
 			return 0;
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCKDEP_CHAINS too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return 0;
 	}
 	chain->chain_key = chain_key;
@@ -3732,8 +3766,10 @@ static inline int add_chain_cache(struct task_struct *curr,
 		if (!debug_locks_off_graph_unlock())
 			return 0;
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return 0;
 	}
 
@@ -4038,6 +4074,8 @@ print_irq_inversion_bug(struct task_struct *curr,
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("========================================================\n");
 	pr_warn("WARNING: possible irq lock inversion dependency detected\n");
@@ -4078,11 +4116,13 @@ print_irq_inversion_bug(struct task_struct *curr,
 	pr_warn("\nthe shortest dependencies between 2nd lock and 1st lock:\n");
 	root->trace = save_trace();
 	if (!root->trace)
-		return;
+		goto out;
 	print_shortest_lock_dependencies(other, root);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+out:
+	nbcon_cpu_emergency_exit();
 }
 
 /*
@@ -4159,6 +4199,8 @@ void print_irqtrace_events(struct task_struct *curr)
 {
 	const struct irqtrace_events *trace = &curr->irqtrace;
 
+	nbcon_cpu_emergency_enter();
+
 	printk("irq event stamp: %u\n", trace->irq_events);
 	printk("hardirqs last  enabled at (%u): [<%px>] %pS\n",
 		trace->hardirq_enable_event, (void *)trace->hardirq_enable_ip,
@@ -4172,6 +4214,8 @@ void print_irqtrace_events(struct task_struct *curr)
 	printk("softirqs last disabled at (%u): [<%px>] %pS\n",
 		trace->softirq_disable_event, (void *)trace->softirq_disable_ip,
 		(void *)trace->softirq_disable_ip);
+
+	nbcon_cpu_emergency_exit();
 }
 
 static int HARDIRQ_verbose(struct lock_class *class)
@@ -4692,10 +4736,12 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	 * We must printk outside of the graph_lock:
 	 */
 	if (ret == 2) {
+		nbcon_cpu_emergency_enter();
 		printk("\nmarked lock as {%s}:\n", usage_str[new_bit]);
 		print_lock(this);
 		print_irqtrace_events(curr);
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 	}
 
 	return ret;
@@ -4736,6 +4782,8 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 	if (debug_locks_silent)
 		return 0;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=============================\n");
 	pr_warn("[ BUG: Invalid wait context ]\n");
@@ -4755,6 +4803,8 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 	pr_warn("stack backtrace:\n");
 	dump_stack();
 
+	nbcon_cpu_emergency_exit();
+
 	return 0;
 }
 
@@ -4959,6 +5009,8 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("==================================\n");
 	pr_warn("WARNING: Nested lock was not taken\n");
@@ -4979,6 +5031,8 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static int __lock_is_held(const struct lockdep_map *lock, int read);
@@ -5024,11 +5078,13 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	debug_class_ops_inc(class);
 
 	if (very_verbose(class)) {
+		nbcon_cpu_emergency_enter();
 		printk("\nacquire class [%px] %s", class->key, class->name);
 		if (class->name_version > 1)
 			printk(KERN_CONT "#%d", class->name_version);
 		printk(KERN_CONT "\n");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 	}
 
 	/*
@@ -5155,6 +5211,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 #endif
 	if (unlikely(curr->lockdep_depth >= MAX_LOCK_DEPTH)) {
 		debug_locks_off();
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCK_DEPTH too low!");
 		printk(KERN_DEBUG "depth: %i  max: %lu!\n",
 		       curr->lockdep_depth, MAX_LOCK_DEPTH);
@@ -5162,6 +5219,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		lockdep_print_held_locks(current);
 		debug_show_all_locks();
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 
 		return 0;
 	}
@@ -5181,6 +5239,8 @@ static void print_unlock_imbalance_bug(struct task_struct *curr,
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=====================================\n");
 	pr_warn("WARNING: bad unlock balance detected!\n");
@@ -5197,6 +5257,8 @@ static void print_unlock_imbalance_bug(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static noinstr int match_held_lock(const struct held_lock *hlock,
@@ -5900,6 +5962,8 @@ static void print_lock_contention_bug(struct task_struct *curr,
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=================================\n");
 	pr_warn("WARNING: bad contention detected!\n");
@@ -5916,6 +5980,8 @@ static void print_lock_contention_bug(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static void
@@ -6529,6 +6595,8 @@ print_freed_lock_bug(struct task_struct *curr, const void *mem_from,
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=========================\n");
 	pr_warn("WARNING: held lock freed!\n");
@@ -6541,6 +6609,8 @@ print_freed_lock_bug(struct task_struct *curr, const void *mem_from,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static inline int not_in_range(const void* mem_from, unsigned long mem_len,
@@ -6587,6 +6657,8 @@ static void print_held_locks_bug(void)
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("====================================\n");
 	pr_warn("WARNING: %s/%d still has locks held!\n",
@@ -6596,6 +6668,8 @@ static void print_held_locks_bug(void)
 	lockdep_print_held_locks(current);
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 void debug_check_no_locks_held(void)
@@ -6614,6 +6688,7 @@ void debug_show_all_locks(void)
 		pr_warn("INFO: lockdep is turned off.\n");
 		return;
 	}
+	nbcon_cpu_emergency_enter();
 	pr_warn("\nShowing all locks held in the system:\n");
 
 	rcu_read_lock();
@@ -6628,6 +6703,7 @@ void debug_show_all_locks(void)
 
 	pr_warn("\n");
 	pr_warn("=============================================\n\n");
+	nbcon_cpu_emergency_exit();
 }
 EXPORT_SYMBOL_GPL(debug_show_all_locks);
 #endif
@@ -6653,6 +6729,7 @@ asmlinkage __visible void lockdep_sys_exit(void)
 	if (unlikely(curr->lockdep_depth)) {
 		if (!debug_locks_off())
 			return;
+		nbcon_cpu_emergency_enter();
 		pr_warn("\n");
 		pr_warn("================================================\n");
 		pr_warn("WARNING: lock held when returning to user space!\n");
@@ -6661,6 +6738,7 @@ asmlinkage __visible void lockdep_sys_exit(void)
 		pr_warn("%s/%d is leaving the kernel with locks still held!\n",
 				curr->comm, curr->pid);
 		lockdep_print_held_locks(curr);
+		nbcon_cpu_emergency_exit();
 	}
 
 	/*
@@ -6677,6 +6755,7 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	bool rcu = warn_rcu_enter();
 
 	/* Note: the following can be executed concurrently, so be careful. */
+	nbcon_cpu_emergency_enter();
 	pr_warn("\n");
 	pr_warn("=============================\n");
 	pr_warn("WARNING: suspicious RCU usage\n");
@@ -6715,6 +6794,7 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	lockdep_print_held_locks(curr);
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	nbcon_cpu_emergency_exit();
 	warn_rcu_exit(rcu);
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
diff --git a/kernel/panic.c b/kernel/panic.c
index 9fa44bc38f466..3754a2471b4ff 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -364,14 +364,14 @@ void panic(const char *fmt, ...)
 
 	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
 
+	printk_legacy_allow_panic_sync();
+
 	/*
 	 * Run any panic handlers, including those that might need to
 	 * add information to the kmsg dump output.
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
-	printk_legacy_allow_panic_sync();
-
 	panic_print_sys_info(false);
 
 	kmsg_dump(KMSG_DUMP_PANIC);
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 1abb4207186f0..fdf455c890338 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -2,12 +2,13 @@
 /*
  * internal.h - printk internal definitions
  */
-#include <linux/percpu.h>
 #include <linux/console.h>
 #include <linux/jump_label.h>
-#include "printk_ringbuffer.h"
+#include <linux/percpu.h>
+#include <linux/types.h>
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
+struct ctl_table;
 void __init printk_sysctl_init(void);
 int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos);
@@ -51,18 +52,11 @@ enum printk_info_flags {
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
+struct printk_ringbuffer;
+struct dev_printk_info;
+
 extern struct printk_ringbuffer *prb;
 extern bool printk_threads_enabled;
-extern bool have_legacy_console;
-extern bool have_boot_console;
-
-/*
- * Specifies if the console lock/unlock dance is needed for console
- * printing. If @have_boot_console is true, the nbcon consoles will
- * be printed serially along with the legacy consoles because nbcon
- * consoles cannot print simultaneously with boot consoles.
- */
-#define printing_via_unlock (have_legacy_console || have_boot_console)
 
 __printf(4, 0)
 int vprintk_store(int facility, int level,
@@ -72,6 +66,9 @@ int vprintk_store(int facility, int level,
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
 __printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
 
+void __printk_safe_enter(void);
+void __printk_safe_exit(void);
+
 bool printk_percpu_data_ready(void);
 
 #define printk_safe_enter_irqsave(flags)	\
@@ -99,7 +96,7 @@ bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con);
 void nbcon_free(struct console *con);
 enum nbcon_prio nbcon_get_default_prio(void);
-void nbcon_atomic_flush_all(void);
+void nbcon_atomic_flush_pending(void);
 bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 				   int cookie, bool use_atomic);
 void nbcon_kthread_create(struct console *con);
@@ -173,7 +170,6 @@ static inline void nbcon_kthread_wake(struct console *con)
 static inline void nbcon_kthread_wake(struct console *con) { }
 static inline void nbcon_kthread_create(struct console *con) { }
 #define printk_threads_enabled (false)
-#define printing_via_unlock (false)
 
 /*
  * In !PRINTK builds we still export console_sem
@@ -190,7 +186,7 @@ static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
 static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
-static inline void nbcon_atomic_flush_all(void) { }
+static inline void nbcon_atomic_flush_pending(void) { }
 static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 						 int cookie, bool use_atomic) { return false; }
 
@@ -199,6 +195,17 @@ static inline bool console_is_usable(struct console *con, short flags,
 
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
@@ -233,4 +240,5 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 
 #ifdef CONFIG_PRINTK
 void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped);
+void console_prepend_replay(struct printk_message *pmsg);
 #endif
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index f2d59a0a93e58..92d59c85d43a3 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -2,15 +2,26 @@
 // Copyright (C) 2022 Linutronix GmbH, John Ogness
 // Copyright (C) 2022 Intel, Thomas Gleixner
 
-#include <linux/kernel.h>
+#include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/irqflags.h>
 #include <linux/kthread.h>
+#include <linux/minmax.h>
+#include <linux/percpu.h>
+#include <linux/preempt.h>
 #include <linux/slab.h>
-#include <linux/serial_core.h>
+#include <linux/smp.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
 #include <linux/syscore_ops.h>
-#include "printk_ringbuffer.h"
+#include <linux/types.h>
 #include "internal.h"
+#include "printk_ringbuffer.h"
 /*
  * Printk console printing implementation for consoles which does not depend
  * on the legacy style console_lock mechanism.
@@ -176,9 +187,6 @@ void nbcon_seq_force(struct console *con, u64 seq)
 	u64 valid_seq = max_t(u64, seq, prb_first_valid_seq(prb));
 
 	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __u64seq_to_ulseq(valid_seq));
-
-	/* Clear con->seq since nbcon consoles use con->nbcon_seq instead. */
-	con->seq = 0;
 }
 
 /**
@@ -890,7 +898,7 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	unsigned long con_dropped;
 	struct nbcon_state cur;
 	unsigned long dropped;
-	bool done = false;
+	unsigned long ulseq;
 
 	/*
 	 * The printk buffers are filled within an unsafe section. This
@@ -916,6 +924,28 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	if (dropped && !is_extended)
 		console_prepend_dropped(&pmsg, dropped);
 
+	/*
+	 * If the previous owner was assigned the same record, this context
+	 * has taken over ownership and is replaying the record. Prepend a
+	 * message to let the user know the record is replayed.
+	 */
+	ulseq = atomic_long_read(&ACCESS_PRIVATE(con, nbcon_prev_seq));
+	if (__ulseq_to_u64seq(prb, ulseq) == pmsg.seq) {
+		console_prepend_replay(&pmsg);
+	} else {
+		/*
+		 * Ensure this context is still the owner before trying to
+		 * update @nbcon_prev_seq. Otherwise the value in @ulseq may
+		 * not be from the previous owner.
+		 */
+		nbcon_state_read(con, &cur);
+		if (!nbcon_context_can_proceed(ctxt, &cur))
+			return false;
+
+		atomic_long_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_prev_seq), &ulseq,
+					__u64seq_to_ulseq(pmsg.seq));
+	}
+
 	if (!nbcon_context_exit_unsafe(ctxt))
 		return false;
 
@@ -931,18 +961,26 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 
 	if (use_atomic &&
 	    con->write_atomic) {
-		done = con->write_atomic(con, wctxt);
+		con->write_atomic(con, wctxt);
 
 	} else if (!use_atomic &&
 		   con->write_thread) {
-		done = con->write_thread(con, wctxt);
+		con->write_thread(con, wctxt);
+
+	} else {
+		/*
+		 * This function should never be called for legacy consoles.
+		 * Handle it as if ownership was lost and try to continue.
+		 */
+		WARN_ON_ONCE(1);
+		nbcon_context_release(ctxt);
+		return false;
 	}
 
-	if (!done) {
+	if (!wctxt->outbuf) {
 		/*
-		 * The emit was aborted, probably due to a loss of ownership.
-		 * Ensure ownership was lost or released before reporting the
-		 * loss.
+		 * Ownership was lost and reacquired by the driver.
+		 * Handle it as if ownership was lost and try to continue.
 		 */
 		nbcon_context_release(ctxt);
 		return false;
@@ -987,7 +1025,7 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
  */
 static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_context *ctxt)
 {
-	bool is_usable;
+	bool ret = false;
 	short flags;
 	int cookie;
 
@@ -995,17 +1033,17 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
 		return true;
 
 	cookie = console_srcu_read_lock();
+
 	flags = console_srcu_read_flags(con);
-	is_usable = console_is_usable(con, flags, false);
+	if (console_is_usable(con, flags, false)) {
+		/* Bring the sequence in @ctxt up to date */
+		ctxt->seq = nbcon_seq_read(con);
+
+		ret = prb_read_valid(prb, ctxt->seq, NULL);
+	}
+
 	console_srcu_read_unlock(cookie);
-
-	if (!is_usable)
-		return false;
-
-	/* Bring the sequence in @ctxt up to date */
-	ctxt->seq = nbcon_seq_read(con);
-
-	return prb_read_valid(prb, ctxt->seq, NULL);
+	return ret;
 }
 
 /**
@@ -1056,7 +1094,7 @@ static int nbcon_kthread_func(void *__console)
 		con_flags = console_srcu_read_flags(con);
 
 		if (console_is_usable(con, con_flags, false)) {
-			con->driver_enter(con, &flags);
+			con->device_lock(con, &flags);
 
 			/*
 			 * Ensure this stays on the CPU to make handover and
@@ -1075,7 +1113,7 @@ static int nbcon_kthread_func(void *__console)
 				}
 			}
 
-			con->driver_exit(con, flags);
+			con->device_unlock(con, flags);
 		}
 
 		console_srcu_read_unlock(cookie);
@@ -1166,12 +1204,11 @@ static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
 /**
  * nbcon_emit_one - Print one record for an nbcon console using the
  *			specified callback
- * @wctxt:	An initialized write context struct to use
- *		for this context
+ * @wctxt:	An initialized write context struct to use for this context
  * @use_atomic:	True if the write_atomic callback is to be used
  *
- * Return:	False if the given console could not print a record or there
- *		are no more records to print, otherwise true.
+ * Return:	False if it is known there are no more records to print,
+ *		otherwise true.
  *
  * This is an internal helper to handle the locking of the console before
  * calling nbcon_emit_next_record().
@@ -1181,7 +1218,7 @@ static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
 
 	if (!nbcon_context_try_acquire(ctxt))
-		return false;
+		return true;
 
 	/*
 	 * nbcon_emit_next_record() returns false when the console was
@@ -1189,7 +1226,7 @@ static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
 	 * longer valid.
 	 */
 	if (!nbcon_emit_next_record(wctxt, use_atomic))
-		return false;
+		return true;
 
 	nbcon_context_release(ctxt);
 
@@ -1229,8 +1266,9 @@ enum nbcon_prio nbcon_get_default_prio(void)
  * @cookie:	The cookie from the SRCU read lock.
  * @use_atomic:	True if the write_atomic callback is to be used
  *
- * Context:	Any context which could not be migrated to another CPU.
- * Return:	True if a record could be printed, otherwise false.
+ * Context:	Any context except NMI.
+ * Return:	False if the given console has no next record to print,
+ *		otherwise true.
  *
  * This function is meant to be called by console_flush_all() to print records
  * on nbcon consoles from legacy context (printing via console unlocking).
@@ -1241,8 +1279,8 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 {
 	struct nbcon_write_context wctxt = { };
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
-	bool progress = false;
 	unsigned long flags;
+	bool progress;
 
 	*handover = false;
 
@@ -1261,34 +1299,78 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 		*handover = console_lock_spinning_disable_and_check(cookie);
 		printk_safe_exit_irqrestore(flags);
 	} else {
-		con->driver_enter(con, &flags);
+		con->device_lock(con, &flags);
 		cant_migrate();
 
 		ctxt->prio = nbcon_get_default_prio();
 		progress = nbcon_emit_one(&wctxt, use_atomic);
 
-		con->driver_exit(con, flags);
+		con->device_unlock(con, flags);
 	}
 
 	return progress;
 }
 
 /**
- * __nbcon_atomic_flush_all - Flush all nbcon consoles using their
+ * __nbcon_atomic_flush_pending_con - Flush specified nbcon console using its
+ *					write_atomic() callback
+ * @con:			The nbcon console to flush
+ * @stop_seq:			Flush up until this record
+ * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
+ *
+ * Return:	True if taken over while printing. Otherwise false.
+ *
+ * If flushing up to @stop_seq was not successful, it only makes sense for the
+ * caller to try again when true was returned. When false is returned, either
+ * there are no more records available to read or this context is not allowed
+ * to acquire the console.
+ */
+static bool __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
+					     bool allow_unsafe_takeover)
+{
+	struct nbcon_write_context wctxt = { };
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
+
+	ctxt->console			= con;
+	ctxt->spinwait_max_us		= 2000;
+	ctxt->prio			= nbcon_get_default_prio();
+	ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
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
+		if (!nbcon_emit_next_record(&wctxt, true))
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
  *					write_atomic() callback
  * @stop_seq:			Flush up until this record
  * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
  */
-static void __nbcon_atomic_flush_all(u64 stop_seq, bool allow_unsafe_takeover)
+static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeover)
 {
-	struct nbcon_write_context wctxt = { };
-	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
 	struct console *con;
-	bool any_progress;
+	bool should_retry;
 	int cookie;
 
 	do {
-		any_progress = false;
+		should_retry = false;
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
@@ -1304,11 +1386,6 @@ static void __nbcon_atomic_flush_all(u64 stop_seq, bool allow_unsafe_takeover)
 			if (nbcon_seq_read(con) >= stop_seq)
 				continue;
 
-			memset(ctxt, 0, sizeof(*ctxt));
-			ctxt->console			= con;
-			ctxt->spinwait_max_us		= 2000;
-			ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
-
 			/*
 			 * Atomic flushing does not use console driver
 			 * synchronization (i.e. it does not hold the port
@@ -1316,33 +1393,28 @@ static void __nbcon_atomic_flush_all(u64 stop_seq, bool allow_unsafe_takeover)
 			 * disabled to avoid being interrupted and then
 			 * calling into a driver that will deadlock trying
 			 * acquire console ownership.
-			 *
-			 * This also disables migration in order to get the
-			 * current CPU priority.
 			 */
 			local_irq_save(irq_flags);
 
-			ctxt->prio = nbcon_get_default_prio();
-
-			any_progress |= nbcon_emit_one(&wctxt, true);
-
+			should_retry |= __nbcon_atomic_flush_pending_con(con, stop_seq,
+									 allow_unsafe_takeover);
 			local_irq_restore(irq_flags);
 		}
 		console_srcu_read_unlock(cookie);
-	} while (any_progress);
+	} while (should_retry);
 }
 
 /**
- * nbcon_atomic_flush_all - Flush all nbcon consoles using their
+ * nbcon_atomic_flush_pending - Flush all nbcon consoles using their
  *				write_atomic() callback
  *
  * Flush the backlog up through the currently newest record. Any new
  * records added while flushing will not be flushed. This is to avoid
  * one CPU printing unbounded because other CPUs continue to add records.
  */
-void nbcon_atomic_flush_all(void)
+void nbcon_atomic_flush_pending(void)
 {
-	__nbcon_atomic_flush_all(prb_next_reserve_seq(prb), false);
+	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), false);
 }
 
 /**
@@ -1354,7 +1426,7 @@ void nbcon_atomic_flush_all(void)
  */
 void nbcon_atomic_flush_unsafe(void)
 {
-	__nbcon_atomic_flush_all(prb_next_reserve_seq(prb), true);
+	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), true);
 }
 
 /**
@@ -1397,8 +1469,10 @@ void nbcon_cpu_emergency_exit(void)
 
 	WARN_ON_ONCE(*cpu_emergency_nesting == 0);
 
-	if (*cpu_emergency_nesting == 1)
+	if (*cpu_emergency_nesting == 1) {
+		nbcon_atomic_flush_pending();
 		do_trigger_flush = true;
+	}
 
 	/* Undo the nesting count of nbcon_cpu_emergency_enter(). */
 	(*cpu_emergency_nesting)--;
@@ -1517,8 +1591,6 @@ bool nbcon_alloc(struct console *con)
  *
  * nbcon_alloc() *must* be called and succeed before this function
  * is called.
- *
- * This function expects that the legacy @con->seq has been set.
  */
 void nbcon_init(struct console *con)
 {
@@ -1529,7 +1601,8 @@ void nbcon_init(struct console *con)
 
 	rcuwait_init(&con->rcuwait);
 	init_irq_work(&con->irq_work, nbcon_irq_work);
-	nbcon_seq_force(con, con->seq);
+	nbcon_seq_force(con, 0);
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_prev_seq), -1UL);
 	nbcon_state_set(con, &state);
 	nbcon_kthread_create(con);
 }
@@ -1552,87 +1625,54 @@ void nbcon_free(struct console *con)
 	con->pbufs = NULL;
 }
 
-static inline bool uart_is_nbcon(struct uart_port *up)
-{
-	int cookie;
-	bool ret;
-
-	if (!uart_console(up))
-		return false;
-
-	cookie = console_srcu_read_lock();
-	ret = (console_srcu_read_flags(up->cons) & CON_NBCON);
-	console_srcu_read_unlock(cookie);
-	return ret;
-}
-
 /**
- * uart_nbcon_acquire - The second half of the port locking wrapper
- * @up:		The uart port whose @lock was locked
+ * nbcon_driver_acquire - Acquire nbcon console and enter unsafe section
+ * @con:	The nbcon console to acquire
  *
- * The uart_port_lock() wrappers will first lock the spin_lock @up->lock.
- * Then this function is called to implement nbcon-specific processing.
+ * Context:	Any context which could not be migrated to another CPU.
  *
- * If @up is an nbcon console, this console will be acquired and marked as
- * unsafe. Otherwise this function does nothing.
+ * Console drivers will usually use their own internal synchronization
+ * mechasism to synchronize between console printing and non-printing
+ * activities (such as setting baud rates). However, nbcon console drivers
+ * supporting atomic consoles may also want to mark unsafe sections when
+ * performing non-printing activities.
  *
- * nbcon consoles acquired via the port lock wrapper always use priority
- * NBCON_PRIO_NORMAL.
+ * This function acquires the nbcon console using priority NBCON_PRIO_NORMAL
+ * and marks it unsafe for handover/takeover.
+ *
+ * Console drivers using this function must have provided @nbcon_drvdata in
+ * their struct console, which is used to track ownership and state
+ * information.
  */
-void uart_nbcon_acquire(struct uart_port *up)
+void nbcon_driver_acquire(struct console *con)
 {
-	struct console *con = up->cons;
-	struct nbcon_context ctxt;
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con->nbcon_drvdata, ctxt);
 
-	if (!uart_is_nbcon(up))
-		return;
-
-	WARN_ON_ONCE(up->nbcon_locked_port);
+	cant_migrate();
 
 	do {
 		do {
-			memset(&ctxt, 0, sizeof(ctxt));
-			ctxt.console	= con;
-			ctxt.prio	= NBCON_PRIO_NORMAL;
-		} while (!nbcon_context_try_acquire(&ctxt));
+			memset(ctxt, 0, sizeof(*ctxt));
+			ctxt->console	= con;
+			ctxt->prio	= NBCON_PRIO_NORMAL;
+		} while (!nbcon_context_try_acquire(ctxt));
 
-	} while (!nbcon_context_enter_unsafe(&ctxt));
-
-	up->nbcon_locked_port = true;
+	} while (!nbcon_context_enter_unsafe(ctxt));
 }
-EXPORT_SYMBOL_GPL(uart_nbcon_acquire);
+EXPORT_SYMBOL_GPL(nbcon_driver_acquire);
 
 /**
- * uart_nbcon_release - The first half of the port unlocking wrapper
- * @up:		The uart port whose @lock is about to be unlocked
- *
- * The uart_port_unlock() wrappers will first call this function to implement
- * nbcon-specific processing. Then afterwards the uart_port_unlock() wrappers
- * will unlock the spin_lock @up->lock.
- *
- * If @up is an nbcon console, the console will be marked as safe and
- * released. Otherwise this function does nothing.
- *
- * nbcon consoles acquired via the port lock wrapper always use priority
- * NBCON_PRIO_NORMAL.
+ * nbcon_driver_release - Exit unsafe section and release the nbcon console
+ * @con:	The nbcon console acquired in nbcon_driver_acquire()
  */
-void uart_nbcon_release(struct uart_port *up)
+void nbcon_driver_release(struct console *con)
 {
-	struct console *con = up->cons;
-	struct nbcon_context ctxt = {
-		.console	= con,
-		.prio		= NBCON_PRIO_NORMAL,
-	};
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con->nbcon_drvdata, ctxt);
 
-	if (!up->nbcon_locked_port)
-		return;
-
-	if (nbcon_context_exit_unsafe(&ctxt))
-		nbcon_context_release(&ctxt);
-
-	up->nbcon_locked_port = false;
+	if (nbcon_context_exit_unsafe(ctxt))
+		nbcon_context_release(ctxt);
 }
-EXPORT_SYMBOL_GPL(uart_nbcon_release);
+EXPORT_SYMBOL_GPL(nbcon_driver_release);
 
 /**
  * printk_kthread_shutdown - shutdown all threaded printers
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e29f77f4f8b46..2be1157e8169c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -200,8 +200,8 @@ DEFINE_STATIC_KEY_FALSE(force_printkthreads_key);
 
 static int __init setup_forced_printkthreads(char *arg)
 {
-        static_branch_enable(&force_printkthreads_key);
-        return 0;
+	static_branch_enable(&force_printkthreads_key);
+	return 0;
 }
 early_param("threadprintk", setup_forced_printkthreads);
 #endif
@@ -486,7 +486,7 @@ bool have_legacy_console;
  * synchronous printing of legacy consoles will not occur during panic until
  * the backtrace has been stored to the ringbuffer.
  */
-bool have_nbcon_console;
+static bool have_nbcon_console;
 
 /*
  * Specifies if a boot console is registered. If boot consoles are present,
@@ -2347,11 +2347,15 @@ static bool legacy_allow_panic_sync;
 
 /*
  * This acts as a one-way switch to allow legacy consoles to print from
- * the printk() caller context on a panic CPU.
+ * the printk() caller context on a panic CPU. It also attempts to flush
+ * the legacy consoles in this context.
  */
 void printk_legacy_allow_panic_sync(void)
 {
 	legacy_allow_panic_sync = true;
+
+	if (printing_via_unlock && !in_nmi() && console_trylock())
+		console_unlock();
 }
 
 asmlinkage int vprintk_emit(int facility, int level,
@@ -2384,7 +2388,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
-	if (!have_boot_console && have_nbcon_console) {
+	if (have_nbcon_console && !have_boot_console) {
 		bool is_panic_context = this_cpu_in_panic();
 
 		/*
@@ -2417,7 +2421,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		if (is_panic_context ||
 		    !printk_threads_enabled ||
 		    (system_state > SYSTEM_RUNNING)) {
-			nbcon_atomic_flush_all();
+			nbcon_atomic_flush_pending();
 		}
 	}
 
@@ -2436,19 +2440,15 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_disable();
 
 		/*
-		 * Do not emit for EMERGENCY priority. The console will be
+		 * Try to acquire and then immediately release the console
+		 * semaphore. The release will print out buffers. With the
+		 * spinning variant, this context tries to take over the
+		 * printing from another printing context.
+		 *
+		 * Skip it in EMERGENCY priority. The console will be
 		 * explicitly flushed when exiting the emergency section.
 		 */
-		if (nbcon_get_default_prio() == NBCON_PRIO_EMERGENCY) {
-			do_trylock_unlock = false;
-		} else {
-			/*
-			 * Try to acquire and then immediately release the
-			 * console semaphore. The release will print out
-			 * buffers. With the spinning variant, this context
-			 * tries to take over the printing from another
-			 * printing context.
-			 */
+		if (nbcon_get_default_prio() != NBCON_PRIO_EMERGENCY) {
 			if (console_trylock_spinning())
 				console_unlock();
 		}
@@ -2838,30 +2838,25 @@ static void __console_unlock(void)
 #ifdef CONFIG_PRINTK
 
 /*
- * Prepend the message in @pmsg->pbufs->outbuf with a "dropped message". This
- * is achieved by shifting the existing message over and inserting the dropped
- * message.
+ * Prepend the message in @pmsg->pbufs->outbuf with the message in
+ * @pmsg->pbufs->scratchbuf. This is achieved by shifting the existing message
+ * over and inserting the scratchbuf message.
  *
  * @pmsg is the printk message to prepend.
  *
- * @dropped is the dropped count to report in the dropped message.
+ * @len is the length of the message in @pmsg->pbufs->scratchbuf.
  *
  * If the message text in @pmsg->pbufs->outbuf does not have enough space for
- * the dropped message, the message text will be sufficiently truncated.
+ * the scratchbuf message, the message text will be sufficiently truncated.
  *
  * If @pmsg->pbufs->outbuf is modified, @pmsg->outbuf_len is updated.
  */
-void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
+static void __console_prepend_scratch(struct printk_message *pmsg, size_t len)
 {
 	struct printk_buffers *pbufs = pmsg->pbufs;
-	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
 	const size_t outbuf_sz = sizeof(pbufs->outbuf);
 	char *scratchbuf = &pbufs->scratchbuf[0];
 	char *outbuf = &pbufs->outbuf[0];
-	size_t len;
-
-	len = scnprintf(scratchbuf, scratchbuf_sz,
-		       "** %lu printk messages dropped **\n", dropped);
 
 	/*
 	 * Make sure outbuf is sufficiently large before prepending.
@@ -2883,6 +2878,46 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 	pmsg->outbuf_len += len;
 }
 
+/*
+ * Prepend the message in @pmsg->pbufs->outbuf with a "dropped message".
+ * @pmsg->outbuf_len is updated appropriately.
+ *
+ * @pmsg is the printk message to prepend.
+ *
+ * @dropped is the dropped count to report in the dropped message.
+ */
+void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
+{
+	struct printk_buffers *pbufs = pmsg->pbufs;
+	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
+	char *scratchbuf = &pbufs->scratchbuf[0];
+	size_t len;
+
+	len = scnprintf(scratchbuf, scratchbuf_sz,
+		       "** %lu printk messages dropped **\n", dropped);
+
+	__console_prepend_scratch(pmsg, len);
+}
+
+/*
+ * Prepend the message in @pmsg->pbufs->outbuf with a "replay message".
+ * @pmsg->outbuf_len is updated appropriately.
+ *
+ * @pmsg is the printk message to prepend.
+ */
+void console_prepend_replay(struct printk_message *pmsg)
+{
+	struct printk_buffers *pbufs = pmsg->pbufs;
+	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
+	char *scratchbuf = &pbufs->scratchbuf[0];
+	size_t len;
+
+	len = scnprintf(scratchbuf, scratchbuf_sz,
+			"** replaying previous printk message **\n");
+
+	__console_prepend_scratch(pmsg, len);
+}
+
 /*
  * Read and format the specified record (or a later record if the specified
  * record is not available).
@@ -2962,7 +2997,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 static inline void printk_legacy_lock_map_acquire_try(void) { }
 static inline void printk_legacy_lock_map_release(void) { }
 #else
-DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
+static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
 
 static inline void printk_legacy_lock_map_acquire_try(void)
 {
@@ -3136,7 +3171,6 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 				printk_seq = nbcon_seq_read(con);
 			} else {
 				progress = console_emit_next_record(con, handover, cookie);
-
 				printk_seq = con->seq;
 			}
 
@@ -3375,7 +3409,7 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		console_srcu_read_unlock(cookie);
 	}
 
-	nbcon_atomic_flush_all();
+	nbcon_atomic_flush_pending();
 
 	if (printing_via_unlock)
 		console_flush_all(false, &next_seq, &handover);
@@ -3634,6 +3668,7 @@ static void try_enable_default_console(struct console *newcon)
 		newcon->flags |= CON_CONSDEV;
 }
 
+/* Set @newcon->seq to the first record this console should print. */
 static void console_init_seq(struct console *newcon, bool bootcon_registered)
 {
 	struct console *con;
@@ -3733,6 +3768,7 @@ void register_console(struct console *newcon)
 	struct console *con;
 	bool bootcon_registered = false;
 	bool realcon_registered = false;
+	unsigned long flags;
 	int err;
 
 	console_list_lock();
@@ -3815,6 +3851,14 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_NBCON) {
 		have_nbcon_console = true;
 		nbcon_init(newcon);
+
+		/*
+		 * nbcon consoles have their own sequence counter. The legacy
+		 * sequence counter is reset so that it is clear it is not
+		 * being used.
+		 */
+		nbcon_seq_force(newcon, newcon->seq);
+		newcon->seq = 0;
 	} else {
 		have_legacy_console = true;
 		nbcon_legacy_kthread_create();
@@ -3823,6 +3867,19 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_BOOT)
 		have_boot_console = true;
 
+	/*
+	 * If another context is actively using the hardware of this new
+	 * console, it will not be aware of the nbcon synchronization. This
+	 * is a risk that two contexts could access the hardware
+	 * simultaneously if this new console is used for atomic printing
+	 * and the other context is still using the hardware.
+	 *
+	 * Use the driver synchronization to ensure that the hardware is not
+	 * in use while this new console transitions to being registered.
+	 */
+	if ((newcon->flags & CON_NBCON) && newcon->write_atomic)
+		newcon->device_lock(newcon, &flags);
+
 	/*
 	 * Put this console in the list - keep the
 	 * preferred driver at the head of the list.
@@ -3847,6 +3904,10 @@ void register_console(struct console *newcon)
 	 * register_console() completes.
 	 */
 
+	/* This new console is now registered. */
+	if ((newcon->flags & CON_NBCON) && newcon->write_atomic)
+		newcon->device_unlock(newcon, flags);
+
 	console_sysfs_notify();
 
 	/*
@@ -3941,11 +4002,11 @@ static int unregister_console_locked(struct console *console)
 			found_legacy_con = true;
 	}
 	if (!found_boot_con)
-		have_boot_console = false;
+		have_boot_console = found_boot_con;
 	if (!found_legacy_con)
-		have_legacy_console = false;
+		have_legacy_console = found_legacy_con;
 	if (!found_nbcon_con)
-		have_nbcon_console = false;
+		have_nbcon_console = found_nbcon_con;
 
 	/*
 	 * When the last boot console unregisters, start up the
@@ -4150,6 +4211,13 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			locked = true;
 		}
 
+		/*
+		 * Ensure the compiler does not optimize @locked to be
+		 * @printing_via_unlock since the latter can change at any
+		 * time.
+		 */
+		barrier();
+
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(c) {
 			if (con && con != c)
@@ -4260,6 +4328,7 @@ static void __wake_up_klogd(int val)
 		return;
 
 	preempt_disable();
+
 	/*
 	 * Guarantee any new records can be seen by tasks preparing to wait
 	 * before this context checks if the wait queue is empty.
@@ -4271,11 +4340,22 @@ static void __wake_up_klogd(int val)
 	 *
 	 * This pairs with devkmsg_read:A and syslog_print:A.
 	 */
-	if (wq_has_sleeper(&log_wait) || /* LMM(__wake_up_klogd:A) */
-	    (val & PRINTK_PENDING_OUTPUT)) {
+	if (!wq_has_sleeper(&log_wait)) /* LMM(__wake_up_klogd:A) */
+		val &= ~PRINTK_PENDING_WAKEUP;
+
+	/*
+	 * Simple read is safe. register_console() would flush a newly
+	 * registered legacy console when writing the message about it
+	 * being enabled.
+	 */
+	if (!printing_via_unlock)
+		val &= ~PRINTK_PENDING_OUTPUT;
+
+	if (val) {
 		this_cpu_or(printk_pending, val);
 		irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	}
+
 	preempt_enable();
 }
 
@@ -4312,11 +4392,7 @@ void defer_console_output(void)
 	 * New messages may have been added directly to the ringbuffer
 	 * using vprintk_store(), so wake any waiters as well.
 	 */
-	int val = PRINTK_PENDING_WAKEUP;
-
-	if (printing_via_unlock)
-		val |= PRINTK_PENDING_OUTPUT;
-	__wake_up_klogd(val);
+	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
 }
 
 void printk_trigger_flush(void)
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 52626d0f1fa37..bd2a892deac1a 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -5,6 +5,8 @@
 
 #include <linux/atomic.h>
 #include <linux/dev_printk.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 
 /*
  * Meta information about each stored message.
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 8d9408d653de5..4421ccac31133 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -29,13 +29,13 @@ void __printk_safe_exit(void)
 void __printk_deferred_enter(void)
 {
 	cant_migrate();
-	this_cpu_inc(printk_context);
+	__printk_safe_enter();
 }
 
 void __printk_deferred_exit(void)
 {
 	cant_migrate();
-	this_cpu_dec(printk_context);
+	__printk_safe_exit();
 }
 
 asmlinkage int vprintk(const char *fmt, va_list args)
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8107f818455da..b17130b7e522d 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -7,6 +7,7 @@
  * Authors: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
+#include <linux/console.h>
 #include <linux/lockdep.h>
 
 static void rcu_exp_handler(void *unused);
@@ -636,6 +637,9 @@ static void synchronize_rcu_expedited_wait(void)
 			return;
 		if (rcu_stall_is_suppressed())
 			continue;
+
+		nbcon_cpu_emergency_enter();
+
 		j = jiffies;
 		rcu_stall_notifier_call_chain(RCU_STALL_NOTIFY_EXP, (void *)(j - jiffies_start));
 		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
@@ -689,6 +693,9 @@ static void synchronize_rcu_expedited_wait(void)
 			rcu_exp_print_detail_task_stall_rnp(rnp);
 		}
 		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
+
+		nbcon_cpu_emergency_exit();
+
 		panic_on_rcu_stall();
 	}
 }
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5887c00e67389..f4d73ca20c768 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -7,9 +7,9 @@
  * Author: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
+#include <linux/console.h>
 #include <linux/kvm_para.h>
 #include <linux/rcu_notifier.h>
-#include <linux/console.h>
 
 //////////////////////////////////////////////////////////////////////////////
 //
@@ -658,11 +658,11 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
+	nbcon_cpu_emergency_exit();
+
 	panic_on_rcu_stall();
 
 	rcu_force_quiescent_state();  /* Kick them all. */
-
-	nbcon_cpu_emergency_exit();
 }
 
 static void print_cpu_stall(unsigned long gps)
@@ -680,6 +680,8 @@ static void print_cpu_stall(unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	/*
 	 * OK, time to rat on ourselves...
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
@@ -708,6 +710,8 @@ static void print_cpu_stall(unsigned long gps)
 			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
+	nbcon_cpu_emergency_exit();
+
 	panic_on_rcu_stall();
 
 	/*
diff --git a/localversion-rt b/localversion-rt
index 22746d6390a42..d79dde624aaac 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt9
+-rt10


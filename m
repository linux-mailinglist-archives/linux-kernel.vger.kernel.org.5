Return-Path: <linux-kernel+bounces-128770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0B1895F75
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43229284AD4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3C715FD0D;
	Tue,  2 Apr 2024 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BACRPbKa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T6bvFuay"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C8115F30B;
	Tue,  2 Apr 2024 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095902; cv=none; b=Ec9ZOi1kjriZ49nDOaEDIJfmtrKSpd/5pJeTswC0u4kIlUtj3BNwNHJAVmPrHWx8DdgztkdPmdcwtFhtubxwcECpT6qLRGpTlMlq6Ht3kFuLr1jSEKrwXuMcLXdEBdAE5692+YEZGgpOrkGGoAnKftM5VHf5cFi26M8J+b2oKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095902; c=relaxed/simple;
	bh=mtGOEUKfUQNAmRmQTQh4Ma6J4SJ6z1AyObI0bodMtgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NADd/TiWU4KkU2PvpGqsKbOnF2lDVBdA9ts2ykvDQcFb4xS6IvBi6R+PVXBnTTQcCOoELSf6tQwq/yc8pT4jGAkM67qX3Q0XTgM9vpyBzb6uWH2VRj3uhc8JP+UEbdocr7v3SS/XPXKLvUJsCjvfXIDb1zq8jWV0SZLMUyjMOsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BACRPbKa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T6bvFuay; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFbsuCl5o+zgXOz4kC55LRN5ZtRf7uxaMfN2yuGp6v8=;
	b=BACRPbKa4EKWfdgPrzKfP22fxcbcn0GXh593LKVkQTeXKx+HfZWUkN7RwmXr/iYvI7bqbo
	FgIvmBGLNNNF7g33/vM/+LXw9Nzl4U+6HXiUY+D7S3uA/VGxSBBVmuojl1nixmwBFGhZYQ
	0VPt2qyhSx50uLXvZmrL6niKfMm5fvpuZOSDl8z10Vt6B1hWIOBUlDB7ghm7rqQPPjdOHq
	TYlc29CunC2gaIznj9NrU1htC5pngoSwZcVyz4rIXd6RnNMcNYnuD5SSIXfYkSTPs6TIhp
	Wd8wyfKMxef5EEESNUECiiH2lRG0C3zyhYBZw0VxZUSYnZgzFbeiXiVMKQBjBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFbsuCl5o+zgXOz4kC55LRN5ZtRf7uxaMfN2yuGp6v8=;
	b=T6bvFuayD1Wkc6Cti/Z4rCW+wZDzH8DyfbJ69pGy93cYf16vwDPewxRlSdcQqe6TjTl2M/
	9Blu/upy18Iug3DQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Fabio Estevam <festevam@denx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v4 09/27] printk: nbcon: Implement processing in port->lock wrapper
Date: Wed,  3 Apr 2024 00:17:11 +0206
Message-Id: <20240402221129.2613843-10-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the port->lock wrappers uart_port_lock(),
uart_port_unlock() (and their variants) only lock/unlock
the spin_lock.

If the port is an nbcon console, the wrappers must also
acquire/release the console and mark the region as unsafe. This
allows general port->lock synchronization to be synchronized
with the nbcon console ownership.

Introduce a new struct nbcon_drvdata within struct console that
provides the necessary components for the port lock wrappers to
acquire the nbcon console and track its ownership.

Also introduce uart_port_set_cons() as a wrapper to set @cons
of a uart_port. The wrapper sets @cons under the port lock in
order to prevent @cons from disappearing while another context
owns the port lock via the port lock wrappers.

Also cleanup the description of the console_srcu_read_flags()
function. It is used by the port lock wrappers to ensure a
console cannot be fully unregistered while another context
owns the port lock via the port lock wrappers.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c |  6 +-
 drivers/tty/serial/amba-pl011.c     |  2 +-
 drivers/tty/serial/serial_core.c    |  2 +-
 include/linux/console.h             | 57 +++++++++++++----
 include/linux/printk.h              | 13 ++++
 include/linux/serial_core.h         | 98 ++++++++++++++++++++++++++++-
 kernel/printk/nbcon.c               | 52 +++++++++++++++
 7 files changed, 212 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index b62ad9006780..41d74ee3d95a 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -627,11 +627,11 @@ static int univ8250_console_setup(struct console *co, char *options)
 
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
 
@@ -689,7 +689,7 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 			continue;
 
 		co->index = i;
-		port->cons = co;
+		uart_port_set_cons(port, co);
 		return serial8250_console_setup(port, options, true);
 	}
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index cf2c890a560f..347aacf8400f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2496,7 +2496,7 @@ static int pl011_console_match(struct console *co, char *name, int idx,
 			continue;
 
 		co->index = i;
-		port->cons = co;
+		uart_port_set_cons(port, co);
 		return pl011_console_setup(co, options);
 	}
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d6a58a9e072a..2652b4d5c944 100644
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
index ad85594e070e..e7c35c686720 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -282,6 +282,25 @@ struct nbcon_write_context {
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
@@ -396,6 +415,21 @@ struct console {
 
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
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
 };
 
@@ -425,28 +459,29 @@ extern void console_list_unlock(void) __releases(console_mutex);
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
index d8b3f51d9e98..0ad3ee752635 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -9,6 +9,8 @@
 #include <linux/ratelimit_types.h>
 #include <linux/once_lite.h>
 
+struct console;
+
 extern const char linux_banner[];
 extern const char linux_proc_banner[];
 
@@ -193,6 +195,8 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+extern void nbcon_driver_acquire(struct console *con);
+extern void nbcon_driver_release(struct console *con);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -272,6 +276,15 @@ static inline void dump_stack(void)
 static inline void printk_trigger_flush(void)
 {
 }
+
+static inline void nbcon_driver_acquire(struct console *con)
+{
+}
+
+static inline void nbcon_driver_release(struct console *con)
+{
+}
+
 #endif
 
 bool this_cpu_in_panic(void);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index bb3324d49453..9a73dee32ad9 100644
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
@@ -606,6 +609,83 @@ static inline void __uart_port_unlock_irqrestore(struct uart_port *up, unsigned
 	spin_unlock_irqrestore(&up->lock, flags);
 }
 
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
@@ -613,6 +693,7 @@ static inline void __uart_port_unlock_irqrestore(struct uart_port *up, unsigned
 static inline void uart_port_lock(struct uart_port *up)
 {
 	spin_lock(&up->lock);
+	__uart_port_nbcon_acquire(up);
 }
 
 /**
@@ -622,6 +703,7 @@ static inline void uart_port_lock(struct uart_port *up)
 static inline void uart_port_lock_irq(struct uart_port *up)
 {
 	spin_lock_irq(&up->lock);
+	__uart_port_nbcon_acquire(up);
 }
 
 /**
@@ -632,6 +714,7 @@ static inline void uart_port_lock_irq(struct uart_port *up)
 static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
 {
 	spin_lock_irqsave(&up->lock, *flags);
+	__uart_port_nbcon_acquire(up);
 }
 
 /**
@@ -642,7 +725,11 @@ static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *f
  */
 static inline bool uart_port_trylock(struct uart_port *up)
 {
-	return spin_trylock(&up->lock);
+	if (!spin_trylock(&up->lock))
+		return false;
+
+	__uart_port_nbcon_acquire(up);
+	return true;
 }
 
 /**
@@ -654,7 +741,11 @@ static inline bool uart_port_trylock(struct uart_port *up)
  */
 static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long *flags)
 {
-	return spin_trylock_irqsave(&up->lock, *flags);
+	if (!spin_trylock_irqsave(&up->lock, *flags))
+		return false;
+
+	__uart_port_nbcon_acquire(up);
+	return true;
 }
 
 /**
@@ -663,6 +754,7 @@ static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long
  */
 static inline void uart_port_unlock(struct uart_port *up)
 {
+	__uart_port_nbcon_release(up);
 	spin_unlock(&up->lock);
 }
 
@@ -672,6 +764,7 @@ static inline void uart_port_unlock(struct uart_port *up)
  */
 static inline void uart_port_unlock_irq(struct uart_port *up)
 {
+	__uart_port_nbcon_release(up);
 	spin_unlock_irq(&up->lock);
 }
 
@@ -682,6 +775,7 @@ static inline void uart_port_unlock_irq(struct uart_port *up)
  */
 static inline void uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
 {
+	__uart_port_nbcon_release(up);
 	spin_unlock_irqrestore(&up->lock, flags);
 }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 2516449f921d..38328cf0fd5c 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -3,9 +3,12 @@
 // Copyright (C) 2022 Intel, Thomas Gleixner
 
 #include <linux/kernel.h>
+#include <linux/bug.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include "internal.h"
 /*
  * Printk console printing implementation for consoles which does not depend
@@ -988,3 +991,52 @@ void nbcon_free(struct console *con)
 
 	con->pbufs = NULL;
 }
+
+/**
+ * nbcon_driver_acquire - Acquire nbcon console and enter unsafe section
+ * @con:	The nbcon console to acquire
+ *
+ * Context:	Any context which could not be migrated to another CPU.
+ *
+ * Console drivers will usually use their own internal synchronization
+ * mechasism to synchronize between console printing and non-printing
+ * activities (such as setting baud rates). However, nbcon console drivers
+ * supporting atomic consoles may also want to mark unsafe sections when
+ * performing non-printing activities.
+ *
+ * This function acquires the nbcon console using priority NBCON_PRIO_NORMAL
+ * and marks it unsafe for handover/takeover.
+ *
+ * Console drivers using this function must have provided @nbcon_drvdata in
+ * their struct console, which is used to track ownership and state
+ * information.
+ */
+void nbcon_driver_acquire(struct console *con)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con->nbcon_drvdata, ctxt);
+
+	cant_migrate();
+
+	do {
+		do {
+			memset(ctxt, 0, sizeof(*ctxt));
+			ctxt->console	= con;
+			ctxt->prio	= NBCON_PRIO_NORMAL;
+		} while (!nbcon_context_try_acquire(ctxt));
+
+	} while (!nbcon_context_enter_unsafe(ctxt));
+}
+EXPORT_SYMBOL_GPL(nbcon_driver_acquire);
+
+/**
+ * nbcon_driver_release - Exit unsafe section and release the nbcon console
+ * @con:	The nbcon console acquired in nbcon_driver_acquire()
+ */
+void nbcon_driver_release(struct console *con)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con->nbcon_drvdata, ctxt);
+
+	if (nbcon_context_exit_unsafe(ctxt))
+		nbcon_context_release(ctxt);
+}
+EXPORT_SYMBOL_GPL(nbcon_driver_release);
-- 
2.39.2



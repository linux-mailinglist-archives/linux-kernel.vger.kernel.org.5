Return-Path: <linux-kernel+bounces-70503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5888598BC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0BE1C20FCC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10B871B2B;
	Sun, 18 Feb 2024 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OxRI2d34";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rsnkb8W7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFAD6F09B;
	Sun, 18 Feb 2024 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282674; cv=none; b=AhgcbfS4eg6HlKfcNVIRC6xeRye+lEQZXd646F84cvdUimRUvJvStzmRq0oUyMvDp6MlbubOxn7fdaNlgguVjUjMQYBp7uk+gI2lSHAXc9tLzSa44G+hA5VZAX2upyIqDVWJBiHO+T7d/7zEQpI6ORJPY/zTNmmSqtEnGUGCvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282674; c=relaxed/simple;
	bh=Uh1a7N6liYSzDazmzjchFNl1uPkqsuEMN7I6bWMM5lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8VK+cZaI17xAQQkQ98GiMYBrhgiKM39ALgkY1ZNze7Dlyr2qCWltIHKtAYy8v1sad4izTkuDFauF7DQPvwUD2bV35QWVSQVKFuheOVyozVa0R4Ay1EulMEGreVrdJerJZDb1rZn6v1Ho3bDzvBEeovBI7AxVc8jiz9Ja2EuFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OxRI2d34; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rsnkb8W7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrTMG/IO2xEuBdqD5OxQ1/ULXhRtRhpYhyRMl+KnF7w=;
	b=OxRI2d34d6eZ84FJ7ek1LsuerkJcVIohMxOCIEONANmxjad1y70ujK/AQkOy/143chnRYk
	axXq9ozPgZaRTxPS2OU7FU/O2GmA4dQqaDAYVnThA0KVqDRntfohKh/LtQmkD6y6C6/PpO
	w5Mo7Fvy6+2N6uBZjtL8dfWxrur03oO6Riby83YgQu9pWCnLN3iuAnBMI0QZ8lP6gIHFqN
	wI3gEXimzNOiRYIOXA7IuqqFHlIQPWrFitlcfb249CDX8ATU6Ne+IliEJ+ba6VDCwX+OcB
	8aTaUpAxr18hbUGOGraqr3e+Caqa7suhJtJvrivhatX1a6gL7hZM8e7x1aOLqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrTMG/IO2xEuBdqD5OxQ1/ULXhRtRhpYhyRMl+KnF7w=;
	b=Rsnkb8W7+dOJGMPJ0e2uA0Qw+jE3lvQlvn7hjAPcJzTKGdemWwBwLWErNiRpjvS9iouHHa
	VyIr8Gp7jlbNNSAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Justin Chen <justin.chen@broadcom.com>,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v2 08/26] printk: nbcon: Implement processing in port->lock wrapper
Date: Sun, 18 Feb 2024 20:03:08 +0106
Message-Id: <20240218185726.1994771-9-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
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

Add a flag to struct uart_port to track nbcon console ownership.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_port.c |  1 +
 include/linux/printk.h              | 13 +++++
 include/linux/serial_core.h         | 19 ++++++-
 kernel/printk/nbcon.c               | 77 +++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 141627370aab..16e2705b4867 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3284,6 +3284,7 @@ void serial8250_init_port(struct uart_8250_port *up)
 	struct uart_port *port = &up->port;
 
 	spin_lock_init(&port->lock);
+	port->nbcon_locked_port = false;
 	port->ctrl_id = 0;
 	port->pm = NULL;
 	port->ops = &serial8250_pops;
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8d5c5588eec9..ef57a4d93ae2 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -9,6 +9,8 @@
 #include <linux/ratelimit_types.h>
 #include <linux/once_lite.h>
 
+struct uart_port;
+
 extern const char linux_banner[];
 extern const char linux_proc_banner[];
 
@@ -195,6 +197,8 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+extern void uart_nbcon_acquire(struct uart_port *up);
+extern void uart_nbcon_release(struct uart_port *up);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -274,6 +278,15 @@ static inline void dump_stack(void)
 static inline void printk_trigger_flush(void)
 {
 }
+
+static inline void uart_nbcon_acquire(struct uart_port *up)
+{
+}
+
+static inline void uart_nbcon_release(struct uart_port *up)
+{
+}
+
 #endif
 
 bool this_cpu_in_panic(void);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 89f7b6c63598..d4b93d721715 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -488,6 +488,7 @@ struct uart_port {
 	struct uart_icount	icount;			/* statistics */
 
 	struct console		*cons;			/* struct console, if any */
+	bool			nbcon_locked_port;	/* True, if the port is locked by nbcon */
 	/* flags must be updated while holding port mutex */
 	upf_t			flags;
 
@@ -595,6 +596,7 @@ struct uart_port {
 static inline void uart_port_lock(struct uart_port *up)
 {
 	spin_lock(&up->lock);
+	uart_nbcon_acquire(up);
 }
 
 /**
@@ -604,6 +606,7 @@ static inline void uart_port_lock(struct uart_port *up)
 static inline void uart_port_lock_irq(struct uart_port *up)
 {
 	spin_lock_irq(&up->lock);
+	uart_nbcon_acquire(up);
 }
 
 /**
@@ -614,6 +617,7 @@ static inline void uart_port_lock_irq(struct uart_port *up)
 static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
 {
 	spin_lock_irqsave(&up->lock, *flags);
+	uart_nbcon_acquire(up);
 }
 
 /**
@@ -624,7 +628,11 @@ static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *f
  */
 static inline bool uart_port_trylock(struct uart_port *up)
 {
-	return spin_trylock(&up->lock);
+	if (!spin_trylock(&up->lock))
+		return false;
+
+	uart_nbcon_acquire(up);
+	return true;
 }
 
 /**
@@ -636,7 +644,11 @@ static inline bool uart_port_trylock(struct uart_port *up)
  */
 static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long *flags)
 {
-	return spin_trylock_irqsave(&up->lock, *flags);
+	if (!spin_trylock_irqsave(&up->lock, *flags))
+		return false;
+
+	uart_nbcon_acquire(up);
+	return true;
 }
 
 /**
@@ -645,6 +657,7 @@ static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long
  */
 static inline void uart_port_unlock(struct uart_port *up)
 {
+	uart_nbcon_release(up);
 	spin_unlock(&up->lock);
 }
 
@@ -654,6 +667,7 @@ static inline void uart_port_unlock(struct uart_port *up)
  */
 static inline void uart_port_unlock_irq(struct uart_port *up)
 {
+	uart_nbcon_release(up);
 	spin_unlock_irq(&up->lock);
 }
 
@@ -664,6 +678,7 @@ static inline void uart_port_unlock_irq(struct uart_port *up)
  */
 static inline void uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
 {
+	uart_nbcon_release(up);
 	spin_unlock_irqrestore(&up->lock, flags);
 }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 8ecd76aa22e6..02e8fdc1ea43 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -6,6 +6,7 @@
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/serial_core.h>
 #include "internal.h"
 /*
  * Printk console printing implementation for consoles which does not depend
@@ -995,3 +996,79 @@ void nbcon_free(struct console *con)
 
 	con->pbufs = NULL;
 }
+
+static inline bool uart_is_nbcon(struct uart_port *up)
+{
+	int cookie;
+	bool ret;
+
+	if (!uart_console(up))
+		return false;
+
+	cookie = console_srcu_read_lock();
+	ret = (console_srcu_read_flags(up->cons) & CON_NBCON);
+	console_srcu_read_unlock(cookie);
+	return ret;
+}
+
+/**
+ * uart_nbcon_acquire - The second half of the port locking wrapper
+ * @up:		The uart port whose @lock was locked
+ *
+ * The uart_port_lock() wrappers will first lock the spin_lock @up->lock.
+ * Then this function is called to implement nbcon-specific processing.
+ *
+ * If @up is an nbcon console, this console will be acquired and marked as
+ * unsafe. Otherwise this function does nothing.
+ */
+void uart_nbcon_acquire(struct uart_port *up)
+{
+	struct console *con = up->cons;
+	struct nbcon_context ctxt;
+
+	if (!uart_is_nbcon(up))
+		return;
+
+	WARN_ON_ONCE(up->nbcon_locked_port);
+
+	do {
+		do {
+			memset(&ctxt, 0, sizeof(ctxt));
+			ctxt.console	= con;
+			ctxt.prio	= NBCON_PRIO_NORMAL;
+		} while (!nbcon_context_try_acquire(&ctxt));
+
+	} while (!nbcon_context_enter_unsafe(&ctxt));
+
+	up->nbcon_locked_port = true;
+}
+EXPORT_SYMBOL_GPL(uart_nbcon_acquire);
+
+/**
+ * uart_nbcon_release - The first half of the port unlocking wrapper
+ * @up:		The uart port whose @lock is about to be unlocked
+ *
+ * The uart_port_unlock() wrappers will first call this function to implement
+ * nbcon-specific processing. Then afterwards the uart_port_unlock() wrappers
+ * will unlock the spin_lock @up->lock.
+ *
+ * If @up is an nbcon console, the console will be marked as safe and
+ * released. Otherwise this function does nothing.
+ */
+void uart_nbcon_release(struct uart_port *up)
+{
+	struct console *con = up->cons;
+	struct nbcon_context ctxt = {
+		.console	= con,
+		.prio		= NBCON_PRIO_NORMAL,
+	};
+
+	if (!up->nbcon_locked_port)
+		return;
+
+	if (nbcon_context_exit_unsafe(&ctxt))
+		nbcon_context_release(&ctxt);
+
+	up->nbcon_locked_port = false;
+}
+EXPORT_SYMBOL_GPL(uart_nbcon_release);
-- 
2.39.2



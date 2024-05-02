Return-Path: <linux-kernel+bounces-166960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06658BA274
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0441F215AE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537DB1C6892;
	Thu,  2 May 2024 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WxHBLqXI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9+i/8QDR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1ED1A0AE6;
	Thu,  2 May 2024 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685931; cv=none; b=qPbt1HF56XIN4WeAh2CyiAvYHnbmAhBfTMF/+4Bov9yBn2q4OBErJt8HJ7yZu+64xAsUiMRuWOGuL9JwIKjFc642kkUBqUSYYMZPeTZ8kF+cIb7u5Kup9Hmn+wiEYZAc2DVfD1oIPc9x/QFLGEvhKqJeVAa1mKIvDmVlBQ9FoVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685931; c=relaxed/simple;
	bh=3RNIRC95YwkSxio89zLt/lJIBzFyR9QneWMaF/wgmVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eLSXfr1B8c7P7xIe6vY1uXmSMMGgJiwjLE7khKihs3d7GGPlhClva61EDXT+jM6U30f0T6aqEAmPoIlxp5un9b+EtmU84maiy7Wyqz0dx6nLxAf6yExqXj9+fzX26e08552Lbmv00KuYBVyF5hK3Hk2qWLjwVYk1E3KKvdNt0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WxHBLqXI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9+i/8QDR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eaATRs9117EMzRD+7tFfr5M9kuNyDlYTa2bO2w7iv9A=;
	b=WxHBLqXIocUmwhU1GouBuCrQo/8ClFBUs4OhpstrHP4GJPx3wxkttlr3eQJhAyAEuSqLse
	kdIiwRTcuR05a+YiJYtTzc9croJZZm51tVAP5rpOhH/FblB0ObA6WeMxAdhI6o1vXXWR85
	ANoax2tdUmZ6ghpZpM0kT2NcYgvvwJZVZiwiJcphTKb6GSE9pa1gq393fiq/9ZyoibFVFE
	KfmUAodV4MpmjyxHHCOTuJSFQF4pBElOLWQlVLY8pk709J93L3XGKUI8zCyDQC93bSasK5
	OzLhV09GpLy76fMTrdZswsXXVSv1uhG8SJNMw8Fnbd5PfeOu8d9sVkcFS29Ufg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eaATRs9117EMzRD+7tFfr5M9kuNyDlYTa2bO2w7iv9A=;
	b=9+i/8QDRVKjQIJsdY6A+lbKZvBCvovWh77aZ6GZrUED3vse0MTixwhqlhigo1fQlaAA0py
	lheZLOL6fmcw/lDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hongyu Xie <xiehongyu1@kylinos.cn>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v5 09/30] serial: core: Introduce wrapper to set @uart_port->cons
Date: Thu,  2 May 2024 23:44:18 +0206
Message-Id: <20240502213839.376636-10-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce uart_port_set_cons() as a wrapper to set @cons of a
uart_port. The wrapper sets @cons under the port lock in order
to prevent @cons from disappearing while another context is
holding the port lock. This is necessary for a follow-up
commit relating to the port lock wrappers, which rely on @cons
not changing between lock and unlock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c |  6 +++---
 drivers/tty/serial/amba-pl011.c     |  2 +-
 drivers/tty/serial/serial_core.c    | 16 ++++++++--------
 include/linux/serial_core.h         | 17 +++++++++++++++++
 4 files changed, 29 insertions(+), 12 deletions(-)

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
index d6a58a9e072a..0c13ea6a3afa 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3145,8 +3145,15 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	state->uart_port = uport;
 	uport->state = state;
 
+	/*
+	 * If this port is in use as a console then the spinlock is already
+	 * initialised.
+	 */
+	if (!uart_console_registered(uport))
+		uart_port_spin_lock_init(uport);
+
 	state->pm_state = UART_PM_STATE_UNDEFINED;
-	uport->cons = drv->cons;
+	uart_port_set_cons(uport, drv->cons);
 	uport->minor = drv->tty_driver->minor_start + uport->line;
 	uport->name = kasprintf(GFP_KERNEL, "%s%d", drv->dev_name,
 				drv->tty_driver->name_base + uport->line);
@@ -3155,13 +3162,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 		goto out;
 	}
 
-	/*
-	 * If this port is in use as a console then the spinlock is already
-	 * initialised.
-	 */
-	if (!uart_console_registered(uport))
-		uart_port_spin_lock_init(uport);
-
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index bb3324d49453..038693774f21 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -606,6 +606,23 @@ static inline void __uart_port_unlock_irqrestore(struct uart_port *up, unsigned
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
 /**
  * uart_port_lock - Lock the UART port
  * @up:		Pointer to UART port structure
-- 
2.39.2



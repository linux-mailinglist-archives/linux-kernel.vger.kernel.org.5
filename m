Return-Path: <linux-kernel+bounces-121226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B2788E426
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B961C2B80D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58261411DF;
	Wed, 27 Mar 2024 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNJchuxA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCB1411D0;
	Wed, 27 Mar 2024 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542399; cv=none; b=RUoUKxu3k69MXfEEEfp6LsAzQcVu4wvm3enkeOBl/YzSaGmFM2L9H+1prLQ0QCx6dbWKw/Y/OVr6o56C37lMqrqq0+hms9N/q4deevBZUT5pGuN31MlZ1U6EZcZVjrrlA7oCQ2vLbUbBp4iNULUwluDtfgwLOmyX7B8ZgZpG1Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542399; c=relaxed/simple;
	bh=Bqu2hl0JtlSjthW01bczpNl7+e3+8YdJrSpVEmEBO3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdYgfUcCMtaJflR19DgCfSNLekqvnccVz5agiTL30mq7dIPvh0oGQZqdLmDXaV6SAPnQftjPfU8s8mvvSjr+03QhubEwhWPuMAPyqUBkeob+DvBPTUeJPbad6LyW6SPGGhdK5VeDjT3DDZUvAp4+hjlzg/go4u1qS+RXM+cDzm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNJchuxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED98CC43390;
	Wed, 27 Mar 2024 12:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542399;
	bh=Bqu2hl0JtlSjthW01bczpNl7+e3+8YdJrSpVEmEBO3s=;
	h=From:To:Cc:Subject:Date:From;
	b=vNJchuxAw9LEhB2phjuhAi13YEGsSyRWsl10yeWaqze0JumTfUro+QV39LJOCr3fI
	 CebpZI0Dudo9NCZ+zr0Gol2TlBVHdsawwu++/XCCQfO4Yg0NSxRkHc4JmdxzqdEot3
	 8/qNi8koZFlW3cBThZ5CBgkr2vnGFTPpe8q3GnuZfAi2H8sdxChuWWMDN5FLl1WgyD
	 PEmxPARQSQQlso00Yj0YW9EQ4+SeebWtVQSxav6bu90cYt3W570RyIZVaQ90aohMTE
	 abE9F74XKyr2wM9/3MGp08yftNNkkxsEukwvb7jMX50eIOOM3jd6VJk1TBjlEabtbp
	 yROvlvZsN1wQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pcc@google.com
Cc: John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: FAILED: Patch "serial: Lock console when calling into driver before registration" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:26:35 -0400
Message-ID: <20240327122638.2841224-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 801410b26a0e8b8a16f7915b2b55c9528b69ca87 Mon Sep 17 00:00:00 2001
From: Peter Collingbourne <pcc@google.com>
Date: Mon, 4 Mar 2024 13:43:49 -0800
Subject: [PATCH] serial: Lock console when calling into driver before
 registration

During the handoff from earlycon to the real console driver, we have
two separate drivers operating on the same device concurrently. In the
case of the 8250 driver these concurrent accesses cause problems due
to the driver's use of banked registers, controlled by LCR.DLAB. It is
possible for the setup(), config_port(), pm() and set_mctrl() callbacks
to set DLAB, which can cause the earlycon code that intends to access
TX to instead access DLL, leading to missed output and corruption on
the serial line due to unintended modifications to the baud rate.

In particular, for setup() we have:

univ8250_console_setup()
-> serial8250_console_setup()
-> uart_set_options()
-> serial8250_set_termios()
-> serial8250_do_set_termios()
-> serial8250_do_set_divisor()

For config_port() we have:

serial8250_config_port()
-> autoconfig()

For pm() we have:

serial8250_pm()
-> serial8250_do_pm()
-> serial8250_set_sleep()

For set_mctrl() we have (for some devices):

serial8250_set_mctrl()
-> omap8250_set_mctrl()
-> __omap8250_set_mctrl()

To avoid such problems, let's make it so that the console is locked
during pre-registration calls to these callbacks, which will prevent
the earlycon driver from running concurrently.

Remove the partial solution to this problem in the 8250 driver
that locked the console only during autoconfig_irq(), as this would
result in a deadlock with the new approach. The console continues
to be locked during autoconfig_irq() because it can only be called
through uart_configure_port().

Although this patch introduces more locking than strictly necessary
(and in particular it also locks during the call to rs485_config()
which is not affected by this issue as far as I can tell), it follows
the principle that it is the responsibility of the generic console
code to manage the earlycon handoff by ensuring that earlycon and real
console driver code cannot run concurrently, and not the individual
drivers.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Link: https://linux-review.googlesource.com/id/I7cf8124dcebf8618e6b2ee543fa5b25532de55d8
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240304214350.501253-1-pcc@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_port.c |  6 ------
 drivers/tty/serial/serial_core.c    | 12 ++++++++++++
 kernel/printk/printk.c              | 21 ++++++++++++++++++---
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 336a0bd4d172a..fc9dd5d45295d 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1325,9 +1325,6 @@ static void autoconfig_irq(struct uart_8250_port *up)
 		inb_p(ICP);
 	}
 
-	if (uart_console(port))
-		console_lock();
-
 	/* forget possible initially masked and pending IRQ */
 	probe_irq_off(probe_irq_on());
 	save_mcr = serial8250_in_MCR(up);
@@ -1367,9 +1364,6 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	if (port->flags & UPF_FOURPORT)
 		outb_p(save_ICP, ICP);
 
-	if (uart_console(port))
-		console_unlock();
-
 	port->irq = (irq > 0) ? irq : 0;
 }
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d6a58a9e072a1..ff85ebd3a007d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2608,7 +2608,12 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 			port->type = PORT_UNKNOWN;
 			flags |= UART_CONFIG_TYPE;
 		}
+		/* Synchronize with possible boot console. */
+		if (uart_console(port))
+			console_lock();
 		port->ops->config_port(port, flags);
+		if (uart_console(port))
+			console_unlock();
 	}
 
 	if (port->type != PORT_UNKNOWN) {
@@ -2616,6 +2621,10 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 
 		uart_report_port(drv, port);
 
+		/* Synchronize with possible boot console. */
+		if (uart_console(port))
+			console_lock();
+
 		/* Power up port for set_mctrl() */
 		uart_change_pm(state, UART_PM_STATE_ON);
 
@@ -2632,6 +2641,9 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 
 		uart_rs485_config(port);
 
+		if (uart_console(port))
+			console_unlock();
+
 		/*
 		 * If this driver supports console, and it hasn't been
 		 * successfully registered yet, try to re-register it.
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f2444b581e16c..89f2aa2e1172f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3263,6 +3263,21 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+static int console_call_setup(struct console *newcon, char *options)
+{
+	int err;
+
+	if (!newcon->setup)
+		return 0;
+
+	/* Synchronize with possible boot console. */
+	console_lock();
+	err = newcon->setup(newcon, options);
+	console_unlock();
+
+	return err;
+}
+
 /*
  * This is called by register_console() to try to match
  * the newly registered console with any of the ones selected
@@ -3298,8 +3313,8 @@ static int try_enable_preferred_console(struct console *newcon,
 			if (_braille_register_console(newcon, c))
 				return 0;
 
-			if (newcon->setup &&
-			    (err = newcon->setup(newcon, c->options)) != 0)
+			err = console_call_setup(newcon, c->options);
+			if (err)
 				return err;
 		}
 		newcon->flags |= CON_ENABLED;
@@ -3325,7 +3340,7 @@ static void try_enable_default_console(struct console *newcon)
 	if (newcon->index < 0)
 		newcon->index = 0;
 
-	if (newcon->setup && newcon->setup(newcon, NULL) != 0)
+	if (console_call_setup(newcon, NULL) != 0)
 		return;
 
 	newcon->flags |= CON_ENABLED;
-- 
2.43.0






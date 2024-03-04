Return-Path: <linux-kernel+bounces-90679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54547870344
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3EA41F2370F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B613F9CB;
	Mon,  4 Mar 2024 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r2wQfZjL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nAiQt8xO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD33EA83;
	Mon,  4 Mar 2024 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560197; cv=none; b=MIHh9CuUA57f9c8vYr0QEMGoue4SmGfWIkfRe0gzx3ACpd1sY6cc4XAA+4xBN7NKOUnILp9/cg4W+e2IVCkRIcqk0BP58LVGPzEbNfigXD/88d3apsqgMip//7ExtOzUq6TyH60NJcNVdvCIuPvKYA5WlO6et08dF+pXgn9VD/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560197; c=relaxed/simple;
	bh=2ofoTOfZcewgF+rtz4JdOKDkeH8IAgzg4lieuen/AgU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c3z4lVlYS1zupeteo2s6HavFkzVQh1wFF6+buR3cm9gmTmDlJYuVvm4o+HrvE6hvy+A7jEKNzIPP/iO1JniAq01tu5Uy8LJQlB4jLePMb/PY1I3KzpZLHwQrElF1au9e8qokuANVhZIwjxAAdOYTjVeRz2l3VWxvtuFWhZB8br8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r2wQfZjL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nAiQt8xO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 4 Mar 2024 14:49:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709560193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=lHxH3Q2RKQu8OquCyYAQz47aeyCqmiKVbix7DY6QmbU=;
	b=r2wQfZjLIhj5BjkaYKbSzvosocIEsvoPKr/WN3UXRTfoqrOC3bXlej0Pd6F+ofsd+FdPOj
	h9maGIqAgyhvNlIOlPmb6ebktK35h7YxMNA9YPAfSUMwhZ6rs0294hZU3pjJ8ZkmCwuf6h
	apstwU7H0mnhpb+3HHnP3cGyyvwtmH2y+aHO//P4EsUpOagOM6XFQrfxKLlgUyw/6+53eL
	C2ylxbxd9ysk6/ixLjkfQQqUdygx8PPgUMn58DRw/vCKglFaMO4Z+UUifrx+Uih1YLGokQ
	MBlQNryRpgS44jVpvsWqTWPUHG6n9qOLYwV6dXd0Y+Skx0gojOTPewRiLSrSMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709560193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=lHxH3Q2RKQu8OquCyYAQz47aeyCqmiKVbix7DY6QmbU=;
	b=nAiQt8xO8254qPUevZ9+cipIxOl+zO1v9YIAdcYFe60O3Z1/lKykwmhZy1w51nOO4TdD0Y
	m2FLIKTkikT6RYAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.8-rc7-rt6
Message-ID: <20240304134951.FXk4CEYI@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.8-rc7-rt6 patch set. 

Changes since v6.8-rc7-rt5:

  - Check all serial driver for the problematic lock pattern in their
    console_write() function and replace if existing.

  - Pierre Gondois reported crashes on ARM64 together with "rtla timerlat
    hist" as trigger. It is not yet understood. The report is at
	https://lore.kernel.org/70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com

    This report is now removed from the list because Pierre can not
    reproduce it anymore in the original setup.
        https://lore.kernel.org/1ae5b9e6-9eb4-49a5-8cfc-46359c8d74c3@arm.com

Known issues
    - None

The delta patch against v6.8-rc7-rt5 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/incr/patch-6.8-rc7-rt5-rt6.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.8-rc7-rt6

The RT patch against v6.8-rc7 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/older/patch-6.8-rc7-rt6.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/older/patches-6.8-rc7-rt6.tar.xz

Sebastian

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index b1f7f5ffff512..2fa3fb30dc6c7 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -348,10 +348,7 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 				flag = TTY_FRAME;
 		}
 
-		uart_port_unlock(&uap->port);
-		sysrq = uart_handle_sysrq_char(&uap->port, ch & 255);
-		uart_port_lock(&uap->port);
-
+		sysrq = uart_prepare_sysrq_char(&uap->port, ch & 255);
 		if (!sysrq)
 			uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
 	}
@@ -1017,7 +1014,7 @@ static void pl011_dma_rx_callback(void *data)
 	ret = pl011_dma_rx_trigger_dma(uap);
 
 	pl011_dma_rx_chars(uap, pending, lastbuf, false);
-	uart_port_unlock_irq(&uap->port);
+	uart_unlock_and_check_sysrq(&uap->port);
 	/*
 	 * Do this check after we picked the DMA chars so we don't
 	 * get some IRQ immediately from RX.
@@ -1540,11 +1537,10 @@ static void check_apply_cts_event_workaround(struct uart_amba_port *uap)
 static irqreturn_t pl011_int(int irq, void *dev_id)
 {
 	struct uart_amba_port *uap = dev_id;
-	unsigned long flags;
 	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
 	int handled = 0;
 
-	uart_port_lock_irqsave(&uap->port, &flags);
+	uart_port_lock(&uap->port);
 	status = pl011_read(uap, REG_RIS) & uap->im;
 	if (status) {
 		do {
@@ -1573,7 +1569,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 		handled = 1;
 	}
 
-	uart_port_unlock_irqrestore(&uap->port, flags);
+	uart_unlock_and_check_sysrq(&uap->port);
 
 	return IRQ_RETVAL(handled);
 }
@@ -2322,7 +2318,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 
 	clk_enable(uap->clk);
 
-	if (uap->port.sysrq || oops_in_progress)
+	if (oops_in_progress)
 		locked = uart_port_trylock_irqsave(&uap->port, &flags);
 	else
 		uart_port_lock_irqsave(&uap->port, &flags);
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 8d09ace062e59..7790cbc57391a 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -378,7 +378,7 @@ static void ar933x_uart_rx_chars(struct ar933x_uart_port *up)
 		up->port.icount.rx++;
 		ch = rdata & AR933X_UART_DATA_TX_RX_MASK;
 
-		if (uart_handle_sysrq_char(&up->port, ch))
+		if (uart_prepare_sysrq_char(&up->port, ch))
 			continue;
 
 		if ((up->port.ignore_status_mask & AR933X_DUMMY_STATUS_RD) == 0)
@@ -468,7 +468,7 @@ static irqreturn_t ar933x_uart_interrupt(int irq, void *dev_id)
 		ar933x_uart_tx_chars(up);
 	}
 
-	uart_port_unlock(&up->port);
+	uart_unlock_and_check_sysrq(&up->port);
 
 	return IRQ_HANDLED;
 }
@@ -627,14 +627,10 @@ static void ar933x_uart_console_write(struct console *co, const char *s,
 	unsigned int int_en;
 	int locked = 1;
 
-	local_irq_save(flags);
-
-	if (up->port.sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = uart_port_trylock(&up->port);
+	if (oops_in_progress)
+		locked = uart_port_trylock_irqsave(&up->port, &flags);
 	else
-		uart_port_lock(&up->port);
+		uart_port_lock_irqsave(&up->port, &flags);
 
 	/*
 	 * First save the IER then disable the interrupts
@@ -654,9 +650,7 @@ static void ar933x_uart_console_write(struct console *co, const char *s,
 	ar933x_uart_write(up, AR933X_UART_INT_REG, AR933X_UART_INT_ALLINTS);
 
 	if (locked)
-		uart_port_unlock(&up->port);
-
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 static int ar933x_uart_console_setup(struct console *co, char *options)
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index a3cefa153456d..34801a6f300b6 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -285,10 +285,9 @@ static void bcm_uart_do_rx(struct uart_port *port)
 				flag = TTY_PARITY;
 		}
 
-		if (uart_handle_sysrq_char(port, c))
+		if (uart_prepare_sysrq_char(port, c))
 			continue;
 
-
 		if ((cstat & port->ignore_status_mask) == 0)
 			tty_insert_flip_char(tty_port, c, flag);
 
@@ -353,7 +352,7 @@ static irqreturn_t bcm_uart_interrupt(int irq, void *dev_id)
 					       estat & UART_EXTINP_DCD_MASK);
 	}
 
-	uart_port_unlock(port);
+	uart_unlock_and_check_sysrq(port);
 	return IRQ_HANDLED;
 }
 
@@ -703,20 +702,14 @@ static void bcm_console_write(struct console *co, const char *s,
 {
 	struct uart_port *port;
 	unsigned long flags;
-	int locked;
+	int locked = 1;
 
 	port = &ports[co->index];
 
-	local_irq_save(flags);
-	if (port->sysrq) {
-		/* bcm_uart_interrupt() already took the lock */
-		locked = 0;
-	} else if (oops_in_progress) {
-		locked = uart_port_trylock(port);
-	} else {
-		uart_port_lock(port);
-		locked = 1;
-	}
+	if (oops_in_progress)
+		locked = uart_port_trylock_irqsave(port, &flags);
+	else
+		uart_port_lock_irqsave(port, &flags);
 
 	/* call helper to deal with \r\n */
 	uart_console_write(port, s, count, bcm_console_putchar);
@@ -725,8 +718,7 @@ static void bcm_console_write(struct console *co, const char *s,
 	wait_for_xmitr(port);
 
 	if (locked)
-		uart_port_unlock(port);
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
 
 /*
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index ec20329f06036..e70fa59dbcc3b 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -136,20 +136,16 @@ static void lpc32xx_hsuart_console_write(struct console *co, const char *s,
 	int locked = 1;
 
 	touch_nmi_watchdog();
-	local_irq_save(flags);
-	if (up->port.sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = uart_port_trylock(&up->port);
+	if (oops_in_progress)
+		locked = uart_port_trylock_irqsave(&up->port, &flags);
 	else
-		uart_port_lock(&up->port);
+		uart_port_lock_irqsave(&up->port, &flags);
 
 	uart_console_write(&up->port, s, count, lpc32xx_hsuart_console_putchar);
 	wait_for_xmit_empty(&up->port);
 
 	if (locked)
-		uart_port_unlock(&up->port);
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 static int __init lpc32xx_hsuart_console_setup(struct console *co,
@@ -268,7 +264,8 @@ static void __serial_lpc32xx_rx(struct uart_port *port)
 			tty_insert_flip_char(tport, 0, TTY_FRAME);
 		}
 
-		tty_insert_flip_char(tport, (tmp & 0xFF), flag);
+		if (!uart_prepare_sysrq_char(port, tmp & 0xff))
+			tty_insert_flip_char(tport, (tmp & 0xFF), flag);
 
 		tmp = readl(LPC32XX_HSUART_FIFO(port->membase));
 	}
@@ -333,7 +330,7 @@ static irqreturn_t serial_lpc32xx_interrupt(int irq, void *dev_id)
 		__serial_lpc32xx_tx(port);
 	}
 
-	uart_port_unlock(port);
+	uart_unlock_and_check_sysrq(port);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 8395688f5ee92..6feac459c0cf4 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -220,7 +220,7 @@ static void meson_receive_chars(struct uart_port *port)
 				continue;
 		}
 
-		if (uart_handle_sysrq_char(port, ch))
+		if (uart_prepare_sysrq_char(port, ch))
 			continue;
 
 		if ((status & port->ignore_status_mask) == 0)
@@ -248,7 +248,7 @@ static irqreturn_t meson_uart_interrupt(int irq, void *dev_id)
 			meson_uart_start_tx(port);
 	}
 
-	uart_port_unlock(port);
+	uart_unlock_and_check_sysrq(port);
 
 	return IRQ_HANDLED;
 }
@@ -556,18 +556,13 @@ static void meson_serial_port_write(struct uart_port *port, const char *s,
 				    u_int count)
 {
 	unsigned long flags;
-	int locked;
+	int locked = 1;
 	u32 val, tmp;
 
-	local_irq_save(flags);
-	if (port->sysrq) {
-		locked = 0;
-	} else if (oops_in_progress) {
-		locked = uart_port_trylock(port);
-	} else {
-		uart_port_lock(port);
-		locked = 1;
-	}
+	if (oops_in_progress)
+		locked = uart_port_trylock_irqsave(port, &flags);
+	else
+		uart_port_lock_irqsave(port, &flags);
 
 	val = readl(port->membase + AML_UART_CONTROL);
 	tmp = val & ~(AML_UART_TX_INT_EN | AML_UART_RX_INT_EN);
@@ -577,8 +572,7 @@ static void meson_serial_port_write(struct uart_port *port, const char *s,
 	writel(val, port->membase + AML_UART_CONTROL);
 
 	if (locked)
-		uart_port_unlock(port);
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
 
 static void meson_serial_console_write(struct console *co, const char *s,
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index e24204ad35def..d27c4c8c84e13 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -588,16 +588,14 @@ static void msm_complete_rx_dma(void *args)
 		if (!(port->read_status_mask & MSM_UART_SR_RX_BREAK))
 			flag = TTY_NORMAL;
 
-		uart_port_unlock_irqrestore(port, flags);
-		sysrq = uart_handle_sysrq_char(port, dma->virt[i]);
-		uart_port_lock_irqsave(port, &flags);
+		sysrq = uart_prepare_sysrq_char(port, dma->virt[i]);
 		if (!sysrq)
 			tty_insert_flip_char(tport, dma->virt[i], flag);
 	}
 
 	msm_start_rx_dma(msm_port);
 done:
-	uart_port_unlock_irqrestore(port, flags);
+	uart_unlock_and_check_sysrq_irqrestore(port, flags);
 
 	if (count)
 		tty_flip_buffer_push(tport);
@@ -763,9 +761,7 @@ static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
 			if (!(port->read_status_mask & MSM_UART_SR_RX_BREAK))
 				flag = TTY_NORMAL;
 
-			uart_port_unlock(port);
-			sysrq = uart_handle_sysrq_char(port, buf[i]);
-			uart_port_lock(port);
+			sysrq = uart_prepare_sysrq_char(port, buf[i]);
 			if (!sysrq)
 				tty_insert_flip_char(tport, buf[i], flag);
 		}
@@ -825,9 +821,7 @@ static void msm_handle_rx(struct uart_port *port)
 		else if (sr & MSM_UART_SR_PAR_FRAME_ERR)
 			flag = TTY_FRAME;
 
-		uart_port_unlock(port);
-		sysrq = uart_handle_sysrq_char(port, c);
-		uart_port_lock(port);
+		sysrq = uart_prepare_sysrq_char(port, c);
 		if (!sysrq)
 			tty_insert_flip_char(tport, c, flag);
 	}
@@ -948,11 +942,10 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
 	struct uart_port *port = dev_id;
 	struct msm_port *msm_port = to_msm_port(port);
 	struct msm_dma *dma = &msm_port->rx_dma;
-	unsigned long flags;
 	unsigned int misr;
 	u32 val;
 
-	uart_port_lock_irqsave(port, &flags);
+	uart_port_lock(port);
 	misr = msm_read(port, MSM_UART_MISR);
 	msm_write(port, 0, MSM_UART_IMR); /* disable interrupt */
 
@@ -984,7 +977,7 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
 		msm_handle_delta_cts(port);
 
 	msm_write(port, msm_port->imr, MSM_UART_IMR); /* restore interrupt */
-	uart_port_unlock_irqrestore(port, flags);
+	uart_unlock_and_check_sysrq(port);
 
 	return IRQ_HANDLED;
 }
@@ -1621,14 +1614,10 @@ static void __msm_console_write(struct uart_port *port, const char *s,
 			num_newlines++;
 	count += num_newlines;
 
-	local_irq_save(flags);
-
-	if (port->sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = uart_port_trylock(port);
+	if (oops_in_progress)
+		locked = uart_port_trylock_irqsave(port, &flags);
 	else
-		uart_port_lock(port);
+		uart_port_lock_irqsave(port, &flags);
 
 	if (is_uartdm)
 		msm_reset_dm_count(port, count);
@@ -1667,9 +1656,7 @@ static void __msm_console_write(struct uart_port *port, const char *s,
 	}
 
 	if (locked)
-		uart_port_unlock(port);
-
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
 
 static void msm_console_write(struct console *co, const char *s,
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index c7a039a977cf7..9be1c871cf116 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -508,7 +508,7 @@ static void serial_omap_rdi(struct uart_omap_port *up, unsigned int lsr)
 
 	up->port.icount.rx++;
 
-	if (uart_handle_sysrq_char(&up->port, ch))
+	if (uart_prepare_sysrq_char(&up->port, ch))
 		return;
 
 	uart_insert_char(&up->port, lsr, UART_LSR_OE, ch, TTY_NORMAL);
@@ -563,7 +563,7 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 		}
 	} while (max_count--);
 
-	uart_port_unlock(&up->port);
+	uart_unlock_and_check_sysrq(&up->port);
 
 	tty_flip_buffer_push(&up->port.state->port);
 
@@ -1212,7 +1212,7 @@ serial_omap_console_write(struct console *co, const char *s,
 	unsigned int ier;
 	int locked = 1;
 
-	if (up->port.sysrq || oops_in_progress)
+	if (oops_in_progress)
 		locked = uart_port_trylock_irqsave(&up->port, &flags);
 	else
 		uart_port_lock_irqsave(&up->port, &flags);
diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index d9fe85397741d..8b60ac0ad7cd3 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -199,6 +199,7 @@ static void owl_uart_receive_chars(struct uart_port *port)
 	stat = owl_uart_read(port, OWL_UART_STAT);
 	while (!(stat & OWL_UART_STAT_RFEM)) {
 		char flag = TTY_NORMAL;
+		bool sysrq;
 
 		if (stat & OWL_UART_STAT_RXER)
 			port->icount.overrun++;
@@ -217,7 +218,9 @@ static void owl_uart_receive_chars(struct uart_port *port)
 		val = owl_uart_read(port, OWL_UART_RXDAT);
 		val &= 0xff;
 
-		if ((stat & port->ignore_status_mask) == 0)
+		sysrq = uart_prepare_sysrq_char(port, val);
+
+		if (!sysrq && (stat & port->ignore_status_mask) == 0)
 			tty_insert_flip_char(&port->state->port, val, flag);
 
 		stat = owl_uart_read(port, OWL_UART_STAT);
@@ -229,10 +232,9 @@ static void owl_uart_receive_chars(struct uart_port *port)
 static irqreturn_t owl_uart_irq(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
-	unsigned long flags;
 	u32 stat;
 
-	uart_port_lock_irqsave(port, &flags);
+	uart_port_lock(port);
 
 	stat = owl_uart_read(port, OWL_UART_STAT);
 
@@ -246,7 +248,7 @@ static irqreturn_t owl_uart_irq(int irq, void *dev_id)
 	stat |= OWL_UART_STAT_RIP | OWL_UART_STAT_TIP;
 	owl_uart_write(port, stat, OWL_UART_STAT);
 
-	uart_port_unlock_irqrestore(port, flags);
+	uart_unlock_and_check_sysrq(port);
 
 	return IRQ_HANDLED;
 }
@@ -508,18 +510,12 @@ static void owl_uart_port_write(struct uart_port *port, const char *s,
 {
 	u32 old_ctl, val;
 	unsigned long flags;
-	int locked;
+	int locked = 1;
 
-	local_irq_save(flags);
-
-	if (port->sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = uart_port_trylock(port);
-	else {
-		uart_port_lock(port);
-		locked = 1;
-	}
+	if (oops_in_progress)
+		locked = uart_port_trylock_irqsave(port, &flags);
+	else
+		uart_port_lock_irqsave(port, &flags);
 
 	old_ctl = owl_uart_read(port, OWL_UART_CTL);
 	val = old_ctl | OWL_UART_CTL_TRFS_TX;
@@ -541,9 +537,7 @@ static void owl_uart_port_write(struct uart_port *port, const char *s,
 	owl_uart_write(port, old_ctl, OWL_UART_CTL);
 
 	if (locked)
-		uart_port_unlock(port);
-
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
 
 static void owl_uart_console_write(struct console *co, const char *s,
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 436cc6d52a11b..89257cddf5405 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -237,9 +237,6 @@ struct eg20t_port {
 
 #define IRQ_NAME_SIZE 17
 	char				irq_name[IRQ_NAME_SIZE];
-
-	/* protect the eg20t_port private structure and io access to membase */
-	spinlock_t lock;
 };
 
 /**
@@ -567,7 +564,7 @@ static int pch_uart_hal_read(struct eg20t_port *priv, unsigned char *buf,
 			if (uart_handle_break(port))
 				continue;
 		}
-		if (uart_handle_sysrq_char(port, rbr))
+		if (uart_prepare_sysrq_char(port, rbr))
 			continue;
 
 		buf[i++] = rbr;
@@ -599,16 +596,14 @@ static void pch_uart_hal_set_break(struct eg20t_port *priv, int on)
 	iowrite8(lcr, priv->membase + UART_LCR);
 }
 
-static int push_rx(struct eg20t_port *priv, const unsigned char *buf,
-		   int size)
+static void push_rx(struct eg20t_port *priv, const unsigned char *buf,
+		    int size)
 {
 	struct uart_port *port = &priv->port;
 	struct tty_port *tport = &port->state->port;
 
 	tty_insert_flip_string(tport, buf, size);
 	tty_flip_buffer_push(tport);
-
-	return 0;
 }
 
 static int dma_push_rx(struct eg20t_port *priv, int size)
@@ -761,7 +756,7 @@ static int handle_rx_to(struct eg20t_port *priv)
 {
 	struct pch_uart_buffer *buf;
 	int rx_size;
-	int ret;
+
 	if (!priv->start_rx) {
 		pch_uart_hal_disable_interrupt(priv, PCH_UART_HAL_RX_INT |
 						     PCH_UART_HAL_RX_ERR_INT);
@@ -770,19 +765,12 @@ static int handle_rx_to(struct eg20t_port *priv)
 	buf = &priv->rxbuf;
 	do {
 		rx_size = pch_uart_hal_read(priv, buf->buf, buf->size);
-		ret = push_rx(priv, buf->buf, rx_size);
-		if (ret)
-			return 0;
+		push_rx(priv, buf->buf, rx_size);
 	} while (rx_size == buf->size);
 
 	return PCH_UART_HANDLED_RX_INT;
 }
 
-static int handle_rx(struct eg20t_port *priv)
-{
-	return handle_rx_to(priv);
-}
-
 static int dma_handle_rx(struct eg20t_port *priv)
 {
 	struct uart_port *port = &priv->port;
@@ -1019,11 +1007,10 @@ static irqreturn_t pch_uart_interrupt(int irq, void *dev_id)
 	u8 lsr;
 	int ret = 0;
 	unsigned char iid;
-	unsigned long flags;
 	int next = 1;
 	u8 msr;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	uart_port_lock(&priv->port);
 	handled = 0;
 	while (next) {
 		iid = pch_uart_hal_get_iid(priv);
@@ -1051,7 +1038,7 @@ static irqreturn_t pch_uart_interrupt(int irq, void *dev_id)
 						PCH_UART_HAL_RX_INT |
 						PCH_UART_HAL_RX_ERR_INT);
 			} else {
-				ret = handle_rx(priv);
+				ret = handle_rx_to(priv);
 			}
 			break;
 		case PCH_UART_IID_RDR_TO:	/* Received Data Ready
@@ -1083,7 +1070,7 @@ static irqreturn_t pch_uart_interrupt(int irq, void *dev_id)
 		handled |= (unsigned int)ret;
 	}
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	uart_unlock_and_check_sysrq(&priv->port);
 	return IRQ_RETVAL(handled);
 }
 
@@ -1194,9 +1181,9 @@ static void pch_uart_break_ctl(struct uart_port *port, int ctl)
 	unsigned long flags;
 
 	priv = container_of(port, struct eg20t_port, port);
-	spin_lock_irqsave(&priv->lock, flags);
+	uart_port_lock_irqsave(&priv->port, &flags);
 	pch_uart_hal_set_break(priv, ctl);
-	spin_unlock_irqrestore(&priv->lock, flags);
+	uart_port_unlock_irqrestore(&priv->port, flags);
 }
 
 /* Grab any interrupt resources and initialise any low level driver state. */
@@ -1346,8 +1333,7 @@ static void pch_uart_set_termios(struct uart_port *port,
 
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
 
-	spin_lock_irqsave(&priv->lock, flags);
-	uart_port_lock(port);
+	uart_port_lock_irqsave(port, &flags);
 
 	uart_update_timeout(port, termios->c_cflag, baud);
 	rtn = pch_uart_hal_set_line(priv, baud, parity, bits, stb);
@@ -1360,8 +1346,7 @@ static void pch_uart_set_termios(struct uart_port *port,
 		tty_termios_encode_baud_rate(termios, baud, baud);
 
 out:
-	uart_port_unlock(port);
-	spin_unlock_irqrestore(&priv->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *pch_uart_type(struct uart_port *port)
@@ -1565,27 +1550,17 @@ pch_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct eg20t_port *priv;
 	unsigned long flags;
-	int priv_locked = 1;
-	int port_locked = 1;
+	int locked = 1;
 	u8 ier;
 
 	priv = pch_uart_ports[co->index];
 
 	touch_nmi_watchdog();
 
-	local_irq_save(flags);
-	if (priv->port.sysrq) {
-		/* call to uart_handle_sysrq_char already took the priv lock */
-		priv_locked = 0;
-		/* serial8250_handle_port() already took the port lock */
-		port_locked = 0;
-	} else if (oops_in_progress) {
-		priv_locked = spin_trylock(&priv->lock);
-		port_locked = uart_port_trylock(&priv->port);
-	} else {
-		spin_lock(&priv->lock);
-		uart_port_lock(&priv->port);
-	}
+	if (oops_in_progress)
+		locked = uart_port_trylock_irqsave(&priv->port, &flags);
+	else
+		uart_port_lock_irqsave(&priv->port, &flags);
 
 	/*
 	 *	First save the IER then disable the interrupts
@@ -1603,11 +1578,8 @@ pch_console_write(struct console *co, const char *s, unsigned int count)
 	wait_for_xmitr(priv, UART_LSR_BOTH_EMPTY);
 	iowrite8(ier, priv->membase + UART_IER);
 
-	if (port_locked)
-		uart_port_unlock(&priv->port);
-	if (priv_locked)
-		spin_unlock(&priv->lock);
-	local_irq_restore(flags);
+	if (locked)
+		uart_port_unlock_irqrestore(&priv->port, flags);
 }
 
 static int __init pch_console_setup(struct console *co, char *options)
@@ -1704,8 +1676,6 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	pci_enable_msi(pdev);
 	pci_set_master(pdev);
 
-	spin_lock_init(&priv->lock);
-
 	iobase = pci_resource_start(pdev, 0);
 	mapbase = pci_resource_start(pdev, 1);
 	priv->mapbase = mapbase;
@@ -1735,8 +1705,6 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 		 KBUILD_MODNAME ":" PCH_UART_DRIVER_DEVICE "%d",
 		 priv->port.line);
 
-	spin_lock_init(&priv->port.lock);
-
 	pci_set_drvdata(pdev, priv);
 	priv->trigger_level = 1;
 	priv->fcr = 0;
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 46e70e155aab2..e395ff29c1a2c 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -151,7 +151,7 @@ static inline void receive_chars(struct uart_pxa_port *up, int *status)
 				flag = TTY_FRAME;
 		}
 
-		if (uart_handle_sysrq_char(&up->port, ch))
+		if (uart_prepare_sysrq_char(&up->port, ch))
 			goto ignore_char;
 
 		uart_insert_char(&up->port, *status, UART_LSR_OE, ch, flag);
@@ -232,7 +232,7 @@ static inline irqreturn_t serial_pxa_irq(int irq, void *dev_id)
 	check_modem_status(up);
 	if (lsr & UART_LSR_THRE)
 		transmit_chars(up);
-	uart_port_unlock(&up->port);
+	uart_unlock_and_check_sysrq(&up->port);
 	return IRQ_HANDLED;
 }
 
@@ -604,13 +604,10 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 	int locked = 1;
 
 	clk_enable(up->clk);
-	local_irq_save(flags);
-	if (up->port.sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = uart_port_trylock(&up->port);
+	if (oops_in_progress)
+		locked = uart_port_trylock_irqsave(&up->port, &flags);
 	else
-		uart_port_lock(&up->port);
+		uart_port_lock_irqsave(&up->port, &flags);
 
 	/*
 	 *	First save the IER then disable the interrupts
@@ -628,10 +625,8 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 	serial_out(up, UART_IER, ier);
 
 	if (locked)
-		uart_port_unlock(&up->port);
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(&up->port, flags);
 	clk_disable(up->clk);
-
 }
 
 #ifdef CONFIG_CONSOLE_POLL
diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index 13deb355cf1bc..82def9b8632a5 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -394,7 +394,8 @@ static void rda_uart_receive_chars(struct uart_port *port)
 		val &= 0xff;
 
 		port->icount.rx++;
-		tty_insert_flip_char(&port->state->port, val, flag);
+		if (!uart_prepare_sysrq_char(port, val))
+			tty_insert_flip_char(&port->state->port, val, flag);
 
 		status = rda_uart_read(port, RDA_UART_STATUS);
 	}
@@ -405,10 +406,9 @@ static void rda_uart_receive_chars(struct uart_port *port)
 static irqreturn_t rda_interrupt(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
-	unsigned long flags;
 	u32 val, irq_mask;
 
-	uart_port_lock_irqsave(port, &flags);
+	uart_port_lock(port);
 
 	/* Clear IRQ cause */
 	val = rda_uart_read(port, RDA_UART_IRQ_CAUSE);
@@ -425,7 +425,7 @@ static irqreturn_t rda_interrupt(int irq, void *dev_id)
 		rda_uart_send_chars(port);
 	}
 
-	uart_port_unlock_irqrestore(port, flags);
+	uart_unlock_and_check_sysrq(port);
 
 	return IRQ_HANDLED;
 }
@@ -590,18 +590,12 @@ static void rda_uart_port_write(struct uart_port *port, const char *s,
 {
 	u32 old_irq_mask;
 	unsigned long flags;
-	int locked;
+	int locked = 1;
 
-	local_irq_save(flags);
-
-	if (port->sysrq) {
-		locked = 0;
-	} else if (oops_in_progress) {
-		locked = uart_port_trylock(port);
-	} else {
-		uart_port_lock(port);
-		locked = 1;
-	}
+	if (oops_in_progress)
+		locked = uart_port_trylock_irqsave(port, &flags);
+	else
+		uart_port_lock_irqsave(port, &flags);
 
 	old_irq_mask = rda_uart_read(port, RDA_UART_IRQ_MASK);
 	rda_uart_write(port, 0, RDA_UART_IRQ_MASK);
@@ -615,9 +609,7 @@ static void rda_uart_port_write(struct uart_port *port, const char *s,
 	rda_uart_write(port, old_irq_mask, RDA_UART_IRQ_MASK);
 
 	if (locked)
-		uart_port_unlock(port);
-
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
 
 static void rda_uart_console_write(struct console *co, const char *s,
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index a4cc569a78a25..0670fd9f84967 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -412,7 +412,8 @@ static void __ssp_receive_chars(struct sifive_serial_port *ssp)
 			break;
 
 		ssp->port.icount.rx++;
-		uart_insert_char(&ssp->port, 0, 0, ch, TTY_NORMAL);
+		if (!uart_prepare_sysrq_char(&ssp->port, ch))
+			uart_insert_char(&ssp->port, 0, 0, ch, TTY_NORMAL);
 	}
 
 	tty_flip_buffer_push(&ssp->port.state->port);
@@ -534,7 +535,7 @@ static irqreturn_t sifive_serial_irq(int irq, void *dev_id)
 	if (ip & SIFIVE_SERIAL_IP_TXWM_MASK)
 		__ssp_transmit_chars(ssp);
 
-	uart_port_unlock(&ssp->port);
+	uart_unlock_and_check_sysrq(&ssp->port);
 
 	return IRQ_HANDLED;
 }
@@ -791,13 +792,10 @@ static void sifive_serial_console_write(struct console *co, const char *s,
 	if (!ssp)
 		return;
 
-	local_irq_save(flags);
-	if (ssp->port.sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = uart_port_trylock(&ssp->port);
+	if (oops_in_progress)
+		locked = uart_port_trylock_irqsave(&ssp->port, &flags);
 	else
-		uart_port_lock(&ssp->port);
+		uart_port_lock_irqsave(&ssp->port, &flags);
 
 	ier = __ssp_readl(ssp, SIFIVE_SERIAL_IE_OFFS);
 	__ssp_writel(0, SIFIVE_SERIAL_IE_OFFS, ssp);
@@ -807,8 +805,7 @@ static void sifive_serial_console_write(struct console *co, const char *s,
 	__ssp_writel(ier, SIFIVE_SERIAL_IE_OFFS, ssp);
 
 	if (locked)
-		uart_port_unlock(&ssp->port);
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(&ssp->port, flags);
 }
 
 static int sifive_serial_console_setup(struct console *co, char *options)
diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
index 99f5285819d4b..f5e29eb4a4ce4 100644
--- a/drivers/tty/serial/sunplus-uart.c
+++ b/drivers/tty/serial/sunplus-uart.c
@@ -260,7 +260,7 @@ static void receive_chars(struct uart_port *port)
 		if (port->ignore_status_mask & SUP_DUMMY_READ)
 			goto ignore_char;
 
-		if (uart_handle_sysrq_char(port, ch))
+		if (uart_prepare_sysrq_char(port, ch))
 			goto ignore_char;
 
 		uart_insert_char(port, lsr, SUP_UART_LSR_OE, ch, flag);
@@ -287,7 +287,7 @@ static irqreturn_t sunplus_uart_irq(int irq, void *args)
 	if (isc & SUP_UART_ISC_TX)
 		transmit_chars(port);
 
-	uart_port_unlock(port);
+	uart_unlock_and_check_sysrq(port);
 
 	return IRQ_HANDLED;
 }
@@ -512,22 +512,16 @@ static void sunplus_console_write(struct console *co,
 	unsigned long flags;
 	int locked = 1;
 
-	local_irq_save(flags);
-
-	if (sunplus_console_ports[co->index]->port.sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = uart_port_trylock(&sunplus_console_ports[co->index]->port);
+	if (oops_in_progress)
+		locked = uart_port_trylock_irqsave(&sunplus_console_ports[co->index]->port, &flags);
 	else
-		uart_port_lock(&sunplus_console_ports[co->index]->port);
+		uart_port_lock_irqsave(&sunplus_console_ports[co->index]->port, &flags);
 
 	uart_console_write(&sunplus_console_ports[co->index]->port, s, count,
 			   sunplus_uart_console_putchar);
 
 	if (locked)
-		uart_port_unlock(&sunplus_console_ports[co->index]->port);
-
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(&sunplus_console_ports[co->index]->port, flags);
 }
 
 static int __init sunplus_console_setup(struct console *co, char *options)
diff --git a/localversion-rt b/localversion-rt
index 0efe7ba1930e1..8fc605d806670 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt5
+-rt6


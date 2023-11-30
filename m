Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F7C7FF149
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345893AbjK3OHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345823AbjK3OHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:07:31 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB4010D0;
        Thu, 30 Nov 2023 06:07:36 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9747140004;
        Thu, 30 Nov 2023 14:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701353255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJyFcxJM01dDApq68xWmtCn0ZQ8JKrTtmYGYE4ZF37g=;
        b=GMcCHvDhuwlonRU3E+fMzcXPt3IcdPKjXeqpWJN2hxO2tkHJwtUPYVBxXpMnM8nFBCy2FA
        f+d5J4O0ip7+gdtettFdUg400016tgyhPPImt38WrbkYg7doRyrLZDGlVoDCM3Xr1gbM1k
        GNhFehipEqyZg1rSZ5dkTiBPWki5jbVLCfaeuZwfHZFy/hjql+VI9isdmNBYUu2AfPBu2+
        NKKo5oG3k+ScgrtfRYhfuTZo5lq6Su6EJE9QcvaPvvhCQw6nH8FcWiiajpGzGmrdmAJR6D
        04YdHtufWZr8WS8HhleOyKxl8sbwKzmzzknfW3WuXH1j8KFg9nxd2z+gtVH06A==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Thu, 30 Nov 2023 15:07:15 +0100
Subject: [PATCH v5 3/9] tty: serial: amba-pl011: fix whitespace formatting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231130-mbly-uart-v5-3-6566703a04b5@bootlin.com>
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com>
In-Reply-To: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow recommandations from:

    $ ./scripts/checkpatch.pl --strict --file \
        drivers/tty/serial/amba-pl011.c

We fix 5 warnings and 48 checks, all related to whitespace.
Culprits are:

CHECK: Alignment should match open parenthesis
CHECK: Blank lines aren't necessary after an open brace '{'
CHECK: Lines should not end with a '('
CHECK: Please don't use multiple blank lines
CHECK: Please use a blank line after function/struct/union/enum
       declarations
CHECK: spaces preferred around that '/' (ctx:VxV)
CHECK: spaces preferred around that '|' (ctx:VxV)
WARNING: Missing a blank line after declarations
WARNING: please, no spaces at the start of a line

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/tty/serial/amba-pl011.c | 97 +++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 52 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index b7635363373e..7bd0b68ef92f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -50,7 +50,7 @@
 
 #define AMBA_ISR_PASS_LIMIT	256
 
-#define UART_DR_ERROR		(UART011_DR_OE|UART011_DR_BE|UART011_DR_PE|UART011_DR_FE)
+#define UART_DR_ERROR		(UART011_DR_OE | UART011_DR_BE | UART011_DR_PE | UART011_DR_FE)
 #define UART_DUMMY_DR_RX	(1 << 16)
 
 enum {
@@ -125,7 +125,7 @@ static unsigned int get_fifosize_arm(struct amba_device *dev)
 
 static struct vendor_data vendor_arm = {
 	.reg_offset		= pl011_std_offsets,
-	.ifls			= UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
+	.ifls			= UART011_IFLS_RX4_8 | UART011_IFLS_TX4_8,
 	.fr_busy		= UART01x_FR_BUSY,
 	.fr_dsr			= UART01x_FR_DSR,
 	.fr_cts			= UART01x_FR_CTS,
@@ -203,7 +203,7 @@ static unsigned int get_fifosize_st(struct amba_device *dev)
 
 static struct vendor_data vendor_st = {
 	.reg_offset		= pl011_st_offsets,
-	.ifls			= UART011_IFLS_RX_HALF|UART011_IFLS_TX_HALF,
+	.ifls			= UART011_IFLS_RX_HALF | UART011_IFLS_TX_HALF,
 	.fr_busy		= UART01x_FR_BUSY,
 	.fr_dsr			= UART01x_FR_DSR,
 	.fr_cts			= UART01x_FR_CTS,
@@ -277,13 +277,13 @@ struct uart_amba_port {
 static unsigned int pl011_tx_empty(struct uart_port *port);
 
 static unsigned int pl011_reg_to_offset(const struct uart_amba_port *uap,
-	unsigned int reg)
+					unsigned int reg)
 {
 	return uap->reg_offset[reg];
 }
 
 static unsigned int pl011_read(const struct uart_amba_port *uap,
-	unsigned int reg)
+			       unsigned int reg)
 {
 	void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
 
@@ -292,7 +292,7 @@ static unsigned int pl011_read(const struct uart_amba_port *uap,
 }
 
 static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
-	unsigned int reg)
+			unsigned int reg)
 {
 	void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
 
@@ -358,7 +358,6 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 	return fifotaken;
 }
 
-
 /*
  * All the DMA operation mode stuff goes inside this ifdef.
  * This assumes that you have a generic DMA device interface,
@@ -369,7 +368,7 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 #define PL011_DMA_BUFFER_SIZE PAGE_SIZE
 
 static int pl011_dmabuf_init(struct dma_chan *chan, struct pl011_dmabuf *db,
-	enum dma_data_direction dir)
+			     enum dma_data_direction dir)
 {
 	db->buf = dma_alloc_coherent(chan->device->dev, PL011_DMA_BUFFER_SIZE,
 				     &db->dma, GFP_KERNEL);
@@ -381,7 +380,7 @@ static int pl011_dmabuf_init(struct dma_chan *chan, struct pl011_dmabuf *db,
 }
 
 static void pl011_dmabuf_free(struct dma_chan *chan, struct pl011_dmabuf *db,
-	enum dma_data_direction dir)
+			      enum dma_data_direction dir)
 {
 	if (db->buf) {
 		dma_free_coherent(chan->device->dev,
@@ -424,7 +423,7 @@ static void pl011_dma_probe(struct uart_amba_port *uap)
 		dma_cap_set(DMA_SLAVE, mask);
 
 		chan = dma_request_channel(mask, plat->dma_filter,
-						plat->dma_tx_param);
+					   plat->dma_tx_param);
 		if (!chan) {
 			dev_err(uap->port.dev, "no TX DMA channel!\n");
 			return;
@@ -470,7 +469,7 @@ static void pl011_dma_probe(struct uart_amba_port *uap)
 					DMA_RESIDUE_GRANULARITY_DESCRIPTOR) {
 				dma_release_channel(chan);
 				dev_info(uap->port.dev,
-					"RX DMA disabled - no residue processing\n");
+					 "RX DMA disabled - no residue processing\n");
 				return;
 			}
 		}
@@ -499,18 +498,16 @@ static void pl011_dma_probe(struct uart_amba_port *uap)
 			else
 				uap->dmarx.poll_timeout = 3000;
 		} else if (!plat && dev->of_node) {
-			uap->dmarx.auto_poll_rate = of_property_read_bool(
-						dev->of_node, "auto-poll");
+			uap->dmarx.auto_poll_rate =
+					of_property_read_bool(dev->of_node, "auto-poll");
 			if (uap->dmarx.auto_poll_rate) {
 				u32 x;
 
-				if (0 == of_property_read_u32(dev->of_node,
-						"poll-rate-ms", &x))
+				if (0 == of_property_read_u32(dev->of_node, "poll-rate-ms", &x))
 					uap->dmarx.poll_rate = x;
 				else
 					uap->dmarx.poll_rate = 100;
-				if (0 == of_property_read_u32(dev->of_node,
-						"poll-timeout-ms", &x))
+				if (0 == of_property_read_u32(dev->of_node, "poll-timeout-ms", &x))
 					uap->dmarx.poll_timeout = x;
 				else
 					uap->dmarx.poll_timeout = 3000;
@@ -547,7 +544,7 @@ static void pl011_dma_tx_callback(void *data)
 	uart_port_lock_irqsave(&uap->port, &flags);
 	if (uap->dmatx.queued)
 		dma_unmap_single(dmatx->chan->device->dev, dmatx->dma,
-				dmatx->len, DMA_TO_DEVICE);
+				 dmatx->len, DMA_TO_DEVICE);
 
 	dmacr = uap->dmacr;
 	uap->dmacr = dmacr & ~UART011_TXDMAE;
@@ -643,7 +640,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 	}
 
 	desc = dmaengine_prep_slave_single(chan, dmatx->dma, dmatx->len, DMA_MEM_TO_DEV,
-					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
 		dma_unmap_single(dma_dev->dev, dmatx->dma, dmatx->len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
@@ -832,8 +829,8 @@ static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
 	dbuf = uap->dmarx.use_buf_b ?
 		&uap->dmarx.dbuf_b : &uap->dmarx.dbuf_a;
 	desc = dmaengine_prep_slave_single(rxchan, dbuf->dma, dbuf->len,
-					DMA_DEV_TO_MEM,
-					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+					   DMA_DEV_TO_MEM,
+					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	/*
 	 * If the DMA engine is busy and cannot prepare a
 	 * channel, no big deal, the driver will fall back
@@ -889,14 +886,12 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 	/* Pick the remain data from the DMA */
 	if (pending) {
-
 		/*
 		 * First take all chars in the DMA pipe, then look in the FIFO.
 		 * Note that tty_insert_flip_buf() tries to take as many chars
 		 * as it can.
 		 */
-		dma_count = tty_insert_flip_string(port, dbuf->buf + dmataken,
-				pending);
+		dma_count = tty_insert_flip_string(port, dbuf->buf + dmataken, pending);
 
 		uap->port.icount.rx += dma_count;
 		if (dma_count < pending)
@@ -1072,7 +1067,7 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 		dmataken = dbuf->len - dmarx->last_residue;
 		size = dmarx->last_residue - state.residue;
 		dma_count = tty_insert_flip_string(port, dbuf->buf + dmataken,
-				size);
+						   size);
 		if (dma_count == size)
 			dmarx->last_residue =  state.residue;
 		dmarx->last_jiffies = jiffies;
@@ -1085,7 +1080,6 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 	 */
 	if (jiffies_to_msecs(jiffies - dmarx->last_jiffies)
 			> uap->dmarx.poll_timeout) {
-
 		uart_port_lock_irqsave(&uap->port, &flags);
 		pl011_dma_rx_stop(uap);
 		uap->im |= UART011_RXIM;
@@ -1097,7 +1091,7 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 		del_timer(&uap->dmarx.timer);
 	} else {
 		mod_timer(&uap->dmarx.timer,
-			jiffies + msecs_to_jiffies(uap->dmarx.poll_rate));
+			  jiffies + msecs_to_jiffies(uap->dmarx.poll_rate));
 	}
 }
 
@@ -1129,7 +1123,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 
 	/* Allocate and map DMA RX buffers */
 	ret = pl011_dmabuf_init(uap->dmarx.chan, &uap->dmarx.dbuf_a,
-			       DMA_FROM_DEVICE);
+				DMA_FROM_DEVICE);
 	if (ret) {
 		dev_err(uap->port.dev, "failed to init DMA %s: %d\n",
 			"RX buffer A", ret);
@@ -1137,12 +1131,12 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 	}
 
 	ret = pl011_dmabuf_init(uap->dmarx.chan, &uap->dmarx.dbuf_b,
-			       DMA_FROM_DEVICE);
+				DMA_FROM_DEVICE);
 	if (ret) {
 		dev_err(uap->port.dev, "failed to init DMA %s: %d\n",
 			"RX buffer B", ret);
 		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_a,
-				 DMA_FROM_DEVICE);
+				  DMA_FROM_DEVICE);
 		goto skip_rx;
 	}
 
@@ -1169,8 +1163,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 		if (uap->dmarx.poll_rate) {
 			timer_setup(&uap->dmarx.timer, pl011_dma_rx_poll, 0);
 			mod_timer(&uap->dmarx.timer,
-				jiffies +
-				msecs_to_jiffies(uap->dmarx.poll_rate));
+				  jiffies + msecs_to_jiffies(uap->dmarx.poll_rate));
 			uap->dmarx.last_residue = PL011_DMA_BUFFER_SIZE;
 			uap->dmarx.last_jiffies = jiffies;
 		}
@@ -1359,8 +1352,8 @@ static void pl011_stop_rx(struct uart_port *port)
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
-	uap->im &= ~(UART011_RXIM|UART011_RTIM|UART011_FEIM|
-		     UART011_PEIM|UART011_BEIM|UART011_OEIM);
+	uap->im &= ~(UART011_RXIM | UART011_RTIM | UART011_FEIM |
+		     UART011_PEIM | UART011_BEIM | UART011_OEIM);
 	pl011_write(uap->im, uap, REG_IMSC);
 
 	pl011_dma_rx_stop(uap);
@@ -1380,7 +1373,7 @@ static void pl011_enable_ms(struct uart_port *port)
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
-	uap->im |= UART011_RIMIM|UART011_CTSMIM|UART011_DCDMIM|UART011_DSRMIM;
+	uap->im |= UART011_RIMIM | UART011_CTSMIM | UART011_DCDMIM | UART011_DSRMIM;
 	pl011_write(uap->im, uap, REG_IMSC);
 }
 
@@ -1409,8 +1402,7 @@ __acquires(&uap->port.lock)
 				uap->dmarx.last_jiffies = jiffies;
 				uap->dmarx.last_residue	= PL011_DMA_BUFFER_SIZE;
 				mod_timer(&uap->dmarx.timer,
-					jiffies +
-					msecs_to_jiffies(uap->dmarx.poll_rate));
+					  jiffies + msecs_to_jiffies(uap->dmarx.poll_rate));
 			}
 #endif
 		}
@@ -1557,18 +1549,17 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 		do {
 			check_apply_cts_event_workaround(uap);
 
-			pl011_write(status & ~(UART011_TXIS|UART011_RTIS|
-					       UART011_RXIS),
+			pl011_write(status & ~(UART011_TXIS | UART011_RTIS | UART011_RXIS),
 				    uap, REG_ICR);
 
-			if (status & (UART011_RTIS|UART011_RXIS)) {
+			if (status & (UART011_RTIS | UART011_RXIS)) {
 				if (pl011_dma_rx_running(uap))
 					pl011_dma_rx_irq(uap);
 				else
 					pl011_rx_chars(uap);
 			}
-			if (status & (UART011_DSRMIS|UART011_DCDMIS|
-				      UART011_CTSMIS|UART011_RIMIS))
+			if (status & (UART011_DSRMIS | UART011_DCDMIS |
+				      UART011_CTSMIS | UART011_RIMIS))
 				pl011_modem_status(uap);
 			if (status & UART011_TXIS)
 				pl011_tx_chars(uap, true);
@@ -1707,8 +1698,7 @@ static int pl011_get_poll_char(struct uart_port *port)
 	return pl011_read(uap, REG_DR);
 }
 
-static void pl011_put_poll_char(struct uart_port *port,
-			 unsigned char ch)
+static void pl011_put_poll_char(struct uart_port *port, unsigned char ch)
 {
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
@@ -1909,14 +1899,13 @@ static int sbsa_uart_startup(struct uart_port *port)
 	return 0;
 }
 
-static void pl011_shutdown_channel(struct uart_amba_port *uap,
-					unsigned int lcrh)
+static void pl011_shutdown_channel(struct uart_amba_port *uap, unsigned int lcrh)
 {
-      unsigned long val;
+	unsigned long val;
 
-      val = pl011_read(uap, lcrh);
-      val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
-      pl011_write(val, uap, lcrh);
+	val = pl011_read(uap, lcrh);
+	val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
+	pl011_write(val, uap, lcrh);
 }
 
 /*
@@ -2065,7 +2054,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 		uap->dmarx.poll_rate = DIV_ROUND_UP(10000000, baud);
 #endif
 
-	if (baud > port->uartclk/16)
+	if (baud > port->uartclk / 16)
 		quot = DIV_ROUND_CLOSEST(port->uartclk * 8, baud);
 	else
 		quot = DIV_ROUND_CLOSEST(port->uartclk * 4, baud);
@@ -2218,13 +2207,14 @@ static void pl011_config_port(struct uart_port *port, int flags)
 static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
 	int ret = 0;
+
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_AMBA)
 		ret = -EINVAL;
 	if (ser->irq < 0 || ser->irq >= nr_irqs)
 		ret = -EINVAL;
 	if (ser->baud_base < 9600)
 		ret = -EINVAL;
-	if (port->mapbase != (unsigned long) ser->iomem_base)
+	if (port->mapbase != (unsigned long)ser->iomem_base)
 		ret = -EINVAL;
 	return ret;
 }
@@ -2613,7 +2603,9 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
 
 	return 0;
 }
+
 OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
+
 OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", pl011_early_console_setup);
 
 /*
@@ -2636,6 +2628,7 @@ qdf2400_e44_early_console_setup(struct earlycon_device *device,
 	device->con->write = qdf2400_e44_early_write;
 	return 0;
 }
+
 EARLYCON_DECLARE(qdf2400_e44, qdf2400_e44_early_console_setup);
 
 #else

-- 
2.43.0


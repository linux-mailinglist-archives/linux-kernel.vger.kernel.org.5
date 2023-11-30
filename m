Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659217FF143
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345927AbjK3OHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345843AbjK3OHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:07:32 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB2410F1;
        Thu, 30 Nov 2023 06:07:37 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C02A4000B;
        Thu, 30 Nov 2023 14:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701353256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JPnpei+XJSun9e0vqZLqNWsfUUIRQcv3+GojvAH6Jyc=;
        b=XLlSWDoyuXhaAqdAoHLV6JiqayIT0d2vRkKtzgakNIzPa0olIGDn/y9MGRakJVYgYSYN9R
        qEg0mm+hbw1teYC02nM5sLA2gj8pcAwAiXudU5f9eoC9relgogyWOcBbSXtFjXya0bAVTj
        9LqK6IvHjWBok2FKn112TQ3QtsPqfwYooNyOUDUMcjkRADsfnmByf+0O5lVFZtNUAJqt/6
        uy8ZF9FQ3td2zwF1LtAMS1Kll2R18mw3mCF4rXJxPU0HhDTJ1PyqPnSHUMSi5hFNvWWUaU
        cqcGnPXiaPRd/m0y93Fq0+iIpU2DxGHCqKydM5ZE99PBiPFNVeAH6VpQsZCnaQ==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Thu, 30 Nov 2023 15:07:18 +0100
Subject: [PATCH v5 6/9] tty: serial: amba-pl011: fix formatting of
 conditions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231130-mbly-uart-v5-6-6566703a04b5@bootlin.com>
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch warnings & checks:

	$ ./scripts/checkpatch.pl --strict --file \
        drivers/tty/serial/amba-pl011.c

    CHECK: Unbalanced braces around else statement
    CHECK: Unnecessary parentheses around '[...]'
    CHECK: braces {} should be used on all arms of this statement
    CHECK: Comparison to NULL could be written "[...]"
    WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/tty/serial/amba-pl011.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index be8888db1a37..3c657bac2359 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -330,10 +330,11 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 				uap->port.icount.brk++;
 				if (uart_handle_break(&uap->port))
 					continue;
-			} else if (ch & UART011_DR_PE)
+			} else if (ch & UART011_DR_PE) {
 				uap->port.icount.parity++;
-			else if (ch & UART011_DR_FE)
+			} else if (ch & UART011_DR_FE) {
 				uap->port.icount.frame++;
+			}
 			if (ch & UART011_DR_OE)
 				uap->port.icount.overrun++;
 
@@ -464,7 +465,7 @@ static void pl011_dma_probe(struct uart_amba_port *uap)
 		 * If the controller does, check for suitable residue processing
 		 * otherwise assime all is well.
 		 */
-		if (0 == dma_get_slave_caps(chan, &caps)) {
+		if (dma_get_slave_caps(chan, &caps) == 0) {
 			if (caps.residue_granularity ==
 					DMA_RESIDUE_GRANULARITY_DESCRIPTOR) {
 				dma_release_channel(chan);
@@ -503,11 +504,11 @@ static void pl011_dma_probe(struct uart_amba_port *uap)
 			if (uap->dmarx.auto_poll_rate) {
 				u32 x;
 
-				if (0 == of_property_read_u32(dev->of_node, "poll-rate-ms", &x))
+				if (of_property_read_u32(dev->of_node, "poll-rate-ms", &x) == 0)
 					uap->dmarx.poll_rate = x;
 				else
 					uap->dmarx.poll_rate = 100;
-				if (0 == of_property_read_u32(dev->of_node, "poll-timeout-ms", &x))
+				if (of_property_read_u32(dev->of_node, "poll-timeout-ms", &x) == 0)
 					uap->dmarx.poll_timeout = x;
 				else
 					uap->dmarx.poll_timeout = 3000;
@@ -615,9 +616,9 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 	if (count > PL011_DMA_BUFFER_SIZE)
 		count = PL011_DMA_BUFFER_SIZE;
 
-	if (xmit->tail < xmit->head)
+	if (xmit->tail < xmit->head) {
 		memcpy(&dmatx->buf[0], &xmit->buf[xmit->tail], count);
-	else {
+	} else {
 		size_t first = UART_XMIT_SIZE - xmit->tail;
 		size_t second;
 
@@ -751,8 +752,9 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
 			if (pl011_dma_tx_refill(uap) > 0) {
 				uap->im &= ~UART011_TXIM;
 				pl011_write(uap->im, uap, REG_IMSC);
-			} else
+			} else {
 				ret = false;
+			}
 		} else if (!(uap->dmacr & UART011_TXDMAE)) {
 			uap->dmacr |= UART011_TXDMAE;
 			pl011_write(uap->dmacr, uap, REG_DMACR);
@@ -2139,9 +2141,9 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * else we see data corruption.
 	 */
 	if (uap->vendor->oversampling) {
-		if ((baud >= 3000000) && (baud < 3250000) && (quot > 1))
+		if (baud >= 3000000 && baud < 3250000 && quot > 1)
 			quot -= 1;
-		else if ((baud > 3250000) && (quot > 2))
+		else if (baud > 3250000 && quot > 2)
 			quot -= 2;
 	}
 	/* Set baud rate */
@@ -2668,7 +2670,7 @@ static int pl011_probe_dt_alias(int index, struct device *dev)
 		ret = index;
 	} else {
 		seen_dev_with_alias = true;
-		if (ret >= ARRAY_SIZE(amba_ports) || amba_ports[ret] != NULL) {
+		if (ret >= ARRAY_SIZE(amba_ports) || amba_ports[ret]) {
 			dev_warn(dev, "requested serial port %d  not available.\n", ret);
 			ret = index;
 		}
@@ -2702,7 +2704,7 @@ static int pl011_find_free_port(void)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(amba_ports); i++)
-		if (amba_ports[i] == NULL)
+		if (!amba_ports[i])
 			return i;
 
 	return -EBUSY;

-- 
2.43.0


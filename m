Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36457D8100
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344732AbjJZKmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjJZKl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:41:56 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2053A1A7;
        Thu, 26 Oct 2023 03:41:52 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27F6024000A;
        Thu, 26 Oct 2023 10:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698316911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvItf+Q4uznFQkXp+ZifDN/od0IVBL9im+3wFy3ecg8=;
        b=Dwu/4KiO+XbS+wEpdfzesTIjzNiAR4JzS7q9MbH+2JMAoNu7vrqPn/1Yty7XstKsDVV1TJ
        cjG9nk3zWoRw6HeaZCmv9Bs4fXjiaNyrZc+VB+/lI4i7ykqpUzQ+4e6FMkNGMNVc0L3bD8
        FlDhc1WJx4Xcp9ywszAhvzq/MDqnt8I53SCpvn3KFaJvrdyU74R25WA84SY9VHmPsJPUwK
        N519PzPRt4IeEM77Btw9cOvmK5T3qYSlxB65KN/zMRZWeCtgg4FLTms1YctUa5sryYPV+d
        Y/aKPoqrXy0640gKL6dGPSSn7Zpl6tPVtj4dS3ZjwyDH9kj+50fJQEIBdk5kJQ==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Thu, 26 Oct 2023 12:41:22 +0200
Subject: [PATCH 5/6] tty: serial: amba-pl011: unindent
 pl011_console_get_options function body
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231026-mbly-uart-v1-5-9258eea297d3@bootlin.com>
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
In-Reply-To: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole function body is encapsulated inside an if-condition. Reverse
the if logic and early return to remove one indentation level.

Also turn two nested ifs into a single one at the end of the function.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/tty/serial/amba-pl011.c | 42 ++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index bb3082c4d35c..5774d48c7f16 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2369,34 +2369,34 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 static void pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 				      int *parity, int *bits)
 {
-	if (pl011_read(uap, REG_CR) & UART01x_CR_UARTEN) {
-		unsigned int lcr_h, ibrd, fbrd;
+	unsigned int lcr_h, ibrd, fbrd;
 
-		lcr_h = pl011_read(uap, REG_LCRH_TX);
+	if (!(pl011_read(uap, REG_CR) & UART01x_CR_UARTEN))
+		return;
 
-		*parity = 'n';
-		if (lcr_h & UART01x_LCRH_PEN) {
-			if (lcr_h & UART01x_LCRH_EPS)
-				*parity = 'e';
-			else
-				*parity = 'o';
-		}
+	lcr_h = pl011_read(uap, REG_LCRH_TX);
 
-		if ((lcr_h & 0x60) == UART01x_LCRH_WLEN_7)
-			*bits = 7;
+	*parity = 'n';
+	if (lcr_h & UART01x_LCRH_PEN) {
+		if (lcr_h & UART01x_LCRH_EPS)
+			*parity = 'e';
 		else
-			*bits = 8;
+			*parity = 'o';
+	}
+
+	if ((lcr_h & 0x60) == UART01x_LCRH_WLEN_7)
+		*bits = 7;
+	else
+		*bits = 8;
 
-		ibrd = pl011_read(uap, REG_IBRD);
-		fbrd = pl011_read(uap, REG_FBRD);
+	ibrd = pl011_read(uap, REG_IBRD);
+	fbrd = pl011_read(uap, REG_FBRD);
 
-		*baud = uap->port.uartclk * 4 / (64 * ibrd + fbrd);
+	*baud = uap->port.uartclk * 4 / (64 * ibrd + fbrd);
 
-		if (uap->vendor->oversampling) {
-			if (pl011_read(uap, REG_CR)
-				  & ST_UART011_CR_OVSFACT)
-				*baud *= 2;
-		}
+	if (uap->vendor->oversampling &&
+	    (pl011_read(uap, REG_CR) & ST_UART011_CR_OVSFACT)) {
+		*baud *= 2;
 	}
 }
 

-- 
2.41.0


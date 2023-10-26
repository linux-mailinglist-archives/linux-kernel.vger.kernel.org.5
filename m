Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369E77D80FC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344701AbjJZKmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjJZKlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:41:55 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39781B1;
        Thu, 26 Oct 2023 03:41:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A3E44240008;
        Thu, 26 Oct 2023 10:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698316909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tDw5w/BCvQxAYVMZ3iFH2d1Ti5JAK2d/k6tk4TbsZXw=;
        b=kQZjqCCmQSFYlDXBRl68K9ttqjmmfPXdyUPjej1MswBg0iOL4sp8f/CLcjgpO/cTQWY7e1
        rSWod5+U2VCqdW3iiigY5yqHgHE58XGLtsLHaPMH23UqWAdPeR/DecIpCeMfTvuEAjmXtr
        8iPgx29Ugf7blVHQ3xzSTAHiBK9OkRQr0zFEeKkSoQFtNgZ7G+l9XGy9s5FEDOYSP943wB
        +6RegEkxyETCZUPJ30DVNNs+3kcQ5J+STBb9NItpEROYmL79QLrx18mxhIjHYrigHeq27+
        8RgH4k50N17X11NvepP9gaMSrPqj1ZSjqQjw5ptdX/vSwI72m+PkZ+UUxvV0GA==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Thu, 26 Oct 2023 12:41:18 +0200
Subject: [PATCH 1/6] tty: serial: amba: cleanup whitespace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231026-mbly-uart-v1-1-9258eea297d3@bootlin.com>
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

Fix whitespace in include/linux/amba/serial.h to match current kernel
coding standards. Fixes about:

 - CHECK: spaces preferred around that '|' (ctx:VxV)
 - ERROR: code indent should use tabs where possible
 - WARNING: Unnecessary space before function pointer arguments
 - WARNING: please, no spaces at the start of a line

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 include/linux/amba/serial.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index a1307b58cc2c..27003ec52114 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -75,10 +75,10 @@
 #define UART011_DR_PE		(1 << 9)
 #define UART011_DR_FE		(1 << 8)
 
-#define UART01x_RSR_OE 		0x08
-#define UART01x_RSR_BE 		0x04
-#define UART01x_RSR_PE 		0x02
-#define UART01x_RSR_FE 		0x01
+#define UART01x_RSR_OE		0x08
+#define UART01x_RSR_BE		0x04
+#define UART01x_RSR_PE		0x02
+#define UART01x_RSR_FE		0x01
 
 #define UART011_FR_RI		0x100
 #define UART011_FR_TXFE		0x080
@@ -86,9 +86,9 @@
 #define UART01x_FR_TXFF		0x020
 #define UART01x_FR_RXFE		0x010
 #define UART01x_FR_BUSY		0x008
-#define UART01x_FR_DCD 		0x004
-#define UART01x_FR_DSR 		0x002
-#define UART01x_FR_CTS 		0x001
+#define UART01x_FR_DCD		0x004
+#define UART01x_FR_DSR		0x002
+#define UART01x_FR_CTS		0x001
 #define UART01x_FR_TMSK		(UART01x_FR_TXFF + UART01x_FR_BUSY)
 
 /*
@@ -110,14 +110,14 @@
 #define UART011_CR_TXE		0x0100	/* transmit enable */
 #define UART011_CR_LBE		0x0080	/* loopback enable */
 #define UART010_CR_RTIE		0x0040
-#define UART010_CR_TIE 		0x0020
-#define UART010_CR_RIE 		0x0010
+#define UART010_CR_TIE		0x0020
+#define UART010_CR_RIE		0x0010
 #define UART010_CR_MSIE		0x0008
 #define ST_UART011_CR_OVSFACT	0x0008	/* Oversampling factor */
 #define UART01x_CR_IIRLP	0x0004	/* SIR low power mode */
 #define UART01x_CR_SIREN	0x0002	/* SIR enable */
 #define UART01x_CR_UARTEN	0x0001	/* UART enable */
- 
+
 #define UART011_LCRH_SPS	0x80
 #define UART01x_LCRH_WLEN_8	0x60
 #define UART01x_LCRH_WLEN_7	0x40
@@ -203,8 +203,8 @@
 #define UART011_TXDMAE		(1 << 1)	/* enable transmit dma */
 #define UART011_RXDMAE		(1 << 0)	/* enable receive dma */
 
-#define UART01x_RSR_ANY		(UART01x_RSR_OE|UART01x_RSR_BE|UART01x_RSR_PE|UART01x_RSR_FE)
-#define UART01x_FR_MODEM_ANY	(UART01x_FR_DCD|UART01x_FR_DSR|UART01x_FR_CTS)
+#define UART01x_RSR_ANY		(UART01x_RSR_OE | UART01x_RSR_BE | UART01x_RSR_PE | UART01x_RSR_FE)
+#define UART01x_FR_MODEM_ANY	(UART01x_FR_DCD | UART01x_FR_DSR | UART01x_FR_CTS)
 
 #ifndef __ASSEMBLY__
 struct amba_device; /* in uncompress this is included but amba/bus.h is not */
@@ -220,8 +220,8 @@ struct amba_pl011_data {
 	bool dma_rx_poll_enable;
 	unsigned int dma_rx_poll_rate;
 	unsigned int dma_rx_poll_timeout;
-        void (*init) (void);
-	void (*exit) (void);
+	void (*init)(void);
+	void (*exit)(void);
 };
 #endif
 

-- 
2.41.0


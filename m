Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703D27DCA9F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343617AbjJaKUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjJaKUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:20:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F80DE;
        Tue, 31 Oct 2023 03:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698747633; x=1699352433; i=rwahl@gmx.de;
        bh=8KUc/Sw7tIPGe75TyB2d3JWyjue4bvCoh74xhIWYR1o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=GF4RrG1McZkxMwr8GPYDaosOu01rTUUZOkEG4I8gq1ISGfQvTN94Q5XHJpxPNPG0
         ynA41ekXL0yKlSxaenVCNki0+Ii7JIBHqxFewjhVrbpjVL4816faTwC6J4BsA0WXQ
         zyZNw+f8rQ0K43+gHvNV4goyfhRM47LHs9CNKz8+eXrxW9LopwsGT0EfKeAR1pyCh
         gIdIE2H++mlrgWTM2GhireCeoojn+/30qgVPPrFLmMOwLeCWWeXXe/jyfCwqBH/lK
         z23uNCl0VmaiKgAXMYKexGCcn9oYFS9EHN+WvYfDvXVUMQoZCIxkCPRFhAnbbmlt4
         x2E2NhJwqrSU55Ix/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.147.134]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEFvj-1r7yaq2qgv-00AIde; Tue, 31
 Oct 2023 11:20:33 +0100
From:   Ronald Wahl <rwahl@gmx.de>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ronald Wahl <ronald.wahl@raritan.com>
Subject: [PATCH v2] serial: 8250: 8250_omap: Clear UART_HAS_RHR_IT_DIS bit
Date:   Tue, 31 Oct 2023 11:20:24 +0100
Message-ID: <20231031102024.9973-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J42Rvwev/XCjYJrWI0iYmpHXJrUGYjJ0gOtj07t/iMcnNp3Z0Fs
 OUM4c0iu4g1/BJphvjFMXA9SB6DvK8PpvGPrx2YWqEuMRDccHiuteewsnulbGVCb9bh9nXJ
 lmO7kIoRjgIcQAX95beQ2ItKHYPkK3E3gEIjr7VLpwOTdrlkvhQ9Mci7rCFyy4b0JJP6IaF
 xrUfH+Q0+GneTzDvYWbnQ==
UI-OutboundReport: notjunk:1;M01:P0:wJXI9Vn1AN4=;ZOyEThFmvZSCukLqgzIlySsuWW8
 SWwlM7/2PHfRqstnZWYXmCOB0hK6WrEkp/YCGqnVoasdvbd7bS6AU/zQi21CBRUJX67BTnuL+
 BKDuh/a/Hv1bpiNSnuB0T9o1UYb1AkdE1z1ia1/nysoqlgSU3PNseLMySc3awxTuf7HC8GbKl
 bYSEX+xZ9Rqjf4wjWP6sA+r7rIAtLTz9AITyQ43W6sLsVq5mD+4u64/8Lj6AU6NTEWn8wN6ft
 PDP66eSRM8DEkkk7NqFw/I5RmjMynuHvHSqfqfJJnWzvQM/QRz3Lgi3WcIK+2dhOlJu02qrN1
 8nOu8Yi3qyjbPDzP/XDeh51/U1zB0VFgN/JQTQGmFKoRnuG8TLIPlfF1i3SrjntTlXvesLuMw
 +DX19xKheO7GQRApTyWf2rV2gcji3DHQMQOECIanykKFXZoaRWjXAbDtZ+laIX81wfs2buj/W
 x6hWUE/j7/2mAdNdyhSuxfs3uDWTqusn7UFU8Pe8GGB7bOiFNpc8JPgsWPrZxm/LB2fzR9E+U
 wvKF6KvGKuG0h/KgKvk2CeUrYukog1tNeUDGc/CUP84hPgc5t7X1KX0JiP5xdTFFpz2zmiOLZ
 MCz+GAetAtM9EiMHHdBTz8DqfZziQRcpO2rwkBbwW1vECcC7NaKOJfK7tyZ7gw00HNmGGu9W9
 +wTRORZzBg7TwGUr9KHbw2mL/H8uvK89J0KS+sDrTzrebFGevtHqnx0fNUseDmaPW6zsudqsQ
 RFZPV8I8mXZ8FhO7VOxM9mj6MjwlVhNPExNXQKy+tin9AL7g2SVvVfCuAiQU17F48hBUWys8H
 8HJMg21lfSlTStedvtQSrJkjb0rDmUDoaIeRPsqCbTrsH06hwcEjNBAvNz5H4Cs69osnJAW+l
 5PoTmUHWe4ig6amVoR2a2qVEJZdcBw5fIB6X4/nYC3X05bihsXYq6M6ZCeex0oDJm3fHeix7e
 LzOr3QwfB+75HRYFZD9bACPZXhs=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronald Wahl <ronald.wahl@raritan.com>

This fixes commit 439c7183e5b9 ("serial: 8250: 8250_omap: Disable RX
interrupt after DMA enable") which unfortunately set the
UART_HAS_RHR_IT_DIS bit in the UART_OMAP_IER2 register and never
cleared it.

Fixes: 439c7183e5b9 ("serial: 8250: 8250_omap: Disable RX interrupt after =
DMA enable")
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
V2: - add Fixes: tag
    - fix author

 drivers/tty/serial/8250/8250_omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250=
/8250_omap.c
index ca972fd37725..c7ab2963040b 100644
=2D-- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -914,7 +914,7 @@ static void __dma_rx_do_complete(struct uart_8250_port=
 *p)
 	if (priv->habit & UART_HAS_RHR_IT_DIS) {
 		reg =3D serial_in(p, UART_OMAP_IER2);
 		reg &=3D ~UART_OMAP_IER2_RHR_IT_DIS;
-		serial_out(p, UART_OMAP_IER2, UART_OMAP_IER2_RHR_IT_DIS);
+		serial_out(p, UART_OMAP_IER2, reg);
 	}

 	dmaengine_tx_status(rxchan, cookie, &state);
@@ -1060,7 +1060,7 @@ static int omap_8250_rx_dma(struct uart_8250_port *p=
)
 	if (priv->habit & UART_HAS_RHR_IT_DIS) {
 		reg =3D serial_in(p, UART_OMAP_IER2);
 		reg |=3D UART_OMAP_IER2_RHR_IT_DIS;
-		serial_out(p, UART_OMAP_IER2, UART_OMAP_IER2_RHR_IT_DIS);
+		serial_out(p, UART_OMAP_IER2, reg);
 	}

 	dma_async_issue_pending(dma->rxchan);
=2D-
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA7B7DCB75
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344015AbjJaLJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344026AbjJaLJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:09:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E04FC;
        Tue, 31 Oct 2023 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698750563; x=1699355363; i=rwahl@gmx.de;
        bh=pWFUU3PD5OIMpvpaP0tb8mgejL5DJ4aG473dM5x6J60=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=eQX/xwUNW7BAL24QBW8O6482LJiRlFB0Raj7BCYxuAUUH3ZWFOVT6X9F7ZpTNI5G
         HKHzwO7WZ6Br5+Re6ET+4gzkYJGJO7iDrHuKOZaFmavSmdAEH5JknuWvr8hy8qV1K
         ve8Ece1+5Ak17yHMiCJ34qRh0nonLYtphAuUVJqF8fkyjdvcfwMySjdK+rPAcAd/n
         INb7CKFZYMnl6zsrAOKWzfkpeoH6aXGfotOL3zCQiHoLIzczvgSNbg+/EVXQ+u5fl
         5PSsfMyc+5VKrSQzkH7ftavtYIAiC2zUhYxQa1E8HPqgzd/QXxuZx4uhHYaTw4tWT
         JV0/4dctKeHnzhyT1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.147.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1po0-1qzzY32d20-002Dpa; Tue, 31
 Oct 2023 12:09:23 +0100
From:   Ronald Wahl <rwahl@gmx.de>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ronald Wahl <ronald.wahl@raritan.com>, stable@vger.kernel.org
Subject: [PATCH v3] serial: 8250: 8250_omap: Clear UART_HAS_RHR_IT_DIS bit
Date:   Tue, 31 Oct 2023 12:09:09 +0100
Message-ID: <20231031110909.11695-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gOseK3Km/gFJ2PhS/d+snCZm/h4A1zwOObjyPd+e6edCohA+d/u
 TFHOuTMyF2mi9J5IEyI4DKEAOw88rn8T07MwEJmU2VIhuAQzbD35usznfrfCx5TDnzE9Pah
 7DSB5T82gk8Ujy033l5tgjjZEpq8GyJ9+H4wk6lBNaW/qwlFlyg6C1h+YG+qOrMP9+GVmqY
 R1chUDQ8wob0VXJBwrRSg==
UI-OutboundReport: notjunk:1;M01:P0:hxMtm8BXEcE=;rD2x+s6ILz5ut8nptxKwF2SiYow
 BQ/0njUICFKwRDm4FtE+V/qOwgd12/qv0ZIcAxm/XFLAwt5hpTtlFN/SO2RCJ4b4/bKHiFrlf
 iPsYjXQhdOBxuvCEd38lVR1GQoGQZYIpXcHgnIhjcsV9ee1+vF2j70JG3cBzQa8/6vfBnLLfP
 Do5RPf867B9254xoriKWif0ssl0pTi58t+6DxV2vUK/wG6MNJGOs3HwTMtzCV63m2c6/dfBJ2
 06mo5iLK21ZNiGy1sZ2SqNHECWmvXm8mKY8AfGPLlo+QclgcM8cmO5PNOIef/DLZ3faVxnhX0
 +iZGZ2+3EzDf7vYGAnmzzo1mRDOMfn7R5swXgDLyN9aVsGtzmSpLUekX085utE4ulWEI3n3Io
 wLftFm63ZPCpOD9w5WdI6LOkU1K8dB3KrYPLgtylxUWhhFjlT9oNQe25u4sOTcSywCGxNV8fa
 jZFSCjrBzgwyOYBqqXbXCBz8Tm17XSNamj7yVI7fTy8E0JoqWmRm6LmeybHAGGZRMY5JWKv8c
 eVPeAiNcnCOfqHdJ3VTanxfr9PwG/GnNp+VlcA5QOFdE0u3icOwHb3HwiKbPlpQhEcslGkvJV
 cCXXvRFyZKMl4AQgIHNvifBoGArUVXUbxaUZAxGEnHzCNZPAC1/27e3WvsiptCOl4xk7G4BBf
 IDyiKSXZu09eF4QGcpfkN95/2nq/9Q8CVGYJz1PLMyJHb8wKF1Buf/EDjuvh8uxztjThGHmqU
 sm0zwV7/ZY6E8xfkJqq1yhJ4RzV2XH79V9PFqc+ea57gHZobaOpb0uan/CXkbWTqSzwIG7QUt
 o8US7l+NmNbS5ueJe1Y5+HIRDx/7tfHVWWzQicmHn9m6Vf8V4UWdANpHnopEmcZH/WiI39/yF
 Epv/9R0XcFxZfiVmfp/edVY4is7ZzarkSYkq8GykqF7CXwwJwyCxh9KhM5l29jU7EtcL1a7xW
 DSVlVSaDtRJeA1igZgNhIDtKQT8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
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

Cc: stable@vger.kernel.org
Fixes: 439c7183e5b9 ("serial: 8250: 8250_omap: Disable RX interrupt after =
DMA enable")
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
V3: - add Cc: stable@vger.kernel.org

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


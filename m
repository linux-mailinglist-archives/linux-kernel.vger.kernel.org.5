Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC677DC061
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjJ3TZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjJ3SWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:22:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ECE1738;
        Mon, 30 Oct 2023 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698690066; x=1699294866; i=rwahl@gmx.de;
        bh=juI+8xCOhSJyejFjOT2zkvfZkD279hxgL01eRZueXmI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=dhnkcWSOdzAkTce9+0fTzPMoVmi6fOPzmDE1BgDM9CfeIdKlFEwoYDiRDMvdSIAd
         1jGYvTDc9KBE96pWCRY0a7T3+fc39EpTrF3CThFdu3JdIsT6yZULGbU+C+8QCDsIF
         o7XxFF+JP77rTTL9wk6/4KJntb7PHNUC7qrO7P/+JoYqMd0KIkzFcgV83atE+TdVF
         RTzHfDWnc8vM7m9Bis45Ljk/Fv//Pk8S1iHGy697NTimNx4B23NNW1xnBs68tqSLh
         tQiQG4EsQeE0hBRd3rr3CPRiKZKTUdMWN5ITM0yAyqKY0CfPs41JNFk2zpZQPWMAR
         odAB4uPU58HyIrDU7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.147.134]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnpns-1rGbIB3wj4-00pMjn; Mon, 30
 Oct 2023 19:21:05 +0100
From:   Ronald Wahl <rwahl@gmx.de>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ronald Wahl <ronald.wahl@raritan.com>
Subject: [PATCH] serial: 8250: 8250_omap: Clear UART_HAS_RHR_IT_DIS bit
Date:   Mon, 30 Oct 2023 19:20:44 +0100
Message-ID: <20231030182044.14056-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6aEzOJf8ErnBwG/cjEQ/aqFw3nonnMkCVnajg0LlL2q0bNLLcLA
 9ajQSHt7hlGwrKrgidJ1nQQetWU8U1yMsO7HF9o9HyvNET9X+NlKpMSIYgn8ySOLqBuEvnB
 pCo4UAwzcBPy9H4IQy0YiEXuIRPSYJUTrGuEkgWzGCXqh8BI1gFGcfoKU+8aR6E4BuyV2Nd
 T5ED3kSMnL+orUyWoaKyw==
UI-OutboundReport: notjunk:1;M01:P0:OFvOA48QsX4=;+71PI5ffwO95P42qbi7HnE9iE8B
 mGeuc9wafxvcFgoiRqt8/9fDJSEmcIQzRhVZS3+SryF0hMQ7xGiuMrKCi8jel8rVrjB0WC3JU
 FSSBJ1OkvCy0c+KZlc4cYhIS+i9dIt5fwMNkX3o1jTo1LdqDgxwVGQJpJ+jqs7jZc6zMCZDCQ
 jMvoNnK8RKaYltsZ+Usuf2FTN+F4T7TU3MMq/Ngeyk/Z5QK4nkxMqjdreGGaO45PgoZ/2ER+e
 mEJrHBC2fqXlQqBjkEPiXnjRL56mWuxcM23Ck53tPwpwp1ycTiSh+g2qFRxxzbbKySSF3k0Lc
 2hSBLZCF0uvmw9cZMfSzCj5douhIx3RKI/9bpmQIwPBB/VZGnmqJuYUbvU4v1s0O2CT73Zk0h
 I+qL/e0cQevqJoBQyHdIwnAOToQVmpxVDLOEcb6uYECE12i9xKoQHgJPJ9al48hjJlDffPSfK
 xY6fgtHdn2bJL+GdaLKKoz+pGfJhshDuVbiRs4CnXsyeXwEbFhD2xJTvRYYJACGelE+f5S+1Q
 QLv/UFdA26IgdPjz9Wk7tHLMD1FHhWkOTyWluqbMWlWBeZH59dIqphqqPFiNBsrLNOq41zneN
 eyeLF+y9AvMKoKVdfSjRpRtHzjNGPR2MeLxq84VkWG4Xaxz330Q2rlSUSJ8NbERKhusBi4gRT
 WoIGX+A19TV8Xd3f/0it9hi+ZRBK9jxhWF24lpcLeyi+VpsSZM7mcLhqQWvle0EpVu4rUWkQk
 zu6qAZ6JjcvReC7bs4XGtKRjW/TebAku7zg+5UmVkOOCt/hr+ptdFAcO6cNV8S14kMnMOT6c+
 ElpBpMUaCaULV0F9UDr5gqGtn0RufFIRg0lIw6AtP4GNpZON6UPSNc1iX1jVTvwRfEtipSYIT
 V+R1juwOsHj6nyRwevKAVuhawq1ZJg4cB2SRLuRgbRbnf9i+wqY1H/zFlLSGTFAdWMfgHsrmE
 vEqBwMWg3GHssQLDt7yrjQuu2Xk=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes commit 439c7183e5b9 ("serial: 8250: 8250_omap: Disable RX
interrupt after DMA enable") which unfortunately set the
UART_HAS_RHR_IT_DIS bit in the UART_OMAP_IER2 register and never
cleared it.

Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
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


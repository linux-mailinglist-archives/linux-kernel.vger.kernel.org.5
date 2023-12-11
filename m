Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F69F80CA31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343558AbjLKMtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343499AbjLKMtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:49:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96918BD;
        Mon, 11 Dec 2023 04:49:27 -0800 (PST)
From:   Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702298966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3ovit8JRev9mIgnPEoYTIqblldYPcpSv7qLZTfPzw4=;
        b=4JJ2Qk72dcJdeAaIHuGjup/kSea+/yooYgkZFiT0qzQcBSSLz9+okWoWsNtpQ5p/XSqNF4
        EcIkOBZ5m+FV11RvcGy7ew1w0WCdwu1hN7f7r26WWRL/XzntVMOoWLTrkD6wkH9fSuNzcH
        MhriVyGNZ6LpKZwAIYRa3CqO9hui47wMIhWxMbcnLSR2MDFECU+x86OrgRfpvzsIRhwzhI
        CwYwzSV8k7a3PcYWb2NNPhdLLCkvRFghJ2frebp2yQp+hnWkIrehoovWF1Jie+DUvOXZkN
        3A0M2D64VpPWkroKDJbAohZ/S6NvBHWYmm7Rj3Ipap22V2cqMtHRQ2iMPiIF4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702298966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3ovit8JRev9mIgnPEoYTIqblldYPcpSv7qLZTfPzw4=;
        b=0iOZd71mxsCF/WKwjF1oAFTITnAJpc2esvPgdpjOBoI3gYWbFnaTE8Sbu7j60dj1EtClZr
        iwdCa+vhjo9MS6Dw==
To:     linus.walleij@linaro.org, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcao@linutronix.de>
Subject: [PATCH 2/2] spi: pl022: delete unused next_msg_cs_active in struct pl022
Date:   Mon, 11 Dec 2023 13:49:15 +0100
Message-Id: <424fec01a75f6a881edcce189ac68b3408b62f29.1702298527.git.namcao@linutronix.de>
In-Reply-To: <cover.1702298527.git.namcao@linutronix.de>
References: <cover.1702298527.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member next_msg_cs_active of struct pl022 is not used anywhere.
Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/spi/spi-pl022.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index fd21e83cc3a4..3baf45da01cd 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -341,10 +341,6 @@ struct vendor_data {
  * @cur_msg: Pointer to current spi_message being processed
  * @cur_transfer: Pointer to current spi_transfer
  * @cur_chip: pointer to current clients chip(assigned from controller_sta=
te)
- * @next_msg_cs_active: the next message in the queue has been examined
- *  and it was found that it uses the same chip select as the previous
- *  message, so we left it active after the previous transfer, and it's
- *  active already.
  * @tx: current position in TX buffer to be read
  * @tx_end: end position in TX buffer to be read
  * @rx: current position in RX buffer to be written
@@ -372,7 +368,6 @@ struct pl022 {
 	struct pl022_ssp_controller	*host_info;
 	struct spi_transfer		*cur_transfer;
 	struct chip_data		*cur_chip;
-	bool				next_msg_cs_active;
 	void				*tx;
 	void				*tx_end;
 	void				*rx;
--=20
2.39.2


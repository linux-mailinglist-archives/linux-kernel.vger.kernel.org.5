Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D948A80CA30
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343528AbjLKMtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbjLKMtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:49:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59792B0;
        Mon, 11 Dec 2023 04:49:26 -0800 (PST)
From:   Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702298965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZzKwjWTDOK+X7Q3TY/aJqPSWaSZ1XBXSEY0XUeQD/0=;
        b=1XFw6mvYpdeNplzdWtSzeZwOA3ynoBpM7WEEQXZOxHeokczKH5c6iWlNF1Up6TbIN7FlQS
        TdTo8Lqk8H2im4WQURr5PW1mVg10ATrC3DO5ZrGJwDOrR5JPBxKIO7LwDzL4o3N1+2FEzO
        qaH9Qxks5Abxpyp+ck2ICtCRQVUMCE2s7d5FM7RMNeh5uVXQA+zjA1RBIybA95o1QudDqH
        ngsMSszpQsq8l1J9JleLSI5612kau9EBLhi+cbRhr+L8MFe/4yyfJU0HpKpp7u2lZt6Pzk
        mrCY+Qr5TdMaBRuKYuY0qYyQE+g/j/eaJmwimjiQb+uoy5Lc6IYAuqepD44wdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702298965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZzKwjWTDOK+X7Q3TY/aJqPSWaSZ1XBXSEY0XUeQD/0=;
        b=TC0ReHNdWwpUHHTLM6SA8IlCg8XtXt/ob1vCrK2zV1HUGyN5JpVRH664ZO3riyPDpU/5P+
        CpTHfkqGtftM6dAA==
To:     linus.walleij@linaro.org, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcao@linutronix.de>
Subject: [PATCH 1/2] spi: pl022: delete unused cur_gpiod in struct pl022
Date:   Mon, 11 Dec 2023 13:49:14 +0100
Message-Id: <7618c9d714aa1c16c7cb06f9d1fb1c074d1d9c65.1702298527.git.namcao@linutronix.de>
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

The member cur_gpiod of struct pl022 is not used anywhere. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/spi/spi-pl022.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 1e3bd6f3303a..fd21e83cc3a4 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -361,7 +361,6 @@ struct vendor_data {
  * @dummypage: a dummy page used for driving data on the bus with DMA
  * @dma_running: indicates whether DMA is in operation
  * @cur_cs: current chip select index
- * @cur_gpiod: current chip select GPIO descriptor
  */
 struct pl022 {
 	struct amba_device		*adev;
@@ -393,7 +392,6 @@ struct pl022 {
 	bool				dma_running;
 #endif
 	int cur_cs;
-	struct gpio_desc *cur_gpiod;
 };
=20
 /**
@@ -1344,8 +1342,6 @@ static int pl022_transfer_one(struct spi_controller *=
host, struct spi_device *sp
 	/* Setup the SPI using the per chip configuration */
 	pl022->cur_chip =3D spi_get_ctldata(spi);
 	pl022->cur_cs =3D spi_get_chipselect(spi, 0);
-	/* This is always available but may be set to -ENOENT */
-	pl022->cur_gpiod =3D spi_get_csgpiod(spi, 0);
=20
 	restore_state(pl022);
 	flush(pl022);
--=20
2.39.2


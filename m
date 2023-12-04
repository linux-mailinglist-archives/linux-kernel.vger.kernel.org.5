Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEAD804147
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjLDWFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjLDWF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:05:28 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA16CD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:05:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAH4G-0003Eq-Uv; Mon, 04 Dec 2023 23:05:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAH4G-00DbY6-I5; Mon, 04 Dec 2023 23:05:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAH4G-00EMXA-95; Mon, 04 Dec 2023 23:05:32 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2 3/3] w1: gpio: rename pointer to driver data from pdata to ddata
Date:   Mon,  4 Dec 2023 23:05:23 +0100
Message-ID:  <f863cacc485a701268164c9734b6d4aef23dae3e.1701727212.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701727212.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701727212.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4335; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=xHTjgY4K9af7P1vNMusocVvYmeNn9kGZK5/hjxTbjaU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbk0iwrlaqHGrugWKtZmWyfwV958P94eltYw5k s9bGNTaSpGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW5NIgAKCRCPgPtYfRL+ TqFkB/9dHTTrpvTiJhJauqJI0ZRre/cfyGBfu6hDGN+SGMJexK2NZrucAy8W81E85QyamsZpttt N3fL5og4hOD+DFYEU1C4cjfkTOzWTc5NHk02RXzcg38yhET1YI+BeyQ8577bxTbE+5GOJyym3yD 11as0zhIKVXjldIEaLOSX2mj4JSKU4c8Yy6X4aJnYc1E3gIW7ltEl+S9N0901eU+njaxBmGeu6l o1jGlRfrUq+zNSf5H/Fr+AE50ue5B6/tXTRurGj3Btyg/IK9wIUtGpgCBP5OQACFLODTa63Tiag vUpjxW2CUQ6ZaKUfQIFxyl38WtPBLDK1S67KHRRzrpmn5gxU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pdata is a relict when this was still platform data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/w1/masters/w1-gpio.c | 54 ++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index 67596428f69b..05c67038ed20 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -25,25 +25,25 @@ struct w1_gpio_ddata {
 
 static u8 w1_gpio_set_pullup(void *data, int delay)
 {
-	struct w1_gpio_ddata *pdata = data;
+	struct w1_gpio_ddata *ddata = data;
 
 	if (delay) {
-		pdata->pullup_duration = delay;
+		ddata->pullup_duration = delay;
 	} else {
-		if (pdata->pullup_duration) {
+		if (ddata->pullup_duration) {
 			/*
 			 * This will OVERRIDE open drain emulation and force-pull
 			 * the line high for some time.
 			 */
-			gpiod_set_raw_value(pdata->gpiod, 1);
-			msleep(pdata->pullup_duration);
+			gpiod_set_raw_value(ddata->gpiod, 1);
+			msleep(ddata->pullup_duration);
 			/*
 			 * This will simply set the line as input since we are doing
 			 * open drain emulation in the GPIO library.
 			 */
-			gpiod_set_value(pdata->gpiod, 1);
+			gpiod_set_value(ddata->gpiod, 1);
 		}
-		pdata->pullup_duration = 0;
+		ddata->pullup_duration = 0;
 	}
 
 	return 0;
@@ -51,16 +51,16 @@ static u8 w1_gpio_set_pullup(void *data, int delay)
 
 static void w1_gpio_write_bit(void *data, u8 bit)
 {
-	struct w1_gpio_ddata *pdata = data;
+	struct w1_gpio_ddata *ddata = data;
 
-	gpiod_set_value(pdata->gpiod, bit);
+	gpiod_set_value(ddata->gpiod, bit);
 }
 
 static u8 w1_gpio_read_bit(void *data)
 {
-	struct w1_gpio_ddata *pdata = data;
+	struct w1_gpio_ddata *ddata = data;
 
-	return gpiod_get_value(pdata->gpiod) ? 1 : 0;
+	return gpiod_get_value(ddata->gpiod) ? 1 : 0;
 }
 
 #if defined(CONFIG_OF)
@@ -74,15 +74,15 @@ MODULE_DEVICE_TABLE(of, w1_gpio_dt_ids);
 static int w1_gpio_probe(struct platform_device *pdev)
 {
 	struct w1_bus_master *master;
-	struct w1_gpio_ddata *pdata;
+	struct w1_gpio_ddata *ddata;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	/* Enforce open drain mode by default */
 	enum gpiod_flags gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
 	int err;
 
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
+	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
 		return -ENOMEM;
 
 	/*
@@ -99,23 +99,23 @@ static int w1_gpio_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
-	pdata->gpiod = devm_gpiod_get_index(dev, NULL, 0, gflags);
-	if (IS_ERR(pdata->gpiod)) {
+	ddata->gpiod = devm_gpiod_get_index(dev, NULL, 0, gflags);
+	if (IS_ERR(ddata->gpiod)) {
 		dev_err(dev, "gpio_request (pin) failed\n");
-		return PTR_ERR(pdata->gpiod);
+		return PTR_ERR(ddata->gpiod);
 	}
 
-	pdata->pullup_gpiod =
+	ddata->pullup_gpiod =
 		devm_gpiod_get_index_optional(dev, NULL, 1, GPIOD_OUT_LOW);
-	if (IS_ERR(pdata->pullup_gpiod)) {
+	if (IS_ERR(ddata->pullup_gpiod)) {
 		dev_err(dev, "gpio_request_one "
 			"(ext_pullup_enable_pin) failed\n");
-		return PTR_ERR(pdata->pullup_gpiod);
+		return PTR_ERR(ddata->pullup_gpiod);
 	}
 
-	master->data = pdata;
+	master->data = ddata;
 	master->read_bit = w1_gpio_read_bit;
-	gpiod_direction_output(pdata->gpiod, 1);
+	gpiod_direction_output(ddata->gpiod, 1);
 	master->write_bit = w1_gpio_write_bit;
 
 	/*
@@ -133,8 +133,8 @@ static int w1_gpio_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	if (pdata->pullup_gpiod)
-		gpiod_set_value(pdata->pullup_gpiod, 1);
+	if (ddata->pullup_gpiod)
+		gpiod_set_value(ddata->pullup_gpiod, 1);
 
 	platform_set_drvdata(pdev, master);
 
@@ -144,10 +144,10 @@ static int w1_gpio_probe(struct platform_device *pdev)
 static int w1_gpio_remove(struct platform_device *pdev)
 {
 	struct w1_bus_master *master = platform_get_drvdata(pdev);
-	struct w1_gpio_ddata *pdata = master->data;
+	struct w1_gpio_ddata *ddata = master->data;
 
-	if (pdata->pullup_gpiod)
-		gpiod_set_value(pdata->pullup_gpiod, 0);
+	if (ddata->pullup_gpiod)
+		gpiod_set_value(ddata->pullup_gpiod, 0);
 
 	w1_remove_master_device(master);
 
-- 
2.42.0


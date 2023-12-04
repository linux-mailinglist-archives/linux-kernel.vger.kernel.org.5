Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D77804148
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjLDWFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjLDWF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:05:29 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780E5FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:05:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAH4G-0003EO-JY; Mon, 04 Dec 2023 23:05:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAH4G-00DbY3-6U; Mon, 04 Dec 2023 23:05:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAH4F-00EMX6-TN; Mon, 04 Dec 2023 23:05:31 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 2/3] w1: gpio: Drop unused enable_external_pullup from driver data
Date:   Mon,  4 Dec 2023 23:05:22 +0100
Message-ID:  <7009fc53745c8e0336e9379022ce648a60c519f8.1701727212.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701727212.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701727212.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2219; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=iZiYCCot4tFbakRhO9/1l9MMZBqNsQ48MgdJZLGkafQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbk0hf6byIO3pueIYUffdIjp0VJY4K7iFX/YW7 nCF5PvLkDqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW5NIQAKCRCPgPtYfRL+ Trg0B/9gatIZe8tiLY8urH16QIiet3H5sbGv6UEua91F2XViJUukPKafvD98uoBvhbmsISw5zMT z1ChyaOwTuYnq6sWYshaES0S094/PcOPG6GSFZBwqgrbB4yZGyGnlJsesKN5Tga1O6rJY8Q67Ja j/lPKtM3ZdQp/qoy2uvF6qf9mNjcLz+L9biPE31+AD5GgczphCbkTwi/pkSq+Z85nrXCytqh8zg +In1zRjJyVQZQYlrjOTpZGEFSEBL5dQdkZB9uOdYruSCnwRZpQWZUtZfEK+mB797hQ4jfPXpMl1 rMKfBn0yNeckcU1hW41StNn31FHt6s2YFShcxGtM+wxneDqt
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

This member is always NULL, so drop it. That makes the suspend and
resume callbacks empty, so they can be dropped, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/w1/masters/w1-gpio.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index 8d65db65178c..67596428f69b 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -20,7 +20,6 @@
 struct w1_gpio_ddata {
 	struct gpio_desc *gpiod;
 	struct gpio_desc *pullup_gpiod;
-	void (*enable_external_pullup)(int enable);
 	unsigned int pullup_duration;
 };
 
@@ -134,9 +133,6 @@ static int w1_gpio_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	if (pdata->enable_external_pullup)
-		pdata->enable_external_pullup(1);
-
 	if (pdata->pullup_gpiod)
 		gpiod_set_value(pdata->pullup_gpiod, 1);
 
@@ -150,9 +146,6 @@ static int w1_gpio_remove(struct platform_device *pdev)
 	struct w1_bus_master *master = platform_get_drvdata(pdev);
 	struct w1_gpio_ddata *pdata = master->data;
 
-	if (pdata->enable_external_pullup)
-		pdata->enable_external_pullup(0);
-
 	if (pdata->pullup_gpiod)
 		gpiod_set_value(pdata->pullup_gpiod, 0);
 
@@ -161,34 +154,9 @@ static int w1_gpio_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused w1_gpio_suspend(struct device *dev)
-{
-	struct w1_bus_master *master = dev_get_drvdata(dev);
-	struct w1_gpio_ddata *pdata = master->data;
-
-	if (pdata->enable_external_pullup)
-		pdata->enable_external_pullup(0);
-
-	return 0;
-}
-
-static int __maybe_unused w1_gpio_resume(struct device *dev)
-{
-	struct w1_bus_master *master = dev_get_drvdata(dev);
-	struct w1_gpio_ddata *pdata = master->data;
-
-	if (pdata->enable_external_pullup)
-		pdata->enable_external_pullup(1);
-
-	return 0;
-}
-
-static SIMPLE_DEV_PM_OPS(w1_gpio_pm_ops, w1_gpio_suspend, w1_gpio_resume);
-
 static struct platform_driver w1_gpio_driver = {
 	.driver = {
 		.name	= "w1-gpio",
-		.pm	= &w1_gpio_pm_ops,
 		.of_match_table = of_match_ptr(w1_gpio_dt_ids),
 	},
 	.probe = w1_gpio_probe,
-- 
2.42.0


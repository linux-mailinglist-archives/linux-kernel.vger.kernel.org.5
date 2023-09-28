Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632717B13CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjI1HH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjI1HHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:19 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCDE1B8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-0002PP-A6; Thu, 28 Sep 2023 09:07:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll77-009WBl-TY; Thu, 28 Sep 2023 09:07:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll77-005ZXN-KF; Thu, 28 Sep 2023 09:07:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/23] gpio: ljca: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:06:51 +0200
Message-Id: <20230928070706.2290137-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1900; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=O5RheHuuuyYsWyRibPBNQY9XJKwZ/Al0AGKS9Y0bJLM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSRnTU9g1tvdKqYIlPSGMuvVMb7c843MQyWqD ZtRkvV5eKuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkZwAKCRCPgPtYfRL+ TjL9B/95CyQdlBR0263hEPruOveU6oJ15c5ZJU58TShADPK7w95fS2FWL9Vga4nxik4zqF9F01q ebPip0V17ByPN35InOlmoIEIGdekf2a7edauEvzkGss4heS9PAdOn+1f0ZoG+PcQan3cswHy0nS IGqXSh30Rc7JOUN778J74X8sh6G+L5o4/P7j3NdTven++/wbE9yqrB+s2wpLqqGFh3tdAUXwIjx 0heUCzou+RuZreGh7VLJ9PrZ6X1OrvRGYaTj1Lto6+7b9F/7DYBjKBvPHTH7q75CWLZ/g8/oH/i 9II0ogwA1esU3fC0tkG4bv0d6/hcGpXLLpp5dorcMJveTAhQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpio/gpio-ljca.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-ljca.c b/drivers/gpio/gpio-ljca.c
index 87863f0230f5..aca69329455f 100644
--- a/drivers/gpio/gpio-ljca.c
+++ b/drivers/gpio/gpio-ljca.c
@@ -421,7 +421,7 @@ static int ljca_gpio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ljca_gpio_remove(struct platform_device *pdev)
+static void ljca_gpio_remove(struct platform_device *pdev)
 {
 	struct ljca_gpio_dev *ljca_gpio = platform_get_drvdata(pdev);
 
@@ -429,7 +429,6 @@ static int ljca_gpio_remove(struct platform_device *pdev)
 	ljca_unregister_event_cb(ljca_gpio->gpio_info->ljca);
 	mutex_destroy(&ljca_gpio->irq_lock);
 	mutex_destroy(&ljca_gpio->trans_lock);
-	return 0;
 }
 
 #define LJCA_GPIO_DRV_NAME "ljca-gpio"
@@ -442,7 +441,7 @@ MODULE_DEVICE_TABLE(platform, ljca_gpio_id);
 static struct platform_driver ljca_gpio_driver = {
 	.driver.name = LJCA_GPIO_DRV_NAME,
 	.probe = ljca_gpio_probe,
-	.remove = ljca_gpio_remove,
+	.remove_new = ljca_gpio_remove,
 };
 module_platform_driver(ljca_gpio_driver);
 
-- 
2.40.1


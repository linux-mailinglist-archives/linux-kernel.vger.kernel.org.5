Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A167B13C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjI1HHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjI1HHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:20 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB621B9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-0002Pr-NZ; Thu, 28 Sep 2023 09:07:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-009WBu-AS; Thu, 28 Sep 2023 09:07:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-005ZXW-1M; Thu, 28 Sep 2023 09:07:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/23] gpio: mb86s7x: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:06:53 +0200
Message-Id: <20230928070706.2290137-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1839; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WPcDIjpmyzu/jlqFKeLdgoc1fiE6YSUTS+0IHvir+Ow=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSRqf4S9RdTk3Q3vhF0e9LUO0JOBOrWkbuHhq 9c0as1k9giJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkagAKCRCPgPtYfRL+ TnoiB/928vsCsni4kOWZ4UadomEZI2aY26oH+s3dV0sdTV9DHAnFCdL/a+GIkr1oedvp5QZLdSz 1UxVEN5smKMWfOzv2kA2hWxbg6FqPiiYb3n4fkmrLdAxDk6cVBDzd08U6vLmPDcZU0utTZsVSnd J36y+MKsrAvFo3IUboLzCh6ECrRd7+em1NqdmdQlHWYT02bganpFFKufwUhujSizfwz+va/hjTE oXePogmzX1VMBv9Ccex4LoaRrB4Y0LC8/l2oVVU5zQuebK+E5TbLj2AWiDMUmVjC0/ipU/3LOFC WNoq4czfd7HrBKXwXZjRWL/atX5fh7kX9tR/T/w4BOpn2KWZ
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
 drivers/gpio/gpio-mb86s7x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mb86s7x.c b/drivers/gpio/gpio-mb86s7x.c
index 248df657c38e..7fb298b4571b 100644
--- a/drivers/gpio/gpio-mb86s7x.c
+++ b/drivers/gpio/gpio-mb86s7x.c
@@ -204,15 +204,13 @@ static int mb86s70_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mb86s70_gpio_remove(struct platform_device *pdev)
+static void mb86s70_gpio_remove(struct platform_device *pdev)
 {
 	struct mb86s70_gpio_chip *gchip = platform_get_drvdata(pdev);
 
 	acpi_gpiochip_free_interrupts(&gchip->gc);
 	gpiochip_remove(&gchip->gc);
 	clk_disable_unprepare(gchip->clk);
-
-	return 0;
 }
 
 static const struct of_device_id mb86s70_gpio_dt_ids[] = {
@@ -236,7 +234,7 @@ static struct platform_driver mb86s70_gpio_driver = {
 		.acpi_match_table = ACPI_PTR(mb86s70_gpio_acpi_ids),
 	},
 	.probe = mb86s70_gpio_probe,
-	.remove = mb86s70_gpio_remove,
+	.remove_new = mb86s70_gpio_remove,
 };
 module_platform_driver(mb86s70_gpio_driver);
 
-- 
2.40.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123237B13D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjI1HIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjI1HHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293AACD2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll7A-0002Ri-Dh; Thu, 28 Sep 2023 09:07:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll7A-009WCZ-0Y; Thu, 28 Sep 2023 09:07:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll79-005ZY9-Nn; Thu, 28 Sep 2023 09:07:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/23] gpio: xgene-sb: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:07:03 +0200
Message-Id: <20230928070706.2290137-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zztpnxsZEJDFZIm9qSZPjBEfzvjHiZRS9y3gnRLWgew=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSR1nubBXr+coH9eBOJNEo6aa+yPeQ4YMVMX0 ZDw574HLTiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkdQAKCRCPgPtYfRL+ TiI2B/oDOUHb6ePdR5VqbUCgMJZxnP2/lZT7ygDZ/Mk5rREx7XWdA4p48ExDku2v8O99ZhRT8LV ro1ex9HnLOUhOV1fnXUal5mJpd1cKZ1sSphE28nBtiGGb/kfc5ICJUS3uIb579J7LJFhMzIfn/h W+5xj1dW+8cwJc2ZFilC7jOaY+Eh5Rgs9JjwYm1Jp9SljkPqhYRpM6B2kBeLiTPdcVnillrR+Qy 3IiAa2cahJbwOPaS3OOOpQyUs5LXfr6CjnmYXFNVzZAipoiIfVO0ubzXeyfde+2CJhLO2Z4ocvI DK9B/ptJuv8oqaFwM2WaNOBS47iGDwy/97cr8oC9/d+0jXtr
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
 drivers/gpio/gpio-xgene-sb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index 453bf9338ac4..bd5befa807c3 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -295,15 +295,13 @@ static int xgene_gpio_sb_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int xgene_gpio_sb_remove(struct platform_device *pdev)
+static void xgene_gpio_sb_remove(struct platform_device *pdev)
 {
 	struct xgene_gpio_sb *priv = platform_get_drvdata(pdev);
 
 	acpi_gpiochip_free_interrupts(&priv->gc);
 
 	irq_domain_remove(priv->irq_domain);
-
-	return 0;
 }
 
 static const struct of_device_id xgene_gpio_sb_of_match[] = {
@@ -327,7 +325,7 @@ static struct platform_driver xgene_gpio_sb_driver = {
 		   .acpi_match_table = ACPI_PTR(xgene_gpio_sb_acpi_match),
 		   },
 	.probe = xgene_gpio_sb_probe,
-	.remove = xgene_gpio_sb_remove,
+	.remove_new = xgene_gpio_sb_remove,
 };
 module_platform_driver(xgene_gpio_sb_driver);
 
-- 
2.40.1


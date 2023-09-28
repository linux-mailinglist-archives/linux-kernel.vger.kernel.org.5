Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489747B13B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjI1HH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjI1HHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:18 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3904E1AC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll77-0002OH-7C; Thu, 28 Sep 2023 09:07:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll76-009WBP-Qd; Thu, 28 Sep 2023 09:07:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll76-005ZWz-HM; Thu, 28 Sep 2023 09:07:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/23] gpio: amdpt: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:06:45 +0200
Message-Id: <20230928070706.2290137-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1704; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=pmBQ7x4NlnXZMn9aA/nAoCKl01g7jBU9/A19/uOU6ts=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSRgGcmEwGahH1iTqFL7RNhqMJ9vePhEwX8cN fgjDAG+mw+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkYAAKCRCPgPtYfRL+ TsGnB/oCwnKuHDTBqxM0td9Y3sbgKQ0IHV+CxG1zN/bLO54cAS+c+2Reqy6DB3VeHXJvZRqPQcz q6LubKG/DWDnO5vXsXIKhZkKC84nvwYylxX3BzzWB6GVSxeWxlWz8p3Hzcv4ZzJZCYDaC5TZ1+r 9hf8Q/vSN5zGhW3CSP2ZFFpC6+hDofGbTXaf/NGhODjMe5XOoQmUKB1DUh+dUvFxFG2Wo9EG+Yt IdyOgx/a7XCgitedepWM4eLfSCtBhM0/pfKhdgaidDdcQrSsg+3Qr5ODJGJwWITwTZOMi1nMHPj 0wvHk+Dd4ercHPeAVJcxYoQGv/c7d/C4JYe5Pj7NrlFx73Ld
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
 drivers/gpio/gpio-amdpt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
index 07c6d090058d..0a2ea9db4682 100644
--- a/drivers/gpio/gpio-amdpt.c
+++ b/drivers/gpio/gpio-amdpt.c
@@ -122,13 +122,11 @@ static int pt_gpio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pt_gpio_remove(struct platform_device *pdev)
+static void pt_gpio_remove(struct platform_device *pdev)
 {
 	struct pt_gpio_chip *pt_gpio = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&pt_gpio->gc);
-
-	return 0;
 }
 
 static const struct acpi_device_id pt_gpio_acpi_match[] = {
@@ -145,7 +143,7 @@ static struct platform_driver pt_gpio_driver = {
 		.acpi_match_table = ACPI_PTR(pt_gpio_acpi_match),
 	},
 	.probe = pt_gpio_probe,
-	.remove = pt_gpio_remove,
+	.remove_new = pt_gpio_remove,
 };
 
 module_platform_driver(pt_gpio_driver);
-- 
2.40.1


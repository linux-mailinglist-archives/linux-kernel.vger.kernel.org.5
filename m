Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AA07B13E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjI1HI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjI1HHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C6EC1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-0002Pi-IO; Thu, 28 Sep 2023 09:07:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-009WBq-5A; Thu, 28 Sep 2023 09:07:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll77-005ZXR-S4; Thu, 28 Sep 2023 09:07:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/23] gpio: lpc18xx: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:06:52 +0200
Message-Id: <20230928070706.2290137-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=r6gSrBD5louss3Pb3GEhi8iDF5ZJsJp/xHMLIjEPUXI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSRoPPwhAHeunrGSHzBaqKYVPL7fpeFT8pED+ BnfUsDk0tmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkaAAKCRCPgPtYfRL+ TheCB/95/GzZjoA8Q8L9sPtKA+hptDBPpeF5lihSAoaiMRz/uH3/D+E8LgTG4QzrMkHqT7w8RP6 t9giJS2C73ja7I/bnZOTKYdBAnr8ES9SBPKI9vrnTsTOa4k9L7PBGTDrkUoPkSAqlXJUv09s6H5 V8At5Qfsf60TBp2xjXqosU/a7iv2MCfjF2ETHgIuBZ4DVWx9vv44tFvQpG883c3P3edp74ZUuRE 6UQwnhielvT+qJC0rSw7g9ewBtBA40Xr6x5aGlYHmXh4WiV9jClrEo8vUKXt0f7zC3+AKa7KP3r /IKK8HgIuZMZY+oHw1JzvIrYkHR7ab1a9OHmfhyK1xroJgeu
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
 drivers/gpio/gpio-lpc18xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-lpc18xx.c b/drivers/gpio/gpio-lpc18xx.c
index ed3f653a1dfc..5c6bb57a8c99 100644
--- a/drivers/gpio/gpio-lpc18xx.c
+++ b/drivers/gpio/gpio-lpc18xx.c
@@ -381,7 +381,7 @@ static int lpc18xx_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int lpc18xx_gpio_remove(struct platform_device *pdev)
+static void lpc18xx_gpio_remove(struct platform_device *pdev)
 {
 	struct lpc18xx_gpio_chip *gc = platform_get_drvdata(pdev);
 
@@ -389,8 +389,6 @@ static int lpc18xx_gpio_remove(struct platform_device *pdev)
 		irq_domain_remove(gc->pin_ic->domain);
 
 	clk_disable_unprepare(gc->clk);
-
-	return 0;
 }
 
 static const struct of_device_id lpc18xx_gpio_match[] = {
@@ -401,7 +399,7 @@ MODULE_DEVICE_TABLE(of, lpc18xx_gpio_match);
 
 static struct platform_driver lpc18xx_gpio_driver = {
 	.probe	= lpc18xx_gpio_probe,
-	.remove	= lpc18xx_gpio_remove,
+	.remove_new = lpc18xx_gpio_remove,
 	.driver	= {
 		.name		= "lpc18xx-gpio",
 		.of_match_table	= lpc18xx_gpio_match,
-- 
2.40.1


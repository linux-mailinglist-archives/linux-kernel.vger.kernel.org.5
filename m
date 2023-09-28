Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E2C7B13FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjI1HIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjI1HH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6C81B0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll79-0002QY-Cf; Thu, 28 Sep 2023 09:07:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-009WCA-Vy; Thu, 28 Sep 2023 09:07:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-005ZXl-Mq; Thu, 28 Sep 2023 09:07:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/23] gpio: omap: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:06:57 +0200
Message-Id: <20230928070706.2290137-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wEFMqOEsGUYaZ8PzVi4YAslK/wtyEnoVwyh+B2QiGHA=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlRRlbxIu50W+V/ltro6/2PTeD3tldWFTbvbFHTcvRYZd bsc327XyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBEgvey/5XzVPASU7Hev/Dd bF3v2MSlW/OyTILeFl82ebjl0eb/nle1Fy62YhBU2mQkGPDwcMbv+g039OKkP+dXr0hdqpTfqrF PUrFQ8fH61E2mn/6fYUr6wts00/zEktWuv+6etOyVmf+hTVN+q+Sac5rPO+/o53Ue59MJ+Vj/SS XLZLbzUZ/VqeVlClGLa5krvbwVOXidN3uJr0qLb3+UK898Jex5qKjo86m3sxosaqKKtXeseTuPx SlILWRzd2pRbJ3L6l+aLRtfpj3xv8th2f5n5TXPedGvjF5uc/EIqOPvZnNIdf0q9T84ek2vgqW7 15tyu+LZNeqpftMimYI3WanuKyxPz59jwKyWmu0RORkA
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
 drivers/gpio/gpio-omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index a927680c66f8..8889755e2d03 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1489,7 +1489,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int omap_gpio_remove(struct platform_device *pdev)
+static void omap_gpio_remove(struct platform_device *pdev)
 {
 	struct gpio_bank *bank = platform_get_drvdata(pdev);
 
@@ -1498,8 +1498,6 @@ static int omap_gpio_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	if (bank->dbck_flag)
 		clk_unprepare(bank->dbck);
-
-	return 0;
 }
 
 static int __maybe_unused omap_gpio_runtime_suspend(struct device *dev)
@@ -1560,7 +1558,7 @@ static const struct dev_pm_ops gpio_pm_ops = {
 
 static struct platform_driver omap_gpio_driver = {
 	.probe		= omap_gpio_probe,
-	.remove		= omap_gpio_remove,
+	.remove_new	= omap_gpio_remove,
 	.driver		= {
 		.name	= "omap_gpio",
 		.pm	= &gpio_pm_ops,
-- 
2.40.1


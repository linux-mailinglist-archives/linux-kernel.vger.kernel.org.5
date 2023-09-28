Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50B47B13E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjI1HIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjI1HHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4403CCD3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll77-0002OQ-ET; Thu, 28 Sep 2023 09:07:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll77-009WBS-17; Thu, 28 Sep 2023 09:07:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll76-005ZX3-Np; Thu, 28 Sep 2023 09:07:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/23] gpio: brcmstb: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:06:46 +0200
Message-Id: <20230928070706.2290137-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1927; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=L+YuiCv+iiMESLsUmp6IhUmqUktxmuMzPNS/HWpaLWs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSRiwnkuoSq9wBB88Trgo/gTM6hWPAwSqR+L/ XF912idvtKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkYgAKCRCPgPtYfRL+ ThKzB/94/Ax3Aq+EhF1eAa0+/BxZXi3JwBr2XRoweGi9T1083yVRzfoS8tFl1Q23Ez69e/Z8sYD 7KiLZ5tprjeU0utGcs1jon7+ysvoD7Kzm6RaL6cSiCJPCQ7wjrlemFvfUsTViE5Ev3RCoubib2V bfE9sB4y4qPFJTHdm5fm1zoT0cCFvFaOR4ic0KSnxnq9ZwxjbC1Ylg160+bFvOr9sEBlp9x8P3l ZKdWePxLPgScwk7Un7vsRCad3LILqv3zZMG/qZ5oKYmSJlRg6sCNH/xuVfXR+Kfywy8U0a1AzGK twvQttfSz4m5vuTXI87y7HItA2L0iwS52sAfoT1vjfbnvkyT
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
 drivers/gpio/gpio-brcmstb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index bccdbfd5ec80..a789af4a5c85 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -371,7 +371,7 @@ static int brcmstb_gpio_sanity_check_banks(struct device *dev,
 	}
 }
 
-static int brcmstb_gpio_remove(struct platform_device *pdev)
+static void brcmstb_gpio_remove(struct platform_device *pdev)
 {
 	struct brcmstb_gpio_priv *priv = platform_get_drvdata(pdev);
 	struct brcmstb_gpio_bank *bank;
@@ -395,8 +395,6 @@ static int brcmstb_gpio_remove(struct platform_device *pdev)
 	 */
 	list_for_each_entry(bank, &priv->bank_list, node)
 		gpiochip_remove(&bank->gc);
-
-	return 0;
 }
 
 static int brcmstb_gpio_of_xlate(struct gpio_chip *gc,
@@ -757,7 +755,7 @@ static struct platform_driver brcmstb_gpio_driver = {
 		.pm = &brcmstb_gpio_pm_ops,
 	},
 	.probe = brcmstb_gpio_probe,
-	.remove = brcmstb_gpio_remove,
+	.remove_new = brcmstb_gpio_remove,
 	.shutdown = brcmstb_gpio_shutdown,
 };
 module_platform_driver(brcmstb_gpio_driver);
-- 
2.40.1


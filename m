Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968A87B13F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjI1HIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjI1HHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:25 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1F6F9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll7A-0002S1-OQ; Thu, 28 Sep 2023 09:07:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll7A-009WCd-At; Thu, 28 Sep 2023 09:07:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll7A-005ZYE-1T; Thu, 28 Sep 2023 09:07:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/23] gpio: xgs-iproc: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:07:04 +0200
Message-Id: <20230928070706.2290137-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=sxVA/y9La9BszqNJ1kefMBOoUDJPzAiVmTfSV9IJ0JA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSR2BwmVtukbBUIT0Q7riLSWhpIQXFAcUL8Xe /erPkcOP9KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkdgAKCRCPgPtYfRL+ TrgRCACAq8rdQ3J84HD06lj45/F9HM5kh4c/f6N4opMI4Vpuz8SLDowUZjgND18d/Owi2psX+v6 RRTZCyYYfa02VY+OE6dBs+GaZAznYofBLpgDVsbveIs5pZVL40sOKw0XB7D2+L8rA4LXKe7JXab q/eBsGDxgTAzizqJCczMq6vBUVIvvvHlQrhYfQngnruhV/cvW+a3qZRfXQRqB2FdHCLL9WQ2RgL H7LFec0WxjIQXP2sk+D5w0ZyU6AQkCkawzfdLRwLBE+9Bmd+vOucGzzudh0e86mN3BI9G2iqdht hNDwK+sfO9aYhiNkmdG5qvdwVhVrTFVG/1WGKxkR6ZGeTbpZ
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
 drivers/gpio/gpio-xgs-iproc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-xgs-iproc.c b/drivers/gpio/gpio-xgs-iproc.c
index 2d23b27d55af..d445eea03687 100644
--- a/drivers/gpio/gpio-xgs-iproc.c
+++ b/drivers/gpio/gpio-xgs-iproc.c
@@ -291,7 +291,7 @@ static int iproc_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int iproc_gpio_remove(struct platform_device *pdev)
+static void iproc_gpio_remove(struct platform_device *pdev)
 {
 	struct iproc_gpio_chip *chip = platform_get_drvdata(pdev);
 
@@ -302,8 +302,6 @@ static int iproc_gpio_remove(struct platform_device *pdev)
 		val &= ~IPROC_CCA_INT_F_GPIOINT;
 		writel_relaxed(val, chip->intr + IPROC_CCA_INT_MASK);
 	}
-
-	return 0;
 }
 
 static const struct of_device_id bcm_iproc_gpio_of_match[] = {
@@ -318,7 +316,7 @@ static struct platform_driver bcm_iproc_gpio_driver = {
 		.of_match_table = bcm_iproc_gpio_of_match,
 	},
 	.probe = iproc_gpio_probe,
-	.remove = iproc_gpio_remove,
+	.remove_new = iproc_gpio_remove,
 };
 
 module_platform_driver(bcm_iproc_gpio_driver);
-- 
2.40.1


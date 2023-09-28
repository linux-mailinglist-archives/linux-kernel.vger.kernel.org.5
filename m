Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84347B13BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjI1HHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjI1HHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:19 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58361B2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll77-0002Ov-QA; Thu, 28 Sep 2023 09:07:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll77-009WBa-DB; Thu, 28 Sep 2023 09:07:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll77-005ZXB-3v; Thu, 28 Sep 2023 09:07:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/23] gpio: dln2: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:06:48 +0200
Message-Id: <20230928070706.2290137-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=biqDfI9M7d3E1sFhGRzLi5Y0K0g1VMmj7HWgBhC3W9A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSRkLzXqHoQJjWHt1lfdVX0FRrTmSSk1IIHRw IuKg+Yszm6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkZAAKCRCPgPtYfRL+ TktVB/sFfvb39bvdNhkC1dp4L71giJ5S/rWTMATly8q6Tn0Uog8MdoXTgAqbtPtlJeOCGZvDlj6 cYxsjm9nu4n74vlPVCABpp6kSKdz5sec4BMudfu8v1W7/NYpV3vU+mZgO/AzER34BxBrSbT0bf4 j6HwRaRAk5QeVyJexTupnY5EPgs/ZOLUJLjsS5YXWY4zBI8ldHmqj3+pGkkBUFOThAA4dhMt5EB 1d+rbQICjy0FTyILgIps0q/wkhJzuqoQvd32DvAJ71+nxpTWqmUrcWwfphDlb+aXj+SLZHN9igb QCjSd7+CdO0u6hPNhaOV95bpAVP38zsrEv5kq23cWyl/AZlA
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
 drivers/gpio/gpio-dln2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-dln2.c b/drivers/gpio/gpio-dln2.c
index 71fa437b491f..7ead1f51128a 100644
--- a/drivers/gpio/gpio-dln2.c
+++ b/drivers/gpio/gpio-dln2.c
@@ -504,17 +504,15 @@ static int dln2_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int dln2_gpio_remove(struct platform_device *pdev)
+static void dln2_gpio_remove(struct platform_device *pdev)
 {
 	dln2_unregister_event_cb(pdev, DLN2_GPIO_CONDITION_MET_EV);
-
-	return 0;
 }
 
 static struct platform_driver dln2_gpio_driver = {
 	.driver.name	= "dln2-gpio",
 	.probe		= dln2_gpio_probe,
-	.remove		= dln2_gpio_remove,
+	.remove_new	= dln2_gpio_remove,
 };
 
 module_platform_driver(dln2_gpio_driver);
-- 
2.40.1


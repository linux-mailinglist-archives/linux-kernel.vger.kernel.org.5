Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DB57B13E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjI1HIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjI1HHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F412CCB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll79-0002QO-6q; Thu, 28 Sep 2023 09:07:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-009WC6-QT; Thu, 28 Sep 2023 09:07:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-005ZXh-HE; Thu, 28 Sep 2023 09:07:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/23] gpio: mpc8xxx: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:06:56 +0200
Message-Id: <20230928070706.2290137-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Jl41cOt7+Lv9JbkVXP3DWMA0yt63VqWt5+gjigiRDOg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSRtx7bDmd79vKN6bzdwsQxQsN6SAjHD3+1pI KhejWJqu7qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkbQAKCRCPgPtYfRL+ TvrdB/4nqoqozrSwD19oFZgtMtd/oH7H9w0TmDzyaMqL9WZExdF4GZRBYQIE8Il+hTgu/bFbHMW doEf3zmZ877nRP8PjdxNXU2/6cAqoi2QKHycIc8HtkPFpr43FMiCvVSBzL6GSO32CmNymsDUJtv 0+N0M+iFPb3IsBUYRzp+syaq6+V8P4gLo+5/9fs8yJMzM3mDta9eK2LRmqtOyEe7ug6saInv5lV D37SGeV/Yxdhn77ou2d2t8TdXzc4a5PrzVao4g7/owwdP5girmgxsFEj7erUnDgK0sbaF7Jtgnw Wv4gjke//rQVi9Qm6UZfxG5P37P69lQTrFgb/EpVnSNcAPeI
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
 drivers/gpio/gpio-mpc8xxx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index ebf2f511df59..c0125ac73906 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -419,7 +419,7 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mpc8xxx_remove(struct platform_device *pdev)
+static void mpc8xxx_remove(struct platform_device *pdev)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = platform_get_drvdata(pdev);
 
@@ -427,8 +427,6 @@ static int mpc8xxx_remove(struct platform_device *pdev)
 		irq_set_chained_handler_and_data(mpc8xxx_gc->irqn, NULL, NULL);
 		irq_domain_remove(mpc8xxx_gc->irq);
 	}
-
-	return 0;
 }
 
 #ifdef CONFIG_ACPI
@@ -441,7 +439,7 @@ MODULE_DEVICE_TABLE(acpi, gpio_acpi_ids);
 
 static struct platform_driver mpc8xxx_plat_driver = {
 	.probe		= mpc8xxx_probe,
-	.remove		= mpc8xxx_remove,
+	.remove_new	= mpc8xxx_remove,
 	.driver		= {
 		.name = "gpio-mpc8xxx",
 		.of_match_table	= mpc8xxx_gpio_ids,
-- 
2.40.1


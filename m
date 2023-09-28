Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8467B13DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjI1HIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjI1HHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13254CD0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll7A-0002RL-2r; Thu, 28 Sep 2023 09:07:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll79-009WCR-ME; Thu, 28 Sep 2023 09:07:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll79-005ZY1-D8; Thu, 28 Sep 2023 09:07:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/23] gpio: ts5500: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:07:01 +0200
Message-Id: <20230928070706.2290137-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=iw7ZWGXZvP/QIT4+jRzjsvk/ZtvTr2U/nxvNwmbgPAU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSRz6+CzebKd761NACqJZ1kdWEq/3NjORnf2n NtFLBz9iYaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkcwAKCRCPgPtYfRL+ Tj8wB/9ErREPyl2iDDwolD80XRrR8pe5lQokZ37nIrWxoN9GdkTAgHvqoeiFS+hcZTFta5cANBJ 87frTN1jWmuT7Q/0+rOr1HzPy23ruqXIgVIGKI/O0EvrsXh088uI5sdjd1OgySWhov0eqkQs4h0 OAj7kj8lilOZ24sdBra0cz0q1D9l6+xOxyIqSQY8t1xQu/+GfLi/BpJZc1bb3bVLfdEhnziQZ++ pLIOOtaI8eUzTg59mIiqNVx5TByiKhxon8MH7Qn4NL2CgOhNR85L864RXyK1LXCRdWRPbJC7lrd UPqJXN6zEzJ9DZAtR0MuYms8wXftJPJPF0VoR7JlSF6u5k7c
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
 drivers/gpio/gpio-ts5500.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-ts5500.c b/drivers/gpio/gpio-ts5500.c
index 8e03614c7a24..90f8e9e9915e 100644
--- a/drivers/gpio/gpio-ts5500.c
+++ b/drivers/gpio/gpio-ts5500.c
@@ -412,13 +412,11 @@ static int ts5500_dio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ts5500_dio_remove(struct platform_device *pdev)
+static void ts5500_dio_remove(struct platform_device *pdev)
 {
 	struct ts5500_priv *priv = platform_get_drvdata(pdev);
 
 	ts5500_disable_irq(priv);
-
-	return 0;
 }
 
 static const struct platform_device_id ts5500_dio_ids[] = {
@@ -435,7 +433,7 @@ static struct platform_driver ts5500_dio_driver = {
 		.name = "ts5500-dio",
 	},
 	.probe = ts5500_dio_probe,
-	.remove = ts5500_dio_remove,
+	.remove_new = ts5500_dio_remove,
 	.id_table = ts5500_dio_ids,
 };
 
-- 
2.40.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAA57F6472
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345136AbjKWQ45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWQ4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:56:55 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37587BC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:57:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0d-0004zR-IT; Thu, 23 Nov 2023 17:56:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0d-00B54k-66; Thu, 23 Nov 2023 17:56:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0c-006ozM-TS; Thu, 23 Nov 2023 17:56:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 05/18] mfd: hi655x-pmic: Convert to platform remove callback returning void
Date:   Thu, 23 Nov 2023 17:56:33 +0100
Message-ID: <20231123165627.492259-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
References: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dI9I7gz8/r2ZcPCua/AplnWUDrg6g0W/Uk6MlFqZHHs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlX4RB+83Rz11Z6/NItwJ0/Z2CF9epAbSH3zyAJ bGInwhPFXeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZV+EQQAKCRCPgPtYfRL+ TkNtB/wOctIRHw/GpGBKwLcWP5+UlhVikKuLUUUSBgs3bn3C+ji2CoY2cc56deEZZE4k5Fd7MGM /ae9HmULVtrQu6GSj25QNZna4hagUvC/NNFcDNbJ30cMxve4yqWRilnBqKKV5Napyc1dFgwiiGE cKT+l2u9f2FN1qHCxvW/ATkHT6zlXJPkUcJqhV1IMHRPN/q71spl8z3K9gsI0mmY1S3PnN9IsXk v3GqUubRdIGafZl75/bHxHOMkXRNLF+sXhdbNeJ9dRzO77PI71gbn+QtRzrAAdlOa+N44N20QA6 JAMBUPoxPHrt25mXDUnYv1y92yIivSmpLYmHoZYw9oRCkAa9
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mfd/hi655x-pmic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
index 8feae8d8fd9d..042109304db4 100644
--- a/drivers/mfd/hi655x-pmic.c
+++ b/drivers/mfd/hi655x-pmic.c
@@ -144,13 +144,12 @@ static int hi655x_pmic_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hi655x_pmic_remove(struct platform_device *pdev)
+static void hi655x_pmic_remove(struct platform_device *pdev)
 {
 	struct hi655x_pmic *pmic = platform_get_drvdata(pdev);
 
 	regmap_del_irq_chip(gpiod_to_irq(pmic->gpio), pmic->irq_data);
 	mfd_remove_devices(&pdev->dev);
-	return 0;
 }
 
 static const struct of_device_id hi655x_pmic_match[] = {
@@ -165,7 +164,7 @@ static struct platform_driver hi655x_pmic_driver = {
 		.of_match_table = hi655x_pmic_match,
 	},
 	.probe  = hi655x_pmic_probe,
-	.remove = hi655x_pmic_remove,
+	.remove_new = hi655x_pmic_remove,
 };
 module_platform_driver(hi655x_pmic_driver);
 
-- 
2.42.0


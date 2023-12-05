Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC46805418
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbjLEM0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjLEM0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:26:33 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D08D7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:26:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVX-0005XW-KJ; Tue, 05 Dec 2023 13:26:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVW-00Djuo-SO; Tue, 05 Dec 2023 13:26:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVW-00EhQa-JR; Tue, 05 Dec 2023 13:26:34 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 1/8] regulator: arizona-ldo1: Convert to platform remove callback returning void
Date:   Tue,  5 Dec 2023 13:26:16 +0100
Message-ID:  <76c7af01e2c8b3ab6585a04bc3f0d163fbb7fdf7.1701778038.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2157; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=tqCSGHqBxpGncb/+HKOeTjE6jA8FKgj6miulNJehbSo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbxbnODU3ZgR0fcmS1aFFE63uhc6c35DkU4ysm IwvnJ5XRzWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW8W5wAKCRCPgPtYfRL+ TqJUB/42N8x71AwQgruQABeImfIN7vEaTkaTthiUERrgXAnkBzZ9gegXAy7pvht0kx7KCwXwYKQ f/m/Xkrf8wXWN+2PAo0aoBsh9p+K4akQOsOuApKCOWItKTNextjtAYmplBZnZnlzBDFcCyX+D9y q5+SdJ9ZXfgGTOEhBIoTMekZawYBDuAaTno7ZTLTPK0X46E2miZttmTywkwuR8jdcx8xWztHdf2 uqz2j8yAzXaxXiPf+vDjO9RjhVw+7OoEZ9vSxqmSwXo8FdZm22cGjZ3NQ49s4fiYdipQGzx9uhV TrlpV9kbWMTQ3P76Tzgr8GKnX83oMIqzv4BoL5d3qpeJEWLS
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
 drivers/regulator/arizona-ldo1.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index b465c0010665..4b54068d4f59 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -339,14 +339,12 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int arizona_ldo1_remove(struct platform_device *pdev)
+static void arizona_ldo1_remove(struct platform_device *pdev)
 {
 	struct arizona_ldo1 *ldo1 = platform_get_drvdata(pdev);
 
 	if (ldo1->ena_gpiod)
 		gpiod_put(ldo1->ena_gpiod);
-
-	return 0;
 }
 
 static int madera_ldo1_probe(struct platform_device *pdev)
@@ -377,7 +375,7 @@ static int madera_ldo1_probe(struct platform_device *pdev)
 
 static struct platform_driver arizona_ldo1_driver = {
 	.probe = arizona_ldo1_probe,
-	.remove = arizona_ldo1_remove,
+	.remove_new = arizona_ldo1_remove,
 	.driver		= {
 		.name	= "arizona-ldo1",
 		.probe_type = PROBE_FORCE_SYNCHRONOUS,
@@ -386,7 +384,7 @@ static struct platform_driver arizona_ldo1_driver = {
 
 static struct platform_driver madera_ldo1_driver = {
 	.probe = madera_ldo1_probe,
-	.remove = arizona_ldo1_remove,
+	.remove_new = arizona_ldo1_remove,
 	.driver		= {
 		.name	= "madera-ldo1",
 		.probe_type = PROBE_FORCE_SYNCHRONOUS,
-- 
2.42.0


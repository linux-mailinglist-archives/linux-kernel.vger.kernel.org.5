Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F24805416
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbjLEM0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjLEM0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:26:32 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2783C11F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:26:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVY-0005Y2-7R; Tue, 05 Dec 2023 13:26:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVX-00Djv6-Qq; Tue, 05 Dec 2023 13:26:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVX-00EhQu-I2; Tue, 05 Dec 2023 13:26:35 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 6/8] regulator: userspace-consumer: Convert to platform remove callback returning void
Date:   Tue,  5 Dec 2023 13:26:21 +0100
Message-ID:  <89c5f261707bf178e1508cf5dd55121f0da2dc3f.1701778038.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2190; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=A8FP1XBHehjd8UZNqwQtALdNNbXhhXcBzW90wH3+wU0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbxbt3vaMkK4LhyfDydpOLGLXDFYQBWohwmjpu 9scuU8+/uOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW8W7QAKCRCPgPtYfRL+ TtCQB/9nVBvW/kdX4kAi9nIrvM74HxCnyXKpICHcrA/OS3LUZ9JMacf2aFINSrGVRFzqWXY6zbP CxwOkupHvIut6+Rgs5HyxXwT8sF4Dh/KpH5fKZ4/A7oEBEX8FXWauziq8vMAjxavImdQCLsNHd2 w9W+Qb7bBfW/c2SYnFwTyJ0aWamRJwT/ZkiaF7cc8buQs9HXbDSgtG4neFmrW1XSHOlCciPom8o cdPsI8kf4xyVyxY7BFDhtjO8ZnpQitWrMbU0V6Eh1FCtStPSnFDETH8Fig2KLG2+Q/ymECJn8Z+ 3CtO9SueGnykA0xkxN6ahwAQxtoVvNDH7yHz50X7ty0t545p
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
 drivers/regulator/userspace-consumer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 97f075ed68c9..53d1b9d6f69c 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -194,7 +194,7 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int regulator_userspace_consumer_remove(struct platform_device *pdev)
+static void regulator_userspace_consumer_remove(struct platform_device *pdev)
 {
 	struct userspace_consumer_data *data = platform_get_drvdata(pdev);
 
@@ -202,8 +202,6 @@ static int regulator_userspace_consumer_remove(struct platform_device *pdev)
 
 	if (data->enabled && !data->no_autoswitch)
 		regulator_bulk_disable(data->num_supplies, data->supplies);
-
-	return 0;
 }
 
 static const struct of_device_id regulator_userspace_consumer_of_match[] = {
@@ -213,7 +211,7 @@ static const struct of_device_id regulator_userspace_consumer_of_match[] = {
 
 static struct platform_driver regulator_userspace_consumer_driver = {
 	.probe		= regulator_userspace_consumer_probe,
-	.remove		= regulator_userspace_consumer_remove,
+	.remove_new	= regulator_userspace_consumer_remove,
 	.driver		= {
 		.name		= "reg-userspace-consumer",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.42.0


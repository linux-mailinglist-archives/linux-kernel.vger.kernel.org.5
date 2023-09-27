Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0A97AFDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjI0ILr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjI0ILA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:11:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04F6CC4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:10:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd9-0007vL-1t; Wed, 27 Sep 2023 10:10:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd8-009I6x-Ka; Wed, 27 Sep 2023 10:10:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd8-005BQD-Ba; Wed, 27 Sep 2023 10:10:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 03/27] platform/chrome: cros_ec_lightbar: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 10:10:16 +0200
Message-Id: <20230927081040.2198742-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Tfs5gi7h7v1Dwa3H1JCi2pH6aHZKCdFVdfdoZK+EHJA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlE+NgCQKHZFj5mqOwyG6uYKFEWnnxsQRTVtbJ1 /YmRJcnkKyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRPjYAAKCRCPgPtYfRL+ TgEwB/4iiOJeH8c8mxCUWtYw9NVWS834cnqPM7W8mzvLCpmz/PHR4fvj9Px95xRvwOn/gWJfVWY 0WJySnZFHYiQIZ8reBiJw3DqVIh4Ka7byTW7+8kaClQKd9HA/ZaDdD/xGpm37Xgg+GsH1Awaq/7 sAeVd3eLLzYDNQ9gisnGhwP/t4cM8/7l0Ar8Txf1OvpbmiPbXDvQFYtKAU74U5fC14uzxwwyRxX 5lr1Qn8xTvimqO6QJXGJlWB8xnkLCJJAbkug0UiVHXDGyd9axwUlgiwvNelul4yGeQY96ACVXQA 21HaoxUcIbf1ZkmsU0XZFgUvdAA+8P9/59MD48ZzjMkXoyMN
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/platform/chrome/cros_ec_lightbar.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index 376425bbd8ff..6677cc6c4984 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -560,7 +560,7 @@ static int cros_ec_lightbar_probe(struct platform_device *pd)
 	return ret;
 }
 
-static int cros_ec_lightbar_remove(struct platform_device *pd)
+static void cros_ec_lightbar_remove(struct platform_device *pd)
 {
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
 
@@ -569,8 +569,6 @@ static int cros_ec_lightbar_remove(struct platform_device *pd)
 
 	/* Let the EC take over the lightbar again. */
 	lb_manual_suspend_ctrl(ec_dev, 0);
-
-	return 0;
 }
 
 static int __maybe_unused cros_ec_lightbar_resume(struct device *dev)
@@ -603,7 +601,7 @@ static struct platform_driver cros_ec_lightbar_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = cros_ec_lightbar_probe,
-	.remove = cros_ec_lightbar_remove,
+	.remove_new = cros_ec_lightbar_remove,
 };
 
 module_platform_driver(cros_ec_lightbar_driver);
-- 
2.40.1


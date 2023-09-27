Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A516F7AFDD4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjI0ILu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjI0IK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:10:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5A81B5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:10:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd8-0007vI-Rl; Wed, 27 Sep 2023 10:10:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd8-009I6r-9x; Wed, 27 Sep 2023 10:10:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd8-005BQ6-0m; Wed, 27 Sep 2023 10:10:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 01/27] platform/chrome: cros_ec_chardev: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 10:10:14 +0200
Message-Id: <20230927081040.2198742-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Xe6M9G5oHpj29v0p0F+j+Zzzp8VU3j+XZbTFtKR2XC8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlE+NeiBb7JrW4zkLm/SiYb1HpuFi88VxguMriX 3i2w3k/Yj6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRPjXgAKCRCPgPtYfRL+ TlPRB/9V/q+9Nu1bDmwLd4eMhIr7+4mEjxDJyZoypCumo78BRHLbXeRwy6q1aqMW/jZ9OLbUIQg aX5tkB3jkFdlCobZquUz+DBkjI375NRCmhSLCxxys2lhREZZnlfwdg3VOmFWM09apLwKa1t0XIe 06/g3lm7O6kJCiz72NP6qcPBtNfraWJ4OxIAAMKJLfsCfDQTzulmNEq0WneqTN/rl5fKiAJpIbx IV33lsVXIdtDxxRmmaFF0UpSpXbVmklUoYAmum5ZEHcDqKTIkOhCICFmtMHSiiKp/1DSQyFMUvz V1VvsWmO1bjFBo7IneI4dY5C9WfZA3FFhPjC7g18/zccoiv/
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
 drivers/platform/chrome/cros_ec_chardev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index d6de5a294128..81950bb2c6da 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -396,13 +396,11 @@ static int cros_ec_chardev_probe(struct platform_device *pdev)
 	return misc_register(&data->misc);
 }
 
-static int cros_ec_chardev_remove(struct platform_device *pdev)
+static void cros_ec_chardev_remove(struct platform_device *pdev)
 {
 	struct chardev_data *data = dev_get_drvdata(&pdev->dev);
 
 	misc_deregister(&data->misc);
-
-	return 0;
 }
 
 static struct platform_driver cros_ec_chardev_driver = {
@@ -410,7 +408,7 @@ static struct platform_driver cros_ec_chardev_driver = {
 		.name = DRV_NAME,
 	},
 	.probe = cros_ec_chardev_probe,
-	.remove = cros_ec_chardev_remove,
+	.remove_new = cros_ec_chardev_remove,
 };
 
 module_platform_driver(cros_ec_chardev_driver);
-- 
2.40.1


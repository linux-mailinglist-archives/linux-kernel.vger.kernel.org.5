Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC91B7AFDC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjI0ILP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjI0IK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:10:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88361B7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:10:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdA-0007xR-6v; Wed, 27 Sep 2023 10:10:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd9-009I7L-NV; Wed, 27 Sep 2023 10:10:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd9-005BQc-EN; Wed, 27 Sep 2023 10:10:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 09/27] platform/chrome: cros_usbpd_notify: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 10:10:22 +0200
Message-Id: <20230927081040.2198742-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2938; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hSEWunQsqDf9o0Gu7AfSQmYYAjV96zrpal7gSYkj2l4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlThx+mvgrMFV7z2kFm3lCWlqUUko8Tb9XNgf4xJXc53x 8o9hs86GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZgIXwoHww5lvfVq5s91rYw2 x50wyvB+cPb/0kUpLMvKcktr906p1+eKS/v37OqaWPWtN49Py+T57ZnAXm2zMOPi9zjJA4IiprL n5709uyBX45XgdLMtTtN2zcs4HL/MxcuxS+rShh0X/907rP/nY/f1YFa+Xu/fM7nqjAWrjUVs9n gWKD81/s80W+705U7RnY0ParolE8v/frYvrjnOvGCapJbmgU3Mp5rWp07ac3OeW4m7+/rsbYs2R 0i/OhGdpv+gz2NFV2af4mYTHXb+yBKbqdsL1c8HyGmo6Xas81hluPRByUouaW3zhe0O+zy3PeVv dv68KE9w1c8VaXeDJ8Snayxu6+05bmC1SlBGYI4Iz5qJAA==
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
 drivers/platform/chrome/cros_usbpd_notify.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index 10670b6588e3..aacad022f21d 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -134,15 +134,13 @@ static int cros_usbpd_notify_probe_acpi(struct platform_device *pdev)
 	return 0;
 }
 
-static int cros_usbpd_notify_remove_acpi(struct platform_device *pdev)
+static void cros_usbpd_notify_remove_acpi(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 
 	acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
 				   cros_usbpd_notify_acpi);
-
-	return 0;
 }
 
 static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
@@ -157,7 +155,7 @@ static struct platform_driver cros_usbpd_notify_acpi_driver = {
 		.acpi_match_table = cros_usbpd_notify_acpi_device_ids,
 	},
 	.probe = cros_usbpd_notify_probe_acpi,
-	.remove = cros_usbpd_notify_remove_acpi,
+	.remove_new = cros_usbpd_notify_remove_acpi,
 };
 
 #endif /* CONFIG_ACPI */
@@ -209,7 +207,7 @@ static int cros_usbpd_notify_probe_plat(struct platform_device *pdev)
 	return 0;
 }
 
-static int cros_usbpd_notify_remove_plat(struct platform_device *pdev)
+static void cros_usbpd_notify_remove_plat(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
@@ -218,8 +216,6 @@ static int cros_usbpd_notify_remove_plat(struct platform_device *pdev)
 
 	blocking_notifier_chain_unregister(&ecdev->ec_dev->event_notifier,
 					   &pdnotify->nb);
-
-	return 0;
 }
 
 static struct platform_driver cros_usbpd_notify_plat_driver = {
@@ -227,7 +223,7 @@ static struct platform_driver cros_usbpd_notify_plat_driver = {
 		.name = DRV_NAME,
 	},
 	.probe = cros_usbpd_notify_probe_plat,
-	.remove = cros_usbpd_notify_remove_plat,
+	.remove_new = cros_usbpd_notify_remove_plat,
 };
 
 static int __init cros_usbpd_notify_init(void)
-- 
2.40.1


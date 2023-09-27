Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6437AFDE2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjI0IMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjI0ILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:11:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7745199
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:10:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdD-00088l-69; Wed, 27 Sep 2023 10:10:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdC-009I8B-Hp; Wed, 27 Sep 2023 10:10:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdC-005BRS-8f; Wed, 27 Sep 2023 10:10:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 22/27] platform/x86: sel3350-platform: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 10:10:35 +0200
Message-Id: <20230927081040.2198742-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1935; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=kGFT7lS86ctdmmkMpaZWg5zGeyf+eOIqmv/jUI2LUYo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlE+N2rxvqD+lA8wv6scmPkLhb0cJvvDgUq/DRH HywXQsx0qGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRPjdgAKCRCPgPtYfRL+ ThxjCAC277WBTJ7ekvWUxkUJM+++B0FDDI0JW1ZCzWsDhRKXQ++9l2dq64Eqsc5CKqxZtsejGEr obgo10zU1xjeUNB9knrcx/+e5Qi8W9Uls0bwXxwIzFIc545sTE3rWjTO3pOQqDgRz4cOSFBH1Ea tCcY7JrSH3nh13VWr863FYmD8VTP88FfOzNZ72N7WDQI+WWL8F6PXHjAysggzy9E7fJUc8oEkMs l97t4x6qIrJ/pT1q1tZC0cPml5bAcuw3cu+NhkzcAtYWySHR3QvUtxaA3NSDHnYHBZihAfyVbG8 77HEsW+4M7RNYvoRBFIs2uDQg5HUFZqkNoDy4HXMFBRflF+/
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
 drivers/platform/x86/sel3350-platform.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/sel3350-platform.c b/drivers/platform/x86/sel3350-platform.c
index fa267d0d3778..d09e976e7148 100644
--- a/drivers/platform/x86/sel3350-platform.c
+++ b/drivers/platform/x86/sel3350-platform.c
@@ -218,15 +218,13 @@ static int sel3350_probe(struct platform_device *pdev)
 	return rs;
 }
 
-static int sel3350_remove(struct platform_device *pdev)
+static void sel3350_remove(struct platform_device *pdev)
 {
 	struct sel3350_data *sel3350 = platform_get_drvdata(pdev);
 
 	platform_device_unregister(sel3350->leds_pdev);
 	gpiod_remove_lookup_table(&sel3350_gpios_table);
 	gpiod_remove_lookup_table(&sel3350_leds_table);
-
-	return 0;
 }
 
 static const struct acpi_device_id sel3350_device_ids[] = {
@@ -237,7 +235,7 @@ MODULE_DEVICE_TABLE(acpi, sel3350_device_ids);
 
 static struct platform_driver sel3350_platform_driver = {
 	.probe = sel3350_probe,
-	.remove = sel3350_remove,
+	.remove_new = sel3350_remove,
 	.driver = {
 		.name = "sel3350-platform",
 		.acpi_match_table = sel3350_device_ids,
-- 
2.40.1


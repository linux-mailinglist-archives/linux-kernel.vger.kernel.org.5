Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08467AD521
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjIYJ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjIYJ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:56:38 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C043CDA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJc-0008BC-Vh; Mon, 25 Sep 2023 11:55:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJc-008q1A-I2; Mon, 25 Sep 2023 11:55:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJc-004dmw-8x; Mon, 25 Sep 2023 11:55:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Rob Herring <robh@kernel.org>, Ruan Jinjie <ruanjinjie@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 40/40] soc/xilinx: zynqmp_power: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:31 +0200
Message-Id: <20230925095532.1984344-41-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1887; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=gIpZ9diDZeuFvzB/S1auBzLsV7kwS6CbiHArr/4Amqs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhsmBIFeF96e2ej5WPmcUERrhYQkPD1S8gZD 6zHN1isOjOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYbAAKCRCPgPtYfRL+ TnImCACr+IZ5Ex28v9coHdnTaCVbz+D3NZEWm/YoHQ01dIkmhaUZcckq+JW1+w/fYuSaj87sE6o 4wkYX9zAKfqjWkZd1Ho6ObugY+5YFaWgn8qQ8Q6E5TDBBTM0cX6T5fTabMn8qiN1/9GgUahMJ0F xgyTLuuW2iTZfy1INrCYaMRs24qz+v5XnjuOk4Amwh5uvHb42mC8sx92Z1x5EgE+rtGM4NnKAzj IPAZBNlkNk1ikPUhz0NIdTAvWa4QzxVKm3+DAiy0fwKE+EVDjWeXu+rlR5OhBamynhnguxIroxf bmL4YRnPEGFnLEYS/o1zEZC6kvM4gXZJkvfU3DBjEXG0rgWX
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
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/soc/xilinx/zynqmp_power.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index c2c819701eec..9d27f850f491 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -275,7 +275,7 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int zynqmp_pm_remove(struct platform_device *pdev)
+static void zynqmp_pm_remove(struct platform_device *pdev)
 {
 	sysfs_remove_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
 	if (event_registered)
@@ -283,8 +283,6 @@ static int zynqmp_pm_remove(struct platform_device *pdev)
 
 	if (!rx_chan)
 		mbox_free_channel(rx_chan);
-
-	return 0;
 }
 
 static const struct of_device_id pm_of_match[] = {
@@ -295,7 +293,7 @@ MODULE_DEVICE_TABLE(of, pm_of_match);
 
 static struct platform_driver zynqmp_pm_platform_driver = {
 	.probe = zynqmp_pm_probe,
-	.remove = zynqmp_pm_remove,
+	.remove_new = zynqmp_pm_remove,
 	.driver = {
 		.name = "zynqmp_power",
 		.of_match_table = pm_of_match,
-- 
2.40.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38797E72D8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345331AbjKIUaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345231AbjKIU3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:29:49 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334AE49F8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:29:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeH-00030C-0D; Thu, 09 Nov 2023 21:29:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeE-007rWs-6t; Thu, 09 Nov 2023 21:29:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeD-00GGtn-TH; Thu, 09 Nov 2023 21:29:05 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Rob Herring <robh@kernel.org>, Yangtao Li <frank.li@vivo.com>,
        Yuan Can <yuancan@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 07/12] bus: sunxi-rsb: Convert to platform remove callback returning void
Date:   Thu,  9 Nov 2023 21:28:37 +0100
Message-ID: <20231109202830.4124591-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Ljw1iocUr54lmlYHGt3emJtH6h+URgB1aeVfWaWuuQk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTUD23dZO5dhS0cwcbsOoJZ0FDGjDEMqO4zgGJ m3BUYf5IC+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU1A9gAKCRCPgPtYfRL+ TrHXB/0TOFve/dtvkisgJw9zkcCVDFLSsx+YLtqy1MqcS2oO79o1lTsMGekYQM6+DaRVZ7vqf+T ZBLt41FuXVbcWj5mLK+FrhBlEd73VtGrRCiUBXagwvLu3a1hNKzj394MjGLv+TMjtpN1RZmojdH 64CASdg19YDpS6KBNvJuKR1uvW/YD2Pg2Tz3/OL60r7Xdo0b5BjhjK3tnKRI81mtoSNMfymcOdB uGDz5C7eJbnlGen/U8W0Dgtp+jVmrz8mYo1hzYmclKIOFD8Ypdx3zaWErhBPPGMprnD9kW98UqB iv07DwwQaCkKLOx89X1FvLjKOyNoEkwbxaiX7waYUstQIa3s
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
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
 drivers/bus/sunxi-rsb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index db0ed4e5d315..fd3e9d82340a 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -817,15 +817,13 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sunxi_rsb_remove(struct platform_device *pdev)
+static void sunxi_rsb_remove(struct platform_device *pdev)
 {
 	struct sunxi_rsb *rsb = platform_get_drvdata(pdev);
 
 	device_for_each_child(rsb->dev, NULL, sunxi_rsb_remove_devices);
 	pm_runtime_disable(&pdev->dev);
 	sunxi_rsb_hw_exit(rsb);
-
-	return 0;
 }
 
 static const struct dev_pm_ops sunxi_rsb_dev_pm_ops = {
@@ -842,7 +840,7 @@ MODULE_DEVICE_TABLE(of, sunxi_rsb_of_match_table);
 
 static struct platform_driver sunxi_rsb_driver = {
 	.probe = sunxi_rsb_probe,
-	.remove	= sunxi_rsb_remove,
+	.remove_new = sunxi_rsb_remove,
 	.driver	= {
 		.name = RSB_CTRL_NAME,
 		.of_match_table = sunxi_rsb_of_match_table,
-- 
2.42.0


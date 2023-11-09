Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5BB7E72D5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345313AbjKIU3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345195AbjKIU3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:29:31 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935BE4787
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:29:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeE-0002zu-E0; Thu, 09 Nov 2023 21:29:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeD-007rWk-LU; Thu, 09 Nov 2023 21:29:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeD-00GGtf-C6; Thu, 09 Nov 2023 21:29:05 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liu Ying <victor.liu@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 05/12] bus: simple-pm-bus: Convert to platform remove callback returning void
Date:   Thu,  9 Nov 2023 21:28:35 +0100
Message-ID: <20231109202830.4124591-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Ox2UR96mQUBphpPQCu2afHS3QOH3355cCf293Z7ZMuU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTUD0TmHACrZZ3AsH1FRI415x4vDLXTNjGwR+W w452ENjBoCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU1A9AAKCRCPgPtYfRL+ TrRtB/sGslx73P03TonkbUftTqrJqMOyxQ4WC5pr+hCbarcjoCMF5U2yhaWGSQ1Ro0wgBDiveYk 0eI6j6BC9b4c+kIOs7vBwqPH2W2ms2L3A7kP6nZUAgxCJykdiCusTROwBKsVcIGIXCmUC9fjLRO dLr2vSJaM+I7TXkxaW7U2B7UxV0Cg+z5PrUXuQbkZXxC2RK5CDNYrxSO0z3i/D1nEV+qxAjzQiz oemf3SUqAMXVNqRpWG0k7NhhZVQZ28EO4HZskEZ9cim12E8/UYIbcEuszQ8X4rAUWNH8lkc1FWq DjTR6eFHVMmHFFsMxzSy6WRbZICUa8R8L710UnTCc7VGqs35
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
 drivers/bus/simple-pm-bus.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index aafcc481de91..50870c827889 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -74,17 +74,16 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int simple_pm_bus_remove(struct platform_device *pdev)
+static void simple_pm_bus_remove(struct platform_device *pdev)
 {
 	const void *data = of_device_get_match_data(&pdev->dev);
 
 	if (pdev->driver_override || data)
-		return 0;
+		return;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
 
 static int simple_pm_bus_runtime_suspend(struct device *dev)
@@ -129,7 +128,7 @@ MODULE_DEVICE_TABLE(of, simple_pm_bus_of_match);
 
 static struct platform_driver simple_pm_bus_driver = {
 	.probe = simple_pm_bus_probe,
-	.remove = simple_pm_bus_remove,
+	.remove_new = simple_pm_bus_remove,
 	.driver = {
 		.name = "simple-pm-bus",
 		.of_match_table = simple_pm_bus_of_match,
-- 
2.42.0


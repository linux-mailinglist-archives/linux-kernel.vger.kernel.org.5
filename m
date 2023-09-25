Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EED17AD509
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjIYJ5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjIYJz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:55:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D3B109
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJb-0008AG-Vi; Mon, 25 Sep 2023 11:55:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJb-008q0t-Iy; Mon, 25 Sep 2023 11:55:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJb-004dmg-9u; Mon, 25 Sep 2023 11:55:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 36/40] soc/ti: pm33xx: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:27 +0200
Message-Id: <20230925095532.1984344-37-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1787; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=HJo3aWO18/wKa8knQmWwhu5R4zVuVXax0HAzXVwl9s0=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTBiIzcKIfQnIyHXcuv97WxRLPfu+ktFR3Z1jxXy2vN2 jAP7ZZORmMWBkYuBlkxRRb7xjWZVlVykZ1r/12GGcTKBDKFgYtTACayx5T9n1b5U2WuUv01oo2q vI2CgifuBlya5CTafvNIKJdTxPr1MU0K21TqmGU3TMtL0/F8KZYd+jNguSeXo8GFUo6lPjEndvN rTDp6alVf0pGbpUpXuQITPytyFB2YmpH40qKslCFeds/n6EuXVqu8VrA89KU7PsHpU+K1Gu/bfb qmV6KuMb+87MMxs0c4aGVsuwDvG/tJzPfWvny6ZP0HY+WZsh8ivz8MeKa8ZuIJLk0mmb13/ttMW K6wbObhdr+Wq56er4I6J1tVzV55pMrnme+cX82vZkyMXHL1frjX/G3OmS86JtmHdWb/Dsk42TUv 7WX+C2GWyyIaCycV3dZSsJKt+VpTVyK4x/LXA76TSou5AQ==
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
 drivers/soc/ti/pm33xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index f04c21157904..8e983c3c4e03 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -583,7 +583,7 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int am33xx_pm_remove(struct platform_device *pdev)
+static void am33xx_pm_remove(struct platform_device *pdev)
 {
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -594,7 +594,6 @@ static int am33xx_pm_remove(struct platform_device *pdev)
 	am33xx_pm_free_sram();
 	iounmap(rtc_base_virt);
 	clk_put(rtc_fck);
-	return 0;
 }
 
 static struct platform_driver am33xx_pm_driver = {
@@ -602,7 +601,7 @@ static struct platform_driver am33xx_pm_driver = {
 		.name   = "pm33xx",
 	},
 	.probe = am33xx_pm_probe,
-	.remove = am33xx_pm_remove,
+	.remove_new = am33xx_pm_remove,
 };
 module_platform_driver(am33xx_pm_driver);
 
-- 
2.40.1


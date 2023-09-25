Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892D47AD4FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjIYJ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjIYJzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:55:53 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEFAE3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJa-00083B-ND; Mon, 25 Sep 2023 11:55:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJa-008q0T-64; Mon, 25 Sep 2023 11:55:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJZ-004dmI-TM; Mon, 25 Sep 2023 11:55:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 30/40] soc/rockchip: io-domain: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:21 +0200
Message-Id: <20230925095532.1984344-31-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dSb9QNeIckA738H8tOK4mdlXe6+NMGUKtANgI6GyJvY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhhLmCL9V7I1ameNsoabvEahY8rsNxRFzmCZ MhyoiSvkuaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYYQAKCRCPgPtYfRL+ TqsQB/9O+lvyEqVpjhB5clMRQGvlRE2E4pIuH64H6vN9WvwD5VS8yymgO0poaWwThVyUFi+99fT U093S8k4KltHmhp1f3W6QsxW5PRVITqv1aAfgbppx3udLWVOGS0Kxddhx6IQC6B1BH0ObMYLeS+ IyUyRbRc6+6yg6g47KD97bvsnYI0v7WSsNoYgqIFq6/q1qqc9cQcXpX+52TtX14VBmjcAc+8Z09 +4iATbjiqKUDmFD46IaH6VEfdqTT3kCBNefhCFKrhSxJR1Fphp7M0lRSrxo0+rE2e65cnk/OJXo MahpxRkHCxfat45eiM6+ExAZ7EOdKL3c+6aMRulj8Mk7KaL/
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
 drivers/soc/rockchip/io-domain.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
index 6619256c2d11..18f809c160a7 100644
--- a/drivers/soc/rockchip/io-domain.c
+++ b/drivers/soc/rockchip/io-domain.c
@@ -687,7 +687,7 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rockchip_iodomain_remove(struct platform_device *pdev)
+static void rockchip_iodomain_remove(struct platform_device *pdev)
 {
 	struct rockchip_iodomain *iod = platform_get_drvdata(pdev);
 	int i;
@@ -699,13 +699,11 @@ static int rockchip_iodomain_remove(struct platform_device *pdev)
 			regulator_unregister_notifier(io_supply->reg,
 						      &io_supply->nb);
 	}
-
-	return 0;
 }
 
 static struct platform_driver rockchip_iodomain_driver = {
 	.probe   = rockchip_iodomain_probe,
-	.remove  = rockchip_iodomain_remove,
+	.remove_new = rockchip_iodomain_remove,
 	.driver  = {
 		.name  = "rockchip-iodomain",
 		.of_match_table = rockchip_iodomain_match,
-- 
2.40.1


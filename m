Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A247BD6AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345790AbjJIJWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345707AbjJIJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:22:41 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB565CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:22:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTE-0006tV-Cz; Mon, 09 Oct 2023 11:22:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTE-000NWs-0L; Mon, 09 Oct 2023 11:22:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTD-00C4pL-NR; Mon, 09 Oct 2023 11:22:35 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        linux-arm-kernel@axis.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/20] pinctrl: artpec6: Convert to platform remove callback returning void
Date:   Mon,  9 Oct 2023 10:38:45 +0200
Message-Id: <20231009083856.222030-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=REwHugWByH9MZiAq/xaUHUffBTFsuoloAV+rOifD5WE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlI7wJ0B8jigP3Dxi7n9R6rd5K2RcM9kcrzEbQ3 oJLJrwV1AyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSO8CQAKCRCPgPtYfRL+ TjIfB/41KqJBdmph4C1MLpdcUe6c+RY3hCISKnr2/I2/lax9Tbb+w4xBwLLzqqNgdxopKbkGJEe 1uO2DLLNtbS6jFO+p9j0dJR47AR3ZYlIx0IlDrTsFBHFqSeCJZKn2VwyeNGwc+myk8VQniU0cJ3 ++SAUQqPTYzSOuO1LZXT1RPQexyt6bcMa/8p0T4/aOdQKGSta0+GEBcK1KyjJ6ktgKM/Av+DwUH E47opsIFgA7KXx9HkDDsxo+cj6pKu9KIcf8ubfLG4c61M6mB9OCvsea8NYQcOyzdN39TNndY0BA t/zFFA+FkJKmtFyo+p1HrKlBvSqRs85XfxEm9Tat9R7vsZP0
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
 drivers/pinctrl/pinctrl-artpec6.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-artpec6.c b/drivers/pinctrl/pinctrl-artpec6.c
index d6c9f9dcff97..dd93f124e0a0 100644
--- a/drivers/pinctrl/pinctrl-artpec6.c
+++ b/drivers/pinctrl/pinctrl-artpec6.c
@@ -970,13 +970,11 @@ static int artpec6_pmx_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int artpec6_pmx_remove(struct platform_device *pdev)
+static void artpec6_pmx_remove(struct platform_device *pdev)
 {
 	struct artpec6_pmx *pmx = platform_get_drvdata(pdev);
 
 	pinctrl_unregister(pmx->pctl);
-
-	return 0;
 }
 
 static const struct of_device_id artpec6_pinctrl_match[] = {
@@ -990,7 +988,7 @@ static struct platform_driver artpec6_pmx_driver = {
 		.of_match_table = artpec6_pinctrl_match,
 	},
 	.probe = artpec6_pmx_probe,
-	.remove = artpec6_pmx_remove,
+	.remove_new = artpec6_pmx_remove,
 };
 
 static int __init artpec6_pmx_init(void)
-- 
2.40.1


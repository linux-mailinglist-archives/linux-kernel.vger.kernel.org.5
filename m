Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B257BD6CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbjJIJXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345865AbjJIJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:22:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6015C10E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:22:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTF-0006uH-DO; Mon, 09 Oct 2023 11:22:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTF-000NX9-0B; Mon, 09 Oct 2023 11:22:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTE-00C4pb-NE; Mon, 09 Oct 2023 11:22:36 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/20] pinctrl: stmfx: Convert to platform remove callback returning void
Date:   Mon,  9 Oct 2023 10:38:49 +0200
Message-Id: <20231009083856.222030-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1870; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=PgpMnVQndSD56U26Qe9f+HDWSOr4u9++3LxM4ikfokI=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTlPXxTYpbahPY0vU5SKpNnd1LLWngypTvykl6VQwL3b 92rOS87GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZgI71T2/0mqOXml5U71y83+ 5QtO/ybMIN1Q/Kpu5roQhzqhieruz96ncFc1unAsXL7/9ZeuytoWT9YvaomGezbrXRT6GFx2SzK obD/Pu6MeE1gLZtddeOywgHm6cXzLnb7939X3c9SFmK8u+2y4dNI8rq9326eoLDs553hjocupl2 wOjZueGDy4rr01LSjIoFf1uYzRLcFplSeYInlNag5XeAULK37gnn7gtu+D8oBEo/sq3YdXXP5f8 CG9M6bqq17Km+wl3j36FV5nDjT/LuuyMnfaxP7qtt8jkRdy59P23uadXGjZ0GAv/KCq+j77Amfz tv5OgYNz1+fss0pU19aLbv3yod8ibzbHf16OQDVTkb0A
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
 drivers/pinctrl/pinctrl-stmfx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
index d7ab82432a52..6313be370eb7 100644
--- a/drivers/pinctrl/pinctrl-stmfx.c
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -734,7 +734,7 @@ static int stmfx_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int stmfx_pinctrl_remove(struct platform_device *pdev)
+static void stmfx_pinctrl_remove(struct platform_device *pdev)
 {
 	struct stmfx *stmfx = dev_get_drvdata(pdev->dev.parent);
 	int ret;
@@ -746,8 +746,6 @@ static int stmfx_pinctrl_remove(struct platform_device *pdev)
 	if (ret)
 		dev_err(&pdev->dev, "Failed to disable pins (%pe)\n",
 			ERR_PTR(ret));
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -856,7 +854,7 @@ static struct platform_driver stmfx_pinctrl_driver = {
 		.pm = &stmfx_pinctrl_dev_pm_ops,
 	},
 	.probe = stmfx_pinctrl_probe,
-	.remove = stmfx_pinctrl_remove,
+	.remove_new = stmfx_pinctrl_remove,
 };
 module_platform_driver(stmfx_pinctrl_driver);
 
-- 
2.40.1


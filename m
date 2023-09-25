Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6A37AD503
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjIYJ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjIYJz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:55:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DEF101
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJa-000859-TZ; Mon, 25 Sep 2023 11:55:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJa-008q0X-FA; Mon, 25 Sep 2023 11:55:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJa-004dmM-5r; Mon, 25 Sep 2023 11:55:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 31/40] soc/samsung: exynos-chipid: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:22 +0200
Message-Id: <20230925095532.1984344-32-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1808; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=5kh+y4DOQVrSyZkhWv/uw6w4/RUDtFUk39hMgcVFiI0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhiyd9rJ769lDBMAmedB3kviAVUASyQCp9/t LhMqggF/tuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYYgAKCRCPgPtYfRL+ Tg/8B/94KeKdeLgFZohjWhwnbra0fvi3MpKMsMjNUhpcd5kPIi1qsJy67sN20WFAReEnLBGMqMZ aqAl6ldk1b53Q2M3ATlr6o+JVUSh7zypA2EjalEXxZCHtfZ1FWpEPlQexHVRVwtmsQ26hHvrcRI DtGCjq9+3xNJyX8NJdou4dGOGtFmWg219SQ354karaHcN6fL96DwdljDjZtkQKnc0ZHa+C50ZAd SguGjS2vTnqeGDvd0vmPAFZ+PxNxvPtmU+T5eEmjpAOLiB4ch2ZBLCfK3z6kYiF8RQCK9hikHu0 DYJ3QM1mfBiYubDx2Lxkej4YtYn8R56ctFvTfBsTeyfJWTFm
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
 drivers/soc/samsung/exynos-chipid.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 7ba45c4aff97..3fd0f2b84dd3 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -158,13 +158,11 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int exynos_chipid_remove(struct platform_device *pdev)
+static void exynos_chipid_remove(struct platform_device *pdev)
 {
 	struct soc_device *soc_dev = platform_get_drvdata(pdev);
 
 	soc_device_unregister(soc_dev);
-
-	return 0;
 }
 
 static const struct exynos_chipid_variant exynos4210_chipid_drv_data = {
@@ -197,7 +195,7 @@ static struct platform_driver exynos_chipid_driver = {
 		.of_match_table = exynos_chipid_of_device_ids,
 	},
 	.probe	= exynos_chipid_probe,
-	.remove	= exynos_chipid_remove,
+	.remove_new = exynos_chipid_remove,
 };
 module_platform_driver(exynos_chipid_driver);
 
-- 
2.40.1


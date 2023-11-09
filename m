Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67787E72D7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345264AbjKIU3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345226AbjKIU3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:29:32 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7803444BC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:29:20 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeD-0002zp-S5; Thu, 09 Nov 2023 21:29:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeD-007rWg-FB; Thu, 09 Nov 2023 21:29:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeD-00GGtb-61; Thu, 09 Nov 2023 21:29:05 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 04/12] bus: qcom-ssc-block-bus: Convert to platform remove callback returning void
Date:   Thu,  9 Nov 2023 21:28:34 +0100
Message-ID: <20231109202830.4124591-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2068; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wAGXyo4THEZ3YXfAy6+ytes/4cv/Fu7eWX0o6nDhAIA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTUDzTrNcskF9F/f7KcEHQ1rf0f1wYIKKo0UFW olFqxNoc1mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU1A8wAKCRCPgPtYfRL+ TgRsB/9KhxhY9k0o2+A6JUS7K5v6XNCj4Wzgont+kCkzwMz/YYOJdMy9/JnUbv14K6dc1O3Aww0 tt9LfxAfT3CFQc8WtA5pFIP365Ar9BwyOXvVONlNbJ4NzeuvU6xuKnMco+Q7Wa0cjGpmub+SeA8 2bp2L6R3EGe9KT/Fp9+CxNswZHItWHgw4EwSsEK5yneju39Hgdxiw6E3cdlUc30lR0+FRY07Q0u j0ua1Tpnwn4a+qwxCsziQscqxoXF9PQ770v79b+T2WARxVaZC0eVEC5gwe7mSne70eAIdw+AKnP duc01QYWIctEMduPOoAIKfLVrFc6MMbPFlY0pw328//49g3k
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
 drivers/bus/qcom-ssc-block-bus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/qcom-ssc-block-bus.c b/drivers/bus/qcom-ssc-block-bus.c
index 3fef18a43c01..5931974a21fa 100644
--- a/drivers/bus/qcom-ssc-block-bus.c
+++ b/drivers/bus/qcom-ssc-block-bus.c
@@ -350,7 +350,7 @@ static int qcom_ssc_block_bus_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int qcom_ssc_block_bus_remove(struct platform_device *pdev)
+static void qcom_ssc_block_bus_remove(struct platform_device *pdev)
 {
 	struct qcom_ssc_block_bus_data *data = platform_get_drvdata(pdev);
 
@@ -363,8 +363,6 @@ static int qcom_ssc_block_bus_remove(struct platform_device *pdev)
 	qcom_ssc_block_bus_pds_detach(&pdev->dev, data->pds, data->num_pds);
 	pm_runtime_disable(&pdev->dev);
 	pm_clk_destroy(&pdev->dev);
-
-	return 0;
 }
 
 static const struct of_device_id qcom_ssc_block_bus_of_match[] = {
@@ -375,7 +373,7 @@ MODULE_DEVICE_TABLE(of, qcom_ssc_block_bus_of_match);
 
 static struct platform_driver qcom_ssc_block_bus_driver = {
 	.probe = qcom_ssc_block_bus_probe,
-	.remove = qcom_ssc_block_bus_remove,
+	.remove_new = qcom_ssc_block_bus_remove,
 	.driver = {
 		.name = "qcom-ssc-block-bus",
 		.of_match_table = qcom_ssc_block_bus_of_match,
-- 
2.42.0


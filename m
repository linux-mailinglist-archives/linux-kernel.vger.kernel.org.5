Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA77AD51B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjIYJ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjIYJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:56:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6995E19A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJZ-0007z4-7v; Mon, 25 Sep 2023 11:55:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJY-008pzv-E0; Mon, 25 Sep 2023 11:55:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJY-004dll-4k; Mon, 25 Sep 2023 11:55:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 22/40] soc/qcom: qcom_aoss: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:13 +0200
Message-Id: <20230925095532.1984344-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=T1sLDxR+kGoYzoTaFBI1Nuu59dqPzKlYkoYyT+dImvY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhYTppoFE9VnRzAm5U5zwf2Aj1+tSfVwhRr6 Gcqaa6lDnyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYWAAKCRCPgPtYfRL+ TpZKB/kBrH/g4dHqPBiq925EB/ut0fjDxv7hZauNhlFCuocP/3CcU8c61yphN0kbBfZSDDMiItC c6k6JePZql1xJ8uSvP46r36Kgck+IrGBxxklBzHGQmgJKHH/LlNgGhV91cUmKTthvgs2ZjQeCPS y68Cp3vijmBbm63mpnF4sEhxKUKoiSXbpeONvigO8n6Ktm7VD2yr5mpx6xNiOqak9t8n9+9G8QE ZW3xzp+A+cKNoq+5yzV5Cd0A/D4bwrlVX2a/K8d3VeAxB2K76UZDDPYFx7SqA2v1OOXa4298N+Q uj+b+XvLysqm0Nvj1FtnuUnl+ctXS2e84qQSmgw+yfV3VnoP
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
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/soc/qcom/qcom_aoss.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index 77f0cf126629..e6f16b0f6160 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -533,7 +533,7 @@ static int qmp_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qmp_remove(struct platform_device *pdev)
+static void qmp_remove(struct platform_device *pdev)
 {
 	struct qmp *qmp = platform_get_drvdata(pdev);
 
@@ -542,8 +542,6 @@ static int qmp_remove(struct platform_device *pdev)
 
 	qmp_close(qmp);
 	mbox_free_channel(qmp->mbox_chan);
-
-	return 0;
 }
 
 static const struct of_device_id qmp_dt_match[] = {
@@ -565,7 +563,7 @@ static struct platform_driver qmp_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = qmp_probe,
-	.remove	= qmp_remove,
+	.remove_new = qmp_remove,
 };
 module_platform_driver(qmp_driver);
 
-- 
2.40.1


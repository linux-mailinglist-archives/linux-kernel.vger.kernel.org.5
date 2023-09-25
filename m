Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACB97AD51F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjIYJ55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjIYJ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:56:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A451B1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJZ-0007yW-2A; Mon, 25 Sep 2023 11:55:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJY-008pzr-6x; Mon, 25 Sep 2023 11:55:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJX-004dlh-U4; Mon, 25 Sep 2023 11:55:39 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 21/40] soc/qcom: pmic_glink: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:12 +0200
Message-Id: <20230925095532.1984344-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1935; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=feNw6Iehxq5cpeZvKpkOslVobhCC8GM5VKPDgbn0M7s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhX2d7dAZtHLNX+a36/PvcJy1Ir7k07q9my/ snPq4zbWemJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYVwAKCRCPgPtYfRL+ TmbDB/99bFLJnBjgwDQHuW+8AkUCkuoAMGJhVgGjexCH5XFHmLS1jqaDlr0hdLKPLjlete/WmCU qU64I3t6c1lFWolBWHiE/jgasdui9vZxTbuq7JZVhVNjLh1FsdK+BqdvzjcuRE7+g7ZIrdijP9A QmPv6gjcUu3KqldNCYw462pAKPeKKZTcvkt1879piZLevRFMHf/Orv0qe8wprqziTrS7M0diFIg TnjOwN5rjE3OsgiGGQV7lLgd+HWA+Pb8K+AFrDtvxYkGBrtIv9C2dn2nIM/DdxgGBnqaMPGZsoF 750mRZ5BmdnFO4Hva3Kpk1ieLIC4clQAC2O+pOyZABfe1NdI
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
 drivers/soc/qcom/pmic_glink.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 61c89ddfc75b..914057331afd 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -318,7 +318,7 @@ static int pmic_glink_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pmic_glink_remove(struct platform_device *pdev)
+static void pmic_glink_remove(struct platform_device *pdev)
 {
 	struct pmic_glink *pg = dev_get_drvdata(&pdev->dev);
 
@@ -334,8 +334,6 @@ static int pmic_glink_remove(struct platform_device *pdev)
 	mutex_lock(&__pmic_glink_lock);
 	__pmic_glink = NULL;
 	mutex_unlock(&__pmic_glink_lock);
-
-	return 0;
 }
 
 static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
@@ -352,7 +350,7 @@ MODULE_DEVICE_TABLE(of, pmic_glink_of_match);
 
 static struct platform_driver pmic_glink_driver = {
 	.probe = pmic_glink_probe,
-	.remove = pmic_glink_remove,
+	.remove_new = pmic_glink_remove,
 	.driver = {
 		.name = "qcom_pmic_glink",
 		.of_match_table = pmic_glink_of_match,
-- 
2.40.1


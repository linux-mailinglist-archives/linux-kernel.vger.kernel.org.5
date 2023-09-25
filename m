Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5287AD514
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjIYJ5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjIYJ4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:56:03 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E393711B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJZ-0007zo-9W; Mon, 25 Sep 2023 11:55:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJY-008pzy-Ju; Mon, 25 Sep 2023 11:55:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJY-004dlq-As; Mon, 25 Sep 2023 11:55:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 23/40] soc/qcom: qcom_gsbi: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:14 +0200
Message-Id: <20230925095532.1984344-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=eNF+bxPsU6MJI6SmqQsGkl5fEqZP0D5rW8QkBlB+fmk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhZndudiGaALleMrA8pDLQKs2c7vBoIWBzq7 kRDztsaYDmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYWQAKCRCPgPtYfRL+ ThgjCACrSH0U+OYk1g45k77ScIibVr/T6Xrn2/Q8lfZpo2K+EnhykNeVr/ZQkH/FWaQqCdjPZz2 TjunUQGyU6D7XTQn5XTxZ/6j5P+FQpXyWpDeKppK6Jo79rjZ6NSH02m8V2m1vgyA5rfFjbHIR0b m2xxTs313W8hqOq3MJWZLpjT72QmVp9J4nNrJOmmxDUWe2pjdCfJFNzk0CN0Xavc2xenZnXPyaz GY8woJKetAqWeqvQlcwsjzqEZMHXjwWXJdwsGs+crmMvp61rkd9YCrWdz6P69O45jN6YDpM7ZW7 6AV+6FdmZPLlKOll62bzEFwTfWyfAOCNexhl3KVXBiDefXkf
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
 drivers/soc/qcom/qcom_gsbi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/qcom_gsbi.c b/drivers/soc/qcom/qcom_gsbi.c
index df7907a83aa8..f04b9a324ea9 100644
--- a/drivers/soc/qcom/qcom_gsbi.c
+++ b/drivers/soc/qcom/qcom_gsbi.c
@@ -212,13 +212,11 @@ static int gsbi_probe(struct platform_device *pdev)
 	return of_platform_populate(node, NULL, NULL, &pdev->dev);
 }
 
-static int gsbi_remove(struct platform_device *pdev)
+static void gsbi_remove(struct platform_device *pdev)
 {
 	struct gsbi_info *gsbi = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(gsbi->hclk);
-
-	return 0;
 }
 
 static const struct of_device_id gsbi_dt_match[] = {
@@ -234,7 +232,7 @@ static struct platform_driver gsbi_driver = {
 		.of_match_table	= gsbi_dt_match,
 	},
 	.probe = gsbi_probe,
-	.remove	= gsbi_remove,
+	.remove_new = gsbi_remove,
 };
 
 module_platform_driver(gsbi_driver);
-- 
2.40.1


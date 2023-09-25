Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354367AD511
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjIYJ5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjIYJ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:56:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C78BA3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJZ-00080N-Gs; Mon, 25 Sep 2023 11:55:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJY-008q02-Qi; Mon, 25 Sep 2023 11:55:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJY-004dlu-HQ; Mon, 25 Sep 2023 11:55:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 24/40] soc/qcom: qcom_stats: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:15 +0200
Message-Id: <20230925095532.1984344-25-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=z9fDP19zx0VBMpDk4svcAIbNux/+DzH7lIgpOOieEuk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhabXvvmA8uj9gwxN5Bih6E2DKSb+yniXcUz kUbKHroAeKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYWgAKCRCPgPtYfRL+ TptoB/9TY2KCYDK+eIBZrVgrDX5tQLexjXbFoZvHdiMXF9/0t0S/4ZCayyj9cCGLp5djqtzdM7O zpR/1fU8wJiuqOcriuilvLdpsln5MfTGw4vZnIDxG9u7bG+tCS8rE40N6jEHOy1NmotiXa5z1Bo 91hIQpmafX59c7JwHG7CNMy3rmRqXDXLociJjgkNLFviyVdQMpn/W8hrwllyAhQthFSQK9x0R35 Md2nl39i4iLDI8kOaR+ADE5Tee1VTJ8QxLyZNZfXaQBqPVYC7IZ71b0ZobhUOT/v188BTrNAB8s M9aaNxV+ilJPJXkt+N23oCA0SZbuZyNUwItdR/yQOUKtVcHk
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
 drivers/soc/qcom/qcom_stats.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
index c207bb96c523..0216fc24f2ca 100644
--- a/drivers/soc/qcom/qcom_stats.c
+++ b/drivers/soc/qcom/qcom_stats.c
@@ -216,13 +216,11 @@ static int qcom_stats_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int qcom_stats_remove(struct platform_device *pdev)
+static void qcom_stats_remove(struct platform_device *pdev)
 {
 	struct dentry *root = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(root);
-
-	return 0;
 }
 
 static const struct stats_config rpm_data = {
@@ -272,7 +270,7 @@ MODULE_DEVICE_TABLE(of, qcom_stats_table);
 
 static struct platform_driver qcom_stats = {
 	.probe = qcom_stats_probe,
-	.remove = qcom_stats_remove,
+	.remove_new = qcom_stats_remove,
 	.driver = {
 		.name = "qcom_stats",
 		.of_match_table = qcom_stats_table,
-- 
2.40.1


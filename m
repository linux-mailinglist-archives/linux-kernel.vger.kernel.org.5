Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2E37AD51D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjIYJ57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjIYJ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:56:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5BB1AD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJZ-00080h-Po; Mon, 25 Sep 2023 11:55:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJZ-008q07-1r; Mon, 25 Sep 2023 11:55:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJY-004dly-Ok; Mon, 25 Sep 2023 11:55:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 25/40] soc/qcom: rmtfs_mem: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:16 +0200
Message-Id: <20230925095532.1984344-26-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1979; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=le7eqGOuTakdhmTooKCsfZuf14WGGjNqknr7alRV/ww=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTBiJg97v/iWBJ0CxjXRAsbe0nmfbMOe31/BfsLjpVbs 5LqLqZ2MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCRxRs4GBYL7X8pZNC1p2xu oMxuy71zeqL5RWPsOyyCJexuxF0NXfv181E+R1X12hJW3lumuZf+7Vv1WFGpOcmvNnD6zEcRuUv mh1z8fSumQUuvnNVEfC2z87PrSrfK9jgq3AvpLJOrdXI+9nh2Rnswb7ihSBGH6JZE/p9uZyYd03 Wtm71Va6LXVIejfzrFwu87LLPZ5SF8zTEmX00zI1PgzL9kjqo5K9OX7zuZq/I6Z8Hvu2s1J1c/r Fk9IU/S2I/paK97++N3R8QWHaxyij/71Xr+Y3G7jiezVewMlerCt0n5G/W4HbLNqnMwmfNS7+bm wLWuKf5bebw3z8g1uWWefuZRNYtjebE0z4NlabIaMx8BAA==
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
 drivers/soc/qcom/rmtfs_mem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index f83811f51175..ab084b633ef0 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -281,7 +281,7 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_rmtfs_mem_remove(struct platform_device *pdev)
+static void qcom_rmtfs_mem_remove(struct platform_device *pdev)
 {
 	struct qcom_rmtfs_mem *rmtfs_mem = dev_get_drvdata(&pdev->dev);
 	struct qcom_scm_vmperm perm;
@@ -296,8 +296,6 @@ static int qcom_rmtfs_mem_remove(struct platform_device *pdev)
 
 	cdev_device_del(&rmtfs_mem->cdev, &rmtfs_mem->dev);
 	put_device(&rmtfs_mem->dev);
-
-	return 0;
 }
 
 static const struct of_device_id qcom_rmtfs_mem_of_match[] = {
@@ -308,7 +306,7 @@ MODULE_DEVICE_TABLE(of, qcom_rmtfs_mem_of_match);
 
 static struct platform_driver qcom_rmtfs_mem_driver = {
 	.probe = qcom_rmtfs_mem_probe,
-	.remove = qcom_rmtfs_mem_remove,
+	.remove_new = qcom_rmtfs_mem_remove,
 	.driver  = {
 		.name  = "qcom_rmtfs_mem",
 		.of_match_table = qcom_rmtfs_mem_of_match,
-- 
2.40.1


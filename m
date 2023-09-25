Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6967AD50E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjIYJ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjIYJ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:56:20 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16207180
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJY-0007xz-UL; Mon, 25 Sep 2023 11:55:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJY-008pzn-1H; Mon, 25 Sep 2023 11:55:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJX-004dle-OF; Mon, 25 Sep 2023 11:55:39 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 20/40] soc/qcom: ocmem: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:11 +0200
Message-Id: <20230925095532.1984344-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1755; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=KObOGlqJibcEwTxRmEgjOwAj9untrpQ8ilKXu7wa5hM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhWk9EthmEyuGyAcgE9Wj5Kqe8FcaAa5iY0q 7LiNSe5O7KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYVgAKCRCPgPtYfRL+ TtK9CACvJQTcafJCCwkC+MZB3DTo+1XaoOUxcUrCpou8CfjDX8a7B1fIPX24SSzqudqSUekatTd sU2Oe7wwMuvnmdwE37nKoEsU/wOTkOthAsYZUWtgf3uLOvncnfL0tjQzHT5+l20znpyTYsgBtwL d41yJj/Nxdga3J9pvwAilw2vJ0CW40xffkUTV0FC/ACYEXRdqNcJQSvgJ709bmyKpuXidPQ++2N sy2QdZBlqWqT6f+uQG7M3Yn3f8sjCI3ALVnsjde8/d1sunxI95iG4xn1S3d1qKlPetCoFX0yK+/ F3BAstM58QT/6BFPyA2t/Hw1aRWrOeiSGOU9sJQBdnvI6JQN
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
 drivers/soc/qcom/ocmem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index 20f5461d46b9..5e9f2c1fd305 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -416,14 +416,12 @@ static int ocmem_dev_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ocmem_dev_remove(struct platform_device *pdev)
+static void ocmem_dev_remove(struct platform_device *pdev)
 {
 	struct ocmem *ocmem = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(ocmem->core_clk);
 	clk_disable_unprepare(ocmem->iface_clk);
-
-	return 0;
 }
 
 static const struct ocmem_config ocmem_8226_config = {
@@ -446,7 +444,7 @@ MODULE_DEVICE_TABLE(of, ocmem_of_match);
 
 static struct platform_driver ocmem_driver = {
 	.probe = ocmem_dev_probe,
-	.remove = ocmem_dev_remove,
+	.remove_new = ocmem_dev_remove,
 	.driver = {
 		.name = "ocmem",
 		.of_match_table = ocmem_of_match,
-- 
2.40.1


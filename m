Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C949B7AD516
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjIYJ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjIYJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:56:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16750193
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJY-0007xa-P4; Mon, 25 Sep 2023 11:55:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJX-008pzj-R4; Mon, 25 Sep 2023 11:55:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJX-004dla-I2; Mon, 25 Sep 2023 11:55:39 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 19/40] soc/qcom: llcc-qcom: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:10 +0200
Message-Id: <20230925095532.1984344-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=GR3kItzTF2lF2zXGuL6lkmNa7DVlgJ27EVeQzbqFRn0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhVilH0/uHBUcMXkElclHTtm9Sh2Mk6dGZzT 8Rh5UsxPqKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYVQAKCRCPgPtYfRL+ TrwgCACLBGz7Uj+cZ36TV3m2AxZ0+NF0u1+JbKpucDB4Yn0U6k+/+ZYgufPcvrIlCadHJJDlsb4 LpfHf2/aKVMz4iA5Ju/e6Qdrq328+QXao5d/ZSxo5gbZahpg+fwWAsdvGVM13gJGMrYyPFof2XR R79r2NT05AKYl/wyykxI7EM1F43CMA5LeC2sxLuxVMIbEd2q5erJpsUaY9IVc0O4n9nAUpFgLc7 o5QgHATSTCoPQ2q+KONMQz+ZzkUh1iQpio5DE/zoMXAEZsIvhUw5NNRXGpu1hvznbTypzDQd9PC Ow4K8o8BulKC51SANFguXad/1kze21ts4l9j7FHDing2AmeR
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
 drivers/soc/qcom/llcc-qcom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index feb21637ac20..2a71548d2dc9 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -1080,11 +1080,10 @@ static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index,
 	return ret;
 }
 
-static int qcom_llcc_remove(struct platform_device *pdev)
+static void qcom_llcc_remove(struct platform_device *pdev)
 {
 	/* Set the global pointer to a error code to avoid referencing it */
 	drv_data = ERR_PTR(-ENODEV);
-	return 0;
 }
 
 static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev, u8 index,
@@ -1257,7 +1256,7 @@ static struct platform_driver qcom_llcc_driver = {
 		.of_match_table = qcom_llcc_of_match,
 	},
 	.probe = qcom_llcc_probe,
-	.remove = qcom_llcc_remove,
+	.remove_new = qcom_llcc_remove,
 };
 module_platform_driver(qcom_llcc_driver);
 
-- 
2.40.1


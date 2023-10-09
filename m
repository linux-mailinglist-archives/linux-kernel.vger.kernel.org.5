Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5AB7BE653
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377633AbjJIQZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377198AbjJIQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:25:26 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797DEB6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:25:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpt4D-0004ib-VA; Mon, 09 Oct 2023 18:25:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpt4D-000SWU-He; Mon, 09 Oct 2023 18:25:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpt4D-00CPkR-8V; Mon, 09 Oct 2023 18:25:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] pinctrl: qcom/lpi: Convert to platform remove callback returning void
Date:   Mon,  9 Oct 2023 18:25:08 +0200
Message-Id: <20231009162510.335208-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009162510.335208-1-u.kleine-koenig@pengutronix.de>
References: <20231009162510.335208-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6473; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=prKK31k9DtBCqz8z5hXL6xYLOiMRRSHWjeaWKl66mrI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlJClhBBgTnPC3EU4HiVHNK8IWD2BGE1S6ECFRO dyX+BAdqSGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSQpYQAKCRCPgPtYfRL+ TtC3B/96GM3NAxSQ+RAKItfonmR5sAw0oD092JwXowyqXpTS0WJQCB8qHjuONyCoLO3xNOz3KcR PlAo4Anvos3Pv+Y3KODpQZ53oYizn8Az1uyR8JQJCWPYzTygJkCVm47aazE+SIUhd7+AKF1QLpX 7R/6poqDGi8T/FBahyk0LxKMEZm705lkYHk57r55EbqCURaGdFeN1AWjnw/JDPHr+gx3WtQHI5m Cd2RtlubK6uLPScSYUwqZc3ylIrZ/E1avxQoUYJ9oW/AG8CNSims5xY9A92S2qmbMq1Sku5eLiF 3LwplbP6ro/j3X/ZJmeLxitBl2nkbsNwVSP3cit9TY31TU0B
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

To convert all those qcom pinctrl drivers, make msm_pinctrl_remove()
return void (instead of zero) and use .remove_new in all drivers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c          | 4 +---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h          | 2 +-
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c   | 2 +-
 drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c   | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c   | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c   | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c   | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c   | 2 +-
 9 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index e5a418026ba3..abb6f1de230b 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -490,7 +490,7 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(lpi_pinctrl_probe);
 
-int lpi_pinctrl_remove(struct platform_device *pdev)
+void lpi_pinctrl_remove(struct platform_device *pdev)
 {
 	struct lpi_pinctrl *pctrl = platform_get_drvdata(pdev);
 	int i;
@@ -500,8 +500,6 @@ int lpi_pinctrl_remove(struct platform_device *pdev)
 
 	for (i = 0; i < pctrl->data->npins; i++)
 		pinctrl_generic_remove_group(pctrl->ctrl, i);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(lpi_pinctrl_remove);
 
diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
index 29047bb80bb8..387d83ee95b5 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
@@ -85,6 +85,6 @@ struct lpi_pinctrl_variant_data {
 };
 
 int lpi_pinctrl_probe(struct platform_device *pdev);
-int lpi_pinctrl_remove(struct platform_device *pdev);
+void lpi_pinctrl_remove(struct platform_device *pdev);
 
 #endif /*__PINCTRL_LPASS_LPI_H__*/
diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
index d615b6c55b89..99156217c6a5 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
@@ -158,7 +158,7 @@ static struct platform_driver lpi_pinctrl_driver = {
 		   .of_match_table = lpi_pinctrl_of_match,
 	},
 	.probe = lpi_pinctrl_probe,
-	.remove = lpi_pinctrl_remove,
+	.remove_new = lpi_pinctrl_remove,
 };
 
 module_platform_driver(lpi_pinctrl_driver);
diff --git a/drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c
index 4b9c0beac32e..b33483056f42 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c
@@ -199,7 +199,7 @@ static struct platform_driver lpi_pinctrl_driver = {
 		   .of_match_table = lpi_pinctrl_of_match,
 	},
 	.probe = lpi_pinctrl_probe,
-	.remove = lpi_pinctrl_remove,
+	.remove_new = lpi_pinctrl_remove,
 };
 
 module_platform_driver(lpi_pinctrl_driver);
diff --git a/drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c
index 2b09bf171a2c..e8a6f6f6af54 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c
@@ -167,7 +167,7 @@ static struct platform_driver lpi_pinctrl_driver = {
 		.of_match_table = lpi_pinctrl_of_match,
 	},
 	.probe = lpi_pinctrl_probe,
-	.remove = lpi_pinctrl_remove,
+	.remove_new = lpi_pinctrl_remove,
 };
 
 module_platform_driver(lpi_pinctrl_driver);
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
index ddbc6317f2a7..cb10ce8d5d28 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
@@ -155,7 +155,7 @@ static struct platform_driver lpi_pinctrl_driver = {
 		   .of_match_table = lpi_pinctrl_of_match,
 	},
 	.probe = lpi_pinctrl_probe,
-	.remove = lpi_pinctrl_remove,
+	.remove_new = lpi_pinctrl_remove,
 };
 
 module_platform_driver(lpi_pinctrl_driver);
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c
index f889c779bccd..297cc95ac3c0 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c
@@ -158,7 +158,7 @@ static struct platform_driver lpi_pinctrl_driver = {
 		   .of_match_table = lpi_pinctrl_of_match,
 	},
 	.probe = lpi_pinctrl_probe,
-	.remove = lpi_pinctrl_remove,
+	.remove_new = lpi_pinctrl_remove,
 };
 module_platform_driver(lpi_pinctrl_driver);
 
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c
index e22d03ce292e..2e7896791fc0 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c
@@ -232,7 +232,7 @@ static struct platform_driver lpi_pinctrl_driver = {
 		   .of_match_table = lpi_pinctrl_of_match,
 	},
 	.probe = lpi_pinctrl_probe,
-	.remove = lpi_pinctrl_remove,
+	.remove_new = lpi_pinctrl_remove,
 };
 
 module_platform_driver(lpi_pinctrl_driver);
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c
index db1a46fee9c6..64458c3fbe5e 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c
@@ -240,7 +240,7 @@ static struct platform_driver lpi_pinctrl_driver = {
 		   .of_match_table = lpi_pinctrl_of_match,
 	},
 	.probe = lpi_pinctrl_probe,
-	.remove = lpi_pinctrl_remove,
+	.remove_new = lpi_pinctrl_remove,
 };
 
 module_platform_driver(lpi_pinctrl_driver);
-- 
2.40.1


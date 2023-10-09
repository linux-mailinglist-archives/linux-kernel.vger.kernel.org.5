Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48AD7BD6CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345965AbjJIJXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345893AbjJIJW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:22:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241E3112
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:22:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTG-0006vI-I4; Mon, 09 Oct 2023 11:22:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTG-000NXS-4q; Mon, 09 Oct 2023 11:22:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTF-00C4pv-S1; Mon, 09 Oct 2023 11:22:37 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/20] pinctrl: qcom: ssbi-mpp: Convert to platform remove callback returning void
Date:   Mon,  9 Oct 2023 10:38:54 +0200
Message-Id: <20231009083856.222030-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SsYV2sgsr7TRLETWckrWLWBbUnJpb3Z9p/eiCeOFjYo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlI7wT3rSpr1DOqqnrcxvuvs6vVTLJ+V1OTMu3R BiQ9k2k4wGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSO8EwAKCRCPgPtYfRL+ TufRB/9rDhQgknJt/0gZukbSFaLF3GDSd6FbDP4NDJm/W5NtDI6yBh8sVvW+ipkChaYtBTlYuMJ CyRf5hTQyXEJlTUEY2sAvNHTakFfdiD8e9m349Rqec+HJN6Pmt5PAQFrJkwq/ki/+Aodp6pr9wG /sjglQ4RUhcpcbsxaAZs5HR9FG6twy1HJ53gx5cIipuOvnNjow1WVxoUIBMLHDN3jBC52VjvL+h 0sVOeA5d8EDbHJ+AdWHFSzR5Y0iLTX6gGTPstwJvjaZ4SKxyrcH2hxGKb33DeeQYFECAe2c5F0f H4Cvqij42TB0aicPrqkL2C3Gg2inW3TtF2K/vaR10wZ31rEO
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
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
index 985d1a0ee8f8..3aee6835a2de 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
@@ -936,13 +936,11 @@ static int pm8xxx_mpp_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pm8xxx_mpp_remove(struct platform_device *pdev)
+static void pm8xxx_mpp_remove(struct platform_device *pdev)
 {
 	struct pm8xxx_mpp *pctrl = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&pctrl->chip);
-
-	return 0;
 }
 
 static struct platform_driver pm8xxx_mpp_driver = {
@@ -951,7 +949,7 @@ static struct platform_driver pm8xxx_mpp_driver = {
 		.of_match_table = pm8xxx_mpp_of_match,
 	},
 	.probe = pm8xxx_mpp_probe,
-	.remove = pm8xxx_mpp_remove,
+	.remove_new = pm8xxx_mpp_remove,
 };
 
 module_platform_driver(pm8xxx_mpp_driver);
-- 
2.40.1


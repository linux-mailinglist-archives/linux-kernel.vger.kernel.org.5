Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8214F7BD6CD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbjJIJXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345892AbjJIJW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:22:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635C0114
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:22:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTF-0006uV-Pq; Mon, 09 Oct 2023 11:22:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTF-000NXG-Cw; Mon, 09 Oct 2023 11:22:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTF-00C4pj-3q; Mon, 09 Oct 2023 11:22:37 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/20] pinctrl: qcom: spmi-gpio: Convert to platform remove callback returning void
Date:   Mon,  9 Oct 2023 10:38:51 +0200
Message-Id: <20231009083856.222030-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1785; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=iUS4SwEkb7r81ttsiZuCAWGZ8BPSgfZwboQcZSPLTn8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlI7wQMOny6ci1vflQLeBPNgnGEOvIztvOzj2IO go4zjz8LpGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSO8EAAKCRCPgPtYfRL+ TqlWB/4icqIp1ueWLdYJ0x2M3biO6YlUZ53y9wFVw/r0HWXI3KfVN2PuVBFCBgXpHxAcQ/8x746 yw1fM8SiMBH/xSuk4oJIqkenN3SNZo1LdJRh1D9DcAV550NqhNOY+cS2Psv5VeSxT9BYb/BqEKl EnLZSSIG2lqHuv7eZKZDewzkP0tsLOJBoIQqoEQIps7nrfgwokxfv6AH05yCxDY4P7e75IARECZ eaBLe8Ybr9RrvVOp69tdQ6SDnYACvUbgFYRQDsGYfJlgg8oWaEsY3PWNCSmJV1c0II1djf9W4F5 7ux4ZDhGCgaDR90Gg1HoHUKVrS5yyFDBWkm8x+Ami2TztYzH
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
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index deded9c6fd7d..f4e2c88a7c82 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1185,12 +1185,11 @@ static int pmic_gpio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pmic_gpio_remove(struct platform_device *pdev)
+static void pmic_gpio_remove(struct platform_device *pdev)
 {
 	struct pmic_gpio_state *state = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&state->chip);
-	return 0;
 }
 
 static const struct of_device_id pmic_gpio_of_match[] = {
@@ -1265,7 +1264,7 @@ static struct platform_driver pmic_gpio_driver = {
 		   .of_match_table = pmic_gpio_of_match,
 	},
 	.probe	= pmic_gpio_probe,
-	.remove = pmic_gpio_remove,
+	.remove_new = pmic_gpio_remove,
 };
 
 module_platform_driver(pmic_gpio_driver);
-- 
2.40.1


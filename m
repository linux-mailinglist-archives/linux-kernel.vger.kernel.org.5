Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4317BD6CB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345945AbjJIJXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345857AbjJIJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:22:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3240110
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:22:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTG-0006ut-2i; Mon, 09 Oct 2023 11:22:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTF-000NXK-Lv; Mon, 09 Oct 2023 11:22:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTF-00C4pn-Cm; Mon, 09 Oct 2023 11:22:37 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/20] pinctrl: qcom: spmi-mpp: Convert to platform remove callback returning void
Date:   Mon,  9 Oct 2023 10:38:52 +0200
Message-Id: <20231009083856.222030-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1767; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vzs3F7Uou+X3yMekBIMHBzYB6Le6JQJjl2rEX4wo4hk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlI7wRHdTZkFmrB0K1w+Co1UvRWrgd7FyRrKniw iSqkGIF5ZGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSO8EQAKCRCPgPtYfRL+ TllIB/9WEsCcLEKVnpUUTRCZBVoZtnBzyHbwYc5LVGsiTRl5TWNsYW0ZXAf4mRAud4cANi6doH9 GAn/d7W3siShHXxsPQFh3JUfURELWF0mUQCP2JiVT3sE7sGlIEa2+9zOiQHgLJPKesRaaHGd4lb zZWFIRJoTlumBk0/QmSrt2rEiW+CHaz8gDcZ2gP7r8jcwsYROmcVOoeQAL/p7fOPgbDvwDNpb4T n4sJJKNLX7Jvn3JFWrQUP+03db/VpQipjk2E8MVVARCY8rsqZnxMcKr3H/ji+0jN+L9smcQEJCm IIO+Pc0z55LK95bmF4l7EpLeBR/FTvvxaCKYNS4ubqApR0Qk
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
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index fe0393829c20..d16ece90d926 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -971,12 +971,11 @@ static int pmic_mpp_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pmic_mpp_remove(struct platform_device *pdev)
+static void pmic_mpp_remove(struct platform_device *pdev)
 {
 	struct pmic_mpp_state *state = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&state->chip);
-	return 0;
 }
 
 static const struct of_device_id pmic_mpp_of_match[] = {
@@ -1001,7 +1000,7 @@ static struct platform_driver pmic_mpp_driver = {
 		   .of_match_table = pmic_mpp_of_match,
 	},
 	.probe	= pmic_mpp_probe,
-	.remove = pmic_mpp_remove,
+	.remove_new = pmic_mpp_remove,
 };
 
 module_platform_driver(pmic_mpp_driver);
-- 
2.40.1


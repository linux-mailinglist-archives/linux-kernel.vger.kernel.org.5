Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2507BE657
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377651AbjJIQZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377640AbjJIQZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:25:36 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1462B6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:25:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpt4E-0004il-Ow; Mon, 09 Oct 2023 18:25:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpt4E-000SWa-1Z; Mon, 09 Oct 2023 18:25:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpt4D-00CPkZ-O7; Mon, 09 Oct 2023 18:25:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] pinctrl: sprd-sc9860: Convert to platform remove callback returning void
Date:   Mon,  9 Oct 2023 18:25:10 +0200
Message-Id: <20231009162510.335208-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009162510.335208-1-u.kleine-koenig@pengutronix.de>
References: <20231009162510.335208-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2793; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=IqXNKTNRDlIlftg1vOloagLt5DM4tFswzFBVR3pOJiw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlJClk3VxoLKOu/793wEyDtT0NwoO970SXjqBAO DIdylD9jy6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSQpZAAKCRCPgPtYfRL+ TmfcB/4qxK0CJoyVqR6PNCNFVPgmgE9fcqgx8/WK95DRuYgyU/tuqsXVILwI18XWxscXn+NLPY2 00aYxsdqCo6LPuj5GPNF2vdlzotM6k8jxNihOuyEvmFzm1ToubCqi8M67v+RtXk+8AY+mOge6cE TZAUgMlCpbjmZAby7unx6TrykTXePgDBsDspRPmzd0EkOrIp4n+9I/UEO6lpRWdht6/6guw4+EX Lck8m7RoovcG7HzgWp+Azslb37gDOAMxU7jNXAqJeBVO15BstVTdwSm4dzm9lXaO200lyu5c95y xLcZ3oftvqTaEBJxjsKly+XBxlYECLQ1a1JwFvUY+PkLzSYK
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

To convert the sprd-sc9860 driver, make sprd_pinctrl_remove()
return void (instead of zero) and use .remove_new as callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c | 2 +-
 drivers/pinctrl/sprd/pinctrl-sprd.c        | 3 +--
 drivers/pinctrl/sprd/pinctrl-sprd.h        | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c b/drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c
index d14f382f2392..9c3c39dc6550 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c
@@ -943,7 +943,7 @@ static struct platform_driver sprd_pinctrl_driver = {
 		.of_match_table = sprd_pinctrl_of_match,
 	},
 	.probe = sprd_pinctrl_probe,
-	.remove = sprd_pinctrl_remove,
+	.remove_new = sprd_pinctrl_remove,
 	.shutdown = sprd_pinctrl_shutdown,
 };
 module_platform_driver(sprd_pinctrl_driver);
diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index ccdcc91c7fa5..d0b6d3e655a2 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -1110,12 +1110,11 @@ int sprd_pinctrl_core_probe(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(sprd_pinctrl_core_probe);
 
-int sprd_pinctrl_remove(struct platform_device *pdev)
+void sprd_pinctrl_remove(struct platform_device *pdev)
 {
 	struct sprd_pinctrl *sprd_pctl = platform_get_drvdata(pdev);
 
 	pinctrl_unregister(sprd_pctl->pctl);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(sprd_pinctrl_remove);
 
diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.h b/drivers/pinctrl/sprd/pinctrl-sprd.h
index 69544a3cd635..190bcdb3bb6a 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.h
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.h
@@ -53,7 +53,7 @@ struct sprd_pins_info {
 int sprd_pinctrl_core_probe(struct platform_device *pdev,
 			    struct sprd_pins_info *sprd_soc_pin_info,
 			    int pins_cnt);
-int sprd_pinctrl_remove(struct platform_device *pdev);
+void sprd_pinctrl_remove(struct platform_device *pdev);
 void sprd_pinctrl_shutdown(struct platform_device *pdev);
 
 #endif /* __PINCTRL_SPRD_H__ */
-- 
2.40.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAE67BD6B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345812AbjJIJWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345778AbjJIJWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:22:43 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9968DE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:22:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTE-0006tB-3J; Mon, 09 Oct 2023 11:22:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTD-000NWm-MM; Mon, 09 Oct 2023 11:22:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTD-00C4pH-DG; Mon, 09 Oct 2023 11:22:35 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/20] pinctrl: amd: Convert to platform remove callback returning void
Date:   Mon,  9 Oct 2023 10:38:44 +0200
Message-Id: <20231009083856.222030-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=V7AnU5mBt80bO3f/bU7N6FqQ85j+a4pI1X5vE/2OSgI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlI7wI1+nZs515nJnjZmZdqHxhOhVNRVBbcm892 LSzhWR+GvSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSO8CAAKCRCPgPtYfRL+ Ttf7CACi6wQsY9DE8xhf2gF61QGcptRTb8H5D+pStx06n6zNcoRco2+PjJF/HNZLUjDok4IzKX2 8DI/1L7yRW3qkHLxoNRi1z0zce0ceVr+TuATh7388F8TrHbv4AbYmw0hOqsiUuXlzZmBxCqzDdG 9inVO+L0dGBOTU0+pv0WUCi7kD/SK7+wZX4NI/pKmkt4q+lc4R2geO6dB+OunvBfV863gD0uraX 5fPv/KpusCfa6MH+qqmzfF2W2T5wtMIbL1v1QiixCXkw2wOhaz0nsDgdSojQAlGlonoH6aQ0g98 yxLQF4/pjNT18Y9Y8O/2GwgEEUKDkJiM5lziHxMEUu/hf5NH
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/pinctrl/pinctrl-amd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 74241b2ff21e..fb58acb843d9 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -1166,7 +1166,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int amd_gpio_remove(struct platform_device *pdev)
+static void amd_gpio_remove(struct platform_device *pdev)
 {
 	struct amd_gpio *gpio_dev;
 
@@ -1174,8 +1174,6 @@ static int amd_gpio_remove(struct platform_device *pdev)
 
 	gpiochip_remove(&gpio_dev->gc);
 	acpi_unregister_wakeup_handler(amd_gpio_check_wake, gpio_dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_ACPI
@@ -1197,7 +1195,7 @@ static struct platform_driver amd_gpio_driver = {
 #endif
 	},
 	.probe		= amd_gpio_probe,
-	.remove		= amd_gpio_remove,
+	.remove_new	= amd_gpio_remove,
 };
 
 module_platform_driver(amd_gpio_driver);
-- 
2.40.1


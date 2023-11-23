Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816157F6480
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjKWQ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345140AbjKWQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:56:58 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0CDD46
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:57:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0c-0004z4-Mw; Thu, 23 Nov 2023 17:56:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0c-00B54W-6j; Thu, 23 Nov 2023 17:56:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0b-006oz6-Tm; Thu, 23 Nov 2023 17:56:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2 01/18] mfd: ab8500-sysctrl: Convert to platform remove callback returning void
Date:   Thu, 23 Nov 2023 17:56:29 +0100
Message-ID: <20231123165627.492259-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
References: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1805; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=GS/UqHACqLFCxsb5xvMGweNluQ8cR4neHNMyqaMRa+A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlX4Q8Pj9Sc/wSXZDMbwzL63aYnjZfexGCMhFLF N+Wdhi9HoyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZV+EPAAKCRCPgPtYfRL+ ThPdB/9f+Oj9hJK9NQybB41yGJvXzMIFj7Y8br+9cK9ocBHzrv4K7Kr0AzVw2ZFitdmQ+nYcs3O E/iMaKg0LCkOAUrTWi7lVUoKCVuW4uDJxBDnNxOFR08TaEuCCEZfO8Gx98J3nXsrQtOQp1gi6wo Pnm5a5F11ePtKNv/9U4brWz5qqC0wlOtvWvZx/PtT9/SbhgLPetfFw16RM1/mYuISR4/pTF6ILI FqHGj8caN09Knp0pMJdUbE9aQQcQpYQwCFjSOTQ+VyY1FSWZFTFVv1ULELcIXo3B1osTNG0V0+1 vp6DmhDpDqYv22iB9B7HlflLK8YdnfaYmZiONZr1qyV9m8d8
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/ab8500-sysctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index eeeb62415f53..ce81fcb785d0 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -140,14 +140,12 @@ static int ab8500_sysctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ab8500_sysctrl_remove(struct platform_device *pdev)
+static void ab8500_sysctrl_remove(struct platform_device *pdev)
 {
 	sysctrl_dev = NULL;
 
 	if (pm_power_off == ab8500_power_off)
 		pm_power_off = NULL;
-
-	return 0;
 }
 
 static const struct of_device_id ab8500_sysctrl_match[] = {
@@ -161,7 +159,7 @@ static struct platform_driver ab8500_sysctrl_driver = {
 		.of_match_table = ab8500_sysctrl_match,
 	},
 	.probe = ab8500_sysctrl_probe,
-	.remove = ab8500_sysctrl_remove,
+	.remove_new = ab8500_sysctrl_remove,
 };
 
 static int __init ab8500_sysctrl_init(void)
-- 
2.42.0


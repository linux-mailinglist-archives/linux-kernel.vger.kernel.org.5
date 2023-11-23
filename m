Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFA17F648D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345163AbjKWQ54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345253AbjKWQ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:57:05 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE9410C9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:57:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0g-00058f-7S; Thu, 23 Nov 2023 17:57:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0f-00B55Q-Qq; Thu, 23 Nov 2023 17:57:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0f-006p00-HW; Thu, 23 Nov 2023 17:57:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2 15/18] mfd: stm32-timers: Convert to platform remove callback returning void
Date:   Thu, 23 Nov 2023 17:56:43 +0100
Message-ID: <20231123165627.492259-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
References: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jVkK8Ke5hsybq+hJya3Qt2KaRP0LWkU08638E+yF+OA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlX4RMWnS+kDacKKlH4v2Liesd5r6OzwvKBRTf0 42Nudp3EaOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZV+ETAAKCRCPgPtYfRL+ Tg51B/4iQeyWsKcZqQxzJ9EpqzADAmrRSQK1J+YgDkC/ssJwOFwFHeKS9ufGTLQZjueDdMviNqX VhZdoCQGRNaPOJGESuecYhuxZuAMuRX8wH9ekGMyx5PJLMf8Eo0kjpy8BNPewRkuvpasgc3ZRiR cOXatNi6ahOcob8Sw52RwHZJpyzqqLLhWt5AKCh2amYBpEo5uWwt192cGOffMLfw7C+sJXQXFzE pey/6uHGKQPofLnGxcpA987g/L1rQeaZFlqP97/GpwMozfiDxicqhDQGWCWf1Rse8p5j3qe7x0v fnP2lJ0Drk67B4wBR3zTU3eQMwcXGlO43rUPuXsSIhW0pukC
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

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/stm32-timers.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
index a656a1c186a8..9fd13d88950c 100644
--- a/drivers/mfd/stm32-timers.c
+++ b/drivers/mfd/stm32-timers.c
@@ -306,7 +306,7 @@ static int stm32_timers_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stm32_timers_remove(struct platform_device *pdev)
+static void stm32_timers_remove(struct platform_device *pdev)
 {
 	struct stm32_timers *ddata = platform_get_drvdata(pdev);
 
@@ -316,8 +316,6 @@ static int stm32_timers_remove(struct platform_device *pdev)
 	 */
 	of_platform_depopulate(&pdev->dev);
 	stm32_timers_dma_remove(&pdev->dev, ddata);
-
-	return 0;
 }
 
 static const struct of_device_id stm32_timers_of_match[] = {
@@ -328,7 +326,7 @@ MODULE_DEVICE_TABLE(of, stm32_timers_of_match);
 
 static struct platform_driver stm32_timers_driver = {
 	.probe = stm32_timers_probe,
-	.remove = stm32_timers_remove,
+	.remove_new = stm32_timers_remove,
 	.driver	= {
 		.name = "stm32-timers",
 		.of_match_table = stm32_timers_of_match,
-- 
2.42.0


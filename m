Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0137F6479
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345225AbjKWQ5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjKWQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:56:56 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2509DD53
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:57:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0f-00057i-D2; Thu, 23 Nov 2023 17:57:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0f-00B55D-0Z; Thu, 23 Nov 2023 17:57:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0e-006ozo-Ns; Thu, 23 Nov 2023 17:57:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 12/18] mfd: pcf50633-adc: Convert to platform remove callback returning void
Date:   Thu, 23 Nov 2023 17:56:40 +0100
Message-ID: <20231123165627.492259-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
References: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1835; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=FtAnMobifYM32sw3SvUnyTDhNGwr52N00NU39uqq4PY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlX4RJMlhOsi8S7zcdLMJJGez9KN5J7DTm4Ovzc h33JyjXZYOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZV+ESQAKCRCPgPtYfRL+ TsSrCACGgOBx/tuJ6VjMhZrKaZ5Q4ORmRr+AKmZ/Jdi25XfzGMxN/QVvYjz4MZIcgK32AbMhuI+ lpzQq5URbuFHW6IUTN6TJj+/ttUcpwjyZt0nZ05mH8upuNsv0f61od4P2RErgPI22odTknb45NU AsK4vOceNV9AWvjJwkGeJFVmMo/DGJ4kHYOQVeliQmEZKdR8I5KlJbWHIfTdHiD9o6JFekGRDNa C4iM72L7ALHRA7LJSZwPf4BezOAqkNl0zR20e3n3ubAOAst4R25Q6gdq3E/MbxnKvh/F8gK/ZE2 5g7BkpUNuzlwXzz6rSI+ErdEhGIaQvol7QNcZNAQr8/hIs2u
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
 drivers/mfd/pcf50633-adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/pcf50633-adc.c b/drivers/mfd/pcf50633-adc.c
index 191b1bc6141c..ab55906f91f9 100644
--- a/drivers/mfd/pcf50633-adc.c
+++ b/drivers/mfd/pcf50633-adc.c
@@ -218,7 +218,7 @@ static int pcf50633_adc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int pcf50633_adc_remove(struct platform_device *pdev)
+static void pcf50633_adc_remove(struct platform_device *pdev)
 {
 	struct pcf50633_adc *adc = platform_get_drvdata(pdev);
 	int i, head;
@@ -236,8 +236,6 @@ static int pcf50633_adc_remove(struct platform_device *pdev)
 		kfree(adc->queue[i]);
 
 	mutex_unlock(&adc->queue_mutex);
-
-	return 0;
 }
 
 static struct platform_driver pcf50633_adc_driver = {
@@ -245,7 +243,7 @@ static struct platform_driver pcf50633_adc_driver = {
 		.name = "pcf50633-adc",
 	},
 	.probe = pcf50633_adc_probe,
-	.remove = pcf50633_adc_remove,
+	.remove_new = pcf50633_adc_remove,
 };
 
 module_platform_driver(pcf50633_adc_driver);
-- 
2.42.0


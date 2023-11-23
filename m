Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8611B7F6475
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345169AbjKWQ5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjKWQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:56:56 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720E8D42
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:57:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0d-000503-Rr; Thu, 23 Nov 2023 17:56:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0d-00B54n-FI; Thu, 23 Nov 2023 17:56:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0d-006ozQ-6D; Thu, 23 Nov 2023 17:56:59 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 06/18] mfd: intel-lpss-acpi: Convert to platform remove callback returning void
Date:   Thu, 23 Nov 2023 17:56:34 +0100
Message-ID: <20231123165627.492259-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
References: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Sme7QalM7Fxz+h2W/iOt36fGZfq+w2Qz9J3kQwKy1O8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlX4RCnfCgkDJiIE25/oCfSiIzC5NO848BrtAnH ZyBqiDPe++JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZV+EQgAKCRCPgPtYfRL+ ToMQB/9Usf5Erf+yrIvwTJja/sV0wyLm7NbGOq/oPD0A6ULzpXEPJXuTuLFzeI+pUQ1izKzIpXX drtfihdCoaAjmIpQ2xlGLJF68i4FohnxMOUI53PnpT2LX7AzWA+g+EUiuldK/u1JmsPMf1kJNLG eiQDV7FQ5EhP+eZbiHSddN3ddK1mR99Ps+2lGCxnuq8/5fmdYe/56ds/hkTJu6fR2yIogyVbQWx AHBac4/+1LERCvnSy4ZkCsdy5K12f3VcJiPMX11dl/8BKpKzC+bnxraJTr24FHc8QtIY4faIWKr r39ArH582zRPo5wsmp1wUA2YZcJkh9BoWu7DNoISukGYB1gT
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
 drivers/mfd/intel-lpss-acpi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index 212818aef93e..5184fd1a5df1 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -198,19 +198,17 @@ static int intel_lpss_acpi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int intel_lpss_acpi_remove(struct platform_device *pdev)
+static void intel_lpss_acpi_remove(struct platform_device *pdev)
 {
 	intel_lpss_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static INTEL_LPSS_PM_OPS(intel_lpss_acpi_pm_ops);
 
 static struct platform_driver intel_lpss_acpi_driver = {
 	.probe = intel_lpss_acpi_probe,
-	.remove = intel_lpss_acpi_remove,
+	.remove_new = intel_lpss_acpi_remove,
 	.driver = {
 		.name = "intel-lpss",
 		.acpi_match_table = intel_lpss_acpi_ids,
-- 
2.42.0


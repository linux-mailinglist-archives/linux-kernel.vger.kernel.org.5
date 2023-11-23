Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DAF7F6476
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345189AbjKWQ5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjKWQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:56:56 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8D2D46
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:57:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0e-00051H-6o; Thu, 23 Nov 2023 17:57:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0d-00B54t-Or; Thu, 23 Nov 2023 17:56:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0d-006ozU-Fw; Thu, 23 Nov 2023 17:56:59 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 07/18] mfd: kempld-core: Convert to platform remove callback returning void
Date:   Thu, 23 Nov 2023 17:56:35 +0100
Message-ID: <20231123165627.492259-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
References: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=KmijBtfkuKurQFpbpsAneLTGXJS1Jnusah8kZowlcJE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlX4RDkwUEr6r4st/+YMwIR6Z1awsT9exPwbnm+ tzt0Lu8yw2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZV+EQwAKCRCPgPtYfRL+ Ttn6B/4ufQ06c+9PQx3uvAkc7ww5TKk0Z7pNN69ibei2pGdkYQWM+s0VKB7rz0SBrWrltLOR/6G FKF61LS1f3IlHxPf5cplsK0Dcb7K15gmy7wdJ7C+un3FEA6ISQMk2ZwGQklHzCRuWn+pudJJJYR Zac1NvgcYdSWbl/CArFuX1NIa7gLd1z4S3b/5mMtDqtMsMEDeweLqu+7Li0nbqxvD77uzi7tDd+ JrVmtmMrTMJWT2wJ7fj5/Et0pFFXkonZrXjw2t2hg9TNuPjDeYbx1D7c2mBi63weorU0GFCIRXg +34765A/6ijn9ryLfJ0JdzdATOibqh0YhNhNCp1JqkusDJGE
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
 drivers/mfd/kempld-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index 33c6cfe9fe42..67af36a38913 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -535,7 +535,7 @@ static int kempld_probe(struct platform_device *pdev)
 	return kempld_detect_device(pld);
 }
 
-static int kempld_remove(struct platform_device *pdev)
+static void kempld_remove(struct platform_device *pdev)
 {
 	struct kempld_device_data *pld = platform_get_drvdata(pdev);
 	const struct kempld_platform_data *pdata = dev_get_platdata(pld->dev);
@@ -544,8 +544,6 @@ static int kempld_remove(struct platform_device *pdev)
 
 	mfd_remove_devices(&pdev->dev);
 	pdata->release_hardware_mutex(pld);
-
-	return 0;
 }
 
 #ifdef CONFIG_ACPI
@@ -563,7 +561,7 @@ static struct platform_driver kempld_driver = {
 		.acpi_match_table = ACPI_PTR(kempld_acpi_table),
 	},
 	.probe		= kempld_probe,
-	.remove		= kempld_remove,
+	.remove_new	= kempld_remove,
 };
 
 static const struct dmi_system_id kempld_dmi_table[] __initconst = {
-- 
2.42.0


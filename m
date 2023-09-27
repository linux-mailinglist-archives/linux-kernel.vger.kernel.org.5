Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59C27AFDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjI0IMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjI0ILC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:11:02 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13E9CE1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:10:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdC-00084s-5c; Wed, 27 Sep 2023 10:10:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdB-009I7k-6e; Wed, 27 Sep 2023 10:10:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdA-005BR4-Tm; Wed, 27 Sep 2023 10:10:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 16/27] platform/mellanox: mlxreg-hotplug: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 10:10:29 +0200
Message-Id: <20230927081040.2198742-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1906; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=E1EtfCdvL5BCirg1ur2IQNU7vZ4qAkjOL+kP2gKTw5k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlE+NwG78MBx7tIkqC0uEqWcAFKkqlNa6mtOqO4 7ZcwyBcivqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRPjcAAKCRCPgPtYfRL+ TueMB/9v6Xjw8xEB+p3Dh7cgTDM6mL9o/iJBzTm8P8CT94rpzvYE60KNf23G/De+bVPcqLc9e1L bnNli0nmcvP9RtX6OF12QVH/lTzK3x+ewvATcCyrBICqj2df1ltRMgQsRcIX6F3KzGBkFx/XddR UxMQ002pmDF1TUPn8YT/8ZFctwqzryeOzHMaM43Z0ai1BLU4c8G9PGer71+B8s6XX1FjJ8BykOa SxVron71EW1qP+ak5bSYRcCFfh/39pMKMYAqXDhDSoeSJo/VhI9P+zJZGFrNCmz/gz7pvYeF1e7 Z3tE2I16yy/r1BnVuTAXeoW+ahEo/rZaQ1s42A0UuavgpDPL
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
 drivers/platform/mellanox/mlxreg-hotplug.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index eb5ad35274dd..5c022b258f91 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -786,15 +786,13 @@ static int mlxreg_hotplug_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mlxreg_hotplug_remove(struct platform_device *pdev)
+static void mlxreg_hotplug_remove(struct platform_device *pdev)
 {
 	struct mlxreg_hotplug_priv_data *priv = dev_get_drvdata(&pdev->dev);
 
 	/* Clean interrupts setup. */
 	mlxreg_hotplug_unset_irq(priv);
 	devm_free_irq(&pdev->dev, priv->irq, priv);
-
-	return 0;
 }
 
 static struct platform_driver mlxreg_hotplug_driver = {
@@ -802,7 +800,7 @@ static struct platform_driver mlxreg_hotplug_driver = {
 		.name = "mlxreg-hotplug",
 	},
 	.probe = mlxreg_hotplug_probe,
-	.remove = mlxreg_hotplug_remove,
+	.remove_new = mlxreg_hotplug_remove,
 };
 
 module_platform_driver(mlxreg_hotplug_driver);
-- 
2.40.1


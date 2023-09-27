Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4947AFDDC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjI0IMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjI0ILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:11:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D3819F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:11:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdC-00086H-Ct; Wed, 27 Sep 2023 10:10:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdB-009I7u-Jh; Wed, 27 Sep 2023 10:10:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdB-005BRC-AM; Wed, 27 Sep 2023 10:10:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 18/27] platform/mellanox: mlxreg-lc: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 10:10:31 +0200
Message-Id: <20230927081040.2198742-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2109; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OgebHyJ1o+cakI4Sj28nDr13s9jhvV2dMgyHvpitWxQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlE+NyGqwa6XJjBwLMBt7Pdf+hattOnrde7yDsd 71DtewBv0+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRPjcgAKCRCPgPtYfRL+ Tp3SB/4jwksQ8EhV3Nuh3lkJZhSyHogXAPjwyPD1wGV7NPFab/t2cFXfYdlwFQt9SOHaQDXlbp0 0Y2o8ZOFaCG+oI87zAc9896w+T/BtGClnvhp43y8Cr5UY7+KNTyPZTypTbAitzAiZYs1r0FaArt f9VyJMWxxgEdlsNn1xPLwL6kVKBe1WEpWkVq2t+Ic/ciDZoDki34aSKZOMqHHykz6tcPQWubMtJ donb5xxPfH2aUfQ/ADU2x2iaxjWpnpAmnftznwesz3rDr1Jy01VYd4szC3TgcJQ66nsE0ELAfgF tnCsrHtc4PgmbF7tgenjfqda1H4xSoMhyhiksDXXXbvgHhbd
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
 drivers/platform/mellanox/mlxreg-lc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-lc.c b/drivers/platform/mellanox/mlxreg-lc.c
index 8d833836a6d3..43d119e3a473 100644
--- a/drivers/platform/mellanox/mlxreg-lc.c
+++ b/drivers/platform/mellanox/mlxreg-lc.c
@@ -907,7 +907,7 @@ static int mlxreg_lc_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int mlxreg_lc_remove(struct platform_device *pdev)
+static void mlxreg_lc_remove(struct platform_device *pdev)
 {
 	struct mlxreg_core_data *data = dev_get_platdata(&pdev->dev);
 	struct mlxreg_lc *mlxreg_lc = platform_get_drvdata(pdev);
@@ -921,7 +921,7 @@ static int mlxreg_lc_remove(struct platform_device *pdev)
 	 * is nothing to remove.
 	 */
 	if (!data->notifier || !data->notifier->handle)
-		return 0;
+		return;
 
 	/* Clear event notification callback and handle. */
 	data->notifier->user_handler = NULL;
@@ -940,13 +940,11 @@ static int mlxreg_lc_remove(struct platform_device *pdev)
 		i2c_put_adapter(data->hpdev.adapter);
 		data->hpdev.adapter = NULL;
 	}
-
-	return 0;
 }
 
 static struct platform_driver mlxreg_lc_driver = {
 	.probe = mlxreg_lc_probe,
-	.remove = mlxreg_lc_remove,
+	.remove_new = mlxreg_lc_remove,
 	.driver = {
 		.name = "mlxreg-lc",
 	},
-- 
2.40.1


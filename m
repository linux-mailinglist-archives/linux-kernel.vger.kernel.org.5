Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB347AFDD9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjI0IMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjI0ILC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:11:02 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76F0193
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:10:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdD-00088U-6A; Wed, 27 Sep 2023 10:10:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdC-009I86-Bi; Wed, 27 Sep 2023 10:10:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdC-005BRO-2L; Wed, 27 Sep 2023 10:10:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vadim Pasternak <vadimp@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 21/27] platform/x86: mlx-platform: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 10:10:34 +0200
Message-Id: <20230927081040.2198742-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ILwP6aWMlmrtZMvtX94OUtej0Lbs5BrrWeR7MH34P5I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlE+N1hK4xqTWZzb0wX5RGhN9DfoJrNIMYbqrjv ZwMFb84pqmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRPjdQAKCRCPgPtYfRL+ TnDNCAC1bBjNG/Jzg+Ikvd+wXLT+hFG5iiOSoxvDjI+umm43Idt+j8Ih/NrtB/JiJHTuqRxaUVe 74nsieW0qMgNMmWyxjnQ/3sX+dm4Yr80X0Vy2Qn0XpcSyDmmNBRpdbFnbJy/ubljDw+umb/TSj0 CZQdsqOlxmL3zTaAQlw/sH0xIep3cmF1e9eqJlxlRa/fwq7M8FLJ1BWJ4Yt0ssaicF7tPeeiodl GoY9CgsYX+16Im+rvThqd2q6OcuqBs7CJiyjcVjw/qAVQ0wSnLTMsDUD12VrUph304JMlFsuSQW bF0bzMem4yI2wkSw68GMlaE6EYel5Smxz/jIUppOJ3tuQmjF
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
 drivers/platform/x86/mlx-platform.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 3d96dbf79a72..03ccadee35d0 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -6606,7 +6606,7 @@ static int mlxplat_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int mlxplat_remove(struct platform_device *pdev)
+static void mlxplat_remove(struct platform_device *pdev)
 {
 	struct mlxplat_priv *priv = platform_get_drvdata(mlxplat_dev);
 
@@ -6617,7 +6617,6 @@ static int mlxplat_remove(struct platform_device *pdev)
 	mlxplat_pre_exit(priv);
 	mlxplat_i2c_main_exit(priv);
 	mlxplat_post_exit();
-	return 0;
 }
 
 static const struct acpi_device_id mlxplat_acpi_table[] = {
@@ -6633,7 +6632,7 @@ static struct platform_driver mlxplat_driver = {
 		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	},
 	.probe		= mlxplat_probe,
-	.remove		= mlxplat_remove,
+	.remove_new	= mlxplat_remove,
 };
 
 static int __init mlxplat_init(void)
-- 
2.40.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24BB7AFDDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjI0IMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjI0ILD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:11:03 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B1DCE6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:10:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdB-000842-KG; Wed, 27 Sep 2023 10:10:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdA-009I7d-Px; Wed, 27 Sep 2023 10:10:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdA-005BQw-GX; Wed, 27 Sep 2023 10:10:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 14/27] platform/mellanox: mlxbf-bootctl: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 10:10:27 +0200
Message-Id: <20230927081040.2198742-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1712; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+Ir65hE13KMzfZwrYtgBOwv1Y990W+ZpXu4su6/aAis=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlE+NtbwIJLSwu+ovYaCgB85EMrNNoExGsUEWKY 6yvz4UDZqOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRPjbQAKCRCPgPtYfRL+ TgO1B/9lVJPfewfvrMAYbtIWl/9JsCA65yFxAjoW5m7TDXDyWVMWjotZ8pMTKxX+tb2u3mOwxki VjwCNniI3AjB5msfEMqnwoxbSEDo00zeVmwkYxTQDMJqmMMlnpfVoMAb62GZj21ly7WnDWbCABx xFtOEEjXLJcdAGuNKdibWtTKeU5U9W61cSshP/jfQ0/VGnOti3AsMTRGE/n/LM2rSkNVWpBnUVs SB3EvZIPIub/KgAoiOrCHzi8IwYSwkRWM6I19WU68zAb6OGJLMGw8QR2eCG8F1BJnhnql/isi2x JhD2phvWkXnbT2k3+HwLrDn/FrRsS826fmGoEw7CX6ZNPAqx
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
 drivers/platform/mellanox/mlxbf-bootctl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 4ee7bb431b7c..1ac7dab22c63 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -1028,17 +1028,15 @@ static int mlxbf_bootctl_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mlxbf_bootctl_remove(struct platform_device *pdev)
+static void mlxbf_bootctl_remove(struct platform_device *pdev)
 {
 	sysfs_remove_bin_file(&pdev->dev.kobj,
 			      &mlxbf_bootctl_bootfifo_sysfs_attr);
-
-	return 0;
 }
 
 static struct platform_driver mlxbf_bootctl_driver = {
 	.probe = mlxbf_bootctl_probe,
-	.remove = mlxbf_bootctl_remove,
+	.remove_new = mlxbf_bootctl_remove,
 	.driver = {
 		.name = "mlxbf-bootctl",
 		.dev_groups = mlxbf_bootctl_groups,
-- 
2.40.1


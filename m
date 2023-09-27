Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68997AFDE0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjI0IM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjI0ILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:11:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985641A8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:11:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdC-00085h-5f; Wed, 27 Sep 2023 10:10:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdB-009I7p-DJ; Wed, 27 Sep 2023 10:10:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdB-005BR8-40; Wed, 27 Sep 2023 10:10:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 17/27] platform/mellanox: mlxreg-io: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 10:10:30 +0200
Message-Id: <20230927081040.2198742-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=W1A4okYNik1VMgJpJLoBZFEE+DlDZ2qN4h6QATaBCC4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlE+Nxthg5Ec1AQ5v355kFCMJJ81EwvWpNdy6Ea fI7RfQySLyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRPjcQAKCRCPgPtYfRL+ Tg/qB/wJX8G3HE0qqXOb9ERJi68xtzC2i1a+W9RDR+4APiDhliH6rE7GesPvO/MumZIkUOuoviU gPDp9kYrqTBTiseLDrlp4InyXLXouMtVlmgN4Cvuuj6FpVhiW22T0pYdODxXmcrNPSnvYrqGrLF mB6tqWZnfiB/pvKbja0YrVQhrfminKhUgBlKSF2jGjky2VLwgyqgw6E34Kwfuf7iIk8ghivGUh1 K3cxZmsZ5l1P2pNUtwFTJE92rejSB5ojYAyKsMwBOaJP/qm0oQvYIUz7/FajJTyfwbywO1jJ9nk oJqOUqu4ZT0UCZjzmjozuS9cW2VJyoBp7WiygWy4sIp/TquW
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
 drivers/platform/mellanox/mlxreg-io.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-io.c b/drivers/platform/mellanox/mlxreg-io.c
index 83ba037408cd..ee7bd623ba44 100644
--- a/drivers/platform/mellanox/mlxreg-io.c
+++ b/drivers/platform/mellanox/mlxreg-io.c
@@ -263,13 +263,11 @@ static int mlxreg_io_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mlxreg_io_remove(struct platform_device *pdev)
+static void mlxreg_io_remove(struct platform_device *pdev)
 {
 	struct mlxreg_io_priv_data *priv = dev_get_drvdata(&pdev->dev);
 
 	mutex_destroy(&priv->io_lock);
-
-	return 0;
 }
 
 static struct platform_driver mlxreg_io_driver = {
@@ -277,7 +275,7 @@ static struct platform_driver mlxreg_io_driver = {
 	    .name = "mlxreg-io",
 	},
 	.probe = mlxreg_io_probe,
-	.remove = mlxreg_io_remove,
+	.remove_new = mlxreg_io_remove,
 };
 
 module_platform_driver(mlxreg_io_driver);
-- 
2.40.1


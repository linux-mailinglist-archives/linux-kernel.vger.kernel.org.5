Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D595A80541B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjLEM0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjLEM0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:26:35 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C865C9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:26:41 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVY-0005Xu-76; Tue, 05 Dec 2023 13:26:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVX-00Djux-Eg; Tue, 05 Dec 2023 13:26:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVX-00EhQm-5Y; Tue, 05 Dec 2023 13:26:35 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 4/8] regulator: stm32-vrefbuf: Convert to platform remove callback returning void
Date:   Tue,  5 Dec 2023 13:26:19 +0100
Message-ID:  <2e96cf99c8d97b728d891a745e8f94ee39fbfee8.1701778038.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2049; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=sYW+VRQlaUR4tM4vU6xMFTkIkYFDO3ZsrQVPaJ+GEJ4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbxbqWGuXtsy7gv6tNYQlb2xj7XMEobJPqduLF BBMwrfHmbqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW8W6gAKCRCPgPtYfRL+ TgbCB/98owzxEUqbrEj9sMckpRxSmLplun0ZyYiCAYe6awaXUO86peyV+H+0CXO93EdHbFb4Ha1 xR5aVqiHFvoflGPGMgYevzws9GXypUxbh9gddEc2dz8xIkjTjFUvIKL/GtY/xbEwdI812mdn2vK cwO2rD6nuyqSKMytiCXe1J1ms/54sERaxtP2fOqj35P8hbQoBW6LBF9iC4Q7bu7gWN8jzQUTFFb g5GpT/vMiC1D1cyVqLkr+nihchbcCW2SQ1C5Pa7VtvAxHVy1/T5Q7GsxR7SxccytJxtrxjMPlhE tA3urkm3LotZUnKzL2NsfSDubXKXyLeesFdivas8fQU+d4sc
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
 drivers/regulator/stm32-vrefbuf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm32-vrefbuf.c
index 717144cbe0f9..40855105dd33 100644
--- a/drivers/regulator/stm32-vrefbuf.c
+++ b/drivers/regulator/stm32-vrefbuf.c
@@ -233,7 +233,7 @@ static int stm32_vrefbuf_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stm32_vrefbuf_remove(struct platform_device *pdev)
+static void stm32_vrefbuf_remove(struct platform_device *pdev)
 {
 	struct regulator_dev *rdev = platform_get_drvdata(pdev);
 	struct stm32_vrefbuf *priv = rdev_get_drvdata(rdev);
@@ -244,8 +244,6 @@ static int stm32_vrefbuf_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
-
-	return 0;
 };
 
 static int __maybe_unused stm32_vrefbuf_runtime_suspend(struct device *dev)
@@ -282,7 +280,7 @@ MODULE_DEVICE_TABLE(of, stm32_vrefbuf_of_match);
 
 static struct platform_driver stm32_vrefbuf_driver = {
 	.probe = stm32_vrefbuf_probe,
-	.remove = stm32_vrefbuf_remove,
+	.remove_new = stm32_vrefbuf_remove,
 	.driver = {
 		.name  = "stm32-vrefbuf",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.42.0


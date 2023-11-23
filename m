Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C7D7F6489
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345198AbjKWQ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345208AbjKWQ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:57:04 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50963D64
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:57:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0d-0004zQ-Dl; Thu, 23 Nov 2023 17:56:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0c-00B54g-UL; Thu, 23 Nov 2023 17:56:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0c-006ozI-L1; Thu, 23 Nov 2023 17:56:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/18] mfd: fsl-imx25-tsadc: Convert to platform remove callback returning void
Date:   Thu, 23 Nov 2023 17:56:32 +0100
Message-ID: <20231123165627.492259-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
References: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=H9E4DQumuJYM4xGNsjymKWQwrBqvaE1jdcSqA7stR1c=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtT4FocGfaaOewzxfHtil1sf2aDbr83dc66GIdswU79qe vUGZsFORmMWBkYuBlkxRRb7xjWZVlVykZ1r/12GGcTKBDKFgYtTACbCls/+z646rGhr3C5Bjiks tW/fztmy8prXz8TGDv5Fv1UupnQfCV7jfkixwfaWSoN7z5ZWjd0/1e/ZNvH8k19+S137VH6C7Cl FhijdjHs6p8Ks+hgFItikJWRiTyasrTul9Gzt2tfxEpqppwy0vj5dIRWl9/h13+xQ7ZslW4Wb3n C8Nly/v4J1Z1zirq0xrXXLj0uc3bRDK3DTh8s8bT/kBcI8OXbNv57JL7F2VrihxckViQbCoU9qK 7juPDu1ef1vu3sTi+dnL7lW6v0mSO+0kvWEFc2cf2K49HQXzrRbPLmWXTM+RfSi5xMhqfXckYLF nxenrHE048m68tzQ4Pm0xgvTgv4WLHgbsKKnYu2V6DUdAA==
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
 drivers/mfd/fsl-imx25-tsadc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
index 089c2ce615b6..74f38bf3778f 100644
--- a/drivers/mfd/fsl-imx25-tsadc.c
+++ b/drivers/mfd/fsl-imx25-tsadc.c
@@ -194,11 +194,9 @@ static int mx25_tsadc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mx25_tsadc_remove(struct platform_device *pdev)
+static void mx25_tsadc_remove(struct platform_device *pdev)
 {
 	mx25_tsadc_unset_irq(pdev);
-
-	return 0;
 }
 
 static const struct of_device_id mx25_tsadc_ids[] = {
@@ -213,7 +211,7 @@ static struct platform_driver mx25_tsadc_driver = {
 		.of_match_table = mx25_tsadc_ids,
 	},
 	.probe = mx25_tsadc_probe,
-	.remove = mx25_tsadc_remove,
+	.remove_new = mx25_tsadc_remove,
 };
 module_platform_driver(mx25_tsadc_driver);
 
-- 
2.42.0


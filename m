Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F307E72D2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbjKIU3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345220AbjKIU3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:29:21 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A92468F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:29:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeD-0002zf-W9; Thu, 09 Nov 2023 21:29:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeD-007rWd-8G; Thu, 09 Nov 2023 21:29:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeC-00GGtX-VE; Thu, 09 Nov 2023 21:29:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 03/12] bus: omap_l3_smx: Convert to platform remove callback returning void
Date:   Thu,  9 Nov 2023 21:28:33 +0100
Message-ID: <20231109202830.4124591-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1746; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zgJm1dlc/UlSS9zetmH5GbvsuMr4qHT3lQphrWzkAzU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTUDyw8liF78LWnyhFZLru8PNsGZ1t5BmeLGyf 0BHYx1oYjSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU1A8gAKCRCPgPtYfRL+ TtsSB/4lgGCQ+t/mONA1F+XnD+DFwmTvwvTCbxyBHsoJ9uUpV+auNZ5K0B0WlzVfMqqDDQWazys Oewf+G4tvcZn3Cr/r7I65OEGZpM/A2wwR6DOr0Vxk49ASXpiik5DaTqrK0sBvMGD4Cpq5B2dFdC 9GTXCisMJb2Ocbbj7ssV5uKEl21yMzv+10pPDCwTLMmLXUk9s5aUB6nL/6o8knNMuPZEDLcmok8 RSuR67bbgUapNxOYgWFwZ9qu6Ra3XHKQlOiCLXQwroe4VqIEG/QCSm+7pGl1fkvC3rZKywWMKq9 185Eh8d+I+slva1fnPV5DRZvTdkYBaIESmhNSzh4SMNuOBs+
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
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
 drivers/bus/omap_l3_smx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
index 31774648be9d..ee6d29925e4d 100644
--- a/drivers/bus/omap_l3_smx.c
+++ b/drivers/bus/omap_l3_smx.c
@@ -261,7 +261,7 @@ static int omap3_l3_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int omap3_l3_remove(struct platform_device *pdev)
+static void omap3_l3_remove(struct platform_device *pdev)
 {
 	struct omap3_l3         *l3 = platform_get_drvdata(pdev);
 
@@ -269,13 +269,11 @@ static int omap3_l3_remove(struct platform_device *pdev)
 	free_irq(l3->debug_irq, l3);
 	iounmap(l3->rt);
 	kfree(l3);
-
-	return 0;
 }
 
 static struct platform_driver omap3_l3_driver = {
 	.probe		= omap3_l3_probe,
-	.remove         = omap3_l3_remove,
+	.remove_new     = omap3_l3_remove,
 	.driver         = {
 		.name   = "omap_l3_smx",
 		.of_match_table = of_match_ptr(omap3_l3_match),
-- 
2.42.0


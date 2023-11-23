Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65AD7F6473
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345148AbjKWQ47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjKWQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:56:56 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8F6D48
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:57:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0e-00053N-Du; Thu, 23 Nov 2023 17:57:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0e-00B54x-03; Thu, 23 Nov 2023 17:57:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0d-006ozY-NM; Thu, 23 Nov 2023 17:56:59 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 08/18] mfd: mcp-sa11x0: Convert to platform remove callback returning void
Date:   Thu, 23 Nov 2023 17:56:36 +0100
Message-ID: <20231123165627.492259-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
References: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1942; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=306Da8DHDzuEHmAs2DmBNmnh5FVbLXfhEvcGFu1AvDA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlX4RE0iIvzSXUDoJ9ZVZKIf15IRopeUzfSOp0C 53AfyWitiyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZV+ERAAKCRCPgPtYfRL+ ThT6B/9e+FvsnumNbUow1hEZHP3FjwjB8jAayEvtkeFQjLORjXL3V8rrtg6gyvW06tlteUyI3AP ALV4nxz7WfRe+LQuqpIULBW9FPfCUh4QO1wouqvS5/8aTmpQ0RKDqaPefNheRW7Wy+FLR+aGfED dYdfjqmHC6Oco4ZwXl945p6b/P80IGkyhPLmc1/lY1q7UboFwhTpYsb1mZfltVDLH+Vt+NBkKDG BH8tfcw40gVGwgVprukoLzsRqbgw3w5tNCZcyPq2dJOaWvLLrXPr0j+aqw/5Eo61WjysE1WOIe1 sRdbMD74i8uGKm7orHjTJ2raUv4mzZbhYItGuEFV1PjyJG0k
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
 drivers/mfd/mcp-sa11x0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 1c9831b78cf9..3883e472b739 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -232,7 +232,7 @@ static int mcp_sa11x0_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int mcp_sa11x0_remove(struct platform_device *dev)
+static void mcp_sa11x0_remove(struct platform_device *dev)
 {
 	struct mcp *mcp = platform_get_drvdata(dev);
 	struct mcp_sa11x0 *m = priv(mcp);
@@ -251,8 +251,6 @@ static int mcp_sa11x0_remove(struct platform_device *dev)
 	mcp_host_free(mcp);
 	release_mem_region(mem1->start, resource_size(mem1));
 	release_mem_region(mem0->start, resource_size(mem0));
-
-	return 0;
 }
 
 static int mcp_sa11x0_suspend(struct device *dev)
@@ -288,7 +286,7 @@ static const struct dev_pm_ops mcp_sa11x0_pm_ops = {
 
 static struct platform_driver mcp_sa11x0_driver = {
 	.probe		= mcp_sa11x0_probe,
-	.remove		= mcp_sa11x0_remove,
+	.remove_new	= mcp_sa11x0_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.pm	= pm_sleep_ptr(&mcp_sa11x0_pm_ops),
-- 
2.42.0


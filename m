Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C13E7E72D3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345251AbjKIU3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345200AbjKIU31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:29:27 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8431A46AF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:29:17 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeF-00030T-FL; Thu, 09 Nov 2023 21:29:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeE-007rWz-Mj; Thu, 09 Nov 2023 21:29:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1BeE-00GGtv-DS; Thu, 09 Nov 2023 21:29:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>, Yangtao Li <frank.li@vivo.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 09/12] bus: tegra-gmi: Convert to platform remove callback returning void
Date:   Thu,  9 Nov 2023 21:28:39 +0100
Message-ID: <20231109202830.4124591-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1763; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=VjQlvlUP0hSc0i1I5jF7v3psby2JMvMAnYEOoHbOgDg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTUD5GJFFr2+w/ToJXtwZlVXQtzp7LkRrRw5f5 SCYzSLnqbyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU1A+QAKCRCPgPtYfRL+ TmaCCACk8lIKtzEjK+HIAmy1UCWEfkh0YtAjwGTgmHGLU/63Bzs7O4EfTlGSgI6CU/WpQd2Z/oT /r/xL1aY6REcPoenUxW+BVtSQcGtBqYiXndadbyVwVDaMqIILZ+56hBkVqu2hoJG/KHagY79d/r 0LldtrxEaP8JmC7P2WQTqBYgkzbRrSesWHx9Sj7SfuXNVDlNLQXsJCnhyu5AUn/1jiSgr6KrdlI XoMbVVk2TDz+BGcFcgVKGaiUM9ZPVDPNtY79OZ9Wmj4VVlEF5x9w2//Qe+beNHlNYEHSCX4sawO pLN2cuvrxwAWCgJJtmEa8vRbXy30siMExPdKvvHYZQdMUr7W
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
 drivers/bus/tegra-gmi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/tegra-gmi.c b/drivers/bus/tegra-gmi.c
index 59919e99f7cc..f5d6414df9f2 100644
--- a/drivers/bus/tegra-gmi.c
+++ b/drivers/bus/tegra-gmi.c
@@ -258,14 +258,12 @@ static int tegra_gmi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_gmi_remove(struct platform_device *pdev)
+static void tegra_gmi_remove(struct platform_device *pdev)
 {
 	struct tegra_gmi *gmi = platform_get_drvdata(pdev);
 
 	of_platform_depopulate(gmi->dev);
 	tegra_gmi_disable(gmi);
-
-	return 0;
 }
 
 static int __maybe_unused tegra_gmi_runtime_resume(struct device *dev)
@@ -305,7 +303,7 @@ MODULE_DEVICE_TABLE(of, tegra_gmi_id_table);
 
 static struct platform_driver tegra_gmi_driver = {
 	.probe = tegra_gmi_probe,
-	.remove = tegra_gmi_remove,
+	.remove_new = tegra_gmi_remove,
 	.driver = {
 		.name		= "tegra-gmi",
 		.of_match_table	= tegra_gmi_id_table,
-- 
2.42.0


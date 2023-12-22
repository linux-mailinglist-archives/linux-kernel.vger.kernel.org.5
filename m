Return-Path: <linux-kernel+bounces-10104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 219B481CFF8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545E21C228B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667F03A287;
	Fri, 22 Dec 2023 22:51:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BCC1EB43
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoML-0005Zf-AD; Fri, 22 Dec 2023 23:51:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMJ-000qv1-PE; Fri, 22 Dec 2023 23:51:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMK-000FfC-2Y;
	Fri, 22 Dec 2023 23:51:12 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 03/13] irqchip/imx-irqsteer: Convert to platform remove callback returning void
Date: Fri, 22 Dec 2023 23:50:34 +0100
Message-ID:  <c0e5afe62256860150d25bcf644f2b8d62794c86.1703284359.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1703284359.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703284359.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=xfWwPsMpemUSHTIcU/EikGDBKd36foZe+1G4fTs3hqo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlhhK6Fur6CUd1UOKaLZ5K33vkMMIOKWjwsqHiH 25whVgrJMeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYYSugAKCRCPgPtYfRL+ TmM1B/0dtKRdQR04yQXFSmzwaKbsX5SOncdt4JztEDpjk9maci6FPNbO2abC9u92f4VLYrEnQbO WyEdYipdt3kPefqWG8bmhncSmyWaAK5Q95KMUDzm+zD66K5GQM9YjaZrGXyALfPMUAK2mHx5563 4aZblITVqigT8nGGU2xr0oI4OGTlBTBCJrYF65ypXXvXJbubUiMrnk/Pdfw2iHWkuLKvNH5Xcue SlDTOQuUDCUMGtkmkC7aS/xJfTHZGAP2gQwrLKx5ewD5ahv+L391QchrYo3AYQsLCRPeuWuj5qP 3eUQObHtwIkaRfDnEh9PCXgEqAXakiYb81I+xLYTBkygm3v1
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

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
 drivers/irqchip/irq-imx-irqsteer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index bd9543314539..05f6b5e8370d 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -231,7 +231,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_irqsteer_remove(struct platform_device *pdev)
+static void imx_irqsteer_remove(struct platform_device *pdev)
 {
 	struct irqsteer_data *irqsteer_data = platform_get_drvdata(pdev);
 	int i;
@@ -243,8 +243,6 @@ static int imx_irqsteer_remove(struct platform_device *pdev)
 	irq_domain_remove(irqsteer_data->domain);
 
 	clk_disable_unprepare(irqsteer_data->ipg_clk);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -312,6 +310,6 @@ static struct platform_driver imx_irqsteer_driver = {
 		.pm = &imx_irqsteer_pm_ops,
 	},
 	.probe = imx_irqsteer_probe,
-	.remove = imx_irqsteer_remove,
+	.remove_new = imx_irqsteer_remove,
 };
 builtin_platform_driver(imx_irqsteer_driver);
-- 
2.42.0



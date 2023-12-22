Return-Path: <linux-kernel+bounces-10101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8286981CFF5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F0D1F25FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3562F503;
	Fri, 22 Dec 2023 22:51:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0981F381BE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoML-0005Zb-AE; Fri, 22 Dec 2023 23:51:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMJ-000quy-IS; Fri, 22 Dec 2023 23:51:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMK-000Ff8-1s;
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
Subject: [PATCH 02/13] irqchip/imx-intmux: Convert to platform remove callback returning void
Date: Fri, 22 Dec 2023 23:50:33 +0100
Message-ID:  <edeee074956dd943d3c67da894a01dc5f0d33bd7.1703284359.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1784; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=4EOrr+KkEGskg0P1J9XoWIGL8rKAKsaZhlgGBH5sOgo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlhhK5wCvDc6ILPQThuf+7sez3z1TdJh7yxJ24I 1sfizwPvvyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYYSuQAKCRCPgPtYfRL+ TurYB/9xFiFUgWxcVzchQkEssIjqdO3bOh0+LZnN5kDZlcdcvByn6cNaEDhBNexJcJBzYHNqcnv 4Y4PM8PpVw07Bq2T3PpWwyP50Qnqx+hAL8ULOFvYY8FSL88chdUC5ERpkqPXXwugOuInqnoMzIE m/3922hXTJ7IZIxDJbL/0aXIGWbdsZPI9l1GNAXPCSgdvgMNKqXNiRTQ0yv5xDEzZ+ZbJ77DJwS u5rQ2hFjE6rmzQ11yq66KKK8onKBiJgc6JtsTX4FCuMXJuv3OQQXFh7P0Tltq7CCLd/rixwmIjJ +xfL9Fwyh4PYJRDuPXh8xuwM2kJ4rSYwz06GqW4YRIk9exUk
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
 drivers/irqchip/irq-imx-intmux.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index aa041e4dfee0..de292bde058f 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -282,7 +282,7 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_intmux_remove(struct platform_device *pdev)
+static void imx_intmux_remove(struct platform_device *pdev)
 {
 	struct intmux_data *data = platform_get_drvdata(pdev);
 	int i;
@@ -298,8 +298,6 @@ static int imx_intmux_remove(struct platform_device *pdev)
 	}
 
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -359,6 +357,6 @@ static struct platform_driver imx_intmux_driver = {
 		.pm = &imx_intmux_pm_ops,
 	},
 	.probe = imx_intmux_probe,
-	.remove = imx_intmux_remove,
+	.remove_new = imx_intmux_remove,
 };
 builtin_platform_driver(imx_intmux_driver);
-- 
2.42.0



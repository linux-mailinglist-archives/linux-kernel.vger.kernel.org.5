Return-Path: <linux-kernel+bounces-10093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D59681CFEB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDBC1C22A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70C82FC46;
	Fri, 22 Dec 2023 22:51:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20302F535
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMM-0005eq-Pk; Fri, 22 Dec 2023 23:51:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoML-000qvS-5O; Fri, 22 Dec 2023 23:51:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMM-000Ffe-0a;
	Fri, 22 Dec 2023 23:51:14 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 10/13] irqchip/renesas-irqc: Convert to platform remove callback returning void
Date: Fri, 22 Dec 2023 23:50:41 +0100
Message-ID:  <2d367ab738ed2e4cf58cffc10d64b0cbe8a1322c.1703284359.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=RbqlBUDyzNjJon1VjvvsSpLOKIrzb9IWsFsQQCiOHOs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlhhLCVKR7Dii+2+5hAaBXjQ5/Enl4dufiFJZ0x jLGSzewFjqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYYSwgAKCRCPgPtYfRL+ TirvCACSQbDFKgHkODHm4EXqgX2Vuvl/DG6J6UhiYVJAd7U0cxPHzyxMmODqfiYB8dNKEnJPGVH 4FQxt11lrVOO/dhCckci/i8HHxPTBspbYYsb5F7IauDcdyzZ359zqd5L2MwKDUeE2xXSV+cW1KN w44SgmCGJ6i0W0tt1a08bmkX2ezW9poFgyAoOdmdWLmCwdoHXJNqADzDEoVeIL+UuyqjGf1FH8B u295ZZ4KWO5qTs1xRrFKFD9H3dbxQP6enA0nvZ9Dkp+xhfMypEc8hsJuj9lgI6TTMZ4zZx8LFZC itfj1XF5KF6U6iBrXqAntwuhDf2pA5eRWhNaQiT1jsGHErL9
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
 drivers/irqchip/irq-renesas-irqc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 49b446b396f9..2bcf14d0f34b 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -218,14 +218,13 @@ static int irqc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int irqc_remove(struct platform_device *pdev)
+static void irqc_remove(struct platform_device *pdev)
 {
 	struct irqc_priv *p = platform_get_drvdata(pdev);
 
 	irq_domain_remove(p->irq_domain);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
 
 static int __maybe_unused irqc_suspend(struct device *dev)
@@ -248,7 +247,7 @@ MODULE_DEVICE_TABLE(of, irqc_dt_ids);
 
 static struct platform_driver irqc_device_driver = {
 	.probe		= irqc_probe,
-	.remove		= irqc_remove,
+	.remove_new	= irqc_remove,
 	.driver		= {
 		.name	= "renesas_irqc",
 		.of_match_table	= irqc_dt_ids,
-- 
2.42.0



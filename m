Return-Path: <linux-kernel+bounces-10095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770EE81CFED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EFD1C22A85
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABB331584;
	Fri, 22 Dec 2023 22:51:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E812EAFD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoML-0005aA-FC; Fri, 22 Dec 2023 23:51:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMJ-000qv5-VE; Fri, 22 Dec 2023 23:51:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMK-000FfG-39;
	Fri, 22 Dec 2023 23:51:12 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 04/13] irqchip/keystone: Convert to platform remove callback returning void
Date: Fri, 22 Dec 2023 23:50:35 +0100
Message-ID:  <4c852a3359aa06bedcf3a10f3fd8c1e008cc5a3a.1703284359.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1968; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=+EDCUP6ePG/o+3slA3AQpIK7gkTvq8KdHgzdFcR2yug=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlhhK7wEMzZpDvgUxYeqw07y4uj4q89h2lKndDj gIK7Plj5u2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYYSuwAKCRCPgPtYfRL+ Tql4CACibtjb7MoMPwK/QFusOJrRV/PTZB0AK1KY73AwyE6W0xfcGAHQMsdXhy6e71UZL6JpVr/ P920+t1qHobfHNZHgpZMFLOiRlIEHWJ4KVpEUuNxHSUa9zQzNpPZLpKwmgnhSlXTzT6+XU/tmXj HQCLEVFfT0v9XcYCiJ57oFu1dFDXsOXr0yVzztk8s6WKL8j2Hr1MrRFki+WTWN/Lo8MPGOrPHG0 nL7V4RHDcGysnieTH3mg7tEdoyOfir/aPgFD8bIDR1GwXf4NLgXhahVBXdH+MTBdQdLr8nG/8nL 8dmlDQ9FhM9/o6EzydOvIOwWginPpiCLxDr7j06R6z48wDUp
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
 drivers/irqchip/irq-keystone.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index a36396db4b08..30f1979fa124 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -190,7 +190,7 @@ static int keystone_irq_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int keystone_irq_remove(struct platform_device *pdev)
+static void keystone_irq_remove(struct platform_device *pdev)
 {
 	struct keystone_irq_device *kirq = platform_get_drvdata(pdev);
 	int hwirq;
@@ -201,7 +201,6 @@ static int keystone_irq_remove(struct platform_device *pdev)
 		irq_dispose_mapping(irq_find_mapping(kirq->irqd, hwirq));
 
 	irq_domain_remove(kirq->irqd);
-	return 0;
 }
 
 static const struct of_device_id keystone_irq_dt_ids[] = {
@@ -212,7 +211,7 @@ MODULE_DEVICE_TABLE(of, keystone_irq_dt_ids);
 
 static struct platform_driver keystone_irq_device_driver = {
 	.probe		= keystone_irq_probe,
-	.remove		= keystone_irq_remove,
+	.remove_new	= keystone_irq_remove,
 	.driver		= {
 		.name	= "keystone_irq",
 		.of_match_table	= of_match_ptr(keystone_irq_dt_ids),
-- 
2.42.0



Return-Path: <linux-kernel+bounces-10098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3363981CFF2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9703B20DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8189339B6;
	Fri, 22 Dec 2023 22:51:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20092F52A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMM-0005d3-GQ; Fri, 22 Dec 2023 23:51:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMK-000qvP-Vp; Fri, 22 Dec 2023 23:51:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMM-000Ffa-00;
	Fri, 22 Dec 2023 23:51:14 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 09/13] irqchip/renesas-intc-irqpin: Convert to platform remove callback returning void
Date: Fri, 22 Dec 2023 23:50:40 +0100
Message-ID:  <6dc03cf63382d24f954c167aaa988f8e31d6b89d.1703284359.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=EKV4srlNWNOnWsCdCeZKIamXZGGpGXN+FOJhjjqDpnQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlhhLBMcLIRm4Fn3o0htbqDSG0GLVzvYibnLsko 1zh9ZvKmXOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYYSwQAKCRCPgPtYfRL+ TmtGB/oDXf+zULXmpxsxQh1t0lCC/BYHVX+wTolPVew/VD0Wp4cKkG4E1blL5qZl803SQwiYXwE bdx2R0Fx1NNZ0WpSFeB1SANiewzBGca0W73hTjNeIT2cqlYwWxo4MTgdNaGdLpEidaRZY78kJLy rVOFxJkufmkOur3PejIrXOFLc1heJTbKTqTaijc5WTcobEGpcdtmsMm+pFYltyw8DayW3Pdc2z5 F/ksE2HjOwry2GNqYRRY3LlEZB43pJrr9FHCvL/Bm8ig+inSLVK6PlOnSlv8aNJUEC82tStuLEa SRYW1AqB5bQHWN2uo9521jh9QtdBfZ+gj0dPrwpauul6W2bd
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
 drivers/irqchip/irq-renesas-intc-irqpin.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index fa19585f3dee..939293bc274e 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -561,14 +561,13 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int intc_irqpin_remove(struct platform_device *pdev)
+static void intc_irqpin_remove(struct platform_device *pdev)
 {
 	struct intc_irqpin_priv *p = platform_get_drvdata(pdev);
 
 	irq_domain_remove(p->irq_domain);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
 
 static int __maybe_unused intc_irqpin_suspend(struct device *dev)
@@ -585,7 +584,7 @@ static SIMPLE_DEV_PM_OPS(intc_irqpin_pm_ops, intc_irqpin_suspend, NULL);
 
 static struct platform_driver intc_irqpin_device_driver = {
 	.probe		= intc_irqpin_probe,
-	.remove		= intc_irqpin_remove,
+	.remove_new	= intc_irqpin_remove,
 	.driver		= {
 		.name	= "renesas_intc_irqpin",
 		.of_match_table = intc_irqpin_dt_ids,
-- 
2.42.0



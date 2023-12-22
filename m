Return-Path: <linux-kernel+bounces-10092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEEF81CFEA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280B51C2291C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53C72FC43;
	Fri, 22 Dec 2023 22:51:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930282F503
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMM-0005cR-8Y; Fri, 22 Dec 2023 23:51:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMK-000qvL-PB; Fri, 22 Dec 2023 23:51:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoML-000FfW-2Y;
	Fri, 22 Dec 2023 23:51:13 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 08/13] irqchip/pruss-intc: Convert to platform remove callback returning void
Date: Fri, 22 Dec 2023 23:50:39 +0100
Message-ID:  <071057cfdc0bc52c574f74156b410c0337adb69c.1703284359.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=zqHuEaXEImwnlCY9D26ACfYfCkuRPJSjdQSURwFRoRw=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQ2oQOndrv++VI/M4H9w4wjfYf+qlmx3z0/zTJTOSrA/ JHM2ZTYTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmkt7H/oej4u+LBMdiBTGt taGZh1Q+6npnKR2q0xM/8rryX8CFqKd3U3pSDufzVPZenBRauOL3nczPNotFi6pKpytkOtW8Cbh dXRvrcPlJi9h2Xhat01NCdXySb8paZ5mmeabeufOp/aiKp5zILcUpfi1sNb8+P7577uKnrxcS69 9/Xj9lsY5BzNe0syKb196s8fyavO3QWakftxftqnbz/Zykfv5EEu/DlwuNH+XnRUbNtbTT7v0dn Z5ooVQek9KnX8H8zeugl4p6gKfv/UTJ8xmCZ5e7nflYkMh8nz2sqna1mP0+s5XbPn2ymr5btWCz 7xaDbxcdZputDmiNZP5REsTR2e+y/nCE2Ywo10Nu9Zn7AA==
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
 drivers/irqchip/irq-pruss-intc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 0f64ecb9b1f4..6daefa7c87bf 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -599,7 +599,7 @@ static int pruss_intc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pruss_intc_remove(struct platform_device *pdev)
+static void pruss_intc_remove(struct platform_device *pdev)
 {
 	struct pruss_intc *intc = platform_get_drvdata(pdev);
 	u8 max_system_events = intc->soc_config->num_system_events;
@@ -616,8 +616,6 @@ static int pruss_intc_remove(struct platform_device *pdev)
 		irq_dispose_mapping(irq_find_mapping(intc->domain, hwirq));
 
 	irq_domain_remove(intc->domain);
-
-	return 0;
 }
 
 static const struct pruss_intc_match_data pruss_intc_data = {
@@ -650,7 +648,7 @@ static struct platform_driver pruss_intc_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe  = pruss_intc_probe,
-	.remove = pruss_intc_remove,
+	.remove_new = pruss_intc_remove,
 };
 module_platform_driver(pruss_intc_driver);
 
-- 
2.42.0



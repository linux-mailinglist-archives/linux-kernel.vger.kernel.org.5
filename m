Return-Path: <linux-kernel+bounces-10100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6381CFF4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6384B22A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D4B364B3;
	Fri, 22 Dec 2023 22:51:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263133CD1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMN-0005ie-Ah; Fri, 22 Dec 2023 23:51:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoML-000qvb-K2; Fri, 22 Dec 2023 23:51:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMM-000Ffm-21;
	Fri, 22 Dec 2023 23:51:14 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 12/13] irqchip/stm32-exti: Convert to platform remove callback returning void
Date: Fri, 22 Dec 2023 23:50:43 +0100
Message-ID:  <ac551b89025bafadce05102b94596f8cd3564a32.1703284359.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=7EUZkiwcSMvqh8+WiN8ti4/qLswt+nYfqNb7cjNoDwE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQ2oSMTEhY9Zs929nbyD5xYoyjS+nYDj6jyi+el7leDn jmqlSzpZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAimw+x/3cIPnHvtvdmj4Ty 9ga120sKuFJanNI+Mpj72VXN6xZasHSLG+exki/JRu4BTzLFQxaf/n9Ia46uV3bt0S1yjLu/8Oo o67l8kHmUmCLvddSq+vfMPI6WCe8WZaotS5iiWytTeHbz+eQ0xrri5ZmFpxNF5kb8Zw0Sl9ytOi P61k7pGdeX6Uk++b5Wtt0urV9U8fn/l3O/BcfYrzQxWGjy5ckNNrEUc9Hv3lPXZp/jEBcx2G77u drG+t0defaoNfJ7d69dHquZ6bTg+OQAnwR+r0258158KVO97Hdsn2K0dSIDT+wPPuaM09J6+hF2 W11XSv7IOJe49VXOp8Y1LGVMARYJ0wtP/E0w/caizP0QAA==
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
 drivers/irqchip/irq-stm32-exti.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 971240e2e31b..c61a97caafc9 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -898,10 +898,9 @@ static void stm32_exti_remove_irq(void *data)
 	irq_domain_remove(domain);
 }
 
-static int stm32_exti_remove(struct platform_device *pdev)
+static void stm32_exti_remove(struct platform_device *pdev)
 {
 	stm32_exti_h_syscore_deinit();
-	return 0;
 }
 
 static int stm32_exti_probe(struct platform_device *pdev)
@@ -991,7 +990,7 @@ MODULE_DEVICE_TABLE(of, stm32_exti_ids);
 
 static struct platform_driver stm32_exti_driver = {
 	.probe		= stm32_exti_probe,
-	.remove		= stm32_exti_remove,
+	.remove_new	= stm32_exti_remove,
 	.driver		= {
 		.name	= "stm32_exti",
 		.of_match_table = stm32_exti_ids,
-- 
2.42.0



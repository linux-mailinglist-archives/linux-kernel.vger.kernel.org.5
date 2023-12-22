Return-Path: <linux-kernel+bounces-10097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADA281CFEF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC7B1C22C36
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB773309F;
	Fri, 22 Dec 2023 22:51:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A9A2F848
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMN-0005kS-D2; Fri, 22 Dec 2023 23:51:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoML-000qve-Pv; Fri, 22 Dec 2023 23:51:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMM-000Ffq-2d;
	Fri, 22 Dec 2023 23:51:14 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 13/13] irqchip/ts4800: Convert to platform remove callback returning void
Date: Fri, 22 Dec 2023 23:50:44 +0100
Message-ID:  <0bdce86b50e5aa50cffbc4add332cbfbad87521e.1703284359.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=9P+LbVGo/TTFNAJ4I3GeO7ieNbGzcoms9p3NIoglRlk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlhhLGp3MhPzeMepy+cjVPc+NFm3S9EHw6HmeBh C7a4Nuop7OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYYSxgAKCRCPgPtYfRL+ TmboB/9qmaYqiy97cqHTGGuAQvFVvZN4gGMqto4Kaaf0xFalfX9pPt9PfNIz/7t+QxpeotlQFgS /46uwjiI6Y6L1SPM/zHhu4nCz1w45mE6n3UKrpUa6uzDhRBPSmgD9IMBSFP8UUDDXM4gzVipw/i QLqjO/jZ8fVNs/JTgSgCBHY+az5lkrqaY5LuuceqGDp/CIx9hAzAJbpm8gF0gn5ATmpKIiUISf4 Y1xADOcIOkLrJ/ExX815lXkXnH2NhgyPkH0air7oi+r0ajNbIjAVhpELfUB7r1WLf78cDRpHA9H LXGXg6e5DbirV+XyQ/LNyzCg5NLQsC/CG7EHB42w4kO/Mipv
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
 drivers/irqchip/irq-ts4800.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index b2d61d4f6fe6..c69a819f099c 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -139,13 +139,11 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ts4800_ic_remove(struct platform_device *pdev)
+static void ts4800_ic_remove(struct platform_device *pdev)
 {
 	struct ts4800_irq_data *data = platform_get_drvdata(pdev);
 
 	irq_domain_remove(data->domain);
-
-	return 0;
 }
 
 static const struct of_device_id ts4800_ic_of_match[] = {
@@ -156,7 +154,7 @@ MODULE_DEVICE_TABLE(of, ts4800_ic_of_match);
 
 static struct platform_driver ts4800_ic_driver = {
 	.probe  = ts4800_ic_probe,
-	.remove = ts4800_ic_remove,
+	.remove_new = ts4800_ic_remove,
 	.driver = {
 		.name = "ts4800-irqc",
 		.of_match_table = ts4800_ic_of_match,
-- 
2.42.0



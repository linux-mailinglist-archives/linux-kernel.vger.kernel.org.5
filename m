Return-Path: <linux-kernel+bounces-80176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95CD862B57
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAD91C21081
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77691B81D;
	Sun, 25 Feb 2024 15:55:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA201802E
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876520; cv=none; b=KP0UFXAQ7e8j+Ei0KK9S6skidXVojVbB/SLJN6761vkzLFpyeZzOp7yBlwPBgsyTWu+GgqIOt0SZCoY0v8sQn3QE3JMVlhzfbpHr/t4ccCjgK67/tLb+BGM3WvR9w00Na4gVEUJx6DVjkiKX/7KV2uqA882ezD/RzkLPayma2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876520; c=relaxed/simple;
	bh=ZzG9u5HNAgKsxobtMilQkgjY+MJvRQhpIBiOCphcdGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxiXugCwwDwgkrbqMkoRDDjc5fjxrv9xdYq5gJyLW2epUpcm9b71w/ByvjdRbHEz8eUkgarkEgl5MUSsDajj0omYMankHky3Qqel++g/UpGmZ3QhnIj/Tp5T3rIsIGLi3bgzYWuLN2x2O+EzGiSPWGH0f4NZlDyGEgvsEddraBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqO-00006u-0K; Sun, 25 Feb 2024 16:55:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqN-002pKO-K8; Sun, 25 Feb 2024 16:55:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqN-00BKp8-1j;
	Sun, 25 Feb 2024 16:55:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] extcon: max77843: Convert to platform remove callback returning void
Date: Sun, 25 Feb 2024 16:54:54 +0100
Message-ID:  <30097beba928bf2073645f85d21fb9c1aee64991.1708876186.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708876186.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708876186.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2017; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ZzG9u5HNAgKsxobtMilQkgjY+MJvRQhpIBiOCphcdGc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl22LUoKa7H3Upy3pf/E2K8o+nXOaA+29hZe2w7 /N02qrYTNeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdti1AAKCRCPgPtYfRL+ TjdeB/wM1LeQcIzHg9kKa+hU5X9Z+tkNYGy7YYsmnDqACXWxLt3TFfwActQfeeyTg1E0eE3bBoG ORl3fCXckYYs274dXFAXmvEBfpmxZKCZ/Zdoh+tXFN9VKr/lkvH1kHjLUQ+BvafWy9ojscTYAhw s88J7Mz95JHybGRBIhCYvBezDJKL/9mLLq3euRHUmNWyVZRnbnbuC0kuERc6Xx7QsfwDByqEoEW PB274I08+ZP3trBFvpbCGS4M5CZRC9039funZ9nNvCU9TPR/is3NURymxxXcGL5OBXLX2/8NV5X ukaHEvblRZxMU5IFLHDmPq4pPfXQY7ggD7SrJmPLFc3H/qTy
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
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/extcon/extcon-max77843.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index acb11a54f875..9849e3b8327e 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -928,7 +928,7 @@ static int max77843_muic_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int max77843_muic_remove(struct platform_device *pdev)
+static void max77843_muic_remove(struct platform_device *pdev)
 {
 	struct max77843_muic_info *info = platform_get_drvdata(pdev);
 	struct max77693_dev *max77843 = info->max77843;
@@ -936,8 +936,6 @@ static int max77843_muic_remove(struct platform_device *pdev)
 	cancel_work_sync(&info->irq_work);
 	regmap_del_irq_chip(max77843->irq, max77843->irq_data_muic);
 	i2c_unregister_device(max77843->i2c_muic);
-
-	return 0;
 }
 
 static const struct platform_device_id max77843_muic_id[] = {
@@ -958,7 +956,7 @@ static struct platform_driver max77843_muic_driver = {
 		.of_match_table = of_max77843_muic_dt_match,
 	},
 	.probe		= max77843_muic_probe,
-	.remove		= max77843_muic_remove,
+	.remove_new	= max77843_muic_remove,
 	.id_table	= max77843_muic_id,
 };
 
-- 
2.43.0



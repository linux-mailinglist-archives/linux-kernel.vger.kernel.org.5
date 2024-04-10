Return-Path: <linux-kernel+bounces-138659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6F689F8C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FAF21C26D88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AD5174EEC;
	Wed, 10 Apr 2024 13:41:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDEB172BB8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756482; cv=none; b=PWc+lqoTnqTKRbmjOg9Z2jgkmS6Kn03T+wRHrtPpXApt72ZqkD26Z+chqFG7tin8NS+AFwJO+kNsTsAvn+3SCcdLUOY1VaF1Qny9b+y2oICHfUTG/d2lky7px8QuQNNmPYoigI8hKetxTIwYsqS9zMpl1M9ZKxoUB6OYSL3MbQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756482; c=relaxed/simple;
	bh=Ma+tNX+cGvgLi5sj6D3GlIy3nW/wQpcfxcu7rY4KQsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVPMzUAxNBUiEYy3V+DAmA1nsXWC1Z27ROaBPxmyc2C90nBnih1TYLdxzsI/L5KGlJn4hMjtUwDZT4gsL4PdBjszJzEo9Te1T1ElrZhQnxs2x0BE4TwQochDvlwpC0dxIM6XHE69B91QmIt0ERzf6lJFA4X6Y7HCW3JHoPadqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYCT-0003w8-Lk; Wed, 10 Apr 2024 15:41:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYCT-00BVN9-8V; Wed, 10 Apr 2024 15:41:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYCT-00HaVo-0b;
	Wed, 10 Apr 2024 15:41:17 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>
Cc: Osama Muhammad <osmtendev@gmail.com>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 2/2] HSI: omap_ssi_port: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 15:41:11 +0200
Message-ID:  <11e06f4cce041436bd63fb24361f3cee06bd2d59.1712756364.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712756364.git.u.kleine-koenig@pengutronix.de>
References: <cover.1712756364.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1984; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Ma+tNX+cGvgLi5sj6D3GlIy3nW/wQpcfxcu7rY4KQsU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFpb5X0+I3Rta/Ik2Nwl0hNVZ6ydSpyZ7aKDDM AB7Fq2JFKKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhaW+QAKCRCPgPtYfRL+ TiHNB/9sn1Wm7BB5ataMlxxAnUWZfhWfeuiJG5VCBmI5Yri/folcgLioe+HP/rdcLR7uWZvc64k YzwotihZ71p/H1CVCM9W1UedFGFc9tRfM3g8lbBnCs60ZHNC9j+7NG9e5JQ3LjTP0cjT3AKU3S4 nuXBGo6gLQiagFfUiN2I0yMtYhCjJUAYOqwNZMfyhPfkCVIls6oMNjWf9e2n6uh5itZE2OpW2Ip F2oDgK14RD7urGDz0v8jCXF0vaSw8xPmCb3et6WxnnsccLA86cXnfAwWGzRwr6+vsAeXTFDGicB Xmim35u5OoIU/V4O4obssWMdHP5xy8iSb4HBOWV2C2d8FAqB
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
 drivers/hsi/controllers/omap_ssi_port.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index c78d9c9f7371..f0b3eca7376e 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -1224,7 +1224,7 @@ static int ssi_port_probe(struct platform_device *pd)
 	return err;
 }
 
-static int ssi_port_remove(struct platform_device *pd)
+static void ssi_port_remove(struct platform_device *pd)
 {
 	struct hsi_port *port = platform_get_drvdata(pd);
 	struct omap_ssi_port *omap_port = hsi_port_drvdata(port);
@@ -1251,8 +1251,6 @@ static int ssi_port_remove(struct platform_device *pd)
 
 	pm_runtime_dont_use_autosuspend(&pd->dev);
 	pm_runtime_disable(&pd->dev);
-
-	return 0;
 }
 
 static int ssi_restore_divisor(struct omap_ssi_port *omap_port)
@@ -1387,7 +1385,7 @@ MODULE_DEVICE_TABLE(of, omap_ssi_port_of_match);
 
 struct platform_driver ssi_port_pdriver = {
 	.probe = ssi_port_probe,
-	.remove	= ssi_port_remove,
+	.remove_new = ssi_port_remove,
 	.driver	= {
 		.name	= "omap_ssi_port",
 		.of_match_table = omap_ssi_port_of_match,
-- 
2.43.0



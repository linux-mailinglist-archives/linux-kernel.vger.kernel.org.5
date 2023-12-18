Return-Path: <linux-kernel+bounces-4387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B894817C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAB81C22727
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2A07349B;
	Mon, 18 Dec 2023 21:05:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058573462
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFKnr-0002lo-6F; Mon, 18 Dec 2023 22:05:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFKnq-00GmX3-QE; Mon, 18 Dec 2023 22:05:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFKnq-005Y6J-HC; Mon, 18 Dec 2023 22:05:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] parport: sunbpp: Convert to platform remove callback returning void
Date: Mon, 18 Dec 2023 22:05:19 +0100
Message-ID:  <f0372246783c7eebb859f82b4b23a9ae25b0adf1.1702933181.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702933181.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702933181.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ofIRXtKGpIt9OxfKBZODaGUOXDxcYP4SGgITVJt06dI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgLQOwZWLAI6JNeacXZ51oE/b3dXdV8luY9/ja rH4bM60HOeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYC0DgAKCRCPgPtYfRL+ ToBSB/kBsrql5HlXWGTX0aJUadzt/IWZGuBlY+vYyL7ylbIismb65+vtNdhJg2B1e5RplFcZXFX Th3yTeNzBHiE4RYcXjfacgrWMKq/9SmTw2VASr0uchyxFTttJT65rejkXD8q2viW1xh1oJqpzRk B4b+pIG41WwAcnPDgP88luVXvSbv9mNwDf2nJTqnJQVWnVPuPkGwlf61acbunLsf3ev5VaIMNfO jm7/xwMRjAkMv46q8jy6CrJsmQc0KSHa5xYJ8Z0xZ4oYEwNknSQzLb5SW45pQlAz1mHQrQB0a0V TuxsfYRRAQWJ54+PeWBshDpWZfGtmMtlAJh66rFbZUNoj1xg
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
 drivers/parport/parport_sunbpp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sunbpp.c
index c81d4d86994b..949236a7a27c 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -334,7 +334,7 @@ static int bpp_probe(struct platform_device *op)
 	return err;
 }
 
-static int bpp_remove(struct platform_device *op)
+static void bpp_remove(struct platform_device *op)
 {
 	struct parport *p = dev_get_drvdata(&op->dev);
 	struct parport_operations *ops = p->ops;
@@ -351,8 +351,6 @@ static int bpp_remove(struct platform_device *op)
 	kfree(ops);
 
 	dev_set_drvdata(&op->dev, NULL);
-
-	return 0;
 }
 
 static const struct of_device_id bpp_match[] = {
@@ -370,7 +368,7 @@ static struct platform_driver bpp_sbus_driver = {
 		.of_match_table = bpp_match,
 	},
 	.probe		= bpp_probe,
-	.remove		= bpp_remove,
+	.remove_new	= bpp_remove,
 };
 
 module_platform_driver(bpp_sbus_driver);
-- 
2.42.0



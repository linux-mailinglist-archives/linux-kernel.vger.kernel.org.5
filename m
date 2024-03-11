Return-Path: <linux-kernel+bounces-99589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDBE878A62
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456B4281B27
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BEE5821C;
	Mon, 11 Mar 2024 21:59:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954FC5788F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194393; cv=none; b=uLM8O1zRxzYVKYbacr/SkNEBuhXrknxj2hltLyYXQissTO/7kuRsaRUrNEG973pxITO2PcnHX8h+C7P498MLwM6n0smUGSmcMYrUEPaH4aqQrvL0oZGyshNr/gIgSlOcibQs7EFcgAXlGpLlaPTbudyBqiAgqGq0aHowieul8ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194393; c=relaxed/simple;
	bh=J0af8rTU5N8DEwYEax+Abb4w87fJFVFWbwKgVA1K+cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9JVgNz07k+g79L+sKb08zUwM36rJApggDF0bTAhd0N9Q+66xOenVfoRNzt0Icc5s+QRh+Gh5SSujIl4URP9dgu14xa/fW4/w93IuMjJnRG0EGxFotjB9GuG0uUZ4zqiqP+FGCaw7gAjypNUnzSGM0Pf5mLuoPgx5Xj8qroldO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjngQ-0006D5-2f; Mon, 11 Mar 2024 22:59:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjngP-005nF6-MQ; Mon, 11 Mar 2024 22:59:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjngP-004JCM-1z;
	Mon, 11 Mar 2024 22:59:45 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andy@kernel.org>
Cc: Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 3/3] auxdisplay: img-ascii-lcd: Convert to platform remove callback returning void
Date: Mon, 11 Mar 2024 22:59:24 +0100
Message-ID:  <44de2d4c1fed6fe96b68ba9ad768d297b8f392a5.1710194084.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710194084.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710194084.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1840; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=J0af8rTU5N8DEwYEax+Abb4w87fJFVFWbwKgVA1K+cg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl736+kkRAF5euv5xWKRVnttsXYNGO5YcyhXrj3 zNGLmw3h8yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe9+vgAKCRCPgPtYfRL+ ToVrCACtgQ3byPvcqkYc7egHYXqIgIEew3R5CGgGy+npZ8Y+0SzVdhUG2/5P6BmbcT0FqxcdmU8 91OdVr0Fu0Yvf1QlczqdY5GUrl8iu6+bqHlwSJeiU69OTmhQUfPXGF8ZUhBn6zhpQN0BCgpltLG RU+5yLaU8IlkBdyHV7izWk1CzA+0tt6N19VOOAc5HDYgrCi0ZyhQkHGSMetUTw0eg9RtU/f0vrg yTt+rFSUGzp4vrLtpyCHUo/ak+AO1OXjAnP8f6Lf8atP1maFwM74RYrgfubfi3rJTZgLbF3q5IJ iYFKCZNwDDQRECgfDsY0cCwdEMLayYOo0dc2vSj6v5WR6DpK
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
 drivers/auxdisplay/img-ascii-lcd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
index 925c4cd101e9..0c91e39389c1 100644
--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -279,13 +279,12 @@ static int img_ascii_lcd_probe(struct platform_device *pdev)
  *
  * Return: 0
  */
-static int img_ascii_lcd_remove(struct platform_device *pdev)
+static void img_ascii_lcd_remove(struct platform_device *pdev)
 {
 	struct img_ascii_lcd_ctx *ctx = platform_get_drvdata(pdev);
 
 	sysfs_remove_link(&pdev->dev.kobj, "message");
 	linedisp_unregister(&ctx->linedisp);
-	return 0;
 }
 
 static struct platform_driver img_ascii_lcd_driver = {
@@ -294,7 +293,7 @@ static struct platform_driver img_ascii_lcd_driver = {
 		.of_match_table	= img_ascii_lcd_matches,
 	},
 	.probe	= img_ascii_lcd_probe,
-	.remove	= img_ascii_lcd_remove,
+	.remove_new = img_ascii_lcd_remove,
 };
 module_platform_driver(img_ascii_lcd_driver);
 
-- 
2.43.0



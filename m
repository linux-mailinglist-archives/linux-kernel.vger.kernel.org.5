Return-Path: <linux-kernel+bounces-99587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B081878A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021011F21FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F5F5733B;
	Mon, 11 Mar 2024 21:59:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41A56B7F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194390; cv=none; b=GqS5r5MMEy9EThla4tWbD3JwacRsNJR73slhlDyeTc0YvtJ2SXHFuBmdJdfNNkMpxMNA9W6iwnEkyUKZigCZdy+/RxbmHtQ0UpqbYsgROhzxZkPPfQjf1FjzietG4zGhsBFT7uV9or4c98rAimVznC/Yfqc2TjOO0cOA6SxdRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194390; c=relaxed/simple;
	bh=X4bTRkoZDBfqWFUU0A2YBkREN3iooCLnOateAdH0SDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHVg173FLB118cYFcwAuj/ojgDrav2Zthzj+aWZI8aa1BqSQx8M71EaLe5cRiBBoURoO7bx5yMuHnp2KdMjD0LVNRAHP5G6jtu64m61jZBnXgCxy0pL0k2gioopz6eICf+AhRW+b5VHOwOuo6E35S6ZXZR295FeEErALJGI+7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjngP-0006Cy-RM; Mon, 11 Mar 2024 22:59:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjngP-005nF1-Ee; Mon, 11 Mar 2024 22:59:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjngP-004JCI-1E;
	Mon, 11 Mar 2024 22:59:45 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andy@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 2/3] auxdisplay: hd44780: Convert to platform remove callback returning void
Date: Mon, 11 Mar 2024 22:59:23 +0100
Message-ID:  <868dcff909d5056be2d548a249820b61fc2f0452.1710194084.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=X4bTRkoZDBfqWFUU0A2YBkREN3iooCLnOateAdH0SDw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7369FQPSH9c4hM0zjqBQ8uZ8qBeTc8EPc+CBF 6IBKGHBmgiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe9+vQAKCRCPgPtYfRL+ TpF5CACoMgPE7gOxWEe31mB7e/Pzj/yKPnp5quXarQCYDDyjwNv3cJmftHLPJTTWMurY+R4WUIq dn7Bb+bd1eMVAdStJT0Gu0vtSUpKtyIXzCbQCgB7AzcuE12BU27SeLrKNPqfpk4RYMjkLbSz5NL vWabLWcrzjASL152CxQEozI1gRouh9HQipnf/LfuGNwfV515zd7s8QgP5fgZ67TSkmfRaS1IXbp QPdcGORWrD3cxvrizC36cXnc7CgnPDGpAAADoNZFE57QPn+w+34zxZa/CMXMuaE9hRMLLl9KQDL EPyD9I9uQG2g1QCKg6y13tUcufU/G2MLmQcl8YnqbMeDjjZk
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
 drivers/auxdisplay/hd44780.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index d56a5d508ccd..7ac0b1b1d548 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -319,7 +319,7 @@ static int hd44780_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hd44780_remove(struct platform_device *pdev)
+static void hd44780_remove(struct platform_device *pdev)
 {
 	struct charlcd *lcd = platform_get_drvdata(pdev);
 	struct hd44780_common *hdc = lcd->drvdata;
@@ -329,7 +329,6 @@ static int hd44780_remove(struct platform_device *pdev)
 	kfree(lcd->drvdata);
 
 	kfree(lcd);
-	return 0;
 }
 
 static const struct of_device_id hd44780_of_match[] = {
@@ -340,7 +339,7 @@ MODULE_DEVICE_TABLE(of, hd44780_of_match);
 
 static struct platform_driver hd44780_driver = {
 	.probe = hd44780_probe,
-	.remove = hd44780_remove,
+	.remove_new = hd44780_remove,
 	.driver		= {
 		.name	= "hd44780",
 		.of_match_table = hd44780_of_match,
-- 
2.43.0



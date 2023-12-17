Return-Path: <linux-kernel+bounces-2636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7CD815FC5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C67B1F21B75
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E7C46BAA;
	Sun, 17 Dec 2023 14:30:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698814594E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9d-0006Vk-Jz; Sun, 17 Dec 2023 15:30:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9d-00GUhN-7G; Sun, 17 Dec 2023 15:30:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9c-004hzD-UL; Sun, 17 Dec 2023 15:30:04 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	Paul Cercueil <paul@crapouillou.net>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] memory: jz4780-nemc: Convert to platform remove callback returning void
Date: Sun, 17 Dec 2023 15:29:32 +0100
Message-ID:  <fa609b805a7ed6e4c6ce81464528ea4163625d67.1702822744.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702822744.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702822744.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=GK2KZnqcdPQ7ce5OhcDXJKsNHWUaLDvnl9OrvLYV59Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfwXMSIuOgrnIXMD1kAk4I+wVgUgcHxmTddpF0 qFTcRdlnNaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX8FzAAKCRCPgPtYfRL+ Tp05B/4yqfZ5IZZi2h6BJZmfSEXr4OSgNKGOr/3MNfLkaHsCLkJEWUTHMcy0qsug2SfL08iyUpE QakKFZs2XfR6MyCKQRLv5ghZIc6jgP4F2Sr77TQZWQx3ON5P4QOP7vJChRukz+1OI57ZUOwIkbZ 4/LUHd+X8o/mAr92zOJmpdX3JjxqoNMh3unQu0zPpdIbEu+DrJg89IUuypv8XtzVYTqektxTX9F okA21bWCJGXBWLxqI/8y3z1YmerloN3D9USxtZoEiPsyN4IPZzpjFylajsl/56NyZdDcdlLchvx otOqdLbqCCeSpGz6w+Mczf/o7pQtI0U/g/Aqalf/q6/J1xi3
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
 drivers/memory/jz4780-nemc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index e5a93e7da15f..fb6db2ffe71b 100644
--- a/drivers/memory/jz4780-nemc.c
+++ b/drivers/memory/jz4780-nemc.c
@@ -384,12 +384,11 @@ static int jz4780_nemc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int jz4780_nemc_remove(struct platform_device *pdev)
+static void jz4780_nemc_remove(struct platform_device *pdev)
 {
 	struct jz4780_nemc *nemc = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(nemc->clk);
-	return 0;
 }
 
 static const struct jz_soc_info jz4740_soc_info = {
@@ -408,7 +407,7 @@ static const struct of_device_id jz4780_nemc_dt_match[] = {
 
 static struct platform_driver jz4780_nemc_driver = {
 	.probe		= jz4780_nemc_probe,
-	.remove		= jz4780_nemc_remove,
+	.remove_new	= jz4780_nemc_remove,
 	.driver	= {
 		.name	= "jz4780-nemc",
 		.of_match_table = of_match_ptr(jz4780_nemc_dt_match),
-- 
2.42.0



Return-Path: <linux-kernel+bounces-2644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9C8815FD0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C921F211E7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C12A45972;
	Sun, 17 Dec 2023 14:30:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7746545
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9f-0006WW-9b; Sun, 17 Dec 2023 15:30:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9e-00GUhc-2u; Sun, 17 Dec 2023 15:30:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9d-004hzT-Pr; Sun, 17 Dec 2023 15:30:05 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/15] memory: exynos5422-dmc: Convert to platform remove callback returning void
Date: Sun, 17 Dec 2023 15:29:36 +0100
Message-ID:  <167dbda286584eafec07da8c11673da07ba72362.1702822744.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2061; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=FHOjgtzRIN9XHjUcxCP7MGMz7yRB1JuZQ6LGi2PE66k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfwXQmW+Q6PEK4vacr/EoUiA1qF6qrGQu4k8BB 9+ceA0cHFWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX8F0AAKCRCPgPtYfRL+ TibiCAC1uo4RR6+/cFLGqWwewyu7CjBqgCgdaQNtmQtdcpP2BuwkSLign+vU7FxZOYvzOomdeb7 Kbha57cN1prbQpTJKp03UX5Y1TyYuVy9YkkPh+Ac2Xi2b98vREFLjfHkN36A2dnfUjLBm4v34+7 vE1YzF5TRy+eKezWaP/iCLmnv85eU9Sn5FMf6SYKYcOEWOuesQzWE+LzP4pM+h4Qsu7IkMOMtgl Hp8SNhDVJklZXTzVGDXH1qQETrw545SnVH1mjxL044eXLlp+mYtBnJhB160GOkhvLz6Z/jZmBgh 50xvY3amw2c7RHVnhGLOYfeiqWmVuYPjiebx2NauufYrlzb+
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
 drivers/memory/samsung/exynos5422-dmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 6d019dbd721c..da7ecd921c72 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1558,7 +1558,7 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
  * clean the device's resources. It just calls explicitly disable function for
  * the performance counters.
  */
-static int exynos5_dmc_remove(struct platform_device *pdev)
+static void exynos5_dmc_remove(struct platform_device *pdev)
 {
 	struct exynos5_dmc *dmc = dev_get_drvdata(&pdev->dev);
 
@@ -1569,8 +1569,6 @@ static int exynos5_dmc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(dmc->mout_bpll);
 	clk_disable_unprepare(dmc->fout_bpll);
-
-	return 0;
 }
 
 static const struct of_device_id exynos5_dmc_of_match[] = {
@@ -1581,7 +1579,7 @@ MODULE_DEVICE_TABLE(of, exynos5_dmc_of_match);
 
 static struct platform_driver exynos5_dmc_platdrv = {
 	.probe	= exynos5_dmc_probe,
-	.remove = exynos5_dmc_remove,
+	.remove_new = exynos5_dmc_remove,
 	.driver = {
 		.name	= "exynos5-dmc",
 		.of_match_table = exynos5_dmc_of_match,
-- 
2.42.0



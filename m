Return-Path: <linux-kernel+bounces-2633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E5E815FC0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6ADD2848AE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822AB46449;
	Sun, 17 Dec 2023 14:30:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA444C84
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9c-0006VM-WF; Sun, 17 Dec 2023 15:30:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9c-00GUhD-GI; Sun, 17 Dec 2023 15:30:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9c-004hz1-7A; Sun, 17 Dec 2023 15:30:04 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	Santosh Shilimkar <ssantosh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] memory: emif: Convert to platform remove callback returning void
Date: Sun, 17 Dec 2023 15:29:29 +0100
Message-ID:  <da2fa8d040d542edc1318aeae5117317bb22aa06.1702822744.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=unkZGXW/GBMij3XUkpyQaAXYnruITJsZtJqqHnqW6wY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfwXIlYCuL20IU+oKd4SHoVuSVc2z9AqLE+XQP VhL8Zc1e3eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX8FyAAKCRCPgPtYfRL+ TkcuB/9xUatnUb3NxjSCoYvzf/ZDrQDjLfZpdz6ty/hfopPE7HsdjEpp1xC68ChCZFEpul2N6ka m5baMNk4B2dtrhQR4UMqwmMLL+NK4H57cYWbQmi2scmzb7nk72ewlnpvIy9x/zDbV4mGXWvuYL2 Cwnr3ddJKhhS1huGAh1sY+pasL7xBIIxjCg8PTV7stp1c+tCw7pf2pjPUtJq62Fz8nLhFBW3Yaw fSeVVqCsu+f/fF2/ji7ikpx+tew/rZft/hESOd53krOs9FxQcDfucVp2wMGDjjEp+SUT1I4pO/i 9chBR4OWfNTWcbjvh54/hUFbh4/wlGe004eGG4i2ccRe771G
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
 drivers/memory/emif.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index f305643209f0..434982545be6 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1159,13 +1159,11 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
 	return -ENODEV;
 }
 
-static int __exit emif_remove(struct platform_device *pdev)
+static void __exit emif_remove(struct platform_device *pdev)
 {
 	struct emif_data *emif = platform_get_drvdata(pdev);
 
 	emif_debugfs_exit(emif);
-
-	return 0;
 }
 
 static void emif_shutdown(struct platform_device *pdev)
@@ -1185,7 +1183,7 @@ MODULE_DEVICE_TABLE(of, emif_of_match);
 #endif
 
 static struct platform_driver emif_driver = {
-	.remove		= __exit_p(emif_remove),
+	.remove_new	= __exit_p(emif_remove),
 	.shutdown	= emif_shutdown,
 	.driver = {
 		.name = "emif",
-- 
2.42.0



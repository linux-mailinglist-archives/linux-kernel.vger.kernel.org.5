Return-Path: <linux-kernel+bounces-2637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2E1815FC9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8222B222A6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2316C1DDC0;
	Sun, 17 Dec 2023 14:30:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DDF44C90
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9f-0006XT-NU; Sun, 17 Dec 2023 15:30:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9e-00GUhk-HB; Sun, 17 Dec 2023 15:30:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9e-004hzg-7v; Sun, 17 Dec 2023 15:30:06 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Nick Alcock <nick.alcock@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 12/15] memory: tegra186-emc: Convert to platform remove callback returning void
Date: Sun, 17 Dec 2023 15:29:38 +0100
Message-ID:  <8481c7e7d5b024325e6b1aabf7cb3a3707d211d6.1702822744.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1927; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=8/pftyzoFtmGA6p6jcaOA6JIc1RRi2neeGtIXzu26sU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfwXTkEYXXtmYxZ4s8+U/GoL3SKSKZkW9evRbN GNv9diXtaCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX8F0wAKCRCPgPtYfRL+ TmZ3B/wJqToPNYpxaErGUho2q1O5sv/fIn6IWr3tr95NscNpSGNq98icF5USm3P5n1jy5oK88H5 YAQSlahvOmYs3rlGOim9tJoxC8ItfqRb/3iRX6qQGuZNw1Cc2JLO5LSJTUwW93w8XhpJ/5bULki krUehMq8ikMVSaZW3KbOp6KmNOeb5XcSZvDAZG8BOsEs6rnyGCH024RseHZVmIsR23awOUiW2Yb MQTegUYdZs/1HF0lmqThU3+P2nSaTP3hFGNZg/PQs8jrZlUdrLS4v0rlEznJwT4uX/7mXikD8Fs 3A+Mud6NvEvfG5kelN5c+20Hev2uWwabIDmkMFzMf9eCMY3E
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
 drivers/memory/tegra/tegra186-emc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 4007f4e16d74..fcd4aea48bda 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -378,7 +378,7 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int tegra186_emc_remove(struct platform_device *pdev)
+static void tegra186_emc_remove(struct platform_device *pdev)
 {
 	struct tegra_mc *mc = dev_get_drvdata(pdev->dev.parent);
 	struct tegra186_emc *emc = platform_get_drvdata(pdev);
@@ -387,8 +387,6 @@ static int tegra186_emc_remove(struct platform_device *pdev)
 
 	mc->bpmp = NULL;
 	tegra_bpmp_put(emc->bpmp);
-
-	return 0;
 }
 
 static const struct of_device_id tegra186_emc_of_match[] = {
@@ -413,7 +411,7 @@ static struct platform_driver tegra186_emc_driver = {
 		.sync_state = icc_sync_state,
 	},
 	.probe = tegra186_emc_probe,
-	.remove = tegra186_emc_remove,
+	.remove_new = tegra186_emc_remove,
 };
 module_platform_driver(tegra186_emc_driver);
 
-- 
2.42.0



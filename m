Return-Path: <linux-kernel+bounces-2643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA5F815FCF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034411F2174B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8186F481D8;
	Sun, 17 Dec 2023 14:30:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E046453
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9f-0006Y8-By; Sun, 17 Dec 2023 15:30:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9e-00GUhn-Nz; Sun, 17 Dec 2023 15:30:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9e-004hzk-Ef; Sun, 17 Dec 2023 15:30:06 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 13/15] memory: tegra210-emc: Convert to platform remove callback returning void
Date: Sun, 17 Dec 2023 15:29:39 +0100
Message-ID:  <3e2951685dddbc0ab32244916a9849af206a6730.1702822744.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=bGdyoxMNmY/bbwpr5SN+sb3K9b9jnZzp/Hcxotdsv9Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfwXUZZG5GWUBTUeLiKtuoBiiZylSrm31PtSWX 94NiU6Y59uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX8F1AAKCRCPgPtYfRL+ TgCOB/0dPqf5bYKYlXnyRskNAJ2J1KfXnjmdTEdDVhDx7V8W651gEkJ9kWcgIzMMPe1kNm9w/MY /FZWlvbRm+V21imJBp+IdlVEXmodVoxUIwNOuZcKHz2yP/OSnVf8zfhKPorwXKlH/wT/INl4zzj +Pp7/rJ8FcK4/aCw0fdDYKFlGNvaThJQ4VOY/UeHWvqjAnhYDzc/gNwlbV0mKnaiBA9aaJV3neO ++YWHaihxoT0q8mH8WePbRn7Xf1x6AvpL/1VSfbvIXOmGixnJk50Zj8A5ci7txtFmrLqJ3yTTg1 gM3wuXnlc82ARyW0RhkX1kgKKS5rMIX9fyRC7pAkdkeMOsaI
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
 drivers/memory/tegra/tegra210-emc-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/tegra/tegra210-emc-core.c b/drivers/memory/tegra/tegra210-emc-core.c
index 3300bde47c13..78ca1d6c0977 100644
--- a/drivers/memory/tegra/tegra210-emc-core.c
+++ b/drivers/memory/tegra/tegra210-emc-core.c
@@ -1985,15 +1985,13 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int tegra210_emc_remove(struct platform_device *pdev)
+static void tegra210_emc_remove(struct platform_device *pdev)
 {
 	struct tegra210_emc *emc = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(emc->debugfs.root);
 	tegra210_clk_emc_detach(emc->clk);
 	of_reserved_mem_device_release(emc->dev);
-
-	return 0;
 }
 
 static int __maybe_unused tegra210_emc_suspend(struct device *dev)
@@ -2053,7 +2051,7 @@ static struct platform_driver tegra210_emc_driver = {
 		.pm = &tegra210_emc_pm_ops,
 	},
 	.probe = tegra210_emc_probe,
-	.remove = tegra210_emc_remove,
+	.remove_new = tegra210_emc_remove,
 };
 
 module_platform_driver(tegra210_emc_driver);
-- 
2.42.0



Return-Path: <linux-kernel+bounces-2639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D41815FCA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB1B1F21103
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A1047F43;
	Sun, 17 Dec 2023 14:30:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E3745014
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9e-0006VK-T6; Sun, 17 Dec 2023 15:30:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9c-00GUh6-23; Sun, 17 Dec 2023 15:30:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9b-004hyt-Os; Sun, 17 Dec 2023 15:30:03 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] memory: brcmstb_dpfe: Convert to platform remove callback returning void
Date: Sun, 17 Dec 2023 15:29:27 +0100
Message-ID:  <94780e5a414b20b6effa1e87208c14620c854e88.1702822744.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=NqCgvYjkJld3SgKTMzNoNFlN7UBIUNxiFFLbxrZ5cYQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfwXGl1AmJHmGkUrNQ1FnLcrkoZ4iDiokSMdTj kBRQcFosluJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX8FxgAKCRCPgPtYfRL+ TgZPB/4yygmvfAFl9kDpKc6eG2Iay0PbfcS9KAho672FuxXi2wYKFF92Z7VSJkHcnd6C6Ix+YRk LujlGAzxjH+9IWgeGNV9cz/jweGLzDqkYgRnawaziENAnDO3Iq7tP+/5170007yJdXpXlFysicj oqONP/mZMeQeFSvbOM7JyWFXaOc68SPyPMWNlAyyG7mzc/PRX+bAqHbCZ29SGzxLQC6egU9PYxY rqlrsHx5t2HOBm5Q0ZNsyHawSJ7InOwuk+KFmXAfaR+ddDLxVmO7f7LRPg0kGHREeWYYWhA8TtU T5eo7lMF2U4nXnyd1mIZSLzSno+1pyI6hIUnPNRqb4oKb9fv
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
 drivers/memory/brcmstb_dpfe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index a7ab3d377206..5028467b2dc9 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -909,13 +909,11 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int brcmstb_dpfe_remove(struct platform_device *pdev)
+static void brcmstb_dpfe_remove(struct platform_device *pdev)
 {
 	struct brcmstb_dpfe_priv *priv = dev_get_drvdata(&pdev->dev);
 
 	sysfs_remove_groups(&pdev->dev.kobj, priv->dpfe_api->sysfs_attrs);
-
-	return 0;
 }
 
 static const struct of_device_id brcmstb_dpfe_of_match[] = {
@@ -936,7 +934,7 @@ static struct platform_driver brcmstb_dpfe_driver = {
 		.of_match_table = brcmstb_dpfe_of_match,
 	},
 	.probe = brcmstb_dpfe_probe,
-	.remove	= brcmstb_dpfe_remove,
+	.remove_new = brcmstb_dpfe_remove,
 	.resume = brcmstb_dpfe_resume,
 };
 
-- 
2.42.0



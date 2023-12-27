Return-Path: <linux-kernel+bounces-12264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ABF81F219
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A5A283E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE356495CF;
	Wed, 27 Dec 2023 21:03:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A37F481A5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3J-0000mR-JU; Wed, 27 Dec 2023 22:02:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3I-001wEs-02; Wed, 27 Dec 2023 22:02:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3J-001ZVQ-01;
	Wed, 27 Dec 2023 22:02:57 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 03/12] mailbox: imx: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 22:02:31 +0100
Message-ID:  <cac656a03311ac42a633c874620b6b6d967a2102.1703710628.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703710628.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703710628.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=tu7OGIAh4t5eSo5RkymTUYbo/0xSaIoNAc2ogwnsVgo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljJDodYLH7tkz1QmIENibmLSj5ppFvhRT8H2EQ iVhsDahxNyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYyQ6AAKCRCPgPtYfRL+ TgfFCACPAWNWZETI1tvYwCrw2K4KfE4KqyAXJTss7x7RZKwriOCHeV05ZuvPw3lhNC0qyk9FoZj Z0LwpZq+kn4+yHziqi6i05zT71n51CZNdTQ2kSm6fMd4XxYlC/O5FGYKcOMLLTx7LBQZ7HuiYYl ZsK0Av6p9SLZbIkW770H8l8YmXbFb1ICniZ8xda0nUV37u9lToGXiH1jPdgHP3GdSbL9YsoCqxS PqhBOziRKbN6KRzm8SMjAn9YEbOYXd9KV6PjldGpuiwpv0UGDjlHeRi8u9I0KQcwrHaJuo/BZO6 OmITM3R0hpu1/G7u9Cp7S8D1+F6aoc6rSHhFi4GcNsFCEynj
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
 drivers/mailbox/imx-mailbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 0af739ab571c..656171362fe9 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -903,13 +903,11 @@ static int imx_mu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_mu_remove(struct platform_device *pdev)
+static void imx_mu_remove(struct platform_device *pdev)
 {
 	struct imx_mu_priv *priv = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(priv->dev);
-
-	return 0;
 }
 
 static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
@@ -1070,7 +1068,7 @@ static const struct dev_pm_ops imx_mu_pm_ops = {
 
 static struct platform_driver imx_mu_driver = {
 	.probe		= imx_mu_probe,
-	.remove		= imx_mu_remove,
+	.remove_new	= imx_mu_remove,
 	.driver = {
 		.name	= "imx_mu",
 		.of_match_table = imx_mu_dt_ids,
-- 
2.43.0



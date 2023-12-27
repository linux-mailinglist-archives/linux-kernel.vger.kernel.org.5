Return-Path: <linux-kernel+bounces-12131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5CC81F064
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D48E1C218DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B750C47F53;
	Wed, 27 Dec 2023 16:26:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9E146424
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjz-00059q-UX; Wed, 27 Dec 2023 17:26:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjx-001tZW-KD; Wed, 27 Dec 2023 17:26:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjy-001Wmx-21;
	Wed, 27 Dec 2023 17:26:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thierry Reding <treding@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 05/11] firmware: mtk-adsp-ipc: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 17:26:29 +0100
Message-ID:  <e2ea8abb4c30190392a86cf05cecd722d0f0b493.1703693980.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=a63jCU/xmx3JjQAul7+0HQjMC2XzUPEGHuetp5aEk3E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljFA3VZRLFHuI4OPARK9PwC54oddug682gpz+A znDmlUhrkyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYxQNwAKCRCPgPtYfRL+ ThSDCACWPSchgdcXQcSe1ovZmVZAWx9vNPIVAPhqu3ln3Y0yG+zsXGBC0H7gc9JaRmGlwAY+riC eSc7+8e3umCnEsXjDUEu6wJnGrWaJCNz4XQlWNzvPaZFSY+i7Mu4Ez+p6/+vcyu1KcXoXqvMFO5 67QAssIT+LYqZ/834Rieou/m7tWmsf3nBZavxgKHIqdkP+pH9gqxcaNnaFixFR89MkOfLUJ9aZH l9qeyQnZP819ihTK0OlbOu2YRAc0oB14rJ36x3WDkg+YwHzMTsBiMMubWPbCdQzfoeX27D4TvnG VKoMdv3Bb+9ECeJu3WAOA//PoFDN6f9c40u6nLxdDcFKxoD0
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
 drivers/firmware/mtk-adsp-ipc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/mtk-adsp-ipc.c b/drivers/firmware/mtk-adsp-ipc.c
index 85e94ddc7204..a762302978de 100644
--- a/drivers/firmware/mtk-adsp-ipc.c
+++ b/drivers/firmware/mtk-adsp-ipc.c
@@ -116,7 +116,7 @@ static int mtk_adsp_ipc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mtk_adsp_ipc_remove(struct platform_device *pdev)
+static void mtk_adsp_ipc_remove(struct platform_device *pdev)
 {
 	struct mtk_adsp_ipc *adsp_ipc = dev_get_drvdata(&pdev->dev);
 	struct mtk_adsp_chan *adsp_chan;
@@ -126,8 +126,6 @@ static int mtk_adsp_ipc_remove(struct platform_device *pdev)
 		adsp_chan = &adsp_ipc->chans[i];
 		mbox_free_channel(adsp_chan->ch);
 	}
-
-	return 0;
 }
 
 static struct platform_driver mtk_adsp_ipc_driver = {
@@ -135,7 +133,7 @@ static struct platform_driver mtk_adsp_ipc_driver = {
 		.name = "mtk-adsp-ipc",
 	},
 	.probe = mtk_adsp_ipc_probe,
-	.remove = mtk_adsp_ipc_remove,
+	.remove_new = mtk_adsp_ipc_remove,
 };
 builtin_platform_driver(mtk_adsp_ipc_driver);
 
-- 
2.43.0



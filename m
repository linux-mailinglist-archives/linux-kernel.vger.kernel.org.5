Return-Path: <linux-kernel+bounces-2640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2691A815FCB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7462FB22214
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F3247F7B;
	Sun, 17 Dec 2023 14:30:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE5045BF2
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9e-0006Vz-U0; Sun, 17 Dec 2023 15:30:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9d-00GUhR-Fv; Sun, 17 Dec 2023 15:30:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9d-004hzH-6b; Sun, 17 Dec 2023 15:30:05 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/15] memory: mtk-smi: Convert to platform remove callback returning void
Date: Sun, 17 Dec 2023 15:29:33 +0100
Message-ID:  <5c35a33cfdc359842e034ddd2e9358f10e91fa1f.1702822744.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2760; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=nsC7YSob3OITdlCeKMTdDVDTrdjo8YuTORSn8Byw9y0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfwXN3/e8ieYkjMi1tAYZQl77ONh52chbRYAon ZmqHfYltDOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX8FzQAKCRCPgPtYfRL+ Tjm+CACaZe3fPNzfsFwX+VFxbpC0VXkBNDQp9G105jLOUAwYeNwMsNtQ8Ra7JbD3v/yciHSQC2k c2jN3f0dxUetCqeD3DbanuNuWKI2zJK5cgooyZ15CSK7RE3QsRUIFZpLOe/PgvEgCDo/6olp0VA 7UmbglPSPG/5ij8OPj6IEtinJCbK+p/nWAFvgBAE5EWXjY8mwH+3yl1bOWLD02aDQJ/ohcP4TuN ZZoEeLsxnJIttB6YjR1X/Y7KNJ3jvru9dDQQrAKK/GPfEfMkTH/HiSY6j/IM2fklHsBrvCu1hZF 3XhZLrsbdJUCcj2kGx+9zBnT5m7DIJYxOnImrnhE/aNZjIF6
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
 drivers/memory/mtk-smi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 6523cb510518..572c7fbdcfd3 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -566,14 +566,13 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mtk_smi_larb_remove(struct platform_device *pdev)
+static void mtk_smi_larb_remove(struct platform_device *pdev)
 {
 	struct mtk_smi_larb *larb = platform_get_drvdata(pdev);
 
 	device_link_remove(&pdev->dev, larb->smi_common_dev);
 	pm_runtime_disable(&pdev->dev);
 	component_del(&pdev->dev, &mtk_smi_larb_component_ops);
-	return 0;
 }
 
 static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
@@ -616,7 +615,7 @@ static const struct dev_pm_ops smi_larb_pm_ops = {
 
 static struct platform_driver mtk_smi_larb_driver = {
 	.probe	= mtk_smi_larb_probe,
-	.remove	= mtk_smi_larb_remove,
+	.remove_new = mtk_smi_larb_remove,
 	.driver	= {
 		.name = "mtk-smi-larb",
 		.of_match_table = mtk_smi_larb_of_ids,
@@ -795,14 +794,13 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mtk_smi_common_remove(struct platform_device *pdev)
+static void mtk_smi_common_remove(struct platform_device *pdev)
 {
 	struct mtk_smi *common = dev_get_drvdata(&pdev->dev);
 
 	if (common->plat->type == MTK_SMI_GEN2_SUB_COMM)
 		device_link_remove(&pdev->dev, common->smi_common_dev);
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
 
 static int __maybe_unused mtk_smi_common_resume(struct device *dev)
@@ -842,7 +840,7 @@ static const struct dev_pm_ops smi_common_pm_ops = {
 
 static struct platform_driver mtk_smi_common_driver = {
 	.probe	= mtk_smi_common_probe,
-	.remove = mtk_smi_common_remove,
+	.remove_new = mtk_smi_common_remove,
 	.driver	= {
 		.name = "mtk-smi-common",
 		.of_match_table = mtk_smi_common_of_ids,
-- 
2.42.0



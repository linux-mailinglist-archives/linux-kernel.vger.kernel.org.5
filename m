Return-Path: <linux-kernel+bounces-137360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A5B89E105
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27EEB28383A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94BB153BC3;
	Tue,  9 Apr 2024 17:03:10 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF2013E3E3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682190; cv=none; b=qh9KZfeuYaZCBexnH+zS+KoJwuEwMzNnbm3khHdBVBC0vkuQ6IixA54KpxO2Fdvu8gchenNuf6gwcRxiXh+uDZXsE1ZXTyn3R2Es4x45CMPM7HnD3i8v4hg+z7FId5cBP9ho4sEmoNkgjaRJ4ovcnF4G/1jS6B0DdC6yCqYTgNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682190; c=relaxed/simple;
	bh=nnag9TDOvYwgs6peM/CI7enPh4lSO2QV8yl8i3TRuW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GfmL56bG1lVg+fdY5deiUJpQbfA1adK0zUC1+gX2ENUKgW/Y7AugY8hyQBluaHB85/goWUQ7XfTTUnVd1BQ/4rkwMeYV3keKbA3d9Ri/DyGs75MKUYA5HxYPSFphPmVHtumheaZmwgoHaf/LzpFiyKplurKg8O9qmLPVvvwGPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEsD-0003vn-K2; Tue, 09 Apr 2024 19:03:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEsD-00BKyJ-3Q; Tue, 09 Apr 2024 19:03:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEsC-00H4tf-3D;
	Tue, 09 Apr 2024 19:03:05 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] gpu: ipu-v3: Convert to platform remove callback returning void
Date: Tue,  9 Apr 2024 19:02:51 +0200
Message-ID:  <dee3c0e1c8c6bd1027a91c65be55ac1d6ba9e099.1712681770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3826; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=nnag9TDOvYwgs6peM/CI7enPh4lSO2QV8yl8i3TRuW0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFXS8dtMuLim9UDueBCfjxfzTAdaOGOHGUKNJc jNMxBZAm3uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhV0vAAKCRCPgPtYfRL+ TisZB/9pONi2zrxHbgOkJ86iC2P6yhflRtOFRCWVQD9qp+WH28/qjDtxe9YIyC8BVJNjVIUnjj7 GRXYay/f3nicVFxtfsi/OPa/nip17Ae4n3+c+rvIoqIWB5Kuw8DIsvYMb26xO2ORMJ97BsCH3wj r5dme+CsSDcNOPsVnjRz3ryZ2O/iDZCfy7djf4UeeEzzFK2HZbPAYsOXBo+jUWpo0HJJgcrt33C sea32KNbigU1AJwSOu13zXNDKBJoMMmcIr5UzmR2IvF90oi0bW1ynCrRFHq26RbUY6WKZbOgq/i 9Sy3Qkd8ghvcbm+JNI5knqw8RB4xMY9H3+LwUbbTMkqqj7vE
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

Trivially convert the ipu-v3 platform drivers from always returning zero
in the remove callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpu/ipu-v3/ipu-common.c | 6 ++----
 drivers/gpu/ipu-v3/ipu-pre.c    | 5 ++---
 drivers/gpu/ipu-v3/ipu-prg.c    | 6 ++----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 71ec1e7f657a..3535be9daa1f 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1450,7 +1450,7 @@ static int ipu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ipu_remove(struct platform_device *pdev)
+static void ipu_remove(struct platform_device *pdev)
 {
 	struct ipu_soc *ipu = platform_get_drvdata(pdev);
 
@@ -1459,8 +1459,6 @@ static int ipu_remove(struct platform_device *pdev)
 	ipu_irq_exit(ipu);
 
 	clk_disable_unprepare(ipu->clk);
-
-	return 0;
 }
 
 static struct platform_driver imx_ipu_driver = {
@@ -1469,7 +1467,7 @@ static struct platform_driver imx_ipu_driver = {
 		.of_match_table = imx_ipu_dt_ids,
 	},
 	.probe = ipu_probe,
-	.remove = ipu_remove,
+	.remove_new = ipu_remove,
 };
 
 static struct platform_driver * const drivers[] = {
diff --git a/drivers/gpu/ipu-v3/ipu-pre.c b/drivers/gpu/ipu-v3/ipu-pre.c
index aef984a43190..e469272d4f25 100644
--- a/drivers/gpu/ipu-v3/ipu-pre.c
+++ b/drivers/gpu/ipu-v3/ipu-pre.c
@@ -312,7 +312,7 @@ static int ipu_pre_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ipu_pre_remove(struct platform_device *pdev)
+static void ipu_pre_remove(struct platform_device *pdev)
 {
 	struct ipu_pre *pre = platform_get_drvdata(pdev);
 
@@ -326,7 +326,6 @@ static int ipu_pre_remove(struct platform_device *pdev)
 	if (pre->buffer_virt)
 		gen_pool_free(pre->iram, (unsigned long)pre->buffer_virt,
 			      IPU_PRE_MAX_WIDTH * IPU_PRE_NUM_SCANLINES * 4);
-	return 0;
 }
 
 static const struct of_device_id ipu_pre_dt_ids[] = {
@@ -336,7 +335,7 @@ static const struct of_device_id ipu_pre_dt_ids[] = {
 
 struct platform_driver ipu_pre_drv = {
 	.probe		= ipu_pre_probe,
-	.remove		= ipu_pre_remove,
+	.remove_new	= ipu_pre_remove,
 	.driver		= {
 		.name	= "imx-ipu-pre",
 		.of_match_table = ipu_pre_dt_ids,
diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
index 729605709955..4976ac0bb876 100644
--- a/drivers/gpu/ipu-v3/ipu-prg.c
+++ b/drivers/gpu/ipu-v3/ipu-prg.c
@@ -419,15 +419,13 @@ static int ipu_prg_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ipu_prg_remove(struct platform_device *pdev)
+static void ipu_prg_remove(struct platform_device *pdev)
 {
 	struct ipu_prg *prg = platform_get_drvdata(pdev);
 
 	mutex_lock(&ipu_prg_list_mutex);
 	list_del(&prg->list);
 	mutex_unlock(&ipu_prg_list_mutex);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -471,7 +469,7 @@ static const struct of_device_id ipu_prg_dt_ids[] = {
 
 struct platform_driver ipu_prg_drv = {
 	.probe		= ipu_prg_probe,
-	.remove		= ipu_prg_remove,
+	.remove_new	= ipu_prg_remove,
 	.driver		= {
 		.name	= "imx-ipu-prg",
 		.pm	= &prg_pm_ops,
-- 
2.43.0



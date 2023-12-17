Return-Path: <linux-kernel+bounces-2632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A0F815FBD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85F5284643
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D236946421;
	Sun, 17 Dec 2023 14:30:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FBC32C86
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9d-0006Vd-DX; Sun, 17 Dec 2023 15:30:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9d-00GUhJ-0P; Sun, 17 Dec 2023 15:30:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9c-004hz9-NZ; Sun, 17 Dec 2023 15:30:04 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] memory: fsl_ifc: Convert to platform remove callback returning void
Date: Sun, 17 Dec 2023 15:29:31 +0100
Message-ID:  <4c90b971e9816320586f4e01e68c95331b8e524a.1702822744.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1764; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=eSBa/fs8NodpdGdszaXDUc+ymMsxDWr2uvmVnp4C53Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfwXLxuA7kDucWGGRqw8PGSmNXnGtbc34NX5Ps jjEdWKqqK+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX8FywAKCRCPgPtYfRL+ Tj+2B/9I76sHZ3/XmoTh9IF8YE+UyAZ56dGm/AQVNrlGvKUkBwIBmTZ+g+adxfthZwO+qt56Pq/ URQybLtFhCu490mxmzvR7y3v7NpFCGODHGBdSr16lrlB60RVz3Q2F54s3l4S15BM1h1g9XfKnb8 07p/qO6wlkLpBmMrV+uJmmz+6P4BnofX9dsY4P3qXfbPA+nAQSqMqytcVaA5XTZHvcgVoS6rufH i9ggz9r6lA1Qh4SYnEwitVPXlOxGHVY94jR7cejRc9r7H5MRRIrsnt15L7f+88n3WG/hlkee7NB gcI2I76dxQqMdWwckvyT6wv2TMqU1gjPcKtCG5KHTvxetgoN
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
 drivers/memory/fsl_ifc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index 2509e5152036..15e919c24f81 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -84,7 +84,7 @@ static int fsl_ifc_ctrl_init(struct fsl_ifc_ctrl *ctrl)
 	return 0;
 }
 
-static int fsl_ifc_ctrl_remove(struct platform_device *dev)
+static void fsl_ifc_ctrl_remove(struct platform_device *dev)
 {
 	struct fsl_ifc_ctrl *ctrl = dev_get_drvdata(&dev->dev);
 
@@ -98,8 +98,6 @@ static int fsl_ifc_ctrl_remove(struct platform_device *dev)
 	iounmap(ctrl->gregs);
 
 	dev_set_drvdata(&dev->dev, NULL);
-
-	return 0;
 }
 
 /*
@@ -318,7 +316,7 @@ static struct platform_driver fsl_ifc_ctrl_driver = {
 		.of_match_table = fsl_ifc_match,
 	},
 	.probe       = fsl_ifc_ctrl_probe,
-	.remove      = fsl_ifc_ctrl_remove,
+	.remove_new  = fsl_ifc_ctrl_remove,
 };
 
 static int __init fsl_ifc_init(void)
-- 
2.42.0



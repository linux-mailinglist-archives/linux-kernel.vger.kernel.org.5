Return-Path: <linux-kernel+bounces-2630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05F4815FB8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178D01C21709
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFA74596C;
	Sun, 17 Dec 2023 14:30:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FF744C74
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9d-0006VQ-6T; Sun, 17 Dec 2023 15:30:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9c-00GUhG-Q0; Sun, 17 Dec 2023 15:30:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9c-004hz5-Gp; Sun, 17 Dec 2023 15:30:04 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] memory: fsl-corenet-cf: Convert to platform remove callback returning void
Date: Sun, 17 Dec 2023 15:29:30 +0100
Message-ID:  <3b506dcf90b57c341e59bcf5af7ee69092a2d857.1702822744.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=4GKd6L0J9ejMA+vYrbmphTcshFPUGEJl8XNbz0nTZqo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfwXKD2N267gDEQ6+5jqpmelYgMzz8hlB8epUD PGbWwv5StKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX8FygAKCRCPgPtYfRL+ TsMSB/4tyd+z/3jSZvqYtk7kHqOBS6yGBKMCquYj1vXCQM+aqhWqyzfWs2kR8ZF24XIa8cRIYwK a4+gmJV0ed+H5Sy5eSRX6KBd5WwMINfjiwq10aPA0bj6+TcxMZpVAwNZLbFmbwSDIRnpLTQG2o/ 0uV+CH/0QKBfvUkfjH0PzVqhQYf5VDvaWR1+W8Y3tcQFdrerzPYCz5vJxUQdZSxOvIk7jjeh3EM oe1VElX/IFxdJ5vbutdNV7lj6s/Odv2OKVALaTiBZf/SrXKcyk4MqIR1pPtEXYoryNCd55QEYei 7kSK2GCSllPdEFBgh++/V5UJJ1X5hRBLgiLQ7XZYlS2G0AMV
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
 drivers/memory/fsl-corenet-cf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/fsl-corenet-cf.c b/drivers/memory/fsl-corenet-cf.c
index 8096c4f33303..f47d05f7c5c5 100644
--- a/drivers/memory/fsl-corenet-cf.c
+++ b/drivers/memory/fsl-corenet-cf.c
@@ -223,7 +223,7 @@ static int ccf_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ccf_remove(struct platform_device *pdev)
+static void ccf_remove(struct platform_device *pdev)
 {
 	struct ccf_private *ccf = dev_get_drvdata(&pdev->dev);
 
@@ -241,8 +241,6 @@ static int ccf_remove(struct platform_device *pdev)
 		iowrite32be(0, &ccf->err_regs->errinten);
 		break;
 	}
-
-	return 0;
 }
 
 static struct platform_driver ccf_driver = {
@@ -251,7 +249,7 @@ static struct platform_driver ccf_driver = {
 		.of_match_table = ccf_matches,
 	},
 	.probe = ccf_probe,
-	.remove = ccf_remove,
+	.remove_new = ccf_remove,
 };
 
 module_platform_driver(ccf_driver);
-- 
2.42.0



Return-Path: <linux-kernel+bounces-2638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0B4815FC8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00B61C21ECE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9FB47A40;
	Sun, 17 Dec 2023 14:30:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6636144C81
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9f-0006b0-O8; Sun, 17 Dec 2023 15:30:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9f-00GUhw-4D; Sun, 17 Dec 2023 15:30:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9e-004hzs-RU; Sun, 17 Dec 2023 15:30:06 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	Santosh Shilimkar <ssantosh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] memory: ti-emif-pm: Convert to platform remove callback returning void
Date: Sun, 17 Dec 2023 15:29:41 +0100
Message-ID:  <c69f64ad0e89fe2a37b281d44ebfb55b565b50bf.1702822744.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=WJZhwPTIlOIcqqLEYHwjtW0719qozbE7mBK83LkfWTk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfwXWitg8IFqEzU/x3i9wOHluf61iEJdKFWz4e sP6AwJyr2WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX8F1gAKCRCPgPtYfRL+ TgQcB/4+1a//3wge4lcfstHDq+FtIiQnRK37NbknYbLzRn5tWA54WLLrR4a0XofCL0GN7YSRAHU 4tu7BUdnZCOxDdTjz/RR1yEFaLgGcij11HxXSoguQ8KEQqsynys0RfRr9AgK687x9PEQeE4+jwg iBLkifzP7BlGxsEpEwtjXc7MsLsFthQ0n80xxHwYrTEZrcFNFUXb/tTkZ8wcn6tTKpS0xeTjAyO rnJNt7KewIhXFdaYSDGNCrXPpPC6DuvbNzoD3e1G+nqPdPsEDotvhJn9KQaQnhFq7Ie074cWR8J nOhS3nF+wQonHYpPT2GhaRRqVFOzI5vIZTIkGTNQ0DXlxpO2
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
 drivers/memory/ti-emif-pm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/ti-emif-pm.c b/drivers/memory/ti-emif-pm.c
index cef0d3beb63b..592f70e9c8e5 100644
--- a/drivers/memory/ti-emif-pm.c
+++ b/drivers/memory/ti-emif-pm.c
@@ -315,15 +315,13 @@ static int ti_emif_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ti_emif_remove(struct platform_device *pdev)
+static void ti_emif_remove(struct platform_device *pdev)
 {
 	struct ti_emif_data *emif_data = emif_instance;
 
 	emif_instance = NULL;
 
 	ti_emif_free_sram(emif_data);
-
-	return 0;
 }
 
 static const struct dev_pm_ops ti_emif_pm_ops = {
@@ -332,7 +330,7 @@ static const struct dev_pm_ops ti_emif_pm_ops = {
 
 static struct platform_driver ti_emif_driver = {
 	.probe = ti_emif_probe,
-	.remove = ti_emif_remove,
+	.remove_new = ti_emif_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = ti_emif_of_match,
-- 
2.42.0



Return-Path: <linux-kernel+bounces-2634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC8A815FC3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF091284CD2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07DE46B9A;
	Sun, 17 Dec 2023 14:30:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6701844C89
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9f-0006ZL-Lm; Sun, 17 Dec 2023 15:30:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9e-00GUhq-U6; Sun, 17 Dec 2023 15:30:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9e-004hzo-Ky; Sun, 17 Dec 2023 15:30:06 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	Santosh Shilimkar <ssantosh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] memory: ti-aemif: Convert to platform remove callback returning void
Date: Sun, 17 Dec 2023 15:29:40 +0100
Message-ID:  <bef01091df036c82a6a6144d3aafd1d7b7be109e.1702822744.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=pyWtWmiwYcg0+6LNzRmjSApIX5L5AKsgQVYFlPzrv+I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfwXVntZp5sOxEOB/5fkXOzLz4JVmjpvWLituw Z1H3E7JdPOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX8F1QAKCRCPgPtYfRL+ ThtuB/9hagkz+RKxDNMHvUqlVsrSIea6Z/3Ptua567Bbsvv/Vm/TW9rnx7r+HP2TtK9PxA+bzZZ 4goIWx5Qec11dH9oFCSVMNlkBiFi910QfVU9ZPk3G774DGlVirfuMCYzu9RgPkqRuVfaaSrq4Be Uf+KUw3YHBNw7gbJCnLtetkBABlrE79c9OT6DRH7ZBJV16it75dcM0Hiz7H9/O+sDzKMAeYEXNk 9pqzSpiGFUDRVgGluK1J+lt99l2Rqu9q++pJn9yi70IZSh3s6ZOFShjKJpaT7X9wx9DEg/PjAvb Zha3UerYfgny7tttBSdN4e7euXHi9YMhv//K/d/SkYJb/e0h
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
 drivers/memory/ti-aemif.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index f81e7df8798a..e192db9e0e4b 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -427,17 +427,16 @@ static int aemif_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int aemif_remove(struct platform_device *pdev)
+static void aemif_remove(struct platform_device *pdev)
 {
 	struct aemif_device *aemif = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(aemif->clk);
-	return 0;
 }
 
 static struct platform_driver aemif_driver = {
 	.probe = aemif_probe,
-	.remove = aemif_remove,
+	.remove_new = aemif_remove,
 	.driver = {
 		.name = "ti-aemif",
 		.of_match_table = of_match_ptr(aemif_of_match),
-- 
2.42.0



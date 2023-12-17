Return-Path: <linux-kernel+bounces-2631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0698815FBC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D8A1F21E6B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F39045BFE;
	Sun, 17 Dec 2023 14:30:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5401444C8C
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9e-0006WA-83; Sun, 17 Dec 2023 15:30:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9d-00GUhZ-Ri; Sun, 17 Dec 2023 15:30:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9d-004hzO-Ic; Sun, 17 Dec 2023 15:30:05 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] memory: renesas-rpc-if: Convert to platform remove callback returning void
Date: Sun, 17 Dec 2023 15:29:35 +0100
Message-ID:  <a7d47700879e10384080b20728aa13ff349fc321.1702822744.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ZMDbiRa3FGTihhO4tO5ODGE29OSsGDt4kVGBu1a2R44=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfwXPj3UhNZgDNyg4+9bkx2WCA2L43Uy2kWkf2 vpluzZRuM2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX8FzwAKCRCPgPtYfRL+ TiKUB/9qljxV2MeMzDUCTbF/CisoK5J7jGBMJKNKmSczc/ZId0wNcKIE/ZII9SiOa0sXgMqooq2 hdXWYXREWg4OuL+Q6yATWPNRJbgu8AcnTbBzxW5mdOnDUVjyH7XYjNdBeoddZQ4pO/c7GDbsJA9 9CXDI67v2k0lSPlOdxGxcw5FHk4jIV45aIdEVvr3YMxoAsM8TkKU8GU5hEyushutaxsNLJybyK5 06XicsJma81Z0Pxc/yJoTw3FJGgjhPQhkJyYpMPnHsEkDeSgQWmeJ+em1rCWYx+ldaoogQ+12FC 6oEs0QakXakB0gOgxA88WgRQdXWMH+NxXbJ/J+AYFLn9x/mv
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
 drivers/memory/renesas-rpc-if.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 9695b2d3ae59..3167826b236a 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -777,13 +777,11 @@ static int rpcif_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rpcif_remove(struct platform_device *pdev)
+static void rpcif_remove(struct platform_device *pdev)
 {
 	struct rpcif_priv *rpc = platform_get_drvdata(pdev);
 
 	platform_device_unregister(rpc->vdev);
-
-	return 0;
 }
 
 static const struct of_device_id rpcif_of_match[] = {
@@ -797,7 +795,7 @@ MODULE_DEVICE_TABLE(of, rpcif_of_match);
 
 static struct platform_driver rpcif_driver = {
 	.probe	= rpcif_probe,
-	.remove	= rpcif_remove,
+	.remove_new = rpcif_remove,
 	.driver = {
 		.name =	"rpc-if",
 		.of_match_table = rpcif_of_match,
-- 
2.42.0



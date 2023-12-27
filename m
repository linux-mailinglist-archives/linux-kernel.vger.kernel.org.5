Return-Path: <linux-kernel+bounces-12270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6906C81F222
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC0EB22D55
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DFB4C3C3;
	Wed, 27 Dec 2023 21:03:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9B34A980
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3M-0000sn-1M; Wed, 27 Dec 2023 22:03:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3J-001wFJ-Uq; Wed, 27 Dec 2023 22:02:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3K-001ZVs-36;
	Wed, 27 Dec 2023 22:02:58 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH 10/12] mailbox: sun6i-msgbox: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 22:02:38 +0100
Message-ID:  <2db7ef94aa35587980697405ec373e0b7bb70466.1703710628.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=N/W8lZej+FeOqTdwnnoNmYqEIad8ynzkdcOjXSzw2ts=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljJDwoMJLjfKm4Cc4/ADr3P0UTr8GXSsZIJG6W H2DM2dIZ4+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYyQ8AAKCRCPgPtYfRL+ TsNlCAC5RWomH9b61vsKXO9seVB+66mp+g78kJnbVAs+m+UWgdssUkxqjQl0IZqc0OlSudVdslX IjnVHkdr/ZzzYZVJVgcTzR4JNZhouUYJDLnKihWTElEo8ye0FJxgHAV9LiHuSoH8NBPRx4vlWOI 1RhV+oIdSY6PtwA5hL6W6T7El2gulfzOCdKPq/q0nawWkBKRj3PEbof8Y5LXTeF+0AV4H/Ip6YR PNVh8GG59D3SPnPZZHLaJYRxWlGwbM/xAJhISVju1WUjnJ7FuoJbXhxMux/7E5dNjCVJ5Dsa2Mr yjFXCkWDvipZ6lhZZsg/qGnz7wXC2tlUUaziuZWURgX0ZjHE
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
 drivers/mailbox/sun6i-msgbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/sun6i-msgbox.c b/drivers/mailbox/sun6i-msgbox.c
index 7f8d931042d3..3dcc54dc83b2 100644
--- a/drivers/mailbox/sun6i-msgbox.c
+++ b/drivers/mailbox/sun6i-msgbox.c
@@ -287,15 +287,13 @@ static int sun6i_msgbox_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sun6i_msgbox_remove(struct platform_device *pdev)
+static void sun6i_msgbox_remove(struct platform_device *pdev)
 {
 	struct sun6i_msgbox *mbox = platform_get_drvdata(pdev);
 
 	mbox_controller_unregister(&mbox->controller);
 	/* See the comment in sun6i_msgbox_probe about the reset line. */
 	clk_disable_unprepare(mbox->clk);
-
-	return 0;
 }
 
 static const struct of_device_id sun6i_msgbox_of_match[] = {
@@ -310,7 +308,7 @@ static struct platform_driver sun6i_msgbox_driver = {
 		.of_match_table = sun6i_msgbox_of_match,
 	},
 	.probe  = sun6i_msgbox_probe,
-	.remove = sun6i_msgbox_remove,
+	.remove_new = sun6i_msgbox_remove,
 };
 module_platform_driver(sun6i_msgbox_driver);
 
-- 
2.43.0



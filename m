Return-Path: <linux-kernel+bounces-22448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD061829DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 470D7B26A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891104D12E;
	Wed, 10 Jan 2024 15:43:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990CD4CB55
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajS-0007JH-A6; Wed, 10 Jan 2024 16:43:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajR-001jUY-4g; Wed, 10 Jan 2024 16:43:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajR-006c4H-0C;
	Wed, 10 Jan 2024 16:43:05 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rob Herring <robh@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jean Delvare <jdelvare@suse.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] macintosh: therm_windtunnel: Convert to platform remove callback returning void
Date: Wed, 10 Jan 2024 16:42:48 +0100
Message-ID:  <74b35a7183dead9cb8359b38356e1a70e720c53e.1704900449.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704900449.git.u.kleine-koenig@pengutronix.de>
References: <cover.1704900449.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=wIMIdTe+K947pJ7HyIvyj/RU52wHIptwgMFUY9QCPbU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlnrr5l0AtXlvqg8+OuSJ+g70r7wMj9tyeZPwiL 4EQGUfHGDCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZZ66+QAKCRCPgPtYfRL+ TtSgB/9nM0q7cqw2P3IaAJfMIWn+HNub1qIM8irQgmtAYZoKYkV59mB1pn5cLYY5yTBoYpZw95y mZiFfHFxG7AGS8Nq7Zj24IosVpvniBmrf/lkglLBMi4ruTzHZIE2XzWLFW2k9Md4nOc5usr9eb5 jmt3DbKLni6966NyStqEWQX7l4CVa/3CVk4pIwSOHyfjg+MEDjUGe7xrq3701MoQEEvVmC+Q9Sj mNA7qCdfIr0vljW6fgkFS74QllLKwPm/69+834WAoqriP1KCp8kcuL0FgQrEXDdEeAR+s6ooTHU yPRPx0O1hP8adVAAMwnhR2FnVyXVlPXycVkzdsiPMQ4vFQDf
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

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/macintosh/therm_windtunnel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 3c1b29476ce2..37cdc6931f6d 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -481,11 +481,9 @@ static int therm_of_probe(struct platform_device *dev)
 	return -ENODEV;
 }
 
-static int
-therm_of_remove( struct platform_device *dev )
+static void therm_of_remove(struct platform_device *dev)
 {
 	i2c_del_driver( &g4fan_driver );
-	return 0;
 }
 
 static const struct of_device_id therm_of_match[] = {{
@@ -501,7 +499,7 @@ static struct platform_driver therm_of_driver = {
 		.of_match_table = therm_of_match,
 	},
 	.probe		= therm_of_probe,
-	.remove		= therm_of_remove,
+	.remove_new	= therm_of_remove,
 };
 
 struct apple_thermal_info {
-- 
2.43.0



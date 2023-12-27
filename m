Return-Path: <linux-kernel+bounces-12129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8FC81F062
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10AA2815D8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D58F4776F;
	Wed, 27 Dec 2023 16:26:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD246433
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWk0-0005AX-5U; Wed, 27 Dec 2023 17:26:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjy-001tZm-LQ; Wed, 27 Dec 2023 17:26:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjz-001WnJ-29;
	Wed, 27 Dec 2023 17:26:43 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] firmware: turris-mox-rwtm: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 17:26:34 +0100
Message-ID:  <9074d1ad2e889425991fecad664781ae27b2418a.1703693980.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2006; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=WEZQXXd5yEntU2Gt+f7/Gkh5GXx5rKG3A+0Dnwst0LE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljFA9qk9zaKQX3LUk4LnI0Bgdn7cRxwonrs9nY Bwreka7G7iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYxQPQAKCRCPgPtYfRL+ TiYRCAChHvmLzvr6zrz7IyRAAX7lZidZ3ESfne2udN3JSW4mLtYdzEQ6YvEhfoWtA0osET5XGJj adYGI/CTr/MJDQAxQ+jkv+BRbPpEN6CCoJ2LuD9B7gL+tfWOhswYSx0i6QQVveeVOOKgo+kwksw gF6e5l1WR/p8iVc7sdSx7mYe6rrTRsgCr7Sk3cU4UrksOY7GZJNhq+4Scz7YrvYwl8qABoCE0c/ 9DeaGLUueTXrSSFQsWrC4IPZVIU+qxZSdAMGf8AAKvrrxwmj3IUwMPMrsXmQhWxkbM55Nz7TNYW dOKmgJ4t1gq2q54Qnwb9gC2QLgcW76fwYFL9l6/JeEvYOJof
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
 drivers/firmware/turris-mox-rwtm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index 2de0fb139ce1..31d962cdd6eb 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -554,7 +554,7 @@ static int turris_mox_rwtm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int turris_mox_rwtm_remove(struct platform_device *pdev)
+static void turris_mox_rwtm_remove(struct platform_device *pdev)
 {
 	struct mox_rwtm *rwtm = platform_get_drvdata(pdev);
 
@@ -562,8 +562,6 @@ static int turris_mox_rwtm_remove(struct platform_device *pdev)
 	sysfs_remove_files(rwtm_to_kobj(rwtm), mox_rwtm_attrs);
 	kobject_put(rwtm_to_kobj(rwtm));
 	mbox_free_channel(rwtm->mbox);
-
-	return 0;
 }
 
 static const struct of_device_id turris_mox_rwtm_match[] = {
@@ -576,7 +574,7 @@ MODULE_DEVICE_TABLE(of, turris_mox_rwtm_match);
 
 static struct platform_driver turris_mox_rwtm_driver = {
 	.probe	= turris_mox_rwtm_probe,
-	.remove	= turris_mox_rwtm_remove,
+	.remove_new = turris_mox_rwtm_remove,
 	.driver	= {
 		.name		= DRIVER_NAME,
 		.of_match_table	= turris_mox_rwtm_match,
-- 
2.43.0



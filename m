Return-Path: <linux-kernel+bounces-12263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257BF81F217
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50BD283E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622EF48CC6;
	Wed, 27 Dec 2023 21:03:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A047F7B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3K-0000qs-Ib; Wed, 27 Dec 2023 22:02:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3J-001wF4-0r; Wed, 27 Dec 2023 22:02:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3K-001ZVc-08;
	Wed, 27 Dec 2023 22:02:58 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 06/12] mailbox: omap: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 22:02:34 +0100
Message-ID:  <466062f1ff1438a22f79260f529a1c2cc233a150.1703710628.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1656; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=j0aEwW5V8+ktwBY7iIhfiCa+CFqdltoLToqYeqCXqXY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljJDsFhgpgYrjS7XbMKMaLE98yrtDfwKEB3n+Q RZes6RQi4GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYyQ7AAKCRCPgPtYfRL+ Thh1B/wPx0HuQZFnGjuuBLvOPrEQwVIO3XWlHql/3OUqpVyaTHqSr9XxEJAM/xYz1+NEPKr0rpb QsPcpQVRd8C6cLnAKwcbsnBkVBxf2w4r+9bNnSPShf1odyY0+oF4Ifz/VwdPQLe7DihdRiaWqQS QtTH85MbKOjcGE/1+Fh/M++/dtBtHGW3aJsUAFHCJZAhwRdJBBSBAT6NYVJHgBuD746NLVnnwZb ifijaU2zEYJBWSnJRlOgEIcA94rNIx7WdUkF4ex72eRJG63SMrovOSgqrgkczx9BxIKSGJRIMKs UmK7PW8zUu2S8TxwerNew41UPZtFCcBY3Lbz26L0uszRl5Ck
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
 drivers/mailbox/omap-mailbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 792bcaebbc9b..c961706fe61d 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -865,19 +865,17 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int omap_mbox_remove(struct platform_device *pdev)
+static void omap_mbox_remove(struct platform_device *pdev)
 {
 	struct omap_mbox_device *mdev = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(mdev->dev);
 	omap_mbox_unregister(mdev);
-
-	return 0;
 }
 
 static struct platform_driver omap_mbox_driver = {
 	.probe	= omap_mbox_probe,
-	.remove	= omap_mbox_remove,
+	.remove_new = omap_mbox_remove,
 	.driver	= {
 		.name = "omap-mailbox",
 		.pm = &omap_mbox_pm_ops,
-- 
2.43.0



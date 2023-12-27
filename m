Return-Path: <linux-kernel+bounces-12125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A7681F05E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6C11C20E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28014644A;
	Wed, 27 Dec 2023 16:26:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D024643A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjz-00059n-UU; Wed, 27 Dec 2023 17:26:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjw-001tZN-S1; Wed, 27 Dec 2023 17:26:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjx-001Wml-2q;
	Wed, 27 Dec 2023 17:26:41 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: kernel@pengutronix.de,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] firmware: arm_scpi: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 17:26:26 +0100
Message-ID:  <e7b4bc389949c3613a358bd8e57d70d7acd5552b.1703693980.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=FF/nyDTSJyTf9/tBea2/MLsCLR8e7FBGnIR1tjwpPwI=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtSeABNWkSWxW+K3Zy7f/dCWS2W3brhfZqL89Gt5ajz3n 5/l2prWyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBEHnGz/48sWTf7KcOmybfe 6BUIBmfaXZRuiGbcW2vINcnP0l/77oLDb7z+TfNinhh9aNmrp32nlbf9CS1b9eLnjSLtPh8jq6K pW+LaUxP5XGsnOU9eumqKqafE/PQnXK7ZmfvmBFapsng1TrmyoCdjDfuziWci8u+uLjzX4PwqsV wnQ85VxDLp5Y76eSvOezcF5ifFVPF1ap7pqJu0+pLRhy0Rx28rK2fJWk6o/v1y1iLuO9XcChqfT px/lipww4XdyNNbwadtHtvdEmmPnVL39vK0WKUlWCVWlK18tq0j+cUcnqCTKY1WtrO+3mFt4yyW iu0PVPBe9DBh39LfF8NqRdtUuDUXTluk2cBntu/aDtlbAA==
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
 drivers/firmware/arm_scpi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 3f123f592cb4..94a6b4e667de 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -863,7 +863,7 @@ static void scpi_free_channels(void *data)
 		mbox_free_channel(info->channels[i].chan);
 }
 
-static int scpi_remove(struct platform_device *pdev)
+static void scpi_remove(struct platform_device *pdev)
 {
 	int i;
 	struct scpi_drvinfo *info = platform_get_drvdata(pdev);
@@ -874,8 +874,6 @@ static int scpi_remove(struct platform_device *pdev)
 		kfree(info->dvfs[i]->opps);
 		kfree(info->dvfs[i]);
 	}
-
-	return 0;
 }
 
 #define MAX_SCPI_XFERS		10
@@ -1048,7 +1046,7 @@ static struct platform_driver scpi_driver = {
 		.dev_groups = versions_groups,
 	},
 	.probe = scpi_probe,
-	.remove = scpi_remove,
+	.remove_new = scpi_remove,
 };
 module_platform_driver(scpi_driver);
 
-- 
2.43.0



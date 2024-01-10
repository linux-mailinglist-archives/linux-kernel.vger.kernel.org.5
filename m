Return-Path: <linux-kernel+bounces-22441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D5E829DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846E11F2782D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BF74C3C2;
	Wed, 10 Jan 2024 15:43:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3A94BA9C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajS-0007Jt-Qq; Wed, 10 Jan 2024 16:43:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajS-001jUv-E5; Wed, 10 Jan 2024 16:43:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajS-006c4p-1B;
	Wed, 10 Jan 2024 16:43:06 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] macintosh: windfarm_rm31: Convert to platform remove callback returning void
Date: Wed, 10 Jan 2024 16:42:54 +0100
Message-ID:  <42358a12b38c9498b8ab2896d4f3d4eb9484b45e.1704900449.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1583; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=SYuS+JG1kCFHVDFFkk6OOKn6/bBKAGVRc6vnNPxCuB8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlnrsALUVJaP9KLzW4W4Q2uqO4g/+z6q6TcsNvc WtfreWrCVOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZZ67AAAKCRCPgPtYfRL+ TuWzB/9UqQD+sv10SjS2Ng0JuRkLQkmcXfn0JSulQ/U3YwO6FsjHeKNGSQielI8xA1GNZrbgg1I Rov5/JCaS42PHL4r8/CfNJMVmS4JyjQaJv+UaqLmQrbgnnce8wRCGEOwee6h2W/Z5JAClMV/FVZ hh4MlNfpO4WI4eOfa+d9oQbIiO2bLKh/9Jf1KDsKIXCdWiUL4+HUM1in6IK8H76kD1cO/Ppzn01 BnFZ4W9SOhIZ2hDogxc7cdLW1l1S8qv3PyK5WASJoVxRI6M78QP+ubTHh52RtSdgLOyXUJ2lDDp TQ+NnBtdlSs/fsreDGlffiw370ZeihOeb9ClesKFHeUT7FrR
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
 drivers/macintosh/windfarm_rm31.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/macintosh/windfarm_rm31.c b/drivers/macintosh/windfarm_rm31.c
index e9eb7fdde48c..dc8f2c7ef103 100644
--- a/drivers/macintosh/windfarm_rm31.c
+++ b/drivers/macintosh/windfarm_rm31.c
@@ -668,17 +668,14 @@ static int wf_rm31_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int wf_rm31_remove(struct platform_device *dev)
+static void wf_rm31_remove(struct platform_device *dev)
 {
 	wf_unregister_client(&rm31_events);
-
-	/* should release all sensors and controls */
-	return 0;
 }
 
 static struct platform_driver wf_rm31_driver = {
 	.probe	= wf_rm31_probe,
-	.remove	= wf_rm31_remove,
+	.remove_new = wf_rm31_remove,
 	.driver	= {
 		.name = "windfarm",
 	},
-- 
2.43.0



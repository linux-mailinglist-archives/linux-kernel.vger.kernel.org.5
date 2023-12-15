Return-Path: <linux-kernel+bounces-1053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB818149D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B011C23C11
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3AA3033B;
	Fri, 15 Dec 2023 13:59:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356842EAF9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iv-0002lY-9F; Fri, 15 Dec 2023 14:59:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iu-00G2ZP-Sd; Fri, 15 Dec 2023 14:59:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iu-003cCE-IY; Fri, 15 Dec 2023 14:59:28 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/18] perf: arm-ccn: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:04 +0100
Message-ID:  <1cae5f0c4693333c91d28a09388bdb8bfcc25d0b.1702648124.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702648124.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702648124.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1666; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=IwQvPM4pMNjqoaU/SqDrjyHMmEbaSTKuNL+vegcPc2I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFupYABrQduygxr1ltHykST+B0mPQoklrnDBG bTOaFpan+WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbqQAKCRCPgPtYfRL+ TuAUB/4/LXliwKSYyXg5BPZr0LBpWT4xzVXi+BVU4gpFMmKpRO1EoCFaXXUB2WJJRvgKrbSDZdF hdaS7h90V4etgGoogeb6a8dOsYtsc0oPGBgsZqyzSYNGvBFFtPcLHRyR9q4buCue+hpq0IqSWRy HTbzLk3XFFyW/EHNi1t6vg2MDqGADWSPePyAEQipWYEuf5gvg9LqYhaOLQssfBOwaEsCcRfhNKj fm2mjdnAeVefrZwEdFgRXok7PFXfVPSm9GXtp43qNpN+6D06GUfJswdfF6VZtt+jrfqL/P/BZ7t pWvs7o77DmyiXM7RgeZ22feiP48fJTidYe8IZC1xarRlole1
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
 drivers/perf/arm-ccn.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 728d13d8e98a..641471bd5eff 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1515,13 +1515,11 @@ static int arm_ccn_probe(struct platform_device *pdev)
 	return arm_ccn_pmu_init(ccn);
 }
 
-static int arm_ccn_remove(struct platform_device *pdev)
+static void arm_ccn_remove(struct platform_device *pdev)
 {
 	struct arm_ccn *ccn = platform_get_drvdata(pdev);
 
 	arm_ccn_pmu_cleanup(ccn);
-
-	return 0;
 }
 
 static const struct of_device_id arm_ccn_match[] = {
@@ -1539,7 +1537,7 @@ static struct platform_driver arm_ccn_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = arm_ccn_probe,
-	.remove = arm_ccn_remove,
+	.remove_new = arm_ccn_remove,
 };
 
 static int __init arm_ccn_init(void)
-- 
2.42.0



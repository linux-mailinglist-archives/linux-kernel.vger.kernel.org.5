Return-Path: <linux-kernel+bounces-1054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114B88149D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0887284584
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A80130346;
	Fri, 15 Dec 2023 13:59:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1CD2D7AA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iv-0002lj-IB; Fri, 15 Dec 2023 14:59:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iv-00G2ZU-5G; Fri, 15 Dec 2023 14:59:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iu-003cCI-SF; Fri, 15 Dec 2023 14:59:28 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/18] perf: arm-cmn: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:05 +0100
Message-ID:  <8698ca612e17292f8a8bbb2d1c0f6be4b2053da7.1702648125.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=rdvhYagiU3f/ZvfHEseZfXcXHLBGbSqUlVpPbtXCZfM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFuqSs0T4Sqze1XzrLbcw0LPpYHBxuClmaojU 0kwcLgxM8KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbqgAKCRCPgPtYfRL+ TmbECACHZbdkhVZnAkBCNBCLANRJrzUadl+dzu25xhZvyB9/uIWNlXBvRnMj5MQG6TjIjSfxmlJ NnqOOaQQjmkzP/LxNGZpA1EBnV5kXk1YowHg8Yp7Kc2D7IyLvIC1CFkGbevgAf/WDbGDh0i0Gg5 j1CIFSo18JIT4KPN11gtwdXaFGrCM9mEIfbqwpGjo3lehyBSooAgYY6xdBSg8JYn8Y5lCaENi/d Gqc90zCWQ6kPHCn0BXILApkXFRXxt+Hl07qJa2So8NP23XUPP0K5oSewtpSGZkwol+pA8CRScXl sKgo4wvu1y2zEKt+al71hbBzKAqMaMT4Sq3J4JqN+D8yNBLS
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
 drivers/perf/arm-cmn.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index c584165b13ba..ac7a953fe902 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2504,7 +2504,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int arm_cmn_remove(struct platform_device *pdev)
+static void arm_cmn_remove(struct platform_device *pdev)
 {
 	struct arm_cmn *cmn = platform_get_drvdata(pdev);
 
@@ -2513,7 +2513,6 @@ static int arm_cmn_remove(struct platform_device *pdev)
 	perf_pmu_unregister(&cmn->pmu);
 	cpuhp_state_remove_instance_nocalls(arm_cmn_hp_state, &cmn->cpuhp_node);
 	debugfs_remove(cmn->debug);
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -2544,7 +2543,7 @@ static struct platform_driver arm_cmn_driver = {
 		.acpi_match_table = ACPI_PTR(arm_cmn_acpi_match),
 	},
 	.probe = arm_cmn_probe,
-	.remove = arm_cmn_remove,
+	.remove_new = arm_cmn_remove,
 };
 
 static int __init arm_cmn_init(void)
-- 
2.42.0



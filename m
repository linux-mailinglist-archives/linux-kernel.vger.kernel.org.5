Return-Path: <linux-kernel+bounces-1061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32748149DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D631C20A42
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91828321BB;
	Fri, 15 Dec 2023 13:59:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32130CFA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iz-0002pb-9k; Fri, 15 Dec 2023 14:59:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iy-00G2aA-R8; Fri, 15 Dec 2023 14:59:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iy-003cD1-Hr; Fri, 15 Dec 2023 14:59:32 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/18] perf: marvell_cn10k_tad: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:15 +0100
Message-ID:  <055656e474208b0fb583e249530fa211fa3be57c.1702648125.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=I1t5aJb11RWvKIbnkVtIejhEjKmdBG1m6FZj4F8ZzMY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFu2lEYp/dB1CWftEjB+6ZuPTaGjyNucTK5gu xt4aJPN/KOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbtgAKCRCPgPtYfRL+ TuDdB/kBymw7MNfXHM14jMTwT9lo4YG/rKEingqeCW6Fo0lo6/bvV3CO0nPSK2ER6RKINJQ1Br/ Fqk/85IWBL/L+MJNehclZ9NelvYivNs03ii3VXli7l/4gGJC9De3FGL6hOyAAEl9VGDJg38l9U8 LUEL0JuVui6u5eYK96P+kSHlr6N9jaajO1A4A3TEM2RwkFbyouqCMCMGxOs+UmD8o1gR8GxpBaE XKeeICZ0eW3hqicJKgJSTULFpSPR4xal0MI/wX6VwCcrtXtqL9nLWyGNlM9kKHV9FMgIqMkXA2N eSh5kMww8MrmaEbCsE8bouGhT7atXwxJAJtUPBjYlqN7n8vR
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
 drivers/perf/marvell_cn10k_tad_pmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index fec8e82edb95..9e635f355470 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -351,15 +351,13 @@ static int tad_pmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tad_pmu_remove(struct platform_device *pdev)
+static void tad_pmu_remove(struct platform_device *pdev)
 {
 	struct tad_pmu *pmu = platform_get_drvdata(pdev);
 
 	cpuhp_state_remove_instance_nocalls(tad_pmu_cpuhp_state,
 						&pmu->node);
 	perf_pmu_unregister(&pmu->pmu);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -385,7 +383,7 @@ static struct platform_driver tad_pmu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe          = tad_pmu_probe,
-	.remove         = tad_pmu_remove,
+	.remove_new     = tad_pmu_remove,
 };
 
 static int tad_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
-- 
2.42.0



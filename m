Return-Path: <linux-kernel+bounces-1062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3E38149DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1631F24BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51C134CFD;
	Fri, 15 Dec 2023 13:59:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0FA31A6B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iz-0002qw-Ub; Fri, 15 Dec 2023 14:59:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iz-00G2aI-Gx; Fri, 15 Dec 2023 14:59:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iz-003cD9-6r; Fri, 15 Dec 2023 14:59:33 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/18] perf: thunderx2: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:17 +0100
Message-ID:  <7be677dfa13d3a7eab6eef0d808ba8a9855d14ae.1702648125.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=kNhz4owPoQxf/kqUCq0mPTfNfI890r9XsLm626uuoYo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFu4yiKFxvFEDp7JBUolIF9D0qBewRZ/dqBFl N4dGfN9J02JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbuAAKCRCPgPtYfRL+ TjaVB/wJVTyeqszuwR2rKLeyZ3db/apOK5yre94HQmLHVYCicO6VGSUcOl3xfZpe+DKWfaYvLCw 61Gc9lVkghr+qS2zMAqbfMp3vsZtTjIQcHVec7gfyFElV6Vtjwa37+KFimzRjZ7x3/OBzjFc9VH Jjv/kmaoskI+QTs+nOI8n2y9K4eA6buyPZtFlVprsNb5FtgZAjlM34qbZ8UuDBtuJhwQe9WQ1a3 Mbt6pPyJ3AC1zFWG4gzrCRAF0XsBSslW7lQXJR4guhyRPUYQFVQqYIlLx37pUu239v1MPzDB+xu hxYC8OSd3h603cGm3l2hnC+rjDDhJCXlXy4qP9Skhb6Vp7HM
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
 drivers/perf/thunderx2_pmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 1edb9c03704f..e16d10c763de 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -993,7 +993,7 @@ static int tx2_uncore_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tx2_uncore_remove(struct platform_device *pdev)
+static void tx2_uncore_remove(struct platform_device *pdev)
 {
 	struct tx2_uncore_pmu *tx2_pmu, *temp;
 	struct device *dev = &pdev->dev;
@@ -1009,7 +1009,6 @@ static int tx2_uncore_remove(struct platform_device *pdev)
 			}
 		}
 	}
-	return 0;
 }
 
 static struct platform_driver tx2_uncore_driver = {
@@ -1019,7 +1018,7 @@ static struct platform_driver tx2_uncore_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = tx2_uncore_probe,
-	.remove = tx2_uncore_remove,
+	.remove_new = tx2_uncore_remove,
 };
 
 static int __init tx2_uncore_driver_init(void)
-- 
2.42.0



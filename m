Return-Path: <linux-kernel+bounces-22444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BB2829DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB611C22AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B114C63D;
	Wed, 10 Jan 2024 15:43:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3673EA80
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajS-0007JL-EX; Wed, 10 Jan 2024 16:43:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajS-001jUk-1Y; Wed, 10 Jan 2024 16:43:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajR-006c4X-38;
	Wed, 10 Jan 2024 16:43:05 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] macintosh: windfarm_pm81: Convert to platform remove callback returning void
Date: Wed, 10 Jan 2024 16:42:52 +0100
Message-ID:  <725a17c7fb1bbe6d827b38bbee40494aebf9c06d.1704900449.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=JIumVAh3vPYREF//u7bkB7EN6JDIcq7JQV0/55+tgig=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlnrr9cGJf6iwan3BelkYvjxz1rORpYhL3KQpVA H9WZZ5TI1WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZZ66/QAKCRCPgPtYfRL+ TriLB/wMDX8j2YkG3CwhSFKfGseVipaO6qkUR7ahpC0Up2CnkrqOwZAobIsf3dw0Y/01I0ZNjtc 8+8LchW5znSHRLxrlQBxaCoeN1dKsRNtzRRkf+vHnAQ53cG9J3OLv7hBL1J+2WtgT6nrZ8VjLqX U1RKwAMSzpK1UzOZs1BUrfpXhNQNigflasKZUFYTfDP/uHGRtATepZ/SNqMKG0XZ9kSbVVrDEcj uNzXxdWCArERgcm9ufu+623M897Wzo6B46xttPUtXAdDQ/PsS2x6iITCaoSlbxFiffqIswxbLyE 0BzKDEr3DmmT0xNnzNC2zLxFrOt+ZszHMFOat94qUpmNvHGT
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
 drivers/macintosh/windfarm_pm81.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/macintosh/windfarm_pm81.c b/drivers/macintosh/windfarm_pm81.c
index 257fb2c695c5..404d2454e33d 100644
--- a/drivers/macintosh/windfarm_pm81.c
+++ b/drivers/macintosh/windfarm_pm81.c
@@ -724,7 +724,7 @@ static int wf_smu_probe(struct platform_device *ddev)
 	return 0;
 }
 
-static int wf_smu_remove(struct platform_device *ddev)
+static void wf_smu_remove(struct platform_device *ddev)
 {
 	wf_unregister_client(&wf_smu_events);
 
@@ -761,13 +761,11 @@ static int wf_smu_remove(struct platform_device *ddev)
 	/* Destroy control loops state structures */
 	kfree(wf_smu_sys_fans);
 	kfree(wf_smu_cpu_fans);
-
-	return 0;
 }
 
 static struct platform_driver wf_smu_driver = {
-        .probe = wf_smu_probe,
-        .remove = wf_smu_remove,
+	.probe = wf_smu_probe,
+	.remove_new = wf_smu_remove,
 	.driver = {
 		.name = "windfarm",
 	},
-- 
2.43.0



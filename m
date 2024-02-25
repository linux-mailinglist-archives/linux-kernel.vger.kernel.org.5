Return-Path: <linux-kernel+bounces-80173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B784862B53
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A0AB2150B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688A917BC2;
	Sun, 25 Feb 2024 15:55:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668AC1758E
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876517; cv=none; b=ql227V1h+sH+YeW/qP/PW+7FXaZQa2Z5bpgMveyXeJ02uM2TazyVhS1JkVqQCKw0lMT0V2sgUorVPRqztjgLn9HP921vNgkxQKwFHr1zKvIuD1OGEpYwxSeTOVsaDZhxSd1xmyEk+CMABj4JCEIq/8oYv5Xf4JpgCO6dSERQVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876517; c=relaxed/simple;
	bh=q+5lGv+CKGW/vgJ013raQ6VcEpihEHl9f/PMadC+rN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XY1TixsjPVNYpZM8mKgyZ2CH6ib90OFeNQIghDGXVoSUOSscwF0kyDMN+WIdqC8Occ8ly1LRHa+syjgeLu+02nwR82tvBa9VZVxFT6o/+f2eooWju4yjygSTMJFHm8zLRNS6fKCtCCVLpv/C41Le44qbXGjkpzQv3E3eR6cesfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqO-00007l-Eg; Sun, 25 Feb 2024 16:55:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqO-002pKZ-24; Sun, 25 Feb 2024 16:55:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqN-00BKpG-3A;
	Sun, 25 Feb 2024 16:55:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [PATCH 7/7] extcon: usbc-cros-ec: Convert to platform remove callback returning void
Date: Sun, 25 Feb 2024 16:54:56 +0100
Message-ID:  <52d0a4317d5372f1135259d4fbbd2822b86ba8f4.1708876186.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708876186.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708876186.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1824; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=q+5lGv+CKGW/vgJ013raQ6VcEpihEHl9f/PMadC+rN8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl22LZ3uO4RQqSPB/2QbpCE/x0dS6kjv67OLUSv pq1ABfA1G+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdti2QAKCRCPgPtYfRL+ TquvB/9P8u6y27a0w8JYAlfpqznfMd7dIhS8bQPSCN/utYqWefewC0vIyEDp3oFaNlc+NLSPzfn InnksNkubr4nIbAvoYaH7iou7PS7DBjDsC5+xcfUjlwra4UxKO6p1hcSI4m0FRZ+jZ/CgWeypPN MqRwFPuC347v0qSbkvYT8XIT1t0eVXO1huoj8qzNLpAeK0f1FgGlpDszrsbQbjtrypYAir04Es/ 7c7KMYRRvYOKsM2t4DyH+aDr5VEEZtpbBFgm8Wsvc5AVVEylpo5rtzfGq3CML3VVXQj+C0VozJl eRvQ3cV0VQCfZs6Gg1j7o37FtpCEDz3mEzLVs91CsNM75GyK
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
 drivers/extcon/extcon-usbc-cros-ec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-usbc-cros-ec.c b/drivers/extcon/extcon-usbc-cros-ec.c
index fde1db62be0d..805a47230689 100644
--- a/drivers/extcon/extcon-usbc-cros-ec.c
+++ b/drivers/extcon/extcon-usbc-cros-ec.c
@@ -480,14 +480,12 @@ static int extcon_cros_ec_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int extcon_cros_ec_remove(struct platform_device *pdev)
+static void extcon_cros_ec_remove(struct platform_device *pdev)
 {
 	struct cros_ec_extcon_info *info = platform_get_drvdata(pdev);
 
 	blocking_notifier_chain_unregister(&info->ec->event_notifier,
 					   &info->notifier);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -531,7 +529,7 @@ static struct platform_driver extcon_cros_ec_driver = {
 		.of_match_table = of_match_ptr(extcon_cros_ec_of_match),
 		.pm = DEV_PM_OPS,
 	},
-	.remove  = extcon_cros_ec_remove,
+	.remove_new = extcon_cros_ec_remove,
 	.probe   = extcon_cros_ec_probe,
 };
 
-- 
2.43.0



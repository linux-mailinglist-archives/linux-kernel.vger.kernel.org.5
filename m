Return-Path: <linux-kernel+bounces-80175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02486862B56
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ED85B21C42
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571231B7E7;
	Sun, 25 Feb 2024 15:55:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C4417BA0
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876519; cv=none; b=Fy6jMAflEDVo4CnFc8qYMxiJOP+lpF8ObVNH7F94UmKAZynmG7cKWen1nk++VC8ygPZSChxumDwWuNpGHUZpMDzMyayfz5jhDzi+4zdKGbTPEn2NW5wm2PVwsbFmPEyGOqA+U3HW70vEcKH2vg9ywOayaF5KJ7eh+H6QH6Ey+jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876519; c=relaxed/simple;
	bh=lNC/jkKjyMMhL1AbItdI166xPrl21UQXTGooYKkG08A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwLi3Tr8BN+Mi6nLTvMeLW9rPMQzJReNq1bP0CJuhLUVvX/G9lWlmIRyKk6Q4FcDqOnUa2W9qQhKq2gCE2sSUlKBK2HrQdMOVKp9CNXtJaOcpmvpXi2HTkxsT4h4AY+e3WzRHjozUqtxHfXcHs9MpTKPLTKxgadkGatp4OP+SwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqN-00006n-PY; Sun, 25 Feb 2024 16:55:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqN-002pKL-Cu; Sun, 25 Feb 2024 16:55:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqN-00BKp4-11;
	Sun, 25 Feb 2024 16:55:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] extcon: max3355: Convert to platform remove callback returning void
Date: Sun, 25 Feb 2024 16:54:53 +0100
Message-ID:  <2c017ea490f721646bd472e7d427eb377e4e8423.1708876186.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=lNC/jkKjyMMhL1AbItdI166xPrl21UQXTGooYKkG08A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl22LTLyXXIKJjBKLJgy5ASgg+jYNeJfflvaKsJ 8fauJJcUX2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdti0wAKCRCPgPtYfRL+ TiSuB/43VdydmkpZlhwkU5iMQ1XZ2Ybo9gVzHvRx27qpTLrBXC+Q3AwEnoGWeaD3fAZiire+clr pCfFqlcu2/uacxE00cShaW/Y2bvGacOgEFYHEz5SNBi2wVnDfOi4K+xKomgKk1E09LYFkO9HQ6c 2J9FQu2E6p3EXMux/IB1lXPzwg81Al4K/NeRbZ/p6UM+hhF/QqmbNtE+sBWSGQ/1HqOmC4Am8GH J+JFa6ZQiJBlTLRLbVVNvqbUhay09OEOm4+7gI7jy9ZKlst7LxpVMVxjCzvyg4ob4wfIBi4GN8r RnLrcxjYg+oTMCW1R7mP6WhNhUECZcV3eWp3JIZ21Z4i+cC+
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
 drivers/extcon/extcon-max3355.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-max3355.c b/drivers/extcon/extcon-max3355.c
index d7795607f693..e62ce7a8d131 100644
--- a/drivers/extcon/extcon-max3355.c
+++ b/drivers/extcon/extcon-max3355.c
@@ -112,13 +112,11 @@ static int max3355_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int max3355_remove(struct platform_device *pdev)
+static void max3355_remove(struct platform_device *pdev)
 {
 	struct max3355_data *data = platform_get_drvdata(pdev);
 
 	gpiod_set_value_cansleep(data->shdn_gpiod, 0);
-
-	return 0;
 }
 
 static const struct of_device_id max3355_match_table[] = {
@@ -129,7 +127,7 @@ MODULE_DEVICE_TABLE(of, max3355_match_table);
 
 static struct platform_driver max3355_driver = {
 	.probe		= max3355_probe,
-	.remove		= max3355_remove,
+	.remove_new	= max3355_remove,
 	.driver		= {
 		.name	= "extcon-max3355",
 		.of_match_table = max3355_match_table,
-- 
2.43.0



Return-Path: <linux-kernel+bounces-80177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC63E862B58
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616481F212D9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D201B978;
	Sun, 25 Feb 2024 15:55:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD9717997
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876521; cv=none; b=IaxvO/8nWDOCYXyJGMm15y4Nnmpz0Mw9ZHHqfhd8RDmZiWJ7IhegVbCL1ZWMCx2zUileLhd2ZbE8hPARPzeQZ4usMdxRbQukxBrCrCLQvZxvpqqDXwESf3BKwL+Sy8flnbS6v3DOTihApHtaeaHRTSpk2xMoSD2BwbXcPqEHx3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876521; c=relaxed/simple;
	bh=5+wahzvFXfhwoK5/hkP6C6S5OwJLhfKiDIIXZS94iYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iB1fpWhWqy8jt6c/bh16N54RJhksENRyDj5njYCYTLLA5w2v/Twi1GyGIC9gwS8DVFN9HrIoInIR7Dwf8H8WJ7g4PypBrgxBlusRY8gblQC7DTkeUwAvVkdvsKxHl4NGHaQPgRf0ObcVsnt8jbh37GDLc/JyFaAzrm8D4jLfYW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqN-00006X-JG; Sun, 25 Feb 2024 16:55:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqN-002pKI-6t; Sun, 25 Feb 2024 16:55:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqN-00BKp0-0Q;
	Sun, 25 Feb 2024 16:55:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] extcon: intel-mrfld: Convert to platform remove callback returning void
Date: Sun, 25 Feb 2024 16:54:52 +0100
Message-ID:  <7223e19152980ef553e38cf56c2b38ec099586e0.1708876186.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=5+wahzvFXfhwoK5/hkP6C6S5OwJLhfKiDIIXZS94iYw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl22LSLGDOjpPuxr+z7CQx4Bvbn37MIxmaywS2U dYAYcl0MYiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdti0gAKCRCPgPtYfRL+ Tn5/B/4rOhT3SHhaYmtgKfbUM/p0qA2T8Fzmpu6xn4TU5jD7v6q4SVFOhYEPZeU/2i0H6UyNSAy coZ5VpGrW+qb/DN7pQldGOXzfkKSM8sdp6eYFyiuqcXRl6mTMLRC2+iE6oFWzArzjK+JhjPLagh qIz58FSFUGLcHFO+tfdUigmMulXZQxiBgDT4Dqaw9mUeX3lGRg0lGxx+vH1JsiLivBX4fYqS2ba mQxiEtalvmZxs+o3ug2i6etVl/rJZHQabHkfpCiwV0nL9RH1/9qT5pXjpsGbTDTuuHsdv9SwwNL 1U7q+gubiZFKoIioHsN2FNUzO6D2oi6zbdLLqjJ8TZy0b4h+
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
 drivers/extcon/extcon-intel-mrfld.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-intel-mrfld.c b/drivers/extcon/extcon-intel-mrfld.c
index e96947fb76ee..12a041a58578 100644
--- a/drivers/extcon/extcon-intel-mrfld.c
+++ b/drivers/extcon/extcon-intel-mrfld.c
@@ -257,13 +257,11 @@ static int mrfld_extcon_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mrfld_extcon_remove(struct platform_device *pdev)
+static void mrfld_extcon_remove(struct platform_device *pdev)
 {
 	struct mrfld_extcon_data *data = platform_get_drvdata(pdev);
 
 	mrfld_extcon_sw_control(data, false);
-
-	return 0;
 }
 
 static const struct platform_device_id mrfld_extcon_id_table[] = {
@@ -277,7 +275,7 @@ static struct platform_driver mrfld_extcon_driver = {
 		.name	= "mrfld_bcove_pwrsrc",
 	},
 	.probe		= mrfld_extcon_probe,
-	.remove		= mrfld_extcon_remove,
+	.remove_new	= mrfld_extcon_remove,
 	.id_table	= mrfld_extcon_id_table,
 };
 module_platform_driver(mrfld_extcon_driver);
-- 
2.43.0



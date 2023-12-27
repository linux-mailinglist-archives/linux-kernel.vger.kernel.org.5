Return-Path: <linux-kernel+bounces-12132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A76481F067
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA561C219A6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D0A481DB;
	Wed, 27 Dec 2023 16:26:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F954777B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjz-00059o-7m; Wed, 27 Dec 2023 17:26:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjx-001tZQ-34; Wed, 27 Dec 2023 17:26:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjy-001Wmp-0L;
	Wed, 27 Dec 2023 17:26:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: kernel@pengutronix.de,
	Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] firmware: coreboot_table: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 17:26:27 +0100
Message-ID:  <d323e4f24bfab3ac1480933deb51e7c5cb025b09.1703693980.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1801; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=KkJyKFS1tf/Q7uVpfdVoCv0nkB+vzLTFnmTd3unQUCU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljFA137qRFmgFH2CW2v85lYu8zAPejn58AHqK2 y66+PpOHTKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYxQNQAKCRCPgPtYfRL+ TqVtB/48BvW7i2SaSdpDvOEONys5ylT5SBQ0NFtzPMFYUto6wdGN1kkOlGP/CeHhN4+hi0wKzpY aei8fq67PrCMzLM+Z/QsZ95Su0qZnirumRVS5R1ub5V1tt/vzKZMiYDbsz0UAMg6tL4XgGTBhDV urNBX6t1EoZ0Ged/KE/7W1wI2GElYzzIgZ7ZEs6ecrhEH27d0gNxIfePA+hbyIL1P0gY7Xpe0GB GOVrnpTqwE7HXXXOQKWoZUbhrsd24TQYUx1D1aOf/BNFPd1LrPRYIe+NGAby2749jgXqPrx34jN BRHOGnBtxPJntg/feNHo2HmP9cjZInR7u39XBs5Y14wZs0EM
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
 drivers/firmware/google/coreboot_table.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 33ae94745aef..2a4469bf1b81 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -176,10 +176,9 @@ static int __cb_dev_unregister(struct device *dev, void *dummy)
 	return 0;
 }
 
-static int coreboot_table_remove(struct platform_device *pdev)
+static void coreboot_table_remove(struct platform_device *pdev)
 {
 	bus_for_each_dev(&coreboot_bus_type, NULL, NULL, __cb_dev_unregister);
-	return 0;
 }
 
 #ifdef CONFIG_ACPI
@@ -201,7 +200,7 @@ MODULE_DEVICE_TABLE(of, coreboot_of_match);
 
 static struct platform_driver coreboot_table_driver = {
 	.probe = coreboot_table_probe,
-	.remove = coreboot_table_remove,
+	.remove_new = coreboot_table_remove,
 	.driver = {
 		.name = "coreboot_table",
 		.acpi_match_table = ACPI_PTR(cros_coreboot_acpi_match),
-- 
2.43.0



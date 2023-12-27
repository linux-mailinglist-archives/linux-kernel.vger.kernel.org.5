Return-Path: <linux-kernel+bounces-12134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FF281F069
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8272728217B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE1C48CE1;
	Wed, 27 Dec 2023 16:27:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB448CD9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWk0-0005Bf-PT; Wed, 27 Dec 2023 17:26:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjy-001tZq-Se; Wed, 27 Dec 2023 17:26:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjz-001WnN-2r;
	Wed, 27 Dec 2023 17:26:43 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michal Simek <michal.simek@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nava kishore Manne <nava.kishore.manne@amd.com>,
	Rajan Vaja <rajan.vaja@xilinx.com>,
	Rob Herring <robh@kernel.org>,
	Dhaval Shah <dhaval.r.shah@amd.com>,
	Marek Vasut <marex@denx.de>
Cc: kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] firmware: zynqmp: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 17:26:35 +0100
Message-ID:  <b5a82472a6d61608c2cd7728ca364f6c88a821c3.1703693980.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1949; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=5lA5AskgyOWj5RlJyQL/1YZMBAmaOueb91fZw7g7wBk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljFA+SOL/OLAdfMhQjjJrd6i8QwhOba6xFIvvF 9XxF7gr7VqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYxQPgAKCRCPgPtYfRL+ Tr/0B/43t00D3aB2EI/DNiEEuY+18Axew5V9CICgtxrn/vfQ8Yk5ViKo9PuE1Ee5VBjRwbh0bpP JYG7GNO2F7JcSXMEOEgxIs17hku48vv+Qabv4ho0F1TtgwWiOWxaX2n6yTt8FkbKXykKoV8nEW6 vSR53TvZNvtyIpP59/0KAIs7//PMmtpBfP37i+0JUmDvIH1ypp0rlDDZH+tP9Zjg5kwnv0QCtH/ YoBdzx7xDa5QfcjvFmYVuedqXmDX8n1ratrsNABJKYmaVbMnFIO9qWZiZVc7Xollxdmk9JFHXzi M1F+jOJ8BFTCXyiVfelpt9t0eIk7Gcb4yU+IDf4MHG7rR3+N
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
 drivers/firmware/xilinx/zynqmp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index a55dfd9bae6b..73cae6ef83ec 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1929,7 +1929,7 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
-static int zynqmp_firmware_remove(struct platform_device *pdev)
+static void zynqmp_firmware_remove(struct platform_device *pdev)
 {
 	struct pm_api_feature_data *feature_data;
 	struct hlist_node *tmp;
@@ -1944,8 +1944,6 @@ static int zynqmp_firmware_remove(struct platform_device *pdev)
 	}
 
 	platform_device_unregister(em_dev);
-
-	return 0;
 }
 
 static const struct of_device_id zynqmp_firmware_of_match[] = {
@@ -1962,6 +1960,6 @@ static struct platform_driver zynqmp_firmware_driver = {
 		.dev_groups = zynqmp_firmware_groups,
 	},
 	.probe = zynqmp_firmware_probe,
-	.remove = zynqmp_firmware_remove,
+	.remove_new = zynqmp_firmware_remove,
 };
 module_platform_driver(zynqmp_firmware_driver);
-- 
2.43.0



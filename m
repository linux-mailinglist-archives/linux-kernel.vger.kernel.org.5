Return-Path: <linux-kernel+bounces-2785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6DF8161CA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3592B21A92
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3437487B9;
	Sun, 17 Dec 2023 19:31:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F4A481A8
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEwrh-0007H4-9b; Sun, 17 Dec 2023 20:31:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEwrg-00GXTq-Sp; Sun, 17 Dec 2023 20:31:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEwrg-004owZ-Jj; Sun, 17 Dec 2023 20:31:52 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] memory: emif: Drop usage of platform_driver_probe()
Date: Sun, 17 Dec 2023 20:31:33 +0100
Message-ID:  <af2931bbb536349a1f9ca637b5aa1094bc354dcc.1702829744.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702829744.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702829744.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4433; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=prMBQ2hUCtXqI31SUwr+YXxg/mNN8P06lT4SD94pU6Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlf0yYc5fPWSiK6VDZRTJfH4m+kxn7+7FcHt0ME LDhaHvRpGeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX9MmAAKCRCPgPtYfRL+ Tm+pB/4lbsjs55REpb7bJZRLG0pPcPE2zk0CeG2sMCR9za6KJzAGC7NtTR2Qvx0FdlBewfLEfxP wgUvxVVYjtGm07zqCLsobijBYxQFu4uSrwRVJCnQqA65frfiI90peK2VDkXWY9red6AwEoT7rNj Me/7erQ111NeAva0+VTE/vv5j3SBVV3a14c1dOz5Za2zgSvwzMt68OVYL//z67mTm2bN4BQCX1n raGrCTfJ1101R1AtDNL0t3SbsZjzH6srwIlybzTr5biu2n98Ed8hsDXOhoC49+v9mdNfxFaD4Sa NVlNF/BtjQyP/jtIlN0bR/Wm0/BELi4UiYXxUuUCcoEVBEii
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

There are considerations to drop platform_driver_probe() as a concept
that isn't relevant any more today. It comes with an added complexity
that makes many users hold it wrong. (E.g. this driver should have
better used __init instead of __init_or_module to mark functions only
relevant to .probe() and mark the driver struct with __refdata.)

This fixes a W=1 build warning:

	WARNING: modpost: drivers/memory/emif: section mismatch in reference: emif_driver+0x4 (section: .data) -> emif_remove (section: .exit.text)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/memory/emif.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 5a3194b9b3bc..84973d7133f4 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -139,7 +139,7 @@ static int emif_mr4_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(emif_mr4);
 
-static void __init_or_module emif_debugfs_init(struct emif_data *emif)
+static void emif_debugfs_init(struct emif_data *emif)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		emif->debugfs_root = debugfs_create_dir(dev_name(emif->dev), NULL);
@@ -150,7 +150,7 @@ static void __init_or_module emif_debugfs_init(struct emif_data *emif)
 	}
 }
 
-static void __exit emif_debugfs_exit(struct emif_data *emif)
+static void emif_debugfs_exit(struct emif_data *emif)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		debugfs_remove_recursive(emif->debugfs_root);
@@ -671,7 +671,7 @@ static void disable_and_clear_all_interrupts(struct emif_data *emif)
 	clear_all_interrupts(emif);
 }
 
-static int __init_or_module setup_interrupts(struct emif_data *emif, u32 irq)
+static int setup_interrupts(struct emif_data *emif, u32 irq)
 {
 	u32		interrupts, type;
 	void __iomem	*base = emif->base;
@@ -702,7 +702,7 @@ static int __init_or_module setup_interrupts(struct emif_data *emif, u32 irq)
 
 }
 
-static void __init_or_module emif_onetime_settings(struct emif_data *emif)
+static void emif_onetime_settings(struct emif_data *emif)
 {
 	u32				pwr_mgmt_ctrl, zq, temp_alert_cfg;
 	void __iomem			*base = emif->base;
@@ -826,7 +826,7 @@ static int is_custom_config_valid(struct emif_custom_configs *cust_cfgs,
 	return valid;
 }
 
-static void __init_or_module of_get_custom_configs(struct device_node *np_emif,
+static void of_get_custom_configs(struct device_node *np_emif,
 		struct emif_data *emif)
 {
 	struct emif_custom_configs	*cust_cfgs = NULL;
@@ -875,7 +875,7 @@ static void __init_or_module of_get_custom_configs(struct device_node *np_emif,
 	emif->plat_data->custom_configs = cust_cfgs;
 }
 
-static void __init_or_module of_get_ddr_info(struct device_node *np_emif,
+static void of_get_ddr_info(struct device_node *np_emif,
 		struct device_node *np_ddr,
 		struct ddr_device_info *dev_info)
 {
@@ -909,7 +909,7 @@ static void __init_or_module of_get_ddr_info(struct device_node *np_emif,
 		dev_info->io_width = __fls(io_width) - 1;
 }
 
-static struct emif_data * __init_or_module of_get_memory_device_details(
+static struct emif_data *of_get_memory_device_details(
 		struct device_node *np_emif, struct device *dev)
 {
 	struct emif_data		*emif = NULL;
@@ -1086,7 +1086,7 @@ static struct emif_data *__init_or_module get_device_details(
 	return NULL;
 }
 
-static int __init_or_module emif_probe(struct platform_device *pdev)
+static int emif_probe(struct platform_device *pdev)
 {
 	struct emif_data	*emif;
 	int			irq, ret;
@@ -1141,7 +1141,7 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
 	return -ENODEV;
 }
 
-static int __exit emif_remove(struct platform_device *pdev)
+static int emif_remove(struct platform_device *pdev)
 {
 	struct emif_data *emif = platform_get_drvdata(pdev);
 
@@ -1167,7 +1167,8 @@ MODULE_DEVICE_TABLE(of, emif_of_match);
 #endif
 
 static struct platform_driver emif_driver = {
-	.remove		= __exit_p(emif_remove),
+	.probe		= emif_probe,
+	.remove		= emif_remove,
 	.shutdown	= emif_shutdown,
 	.driver = {
 		.name = "emif",
@@ -1175,7 +1176,7 @@ static struct platform_driver emif_driver = {
 	},
 };
 
-module_platform_driver_probe(emif_driver, emif_probe);
+module_platform_driver(emif_driver);
 
 MODULE_DESCRIPTION("TI EMIF SDRAM Controller Driver");
 MODULE_LICENSE("GPL");
-- 
2.42.0



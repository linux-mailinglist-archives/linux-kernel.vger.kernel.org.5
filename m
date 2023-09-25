Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D827AD4E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjIYJzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIYJzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:55:46 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CD2CE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJW-0007nL-IL; Mon, 25 Sep 2023 11:55:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJV-008pz8-Lt; Mon, 25 Sep 2023 11:55:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJV-004dkw-Cg; Mon, 25 Sep 2023 11:55:37 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 09/40] soc/hisilicon: kunpeng_hccs: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:00 +0200
Message-Id: <20230925095532.1984344-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1787; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ply7/qctArKFDggIXfdSLlnu/GsdOcRz3LcmV8XoP6g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhK684tGxb/mAjBX0IdDbHleZ0yNFtJqs02u 9jfVpu77X6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYSgAKCRCPgPtYfRL+ TtAMB/9nctyFm3rLBo6SLcMnVXPeyBYuK/vaBuiIMyy2tRBYKlzn8cGBgkLdM2PWsGPDJMz8z9W q+uwVFYpbfrxNts67D2NOAA4wKbfFGwBAKFWO+nD7+SXC3NDuyQtxhNuSPAt/KBNaZ/FuvBtkQw 955873tg+0hatk5SIQsbUU1By2XxSeXYc/Ugs3Lk6VcHNfy7V4tJ+bJeGaSxlt9J69T9/umK6Vb n3DgPRUdlXW+AvCT/AOYjiO0gGW8FTQJ7YAeg0/GjkOnLzyVbQx7Pbx8iUHNkSrWU8f7xWFuiki i5T1kKXUF62XZhhB0Qxiu7y4AGxgxR6UarsLdDVBjOIYvZIM
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index f3810d9d1caa..01aec0df98ec 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -1244,14 +1244,12 @@ static int hccs_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int hccs_remove(struct platform_device *pdev)
+static void hccs_remove(struct platform_device *pdev)
 {
 	struct hccs_dev *hdev = platform_get_drvdata(pdev);
 
 	hccs_remove_topo_dirs(hdev);
 	hccs_unregister_pcc_channel(hdev);
-
-	return 0;
 }
 
 static const struct acpi_device_id hccs_acpi_match[] = {
@@ -1262,7 +1260,7 @@ MODULE_DEVICE_TABLE(acpi, hccs_acpi_match);
 
 static struct platform_driver hccs_driver = {
 	.probe = hccs_probe,
-	.remove = hccs_remove,
+	.remove_new = hccs_remove,
 	.driver = {
 		.name = "kunpeng_hccs",
 		.acpi_match_table = hccs_acpi_match,
-- 
2.40.1


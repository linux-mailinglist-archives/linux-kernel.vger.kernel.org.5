Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8467E0BE7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377252AbjKCXAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjKCXAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:00:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002B118B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:00:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qz398-0001mn-Rt; Sat, 04 Nov 2023 00:00:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qz398-006QIE-5v; Sat, 04 Nov 2023 00:00:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qz397-00Cfjv-Sj; Sat, 04 Nov 2023 00:00:09 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/2] bus: fsl-mc:  Drop if block with always false condition
Date:   Sat,  4 Nov 2023 00:00:02 +0100
Message-ID: <20231103230001.3652259-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=cV8SR9+e1pN98X9OciDQA6uUZrvZUrW5fK8gTZABZlk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlRXtypbwtUMpc2Hzdu6C986lYDTFJW/fCBYzRu q9PXCC/Ac6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUV7cgAKCRCPgPtYfRL+ TsqQCACluSwWQ1d5t2IR2O+leoOjQLawHZw2/8n+YeybUkRqlQvdZJ0U1PjVB+mCYLwbeTMmekp QDqhgv3Pz2uarINsHUkKL0sc5krHEHDL91ock0T6yvHuj17Ow83U50haZKr/3qqztATEWqxYVmR bhJPeiYgrzQ7IoQPZCbDnzK8qKAoxbz6ykMgcCSwHiILLOGbbfMAGG5vg0G8MTaKD7L69Ksin4F /ZKNfLHCfvh5JNjy8tLfkrtKDZfUtZMBqRX07Ff7qzyioR4ZupXyyameIKDDQYWt6mIYWWLarsJ 8u4V29cm+fFbXRX3uW5S4urOm6XIoiiBQn1EUooNNhOoIcMl
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mc that belongs to a pdev is always a root dprc. In
fsl_mc_bus_probe() the mc device gets assigned the platform device as
parent. As dev_is_fsl_mc() is false for a platform device,
fsl_mc_get_root_dprc() will always be true and so the if body is never
run and it can be dropped.

The motivation for this change is to get rid of an error path in
.remove() that is broken (because only a part of the necessary cleanup
is done resulting in leaks and/or use-after-frees and the driver core
ignores the return value of .remove().)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 2f6d5002e43d..75a8d365ffd4 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1172,9 +1172,6 @@ static int fsl_mc_bus_remove(struct platform_device *pdev)
 	struct fsl_mc *mc = platform_get_drvdata(pdev);
 	struct fsl_mc_io *mc_io;
 
-	if (!fsl_mc_is_root_dprc(&mc->root_mc_bus_dev->dev))
-		return -EINVAL;
-
 	mc_io = mc->root_mc_bus_dev->mc_io;
 	fsl_mc_device_remove(mc->root_mc_bus_dev);
 	fsl_destroy_mc_io(mc_io);

base-commit: e27090b1413ff236ca1aec26d6b022149115de2c
-- 
2.42.0


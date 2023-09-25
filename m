Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9F07AD4F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjIYJ4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjIYJzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:55:52 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85738DA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJX-0007qg-M8; Mon, 25 Sep 2023 11:55:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJW-008pzO-Io; Mon, 25 Sep 2023 11:55:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJW-004dlC-9A; Mon, 25 Sep 2023 11:55:38 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 13/40] soc/loongson: loongson2_guts: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:04 +0200
Message-Id: <20230925095532.1984344-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1681; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ATjpJg3Ymn3lpV/5/BensT0YUucFb6ICE/DcTgZnEiU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhOe/DWNmRhMPdnepAPTAePH9HSED/q6ORNq y4EcfxNb7WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYTgAKCRCPgPtYfRL+ TvGmCAChX5JJSKyWxFMa7rU47aHAgL6TpgnCjq94OMFLpaki4HemK4CGcqcXzVOOpb8Ibp7vjsg MZu3h8z/Lbwpavjrwo2L1g7Tq2Tlt2fWIH+F/zX7Eu4+VpphT9vNj0Gjp+VATd8mhbXk1YXE5HJ WcqyI/lLeOVm0dks8SLNWpVBN1UsfpJZyoTB4bpO6u3wnoFNwRqE2xCfeZslzh6B16qzGa5YTi4 yGWMU5gJryc5JulBxbszxRCcsGmlxgU98i9Iy+xytb17tOj+EQR770ZaMTMV0as7ldV2u/Z0miN d6lcfMkkifrfU6ut/kQFd4TW7Hp28ZAUSeAVCNDh1zGfigWT
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
 drivers/soc/loongson/loongson2_guts.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/loongson/loongson2_guts.c b/drivers/soc/loongson/loongson2_guts.c
index bace4bc8e03b..48f8382888a7 100644
--- a/drivers/soc/loongson/loongson2_guts.c
+++ b/drivers/soc/loongson/loongson2_guts.c
@@ -150,11 +150,9 @@ static int loongson2_guts_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int loongson2_guts_remove(struct platform_device *dev)
+static void loongson2_guts_remove(struct platform_device *dev)
 {
 	soc_device_unregister(soc_dev);
-
-	return 0;
 }
 
 /*
@@ -173,7 +171,7 @@ static struct platform_driver loongson2_guts_driver = {
 		.of_match_table = loongson2_guts_of_match,
 	},
 	.probe = loongson2_guts_probe,
-	.remove = loongson2_guts_remove,
+	.remove_new = loongson2_guts_remove,
 };
 
 static int __init loongson2_guts_init(void)
-- 
2.40.1


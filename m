Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243A77AD51A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjIYJ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjIYJ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:56:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C2F19E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJZ-00081B-TA; Mon, 25 Sep 2023 11:55:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJZ-008q0B-B2; Mon, 25 Sep 2023 11:55:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJZ-004dm2-1c; Mon, 25 Sep 2023 11:55:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 26/40] soc/qcom: smem: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:17 +0200
Message-Id: <20230925095532.1984344-27-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=a5TsISKH80t4Mbb4GluzypfGWbzkLo6q57TgzVDictg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhdm+ZJki7j/qruXdGpi5LbIqbJfDW9hrwoV 8YLOyNg3cGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYXQAKCRCPgPtYfRL+ Trm7B/wPJSlkXPWdUmNfpQeJB1SMi+TWplU8juVmDYAeqyFK4I4xEMapC+lUuMzwotmxGee1SAN kvyYOxxEwdmu3byk+386J+ONufQWumzKlfJxGL9KDtDEgNjiXUfOJgJpf/H1tk86HLoWpodxfgq lkUj1Jrpa6wQ1pNlzpwzdAnUSiirjRX+n2GLNtcm01210AhaHa6Zdl3i7DeBtDm3bC6IJs5dAdO 5AujzYcXKKZZQ4BsDegqRMI92V4q5aknOsATlViawWMe0BRDd4n3BfhEZmZsIs4n89GzuvQsK7g LaKMBYdH1w7AR9iPlKJN3f9UYqWGxbSVCpmhN3I8v3chGcAX
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
 drivers/soc/qcom/smem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index d4a89d2bb43b..58beeaab6fb4 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -1187,14 +1187,12 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int qcom_smem_remove(struct platform_device *pdev)
+static void qcom_smem_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(__smem->socinfo);
 
 	hwspin_lock_free(__smem->hwlock);
 	__smem = NULL;
-
-	return 0;
 }
 
 static const struct of_device_id qcom_smem_of_match[] = {
@@ -1205,7 +1203,7 @@ MODULE_DEVICE_TABLE(of, qcom_smem_of_match);
 
 static struct platform_driver qcom_smem_driver = {
 	.probe = qcom_smem_probe,
-	.remove = qcom_smem_remove,
+	.remove_new = qcom_smem_remove,
 	.driver  = {
 		.name = "qcom-smem",
 		.of_match_table = qcom_smem_of_match,
-- 
2.40.1


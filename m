Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2277AD519
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjIYJ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjIYJ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:56:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6E919C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJa-00082M-Do; Mon, 25 Sep 2023 11:55:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJZ-008q0P-WC; Mon, 25 Sep 2023 11:55:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJZ-004dmE-Mr; Mon, 25 Sep 2023 11:55:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 29/40] soc/qcom: socinfo: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:20 +0200
Message-Id: <20230925095532.1984344-30-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=90uOlJONh9cylIs5vvjXRa6sCUvXWA1OmhyJBs1pNUc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhg6iTi/gMVsP6JrDUpRAeFkHFSftL4SAAaA 3n+u6WR9L+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYYAAKCRCPgPtYfRL+ ThxwB/4q6F2zaDWOKrgbtmZdtPznLSspMmFtvuD7MCdqvCTYp/YcywPAIkDk++k0eXVcilqqBKK 7d3eWAjk5yLjzyVo3OvFUBcdxauLQDdZsYn+4T+WsCfS5d9WmAJojYJ9mo7NMrUejJMQ6DHOcJd Y8U5wgoa31qlBwBK1ryUbMI7CW0XdCKngadGw9WimIIL4MlebBwzNJ/ZQgc5399uy71iPlNdkQl Rz7e1k9MxdMSfwnN8J6uPlzpg7Ck2btwbDZKS5Iipkhur6pGBS+Suw4pbGyaAlMByHyAuP51l1q HdnPUtkCU8si6cnxlUyL7flM8/wwMC5Jvzvcvuijpx4GjdUw
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
 drivers/soc/qcom/socinfo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 2a15983d9f60..51e05bec5bfc 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -787,20 +787,18 @@ static int qcom_socinfo_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int qcom_socinfo_remove(struct platform_device *pdev)
+static void qcom_socinfo_remove(struct platform_device *pdev)
 {
 	struct qcom_socinfo *qs = platform_get_drvdata(pdev);
 
 	soc_device_unregister(qs->soc_dev);
 
 	socinfo_debugfs_exit(qs);
-
-	return 0;
 }
 
 static struct platform_driver qcom_socinfo_driver = {
 	.probe = qcom_socinfo_probe,
-	.remove = qcom_socinfo_remove,
+	.remove_new = qcom_socinfo_remove,
 	.driver  = {
 		.name = "qcom-socinfo",
 	},
-- 
2.40.1


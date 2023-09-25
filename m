Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8638E7AD51E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjIYJ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjIYJ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:56:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6D0BE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJa-00081g-Bl; Mon, 25 Sep 2023 11:55:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJZ-008q0L-Ov; Mon, 25 Sep 2023 11:55:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJZ-004dmA-Fk; Mon, 25 Sep 2023 11:55:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 28/40] soc/qcom: smsm: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:19 +0200
Message-Id: <20230925095532.1984344-29-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=z/W3uxTlGbd0Hm50wr5opUq80z5rVkc5dSSX+BBq0wM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhfUTSzppz+UyUZkBjVYnRFg9b67hFbOM0PE CExnpBm1p2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYXwAKCRCPgPtYfRL+ Tgt0B/4uGFdEp9P4aoL87ZCyVsQBO5BPkmdjlzTW0cPdeFm3uCnMPFUD2s563FtLWPA03FeMitr uPoHOrosi72mlJSqkF0yVuL0FgxZSA3wsEjeN0NbGBdob9MPWsOIIMt/bkW+AfJ4hcfdxWWsMsv BDETeZoiEcrS5VqlQvmo0LKcGM4fCDT2h6dZJZ0e6yyGvbzfyjheDlcIhnVw0GeMQZvXJUz5gy7 7n/H/WJF7HAMYvkUP3ahNHxtrR3WwgDfBsK1O2ZpEffPjZY/xoEfjnSnxRzMcjyCV76V+yT/jLS 0CeSXV82SwKllE7eNRBlmUTlWl/CqRnGMQtNMRleLd8xLIxc
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
 drivers/soc/qcom/smsm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/smsm.c b/drivers/soc/qcom/smsm.c
index c58cfff64856..e7c7e9a640a6 100644
--- a/drivers/soc/qcom/smsm.c
+++ b/drivers/soc/qcom/smsm.c
@@ -613,7 +613,7 @@ static int qcom_smsm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_smsm_remove(struct platform_device *pdev)
+static void qcom_smsm_remove(struct platform_device *pdev)
 {
 	struct qcom_smsm *smsm = platform_get_drvdata(pdev);
 	unsigned id;
@@ -623,8 +623,6 @@ static int qcom_smsm_remove(struct platform_device *pdev)
 			irq_domain_remove(smsm->entries[id].domain);
 
 	qcom_smem_state_unregister(smsm->state);
-
-	return 0;
 }
 
 static const struct of_device_id qcom_smsm_of_match[] = {
@@ -635,7 +633,7 @@ MODULE_DEVICE_TABLE(of, qcom_smsm_of_match);
 
 static struct platform_driver qcom_smsm_driver = {
 	.probe = qcom_smsm_probe,
-	.remove = qcom_smsm_remove,
+	.remove_new = qcom_smsm_remove,
 	.driver  = {
 		.name  = "qcom-smsm",
 		.of_match_table = qcom_smsm_of_match,
-- 
2.40.1


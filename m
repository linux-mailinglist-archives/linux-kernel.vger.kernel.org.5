Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557097AD52B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjIYKAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjIYJ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:59:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A59A127
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:56:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJb-00087l-4p; Mon, 25 Sep 2023 11:55:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJa-008q0c-MW; Mon, 25 Sep 2023 11:55:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJa-004dmQ-DB; Mon, 25 Sep 2023 11:55:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Rob Herring <robh@kernel.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 32/40] soc/tegra: cbb: tegra194-cbb: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:23 +0200
Message-Id: <20230925095532.1984344-33-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=fJek1nXRjVsALxbooou+SSfwuAYzMEZE4AiZBXgjDcQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhj7v6vyTqodYCq2VrRogq1Zj5wQGoIHk1ls VBTTjBoX92JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYYwAKCRCPgPtYfRL+ TjGHB/9JTRks2fQHjRlc6o9U5WRuLZL7Gm8heSS/KwtLWYOOBv3Ek2PbVFE+OQCAU6y7WCo1iq2 5XOvCatGvRTVUw3+BYcKE29vfUx7Bdb5uy90WanBBVqlM0V2oSbA6IRGlrskytwisxw9TddnSmy 6bloElouToNXDk1l3QdxBVq3Sot6K4MOvB1CqwkJIhqEsBVRa82b7vs2E0LBTFRoW/xes5Gat59 XH46DrxTc5TV+fMHgeV8oh3g7rzhf2h04+9gVXQ+hCCavmps9d+gybwddVAzkqr95PDnQz+RD6R XJA7viwK5QIe95rnstIB0lNVfUVGNcI0/Pc6FhD4ZGiMtnkL
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
 drivers/soc/tegra/cbb/tegra194-cbb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/tegra/cbb/tegra194-cbb.c b/drivers/soc/tegra/cbb/tegra194-cbb.c
index cf6886f362d3..9cbc562ae7d3 100644
--- a/drivers/soc/tegra/cbb/tegra194-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra194-cbb.c
@@ -2293,7 +2293,7 @@ static int tegra194_cbb_probe(struct platform_device *pdev)
 	return tegra_cbb_register(&cbb->base);
 }
 
-static int tegra194_cbb_remove(struct platform_device *pdev)
+static void tegra194_cbb_remove(struct platform_device *pdev)
 {
 	struct tegra194_cbb *cbb = platform_get_drvdata(pdev);
 	struct tegra_cbb *noc, *tmp;
@@ -2311,8 +2311,6 @@ static int tegra194_cbb_remove(struct platform_device *pdev)
 	}
 
 	spin_unlock_irqrestore(&cbb_lock, flags);
-
-	return 0;
 }
 
 static int __maybe_unused tegra194_cbb_resume_noirq(struct device *dev)
@@ -2332,7 +2330,7 @@ static const struct dev_pm_ops tegra194_cbb_pm = {
 
 static struct platform_driver tegra194_cbb_driver = {
 	.probe = tegra194_cbb_probe,
-	.remove = tegra194_cbb_remove,
+	.remove_new = tegra194_cbb_remove,
 	.driver = {
 		.name = "tegra194-cbb",
 		.of_match_table = of_match_ptr(tegra194_cbb_match),
-- 
2.40.1


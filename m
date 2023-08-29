Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B28F78C148
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjH2JYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjH2JY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:24:26 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2465CE1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:24:20 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230829092413euoutp02ac564a6a4d19a9f77fcc1085c29f181a~-0FYhSUup0626806268euoutp02u
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:24:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230829092413euoutp02ac564a6a4d19a9f77fcc1085c29f181a~-0FYhSUup0626806268euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693301053;
        bh=R1npbRRHIVc5z6cr0/4uwlBlhUhKgoCzpA6deobymMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOFpkEUL0x/7wZ6c3789rGGdbcGSzNtU6wTf93x1lVVHYX+lXu5vu6N38rfo6LfI2
         sArTPqMPk63e8pYYMcz4yu347pTa5vgo6F9UYAOmT5TUarMLbnwLxee5BvfDym+Dgx
         WjDFEY0w21t1a7pE+ZV4hbES3gOyR3mWWJCFSUxk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230829092412eucas1p1531cee3670a5d7e7fe38d7d7151f2a71~-0FYHCpq31623216232eucas1p1l;
        Tue, 29 Aug 2023 09:24:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D4.7F.37758.C39BDE46; Tue, 29
        Aug 2023 10:24:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092412eucas1p2b79a6f90b9077a3a5486845b7e68bbc6~-0FXq7Jdh2939629396eucas1p24;
        Tue, 29 Aug 2023 09:24:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230829092412eusmtrp14cd3da253366871f711c7e1809b20078~-0FXqKtVd3248032480eusmtrp1v;
        Tue, 29 Aug 2023 09:24:12 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-43-64edb93cbb05
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id ED.D9.10549.C39BDE46; Tue, 29
        Aug 2023 10:24:12 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092411eusmtip28a316e30a2b60f07dd72a3c2872f77ed~-0FWvvzIj0629806298eusmtip2i;
        Tue, 29 Aug 2023 09:24:11 +0000 (GMT)
From:   Mateusz Majewski <m.majewski2@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Mateusz Majewski <m.majewski2@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 04/11] thermal: exynos: remove fine-grained clk management
Date:   Tue, 29 Aug 2023 11:18:42 +0200
Message-ID: <20230829091853.626011-5-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829091853.626011-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djP87o2O9+mGOxu17V4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8WaveeYLOZ9lrWYf+Qcq0Xfi4fMFt+udDBZbHp8jdXi8q45bBafe48wWsw4
        v4/JYuKxycwWa4/cZbeY+2Uqs0Xr3iPsFk8e9rE5CHnsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC2CP4rJJSc3JLEst0rdL4Mq4su4uU8EthYrnN5axNjD+kupi5OSQEDCR
        mPX5P2sXIxeHkMAKRomLH7exQzhfGCXOdW5mgnA+M0rcu7aVBablfsNuNojEcqCWtZcYIZxW
        JomWBx+ZQarYBAwkHrxZBjZLRGAxo8TWnbPAZjELzGWRaFj5E2yWsICXxNQLWxlBbBYBVYmW
        re/AbF4BW4nzx2ezQ+yTl3h+6w6YzSlgJzH9fDsTRI2gxMmZT8DmMAPVNG+dzQxRP51T4sxK
        NgjbRWL1iXaouLDEq+NboGbKSJye3AP1T77EjM3vgWwOILtC4u5BLwjTWuLjGWYQk1lAU2L9
        Ln2IYkeJO82PWSEq+CRuvBWE2M8nMWnbdGaIMK9ER5sQRLWqxPE9k6DWS0s8abnNBGF7SNx+
        c519AqPiLCSfzELyySyEvQsYmVcxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEJrnT/45/
        3cG44tVHvUOMTByMhxglOJiVRHgvOb5KEeJNSaysSi3Kjy8qzUktPsQozcGiJM6rbXsyWUgg
        PbEkNTs1tSC1CCbLxMEp1cBU4eR6l4O/3Kiy7+ORV4me6/+ztd3+G/Bl0bkEuTkJ7ddmSW1+
        tWrqsff6v88E3Cvn2SWaf51rdeRPRonaMx/uzKoS2jH1o09rWNzNKwfFp/mdn5C3Rf5oXM1M
        V40LnT7vJhjb7Lrpy+ry55mSx/fEjeVFTrvXz562QEvr77FMrw2PXizR5pEyVVwQf2rSujfn
        Z52fva/3am6dxd3InxsNLK4Za57LfNme1/P3vL7M0rBUp6ol4Rc33FC7qNJZI//c7c4+3YwJ
        AsorJXIjZulqXg9lD2Xc77HspS9DR4bevrM1389sfnq69Iu2VnXWeS9b6ftFK7XeLlq83jmm
        V/jmp13a63Uel9atzb3Rs+uHuhJLcUaioRZzUXEiAN82OdrhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xe7o2O9+mGDw/JGDxYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
        kpqTWZZapG+XoJdxZd1dpoJbChXPbyxjbWD8JdXFyMkhIWAicb9hN1sXIxeHkMBSRom/fe2M
        EAlpicNfprBD2MISf651QRU1M0kseb6FBSTBJmAg8eDNMnaQhIjAckaJq/eWs4A4zALLWSSe
        r/nADFIlLOAlMfXCVrCxLAKqEi1b34HZvAK2EuePz4ZaIS/x/NYdMJtTwE5i+vl2JhBbCKhm
        zYRzbBD1ghInZz4B28wMVN+8dTbzBEaBWUhSs5CkFjAyrWIUSS0tzk3PLTbUK07MLS7NS9dL
        zs/dxAiMym3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeC85vkoR4k1JrKxKLcqPLyrNSS0+xGgK
        dPdEZinR5HxgWsgriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamAy
        z4xzPZB5XYxFzPxXv/30QB6lpqqlMmsW5exz/JT/mmn1mt+zfz06vztmhde0uew3ivKPGRc1
        8tUnaoVs/cI84e3TQMF5NSt3nA25pniRd7772wZFoTb/TRtrsg5opbd/jjA7+oyD2eLtxSXq
        Fq4zOy4yOHrb34qqLiiYduP1RdO3X1iW1tnzXOd7VC0258zHBU9ZJMqWWh95nDdDw/f75oW2
        7lvezVoryxNuz57ywHmVTGLytw35s+bdC/wgeY6x/wXzV95PXFzT9zfxvSpW5zHe6nvIa8fE
        v/r3LjDM1lyeE8HMUqYp+luK0+BB7/OeKRPEonxazf5UpjzIcdx83MFeJcVe5Kdd+FR2h7lK
        LMUZiYZazEXFiQDCK5BvUwMAAA==
X-CMS-MailID: 20230829092412eucas1p2b79a6f90b9077a3a5486845b7e68bbc6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230829092412eucas1p2b79a6f90b9077a3a5486845b7e68bbc6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230829092412eucas1p2b79a6f90b9077a3a5486845b7e68bbc6
References: <20230829091853.626011-1-m.majewski2@samsung.com>
        <CGME20230829092412eucas1p2b79a6f90b9077a3a5486845b7e68bbc6@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clock only controls the register operations. The gain in power
efficiency is therefore quite dubious, while there is price of added
complexity that is important to get right (as a register operation might
outright hang the CPU if the clock is not enabled).

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 35b0a55017ad..2c5501704911 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -275,7 +275,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	}
 
 	mutex_lock(&data->lock);
-	clk_enable(data->clk);
 	if (!IS_ERR(data->clk_sec))
 		clk_enable(data->clk_sec);
 
@@ -305,7 +304,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		data->tmu_clear_irqs(data);
 	}
 err:
-	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 	if (!IS_ERR(data->clk_sec))
 		clk_disable(data->clk_sec);
@@ -336,10 +334,8 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 
 	mutex_lock(&data->lock);
-	clk_enable(data->clk);
 	data->tmu_control(pdev, on);
 	data->enabled = on;
-	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 }
 
@@ -654,7 +650,6 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
 		return -EAGAIN;
 
 	mutex_lock(&data->lock);
-	clk_enable(data->clk);
 
 	value = data->tmu_read(data);
 	if (value < 0)
@@ -662,7 +657,6 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
 	else
 		*temp = code_to_temp(data, value) * MCELSIUS;
 
-	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
 	return ret;
@@ -729,9 +723,7 @@ static int exynos_tmu_set_emulation(struct thermal_zone_device *tz, int temp)
 		goto out;
 
 	mutex_lock(&data->lock);
-	clk_enable(data->clk);
 	data->tmu_set_emulation(data, temp);
-	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 	return 0;
 out:
@@ -769,12 +761,10 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
 
 	mutex_lock(&data->lock);
-	clk_enable(data->clk);
 
 	/* TODO: take action based on particular interrupt */
 	data->tmu_clear_irqs(data);
 
-	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
 	return IRQ_HANDLED;
@@ -1012,7 +1002,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_sensor;
 
-	data->clk = devm_clk_get(&pdev->dev, "tmu_apbif");
+	data->clk = devm_clk_get_enabled(&pdev->dev, "tmu_apbif");
 	if (IS_ERR(data->clk)) {
 		dev_err(&pdev->dev, "Failed to get clock\n");
 		ret = PTR_ERR(data->clk);
@@ -1034,12 +1024,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = clk_prepare(data->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to get clock\n");
-		goto err_clk_sec;
-	}
-
 	switch (data->soc) {
 	case SOC_ARCH_EXYNOS5433:
 	case SOC_ARCH_EXYNOS7:
@@ -1047,12 +1031,12 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		if (IS_ERR(data->sclk)) {
 			dev_err(&pdev->dev, "Failed to get sclk\n");
 			ret = PTR_ERR(data->sclk);
-			goto err_clk;
+			goto err_clk_sec;
 		} else {
 			ret = clk_prepare_enable(data->sclk);
 			if (ret) {
 				dev_err(&pdev->dev, "Failed to enable sclk\n");
-				goto err_clk;
+				goto err_clk_sec;
 			}
 		}
 		break;
@@ -1094,8 +1078,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 
 err_sclk:
 	clk_disable_unprepare(data->sclk);
-err_clk:
-	clk_unprepare(data->clk);
 err_clk_sec:
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
@@ -1113,7 +1095,6 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 	exynos_tmu_control(pdev, false);
 
 	clk_disable_unprepare(data->sclk);
-	clk_unprepare(data->clk);
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
 
-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB5878C146
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjH2JYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjH2JY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:24:27 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FB7CCC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:24:21 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230829092418euoutp02e3e7871b30db9cf0a4208ac429f37ee2~-0Fd09gvn0788107881euoutp02C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:24:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230829092418euoutp02e3e7871b30db9cf0a4208ac429f37ee2~-0Fd09gvn0788107881euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693301058;
        bh=uxrdo/kD2daqjjmxIH/c4SF+x6XLXkAixdvHbsmRDwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFhQ/AeLV5stqfZ7uh7ITLtGukVGSINahJMqLbLxsk9aSeyxj/VfdeC9ViGZs+2av
         3nIJOcq6MhPhF36cTbof5XKDQmUnjqN/Yq85mqWo5yrF6JRDfQbuvQA9ubQ0Jy67J0
         fOzMnb8O6vJ55dq24sHBV5GDvg28M/B3AhtdjmCI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230829092418eucas1p1262a7d262936a80e888373a78c47803f~-0FdU-MLX2028420284eucas1p1r;
        Tue, 29 Aug 2023 09:24:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 88.27.11320.249BDE46; Tue, 29
        Aug 2023 10:24:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230829092417eucas1p187216bed157d5fb8472780688cf746d2~-0Fc7VcCz2327623276eucas1p11;
        Tue, 29 Aug 2023 09:24:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230829092417eusmtrp1eb74272d64882257490272d9adab00eb~-0Fc6jzWT3248032480eusmtrp1C;
        Tue, 29 Aug 2023 09:24:17 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-1d-64edb942d3a9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 27.E9.10549.149BDE46; Tue, 29
        Aug 2023 10:24:17 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092416eusmtip27357c43634c3501df0df9b98f0422dcb~-0Fb-Yloe0986509865eusmtip2f;
        Tue, 29 Aug 2023 09:24:16 +0000 (GMT)
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
Subject: [PATCH 06/11] thermal: exynos: simplify regulator
 (de)initialization
Date:   Tue, 29 Aug 2023 11:18:44 +0200
Message-ID: <20230829091853.626011-7-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829091853.626011-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djP87pOO9+mGJz7KGTxYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJUxacJ79oJJkhXd/+6zNzBuFeli5OSQEDCR
        +PTlIXsXIxeHkMAKRomp3ReYQBJCAl8YJS7uiYOwPzNKbF8pCtNw6uszZoiG5YwS1xcvZYQo
        amWSmLtOEsRmEzCQePBmGdhUEYHFjBJbd85iAnGYBeaySDSs/MkCUiUs4C/x9dplsG4WAVWJ
        9+v2s4HYvAK2EvNbbzJDrJOXeH7rDjuIzSlgJzH9fDsTRI2gxMmZT8DmMAPVNG+dDXaShMBs
        Tol5ix+wQTS7SLRunsAIYQtLvDq+hR3ClpE4PbmHBcLOl5ix+T2QzQFkV0jcPegFYVpLfDzD
        DGIyC2hKrN+lD1HsKHF41wcmiAo+iRtvBSEO4JOYtG06M0SYV6KjTQiiWlXi+J5JUH9ISzxp
        uc0EYXtItGzsYJnAqDgLySuzkLwyC2HvAkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmb
        GIEJ7vS/4192MC5/9VHvECMTB+MhRgkOZiUR3kuOr1KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ
        82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1MEnfybxeO0vy2V09SbblJk6bdhSuf736sXvpb12B
        pJBUC43DDbnzpWp1rRe2yap6yKjY15+abpW5YuG7o1uMIrrCp/ZtXhIW+u72VfdIqxe3p3+M
        uNxwj0O5yHL3zr0O78yWZDrzlfdWq9csqso98Hfj5L9/J128xxdz7LRm/+tpF1Ym/OY6eDdW
        pEwwxN+qUrErt9xy7rQHcRLPdVn8xXqM//z5xMb89+2y8x5PNMSOPpB88fQA/+bKYzM2u/ly
        7lPN850cfonv5nUF9nQ74WWWzm9W9jGnT013YdbctIJt5mq9GdaTOn+c/3yUO/TDDsYHxaeZ
        J66fHNEka5pbH5Mqzhe9bMV3CYciqb1Jx5RYijMSDbWYi4oTAcFTSNXfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7qOO9+mGBzeaW7xYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
        kpqTWZZapG+XoJcxacJ79oJJkhXd/+6zNzBuFeli5OSQEDCROPX1GXMXIxeHkMBSRon7B5ey
        QySkJQ5/mQJlC0v8udbFBlHUzCSx8/FURpAEm4CBxIM3y9hBEiICyxklrt5bzgLiMAssZ5F4
        vuYD0FwODmEBX4n+VTogDSwCqhLv1+1nA7F5BWwl5rfeZIbYIC/x/NYdsG2cAnYS08+3M4HY
        QkA1ayacg6oXlDg58wkLiM0MVN+8dTbzBEaBWUhSs5CkFjAyrWIUSS0tzk3PLTbUK07MLS7N
        S9dLzs/dxAiMyW3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeC85vkoR4k1JrKxKLcqPLyrNSS0+
        xGgKdPdEZinR5HxgUsgriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCU
        amDyCdF+/WuDn+TR25pGFY2vJ2W/SrrjwyWwLPHqfo8nPvqJ1/t/WU9Y4LhH5J9E6Qzl3WqM
        p/aY887MWyRcnVAjOOtekYte8BmlrLMz7idZLrst/lTTIeXA9QZB/otxuTmXjRLb4/9PNQ1d
        Ih1wZ6/2gg8Zj7R1rG7offohKmZ7yVIu8Ok132M730pPav/L82Ja2eUXnCJpLIyrtnpUuzws
        Uoh0Kr59MV1mm/ynvdOP7tgSunnp33LL2MdBu/uyLffOr2+Xn//84UvDxJP8ZlMqljmuk1PX
        rmWI7Wq1nvt2qZSF5fKjTklFPxctqHOuKzBnVJopXbmWM1FxmcC2Xffld4hGxDiFT99cOt/7
        gK8SS3FGoqEWc1FxIgBvIzS5UgMAAA==
X-CMS-MailID: 20230829092417eucas1p187216bed157d5fb8472780688cf746d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230829092417eucas1p187216bed157d5fb8472780688cf746d2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230829092417eucas1p187216bed157d5fb8472780688cf746d2
References: <20230829091853.626011-1-m.majewski2@samsung.com>
        <CGME20230829092417eucas1p187216bed157d5fb8472780688cf746d2@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This does reduce the error granularity a bit, but the code
simplification seems to be worth it.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 33 +++++++---------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 49e9157c3dc7..5c08212ff8ac 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -157,7 +157,6 @@ enum soc_type {
  * @reference_voltage: reference voltage of amplifier
  *	in the positive-TC generator block
  *	0 < reference_voltage <= 31
- * @regulator: pointer to the TMU regulator structure.
  * @reg_conf: pointer to structure to register with core thermal.
  * @tzd: pointer to thermal_zone_device structure
  * @ntrip: number of supported trip points.
@@ -184,7 +183,6 @@ struct exynos_tmu_data {
 	u16 temp_error1, temp_error2;
 	u8 gain;
 	u8 reference_voltage;
-	struct regulator *regulator;
 	struct thermal_zone_device *tzd;
 	unsigned int ntrip;
 	bool enabled;
@@ -985,42 +983,34 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	 * TODO: Add regulator as an SOC feature, so that regulator enable
 	 * is a compulsory call.
 	 */
-	data->regulator = devm_regulator_get_optional(&pdev->dev, "vtmu");
-	if (!IS_ERR(data->regulator)) {
-		ret = regulator_enable(data->regulator);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to enable vtmu\n");
-			return ret;
-		}
-	} else {
-		if (PTR_ERR(data->regulator) == -EPROBE_DEFER)
+	ret = devm_regulator_get_enable_optional(&pdev->dev, "vtmu");
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
-		dev_info(&pdev->dev, "Regulator node (vtmu) not found\n");
+		dev_info(&pdev->dev, "Failed to get regulator node (vtmu)\n");
 	}
 
 	ret = exynos_map_dt_data(pdev);
 	if (ret)
-		goto err_sensor;
+		return ret;
 
 	data->clk = devm_clk_get_enabled(&pdev->dev, "tmu_apbif");
 	if (IS_ERR(data->clk)) {
 		dev_err(&pdev->dev, "Failed to get clock\n");
-		ret = PTR_ERR(data->clk);
-		goto err_sensor;
+		return PTR_ERR(data->clk);
 	}
 
 	data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
 	if (IS_ERR(data->clk_sec)) {
 		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
 			dev_err(&pdev->dev, "Failed to get triminfo clock\n");
-			ret = PTR_ERR(data->clk_sec);
-			goto err_sensor;
+			return PTR_ERR(data->clk_sec);
 		}
 	} else {
 		ret = clk_prepare(data->clk_sec);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to get clock\n");
-			goto err_sensor;
+			return ret;
 		}
 	}
 
@@ -1073,10 +1063,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 err_clk_sec:
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
-err_sensor:
-	if (!IS_ERR(data->regulator))
-		regulator_disable(data->regulator);
-
 	return ret;
 }
 
@@ -1089,9 +1075,6 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
 
-	if (!IS_ERR(data->regulator))
-		regulator_disable(data->regulator);
-
 	return 0;
 }
 
-- 
2.41.0


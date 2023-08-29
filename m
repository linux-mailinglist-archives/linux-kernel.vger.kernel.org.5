Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736C178C151
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjH2JZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbjH2JY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:24:28 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027F31B9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:24:21 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230829092420euoutp022d4c7df2a478a4543026c856919b0dab~-0FfQsYXT0626506265euoutp02A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:24:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230829092420euoutp022d4c7df2a478a4543026c856919b0dab~-0FfQsYXT0626506265euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693301060;
        bh=fAWYlX+RxB8EresjOiGmi5eRZPDuvZsprSSAaoR5vys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sh17cdzYxNoCCmJb+Q2AKOuBnKYqk11Rx/kxRxtOr6tycOfn44gRExUia07CBHeiu
         jKUkSRXuS1Ts9bxSZj/SrmtD9Y+/80W7juANfSiTD3VG9okqqnNRG6CyPxbj63RuV0
         fIJpri309hi4jcIER/w6eGBWi55Es+ynbZ4keKE0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230829092420eucas1p19611b8ff89e109396ed5b59c1b95fa03~-0Fe0s84q2330823308eucas1p1r;
        Tue, 29 Aug 2023 09:24:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 90.E8.42423.349BDE46; Tue, 29
        Aug 2023 10:24:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092419eucas1p275687d1c34087e8bad4b3194ad4b8973~-0FeaITei2901529015eucas1p2q;
        Tue, 29 Aug 2023 09:24:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230829092419eusmtrp18b3a350707c74a739063c2ab0f32a02a~-0FeZZsoF3270032700eusmtrp1c;
        Tue, 29 Aug 2023 09:24:19 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-40-64edb943e032
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9D.8B.14344.349BDE46; Tue, 29
        Aug 2023 10:24:19 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092418eusmtip22e91e730285b16a75a1459994fbd299d~-0FdcuXGj1173411734eusmtip2l;
        Tue, 29 Aug 2023 09:24:18 +0000 (GMT)
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
Subject: [PATCH 07/11] thermal: exynos: simplify clk_sec (de)initialization
Date:   Tue, 29 Aug 2023 11:18:45 +0200
Message-ID: <20230829091853.626011-8-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829091853.626011-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djPc7rOO9+mGJy9Y2bxYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJUx7/ts9oKDkhWrPvxha2C8J9LFyMkhIWAi
        sfb6MXYQW0hgBaPEvbt5XYxcQPYXRonre9+zQTifGSV6m44zdzFygHUc3F8AEV/OKLG57RBU
        USuTxM2nN1hBRrEJGEg8eLOMHSQhIrCYUWLrzllMIA6zwFwWiYaVP1lAqoQFvCX+zZ7DDGKz
        CKhKLPj6BOwQXgFbia/9Z1ghDpSXeH7rDlicU8BOYvr5diaIGkGJkzOfgM1hBqpp3jqbGWSB
        hMB8TomlZ/cwQjS7SGw49p4JwhaWeHV8CzuELSNxenIPC4SdLzFj83sWiN8qJO4e9IIwrSU+
        ngH7mFlAU2L9Ln2IYkeJjXO/sENU8EnceCsIcQCfxKRt06HhwyvR0SYEUa0qcXzPJGYIW1ri
        ScttqFM8JC6/fsM+gVFxFpJXZiF5ZRbC3gWMzKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNz
        NzECU9zpf8c/7WCc++qj3iFGJg7GQ4wSHMxKIryXHF+lCPGmJFZWpRblxxeV5qQWH2KU5mBR
        EufVtj2ZLCSQnliSmp2aWpBaBJNl4uCUamBqL8jtOv4vWuBVQaGe/g2PK2VbBGbuL66bsf9r
        tTff/rTdh6buCwgVNz7+zEbsG/OabJEXExd42BcJV5zJ3xwuc2rp0zOphybcnn1Wiik9TTPn
        YJ7D9o3XdaZ7vCt6lcZ65WzaysLGaVMPvNRexeT7Z1NcSpZc6M7Q/mLRmrVaO+c78aT5ZRYV
        /K0T1TvxUoBnlZDkl6KZd77cyJ7zfcKBMy8uMnPrlSb41XdX3RE/bNSRFBT7huuNU9Ih7mWh
        f7529JTWf5MNujv5hPzx24dCri79aOP4W/a9bpRWErt0YclewbzjM1zu7vnMUy3yMrFa4Klk
        iktp1zHxqr9Xb0rsVeV54JbuxvpH/dS749OUWIozEg21mIuKEwGEBGCT4AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7rOO9+mGPy9KmPxYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
        kpqTWZZapG+XoJcx7/ts9oKDkhWrPvxha2C8J9LFyMEhIWAicXB/QRcjJ4eQwFJGiefn40Bs
        CQFpicNfprBD2MISf651sXUxcgHVNDNJrHvxjw0kwSZgIPHgzTJ2kISIwHJGiav3lrOAOMwC
        y1kknq/5wAxSJSzgLfFv9hwwm0VAVWLB1ydgY3kFbCW+9p9hhVghL/H81h2wOKeAncT08+1M
        ECfZSqyZcI4Nol5Q4uTMJywgNjNQffPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232EivODG3
        uDQvXS85P3cTIzAitx37uWUH48pXH/UOMTJxMB5ilOBgVhLhveT4KkWINyWxsiq1KD++qDQn
        tfgQoynQ3ROZpUST84EpIa8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+J
        g1OqgSn+QXqz06GDvd0ztbKmnmnh4di0fGLSw1nVAtMDTzGfFy/I/qO/4dTSInvbKCbugw9O
        Oa6aVy7q4nSqalHG96Dij8zHFaZcMtn5NUHgV6Kc87OypYYhdx82O2x98YRdw2L2b6OPzfts
        9bbusTFUmG2hHcn1Xyq5sZhL8cqnE8Is5lEvdwqkN299w25v/rujaivri/je47c5My5O+/ph
        l86c1yciDBy6pi/befz8o8afjk807t++/22XQ7GBy9GdK37EJMqeeVC7ZdHM6d/8Etv/yZu6
        9nntNl8k9UnWP/WCQUe07c2303jYDLh/b+G8HrV5xtaQ/BoJ4dqUDxsyt/J7cjiZ3L+12p9l
        sZpK+yIlluKMREMt5qLiRAAfFDHfUQMAAA==
X-CMS-MailID: 20230829092419eucas1p275687d1c34087e8bad4b3194ad4b8973
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230829092419eucas1p275687d1c34087e8bad4b3194ad4b8973
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230829092419eucas1p275687d1c34087e8bad4b3194ad4b8973
References: <20230829091853.626011-1-m.majewski2@samsung.com>
        <CGME20230829092419eucas1p275687d1c34087e8bad4b3194ad4b8973@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only now grab the clock where it is actually being used.
Additionally, we remove the fine-grained clock management by enabling
the clock during initialization.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 45 ++++++++--------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 5c08212ff8ac..5da44f43715d 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -273,8 +273,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	}
 
 	mutex_lock(&data->lock);
-	if (!IS_ERR(data->clk_sec))
-		clk_enable(data->clk_sec);
 
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 	if (!status) {
@@ -303,8 +301,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	}
 err:
 	mutex_unlock(&data->lock);
-	if (!IS_ERR(data->clk_sec))
-		clk_disable(data->clk_sec);
 out:
 	return ret;
 }
@@ -1000,28 +996,21 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		return PTR_ERR(data->clk);
 	}
 
-	data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
-	if (IS_ERR(data->clk_sec)) {
-		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
-			dev_err(&pdev->dev, "Failed to get triminfo clock\n");
-			return PTR_ERR(data->clk_sec);
-		}
-	} else {
-		ret = clk_prepare(data->clk_sec);
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to get clock\n");
-			return ret;
-		}
-	}
-
 	switch (data->soc) {
 	case SOC_ARCH_EXYNOS5433:
 	case SOC_ARCH_EXYNOS7:
 		data->sclk = devm_clk_get_enabled(&pdev->dev, "tmu_sclk");
 		if (IS_ERR(data->sclk)) {
 			dev_err(&pdev->dev, "Failed to get sclk\n");
-			ret = PTR_ERR(data->sclk);
-			goto err_clk_sec;
+			return PTR_ERR(data->sclk);
+		}
+		break;
+	case SOC_ARCH_EXYNOS5420_TRIMINFO:
+		data->clk_sec =
+			devm_clk_get_enabled(&pdev->dev, "tmu_triminfo_apbif");
+		if (IS_ERR(data->clk_sec)) {
+			dev_err(&pdev->dev, "Failed to get triminfo clock\n");
+			return PTR_ERR(data->clk_sec);
 		}
 		break;
 	default:
@@ -1039,13 +1028,13 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		if (ret != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "Failed to register sensor: %d\n",
 				ret);
-		goto err_clk_sec;
+		return ret;
 	}
 
 	ret = exynos_tmu_initialize(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize TMU\n");
-		goto err_clk_sec;
+		return ret;
 	}
 
 	ret = devm_request_threaded_irq(
@@ -1054,27 +1043,17 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		dev_name(&pdev->dev), data);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq: %d\n", data->irq);
-		goto err_clk_sec;
+		return ret;
 	}
 
 	exynos_tmu_control(pdev, true);
 	return 0;
-
-err_clk_sec:
-	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
-	return ret;
 }
 
 static int exynos_tmu_remove(struct platform_device *pdev)
 {
-	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-
 	exynos_tmu_control(pdev, false);
 
-	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
-
 	return 0;
 }
 
-- 
2.41.0


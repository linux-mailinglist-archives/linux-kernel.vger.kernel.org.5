Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F76C78C14A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbjH2JYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbjH2JY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:24:26 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42131CC2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:24:20 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230829092416euoutp0208ab241380cf0893ea595abac4d5b7e3~-0Fb3T7bP0626806268euoutp02w
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:24:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230829092416euoutp0208ab241380cf0893ea595abac4d5b7e3~-0Fb3T7bP0626806268euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693301056;
        bh=PS2hMZWBxoksmfnyC1o735UN6zy7GfxU5G/igjFuprM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNcwJBPbkBMBGGhHtOEQviJPWwgs+WgzxuXo+zBa1gjcgBr+UjGtn68ArVRSfkSVn
         XL9OI+aaUaYoPUBr+q974cgf16dTNKmpl+GWpqi92sgs5YQKBcBB4c0pD/DghVZg1V
         z7sG/B/jceWJ+GqgiWj3FRFWjUKfYJlkrjw8h0Q4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230829092416eucas1p19b7bc837fe4d2a02794541a3b5942096~-0FbdBUCI2064620646eucas1p12;
        Tue, 29 Aug 2023 09:24:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C8.7F.37758.049BDE46; Tue, 29
        Aug 2023 10:24:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230829092415eucas1p1cb4d56f908e7851297b2c4ed59984b2f~-0FbCDVL01818818188eucas1p1t;
        Tue, 29 Aug 2023 09:24:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230829092415eusmtrp1c2a7f49105c3a4b65d53d2f1a07e6816~-0FbBYPNH3248032480eusmtrp17;
        Tue, 29 Aug 2023 09:24:15 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-54-64edb940cb7a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 32.E9.10549.F39BDE46; Tue, 29
        Aug 2023 10:24:15 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092414eusmtip2660964aafb50caa1e630ce78f05556a2~-0FaHHqt10629806298eusmtip2j;
        Tue, 29 Aug 2023 09:24:14 +0000 (GMT)
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
Subject: [PATCH 05/11] thermal: exynos: simplify sclk (de)initialization
Date:   Tue, 29 Aug 2023 11:18:43 +0200
Message-ID: <20230829091853.626011-6-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829091853.626011-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djPc7oOO9+mGMxcLmrxYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJVxtOkRW8EGwYqFPx6wNDBO5uti5OCQEDCR
        OHq4sIuRi0NIYAWjxIepi5khnC+MEt2bj0M5nxklZp45zNLFyAnWcWPbCjaIxHJGiWcnJ4Al
        hARamSQWnk8FsdkEDCQevFnGDlIkIrCYUWLrzllMIA6zwFwWiYaVP8E6hAU8JJ49WMwEYrMI
        qEq0X5nPDGLzCthKTLu1kAlinbzE81t32EFsTgE7ienn25kgagQlTs58AjaHGaimeetssFsl
        BKZzSvxvv8gO0ewicXTuJihbWOLV8S1QtozE6ck9UP/kS8zY/J4FEhoVEncPekGY1hIfzzCD
        mMwCmhLrd+lDFDtK7Ds/iRWigk/ixltBiAP4JCZtm84MEeaV6GgTgqhWlTi+ZxIzhC0t8aTl
        NtRPHhIvli1nmcCoOAvJK7OQvDILYe8CRuZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsY
        gSnu9L/jX3cwrnj1Ue8QIxMH4yFGCQ5mJRHeS46vUoR4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        atueTBYSSE8sSc1OTS1ILYLJMnFwSjUwqdwJ+r3y3zkfj2eXlsw+P1u6dVPEvUuLlhptXVjc
        s0nn5LtZJw+JSCT+uPNtyr9FlXJ/FkWHfG7UOJ245EfJ7fidq+q/WKicX+WukJ4ltWaF35KV
        u71yuRm8z/DdrVBUMc6W5UnqWR2TfuL01e3hK/8UXX5u7d1UbNVjfzxowazUS+7L34pEK2gy
        1btON9y+Mnhq86OPss85o+5ZnTvMmLZ66Srh9D0/X7YfzfA9M6vnomaQpMD5OPGvaxYu+yJ8
        iDudZdKzs5GizdtnLP/l+3RvUGJl363OgxvF95Q4nkva9S/o+671jG9uVsWoVO99vO8IQ6/E
        8s3Fzw63Laub7nrh9wMz8+LMR3lHr+izzmlRYinOSDTUYi4qTgQAFLV/FOADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7r2O9+mGDzZambxYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
        kpqTWZZapG+XoJdxtOkRW8EGwYqFPx6wNDBO5uti5OSQEDCRuLFtBRuILSSwlFGi4bYURFxa
        4vCXKewQtrDEn2tdQDVcQDXNTBKvL+9kBkmwCRhIPHizjB0kISKwnFHi6r3lLCAOs8ByFonn
        az6AVQkLeEg8e7CYCcRmEVCVaL8yHyzOK2ArMe3WQiaIFfISz2/dAVvHKWAnMf18OxPESbYS
        ayacY4OoF5Q4OfMJC4jNDFTfvHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy021CtOzC0uzUvX
        S87P3cQIjMltx35u3sE479VHvUOMTByMhxglOJiVRHgvOb5KEeJNSaysSi3Kjy8qzUktPsRo
        CnT3RGYp0eR8YFLIK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpg
        WtXb4xm7cOIaPskfFt/lFn21n6m1qH5VsdP7w19jlKbrlpxZ3zPTb35/imyAeLza/U9Z8z8o
        rTi5X99NcMq5tSn9PYvNkpNOFe3h6vrKtFFx6ZqdTXsautPdk67MKTh6ZU3UWcbmpy+26/ez
        dHZ03JL9E3GG753Pni0/9T2mhrx3XzN37eKi47PtpcsrQvTMHfiuebq0/ClN4Dg+3aU0eFFI
        7nvtIwmrBSrXbVhb4uwf6993ypjnilvibinrhG7RY0Zq7vMv5m5RtprUqVAuV7suTmj7Kiun
        oCVXNr75deOiYFDJfdnUOUqJJcKvN+eFq+lOzPA9cTJvx82HqyYuET28pM3wyNQLOtNFan0d
        lFiKMxINtZiLihMBcVqSklIDAAA=
X-CMS-MailID: 20230829092415eucas1p1cb4d56f908e7851297b2c4ed59984b2f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230829092415eucas1p1cb4d56f908e7851297b2c4ed59984b2f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230829092415eucas1p1cb4d56f908e7851297b2c4ed59984b2f
References: <20230829091853.626011-1-m.majewski2@samsung.com>
        <CGME20230829092415eucas1p1cb4d56f908e7851297b2c4ed59984b2f@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to enable the clock separately, and this also allows us
to delegate the deinitialization to devm entirely.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 2c5501704911..49e9157c3dc7 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1027,17 +1027,11 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	switch (data->soc) {
 	case SOC_ARCH_EXYNOS5433:
 	case SOC_ARCH_EXYNOS7:
-		data->sclk = devm_clk_get(&pdev->dev, "tmu_sclk");
+		data->sclk = devm_clk_get_enabled(&pdev->dev, "tmu_sclk");
 		if (IS_ERR(data->sclk)) {
 			dev_err(&pdev->dev, "Failed to get sclk\n");
 			ret = PTR_ERR(data->sclk);
 			goto err_clk_sec;
-		} else {
-			ret = clk_prepare_enable(data->sclk);
-			if (ret) {
-				dev_err(&pdev->dev, "Failed to enable sclk\n");
-				goto err_clk_sec;
-			}
 		}
 		break;
 	default:
@@ -1055,13 +1049,13 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		if (ret != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "Failed to register sensor: %d\n",
 				ret);
-		goto err_sclk;
+		goto err_clk_sec;
 	}
 
 	ret = exynos_tmu_initialize(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize TMU\n");
-		goto err_sclk;
+		goto err_clk_sec;
 	}
 
 	ret = devm_request_threaded_irq(
@@ -1070,14 +1064,12 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		dev_name(&pdev->dev), data);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq: %d\n", data->irq);
-		goto err_sclk;
+		goto err_clk_sec;
 	}
 
 	exynos_tmu_control(pdev, true);
 	return 0;
 
-err_sclk:
-	clk_disable_unprepare(data->sclk);
 err_clk_sec:
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
@@ -1094,7 +1086,6 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 
 	exynos_tmu_control(pdev, false);
 
-	clk_disable_unprepare(data->sclk);
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
 
-- 
2.41.0


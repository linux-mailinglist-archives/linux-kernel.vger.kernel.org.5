Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B4E7F164E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjKTOwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjKTOvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:51:55 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600FE10F5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:51:02 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231120145101euoutp0109198847b973dd0f4b1e4c8efb349b20~ZXFaQD2El2522625226euoutp01a
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:51:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231120145101euoutp0109198847b973dd0f4b1e4c8efb349b20~ZXFaQD2El2522625226euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700491861;
        bh=7/6FemRmnMZSvOrVZ5Dgthh/u/9EWRsMZanz4+6xfv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WLp7tqlkH6Shr0I0HrIR7NILj9vCSP3es3tfHlsso5ygtjyb1mM4TZeyKm2gwfj2x
         vc+QnwKnOKRL0O5XTC8bzFJkzxV2LeBIMmjssd1SQjzrOng31VgEex1kwIdGSbKidA
         dBwyi5oBBJPNNTl47lSrKIY13ofP4yI5rxwZEwIk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231120145100eucas1p2d792b2b650f2806556d50436e7749079~ZXFZwjwh11100611006eucas1p2s;
        Mon, 20 Nov 2023 14:51:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 22.A8.09552.4527B556; Mon, 20
        Nov 2023 14:51:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231120145100eucas1p2c451ecec1274d7ba4eb337c409ef7fd2~ZXFZW5GXA1067610676eucas1p2q;
        Mon, 20 Nov 2023 14:51:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231120145100eusmtrp2b50a1b5194651c48b00e9cef7f0bff7d~ZXFZWNRHc0700707007eusmtrp2Y;
        Mon, 20 Nov 2023 14:51:00 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-78-655b72541292
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D1.C3.09146.4527B556; Mon, 20
        Nov 2023 14:51:00 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231120145059eusmtip28574b0da08cec730abbc281a878c265f~ZXFYg2CN00740707407eusmtip2X;
        Mon, 20 Nov 2023 14:50:59 +0000 (GMT)
From:   Mateusz Majewski <m.majewski2@samsung.com>
To:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Majewski <m.majewski2@samsung.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v5 2/9] thermal: exynos: drop id field
Date:   Mon, 20 Nov 2023 15:50:42 +0100
Message-ID: <20231120145049.310509-3-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120145049.310509-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djPc7ohRdGpBr+3KFk8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKC6blNSczLLUIn27BK6MrtNvmAom8VQc/z2LpYHxE2cXIyeHhICJxOTJbaxd
        jFwcQgIrGCU+/17FBpIQEvjCKNFxgQ0i8ZlRYua8XywwHRt3/4VKLGeU2Nt4mh3CaWWSuLzn
        PDtIFZuAgcSDN8vAbBGBVqD2JnWQImaBr8wSV1/PZwZJCAuYSZxsuAI2lkVAVWLZvFlgDbwC
        thJLD0yFWicvsWfRdyYQm1PATqLtyHM2iBpBiZMzn4DVMAPVNG+dzQyyQEKgn1Ni3/yZrBDN
        LhKtvd/YIWxhiVfHt0DZMhL/d85ngrDzJWZsfg80iAPIrpC4e9ALwrSW+HiGGcRkFtCUWL9L
        H6LYUeJwx2EmiAo+iRtvBSEO4JOYtG06M0SYV6KjTQiiWlXi+J5JzBC2tMSTlttQKz0kPq/8
        yD6BUXEWkldmIXllFsLeBYzMqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQIT2+l/x7/u
        YFzx6qPeIUYmDsZDjBIczEoivN+EIlKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ86qmyKcKCaQn
        lqRmp6YWpBbBZJk4OKUamEwm9R7wd03zbb7MwLMqJWzSrN0bCtw3pefOm9jyqnbn9u6eUL3t
        1UdTdQ2WPwv+cndJ4fM/Rcuba1bc3HnXY7/L59LH/8xmP7/bzXE7dX+zb2RYmmP+47o11+JV
        pp1dJ892/UD4pp6E3dP+3zWVatvBVdginrhnu/70tUrKiuo596wVJ+19fXK1/6X0uoliMevO
        reQqkrzCo30tIZO/y+fb0Qdr1nS9e31dnntthaGff8TmaZIMfn03zvJOt9QNeNqdoPdD43FQ
        6pm0TGHLzJwdyY+7ZSoNKrgVr79cKb9Yn69vzrYGgft5M70Pqeoe33F86/cbS1eklH6q3xxw
        dMW/Ar/XNk2apUnej+fPiFZiKc5INNRiLipOBAAWRLnn2wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7ohRdGpBtP/s1s8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLU
        In27BL2MrtNvmAom8VQc/z2LpYHxE2cXIyeHhICJxMbdf9m6GLk4hASWMkqcODqdGSIhLXH4
        yxR2CFtY4s+1LqiiZiaJO3+OgRWxCRhIPHizjB0kISLQySjRtfkcE0iCWeA/s8TXmQogtrCA
        mcTJhissIDaLgKrEsnmzwKbyCthKLD0wlQVig7zEnkXfwXo5Bewk2o48B9rGAbTNVqLjrgZE
        uaDEyZlPWCDGy0s0b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzEC
        43DbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEd5vQhGpQrwpiZVVqUX58UWlOanFhxhNgc6eyCwl
        mpwPTAR5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1M1hv4d/af
        tW32TAvl+uix9RT7TYcpbD1ukbbTHvQ8uGkeb+39PjwgI/UK06rD87S3Np5vfx69zLR87v7L
        GvuKV2kXldSZTJWUbHK1V68ROnQoLTpTXWK5g9n2hNRjjDvv58uXCjMdLM7byyJ7X+fnYZ+5
        B864q3678SEjXTYqYfLV83X7dA7Kie38lC7WKS2xsMF1brLKsY2HymYWpF6vNbURmyTR9FHi
        +SqVZVKssziuH6g0PR2xQXn5osieiUIO7P+XVdg8i53qmsljUiR7alluwR17aZeTO7perxLY
        ahVTtzTQ4Y9kdcM6+1rXWVPbzQX0tKIvJh1mlGd/nsGn2C1Ydrdxe+zy9THvVyqxFGckGmox
        FxUnAgBFytN+TAMAAA==
X-CMS-MailID: 20231120145100eucas1p2c451ecec1274d7ba4eb337c409ef7fd2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231120145100eucas1p2c451ecec1274d7ba4eb337c409ef7fd2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231120145100eucas1p2c451ecec1274d7ba4eb337c409ef7fd2
References: <20231120145049.310509-1-m.majewski2@samsung.com>
        <CGME20231120145100eucas1p2c451ecec1274d7ba4eb337c409ef7fd2@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not use the value, and only Exynos 7 defines this alias anyway.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v1 -> v2: minor commit message rewording.

 drivers/thermal/samsung/exynos_tmu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 187086658e8f..4ff32245d2a9 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -138,7 +138,6 @@ enum soc_type {
 /**
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
  *			    driver
- * @id: identifier of the one instance of the TMU controller.
  * @base: base address of the single instance of the TMU controller.
  * @base_second: base address of the common registers of the TMU controller.
  * @irq: irq number of the TMU controller.
@@ -172,7 +171,6 @@ enum soc_type {
  * @tmu_clear_irqs: SoC specific TMU interrupts clearing method
  */
 struct exynos_tmu_data {
-	int id;
 	void __iomem *base;
 	void __iomem *base_second;
 	int irq;
@@ -865,10 +863,6 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	if (!data || !pdev->dev.of_node)
 		return -ENODEV;
 
-	data->id = of_alias_get_id(pdev->dev.of_node, "tmuctrl");
-	if (data->id < 0)
-		data->id = 0;
-
 	data->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
 	if (data->irq <= 0) {
 		dev_err(&pdev->dev, "failed to get IRQ\n");
-- 
2.42.0


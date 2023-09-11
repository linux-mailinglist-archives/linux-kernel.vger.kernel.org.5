Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EA579B4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352966AbjIKVtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238060AbjIKNgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:36:20 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22A7125
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:36:15 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230911133614euoutp02ca152620330b7244c72a1bd364cb643f~D26I0cith1421914219euoutp02_
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:36:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230911133614euoutp02ca152620330b7244c72a1bd364cb643f~D26I0cith1421914219euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694439374;
        bh=+NqJJH6X7tjJ6+L0iqf3etPp0U96Y5vmOPMMdXKrkyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gL49LS8pN2n8bl4Z2YCwljc/5qiPRvxI2blDai5o2dbafyUHwMxP8zmLrNNdXjSRc
         zOTUSDvCchEZTTOWJz81CkE0tDhxaDVmvUmCPZaUNHDofo5unDkyKM+4uCflyHtjqw
         iKS2zDmHliAt6d/KGy2qQMNdtI/t0ocL1zG3Hvy0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230911133614eucas1p2a6f24ec6a713974c775678e9c2003a01~D26IbnJrG2317523175eucas1p26;
        Mon, 11 Sep 2023 13:36:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B5.B1.42423.EC71FF46; Mon, 11
        Sep 2023 14:36:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230911133613eucas1p1671b7d154e1d567b02516d8c4d8074ab~D26IBuEM31288212882eucas1p1u;
        Mon, 11 Sep 2023 13:36:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230911133613eusmtrp263e49da0aa697d53623dc88f9bfdfffc~D26IBDe3x0864008640eusmtrp2U;
        Mon, 11 Sep 2023 13:36:13 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-5a-64ff17ce85f2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 17.BB.10549.DC71FF46; Mon, 11
        Sep 2023 14:36:13 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230911133612eusmtip2be196bc65de7d8b30f10c76d75aaf216~D26Gwe_vL0323103231eusmtip2N;
        Mon, 11 Sep 2023 13:36:12 +0000 (GMT)
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
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 2/7] thermal: exynos: drop id field
Date:   Mon, 11 Sep 2023 15:34:26 +0200
Message-ID: <20230911133435.14061-3-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911133435.14061-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djPc7rnxP+nGCy9yWzxYN42NovD8yss
        pj58wmbxfct1Jot5n2Ut9r7eym7x7UoHk8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCwmHpvMbLH2
        yF12i7lfpjJbPHnYx+bA77Fz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9+rasYvT4vEkugD2K
        yyYlNSezLLVI3y6BK2PCxV0sBZN4Km4ff8fawPiJs4uRk0NCwERi7cc1bF2MXBxCAisYJRat
        +wnlfGGU+D9zAQuE85lR4lvHDXaYlpbe7awgtpDAckaJ1muuEEWtTBK7J99lAkmwCRhIPHiz
        DKxBRKCVUWJmkzpIEbPAJWaJuzfXsoAkhAXMJA603QBrYBFQlXhwagFYnFfARuLkY4hBEgLy
        Es9v3QEbxClgK3F27XR2iBpBiZMzn4DVMwPVNG+dzQyyQEKgmVPi0tseRohmF4l31+axQtjC
        Eq+Ob4F6QUbi/875UAvyJWZsfg80iAPIrpC4e9ALwrSW+HiGGcRkFtCUWL9LH6LYUWLei19Q
        xXwSN94KQhzAJzFp23RmiDCvREebEES1qsTxPZOYIWxpiSctt6FWekicf/uOZQKj4iwkr8xC
        8soshL0LGJlXMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBCax0/+Of9rBOPfVR71DjEwc
        jIcYJTiYlUR4Sw79TRHiTUmsrEotyo8vKs1JLT7EKM3BoiTOq217MllIID2xJDU7NbUgtQgm
        y8TBKdXAZLXk5Pll+9OXrDp1M8FGcHd4mLDdE8nabbtuB69aJnI8f+qhb+vOCdvM3O5dFHFg
        5laBTO3t/yt3Ma12+DvvqOW7aWwtZUYOyrcurNzQW/SnxreEqbfmleyOlyccJV8L6unJ7fBQ
        0DUKe37jzpuNl4JV16kKJvPxXjjNcLY4oPRZSO2tCq5PcSayZ+0ET+9xFTn/17Nli3FwmfiM
        9a1rVspbXtR7GuEgu+5Y3e9l7iyrcs6IJJ+SKPgkfdrQ1svcm8O9eHbUPu1ctksX+q/tm/w8
        p/uF9aH9E7J/CR7tSRK+tdT783rvY9q3mRh/KmZ129fmGj7yzI2unDqDdfPvpCrZT4vEC0/J
        PpgmHNuzVImlOCPRUIu5qDgRALRGpKjRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xe7pnxf+nGLT9VrZ4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB6l
        Z1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eglzHh4i6W
        gkk8FbePv2NtYPzE2cXIySEhYCLR0rudtYuRi0NIYCmjxK0DLxghEtISh79MYYewhSX+XOti
        gyhqZpL4PekfM0iCTcBA4sGbZewgCRGBTkaJrs3nmEASzAK3mCXuv9YCsYUFzCQOtN0Ai7MI
        qEo8OLWABcTmFbCROPn4LhPEBnmJ57fugG3jFLCVOLt2OpDNAbTNRqL/jA5EuaDEyZlPWCDG
        y0s0b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECY27bsZ+bdzDO
        e/VR7xAjEwfjIUYJDmYlEd6SQ39ThHhTEiurUovy44tKc1KLDzGaAp09kVlKNDkfGPV5JfGG
        ZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MwS8PH1raGOjDvGW3/sfN
        bDPWH7M79YXDhjtCruuL5MXmlA1hUxaEP2FjzGPIn3HudcA/9kWesf7K0fs/n8pIm/H7x+Ot
        s0QZ9+25/yhp3w6pC2ec20XaDz8JZjwu9aIxS2Jm6YXnbQl/jf2Lzn2dF7+5+YyZc+qrtZnb
        l8++t+D79MOzDBcV117wC/A9y3FixfoqJQYVnR1cez9Us+Sxaad3tdcKa4sltuczXNO03G38
        6YBhk2SEs0z1+zZBj+A7m1vlk7do70x3DVurp/j0443pvw3CFn8Q3/XzXeCvTQJztz8/wHDb
        XZKbi9umabsva1npzz4JPqXtPGyGQZGMfPZi3MbFQnyzqhcZBjxQYinOSDTUYi4qTgQAwn0I
        NUIDAAA=
X-CMS-MailID: 20230911133613eucas1p1671b7d154e1d567b02516d8c4d8074ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230911133613eucas1p1671b7d154e1d567b02516d8c4d8074ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230911133613eucas1p1671b7d154e1d567b02516d8c4d8074ab
References: <20230911133435.14061-1-m.majewski2@samsung.com>
        <CGME20230911133613eucas1p1671b7d154e1d567b02516d8c4d8074ab@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 2c1cfb8c4b33..90c33e8017af 100644
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
2.41.0


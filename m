Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AE68007AB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378164AbjLAJ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378091AbjLAJ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:56:39 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6421A170C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:56:43 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231201095642euoutp01e837685593f85d36436cfcf0e4d79535~crKlBNoSN0037200372euoutp01y
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:56:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231201095642euoutp01e837685593f85d36436cfcf0e4d79535~crKlBNoSN0037200372euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701424602;
        bh=7/6FemRmnMZSvOrVZ5Dgthh/u/9EWRsMZanz4+6xfv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFJRsnwtIDxRUMsRDHq5KrOSWtf556jQvRLBaV4CTL85UfgxT08POeEMoAmYMmdss
         HhgHp8BOfFv7kVXkKUP6ZbzInqF6SJgvGMLwEKKgKt1nobjc7VruZAmZNwKOG3pwMh
         6JJBObk1BWccZTNnlhoa1wl6NkQ2wQx+P1z4Il7c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231201095641eucas1p2e62de350f9c76a28b8181f0f3f64dc2a~crKkoi4IA3113731137eucas1p2K;
        Fri,  1 Dec 2023 09:56:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 24.42.09814.9DDA9656; Fri,  1
        Dec 2023 09:56:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231201095641eucas1p26fc829eb32caf077c80cbd0ba97cc4b4~crKkOfotA2712227122eucas1p2G;
        Fri,  1 Dec 2023 09:56:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231201095641eusmtrp27618143a0e39dce2a4cb4121c5c44408~crKkNPDBs2064820648eusmtrp2D;
        Fri,  1 Dec 2023 09:56:41 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-e8-6569add952a3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EA.12.09274.9DDA9656; Fri,  1
        Dec 2023 09:56:41 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231201095640eusmtip2c0dcf3ac5b5cef81904bac9e9cb318ce~crKjTEfyV1189011890eusmtip2x;
        Fri,  1 Dec 2023 09:56:40 +0000 (GMT)
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
        Lukasz Luba <lukasz.luba@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v6 2/9] thermal: exynos: drop id field
Date:   Fri,  1 Dec 2023 10:56:18 +0100
Message-ID: <20231201095625.301884-3-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201095625.301884-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djP87o312amGqzbo2bxYN42NovD8yss
        pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
        1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4MroOv2GqWAST8Xx37NYGhg/cXYxcnJICJhI
        vDtzgbGLkYtDSGAFo8T/gzDOF0aJF+9PM4JUCQl8ZpQ4dMm2i5EDrKPndy1EzXJGiW/LdjBB
        OK1MEj+uPWcBaWATMJB48GYZO4gtItDKKDGzSR3EZhZYyCLR8i8XxBYWMJM492ESG8hQFgFV
        iRsLw0BMXgFbib+bqyGOk5fYs+g7E4jNKWAnMf9QK9h0XgFBiZMzn7BATJSXaN46mxnkBAmB
        2ZwSHVO/MkI0u0hcXvCCHcIWlnh1fAuULSPxf+d8Jgg7X2LG5vcsEH9VSNw96AVhWkt8PMMM
        YjILaEqs36UPUewose/wcWaICj6JG28FIQ7gk5i0bTpUmFeio00IolpV4vieScwQtrTEk5bb
        UCs9JM7O6WGawKg4C8krs5C8Mgth7wJG5lWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiB
        qe30v+NfdjAuf/VR7xAjEwfjIUYJDmYlEd7rT9NThXhTEiurUovy44tKc1KLDzFKc7AoifOq
        psinCgmkJ5akZqemFqQWwWSZODilGpjMpjhvixWoElG6uOtGqJM9R+OdeTc0P4Vd+3iNrcn7
        DftZ35ToZ9/+3HfYsO7I1MYAV7PqJ/8/L4j3Ydv38HV8Et+3u2mtc5ykxP48VJjB9lDw2IIT
        qrW1Nj/ZnVszX6avTTV+mn6dk/HKlXv72U79s7ux9syhuA8H/tyceT9dmFM05/0F447MYvt9
        KuoRTPEaL9mCdFxqyq5KRvDLZ5pXb76d9HvF9J13DtaYPF04eUaN82EHxXu5UUfdmc+GKBxe
        bZj22OupsFz6BCF5iaaD864y3ds6oUz2beF9vYena+a/TqiwCzn+JfOgxLuq2zlv+Ds+dfFl
        dJeEOMxrWP8xJqXutdStksKvk5abbBdWYinOSDTUYi4qTgQAid3bBdwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7o312amGky9zGvxYN42NovD8yss
        pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
        1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0MvoOv2GqWAST8Xx37NYGhg/cXYxcnBICJhI9Pyu7WLk4hASWMoo0dfwn62L
        kRMoLi1x+MsUdghbWOLPtS42iKJmJolp06cwgSTYBAwkHrxZxg6SEBHoZJTo2nyOCcRhFljN
        InFs33ewKmEBM4lzHyaxgaxjEVCVuLEwDMTkFbCV+Lu5GmKBvMSeRRDVnAJ2EvMPtbKA2EJA
        JV1b/jOC2LwCghInZz4BizMD1Tdvnc08gVFgFpLULCSpBYxMqxhFUkuLc9Nzi430ihNzi0vz
        0vWS83M3MQLjcduxn1t2MK589VHvECMTB+MhRgkOZiUR3utP01OFeFMSK6tSi/Lji0pzUosP
        MZoCXT2RWUo0OR+YEPJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODil
        GpjWOR1cEpPyw/HuhOvyasnLVZ3Fl+2L7zyy8prWv2KXH/u27800TNJ5rGU76+0V/Xn8WkwH
        TgUx5lxz+nuMvbjHzu4CP7fbvmNrz29M5s88+jlgs3ldyuF9H5leqSh35JV94r/Ra3fkrd2J
        1rbtDySPhuypm8eldnKfd93L7Q/2uAfVCE177xk4Py+g7ZrP34/Smpf+clTt0FAy+L0gbVKM
        4VyTb1lssvFzp9vp2XIfliiL41wx0eleaOvKgJM9iyedite/7M9fdtjz3ofHATxmSr8EV397
        9j6Wact23y8TglYHGP66s/f86c21Ozr+qBz+9PxXFMvfPT5X3rE8lNdI+bFyWXMd13lW5/Si
        xCMflViKMxINtZiLihMBlmMCAVADAAA=
X-CMS-MailID: 20231201095641eucas1p26fc829eb32caf077c80cbd0ba97cc4b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231201095641eucas1p26fc829eb32caf077c80cbd0ba97cc4b4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231201095641eucas1p26fc829eb32caf077c80cbd0ba97cc4b4
References: <20231201095625.301884-1-m.majewski2@samsung.com>
        <CGME20231201095641eucas1p26fc829eb32caf077c80cbd0ba97cc4b4@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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


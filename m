Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C32F78C160
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbjH2JZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjH2JYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:24:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85405194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:24:28 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230829092427euoutp024ef14dc588a002db832153083fa89138~-0FloTE4W0626806268euoutp028
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:24:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230829092427euoutp024ef14dc588a002db832153083fa89138~-0FloTE4W0626806268euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693301067;
        bh=C5FbbJybvkzNZK0Gyfa1Nr5aayYuC3Mc7brz6IA0CMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVkjLOvj3Z31jVU0WNO4Oh6iftr4rtmAGsRhgRDc50KAQUk3VREsqs9WV6mFAT/1k
         QYS+eKvVaCWSlQbtkIZhlhNfDdv4fY5K86GMw2LhPcszKH67c4VarN8VNOrKaIrjt3
         xdvDLwxUggKHeELLNT5tqBcSDQMeUzjjfv3q2FFk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230829092426eucas1p2d03704c98d91b12179f2b29af682988e~-0FlSALwA2824228242eucas1p2a;
        Tue, 29 Aug 2023 09:24:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F4.8F.37758.A49BDE46; Tue, 29
        Aug 2023 10:24:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092426eucas1p222c2a1c2013f4eb9ee739f03761e5236~-0FkfWmzM2729627296eucas1p2j;
        Tue, 29 Aug 2023 09:24:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230829092426eusmtrp171367fb1384d1ee8b77399c5b6dc0598~-0FketUkS3248032480eusmtrp1V;
        Tue, 29 Aug 2023 09:24:26 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-7c-64edb94aa42a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6F.E9.10549.949BDE46; Tue, 29
        Aug 2023 10:24:26 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092425eusmtip286b9ff2658d36cd4f3a82c6ae94a37bf~-0FjjIsYn1321813218eusmtip2F;
        Tue, 29 Aug 2023 09:24:25 +0000 (GMT)
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
Subject: [PATCH 11/11] ARM: dts: exynos: disable polling in Odroid
 XU3-related devices
Date:   Tue, 29 Aug 2023 11:18:49 +0200
Message-ID: <20230829091853.626011-12-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829091853.626011-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djPc7peO9+mGLS1GVs8mLeNzeLw/AqL
        qQ+fsFl833KdyWLN3nNMFvM+y1rMP3KO1aLvxUNmi29XOpgsNj2+xmpxedccNovPvUcYLWac
        38dkMfHYZGaLtUfuslvM/TKV2aJ17xF2iycP+9gchDx2zrrL7rF4z0smj02rOtk87lzbw+ax
        eUm9R9+WVYwenzfJBbBHcdmkpOZklqUW6dslcGUs/rGKpWCmcMWrluXsDYw/+LoYOTkkBEwk
        jh6bxdzFyMUhJLCCUeLr6VssEM4XRok/D99COZ8ZJdYsmsAE03KhdwkrRGI5UNW15ywgCSGB
        ViaJD3/8QGw2AQOJB2+WsYMUiQgsZpTYunMWE4jDLDCXRaJh5U+wDmGBCIn5F7cyg9gsAqoS
        n49OBFvBK2An8fnuITaIdfISz2/dYQexOYHi08+3Q9UISpyc+QRsDjNQTfPW2WBfSAhM55SY
        8OEQI0Szi8Tq9Y+gbGGJV8e3sEPYMhKnJ/ewQNj5EjM2vweyOYDsCom7B70gTGuJj2eYQUxm
        AU2J9bv0IYodJS6+fAVVzCdx460gxAF8EpO2TWeGCPNKdLQJQVSrShzfM4kZwpaWeNJyGxqE
        HhJHGxeyT2BUnIXklVlIXpmFsHcBI/MqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwCR3
        +t/xrzsYV7z6qHeIkYmD8RCjBAezkgjvJcdXKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5tW1P
        JgsJpCeWpGanphakFsFkmTg4pRqYOvjfPPo9w3n/ZxOtq9p+m/63OG/gNbddwtLVpHlH6Dm/
        ovjmvk95U66xJd9WagvL4uTy5GWQDMh14Ipnj/AvmfE9TLv1xA6Xjfnz1vF9cV7YsW1u4TTv
        0z7K/xpNmlYc0TztxtrR4BWsItnfZVtg++SksMN8iXqOJ/5cpQt2KHWz2W5/Xvu1alKXbMLX
        py/LwzJfaR2ym5Yc5PfqePE7fbd1gb9nTWuNrJqnfOllzZmIiJaTMyevOHL0y2nvrrS7FevC
        pCNNr/65sjZ5fcbyv5lHwi5NVNWP3KrxQjosJWQC18z7NoddVF6alqd5r/y25O92gdqtqjLf
        bk5bcfLsEd7qGB6lPzybfI59aDNRYinOSDTUYi4qTgQAAH5OSuEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xe7peO9+mGDzrZrJ4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8WaveeYLOZ9lrWYf+Qcq0Xfi4fMFt+udDBZbHp8jdXi8q45bBafe48wWsw4
        v4/JYuKxycwWa4/cZbeY+2Uqs0Xr3iPsFk8e9rE5CHnsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC2CP0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0MtY/GMVS8FM4YpXLcvZGxh/8HUxcnJICJhIXOhdwtrFyMUhJLCUUWLVpT3M
        EAlpicNfprBD2MISf651sUEUNTNJrNq7HSzBJmAg8eDNMnaQhIjAckaJq/eWs4A4zALLWSSe
        r/kANkpYIEzi1ZZZLCA2i4CqxOejE5lAbF4BO4nPdw+xQayQl3h+6w7YVE6g+PTz7WA1QgK2
        EmsmnGODqBeUODnzCdgcZqD65q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xoV5xYm5xaV66
        XnJ+7iZGYFRuO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMJ7yfFVihBvSmJlVWpRfnxRaU5q8SFG
        U6C7JzJLiSbnA9NCXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QD
        k3Be8HQ7fv9tQp5bn8frJ/2fssXAn3vLpbqLhfJ5i7fZe8hO9b0tMGHtGhNj6Q0STUbahSxr
        769WCS/6/Mfe6GR2YdJdy5yb8ZIf181OKvRJn6i7+fOmOhsmnnMc3bPz0926nTW3bNsyr9v1
        45lezQd1Ec+dfV7deXh6Vkzvnh0rdG8qO233TtnKpDHT8Av/1YLc71XqtcuXSc8Vv6Tzo/Fm
        m7/PadaCu798u5etuLfy2Ic/eeHLnM/cKewOly8+kbHi/PfMrCWG++8UFCxaL9rGZS3dzT5X
        etH8lPzaB4pPwtje9kcUztf58ONcl6VFy+cNvyrtzBkmqv5/s/2Fj37gxm9203myf3AcvKbV
        rsRSnJFoqMVcVJwIAJuplj5TAwAA
X-CMS-MailID: 20230829092426eucas1p222c2a1c2013f4eb9ee739f03761e5236
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230829092426eucas1p222c2a1c2013f4eb9ee739f03761e5236
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230829092426eucas1p222c2a1c2013f4eb9ee739f03761e5236
References: <20230829091853.626011-1-m.majewski2@samsung.com>
        <CGME20230829092426eucas1p222c2a1c2013f4eb9ee739f03761e5236@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After having switched to dynamic trip points, we no longer have a
hardware limit for trip point count and can support as many as we want
without polling.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 .../dts/samsung/exynos5422-odroidxu3-common.dtsi | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/samsung/exynos5422-odroidxu3-common.dtsi
index b4a851aa8881..4a4c55a4beb3 100644
--- a/arch/arm/boot/dts/samsung/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos5422-odroidxu3-common.dtsi
@@ -55,7 +55,7 @@ fan0: pwm-fan {
 	thermal-zones {
 		cpu0_thermal: cpu0-thermal {
 			thermal-sensors = <&tmu_cpu0>;
-			polling-delay-passive = <250>;
+			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			trips {
 				cpu0_alert0: cpu-alert-0 {
@@ -78,12 +78,6 @@ cpu0_crit0: cpu-crit-0 {
 					hysteresis = <0>; /* millicelsius */
 					type = "critical";
 				};
-				/*
-				 * Exynos542x supports only 4 trip-points
-				 * so for these polling mode is required.
-				 * Start polling at temperature level of last
-				 * interrupt-driven trip: cpu0_alert2
-				 */
 				cpu0_alert3: cpu-alert-3 {
 					temperature = <70000>; /* millicelsius */
 					hysteresis = <10000>; /* millicelsius */
@@ -144,7 +138,7 @@ cpu0_cooling_map4: map4 {
 		};
 		cpu1_thermal: cpu1-thermal {
 			thermal-sensors = <&tmu_cpu1>;
-			polling-delay-passive = <250>;
+			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			trips {
 				cpu1_alert0: cpu-alert-0 {
@@ -217,7 +211,7 @@ cpu1_cooling_map4: map4 {
 		};
 		cpu2_thermal: cpu2-thermal {
 			thermal-sensors = <&tmu_cpu2>;
-			polling-delay-passive = <250>;
+			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			trips {
 				cpu2_alert0: cpu-alert-0 {
@@ -290,7 +284,7 @@ cpu2_cooling_map4: map4 {
 		};
 		cpu3_thermal: cpu3-thermal {
 			thermal-sensors = <&tmu_cpu3>;
-			polling-delay-passive = <250>;
+			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			trips {
 				cpu3_alert0: cpu-alert-0 {
@@ -363,7 +357,7 @@ cpu3_cooling_map4: map4 {
 		};
 		gpu_thermal: gpu-thermal {
 			thermal-sensors = <&tmu_gpu>;
-			polling-delay-passive = <250>;
+			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			trips {
 				gpu_alert0: gpu-alert-0 {
-- 
2.41.0


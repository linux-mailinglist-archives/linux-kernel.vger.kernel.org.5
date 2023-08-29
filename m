Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7294378C135
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjH2JY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbjH2JYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:24:21 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE5BCDA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:24:07 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230829092406euoutp017b5e269d73652adea5c078c9ad6ef1ef~-0FSV2XUJ1639316393euoutp017
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:24:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230829092406euoutp017b5e269d73652adea5c078c9ad6ef1ef~-0FSV2XUJ1639316393euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693301046;
        bh=Yg71emI7rkUdONEcXXwkkssF2zl7EmPpwlLXh4qDTeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bch6VWVrwatFoif+HJy2ySqOXNzxoOhIp/MdTfjgJA024r16aGms8BkL/p94K3kyZ
         3Y7tjFmzFgq3tmDpeTwEQ/WlQXZNFJMm13ZH0F7PHpQpRuA8isWaN1y9s8X3/ab97H
         dBRnqH9vtEs5KGi1mFqHvnkzNifvRTZHpOG7nljU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230829092405eucas1p1fc83dded4ba331d6d818eff146d8f59c~-0FRdLMgt2328123281eucas1p1f;
        Tue, 29 Aug 2023 09:24:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DD.17.11320.539BDE46; Tue, 29
        Aug 2023 10:24:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230829092405eucas1p14543d527d81e8714594ebb999ab5fc02~-0FQ_bvLQ2331823318eucas1p1q;
        Tue, 29 Aug 2023 09:24:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230829092405eusmtrp1060d9335f88fe2227d244eed14cf210f~-0FQ9gpQQ3248032480eusmtrp1V;
        Tue, 29 Aug 2023 09:24:05 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-ee-64edb935cd4d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 86.D9.10549.439BDE46; Tue, 29
        Aug 2023 10:24:05 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092404eusmtip2341d0d647936b47a733e98d3e2a655bb~-0FP-6-gg1072510725eusmtip2i;
        Tue, 29 Aug 2023 09:24:04 +0000 (GMT)
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
Subject: [PATCH 01/11] ARM: dts: exynos: enable polling in Exynos 4210
Date:   Tue, 29 Aug 2023 11:18:39 +0200
Message-ID: <20230829091853.626011-2-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829091853.626011-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djP87qmO9+mGNz8rWDxYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJXxuDO04BFHxcOLj9kaGBeydzFyckgImEhc
        WTuPtYuRi0NIYAWjxJzr16CcL4wSP3euY4FwPjNKTH1yFa5lQvsRNojEckaJVY2f2SGcViaJ
        53f62UCq2AQMJB68WQaWEBFYzCixdecsJhCHWWAui0TDyp8sIFXCAm4SD168ZO5i5OBgEVCV
        ePkzDiTMK2ArsXrHMjaIdfISz2/dAVvNKWAnMf18OxNEjaDEyZlPwMYwA9U0b53NDDJfQmA2
        p8TRDzeZIZpdJPYdus8IYQtLvDq+BeoHGYnTk3tYIOx8iRmb37OA3CAhUCFx96AXhGkt8fEM
        2GXMApoS63fpQ0QdJY7sLoQw+SRuvBWE2M8nMWnbdGaIMK9ER5sQxGRVieN7JkFdIi3xpOU2
        E4TtIfHmwEfWCYyKs5B8MgvJJ7MQ1i5gZF7FKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kR
        mOBO/zv+ZQfj8lcf9Q4xMnEwHmKU4GBWEuG95PgqRYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv
        tu3JZCGB9MSS1OzU1ILUIpgsEwenVAOT55fYsuN7jeUF74fMtRDwnCvK3LHvWJPGdkamoMtR
        +T1vO5+65bu03HCNiNE02fX7c1mQc+yLmn0bhSq/fF2XXaV/plbnp7KoY8z2zVKe5S0xC7K/
        JNrHT2Hy9i2oW39gf7LrriRh/UybDVujwjVee/2a2Bm0I/6z3Pymt/56W+0+vuv8InGgq8v4
        b9LdU8+u9u3YniD9qPH+4s4zd96fSsw8Gfpd8DqjlVpnf+RdmTyjM/Z9ZTWGcay89UrymXsu
        O9w9devJu0d/y05X75h266LqsmcTrR9eiy9bzf5s3s2Loi0bHWayXpmkv2pLUg3Pw+5Jczku
        bih7kr3iY93+mpgGMa3fBedMXhT4Xf2ixFKckWioxVxUnAgAYdxA9N8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7qmO9+mGCy4xWjxYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
        kpqTWZZapG+XoJfxuDO04BFHxcOLj9kaGBeydzFyckgImEhMaD/C1sXIxSEksJRRYlZDKyNE
        Qlri8JcpUEXCEn+udUEVNTNJrL7ZywqSYBMwkHjwZhk7SEJEYDmjxNV7y1lAHGaB5SwSz9d8
        YAapEhZwk3jw4iWQzcHBIqAq8fJnHEiYV8BWYvWOZWwQG+Qlnt+6A7aNU8BOYvr5diYQWwio
        Zs2Ec2wQ9YISJ2c+YQGxmYHqm7fOZp7AKDALSWoWktQCRqZVjCKppcW56bnFhnrFibnFpXnp
        esn5uZsYgRG57djPzTsY5736qHeIkYmD8RCjBAezkgjvJcdXKUK8KYmVValF+fFFpTmpxYcY
        TYHOnsgsJZqcD0wJeSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFIN
        TAs+e0lIMGtM0XyiW7N2R1uubtOdizsKq9dFbqv1m6eWuW7m7qANfSuXSsZ462qtmFp5Q/u6
        Rfoq+bvzOxfzK5pprf137ILEhryXb4/lHpb6Mf2PxrXHktl3syb8qLK9tCazwzthZmzEuYkL
        b/BGHnq6pUysbsavmmmH13839+PQPsObe7x5o/YZ+Tzz2SVVvXzqXisXFsye5lP373Vx0nyF
        8oc7W7m/f/Qx4hfbKvRWv42BL+Xs9nyLubvPHHm/qXrX1p1VL0TWNzwu6TLJ6J51o3iSh/Lk
        lbcULLfGGXWfrTifuSOusGrOetunuZ7rfzcyLmCR+/PlRuP+xXd8e45YPkj+zLZZY0qvpqS5
        f6kSS3FGoqEWc1FxIgDhwqItUQMAAA==
X-CMS-MailID: 20230829092405eucas1p14543d527d81e8714594ebb999ab5fc02
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230829092405eucas1p14543d527d81e8714594ebb999ab5fc02
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230829092405eucas1p14543d527d81e8714594ebb999ab5fc02
References: <20230829091853.626011-1-m.majewski2@samsung.com>
        <CGME20230829092405eucas1p14543d527d81e8714594ebb999ab5fc02@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that thermal in Exynos 4210 is broken without this, as it will
never decrease cooling after increasing it.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 arch/arm/boot/dts/samsung/exynos4210.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4210.dtsi b/arch/arm/boot/dts/samsung/exynos4210.dtsi
index 0e27c3375e2e..aae185b7f91c 100644
--- a/arch/arm/boot/dts/samsung/exynos4210.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4210.dtsi
@@ -391,8 +391,14 @@ &cpu_alert2 {
 };
 
 &cpu_thermal {
-	polling-delay-passive = <0>;
-	polling-delay = <0>;
+	/* Exynos 4210 supports thermal interrupts, but only for the rising threshold.
+	 * This means that polling is not needed for preventing overheating, but only
+	 * for decreasing cooling when possible. Hence we poll with a high delay.
+	 * Ideally, we would disable polling for the first trip point, but this isn't
+	 * really possible without outrageous hacks.
+	 */
+	polling-delay-passive = <5000>;
+	polling-delay = <5000>;
 };
 
 &gic {
-- 
2.41.0


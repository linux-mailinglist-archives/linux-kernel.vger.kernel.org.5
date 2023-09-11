Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7167079BBEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358204AbjIKWIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbjIKNei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:34:38 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4379125
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:34:33 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230911133432euoutp01324d7369faf3bf9e1c54bdb51078a7bb~D24prf-Gk2173821738euoutp010
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:34:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230911133432euoutp01324d7369faf3bf9e1c54bdb51078a7bb~D24prf-Gk2173821738euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694439272;
        bh=/mi0r8mYaalw3knCfTu3gBJk6obrNHW3Nz7s/KCIWgA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ZACIlGI+2K8qVA2wGGgkJ4C/t5HRDYg7t2BFIYdgS/atNu/6dHSTZ4pHoAUSMMEgD
         uZRFAZJ9y9J/SCGSLx0JoFT3tAKlZMPdMIavKgB4IiToeAau8O7r58ojHodiJSGL1S
         p15VddbXacVKEycNj8sKNWq/fm2QK8/Uwv1e2n4k=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230911133431eucas1p1028e1babd7fda9c36d15da5ac371d780~D24pUSUXl3154231542eucas1p1H;
        Mon, 11 Sep 2023 13:34:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9C.41.42423.7671FF46; Mon, 11
        Sep 2023 14:34:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230911133431eucas1p2631e7060cecb0914933ed45b837cf8eb~D24o3k1BS1712417124eucas1p2g;
        Mon, 11 Sep 2023 13:34:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230911133431eusmtrp2f45317b7cd9c99c65a5faf1e744acb79~D24o2pvFw0730407304eusmtrp2T;
        Mon, 11 Sep 2023 13:34:31 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-c7-64ff1767793b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A2.2A.14344.7671FF46; Mon, 11
        Sep 2023 14:34:31 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230911133430eusmtip1cfb8f5bcad10b64100b515751c11ecd7~D24oSDyBB2147821478eusmtip12;
        Mon, 11 Sep 2023 13:34:30 +0000 (GMT)
From:   Mateusz Majewski <m.majewski2@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Majewski <m.majewski2@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2] ARM: dts: exynos: enable polling in Exynos 4210
Date:   Mon, 11 Sep 2023 15:34:14 +0200
Message-ID: <20230911133417.14042-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djP87rp4v9TDGZNMbd4MG8bm8WaveeY
        LOYfOcdq0ffiIbPFpsfXWC0u75rDZjHj/D4mi4nHJjNbrD1yl92ide8Rdgcuj02rOtk87lzb
        w+axeUm9R9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGW8WPaWveApZ8W/a19YGxi7OLoYOTkk
        BEwktlw/xt7FyMUhJLCCUWLej7+MEM4XRolZj5+yQTifGSUevz3KBtPy/fpOqJbljBJnTi6B
        amllkphxbQILSBWbgIHEgzfLwKpEBNoZJRbcfcYM4jALdDJJvP86nRWkSljAWeLKu2Z2EJtF
        QFXi8MMXYDavgI3E9M5WFoh98hLPb92BigtKnJz5BCzODBRv3jobbKiEwBYOicV/IZolBFwk
        vq/YzQphC0u8Or4FKi4j8X/nfCYIO19ixub3QIM4gOwKibsHvSBMa4mPZ5hBTGYBTYn1u/Qh
        ih0lLpz7yAZRwSdx460gxAF8EpO2TWeGCPNKdLQJQVSrShzfM4kZwpaWeNJyG2qlh8TH5xB/
        CwnESlyYNZtxAqPCLCRvzULy1iyEGxYwMq9iFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQI
        TEOn/x3/tINx7quPeocYmTgYDzFKcDArifCWHPqbIsSbklhZlVqUH19UmpNafIhRmoNFSZxX
        2/ZkspBAemJJanZqakFqEUyWiYNTqoFp1qIFbsy9Gz/1GDLf/7Vku17s+WsFX6IVyrRmzwhv
        jGc8tYw9kmFZh1fDAbOYvfM43fP03gUm/Wjg/PdSOvpqUpGpYftWlro99S5rZs46tbwkQPTH
        n4M+5+aGNkR3P8iqFlujPbXu2w43hQC/vz979OW1jn4RWxC/MDD7tiVzA2fmUVWHnS6Ohltk
        32uK3X+rlHU+Qnp6kPxalW/JbbJ9uifnrqzQDHavfHvny4VHPNo39pqFy20QLL6oa1S2oGTh
        qvqza6PPV0XrxrNKXGl89e/7jeNhtw4913o7JS+rbPoTpfoz/5Jbg4u2dS62d9l64eHbd3H1
        u///E7Oe2Zv7YcU+o/dltTZr5p5OO71UiaU4I9FQi7moOBEAtI+1FLIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsVy+t/xu7rp4v9TDLoXS1k8mLeNzWLN3nNM
        FvOPnGO16HvxkNli0+NrrBaXd81hs5hxfh+TxcRjk5kt1h65y27RuvcIuwOXx6ZVnWwed67t
        YfPYvKTeo2/LKkaPz5vkAlij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX0
        7WxSUnMyy1KL9O0S9DJeLHvLXvCUs+LftS+sDYxdHF2MnBwSAiYS36/vZO9i5OIQEljKKHHi
        7yN2iIS0xOEvU6BsYYk/17rYIIqamSRW/57CDJJgEzCQePBmGVi3iEA3o8ShmbdYQBxmgW4m
        ie7FjxhBqoQFnCWuvGsGG8UioCpx+OELMJtXwEZiemcrC8QKeYnnt+5AxQUlTs58AhZnBoo3
        b53NPIGRbxaS1CwkqQWMTKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECo2DbsZ9bdjCufPVR
        7xAjEwfjIUYJDmYlEd6SQ39ThHhTEiurUovy44tKc1KLDzGaAt03kVlKNDkfGId5JfGGZgam
        hiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1M6llfY8uuHLqVE1LL5vTpzN8w
        7tnhadMWpnAunCyh7nw6cSVLcNGJmpUxu169/NPAWHK+q8X9w5Y/EYEeS5emz2ROkLV7I7nQ
        YaLmrLf2c+ZP1fv8slR5udgNmyWZsYvqg3ucZNtP3hf5InZMU/nebgdf29UNwV+VCp9v11M+
        f6mcn+eO7q+rSVO0Zcsuz6td8bylqU+SaecKrVXxrgUhU4w6J+zTnKwbunDam4t7Ymq5nzCE
        B98tOPfioMoRo9MT/oYrmBwVWK2qoMYtLsQS115kdcvXd8L5inXFCkt4Mp/ONTK/E1fGJPhI
        NSGdN/OvafGZzfp+19QiX1xQCZuzXyPaufP785bvFbc8NsgpsRRnJBpqMRcVJwIAw1INSwsD
        AAA=
X-CMS-MailID: 20230911133431eucas1p2631e7060cecb0914933ed45b837cf8eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230911133431eucas1p2631e7060cecb0914933ed45b837cf8eb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230911133431eucas1p2631e7060cecb0914933ed45b837cf8eb
References: <CGME20230911133431eucas1p2631e7060cecb0914933ed45b837cf8eb@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that thermal in Exynos 4210 is broken without this, as it will
never decrease cooling after increasing it.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v1 -> v2: Just uploaded separately from all the thermal: exynos:
  patches with a shorter recipient list, no change otherwise.

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


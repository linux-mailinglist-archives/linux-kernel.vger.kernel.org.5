Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA507D6D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344660AbjJYNbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjJYNay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:30:54 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5BB133
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:30:52 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231025133050euoutp01ccbdff1e00269395e9930bf91d1208e7~RXN-UYHsO3169731697euoutp01X
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:30:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231025133050euoutp01ccbdff1e00269395e9930bf91d1208e7~RXN-UYHsO3169731697euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698240650;
        bh=7/6FemRmnMZSvOrVZ5Dgthh/u/9EWRsMZanz4+6xfv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASJDuyeOtJHmKHcLeIDV0z2BIPUPgCGYhxZcq0tbsB+PDRmKhT5+cdk6WATbbl/CE
         l7x4qm9Jr7hpJUQ5VTF+dDBaihIwILPARlQI3/hP/XyKmyjJUMVqt2UaPg9CFwU/Q2
         YJVmi7RnvIHpxOoOcz2+HzbxXy9DUmQhdPFGphSw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231025133050eucas1p1fb11806b8605d2603dcf2bfe6c8d4dc1~RXN_nXEJm1383513835eucas1p1h;
        Wed, 25 Oct 2023 13:30:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 17.0B.37758.A8819356; Wed, 25
        Oct 2023 14:30:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231025133049eucas1p11f9c4dc6d235418175c94340ad15f5a7~RXN_GZW081436614366eucas1p1f;
        Wed, 25 Oct 2023 13:30:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231025133049eusmtrp12281dbeb629fdd771180328bf20b9b5a~RXN_FpG1C0853808538eusmtrp1i;
        Wed, 25 Oct 2023 13:30:49 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-4b-6539188ade45
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id ED.98.10549.98819356; Wed, 25
        Oct 2023 14:30:49 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231025133048eusmtip26bd5f7522c50974cc574acd1083a3e46~RXN9OFLFq1156911569eusmtip2j;
        Wed, 25 Oct 2023 13:30:48 +0000 (GMT)
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
Subject: [PATCH v4 2/8] thermal: exynos: drop id field
Date:   Wed, 25 Oct 2023 15:30:21 +0200
Message-ID: <20231025133027.524152-3-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025133027.524152-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87pdEpapBteuslo8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKC6blNSczLLUIn27BK6MrtNvmAom8VQc/z2LpYHxE2cXIyeHhICJxMR5l1i6
        GLk4hARWMEr0ffoF5XxhlJi2Zh0rhPOZUeLF89XsMC2zJs5kBbGFBJYzSmzfYQ5R1MoksX3y
        KxaQBJuAgcSDN8vAGkQEWhklZjapgxQxC3xllrj6ej4zSEJYwEzi4oKVTCA2i4CqxPI9r4Bs
        Dg5eAVuJBadiIZbJS+xZ9B2shFPATqL3+HU2EJtXQFDi5MwnYLuYgWqat85mBpkvIdDPKXFl
        72omiGYXif87j7BA2MISr45vgfpARuL05B6oeL7EjM3vWUD2SghUSNw96AVhWkt8PMMMYjIL
        aEqs36UPUewo0fj8LytEBZ/EjbeCEAfwSUzaNp0ZIswr0dEmBFGtKnF8zyRmCFta4knLbaiz
        PCS+dK5knMCoOAvJK7OQvDILYe8CRuZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsYgWnt
        9L/jX3cwrnj1Ue8QIxMH4yFGCQ5mJRHeSB+LVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qiny
        qUIC6YklqdmpqQWpRTBZJg5OqQYmprrefkeXtTPKozoUtZdWT7Vd8sBeaEXimiwDRjYmt93S
        sX9m3JfKmn9gl9D3h1Od9wcue32/4UiUaSaX2Y7yxadtpR6m+Ds/uhGXckvukNRvnl8zBKV5
        fa9PSWI4m7Vyp/VsrwR953PqiTXrzzhITznI06akdd8lsvPVrGTjsPMFTbV7Nha/Xnl8YTHD
        1fZXsxbaqTr0f560cmPgvjnz382zOe10NiLsipjA2dO7jZkmrTsl07Yptv1zTKkY+1WHGB0h
        sa0NcqfkD3gZnRQy3aAZmXycb3Iqd3NSwvRzEcym3Adn/z9+021vtXZ+g5GqQcSx54wfA1/N
        fmd0RLT8zVX5U4vPemSVMs5P7OdRYinOSDTUYi4qTgQAk4mEjtoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7qdEpapBvsnyVk8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLU
        In27BL2MrtNvmAom8VQc/z2LpYHxE2cXIyeHhICJxKyJM1m7GLk4hASWMkosPLGaBSIhLXH4
        yxR2CFtY4s+1LjaIomYmiYXvfoEVsQkYSDx4s4wdJCEi0Mko0bX5HBNIglngP7PE15kKILaw
        gJnExQUrweIsAqoSy/e8ArI5OHgFbCUWnIqFWCAvsWfRd7ASTgE7id7j19lAbCGgkgkdD8GO
        4BUQlDg58wkLxHh5ieats5knMArMQpKahSS1gJFpFaNIamlxbnpusaFecWJucWleul5yfu4m
        RmAcbjv2c/MOxnmvPuodYmTiYDzEKMHBrCTCG+ljkSrEm5JYWZValB9fVJqTWnyI0RTo7InM
        UqLJ+cBEkFcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwLTydOyz
        vrRbtd2CmVXyFxKUQ1M1zs44kijHxHf3w1n9M/ErQ3/L+p7b6KC1/G+bpY9erYXt9nCnl7br
        tRqsWyp808TNZvMwZ/ktWuFW1fq0M6x46ZzpvQ/aZ9ZOdErdvIYn5KjS+edu01ZWMf/8LZi7
        4WZa1Jvuc1ZTbx438Vt95bmG2itmW+dD8/6sOnU1+90ug8AnG/6GmOZOc8h7XvHWs9s7L22z
        1krNGWlnuL2r1PreiLpn3359dImyX+XSwxWxTg/qFi620okwnlMiUrQi4X/qyX1s+41kkkV7
        t9pVzbmZ/ua5/rt397eJRu5ITE/crai1JrIuvvxyg07Mj4uHCpTS+Dey/ZDYtXNatBJLcUai
        oRZzUXEiALIlgTxMAwAA
X-CMS-MailID: 20231025133049eucas1p11f9c4dc6d235418175c94340ad15f5a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231025133049eucas1p11f9c4dc6d235418175c94340ad15f5a7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231025133049eucas1p11f9c4dc6d235418175c94340ad15f5a7
References: <20231025133027.524152-1-m.majewski2@samsung.com>
        <CGME20231025133049eucas1p11f9c4dc6d235418175c94340ad15f5a7@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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


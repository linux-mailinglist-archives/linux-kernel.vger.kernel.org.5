Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CF37F168D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjKTO5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbjKTO5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:57:48 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39CD172A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:51:10 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231120145108euoutp0117b93d2374f4f2e5b658f7f8912efc62~ZXFhh5nzR2535125351euoutp01Q
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:51:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231120145108euoutp0117b93d2374f4f2e5b658f7f8912efc62~ZXFhh5nzR2535125351euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700491869;
        bh=jBlF0oIpiv9kwW8O5r6u3KvNxtWfNTZv3UQkUphMQXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FzvNfT6QqjiCcvDlgcuoYYZEs+upT7SsibZv9+uDvizJO0r5bWlRbDYZBd0DgAJQz
         +a2JimbJGIt8qX0mkAyILFK1UD9wB9wcQqdN6hSwNDvDCQJbJrmd14S4qQ1Iltpo/d
         34Y35F//S3FuBDKRaPTGVTgnw2AfDU3YEF75X5DI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231120145108eucas1p1d9c037fcf01ad33abd2b3989162654a6~ZXFg9bU5I0563605636eucas1p14;
        Mon, 20 Nov 2023 14:51:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F1.47.09539.C527B556; Mon, 20
        Nov 2023 14:51:08 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231120145107eucas1p13ed9ea8772346c404d2d7f47d4c80f5a~ZXFgkKmmp1856818568eucas1p1X;
        Mon, 20 Nov 2023 14:51:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231120145107eusmtrp226def54ebb6b30123443d1e83bd2ee74~ZXFgeg9HP0691806918eusmtrp2V;
        Mon, 20 Nov 2023 14:51:07 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-67-655b725c09c2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5D.C3.09146.B527B556; Mon, 20
        Nov 2023 14:51:07 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231120145106eusmtip299c0f9402e9af46c179a8f5dfe7b646e~ZXFfmg4Cr1340013400eusmtip2D;
        Mon, 20 Nov 2023 14:51:06 +0000 (GMT)
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
Subject: [PATCH v5 8/9] thermal: exynos: use BIT wherever possible
Date:   Mon, 20 Nov 2023 15:50:48 +0100
Message-ID: <20231120145049.310509-9-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120145049.310509-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djPc7oxRdGpBp3X+C0ezNvGZnF4foXF
        1IdP2Cy+b7nOZDHvs6zF3tdb2S2+Xelgstj0+BqrxeVdc9gsPvceYbSYcX4fk8XCphZ2i4nH
        JjNbrD1yl91i7pepzBZPHvaxOQh4rJm3htFj56y77B6L97xk8ti0qpPN4861PWwem5fUe/Rt
        WcXo8XmTXABHFJdNSmpOZllqkb5dAlfGjHXrmAvOiVY8OfyVvYFxj2AXIyeHhICJxMWvE5i7
        GLk4hARWMEo83DydFcL5wijx5dwWdgjnM6PErTm9LDAt6xcuYgaxhQSWM0rsvu4LUdTKJLG7
        eSYbSIJNwEDiwZtl7CC2iEAro8TMJnWQImaBr8wSV1/PB+sWFnCS+PDzPJjNIqAq8XfPASYQ
        m1fAVmLyi2ZWiG3yEnsWfQeLcwrYSbQdec4GUSMocXLmE7CLmIFqmrfOBntCQqCbU+LVngNs
        EM0uEpNnLYQaJCzx6vgWdghbRuL/zvlMEHa+xIzN74EGcQDZFRJ3D3pBmNYSH88wg5jMApoS
        63fpQxQ7Skw6foIJooJP4sZbQYgD+CQmbZvODBHmlehoE4KoVpU4vmcSM4QtLfGk5TbUSg+J
        tVvvM09gVJyF5JVZSF6ZhbB3ASPzKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMDEdvrf
        8U87GOe++qh3iJGJg/EQowQHs5II7zehiFQh3pTEyqrUovz4otKc1OJDjNIcLErivKop8qlC
        AumJJanZqakFqUUwWSYOTqkGphjPih/O5UvCHf2XTiqwebSlzXGyi9b+7vNZj/+vSozbpmvG
        JtVlMq3CWE+vzTRLgPmjS82PZ+WRnmGZvqdj3qy0fn/zq7vzjG3pBxd1aVzYWMX8oDXp+On+
        /7tyP5zdMStMo/la/KdvD/ZdOihiZc3nZ/I45HHynXcKL+753Guez8y5w1ZW9oxKy/lk7c/b
        dzodSFz2p3Xz9rBJjPFXYixC7Kczf64Mz+SR0ri3OG3ahQd2CmwZ706dS+LoC1/71fPoN6Xz
        697N8VBeL/Ppxb983+q0CV8Z93+64/g9Z4J2bKyr2x/bs79ryvyrbBwZpvK+1Vc9e+9Gtdwh
        2fPrgua+fGqwb/aKx5YM5vHLnyuxFGckGmoxFxUnAgDjMhOn2wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7rRRdGpBgfX61s8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLU
        In27BL2MGevWMRecE614cvgrewPjHsEuRk4OCQETifULFzF3MXJxCAksZZQ49KSZFSIhLXH4
        yxR2CFtY4s+1LjaIomYmideHDoMl2AQMJB68WcYOkhAR6GSU6Np8jgkkwSzwn1ni60wFEFtY
        wEniw8/zzCA2i4CqxN89B8BqeAVsJSa/gNkmL7Fn0XewOKeAnUTbkedA2ziAttlKdNzVgCgX
        lDg58wkLxHh5ieats5knMArMQpKahSS1gJFpFaNIamlxbnpusaFecWJucWleul5yfu4mRmAc
        bjv2c/MOxnmvPuodYmTiYDzEKMHBrCTC+00oIlWINyWxsiq1KD++qDQntfgQoynQ2ROZpUST
        84GJIK8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgSnUaX3iRYf8
        d9nNJzb0r3qknaPfePFM1TX2LlZXv9jFeu3Pe/I2xR8RPVXqmj43vlTj6qGH9jq+nnwfm23f
        LAxaohOpvf9/4mxR2QuT3Db/Dfgs+Nd38ew9V/uNn0Ruu+5v6NPAJFyp/7xI3aPsQIi/f+N5
        XsNNrAnXtB8v5dsi9GBb5smateaedu8qY+0fdBopNi67YVvzpN5DVK5lruh+q9Rf7Al2aWKX
        Nu57yDFzle+jdiPTbz4XrxtmLq7iXPo3O+Taxm/vPC4IVS1/sMhg52/V83MlPnyTWvjI8OJZ
        tr/h3JcTHzUUSuY9fz5/5uzubk7nFRwSqT/VmW4siGdhf+is6bY+4/k76eS2e0osxRmJhlrM
        RcWJALSRTsRMAwAA
X-CMS-MailID: 20231120145107eucas1p13ed9ea8772346c404d2d7f47d4c80f5a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231120145107eucas1p13ed9ea8772346c404d2d7f47d4c80f5a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231120145107eucas1p13ed9ea8772346c404d2d7f47d4c80f5a
References: <20231120145049.310509-1-m.majewski2@samsung.com>
        <CGME20231120145107eucas1p13ed9ea8772346c404d2d7f47d4c80f5a@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original driver did not use that macro and it allows us to make our
intentions slightly clearer.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 6b3a7dd05c68..40e250c815f8 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -388,7 +388,7 @@ static void exynos4412_tmu_set_trip_temp(struct exynos_tmu_data *data,
 
 	if (trip == 3) {
 		con = readl(data->base + EXYNOS_TMU_REG_CONTROL);
-		con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
+		con |= BIT(EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
 		writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 	}
 }
@@ -559,16 +559,16 @@ static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 				continue;
 
 			interrupt_en |=
-				(1 << (EXYNOS_TMU_INTEN_RISE0_SHIFT + i * 4));
+				BIT(EXYNOS_TMU_INTEN_RISE0_SHIFT + i * 4);
 		}
 
 		if (data->soc != SOC_ARCH_EXYNOS4210)
 			interrupt_en |=
 				interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
 
-		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
+		con |= BIT(EXYNOS_TMU_CORE_EN_SHIFT);
 	} else {
-		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
+		con &= ~BIT(EXYNOS_TMU_CORE_EN_SHIFT);
 	}
 
 	writel(interrupt_en, data->base + EXYNOS_TMU_REG_INTEN);
@@ -590,15 +590,15 @@ static void exynos5433_tmu_control(struct platform_device *pdev, bool on)
 				continue;
 
 			interrupt_en |=
-				(1 << (EXYNOS7_TMU_INTEN_RISE0_SHIFT + i));
+				BIT(EXYNOS7_TMU_INTEN_RISE0_SHIFT + i);
 		}
 
 		interrupt_en |=
 			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
 
-		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
+		con |= BIT(EXYNOS_TMU_CORE_EN_SHIFT);
 	} else
-		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
+		con &= ~BIT(EXYNOS_TMU_CORE_EN_SHIFT);
 
 	pd_det_en = on ? EXYNOS5433_PD_DET_EN : 0;
 
@@ -622,17 +622,17 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 				continue;
 
 			interrupt_en |=
-				(1 << (EXYNOS7_TMU_INTEN_RISE0_SHIFT + i));
+				BIT(EXYNOS7_TMU_INTEN_RISE0_SHIFT + i);
 		}
 
 		interrupt_en |=
 			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
 
-		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		con |= (1 << EXYNOS7_PD_DET_EN_SHIFT);
+		con |= BIT(EXYNOS_TMU_CORE_EN_SHIFT);
+		con |= BIT(EXYNOS7_PD_DET_EN_SHIFT);
 	} else {
-		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		con &= ~(1 << EXYNOS7_PD_DET_EN_SHIFT);
+		con &= ~BIT(EXYNOS_TMU_CORE_EN_SHIFT);
+		con &= ~BIT(EXYNOS7_PD_DET_EN_SHIFT);
 	}
 
 	writel(interrupt_en, data->base + EXYNOS7_TMU_REG_INTEN);
-- 
2.42.0


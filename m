Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39B37D6D25
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344599AbjJYNbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbjJYNax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:30:53 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E0318D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:30:49 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231025133048euoutp0269f9f26530fe80babe4b11a29d7eb784~RXN85uauC1108811088euoutp02v
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:30:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231025133048euoutp0269f9f26530fe80babe4b11a29d7eb784~RXN85uauC1108811088euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698240648;
        bh=eb8mbc98REMcBZ07pJdFy0917NkB5OE4nrZXufMorTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DG/S7D41jP5u5bqqcxu8C/k8Crsqro0w00obh++bmeHdEqpDJaQsCVnR4qbX6iDZC
         JruDLGNhaPOqBV45GV1iFR4c1+av/J2HTEEDdkaAkQ3kA0qFFAJeUn1ZxXaZx2niMv
         ZdPmip0t0RKi4ex88Ca8+sm528OnwYAH2BDaUfYc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231025133047eucas1p1f0f67fc201f2576579b58cb14a9dd2d2~RXN8i0PSv1622416224eucas1p1I;
        Wed, 25 Oct 2023 13:30:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 13.0B.37758.78819356; Wed, 25
        Oct 2023 14:30:47 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231025133047eucas1p2bef6136656645815da1ff884f4f8d1d0~RXN8DxRSn2546925469eucas1p2j;
        Wed, 25 Oct 2023 13:30:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231025133047eusmtrp21ca9fa31ad4b4f70f73333a8c4f7f9a5~RXN8DF7Wn1205012050eusmtrp2a;
        Wed, 25 Oct 2023 13:30:47 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-41-65391887fb96
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 24.26.25043.78819356; Wed, 25
        Oct 2023 14:30:47 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231025133046eusmtip2566ff2ed17159f364f37707238adffe4~RXN7JV-kv1374613746eusmtip2g;
        Wed, 25 Oct 2023 13:30:46 +0000 (GMT)
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
Subject: [PATCH v4 1/8] thermal: exynos: remove an unnecessary field
 description
Date:   Wed, 25 Oct 2023 15:30:20 +0200
Message-ID: <20231025133027.524152-2-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025133027.524152-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djPc7rtEpapBoePG1g8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKC6blNSczLLUIn27BK6MU0fmsBWsYq9YvecQSwPjZLYuRk4OCQETiZu7TzF2
        MXJxCAmsYJS49HcJC4TzhVHiw/NlzBDOZ0aJI3euAZVxgLUcfOwD0i0ksJxRYu30eIiaViaJ
        C8d6mEESbAIGEg/eLGMHsUUEWhklZjapgxQxC3xllrj6ej5YkbBAkMT6kx+YQGwWAVWJH9cm
        MILYvAK2Ej+vn2SCuE9eYs+i72A2p4CdRO/x62wQNYISJ2c+YQGxmYFqmrfOBrtUQqCfU2Lz
        wdVsEJe6SLS9joCYIyzx6vgWdghbRuL/zvlQ8/MlZmx+zwJRXiFx96AXhGkt8fEMM4jJLKAp
        sX6XPkTUUWL1PQUIk0/ixltBiPV8EpO2TWeGCPNKdLQJQUxWlTi+ZxIzhC0t8aTlNtRGD4mr
        F5pZJjAqzkLyyCwkj8xCWLuAkXkVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYEo7/e/4
        1x2MK1591DvEyMTBeIhRgoNZSYQ30sciVYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBA
        emJJanZqakFqEUyWiYNTqoFJTZ5zhmNly/xUgXdbbBi2Rj/K5Fn5US3viZT1On6FjVrbTjKp
        bNDXjXBWaOSqbovybFjlxlwVGWyn9G7Gj1nOf64n7WZl52fkz9vDurSZJebqr71eB4O5b869
        XC3O8mrtWc3emdef7as8lM28m/nO+emv1v3inML1JfzXB1eNnXmCU4Ia/uw6vzvx3Kq37SZ6
        2fl8Ii+1Rad2h2w/ezr3g9U9TvEf/1VWnepkmMrw0ftGlf27xqyLmtZOV00V3PisE9o/XFi0
        3+BrxbeFfJcnxc0UO8ep71OSrvVg8b3n2iz3qifbB3xT3/5yVsg/G97IL7O8MvdPSKi98l0j
        boZwRZ3y3k2L/9wpX3Mjh+GgEktxRqKhFnNRcSIAXcMDmtgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xe7rtEpapBvM2CFg8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLU
        In27BL2MU0fmsBWsYq9YvecQSwPjZLYuRg4OCQETiYOPfboYuTiEBJYySpzZuxQozgkUl5Y4
        /GUKO4QtLPHnWhcbRFEzk8T0+fsZQRJsAgYSD94sYwdJiAh0Mkp0bT7HBJJgFvjPLPF1pgLI
        BmGBAInpbY4gYRYBVYkf1yaA9fIK2Er8vH6SCWKBvMSeRd/BbE4BO4ne49fBjhACqpnQ8ZAd
        ol5Q4uTMJywQ4+UlmrfOZp7AKDALSWoWktQCRqZVjCKppcW56bnFRnrFibnFpXnpesn5uZsY
        gVG47djPLTsYV776qHeIkYmD8RCjBAezkghvpI9FqhBvSmJlVWpRfnxRaU5q8SFGU6C7JzJL
        iSbnA9NAXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QD06xFzy7u
        K6nNygieYZJh4aB7ViB5y53NigtnWCxs6K1tEpj6raOz9vScK5mNYVH59/d15rLUKj218ru4
        PK90udBuXymPT0vTH+vL5/6Z/ezFvSsPopueBhSYhCu/qzx5iTXxk+CeA8+cX/5Y67AgSGKf
        dUHn6WydvwKMRg+Fcnv3+rDGy8ZvEEnNPXbNKyE048iCdU6TVIMWOh0pPVhuax1WYWZ4pyX5
        oGqE/DUdjr9LJe6s+mOvdnzfr6o1DMaNJmrzGmqnPhc2ergo59T3hyonL5yfbJnbybn/wwvX
        5fFSZzY/lHBY5bbyv4Ml9zzx02uKvdjP5n1M4L3kl3ndYWlYd8eqPUeljsnMKZ19QYmlOCPR
        UIu5qDgRAM127G1LAwAA
X-CMS-MailID: 20231025133047eucas1p2bef6136656645815da1ff884f4f8d1d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231025133047eucas1p2bef6136656645815da1ff884f4f8d1d0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231025133047eucas1p2bef6136656645815da1ff884f4f8d1d0
References: <20231025133027.524152-1-m.majewski2@samsung.com>
        <CGME20231025133047eucas1p2bef6136656645815da1ff884f4f8d1d0@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the field has been removed in one of the previous commits,
but the description has been forgotten.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 123ec81e1943..187086658e8f 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -160,7 +160,6 @@ enum soc_type {
  *	in the positive-TC generator block
  *	0 < reference_voltage <= 31
  * @regulator: pointer to the TMU regulator structure.
- * @reg_conf: pointer to structure to register with core thermal.
  * @tzd: pointer to thermal_zone_device structure
  * @ntrip: number of supported trip points.
  * @enabled: current status of TMU device
-- 
2.42.0


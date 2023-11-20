Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1A07F1644
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjKTOwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjKTOvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:51:55 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607B410F9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:51:02 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231120145100euoutp01ff50cde2d67380ec8a96e77cb5297932~ZXFZMPH9Q2424024240euoutp019
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:51:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231120145100euoutp01ff50cde2d67380ec8a96e77cb5297932~ZXFZMPH9Q2424024240euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700491860;
        bh=eb8mbc98REMcBZ07pJdFy0917NkB5OE4nrZXufMorTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O+9OTrlPA0TVYqzDRyOP2E+QeTukIzT9PEqBtz8GdNO1xPWjmOIqxfpL11oW5032u
         Yvcob87GRdCzS2Onm++jXis27N2f9irtt+lFXwlOt4nj8AZQzuA2QXCqstLY0i5G1s
         kWy5jncDSMBHjxmYihtL0KwGlRYjNsx8si0/nLx8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231120145059eucas1p1dfb26601aa696ead06ab700690edf8b3~ZXFYhpZZg2521425214eucas1p1v;
        Mon, 20 Nov 2023 14:50:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BF.9B.09814.3527B556; Mon, 20
        Nov 2023 14:50:59 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231120145058eucas1p16db15d5d8822c1ce88d7ae5f5d7298bd~ZXFYKIE9a0302603026eucas1p1V;
        Mon, 20 Nov 2023 14:50:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231120145058eusmtrp26f1c7105a59e4c4aad76dbc0312a536d~ZXFYJZ_oH0691806918eusmtrp24;
        Mon, 20 Nov 2023 14:50:58 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-1f-655b7253207a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5A.64.09274.2527B556; Mon, 20
        Nov 2023 14:50:58 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231120145057eusmtip2705fe998d7d6d012db917ab736c0f80d~ZXFXQSoMs1142511425eusmtip2g;
        Mon, 20 Nov 2023 14:50:57 +0000 (GMT)
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
Subject: [PATCH v5 1/9] thermal: exynos: remove an unnecessary field
 description
Date:   Mon, 20 Nov 2023 15:50:41 +0100
Message-ID: <20231120145049.310509-2-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120145049.310509-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djP87rBRdGpBg9P81s8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKC6blNSczLLUIn27BK6MU0fmsBWsYq9YvecQSwPjZLYuRg4OCQETiYkriroY
        OTmEBFYwSixeUdjFyAVkf2GUeH5gAjOE85lRoun6KnaQKpCG/f3/oBLLGSUuHPzHCtHeyiTx
        53kCiM0mYCDx4M0ysAYRgVZGiZlN6iANzAJfmSWuvp7PDJIQFgiSeH5yNhuIzSKgKnH08j2w
        OK+ArcSX121sENvkJfYs+s4EYnMK2Em0HXnOBlEjKHFy5hMWEJsZqKZ562ywiyQEJnNKLF96
        BKrZRWL707MsELawxKvjW6BekJH4v3M+E4SdLzFj83sWSFhUSNw96AVhWkt8PMMMYjILaEqs
        36UPUewo8W3/MiaICj6JG28FIQ7gk5i0bTozRJhXoqNNCKJaVeL4nknMELa0xJOW21ArPSR+
        rDjKPIFRcRaSV2YheWUWwt4FjMyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxApPa6X/H
        v+xgXP7qo94hRiYOxkOMEhzMSiK834QiUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzqqbIpwoJ
        pCeWpGanphakFsFkmTg4pRqY7KtvreOzNj359Pu/d0v/7nPnKSphlJ0YKfs/Nsf4y//Ldavi
        Zk7gvv5l1oP2JafELn19mrQx+dE+V+P9setjQrbFmcRFHvj9/4fw8l5+uROfP13P/Dk1/AMr
        n8i36x+epjp8Wujl2Pu/2ODMsyO5nMId65p3mbn6MO6b8Gze1ePPd8/JXtOzqOiu8cz9ckK6
        K6cseCBk7dS48OmtkhmL+86eNrUzSq0Nfj+HV58jV2jT+1TO7z0Fk5OmPLn95+SXXTOq2/rE
        17/ctO7C5css5wqiO9fdfqH0lf/y3oUhgv1Xu7xs9IM2cKZuT+afrDXvsp0qk6vE6ntKyr4n
        9voeXru0xO3svjxVg3T9T7WvzfOVWIozEg21mIuKEwGnuLkn2QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7pBRdGpBkemGlg8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLU
        In27BL2MU0fmsBWsYq9YvecQSwPjZLYuRk4OCQETif39/5i7GLk4hASWMko87WhkhEhISxz+
        MoUdwhaW+HOtiw2iqJlJ4sia76wgCTYBA4kHb5axgyREBDoZJbo2n2MCSTAL/GeW+DpTAcQW
        FgiQmLf4PVgDi4CqxNHL95hBbF4BW4kvr9ugzpCX2LPoO1gvp4CdRNuR50BxDqBtthIddzUg
        ygUlTs58wgIxXl6ieets5gmMArOQpGYhSS1gZFrFKJJaWpybnltspFecmFtcmpeul5yfu4kR
        GIfbjv3csoNx5auPeocYmTgYDzFKcDArifB+E4pIFeJNSaysSi3Kjy8qzUktPsRoCnT2RGYp
        0eR8YCLIK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpg0tr7+PG8
        RysMQlhMDt40WchZsoh9yZavM0sK1nROKJsZWhOeFvfS69/y0m1bn5fwfRK+YvGvmXfPC4Yd
        F6/mbuFbYKMq8VnidXfa0k8qgqmPv/hIPHc+ZLiISSL4w292plnRWe9P/y1L7it9LXpIb9al
        x6e/2xh90uFtOZx3+U5y7GMjr8bcrOIFJfZKC99c5Tm0ykng5FYfjd+qm1SndK0p8L6oa1yh
        J3I29cj5Q5GLTrU996n4lP+m6pkJQ+Cp96K+k3LnnxG68f7pNpeZaycxir+6cO3H4Z7PUT/X
        KSWtu7I6O/GJSeiG1epsG6e7cN5njetJ/fuLu+PkzomuG+/6h/Bt/2iTpObK+K5iJYcSS3FG
        oqEWc1FxIgBeRX6DTAMAAA==
X-CMS-MailID: 20231120145058eucas1p16db15d5d8822c1ce88d7ae5f5d7298bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231120145058eucas1p16db15d5d8822c1ce88d7ae5f5d7298bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231120145058eucas1p16db15d5d8822c1ce88d7ae5f5d7298bd
References: <20231120145049.310509-1-m.majewski2@samsung.com>
        <CGME20231120145058eucas1p16db15d5d8822c1ce88d7ae5f5d7298bd@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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


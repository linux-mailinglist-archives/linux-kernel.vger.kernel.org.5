Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31FB78C15C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbjH2JZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjH2JY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:24:29 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5EA1B6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:24:23 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230829092422euoutp0190b6a43529a7dbd0f0bb5171434db4c8~-0Fg71TLM1639316393euoutp01G
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:24:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230829092422euoutp0190b6a43529a7dbd0f0bb5171434db4c8~-0Fg71TLM1639316393euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693301062;
        bh=LMqZ4M9gbEgBjK/x+ZePPo+65xbhoSKR9eCICgUWep0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L3LJbhfimGjYfp7ksnG25RJI8NYLC8OwDZViD4rg0IRCeWJulX74W+ql6BS3bkSgg
         ySBlsep3rlU3WUa2kT0i0nYxepW08ZUkKyLlEfuaHjEuke1x7qSVykbrDE5JtiFUxz
         04CEzvMGhYfQ4e1IPJfZPFrzwS71wzAyDIlcjAzE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230829092421eucas1p2c12f3c95625bdb27f300e97656dc3b02~-0Fgnz1pc2921729217eucas1p24;
        Tue, 29 Aug 2023 09:24:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8C.27.11320.549BDE46; Tue, 29
        Aug 2023 10:24:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230829092421eucas1p1970c3fb42ca622129bf92511893500b1~-0FgPiTP92107821078eucas1p1x;
        Tue, 29 Aug 2023 09:24:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230829092421eusmtrp11d25a978c8781712788f9fcef9732d2f~-0FgOIPBV3248032480eusmtrp1L;
        Tue, 29 Aug 2023 09:24:21 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-2e-64edb9458fb1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6F.8B.14344.549BDE46; Tue, 29
        Aug 2023 10:24:21 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092420eusmtip279c0288c8b4887955d720652f40ccf2a~-0FfAyJZY1173411734eusmtip2m;
        Tue, 29 Aug 2023 09:24:20 +0000 (GMT)
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
Subject: [PATCH 08/11] thermal: exynos: stop using the threshold mechanism
 on Exynos 4210
Date:   Tue, 29 Aug 2023 11:18:46 +0200
Message-ID: <20230829091853.626011-9-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829091853.626011-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djPc7quO9+mGFzdaWLxYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJXRtXMOc8EzvoqrV5tZGxg38HQxcnJICJhI
        rNxxk6mLkYtDSGAFo0Tzwj2sEM4XRom/T38wQzifGSXubv3HCtPy6PhpNojEckaJna9+sUM4
        rUwSZ5Y9YwGpYhMwkHjwZhlYQkRgMaPE1p2zwLYwC8xlkWhY+ROoioNDWCBaYsreWpAGFgFV
        icvtnWwgNq+ArcTWqQdZINbJSzy/dYcdxOYUsJOYfr6dCaJGUOLkzCdgNcxANc1bZ4PdKiEw
        nVOi/9NpZpD5EgIuEqefW0HMEZZ4dXwLO4QtI3F6cg/U/HyJGZvfs0CUV0jcPegFYVpLfDwD
        NoRZQFNi/S59iGJHia9frzNBVPBJ3HgrCLGfT2LStulQK3klOtqEIKpVJY7vmcQMYUtLPGm5
        zQRhe0gsezOLdQKj4iwkn8xC8skshL0LGJlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525i
        BKa40/+Of9nBuPzVR71DjEwcjIcYJTiYlUR4Lzm+ShHiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        q217MllIID2xJDU7NbUgtQgmy8TBKdXA1GX7/NT8HjfjKREJR7XmvzVYdmt6WkWWC0fH5/fH
        +o0eeoS4h+vdzPp4a7br15Nb7ogvePRn05I7V+K8hdmieFMz1qV+z2HnfHS81EqhzdZT/t3f
        u18OPTLx4vbltjtl/9u/wX9Bz93fJd3SE9ad9auZ8yoyb6eNUwGHpUnOtSmq975a/vYpUeAw
        5536oLd4i9YBdvFpzXZu9xpKbrrnzRLlsT3rGKaSWP+rv8r/8GMR9fc/+Kde/3fkxS+tuq1z
        VEoZvgfwzrmhvlgmfrWtrWfK/d5r0xi8hE4Ia8YtrRS7Z7p97qES5f9iucdVfxczcj691+Ka
        si//4mSRhE2fnvOs5QjI4tGw8n20VidWiaU4I9FQi7moOBEAiUBw8uADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7quO9+mGBxukrF4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8WaveeYLOZ9lrWYf+Qcq0Xfi4fMFt+udDBZbHp8jdXi8q45bBafe48wWsw4
        v4/JYuKxycwWa4/cZbeY+2Uqs0Xr3iPsFk8e9rE5CHnsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC2CP0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0Mvo2jmHueAZX8XVq82sDYwbeLoYOTkkBEwkHh0/zQZiCwksZZRYdqcWIi4t
        cfjLFHYIW1jiz7UuoBouoJpmJonjz9+ygCTYBAwkHrxZxg6SEBFYzihx9d5yFhCHWWA5i8Tz
        NR+YQaqEBSIlnszdAWazCKhKXG7vBFvHK2ArsXXqQRaIFfISz2/dAVvHKWAnMf18OxPESbYS
        ayacg6oXlDg58wlYPTNQffPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232EivODG3uDQvXS85
        P3cTIzAmtx37uWUH48pXH/UOMTJxMB5ilOBgVhLhveT4KkWINyWxsiq1KD++qDQntfgQoynQ
        3ROZpUST84FJIa8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgSn1
        1ad8jt8/+c03WvKoPJGy6Tf6s5TjvM7VbtGJkjv2X7m3+aT9IluH4yHvWl4VcuY93BX54u26
        vM1OG6Vuf5+hduEyj1VIY5FM8/dNWhZLt2RGV6fZdAa9eMR17fVC71yhjculGqdH//q+ec0d
        PUG9STeOb1wVIKJ/6exnjVkzTx09cyIj7Uj65w3PtTJMohhnZH66w/eO50zuDv1s/km5AuLb
        6+5e5F0fG59Tf37u4n/b1E8tWHZC8VuMvP+vlZs/du2s9q+aufWeaGYR9xaGjSxGiyRrFd1j
        Hkuk2Bb2AWN3o/VP71T+36Hf5melxQUqlTcsvLzWZdWuN2uuddysMZlcxz8/L9/QmXvVg7VK
        LMUZiYZazEXFiQBOBKtnUgMAAA==
X-CMS-MailID: 20230829092421eucas1p1970c3fb42ca622129bf92511893500b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230829092421eucas1p1970c3fb42ca622129bf92511893500b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230829092421eucas1p1970c3fb42ca622129bf92511893500b1
References: <20230829091853.626011-1-m.majewski2@samsung.com>
        <CGME20230829092421eucas1p1970c3fb42ca622129bf92511893500b1@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos 4210 supports setting a base threshold value, which is added to
all trip points. This might be useful, but is not really necessary in
our usecase, so we always set it to 0 to simplify the code a bit.

Additionally, this change makes it so that we convert the value to the
calibrated one in a slightly different place. This is more correct
morally, though it does not make any change when single-point
calibration is being used (which is the case currently).

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 5da44f43715d..6c107fe9fd27 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -336,20 +336,7 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
 					 int trip_id, u8 temp)
 {
-	struct thermal_trip trip;
-	u8 ref, th_code;
-
-	if (thermal_zone_get_trip(data->tzd, 0, &trip))
-		return;
-
-	ref = trip.temperature / MCELSIUS;
-
-	if (trip_id == 0) {
-		th_code = temp_to_code(data, ref);
-		writeb(th_code, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
-	}
-
-	temp -= ref;
+	temp = temp_to_code(data, temp);
 	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + trip_id * 4);
 }
 
@@ -364,6 +351,8 @@ static void exynos4210_tmu_initialize(struct platform_device *pdev)
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 
 	sanitize_temp_error(data, readl(data->base + EXYNOS_TMU_REG_TRIMINFO));
+
+	writeb(0, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
 }
 
 static void exynos4412_tmu_set_trip_temp(struct exynos_tmu_data *data,
-- 
2.41.0


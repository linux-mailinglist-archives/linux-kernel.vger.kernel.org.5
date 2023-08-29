Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A3C78C161
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbjH2JZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjH2JY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:24:29 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A1619A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:24:25 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230829092423euoutp020f727106fca36365e15032d2af23af60~-0FigsVUD0626506265euoutp02E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:24:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230829092423euoutp020f727106fca36365e15032d2af23af60~-0FigsVUD0626506265euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693301064;
        bh=MISFxXLRGqBlhsnV74hyg0jBZORCFgJ+ZNkWVkvzueo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1ALU1ZaQlQfJmmPyq/2vYhFT236PybJ2vQkQNRGDvCVc1h7fOBuHqVXoqGA2EDtM
         1ZDWd1vMwvbSBiaF8ySM+GbDOyikTQEmjRjURRNiTDfuOx0gDJ1ob3ko4V1z/dDGFJ
         /zEEfH2g10uTKFjkDdmye4EzNTT8twkBLUcc0AOU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230829092423eucas1p176bd125264a400fcaf3467cbc8649494~-0FiLmy2y1819818198eucas1p1E;
        Tue, 29 Aug 2023 09:24:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 04.E8.42423.749BDE46; Tue, 29
        Aug 2023 10:24:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230829092423eucas1p1fc13c188d99482b195e115fd19a1391d~-0FhrCmah2075220752eucas1p1o;
        Tue, 29 Aug 2023 09:24:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230829092423eusmtrp1c33955e9998a3af345772e7d3e831fd7~-0FhqahHc3270032700eusmtrp1l;
        Tue, 29 Aug 2023 09:24:23 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-4c-64edb9475ddf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 41.9B.14344.649BDE46; Tue, 29
        Aug 2023 10:24:22 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092422eusmtip2ef283c90696bc30860c4f4d372111754~-0FgvxfYQ1320013200eusmtip2F;
        Tue, 29 Aug 2023 09:24:22 +0000 (GMT)
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
Subject: [PATCH 09/11] thermal: exynos: split initialization of TMU and the
 thermal zone
Date:   Tue, 29 Aug 2023 11:18:47 +0200
Message-ID: <20230829091853.626011-10-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829091853.626011-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djPc7ruO9+mGBzrU7B4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8WaveeYLOZ9lrWYf+Qcq0Xfi4fMFt+udDBZbHp8jdXi8q45bBafe48wWsw4
        v4/JYuKxycwWa4/cZbeY+2Uqs0Xr3iPsFk8e9rE5CHnsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC2CP4rJJSc3JLEst0rdL4MpoeHGHveC5fMX5fW0sDYyXJLsYOTgkBEwk
        Jl/y6WLk4hASWMEosernaRYI5wujxJTGTUwQzmdGiasNM9i6GDnBOl51dbFDJJYzSjx9fowJ
        JCEk0Mok0bOxCsRmEzCQePBmGViRiMBiRomtO2eBjWIWmMsi0bDyJwtIlbBAlMSvvZ3MIDaL
        gKrEhtkLGUFsXgE7iSmfFzFCrJOXeH7rDjuIzQkUn36+nQmiRlDi5MwnYHOYgWqat85mBlkg
        ITCdU6J51zQWiO9cJDZ1eEPMEZZ4dXwLO4QtI3F6cg8LhJ0vMWPze6jyCom7B70gTGuJj2eY
        QUxmAU2J9bv0IYodJXrXf2CHqOCTuPFWEGI/n8SkbdOZIcK8Eh1tQhDVqhLH90xihrClJZ60
        3GaCsD0kNt5czzKBUXEWkk9mIflkFsLeBYzMqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3
        MQIT3Ol/xz/tYJz76qPeIUYmDsZDjBIczEoivJccX6UI8aYkVlalFuXHF5XmpBYfYpTmYFES
        59W2PZksJJCeWJKanZpakFoEk2Xi4JRqYKq4JheSvmKB1GlVCf+f8ZVZ3Z8eRuW8crz9/JDR
        s/ga5pQFW8SPlRuZmkenPgowEd9xbANf3JaKvQ8mJ7zMD28PeKKxIMuyd9PUv+nXObx2lodd
        1d9/2Lqpv3X6na0nVY7fOsnWG7Sf/Zfflvl1rWKf18gzSvbddLm9T8CJw43Fw5dj4zHpKY4t
        m4ViUrQzGNx5l/zLi6xuKJiupc5k/mf9/bq9F1dFlNW5HDjE+nJziIOc4avD/xfWrTyp2bTi
        e+6iF+ePc0p5cfk157lUC5VcOqAtavP0m8ufE2wTep8nPDsuVXLmwoTnz1RTtfhjfZTlLuR5
        FO59tVEh7lrfkr1X30SnKZ3X+iJp/HufjhJLcUaioRZzUXEiAK36DWXfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7ruO9+mGJxwt3gwbxubxeH5FRZT
        Hz5hs/i+5TqTxZq955gs5n2WtZh/5ByrRd+Lh8wW3650MFlsenyN1eLyrjlsFp97jzBazDi/
        j8li4rHJzBZrj9xlt5j7ZSqzReveI+wWTx72sTkIeeycdZfdY/Gel0wem1Z1snncubaHzWPz
        knqPvi2rGD0+b5ILYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJ
        zcksSy3St0vQy2h4cYe94Ll8xfl9bSwNjJckuxg5OSQETCRedXWxdzFycQgJLGWU+LvmBRtE
        Qlri8Jcp7BC2sMSfa11sEEXNTBLth3pZQBJsAgYSD94sA+sWEVjOKHH13nIWEIdZYDmLxPM1
        H5hBqoQFIiSuPD0C1sEioCqxYfZCRhCbV8BOYsrnRYwQK+Qlnt+6A7aOEyg+/Xw7E4gtJGAr
        sWbCOTaIekGJkzOfgM1hBqpv3jqbeQKjwCwkqVlIUgsYmVYxiqSWFuem5xYb6RUn5haX5qXr
        JefnbmIExuS2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIryXHF+lCPGmJFZWpRblxxeV5qQWH2I0
        Bbp7IrOUaHI+MCnklcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUw
        bZ3Xorj63rrXB1W+SNmcdjRYsT0sNYn56Iq9085Krv3XZSz+uIThYsejvZViLi8+2ncx31r2
        LMluAb/yac4Fs2N2/713Uy9y4fWYELH+5lbj1Q0MJ241JhiU5npsyw6srdKvC/ZoLos8fbfu
        /gRz6cem0ifMzyrpcXy+ojapNkmur3fL91q2OzeUqspZ1v9xZGh/ONdI7/fVj6raYRd3Fng6
        92tf0kn+4unnv7HsRei5tO9N2Zy825cJbanuW+vNrrKFYeGqVTwTBILeCrR9fL0ox2P2u/qN
        Kn+D11399WJyX20o3/zJi1bdOzXPV5qt8O+urcqP5PVfuM6VVn/C3/JCcL/qypZ6N2bJTfMF
        lViKMxINtZiLihMBfH7+KlIDAAA=
X-CMS-MailID: 20230829092423eucas1p1fc13c188d99482b195e115fd19a1391d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230829092423eucas1p1fc13c188d99482b195e115fd19a1391d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230829092423eucas1p1fc13c188d99482b195e115fd19a1391d
References: <20230829091853.626011-1-m.majewski2@samsung.com>
        <CGME20230829092423eucas1p1fc13c188d99482b195e115fd19a1391d@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be needed in the future, as the thermal zone subsystem might
call our callbacks right after devm_thermal_of_zone_register. Currently
we just make get_temp return EAGAIN in such case, but this will not be
possible with state-modifying callbacks, for instance set_trips.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 78 ++++++++++++++++------------
 1 file changed, 45 insertions(+), 33 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 6c107fe9fd27..aa3de367b3c7 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -250,20 +250,43 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 }
 
 static int exynos_tmu_initialize(struct platform_device *pdev)
+{
+	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
+	unsigned int status;
+	int ret = 0;
+
+	mutex_lock(&data->lock);
+
+	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
+	if (!status) {
+		ret = -EBUSY;
+	} else {
+		data->tmu_initialize(pdev);
+		data->tmu_clear_irqs(data);
+	}
+
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int exynos_thermal_zone_configure(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tzd = data->tzd;
 	int num_trips = thermal_zone_get_num_trips(tzd);
-	unsigned int status;
 	int ret = 0, temp;
 
 	ret = thermal_zone_get_crit_temp(tzd, &temp);
+
 	if (ret && data->soc != SOC_ARCH_EXYNOS5433) { /* FIXME */
 		dev_err(&pdev->dev,
 			"No CRITICAL trip point defined in device tree!\n");
-		goto out;
+		goto err;
 	}
 
+	mutex_lock(&data->lock);
+
 	if (num_trips > data->ntrip) {
 		dev_info(&pdev->dev,
 			 "More trip points than supported by this TMU.\n");
@@ -272,36 +295,23 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 			 num_trips - data->ntrip);
 	}
 
-	mutex_lock(&data->lock);
+	int i, ntrips = min_t(int, num_trips, data->ntrip);
 
-	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
-	if (!status) {
-		ret = -EBUSY;
-	} else {
-		int i, ntrips =
-			min_t(int, num_trips, data->ntrip);
+	/* Write temperature code for rising and falling threshold */
+	for (i = 0; i < ntrips; i++) {
+		struct thermal_trip trip;
 
-		data->tmu_initialize(pdev);
+		ret = thermal_zone_get_trip(tzd, i, &trip);
+		if (ret)
+			goto err;
 
-		/* Write temperature code for rising and falling threshold */
-		for (i = 0; i < ntrips; i++) {
-
-			struct thermal_trip trip;
-
-			ret = thermal_zone_get_trip(tzd, i, &trip);
-			if (ret)
-				goto err;
-
-			data->tmu_set_trip_temp(data, i, trip.temperature / MCELSIUS);
-			data->tmu_set_trip_hyst(data, i, trip.temperature / MCELSIUS,
-						trip.hysteresis / MCELSIUS);
-		}
-
-		data->tmu_clear_irqs(data);
+		data->tmu_set_trip_temp(data, i, trip.temperature / MCELSIUS);
+		data->tmu_set_trip_hyst(data, i, trip.temperature / MCELSIUS,
+					trip.hysteresis / MCELSIUS);
 	}
-err:
+
 	mutex_unlock(&data->lock);
-out:
+err:
 	return ret;
 }
 
@@ -1006,10 +1016,12 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		break;
 	}
 
-	/*
-	 * data->tzd must be registered before calling exynos_tmu_initialize(),
-	 * requesting irq and calling exynos_tmu_control().
-	 */
+	ret = exynos_tmu_initialize(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to initialize TMU\n");
+		return ret;
+	}
+
 	data->tzd = devm_thermal_of_zone_register(&pdev->dev, 0, data,
 						  &exynos_sensor_ops);
 	if (IS_ERR(data->tzd)) {
@@ -1020,9 +1032,9 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = exynos_tmu_initialize(pdev);
+	ret = exynos_thermal_zone_configure(pdev);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to initialize TMU\n");
+		dev_err(&pdev->dev, "Failed to configure the thermal zone\n");
 		return ret;
 	}
 
-- 
2.41.0


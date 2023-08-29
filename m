Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D57478C162
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbjH2JZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbjH2JYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:24:31 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E080E1BD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:24:26 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230829092425euoutp01969250722deddd6a940dfa4208f0a6b9~-0FkG0Z8h1739317393euoutp01g
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:24:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230829092425euoutp01969250722deddd6a940dfa4208f0a6b9~-0FkG0Z8h1739317393euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693301065;
        bh=BwKvOQg+53QQq68iKWU/gwE5pdkczN9aJgREeUKZy3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SfD6l3QU+syAq6hhiz/RIj5EX613MAz8gqjC0d8iyssHhY7tN365iX0uT+w2/TZCV
         qjAJHAhZKxbQkcUgN2klfvxIt9CUrUJ+8n0QnqmJNUXYCtHAgkfYdj6M0G6SXtUv3t
         HPkkgk5DjMcsXO8QPP6jFwtvdteTreZPg9fJmQjQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230829092425eucas1p27150b492d4b03133a011f9f7fdda83f4~-0FjpW5q02661026610eucas1p29;
        Tue, 29 Aug 2023 09:24:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A2.8F.37758.949BDE46; Tue, 29
        Aug 2023 10:24:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092424eucas1p269935c8781c84b4c2a83d652f3370bf9~-0FjEnkj02939629396eucas1p27;
        Tue, 29 Aug 2023 09:24:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230829092424eusmtrp127bc77c52ddd7de81e9e2b1f9cf72d37~-0FjD16Sm3270032700eusmtrp1n;
        Tue, 29 Aug 2023 09:24:24 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-75-64edb9490b6b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5C.E9.10549.849BDE46; Tue, 29
        Aug 2023 10:24:24 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092423eusmtip211eded09f968e58fecfd87069fafd2f1~-0FiHdy701173411734eusmtip2o;
        Tue, 29 Aug 2023 09:24:23 +0000 (GMT)
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
Subject: [PATCH 10/11] thermal: exynos: use set_trips
Date:   Tue, 29 Aug 2023 11:18:48 +0200
Message-ID: <20230829091853.626011-11-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829091853.626011-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djP87qeO9+mGNx4yG7xYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJXx9cZeloJPSxkrPrx4z9rA2NnB2MXIySEh
        YCKx+8wZMFtIYAWjxPuTSV2MXED2F0aJpU+2s0M4nxkljn/ZDtex8PNaqI7ljBL73tpDFLUy
        Scw63sUOkmATMJB48GYZWLeIwGJGia07ZzGBOMwCc1kkGlb+ZAGpEhYwlejZvQ9sFIuAqsT8
        KfPA4rwCdhKXDkyFWicv8fzWHbCpnEDx6efbmSBqBCVOznwCVs8MVNO8dTYzyAIJgdmcEh9e
        9rJDNLtI9H5YwQZhC0u8Or4FKi4jcXpyDwuEnS8xY/N7IJsDyK6QuHvQC8K0lvh4hhnEZBbQ
        lFi/Sx+i2FFiz4kjzBAVfBI33gpCHMAnMWnbdKgwr0RHmxBEtarE8T2TmCFsaYknLbeZIGwP
        idefZzNNYFScheSVWUhemYWwdwEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzANHf6
        3/GvOxhXvPqod4iRiYPxEKMEB7OSCO8lx1cpQrwpiZVVqUX58UWlOanFhxilOViUxHm1bU8m
        CwmkJ5akZqemFqQWwWSZODilGpi44vXSlX5xdZt6PJOXFWt6sVD1EKOzx9mqY5qRppO2doS2
        NR9MZAvvvxAtt+bHRAnuL083XnZQ/ehqs3W2SjGv3RvGlUeLVqmJsCx/IKWpaNLbc1vK63ym
        6i+RpsKZpzNVr8U/fjUvrL33jYPBnH7hjG8V6zJeLni7/Gum74anv8vigs5Ybm+OKmpv25y9
        7P20c8pXJXt2tLV28T2aqyLwofw7X9Cj6ceDlNTTN95gYFBakPFlmq/VrcyZT4OKVwvd3CLv
        z7zrqPm63IXSBmq/J9+3miuwTm6V6qdSUdXdfwq2b7nu0SYz1cx0pay5ePGWpRO3+oU9OSHQ
        l8wTIHbn2+M+CQ3m3nt7w+wvWiixFGckGmoxFxUnAgAC9dcz4gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7oeO9+mGBycIm/xYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
        kpqTWZZapG+XoJfx9cZeloJPSxkrPrx4z9rA2NnB2MXIySEhYCKx8PNaIJuLQ0hgKaNE59Ie
        JoiEtMThL1PYIWxhiT/XutggipqZJE5vec8MkmATMJB48GYZO0hCRGA5o8TVe8tZQBxmgeUs
        Es/XfACrEhYwlejZvQ9sH4uAqsT8KfNYQGxeATuJSwemQt0hL/H81h2wdZxA8enn28HOEBKw
        lVgz4RwbRL2gxMmZT8B6mYHqm7fOZp7AKDALSWoWktQCRqZVjCKppcW56bnFhnrFibnFpXnp
        esn5uZsYgZG57djPzTsY5736qHeIkYmD8RCjBAezkgjvJcdXKUK8KYmVValF+fFFpTmpxYcY
        TYHunsgsJZqcD0wNeSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFIN
        TLs4gw7V/jwhcFU16cXMX1aK+ywjTmzOvDtR72gay8xv7HMt/8hLrNkh36e0eGdJvsDSrKrQ
        qQLzF7lqSRm0t1kU/V6+4Fmn/8Rul2V39XJinlw4cnr5ObZFTsed+kP9k0oyX66ok5A+oN/W
        fd2zLT6jsED+9IPlFgW7nnyx+cc6x6yxVObd5Ec3NDNnHJ6oKtHx9+3kToZFfyVfPe0+o+Gy
        y2zG1Lk5Flv8Lly9J5W9b8er1xafNz4yTFHynXDSb1X1jGwTazvWgvWrfa+empfmFzzhzdSq
        hTJtn548i5RXEfi/cd63h7d6d0/PbXXyDgg62Ja2v2bbHee61au2KPHbtRxkMrXbnKrYy7bZ
        vlSJpTgj0VCLuag4EQBji6frVQMAAA==
X-CMS-MailID: 20230829092424eucas1p269935c8781c84b4c2a83d652f3370bf9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230829092424eucas1p269935c8781c84b4c2a83d652f3370bf9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230829092424eucas1p269935c8781c84b4c2a83d652f3370bf9
References: <20230829091853.626011-1-m.majewski2@samsung.com>
        <CGME20230829092424eucas1p269935c8781c84b4c2a83d652f3370bf9@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, each trip point defined in the device tree corresponds to a
single hardware interrupt. This commit instead switches to using two
hardware interrupts, whose values are set dynamically using the
set_trips callback. Additionally, the critical temperature threshold is
handled specifically.

Setting interrupts in this way also fixes a long-standing lockdep
warning, which was caused by calling thermal_zone_get_trips with our
lock being held. Do note that this requires TMU initialization to be
split into two parts, as done by the parent commit: parts of the
initialization call into the thermal_zone_device structure and so must
be done after its registration, but the initialization is also
responsible for setting up calibration, which must be done before
thermal_zone_device registration, which will call set_trips for the
first time; if the calibration is not done in time, the interrupt values
will be silently wrong!

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 390 +++++++++++++++------------
 1 file changed, 217 insertions(+), 173 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index aa3de367b3c7..5b35c51fca79 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -159,7 +159,6 @@ enum soc_type {
  *	0 < reference_voltage <= 31
  * @reg_conf: pointer to structure to register with core thermal.
  * @tzd: pointer to thermal_zone_device structure
- * @ntrip: number of supported trip points.
  * @enabled: current status of TMU device
  * @tmu_set_trip_temp: SoC specific method to set trip (rising threshold)
  * @tmu_set_trip_hyst: SoC specific to set hysteresis (falling threshold)
@@ -184,13 +183,13 @@ struct exynos_tmu_data {
 	u8 gain;
 	u8 reference_voltage;
 	struct thermal_zone_device *tzd;
-	unsigned int ntrip;
 	bool enabled;
 
-	void (*tmu_set_trip_temp)(struct exynos_tmu_data *data, int trip,
-				 u8 temp);
-	void (*tmu_set_trip_hyst)(struct exynos_tmu_data *data, int trip,
-				 u8 temp, u8 hyst);
+	void (*tmu_set_low_temp)(struct exynos_tmu_data *data, u8 temp);
+	void (*tmu_set_high_temp)(struct exynos_tmu_data *data, u8 temp);
+	void (*tmu_set_crit_temp)(struct exynos_tmu_data *data, u8 temp);
+	void (*tmu_disable_low)(struct exynos_tmu_data *data);
+	void (*tmu_disable_high)(struct exynos_tmu_data *data);
 	void (*tmu_initialize)(struct platform_device *pdev);
 	void (*tmu_control)(struct platform_device *pdev, bool on);
 	int (*tmu_read)(struct exynos_tmu_data *data);
@@ -274,43 +273,24 @@ static int exynos_thermal_zone_configure(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tzd = data->tzd;
-	int num_trips = thermal_zone_get_num_trips(tzd);
 	int ret = 0, temp;
 
 	ret = thermal_zone_get_crit_temp(tzd, &temp);
-
-	if (ret && data->soc != SOC_ARCH_EXYNOS5433) { /* FIXME */
-		dev_err(&pdev->dev,
-			"No CRITICAL trip point defined in device tree!\n");
-		goto err;
-	}
-
-	mutex_lock(&data->lock);
-
-	if (num_trips > data->ntrip) {
-		dev_info(&pdev->dev,
-			 "More trip points than supported by this TMU.\n");
-		dev_info(&pdev->dev,
-			 "%d trip points should be configured in polling mode.\n",
-			 num_trips - data->ntrip);
-	}
-
-	int i, ntrips = min_t(int, num_trips, data->ntrip);
-
-	/* Write temperature code for rising and falling threshold */
-	for (i = 0; i < ntrips; i++) {
-		struct thermal_trip trip;
-
-		ret = thermal_zone_get_trip(tzd, i, &trip);
-		if (ret)
+	if (ret) {
+		if (data->soc ==
+		    SOC_ARCH_EXYNOS5433) { /* FIXME: Remove this and the check below */
+			temp = INT_MAX;
+			ret = 0;
+		} else {
+			dev_err(&pdev->dev,
+				"No CRITICAL trip point defined in device tree!\n");
 			goto err;
-
-		data->tmu_set_trip_temp(data, i, trip.temperature / MCELSIUS);
-		data->tmu_set_trip_hyst(data, i, trip.temperature / MCELSIUS,
-					trip.hysteresis / MCELSIUS);
+		}
 	}
 
-	mutex_unlock(&data->lock);
+	if (temp < INT_MAX)
+		data->tmu_set_crit_temp(data, temp / MCELSIUS);
+
 err:
 	return ret;
 }
@@ -343,17 +323,56 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 	mutex_unlock(&data->lock);
 }
 
-static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
-					 int trip_id, u8 temp)
+static void exynos_tmu_update_bit(struct exynos_tmu_data *data, int reg_off,
+				  int bit_off, bool enable)
 {
-	temp = temp_to_code(data, temp);
-	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + trip_id * 4);
+	u32 interrupt_en;
+
+	interrupt_en = readl(data->base + reg_off);
+	if (enable)
+		interrupt_en |= 1 << bit_off;
+	else
+		interrupt_en &= ~(1 << bit_off);
+	writel(interrupt_en, data->base + reg_off);
 }
 
-/* failing thresholds are not supported on Exynos4210 */
-static void exynos4210_tmu_set_trip_hyst(struct exynos_tmu_data *data,
-					 int trip, u8 temp, u8 hyst)
+static void exynos4210_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
 {
+	/* Failing thresholds are not supported on Exynos 4210.
+	 * We use polling instead.
+	 */
+}
+
+static void exynos4210_tmu_set_high_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	temp = temp_to_code(data, temp);
+	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + 4);
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_RISE0_SHIFT + 4, true);
+}
+
+static void exynos4210_tmu_disable_low(struct exynos_tmu_data *data)
+{
+	/* Again, this is handled by polling. */
+}
+
+static void exynos4210_tmu_disable_high(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_RISE0_SHIFT + 4, false);
+}
+
+static void exynos4210_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	/* Hardware critical temperature handling is not supported on Exynos 4210.
+	 * We still set the critical temperature threshold, but this is only to
+	 * make sure it is handled as soon as possible. It is just a normal interrupt.
+	 */
+
+	temp = temp_to_code(data, temp);
+	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + 12);
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_RISE0_SHIFT + 12, true);
 }
 
 static void exynos4210_tmu_initialize(struct platform_device *pdev)
@@ -365,33 +384,49 @@ static void exynos4210_tmu_initialize(struct platform_device *pdev)
 	writeb(0, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
 }
 
-static void exynos4412_tmu_set_trip_temp(struct exynos_tmu_data *data,
-					 int trip, u8 temp)
-{
-	u32 th, con;
-
-	th = readl(data->base + EXYNOS_THD_TEMP_RISE);
-	th &= ~(0xff << 8 * trip);
-	th |= temp_to_code(data, temp) << 8 * trip;
-	writel(th, data->base + EXYNOS_THD_TEMP_RISE);
-
-	if (trip == 3) {
-		con = readl(data->base + EXYNOS_TMU_REG_CONTROL);
-		con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
-		writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
-	}
-}
-
-static void exynos4412_tmu_set_trip_hyst(struct exynos_tmu_data *data,
-					 int trip, u8 temp, u8 hyst)
+static void exynos4412_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
 {
 	u32 th;
 
 	th = readl(data->base + EXYNOS_THD_TEMP_FALL);
-	th &= ~(0xff << 8 * trip);
-	if (hyst)
-		th |= temp_to_code(data, temp - hyst) << 8 * trip;
+	th &= ~(0xff << 0);
+	th |= temp_to_code(data, temp) << 0;
 	writel(th, data->base + EXYNOS_THD_TEMP_FALL);
+
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT, true);
+}
+
+static void exynos4412_tmu_set_high_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	u32 th;
+
+	th = readl(data->base + EXYNOS_THD_TEMP_RISE);
+	th &= ~(0xff << 8);
+	th |= temp_to_code(data, temp) << 8;
+	writel(th, data->base + EXYNOS_THD_TEMP_RISE);
+
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_RISE0_SHIFT + 4, true);
+}
+
+static void exynos4412_tmu_disable_low(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT, false);
+}
+
+static void exynos4412_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	u32 th;
+
+	th = readl(data->base + EXYNOS_THD_TEMP_RISE);
+	th &= ~(0xff << 24);
+	th |= temp_to_code(data, temp) << 24;
+	writel(th, data->base + EXYNOS_THD_TEMP_RISE);
+
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_CONTROL,
+			      EXYNOS_TMU_THERM_TRIP_EN_SHIFT, true);
 }
 
 static void exynos4412_tmu_initialize(struct platform_device *pdev)
@@ -421,44 +456,57 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 	sanitize_temp_error(data, trim_info);
 }
 
-static void exynos5433_tmu_set_trip_temp(struct exynos_tmu_data *data,
-					 int trip, u8 temp)
+static void exynos5433_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
 {
-	unsigned int reg_off, j;
 	u32 th;
 
-	if (trip > 3) {
-		reg_off = EXYNOS5433_THD_TEMP_RISE7_4;
-		j = trip - 4;
-	} else {
-		reg_off = EXYNOS5433_THD_TEMP_RISE3_0;
-		j = trip;
-	}
+	th = readl(data->base + EXYNOS5433_THD_TEMP_FALL3_0);
+	th &= ~(0xff << 0);
+	th |= temp_to_code(data, temp) << 0;
+	writel(th, data->base + EXYNOS5433_THD_TEMP_FALL3_0);
 
-	th = readl(data->base + reg_off);
-	th &= ~(0xff << j * 8);
-	th |= (temp_to_code(data, temp) << j * 8);
-	writel(th, data->base + reg_off);
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT, true);
 }
 
-static void exynos5433_tmu_set_trip_hyst(struct exynos_tmu_data *data,
-					 int trip, u8 temp, u8 hyst)
+static void exynos5433_tmu_set_high_temp(struct exynos_tmu_data *data, u8 temp)
 {
-	unsigned int reg_off, j;
 	u32 th;
 
-	if (trip > 3) {
-		reg_off = EXYNOS5433_THD_TEMP_FALL7_4;
-		j = trip - 4;
-	} else {
-		reg_off = EXYNOS5433_THD_TEMP_FALL3_0;
-		j = trip;
-	}
+	th = readl(data->base + EXYNOS5433_THD_TEMP_RISE3_0);
+	th &= ~(0xff << 8);
+	th |= temp_to_code(data, temp) << 8;
+	writel(th, data->base + EXYNOS5433_THD_TEMP_RISE3_0);
 
-	th = readl(data->base + reg_off);
-	th &= ~(0xff << j * 8);
-	th |= (temp_to_code(data, temp - hyst) << j * 8);
-	writel(th, data->base + reg_off);
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 1, true);
+}
+
+static void exynos5433_tmu_disable_low(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT, false);
+}
+
+static void exynos5433_tmu_disable_high(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 1, false);
+}
+
+static void exynos5433_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	u32 th;
+
+	th = readl(data->base + EXYNOS5433_THD_TEMP_RISE7_4);
+	th &= ~(0xff << 24);
+	th |= temp_to_code(data, temp) << 24;
+	writel(th, data->base + EXYNOS5433_THD_TEMP_RISE7_4);
+
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_CONTROL,
+			      EXYNOS_TMU_THERM_TRIP_EN_SHIFT, true);
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 7, true);
 }
 
 static void exynos5433_tmu_initialize(struct platform_device *pdev)
@@ -494,34 +542,47 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
 			cal_type ?  2 : 1);
 }
 
-static void exynos7_tmu_set_trip_temp(struct exynos_tmu_data *data,
-				      int trip, u8 temp)
+static void exynos7_tmu_update_temp(struct exynos_tmu_data *data, u8 temp,
+				    int idx, bool rise)
 {
 	unsigned int reg_off, bit_off;
 	u32 th;
+	void __iomem *reg;
 
-	reg_off = ((7 - trip) / 2) * 4;
-	bit_off = ((8 - trip) % 2);
+	reg_off = ((7 - idx) / 2) * 4;
+	bit_off = ((8 - idx) % 2);
 
-	th = readl(data->base + EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
+	reg = data->base +
+	      (rise ? EXYNOS7_THD_TEMP_RISE7_6 : EXYNOS7_THD_TEMP_FALL7_6) +
+	      reg_off;
+	th = readl(reg);
 	th &= ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
 	th |= temp_to_code(data, temp) << (16 * bit_off);
-	writel(th, data->base + EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
+	writel(th, reg);
+
+	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
+			      (rise ? EXYNOS7_TMU_INTEN_RISE0_SHIFT :
+				      EXYNOS_TMU_INTEN_FALL0_SHIFT) +
+				      idx,
+			      true);
 }
 
-static void exynos7_tmu_set_trip_hyst(struct exynos_tmu_data *data,
-				      int trip, u8 temp, u8 hyst)
+static void exynos7_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
 {
-	unsigned int reg_off, bit_off;
-	u32 th;
+	exynos7_tmu_update_temp(data, temp, 0, false);
+}
 
-	reg_off = ((7 - trip) / 2) * 4;
-	bit_off = ((8 - trip) % 2);
+static void exynos7_tmu_set_high_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	exynos7_tmu_update_temp(data, temp, 1, true);
+}
 
-	th = readl(data->base + EXYNOS7_THD_TEMP_FALL7_6 + reg_off);
-	th &= ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
-	th |= temp_to_code(data, temp - hyst) << (16 * bit_off);
-	writel(th, data->base + EXYNOS7_THD_TEMP_FALL7_6 + reg_off);
+static void exynos7_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	/* Like Exynos 4210, Exynos 7 does not seem to support critical temperature
+	 * handling in hardware. Again, we still set a separate interrupt for it.
+	 */
+	exynos7_tmu_update_temp(data, temp, 7, true);
 }
 
 static void exynos7_tmu_initialize(struct platform_device *pdev)
@@ -536,87 +597,44 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
 static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
-	struct thermal_trip trip;
-	unsigned int con, interrupt_en = 0, i;
+	unsigned int con;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
-	if (on) {
-		for (i = 0; i < data->ntrip; i++) {
-			if (thermal_zone_get_trip(tz, i, &trip))
-				continue;
-
-			interrupt_en |=
-				(1 << (EXYNOS_TMU_INTEN_RISE0_SHIFT + i * 4));
-		}
-
-		if (data->soc != SOC_ARCH_EXYNOS4210)
-			interrupt_en |=
-				interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
-
+	if (on)
 		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
-	} else {
+	else
 		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
-	}
 
-	writel(interrupt_en, data->base + EXYNOS_TMU_REG_INTEN);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
 
 static void exynos5433_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
-	struct thermal_trip trip;
-	unsigned int con, interrupt_en = 0, pd_det_en, i;
+	unsigned int con, pd_det_en;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
-	if (on) {
-		for (i = 0; i < data->ntrip; i++) {
-			if (thermal_zone_get_trip(tz, i, &trip))
-				continue;
-
-			interrupt_en |=
-				(1 << (EXYNOS7_TMU_INTEN_RISE0_SHIFT + i));
-		}
-
-		interrupt_en |=
-			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
-
+	if (on)
 		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
-	} else
+	else
 		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
 
 	pd_det_en = on ? EXYNOS5433_PD_DET_EN : 0;
 
 	writel(pd_det_en, data->base + EXYNOS5433_TMU_PD_DET_EN);
-	writel(interrupt_en, data->base + EXYNOS5433_TMU_REG_INTEN);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
 
 static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
-	struct thermal_trip trip;
-	unsigned int con, interrupt_en = 0, i;
+	unsigned int con;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
 	if (on) {
-		for (i = 0; i < data->ntrip; i++) {
-			if (thermal_zone_get_trip(tz, i, &trip))
-				continue;
-
-			interrupt_en |=
-				(1 << (EXYNOS7_TMU_INTEN_RISE0_SHIFT + i));
-		}
-
-		interrupt_en |=
-			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
-
 		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
 		con |= (1 << EXYNOS7_PD_DET_EN_SHIFT);
 	} else {
@@ -624,7 +642,6 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 		con &= ~(1 << EXYNOS7_PD_DET_EN_SHIFT);
 	}
 
-	writel(interrupt_en, data->base + EXYNOS7_TMU_REG_INTEN);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
 
@@ -856,13 +873,15 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 
 	switch (data->soc) {
 	case SOC_ARCH_EXYNOS4210:
-		data->tmu_set_trip_temp = exynos4210_tmu_set_trip_temp;
-		data->tmu_set_trip_hyst = exynos4210_tmu_set_trip_hyst;
+		data->tmu_set_low_temp = exynos4210_tmu_set_low_temp;
+		data->tmu_set_high_temp = exynos4210_tmu_set_high_temp;
+		data->tmu_disable_low = exynos4210_tmu_disable_low;
+		data->tmu_disable_high = exynos4210_tmu_disable_high;
+		data->tmu_set_crit_temp = exynos4210_tmu_set_crit_temp;
 		data->tmu_initialize = exynos4210_tmu_initialize;
 		data->tmu_control = exynos4210_tmu_control;
 		data->tmu_read = exynos4210_tmu_read;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
-		data->ntrip = 4;
 		data->gain = 15;
 		data->reference_voltage = 7;
 		data->efuse_value = 55;
@@ -875,14 +894,16 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	case SOC_ARCH_EXYNOS5260:
 	case SOC_ARCH_EXYNOS5420:
 	case SOC_ARCH_EXYNOS5420_TRIMINFO:
-		data->tmu_set_trip_temp = exynos4412_tmu_set_trip_temp;
-		data->tmu_set_trip_hyst = exynos4412_tmu_set_trip_hyst;
+		data->tmu_set_low_temp = exynos4412_tmu_set_low_temp;
+		data->tmu_set_high_temp = exynos4412_tmu_set_high_temp;
+		data->tmu_disable_low = exynos4412_tmu_disable_low;
+		data->tmu_disable_high = exynos4210_tmu_disable_high;
+		data->tmu_set_crit_temp = exynos4412_tmu_set_crit_temp;
 		data->tmu_initialize = exynos4412_tmu_initialize;
 		data->tmu_control = exynos4210_tmu_control;
 		data->tmu_read = exynos4412_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
-		data->ntrip = 4;
 		data->gain = 8;
 		data->reference_voltage = 16;
 		data->efuse_value = 55;
@@ -894,14 +915,16 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->max_efuse_value = 100;
 		break;
 	case SOC_ARCH_EXYNOS5433:
-		data->tmu_set_trip_temp = exynos5433_tmu_set_trip_temp;
-		data->tmu_set_trip_hyst = exynos5433_tmu_set_trip_hyst;
+		data->tmu_set_low_temp = exynos5433_tmu_set_low_temp;
+		data->tmu_set_high_temp = exynos5433_tmu_set_high_temp;
+		data->tmu_disable_low = exynos5433_tmu_disable_low;
+		data->tmu_disable_high = exynos5433_tmu_disable_high;
+		data->tmu_set_crit_temp = exynos5433_tmu_set_crit_temp;
 		data->tmu_initialize = exynos5433_tmu_initialize;
 		data->tmu_control = exynos5433_tmu_control;
 		data->tmu_read = exynos4412_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
-		data->ntrip = 8;
 		data->gain = 8;
 		if (res.start == EXYNOS5433_G3D_BASE)
 			data->reference_voltage = 23;
@@ -912,14 +935,16 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->max_efuse_value = 150;
 		break;
 	case SOC_ARCH_EXYNOS7:
-		data->tmu_set_trip_temp = exynos7_tmu_set_trip_temp;
-		data->tmu_set_trip_hyst = exynos7_tmu_set_trip_hyst;
+		data->tmu_set_low_temp = exynos7_tmu_set_low_temp;
+		data->tmu_set_high_temp = exynos7_tmu_set_high_temp;
+		data->tmu_disable_low = exynos5433_tmu_disable_low;
+		data->tmu_disable_high = exynos5433_tmu_disable_high;
+		data->tmu_set_crit_temp = exynos7_tmu_set_crit_temp;
 		data->tmu_initialize = exynos7_tmu_initialize;
 		data->tmu_control = exynos7_tmu_control;
 		data->tmu_read = exynos7_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
-		data->ntrip = 8;
 		data->gain = 9;
 		data->reference_voltage = 17;
 		data->efuse_value = 75;
@@ -955,9 +980,28 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	return 0;
 }
 
+static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
+
+	mutex_lock(&data->lock);
+	if (low > INT_MIN)
+		data->tmu_set_low_temp(data, low / MCELSIUS);
+	else
+		data->tmu_disable_low(data);
+	if (high < INT_MAX)
+		data->tmu_set_high_temp(data, high / MCELSIUS);
+	else
+		data->tmu_disable_high(data);
+	mutex_unlock(&data->lock);
+
+	return 0;
+}
+
 static const struct thermal_zone_device_ops exynos_sensor_ops = {
 	.get_temp = exynos_get_temp,
 	.set_emul_temp = exynos_tmu_set_emulation,
+	.set_trips = exynos_set_trips,
 };
 
 static int exynos_tmu_probe(struct platform_device *pdev)
-- 
2.41.0


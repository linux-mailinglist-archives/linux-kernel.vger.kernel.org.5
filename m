Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D689B78C13F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjH2JYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbjH2JYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:24:23 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC76A1B3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:24:12 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230829092411euoutp0209e10a135765c22e4a553ca2c89b1ed3~-0FXFZmLW0626506265euoutp02y
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:24:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230829092411euoutp0209e10a135765c22e4a553ca2c89b1ed3~-0FXFZmLW0626506265euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693301051;
        bh=/YwrTa0ESS+UZ/KcX0BatXOuWIqWi30gs4sg9b7MyU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOZNT0Clqy0kIQPUk57NiBnuPrj9+JtU2MpUw3uHtZsVfLPvMYi1mFNN3ngBDd1B5
         lDXw8sgZ75wLvF0/g3b/Jza0TjM8Hp/KOtOEaFOvOYuJtQbfpWiHKmCDxPpgaQ7ZGz
         ruterhyr1WgmrGYwI04n7LYtFcxfN36CHF2fsFcY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230829092411eucas1p18948ca3df6f6049f2d055bb275baf85e~-0FWuLK-T2104121041eucas1p1U;
        Tue, 29 Aug 2023 09:24:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 76.D8.42423.B39BDE46; Tue, 29
        Aug 2023 10:24:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092410eucas1p243a88662e8e64f0c406685931d9a80a3~-0FWVUtuh2471924719eucas1p20;
        Tue, 29 Aug 2023 09:24:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230829092410eusmtrp102d89b4ca0e1ae6ac30c2946642efee9~-0FWUlhyK3248032480eusmtrp1s;
        Tue, 29 Aug 2023 09:24:10 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-17-64edb93baa45
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BA.D9.10549.A39BDE46; Tue, 29
        Aug 2023 10:24:10 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092409eusmtip2bf7f8cefba59264b42ba325b5b64538f~-0FVRYGrh0986509865eusmtip2Y;
        Tue, 29 Aug 2023 09:24:09 +0000 (GMT)
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
Subject: [PATCH 03/11] thermal: exynos: switch from workqueue-driven
 interrupt handling to threaded interrupts
Date:   Tue, 29 Aug 2023 11:18:41 +0200
Message-ID: <20230829091853.626011-4-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829091853.626011-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djP87rWO9+mGDz7x2fxYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJVxa91WxoJVEhW/pvxlb2CcJ9LFyMkhIWAi
        Me3gc5YuRi4OIYEVjBJP1r5mhnC+MEq82LMWyvnMKPHh3TSgMg6wlvPPRCHiyxklvl1dxQ7h
        tDJJLPrykxlkLpuAgcSDN8vAEiICixkltu6cxQTiMAvMZZFoWPmTBaRKWKBAYsq6n6wgY1kE
        VCXm7WMDMXkFbCWmnraGuE9e4vmtO+wgNqeAncT08+1MIDavgKDEyZlPwKYwA9U0b53NDFE/
        n1Pix79EiENdJB6ssIIIC0u8Or6FHcKWkTg9uYcFws6XmLH5PdRfFRJ3D3pBmNYSH88wg5jM
        ApoS63fpQ0QdJTq/uEGYfBI33gpCbOeTmLRtOjNEmFeio00IYrKqxPE9k6COkpZ40nKbCcL2
        kFj3o5NxAqPiLCR/zELyxyyEtQsYmVcxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEprbT
        /45/2sE499VHvUOMTByMhxglOJiVRHgvOb5KEeJNSaysSi3Kjy8qzUktPsQozcGiJM6rbXsy
        WUggPbEkNTs1tSC1CCbLxMEp1cDU1CJ2Ydfsfm1n9VflG30UN16fqXtQzdpyQYpfcmSru3qw
        3dllOtfXFU6vnHbNVyhy8pzpBlon94a+vd/X07Hk8xS/VO97kXsOmr5yr69/2qL3ObKx4lXK
        zjzeuqbtXtLpD82DhNUSYptVuDh0jbcH5hbeVlgwZVHoQp/VL6OfbzhzzGF3le06R1t2xWkK
        Jiybdbe9lHy57PO9O+9v+XIcbHJ5f5rZe9oUrjMFb15cOsk7K+1+47GOqi1ZWZeOyddWnGh8
        UvPlmO18N63OqBe7nnnWa211OsNzN1nmqcGhOP/9W2bWz+X/UCRr0H07uC1+7ww+JvGcgoIV
        kRfPM3EsKDklnxFt8k1/j95RqXIlluKMREMt5qLiRACdlSYk3AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7pWO9+mGByeZWjxYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
        kpqTWZZapG+XoJdxa91WxoJVEhW/pvxlb2CcJ9LFyMEhIWAicf6ZaBcjF4eQwFJGiRc9v9m6
        GDmB4tISh79MYYewhSX+XOtigyhqZpI4umoRE0iCTcBA4sGbZewgCRGB5YwSV+8tZwFxmAWW
        s0g8X/OBGaRKWCBPom/5KkaQdSwCqhLz9rGBmLwCthJTT1tDLJCXeH7rDtgyTgE7ienn28Hm
        CwGVrJlwDuwgXgFBiZMzn7CA2MxA9c1bZzNPYBSYhSQ1C0lqASPTKkaR1NLi3PTcYkO94sTc
        4tK8dL3k/NxNjMB43Hbs5+YdjPNefdQ7xMjEwXiIUYKDWUmE95LjqxQh3pTEyqrUovz4otKc
        1OJDjKZAV09klhJNzgcmhLySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4m
        Dk6pBibvuAvm16YE3/HS+S+Tdzpc3fmfLUtX9sXKhUyOL39vsWMTu9CXe+bCjP8PpbK9Z3Dt
        jHf5Ln/+l/jpr2/iFb7sE3Q/kPROccIHraod1t6fd4Szf9ogW79ykli03Pd1O/esONd+ffnf
        /fIpBlwxrlYzai6/3bfzc8mVM6GdDL6z1Jd47Ja1dpfj3cHG7vJe4GlL20m16uTk+Xxfgs9d
        WJO3RVZIQoBp7/GKY6+YpBftk1prfzlxumP8A9dAl/rtV5kqLikvmWGtK8p/43ZM5ovFFySv
        lk56O1VGMm7z7Nd7jm2WCLQ4vvnSA6fe/U13v1tNbHh8XGGu95WfP0skP4Uxxf3zu6xj+1hv
        gqen8q9KJZbijERDLeai4kQA2g7wF1ADAAA=
X-CMS-MailID: 20230829092410eucas1p243a88662e8e64f0c406685931d9a80a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230829092410eucas1p243a88662e8e64f0c406685931d9a80a3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230829092410eucas1p243a88662e8e64f0c406685931d9a80a3
References: <20230829091853.626011-1-m.majewski2@samsung.com>
        <CGME20230829092410eucas1p243a88662e8e64f0c406685931d9a80a3@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue boilerplate is mostly one-to-one what the threaded
interrupts do.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 70e9c0296ee1..35b0a55017ad 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -142,7 +142,6 @@ enum soc_type {
  * @base_second: base address of the common registers of the TMU controller.
  * @irq: irq number of the TMU controller.
  * @soc: id of the SOC type.
- * @irq_work: pointer to the irq work structure.
  * @lock: lock to implement synchronization.
  * @clk: pointer to the clock structure.
  * @clk_sec: pointer to the clock structure for accessing the base_second.
@@ -176,7 +175,6 @@ struct exynos_tmu_data {
 	void __iomem *base_second;
 	int irq;
 	enum soc_type soc;
-	struct work_struct irq_work;
 	struct mutex lock;
 	struct clk *clk, *clk_sec, *sclk;
 	u32 cal_type;
@@ -764,10 +762,9 @@ static int exynos7_tmu_read(struct exynos_tmu_data *data)
 		EXYNOS7_TMU_TEMP_MASK;
 }
 
-static void exynos_tmu_work(struct work_struct *work)
+static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 {
-	struct exynos_tmu_data *data = container_of(work,
-			struct exynos_tmu_data, irq_work);
+	struct exynos_tmu_data *data = id;
 
 	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
 
@@ -779,7 +776,8 @@ static void exynos_tmu_work(struct work_struct *work)
 
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
-	enable_irq(data->irq);
+
+	return IRQ_HANDLED;
 }
 
 static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
@@ -813,16 +811,6 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 	writel(val_irq, data->base + tmu_intclear);
 }
 
-static irqreturn_t exynos_tmu_irq(int irq, void *id)
-{
-	struct exynos_tmu_data *data = id;
-
-	disable_irq_nosync(irq);
-	schedule_work(&data->irq_work);
-
-	return IRQ_HANDLED;
-}
-
 static const struct of_device_id exynos_tmu_match[] = {
 	{
 		.compatible = "samsung,exynos3250-tmu",
@@ -1024,8 +1012,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_sensor;
 
-	INIT_WORK(&data->irq_work, exynos_tmu_work);
-
 	data->clk = devm_clk_get(&pdev->dev, "tmu_apbif");
 	if (IS_ERR(data->clk)) {
 		dev_err(&pdev->dev, "Failed to get clock\n");
@@ -1094,8 +1080,10 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_sclk;
 	}
 
-	ret = devm_request_irq(&pdev->dev, data->irq, exynos_tmu_irq,
-		IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
+	ret = devm_request_threaded_irq(
+		&pdev->dev, data->irq, NULL, exynos_tmu_threaded_irq,
+		IRQF_TRIGGER_RISING | IRQF_SHARED | IRQF_ONESHOT,
+		dev_name(&pdev->dev), data);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq: %d\n", data->irq);
 		goto err_sclk;
-- 
2.41.0


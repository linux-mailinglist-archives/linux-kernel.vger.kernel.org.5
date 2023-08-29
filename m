Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD4D78C143
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjH2JYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjH2JYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:24:23 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D511B7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:24:19 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230829092410euoutp01d3bb6c2c3d051923b5dbd5357cec19ac~-0FVfWhi21738917389euoutp01c
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:24:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230829092410euoutp01d3bb6c2c3d051923b5dbd5357cec19ac~-0FVfWhi21738917389euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693301050;
        bh=P34LvyBd3DIzM/01pFsL6osI5wPMYG7QBHPOp6UyW3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X11MX07hLbBYbNccF7kpbDKdpjaFxkhaRfi7+UAzCFNKfWk4ADgt3iI8piMrF3fna
         jPU/uCCFaLsXyVIIxjjDtr1dnomc6H/fCaXFasgZ4PwthM9UaCjVSaZCyro2bAh+bG
         Ren6/o5bimXRrZtrAS5CA3w7uD3ZPXBLcmkvuPfs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230829092409eucas1p2eb7888fd7a048f0dc432839b8dc5a7c3~-0FU1W7b73169731697eucas1p2n;
        Tue, 29 Aug 2023 09:24:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 42.7F.37758.939BDE46; Tue, 29
        Aug 2023 10:24:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092408eucas1p24901bbd192db03b69d774f2c5936f5b3~-0FUU3pn52802128021eucas1p2g;
        Tue, 29 Aug 2023 09:24:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230829092408eusmtrp1c398a84095b24b2ab9461cd879135176~-0FUULXbt3248032480eusmtrp1m;
        Tue, 29 Aug 2023 09:24:08 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-39-64edb9399b8b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 09.D9.10549.839BDE46; Tue, 29
        Aug 2023 10:24:08 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092407eusmtip21454f38562007fa2dbc8ea627f7f64ac~-0FTXL5VJ1173411734eusmtip2c;
        Tue, 29 Aug 2023 09:24:07 +0000 (GMT)
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
Subject: [PATCH 02/11] thermal: exynos: drop id field
Date:   Tue, 29 Aug 2023 11:18:40 +0200
Message-ID: <20230829091853.626011-3-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829091853.626011-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djP87qWO9+mGMycxWPxYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJVxaOY/5oKj3BXbFvxmbWBczdnFyMkhIWAi
        ceT7OSYQW0hgBaPEjr/cXYxcQPYXRonre2cwQjifGSW+7u5gh+k4tHgCM0RiOaPErceHodpb
        mSQmHZAEsdkEDCQevFnGDlIkIrCYUWLrzllMIA6zwFwWiYaVP1lAqoQFTCU2rjwINpZFQFVi
        9tsvrCA2r4CtxITvu9gg1slLPL91B6yGU8BOYvr5diaIGkGJkzOfgM1hBqpp3job7CQJgdmc
        EvMuvYNqdpFovPiPGcIWlnh1fAvUDzISpyf3sEDY+RIzNr8HsjmA7AqJuwe9IExriY9nmEFM
        ZgFNifW79CGKHSXO7PzIBlHBJ3HjrSDEAXwSk7ZNZ4YI80p0tAlBVKtKHN8zCWq9tMSTlttM
        ECUeEu9b9ScwKs5C8sksJJ/MQli7gJF5FaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmCC
        O/3v+NcdjCtefdQ7xMjEwXiIUYKDWUmE95LjqxQh3pTEyqrUovz4otKc1OJDjNIcLErivNq2
        J5OFBNITS1KzU1MLUotgskwcnFINTLYr9fe2WOtNnLnKSP3W6ryQx8GszzSPpLEuDnZd23ri
        rye74Mnr1XPDV+X9tzFoOxf545NE9X/7Xwsudubee/qY6dajlDuNGc9z2NhWSb46+vIh/565
        /v3ZMQ37XF4YHF7rodux6aGRd8G2jRz7Jxyqy3XQ+s+VFDLxS+l++4bFUkyCuzuP3AxcVPfw
        2SKvJ2dsvPdPzTM79+OSk332ZVnWR3eaIwt4r2b+PJkQJmaa8cZFvIhBs04tvWpxnqvgtVhB
        Rp7TLucFDAIfa5ycL96lcafnQ6etz6oyW6mGHcpuMwsncVgxT+Q/xsHnUhN20ui9V4Cur8vm
        wC6/A7v3mVWt7fR7HSZxLMtMwn6JEktxRqKhFnNRcSIA+qF7Fd8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7oWO9+mGDyar27xYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
        kpqTWZZapG+XoJdxaOY/5oKj3BXbFvxmbWBczdnFyMkhIWAicWjxBGYQW0hgKaPEtXesEHFp
        icNfprBD2MISf651sXUxcgHVNDNJ7HnVwAKSYBMwkHjwZhk7SEJEYDmjxNV7y1lAHGaB5SwS
        z9d8ABsrLGAqsXHlQbBRLAKqErPffgFbwStgKzHh+y42iBXyEs9v3QGr4RSwk5h+vp0J4iRb
        iTUTzrFB1AtKnJz5BGwzM1B989bZzBMYBWYhSc1CklrAyLSKUSS1tDg3PbfYUK84Mbe4NC9d
        Lzk/dxMjMCa3Hfu5eQfjvFcf9Q4xMnEwHmKU4GBWEuG95PgqRYg3JbGyKrUoP76oNCe1+BCj
        KdDdE5mlRJPzgUkhryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qB
        SZ7vYSqP8bt870e/jk3dXatku3P5mfhTdtufBWe1XDtuL7D4UXfVjg3zhCSyivNuLtK1WzH7
        3jLtN0GJUV7t21bE2R9f7xOa/y2kp0L2kxBXqMwM3yPHTun+sjp9/8jO6nefnOa81NRbyH75
        lrfg4yzZHdVPXAwOS06/9P3GkkeTb1ZLijn2NNTdfjZtxnrlin4xZmv5Nwe2h8pemJbNn7Pf
        Lmhlk79KwLKgkPUNk7M6fHmyL8jZdzV//hu8RuTN95wtln8XZEhWxta/YOoR55xdsum2vUDr
        Xy59i+7X3j/qd1gpTD/3f9708MCcOwoCYtons+tObvr17b/JhcCWy8Hp8w9yffpRcWXR2+vP
        diixFGckGmoxFxUnAgBNkSLWUgMAAA==
X-CMS-MailID: 20230829092408eucas1p24901bbd192db03b69d774f2c5936f5b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230829092408eucas1p24901bbd192db03b69d774f2c5936f5b3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230829092408eucas1p24901bbd192db03b69d774f2c5936f5b3
References: <20230829091853.626011-1-m.majewski2@samsung.com>
        <CGME20230829092408eucas1p24901bbd192db03b69d774f2c5936f5b3@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This field is not used in code, and seems to not have any meaning; in my
tests, the value was always 0.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 45e5c840d130..70e9c0296ee1 100644
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
@@ -173,7 +172,6 @@ enum soc_type {
  * @tmu_clear_irqs: SoC specific TMU interrupts clearing method
  */
 struct exynos_tmu_data {
-	int id;
 	void __iomem *base;
 	void __iomem *base_second;
 	int irq;
@@ -866,10 +864,6 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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
2.41.0


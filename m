Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8807B67A6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbjJCLRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239897AbjJCLRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:17:14 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD97B0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:17:09 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231003111708euoutp015c21d2fb1261990b07a5e11ead8685fa~KlM9ehKot1220212202euoutp01d
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:17:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231003111708euoutp015c21d2fb1261990b07a5e11ead8685fa~KlM9ehKot1220212202euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696331828;
        bh=kSlZRZZZYwokLKnnMzMRsCX62Vw++ZxZSxihVjzwQk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9nTjyjEsWcfq5YU3eeOaRkq/emOlob2QHSE7dfzeXHh0Fpb6y1gZKaOXsGKSdaW7
         zkE7Jv/43KniY/sl5mMZoVhOteBXADxfkBxXVKGJj0pgCN3a5jU4INwsz/3exgFifI
         GwPNOvGckgisoITeW6ANTTQdlvDdoKlVSRCn5S94=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231003111707eucas1p23d6471359956640c696157b700f7a153~KlM88kgCg2468224682eucas1p2x;
        Tue,  3 Oct 2023 11:17:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 33.14.11320.338FB156; Tue,  3
        Oct 2023 12:17:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231003111707eucas1p2ec2e5eacf68ecb0610f74ca1105c9da4~KlM8ipCRZ2873428734eucas1p2H;
        Tue,  3 Oct 2023 11:17:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231003111707eusmtrp196e15560308b447fc108fda720121c06~KlM8iBcL52239722397eusmtrp13;
        Tue,  3 Oct 2023 11:17:07 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-32-651bf833bedd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5A.CE.25043.238FB156; Tue,  3
        Oct 2023 12:17:06 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231003111706eusmtip21caa2dee1934b1182cdd7a7e8413b514~KlM7vX00_2730527305eusmtip2c;
        Tue,  3 Oct 2023 11:17:06 +0000 (GMT)
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
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 2/8] thermal: exynos: drop id field
Date:   Tue,  3 Oct 2023 13:16:28 +0200
Message-ID: <20231003111638.241542-3-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003111638.241542-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djPc7rGP6RTDQ5ek7B4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB7F
        ZZOSmpNZllqkb5fAlbHv1knmgkk8FS/WyDYwfuLsYuTkkBAwkTgy/z1zFyMXh5DACkaJFf8O
        s0A4XxglTn2/xwbhfGaUmHv3MztMy4OW6VBVyxkldi9+xAaSEBJoZZJY+aIIxGYTMJB48GYZ
        WIOIQCujxMwmdZAGZoFLzBJ3b64F6ubgEBYwk1g6Xx2khkVAVeLyq1lg9bwCthL9P86yQCyT
        l9iz6DsTiM0pYCex8udyJogaQYmTM5+A1TAD1TRvnQ32g4RAM6fEhduboZpdJOZNvsoKYQtL
        vDq+BeoDGYnTk3ugavIlZmx+D3aPhECFxN2DXhCmtcTHM8wgJrOApsT6XfoQxY4STyZtYIeo
        4JO48VYQ4gA+iUnbpjNDhHklOtqEIKpVJY7vmcQMYUtLPGm5zQRhe0g8Xz2JfQKj4iwkr8xC
        8soshL0LGJlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBCaw0/+Of9nBuPzVR71DjEwc
        jIcYJTiYlUR4w45KpQrxpiRWVqUW5ccXleakFh9ilOZgURLn1bY9mSwkkJ5YkpqdmlqQWgST
        ZeLglGpgKrt46Vts3mH5OLc+3tt3Tnnfa2x55m1fukrhZsWzU7YCSh3/jM3l/+9/MPPPAhG2
        B/ZcBsyvNIyOLZx833vPuSkyD76/fqJ5pKnq8bOwRMZrXVs7rz+JmO/F5do08yLXtktdPu/e
        NFt7TMyTOrT5u32cc9AheX7bjy4PxFWDfgvLVxm7Pds9K+Xq+cSHuS5b1j6RrJ637PTm+Q6S
        zTPr/P0vriy5a3u7+fmNPKP69f5ftVz6sk65iad1sJY59F7L3XIsNeXcjj0v+JNS5aJtF5p8
        8P894c21wydVFAu+TzW9L+Jqd1NnCe8/hkmF27ao7ly/ru+aRI247AHD3Y9LY55ZstYaq3mt
        5ytI4bpwW4mlOCPRUIu5qDgRAKRzbjHPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xe7pGP6RTDY4+t7B4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB6l
        Z1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7Hv1knm
        gkk8FS/WyDYwfuLsYuTkkBAwkXjQMp2li5GLQ0hgKaPE8/9/mCES0hKHv0xhh7CFJf5c62KD
        KGpmktjxdTFYEZuAgcSDN8vYQRIiAp2MEl2bzzGBJJgFbjFL3H+t1cXIwSEsYCaxdL46SJhF
        QFXi8qtZYEN5BWwl+n+cZYFYIC+xZ9F3sFZOATuJlT+Xg9lCQDW3lu9jgagXlDg58wkLxHh5
        ieats5knMArMQpKahSS1gJFpFaNIamlxbnpusZFecWJucWleul5yfu4mRmDEbTv2c8sOxpWv
        PuodYmTiYDzEKMHBrCTCG3ZUKlWINyWxsiq1KD++qDQntfgQoynQ3ROZpUST84Exn1cSb2hm
        YGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwJT0Ni/jx5FfkQt7Ewyc1Z0f
        Rl6UNJQI3hDGt2fL3a/nCy8cC6loSTgtO4ExiVHvTF7mcp04rQ/Trl7oC1/AyyLg5GF1YI/M
        tX3pM8982aa9gq1599utCyaVb5jilRLvUzN5rkO1Vd36P4n3Zpiw3hWZbbLxZbKe45RNqk/m
        xdutnrCzOO9+6rXu4++q3k3Rv7+g58s6TcbIj/KbF22UK18559pUV7FLO/x2Lrz3IsV+5l1H
        juLrob0vPbcam5s8P+IS/n3h7vdpAf8zl2xXn1/rUDvn4qSsHbNEi4Ra1n8pabr5e1JGxRrb
        ly++Vlt4rjtg0DdBw3rl9biUZye2vqz4IqExZ96jnprcxSy/SidfUmIpzkg01GIuKk4EAB8K
        PHZBAwAA
X-CMS-MailID: 20231003111707eucas1p2ec2e5eacf68ecb0610f74ca1105c9da4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231003111707eucas1p2ec2e5eacf68ecb0610f74ca1105c9da4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231003111707eucas1p2ec2e5eacf68ecb0610f74ca1105c9da4
References: <20231003111638.241542-1-m.majewski2@samsung.com>
        <CGME20231003111707eucas1p2ec2e5eacf68ecb0610f74ca1105c9da4@eucas1p2.samsung.com>
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
index 2c1cfb8c4b33..90c33e8017af 100644
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


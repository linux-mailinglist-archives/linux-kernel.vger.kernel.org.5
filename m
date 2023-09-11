Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110C479B9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349681AbjIKVe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbjIKNgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:36:18 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA7A125
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:36:13 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230911133612euoutp0144ff2283cd593f5673ea987c9feabaff~D26HDn_TB2488224882euoutp01I
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:36:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230911133612euoutp0144ff2283cd593f5673ea987c9feabaff~D26HDn_TB2488224882euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694439372;
        bh=KEJwLcfqNIjrIdBLofc1siG7b7b+QXBN4yDVWX5CT1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9DhIskjlHGa8Xxsb2MS9ZabecNECpC1cPimeb7GPz3MHStDP1pS5OdsvSUFoU2Fn
         bzQm46NC05LF+oAHUZw691hahF2d2+ks+OHB1mDrsb6L+sf0FN1JysEDL1x8uJ+FOB
         hHUH2MwqNd2KrjjdAgAlKWdnqqFwuRgrJx+vtn+A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230911133612eucas1p2c831c1925d270486dcbf601a6eaff060~D26GvMDhT1199911999eucas1p2M;
        Mon, 11 Sep 2023 13:36:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D1.B1.42423.CC71FF46; Mon, 11
        Sep 2023 14:36:12 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230911133611eucas1p286e43809a6ca785911c0bbdce15dc15d~D26GWN5KZ0493804938eucas1p25;
        Mon, 11 Sep 2023 13:36:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230911133611eusmtrp2225c2df081edc27773ab5988e93838c9~D26GVhK9x0862108621eusmtrp2Y;
        Mon, 11 Sep 2023 13:36:11 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-4e-64ff17cc51bb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1C.7A.14344.BC71FF46; Mon, 11
        Sep 2023 14:36:11 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230911133610eusmtip206ee8e112c4c553376e284fb923c64a7~D26FToWWL0267702677eusmtip2Q;
        Mon, 11 Sep 2023 13:36:10 +0000 (GMT)
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
Subject: [PATCH v2 1/7] thermal: exynos: remove an unnecessary field
 description
Date:   Mon, 11 Sep 2023 15:34:25 +0200
Message-ID: <20230911133435.14061-2-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911133435.14061-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djPc7pnxP+nGCzu5bZ4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB7F
        ZZOSmpNZllqkb5fAlbGwZwNTwXO2ive//zE3MF5l7WLk5JAQMJG4O+kLcxcjF4eQwApGid0n
        1rGDJIQEvjBKdG+Tg0h8ZpRofH2RBabjRPcCVoii5YwSe/frQhS1Mkkcf7EcrIhNwEDiwZtl
        YJNEBFoZJWY2qYMUMQtcYpa4e3MtWJGwQJDEnq8L2UBsFgFViR9XtzGC2LwCNhK7T39nhNgm
        L/H81h2wQZwCthJn105nh6gRlDg58wnYHGagmuats8F+kBBo5pToa1vDBtHsIvG++xMThC0s
        8er4FnYIW0bi/875UPF8iRmb3wMN4gCyKyTuHvSCMK0lPp5hBjGZBTQl1u/Shyh2lPj9ZR4b
        RAWfxI23ghAH8ElM2jadGSLMK9HRJgRRrSpxfM8kZghbWuJJy22olR4SK880sE5gVJyF5JVZ
        SF6ZhbB3ASPzKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMAUdvrf8U87GOe++qh3iJGJ
        g/EQowQHs5IIb8mhvylCvCmJlVWpRfnxRaU5qcWHGKU5WJTEebVtTyYLCaQnlqRmp6YWpBbB
        ZJk4OKUamJyT+O2ld+d21Pwsu75s0tHqm46al34xdS52P7B7qkd7MEuZbjZjRUWGtDLT//m3
        FydLM258dCD+75cpwUG5E383TQ6aqRx47GxV46Gl9xNenuLr3ckZenSHc/6O26GlHxKlzz17
        67jZ8ez3gOPN12MmFcl7+VdEq3RwNXUXJ8W7JNxN7U0vmZ8ygYsjrG5ZBevzruw65oUKf1bV
        fvEve6By6ZV82h2uxvcv3p/acFKqULSuvV2rSc4t+JSZ11v2kr3285jzbngs8T/LO5P57QO1
        SRXdGteUt9z8cq2m9+dy5fPcflxv5hWmT110O971BUuMw4cFK8VbLVeVfdHu+jjDaa5A3bpz
        X6wOdk7WVGIpzkg01GIuKk4EAON6C/nQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xe7qnxf+nGExoMrR4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB6l
        Z1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7GwZwNT
        wXO2ive//zE3MF5l7WLk5JAQMJE40b0AyObiEBJYyihxdN9iNoiEtMThL1PYIWxhiT/Xutgg
        ipqZJF79ng5WxCZgIPHgzTJ2kISIQCejRNfmc0wgCWaBW8wS919rgdjCAgESH/+cAIuzCKhK
        /Li6jRHE5hWwkdh9+jsjxAZ5iee37oBt4xSwlTi7djqQzQG0zUai/4wORLmgxMmZT1ggxstL
        NG+dzTyBUWAWktQsJKkFjEyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAmNu27GfW3Ywrnz1
        Ue8QIxMH4yFGCQ5mJRHekkN/U4R4UxIrq1KL8uOLSnNSiw8xmgKdPZFZSjQ5Hxj1eSXxhmYG
        poYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTPUv/z58stHox8RtZpb72ts+
        7l9ysbVx0p/KyeLieX9v/8iN6FSZr+qR6faEYcaN0/EX1NLuZZ9bsG+agXDvxWPPFDh2Jl0v
        mXGX07J2quzlywJJrLvuSy2/YryRpe/xIp1j66TcHZsNvX/2p5yZ2cz4tvLpj9uXdh2WXm98
        T3o/84TZ066+XC22e9ayYib+7RUhThdXpLa+zlVKdNx1aedJTv6U36c+Wdzdq2d2yE1l9rGL
        p71eG17fonugfPLJxM6z0/3j2eW6Lu+8ev5fQPmmML6olts2UtHfuZQja81+S1l/PNY4Xzb4
        vRtH3VH2+40bb33lyywQDDgsoLXdzliEu5fRqftxZMea9mki34SUWIozEg21mIuKEwF+XEuT
        QgMAAA==
X-CMS-MailID: 20230911133611eucas1p286e43809a6ca785911c0bbdce15dc15d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230911133611eucas1p286e43809a6ca785911c0bbdce15dc15d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230911133611eucas1p286e43809a6ca785911c0bbdce15dc15d
References: <20230911133435.14061-1-m.majewski2@samsung.com>
        <CGME20230911133611eucas1p286e43809a6ca785911c0bbdce15dc15d@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the field has been removed in one of the previous commits,
but the description has been forgotten.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index e5bc2c82010f..2c1cfb8c4b33 100644
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
2.41.0


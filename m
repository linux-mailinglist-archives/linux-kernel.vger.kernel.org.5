Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C7E79B2B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353829AbjIKVvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbjIKNgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:36:15 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D364125
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:36:09 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230911133608euoutp02e975228b000c9216a49aedc5d0e56d7b~D26DJZnMP1313113131euoutp02Z
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:36:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230911133608euoutp02e975228b000c9216a49aedc5d0e56d7b~D26DJZnMP1313113131euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694439368;
        bh=HFblmEq6Wu63c4OaZSLSXquWsoLJXCWOSNsbX81BJqU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=bzm47R6b9wZSa9afhKxFaoh2ILCa7onNY9B/wIhJvkLQ2ZxS3iLdHdM1zJoAVyRJI
         7l8EzPZjwQiapaHmH2T8x9014wma/nT/Sp13KxjXBmPQ2K1jawDc47QtjAwLzYb+cj
         lZJM2J6xhUIZwfZrEzetntj2oySX/zCiqpbT75zI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230911133608eucas1p28cfd68d14697b278271c55eedaddd34f~D26Cx_Fel1713017130eucas1p21;
        Mon, 11 Sep 2023 13:36:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 16.03.37758.7C71FF46; Mon, 11
        Sep 2023 14:36:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230911133607eucas1p2c9a5b6c3bd785a5d03d78a1db872b188~D26CbkvI_0333903339eucas1p2_;
        Mon, 11 Sep 2023 13:36:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230911133607eusmtrp21ce60ea977e1c47b41aedb48e3f37fe3~D26CZ3LD70862108621eusmtrp2M;
        Mon, 11 Sep 2023 13:36:07 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-48-64ff17c79574
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 67.7A.14344.7C71FF46; Mon, 11
        Sep 2023 14:36:07 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230911133606eusmtip22d0161ac2c9c2e907977814529c6feb2~D26BjiyJQ0797807978eusmtip2a;
        Mon, 11 Sep 2023 13:36:06 +0000 (GMT)
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
Subject: [PATCH v2 0/7] Improve Exynos thermal driver
Date:   Mon, 11 Sep 2023 15:34:24 +0200
Message-ID: <20230911133435.14061-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djPc7rHxf+nGKxYYmPxYN42NovD8yss
        pj58wmbxfct1Jot5n2Ut9r7eym7x7UoHk8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCwmHpvMbLH2
        yF12i7lfpjJbPHnYx+bA77Fz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9+rasYvT4vEkugD2K
        yyYlNSezLLVI3y6BK+Pf0gmsBUe5Ks48e83WwHiSo4uRk0NCwETiTOMS5i5GLg4hgRWMEodf
        n2KDcL4wSqxbcJ0RwvnMKNHxeQE7TMuyjUtZIRLLGSVeLrrMBOG0Mkns/XuHCaSKTcBA4sGb
        ZWAdIgKtjBIzm9RBipgFLjFL3L25lgUkISxgKvH/+SIwm0VAVeLw3KtADRwcvAI2Eu9bjSG2
        yUs8v3UHbA6vgKDEyZlPwMqZgeLNW2czQ9S84JB4s7cewnaRWLZ4GxuELSzx6vgWqKtlJP7v
        nM8EYedLzNj8ngVklYRAhcTdg14QprXExzPMICazgKbE+l36EFFHiZuvDSBMPokbbwUh1vNJ
        TNo2nRkizCvR0SYEMVlV4vieSVBXSUs8abkNtdFDYvG9E6wgtpBArMSdtc+YJjAqzELy1Cwk
        T81COGEBI/MqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwAR2+t/xrzsYV7z6qHeIkYmD
        8RCjBAezkghvyaG/KUK8KYmVValF+fFFpTmpxYcYpTlYlMR5tW1PJgsJpCeWpGanphakFsFk
        mTg4pRqYHDPnrgxedqFT5JvaKvbL3JI1cpft3j7Vyg5oyKxL4os6ZWpT5+T9rfothyTDo6Zf
        ol7FHm8ELpS0SHks7/qQ6+hu2XQwUjOkeWr3hNv1SxX+J+2X6Vw2cdJ7nRCtzZOmhTtZS6x3
        +rFpjYRmd8PZpapKTNcN8nJj/JltA2LEOprXPb33zVvg7vkal5vhn773nTBSXXvx1VHXUzdt
        fD8zV/4WTvFLfsOVPo9JjPPMZpP9deo9n6b/LZRNU73gcvBYl7Jmol7YeoMwPjnmvxvv95bF
        1Wk/WuOumbdUqMvq5JUpSz5fco03yAldqmcpv3Kp1ttcJgORF4qlZ7juz3jh6zBzEpv70sVz
        5YOyeZRYijMSDbWYi4oTAW9SLxvPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7rHxf+nGJyfq2TxYN42NovD8yss
        pj58wmbxfct1Jot5n2Ut9r7eym7x7UoHk8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCwmHpvMbLH2
        yF12i7lfpjJbPHnYx+bA77Fz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9+rasYvT4vEkugD1K
        z6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+Pf0gms
        BUe5Ks48e83WwHiSo4uRk0NCwERi2calrF2MXBxCAksZJZbP3MkKkZCWOPxlCjuELSzx51oX
        G0RRM5PErV/vwBJsAgYSD94sYwdJiAh0Mkp0bT7HBJJgFrjFLHH/tRaILSxgKvH/+SIWEJtF
        QFXi8NyrQA0cHLwCNhLvW40hFshLPL91B2wmr4CgxMmZT1ggxshLNG+dzTyBkW8WktQsJKkF
        jEyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAmNo27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHe
        kkN/U4R4UxIrq1KL8uOLSnNSiw8xmgKdN5FZSjQ5HxjFeSXxhmYGpoYmZpYGppZmxkrivJ4F
        HYlCAumJJanZqakFqUUwfUwcnFINTL3fUq7M3PyefcIHadW55udmvhZ0uhYrEnT2jPlx25ii
        r3UK29/fZdpu47LJNv4VB3fbi61zxCIWVIT2B9bH3O0Wl7J7lf5VWC1m+cJVPz8/jdzg/PJi
        X9OJ6LTLR3ze7XOqij6o+uxctJHEKqtpM+4dOvv+ofnfU2Hyv1JijM3ZWSYunfCTlzP4tGJg
        6aoG87ao/8+W73RvLXkgopLtwHF4xZltSbnLIqtvzsvztJZTclx82n/LntiiWmvVxx99/dLF
        A1NPhDhIHs4S4Nv9RWv9ghcqamKyfqs+PKhbq/uu9cRKbq6un31pF/cutt9XoM0/d2uPxmxz
        uz+T89tYZ61X9tgcUX6JVU1lj6DbUiWW4oxEQy3mouJEAEeqre0qAwAA
X-CMS-MailID: 20230911133607eucas1p2c9a5b6c3bd785a5d03d78a1db872b188
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230911133607eucas1p2c9a5b6c3bd785a5d03d78a1db872b188
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230911133607eucas1p2c9a5b6c3bd785a5d03d78a1db872b188
References: <CGME20230911133607eucas1p2c9a5b6c3bd785a5d03d78a1db872b188@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This work improves Exynos thermal driver in various ways. This is
related to the discussion in
https://lore.kernel.org/all/97201878-3bb8-eac5-7fac-a690322ac43a@linaro.org/

The primary issue being fixed is a lockdep warning, which is fixed by
the thermal: exynos: use set_trips patch. We also simplify the code in
general.

Changelog:
 v2:
   - Added missing field descriptions
   - Removed an unnecessary field description
   - Removed the commits that made clock management more fine-grained
     (need more discussion), and adapted the new code to manage clocks
   - Removed the devicetree changes (will be uploaded separately),
     changing the recipient list accordingly
   - Improved formatting of the devm_request_threaded_irq call

Mateusz Majewski (7):
  thermal: exynos: remove an unnecessary field description
  thermal: exynos: drop id field
  thermal: exynos: switch from workqueue-driven interrupt handling to
    threaded interrupts
  thermal: exynos: simplify regulator (de)initialization
  thermal: exynos: stop using the threshold mechanism on Exynos 4210
  thermal: exynos: split initialization of TMU and the thermal zone
  thermal: exynos: use set_trips

 drivers/thermal/samsung/exynos_tmu.c | 525 ++++++++++++++-------------
 1 file changed, 272 insertions(+), 253 deletions(-)

-- 
2.41.0


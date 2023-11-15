Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F363B7EC01C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbjKOJ7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbjKOJ7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:59:07 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6968418C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:59:02 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231115095857epoutp01a9cdf1f28a558ccb1a263ee4e9bd93d3~Xw3_gP3V40881408814epoutp01T
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:58:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231115095857epoutp01a9cdf1f28a558ccb1a263ee4e9bd93d3~Xw3_gP3V40881408814epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700042337;
        bh=MS6MQATSZ5rMpjsvJnEbBnGdl95WFAKGgIRzQg/GCRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HmAEmgqZ4T4XCQMPbv/COWXASUMgKzO/9Svw25ORPNl6OEdCOn8hh7QsaQaVkUACi
         nTHAhG2FZfbKFIdql1jFceJlyXYQh+3PlBF3p5Thya8wlYVF5geVgGic0UzZQlr6/a
         QN2hzTNieNANUlL6Ek0+iBjhTtxfNyEoeURGkgEQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231115095856epcas2p2454612f1c6908d838b32d6cc24c53137~Xw3_EHMFB1189111891epcas2p2u;
        Wed, 15 Nov 2023 09:58:56 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SVdsr1ljCz4x9Q1; Wed, 15 Nov
        2023 09:58:56 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.46.10006.06694556; Wed, 15 Nov 2023 18:58:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231115095855epcas2p3fe5776db0e15e0427cbe2bd2382644c2~Xw39ELr4w1497814978epcas2p3B;
        Wed, 15 Nov 2023 09:58:55 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231115095855epsmtrp2fd5fb077f4b2dd3486f2e9caa9fa02c2~Xw39Chr0H2554225542epsmtrp2f;
        Wed, 15 Nov 2023 09:58:55 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-fc-65549660216c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.81.08817.F5694556; Wed, 15 Nov 2023 18:58:55 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231115095855epsmtip2d68054b42f963ffc029117aa1331aa66~Xw38l_V9N2498224982epsmtip2R;
        Wed, 15 Nov 2023 09:58:55 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v2 09/12] soc: samsung: exynos-chipid: add exynosautov920
 SoC support
Date:   Wed, 15 Nov 2023 18:56:05 +0900
Message-ID: <20231115095609.39883-10-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115095609.39883-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xTVxTOfa99fUXLnuD0piPSPN0S2YC2K+VJqBlMXBOZIWBmZrJAbd8o
        FNqmPxarf8jCCkjYGDAVyk+tAa0kkOKPDqg6aGQwhnGyLo7VQpgICA6mKxMhW+mrm/9959zv
        nO98596Lo1HjGB8v0Jpog1ZRRGIRrGuDu6n4vDOHaOH1GZyabLmGUZ3uMYRq9YyxqVJ7F0a5
        Sjxs6klzDOV+fJVDfbPWgVDOaS+b6mldA9S93iaM8vkcgKq/cwOhRu1fciir28OhBhfK2dTz
        3hYW5egN8iZq6sB70fJvbT6O3Ok4hcl/8/Zj8pvNnRx5z4WT8up1ofyrKw4gf+rckYUf0aSq
        aYWKNghorVKnKtDmy8gDObnv5yZJhaJ40R4qmRRoFcW0jNyXmRW/v6AoaIcUfKYoMgdTWQqj
        kUzcm2rQmU20QK0zmmQkrVcV6ZP1CUZFsdGszU/Q0qYUkVAoTgoS8zRq99kRTO9lHwtUnUNL
        wCNWJeDikJDAPy71IZUgAo8iXACOfNcdDv4EsG2ql8MEAQBnv7+MvSzx/HweZQ7cADrbJzAm
        WAZwsmc+xMKIt+FKl529gbcSfhQ+LjuxQUKJcgS2BOZC6tHEYeh9OAw2MIt4E3Y/awwV84i9
        8PbiQ5SRi4X951eCQ+E4N5i33oljKFvgcMPvoTZokFJ6tTE0ESTGcThq9YXd7YPrf9s4DI6G
        80NXwpgPnz5xh+1oYPnZNTaDj8G73Y3h/LvQNlMONnRRYjfs6k3cgJDYCT2/hmUjYcXgOodJ
        82BFWRRT+Bb0nx4LN4mBtZ5LCIPlcG75BYtZVQ2Az13L6NdAYHvFje0VN7b/hdsA6gDbaL2x
        OJ82ivWi/25YqSt2gtDzjstwgbrFpYQBgOBgAEAcJbfyknccoqN4KoXlOG3Q5RrMRbRxACQF
        V12D8l9X6oL/Q2vKFUn2CCVSqShZnCRMJrfzHlibVVFEvsJEa2haTxte1iE4l1+CaP6aN4uX
        EjOaq259OHkxtra2VSI92mNt/2XpQuWjTT/96IkBvHNI3InqizsfcLsix0/H6pXDNUPt5Wmv
        TaXsyh5RjgSEZsHhVllhwFed5cAPVlt4qZ+vH5HdHj6+f8vymfT0+mj0pqW0QeUMDC3Ezqqq
        YjJt//yQWTd5/6OyD5oPxvs5hXc/HYVa6Vzax/4vxNzt3ffTM26sODqyV3dxGvodKS9wV8di
        vqyp752cNv7JacvlVS+pTLXXFx/YFjnRWVL9Rvb1mTTJ9MJiZATRZPF4Cx2rt+am7M/61AOz
        McTRT8r6N/tbqu4NJlS1WzaP5lUqCX8OemrVl1PhqR3ZRLKMaoUoDjUYFf8CHoXpDGcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXjd+WkiqQedMZYsH87axWazZe47J
        Yv6Rc6wWzYvXs1nsaDjCavFurozF3tdb2S2m/FnOZLHp8TVWi83z/zBaXN41h83i7t1VjBYz
        zu9jsjizuJfdonXvEXaLw2/aWS1+7prHYrFqF1Dd7YmTGR2EPXbOusvusWlVJ5vHnWt72Dz2
        z13D7rF5Sb1H/18Dj74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4MrYO/0UW8E11opvPQuZGxif
        s3QxcnJICJhIHLm6iLmLkYtDSGA3o8SvngWsEAkZieXP+tggbGGJ+y1HWCGK3jNKdBx9BpZg
        E9CW+L5+MVhCROA5s8TZP4+YQRLMAv1MEtc3JYDYwgKhEp3/VjKC2CwCqhIbvswGa+YVsJM4
        9vYpM8QGeYk9i74zdTFycHACxVvPa4GEhQRsJVp3/2CGKBeUODnzCQvEeHmJ5q2zmScwCsxC
        kpqFJLWAkWkVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwnGlp7WDcs+qD3iFGJg7G
        Q4wSHMxKIrzmciGpQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgsky
        cXBKNTDF7m/2+LFo9skdGQxcV1ed1TjyeLrCDK1VovnaEcUh4pkLjENem/o7TWwt1Hrnk3Jy
        6/9tFQnZfD3PK7iCX4Zlxice0Fv/8c+fRSWx66Nrg3aEVR2YGeMcu2UC76v9vFOKdU+Zbkz/
        FD/n2v03HlVBVy7cW16gwTCd6folA94avoJ8lu/+j6Iq9zdMuT5N4v3Oypbqe3UnfkfPZIva
        xK1b7inkMkOSbfalh99naru/WnGcSWzrtoYOBtf5p7tbL27NvJuy96pc9K0tVYYLAj7OvxNa
        NZv7/IfYev7oGdNeO16UfS29oGqFzNKO+UHB19/9qiw3PbhWoq9R9aH3GtkVW07tfR9ptO6Q
        aeKRvpJ7SizFGYmGWsxFxYkARA2+DSIDAAA=
X-CMS-MailID: 20231115095855epcas2p3fe5776db0e15e0427cbe2bd2382644c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231115095855epcas2p3fe5776db0e15e0427cbe2bd2382644c2
References: <20231115095609.39883-1-jaewon02.kim@samsung.com>
        <CGME20231115095855epcas2p3fe5776db0e15e0427cbe2bd2382644c2@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EXYNOSAUTOV920 information to soc_ids tables. This SoC product id
is "0x0A920000".

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/soc/samsung/exynos-chipid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 3fd0f2b84dd3..b1118d37779e 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -59,6 +59,7 @@ static const struct exynos_soc_id {
 	{ "EXYNOS7885", 0xE7885000 },
 	{ "EXYNOS850", 0xE3830000 },
 	{ "EXYNOSAUTOV9", 0xAAA80000 },
+	{ "EXYNOSAUTOV920", 0x0A920000 },
 };
 
 static const char *product_id_to_soc_id(unsigned int product_id)
-- 
2.42.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127E378C149
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjH2JYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbjH2JYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:24:20 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A78CD3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:24:07 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230829092404euoutp010acb86e06efb19d182ff391a37cbeb87~-0FQH1Np71651116511euoutp01v
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:24:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230829092404euoutp010acb86e06efb19d182ff391a37cbeb87~-0FQH1Np71651116511euoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693301044;
        bh=n03v4YwoYhaEaYsHnGtQUOfGHMiBSqQF5cOtLoFjMKQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=u9LAXqasudmzcJJpHhTN3nIBt2YXRCpb+SEtp79qz5wJwxhMOiT8TaOgdlSEstl3n
         S1BDP+BOkgUMsy+zoLFofKK5zZ2/0VKOOEg2epje+a3qWoIDMkCeTwsWTq8pnYd8r4
         2efpVCtnPoFs64LAmT58PbU6upRZnQrA1/rrjHLU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230829092403eucas1p279c00a8c66918c6f72e9f067ac9ac732~-0FPvKP0D2175521755eucas1p2-;
        Tue, 29 Aug 2023 09:24:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7A.17.11320.339BDE46; Tue, 29
        Aug 2023 10:24:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230829092403eucas1p17048226c987315610cf49c7c6eab2148~-0FPVonT41584115841eucas1p16;
        Tue, 29 Aug 2023 09:24:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230829092403eusmtrp10373b00b6be0c0090dc665198e4a5533~-0FPUyS_t3248032480eusmtrp1N;
        Tue, 29 Aug 2023 09:24:03 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-e8-64edb9333598
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D4.D9.10549.339BDE46; Tue, 29
        Aug 2023 10:24:03 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230829092402eusmtip2363834dd9fd50ef4e351b456a239a76e~-0FOZFnTA1173411734eusmtip2X;
        Tue, 29 Aug 2023 09:24:02 +0000 (GMT)
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
Subject: [PATCH 00/11] Improve Exynos thermal driver
Date:   Tue, 29 Aug 2023 11:18:38 +0200
Message-ID: <20230829091853.626011-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djPc7rGO9+mGGxZpmvxYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJWxaf1KpoIrXBXb3z5nb2B8xNHFyMkhIWAi
        8bnhHnMXIxeHkMAKRonju7awQThfGCWebZvFBFIlJPCZUaJ7SRBMx/WGN4wQRcsZJV6+XcYE
        4bQySTy/uZgZpIpNwEDiwZtl7CAJEYHFjBJbd84Cq2IWmMsi0bDyJ0sXIweHMNCsSwcZQRpY
        BFQl/vY1soPYvAK2EpOnH2CHWCcv8fzWHai4oMTJmU9YQGxmoHjz1tnMEDX/OSTuPiyAsF0k
        /t25xQJhC0u8Or4Fao6MxOnJPVDxfIkZm9+DnSAhUCFx96AXhGkt8fEMM4jJLKApsX6XPkTU
        UWL/DR4Ik0/ixltBiPV8EpO2TWeGCPNKdLQJQUxWlTi+ZxLUVdIST1puM0HYHhIvN7awQwIz
        VuLSg03sExgVZiF5ahaSp2YhnLCAkXkVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYHo7
        /e/4lx2My1991DvEyMTBeIhRgoNZSYT3kuOrFCHelMTKqtSi/Pii0pzU4kOM0hwsSuK82rYn
        k4UE0hNLUrNTUwtSi2CyTBycUg1MQXUBEvrSVSItOe5C7it4j2evb/N7G2Ql+N93a+j2MK3j
        Wj/uf5mVuS3ES+Nz9e/FZzPXuPzpvBVRou+0WbuhvXnf6kJZozkMc6MZ+wI1rk/6vz5soci2
        DwJFH0VUd3tbfKs7I7s15+h/zdbP81JkOA3NL2hrPdxc1Tv35RrLU0d4js9ZKx3fV7To6tYd
        FUwnrt3hnM6y5dq/MoVVd1OWbT2x18Fj2sojx8JnFDIozVSxZ/3CrH1G66b6Hll3TcXgUrF1
        r60XzGbodvTb/7Ly47PD1/Vquizlf6zsqDI77nzKsO6ah+O6/T8dH1/JLDoRcHu+dvTjO/7J
        MX5vRTTWsiezneZO9WrwWbKvmENbiaU4I9FQi7moOBEA8Vcw3N4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7rGO9+mGOx5LWzxYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLb5d6WCy2PT4GqvF5V1z2Cw+9x5htJhx
        fh+TxcRjk5kt1h65y24x98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
        kpqTWZZapG+XoJexaf1KpoIrXBXb3z5nb2B8xNHFyMkhIWAicb3hDSOILSSwlFHi3xlRiLi0
        xOEvU9ghbGGJP9e62LoYuYBqmpkkDrQfAkuwCRhIPHizjB0kISKwnFHi6r3lLCAOs8ByFonn
        az4wdzFycAgDrbh0EGwDi4CqxN++RrBmXgFbicnTD0BtkJd4fusOVFxQ4uTMJywgNjNQvHnr
        bOYJjHyzkKRmIUktYGRaxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERhh24793LyDcd6rj3qH
        GJk4GA8xSnAwK4nwXnJ8lSLEm5JYWZValB9fVJqTWnyI0RTovonMUqLJ+cAYzyuJNzQzMDU0
        MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYDqRF9TwsH6dns5cidXdk+RfFX0T
        qb7HoMpbcUyE88fxY1/vfj1xU/Ovh9XJxQc02PqMDv+5o6bhtXTxjD2Pd96att/LvT1Oi7NB
        4IZqWJSh2gQzhh02eSLcC86qrJyq/KKM7bCQ8PyQid8ljiwwfFe55Xvz1g/ddx4dKb5RYMoY
        1aR60ZI708a6eubNGzePWxSJP0iR8Lr4XlfB+RPPiem7LSMOcRtfb99WES04Oeh/xfWSJ/f7
        rI5cnXb017fMB/tncMtaOXQt8HP/tv70dscTTqrThQUVjhXlp2sfZV64/u+LFvbvuULMAkFx
        uZNqDtx/yzh/p1xL2Y/zX89uXW+tWv6X80z64j+O1SG5dVOUWIozEg21mIuKEwFO+UzwOQMA
        AA==
X-CMS-MailID: 20230829092403eucas1p17048226c987315610cf49c7c6eab2148
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230829092403eucas1p17048226c987315610cf49c7c6eab2148
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230829092403eucas1p17048226c987315610cf49c7c6eab2148
References: <CGME20230829092403eucas1p17048226c987315610cf49c7c6eab2148@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This work improves Exynos thermal driver in various ways. This is
related to the discussion in
https://lore.kernel.org/all/97201878-3bb8-eac5-7fac-a690322ac43a@linaro.org/

The primary issue being fixed is a lockdep warning, which is fixed by
the thermal: exynos: use set_trips patch. We also handle Exynos 4210 not
supporting falling temperature thresholds by enabling polling for this
SoC, and simplify the code in general.

Mateusz Majewski (11):
  ARM: dts: exynos: enable polling in Exynos 4210
  thermal: exynos: drop id field
  thermal: exynos: switch from workqueue-driven interrupt handling to
    threaded interrupts
  thermal: exynos: remove fine-grained clk management
  thermal: exynos: simplify sclk (de)initialization
  thermal: exynos: simplify regulator (de)initialization
  thermal: exynos: simplify clk_sec (de)initialization
  thermal: exynos: stop using the threshold mechanism on Exynos 4210
  thermal: exynos: split initialization of TMU and the thermal zone
  thermal: exynos: use set_trips
  ARM: dts: exynos: disable polling in Odroid XU3-related devices

 arch/arm/boot/dts/samsung/exynos4210.dtsi     |  10 +-
 .../samsung/exynos5422-odroidxu3-common.dtsi  |  16 +-
 drivers/thermal/samsung/exynos_tmu.c          | 581 ++++++++----------
 3 files changed, 284 insertions(+), 323 deletions(-)

-- 
2.41.0


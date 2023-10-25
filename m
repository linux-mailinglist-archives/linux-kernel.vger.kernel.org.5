Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4A77D6D36
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbjJYNaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbjJYNau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:30:50 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8EA196
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:30:46 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231025133044euoutp0228968c7302f0213ba2e198e41eeea98f~RXN5XhKZ00940909409euoutp02h
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:30:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231025133044euoutp0228968c7302f0213ba2e198e41eeea98f~RXN5XhKZ00940909409euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698240644;
        bh=ibVd67MhuJloPyDSlMXVA5muSOdLvO6BJNdQITVskso=;
        h=From:To:Cc:Subject:Date:References:From;
        b=U/5NDoYBPBvjeG+vEVjUpWq+TzxO9em5cTtgxtRlC3AEuJ1F8mSxKwb31anxYtafe
         FJRb/dPAJgV+vRvah5dMPKKVxyu056ITqlthB5SrcbCiakKvGoQzlHgN7APD/6VDQ2
         G5rGOnWwX0gh7quKAkEiM9Q8RJxpk77KCRwjmGNI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231025133043eucas1p10a5105509c5d9cd6d8b69c450ada4e19~RXN43JiZV1384713847eucas1p1q;
        Wed, 25 Oct 2023 13:30:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AC.FA.37758.38819356; Wed, 25
        Oct 2023 14:30:43 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231025133043eucas1p2f882c015c25c185fb4c1cd5b3d3027e8~RXN4f4fT32484324843eucas1p2i;
        Wed, 25 Oct 2023 13:30:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231025133043eusmtrp29e8030e7eda883dff8fbeaf923be0dc5~RXN4fDYmz1205012050eusmtrp2O;
        Wed, 25 Oct 2023 13:30:43 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-30-65391883cc28
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4F.16.25043.38819356; Wed, 25
        Oct 2023 14:30:43 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231025133042eusmtip2f6fa52d2aaced22b53df598125682045~RXN3ps4lA1378813788eusmtip2q;
        Wed, 25 Oct 2023 13:30:42 +0000 (GMT)
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
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v4 0/8] Improve Exynos thermal driver
Date:   Wed, 25 Oct 2023 15:30:19 +0200
Message-ID: <20231025133027.524152-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djPc7rNEpapBl0HzS0ezNvGZnF4foXF
        1IdP2Cy+b7nOZDHvs6zF3tdb2S2+Xelgstj0+BqrxeVdc9gsPvceYbSYcX4fk8XCphZ2i4nH
        JjNbrD1yl91i7pepzBZPHvaxOQh4rJm3htFj56y77B6L97xk8ti0qpPN4861PWwem5fUe/Rt
        WcXo8XmTXABHFJdNSmpOZllqkb5dAlfG9ykLmAu28Va8WfSQtYHxGVcXIyeHhICJxI9Lt9lA
        bCGBFYwSB9/UdzFyAdlfGCW+fFnJDuF8ZpS4+GUiC0zHyYbNTBCJ5YwSjW+2s0A4rUwSy/o/
        sIJUsQkYSDx4s4wdxBYRaGWUmNmkDlLELPCVWeLq6/nMIAlhAVOJpr9NYDaLgKrEn8eXwJp5
        BWwl5jReh1onL7Fn0XcmiLigxMmZT8DizEDx5q2zmUGGSgh84ZD4vO0JK0SDi8SzVS3MELaw
        xKvjW9ghbBmJ/zvnM0HY+RIzNr8HGsQBZFdI3D3oBWFaS3w8wwxiMgtoSqzfpQ8RdZT4vsQK
        wuSTuPFWEGI/n8SkbdOZIcK8Eh1tQhCTVSWO75kEtV1a4knLbaiNHhL9Hceh4RwrMfXsRJYJ
        jAqzkHw1C8lXsxBOWMDIvIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwrZ3+d/zrDsYV
        rz7qHWJk4mA8xCjBwawkwhvpY5EqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc1RT5VSCA9sSQ1
        OzW1ILUIJsvEwSnVwNRrkqfh/9ns5/MLUoIu+yOyZ8vxJ6cenqQhtcl8rnMp35Yajqy9GY/e
        r86fsTKOX/DXa49nUzbMbRB++rz6yZr3Papvaia90FnRH8YzwWZF3gN321UXvP4tXauZMjsw
        WPgh0z+PlTkqvCdtrnjPLt6uPvX579YL/YtfCPLL3BQQtVA6YbKZ7fAnn3rJDXyXcg43nbxY
        +b9y58nCyAk6EZd12/vrq7gsDq2XKu/5z7Zoo7hZ7Lvz1644zXBffEQvU+/46n7pN4wXAv09
        5O86Pzz2UX+r7bmKgLgQ4Uu7TIU8Nj5rETjA5uMYNEXl+wXv3ZZn6qbYp0QdM3v6uTDZ4NqS
        8zuVN1td8mXKLpOqtlRiKc5INNRiLipOBAD8H1Mz2gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7rNEpapBnuWy1s8mLeNzeLw/AqL
        qQ+fsFl833KdyWLeZ1mLva+3slt8u9LBZLHp8TVWi8u75rBZfO49wmgx4/w+JouFTS3sFhOP
        TWa2WHvkLrvF3C9TmS2ePOxjcxDwWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p9+jb
        sorR4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLU
        In27BL2M71MWMBds4614s+ghawPjM64uRk4OCQETiZMNm5m6GLk4hASWMkrcOzCHGSIhLXH4
        yxR2CFtY4s+1LjaIomYmiV0nesASbAIGEg/eLGMHSYgIdDJKdG0+xwSSYBb4zyzxdaYCiC0s
        YCrR9LcJbCqLgKrEn8eXWEFsXgFbiTmN11kgNshL7Fn0nQkiLihxcuYTFog58hLNW2czT2Dk
        m4UkNQtJagEj0ypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAyNp27OeWHYwrX33UO8TIxMF4
        iFGCg1lJhDfSxyJViDclsbIqtSg/vqg0J7X4EKMp0H0TmaVEk/OBsZ1XEm9oZmBqaGJmaWBq
        aWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cBUHjrzl+LHZ7sPt/QefHvi2V/G6e6nPRIt
        52rJZzSkH1A6c8z5275tZUuZJNeKr3ibOX1d9A/Gm1kvj1bb38q+J96i256z4W96W/1+rzyj
        8JsdK3tq5KebvVkp/1JxfkuIuuv1sH2nk+8lRD7cWnD4lc05kZ55O0wijjayrV7w7oDSY2/9
        YKertU+dQnXKH5y7eD3y4CSWc8y+szJ3PpOVbD6hcvZ8/LylF9yvvwhKOb8oqtVk6ZYtgtHX
        uWZZr6l6aFl7Q4idkfkEy8SPK1S/Jub17Wa8U6r0batccNC2K67yMfWWnk/3TP3/jm8J87G7
        4uIaR1Y/lvlzl/2r7Ys/G8Xulfk2GXlseMO7w/h6iBJLcUaioRZzUXEiAFGMcfc1AwAA
X-CMS-MailID: 20231025133043eucas1p2f882c015c25c185fb4c1cd5b3d3027e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231025133043eucas1p2f882c015c25c185fb4c1cd5b3d3027e8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231025133043eucas1p2f882c015c25c185fb4c1cd5b3d3027e8
References: <CGME20231025133043eucas1p2f882c015c25c185fb4c1cd5b3d3027e8@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 v4:
   - Resolved merge conflict when applying thermal: exynos: split
     initialization of TMU and the thermal zone
   - Reordered calls done when leaving exynos_tmu_initialize for
     symmetry
 v3:
   - Fixed regulator initialization
   - Fixed formatting of some comments
 v2:
   - Added missing field descriptions
   - Removed an unnecessary field description
   - Removed the commits that made clock management more fine-grained
     (need more discussion), and adapted the new code to manage clocks
   - Removed the devicetree changes (will be uploaded separately),
     changing the recipient list accordingly
   - Improved formatting of the devm_request_threaded_irq call

Mateusz Majewski (8):
  thermal: exynos: remove an unnecessary field description
  thermal: exynos: drop id field
  thermal: exynos: switch from workqueue-driven interrupt handling to
    threaded interrupts
  thermal: exynos: handle devm_regulator_get_optional return value
    correctly
  thermal: exynos: simplify regulator (de)initialization
  thermal: exynos: stop using the threshold mechanism on Exynos 4210
  thermal: exynos: split initialization of TMU and the thermal zone
  thermal: exynos: use set_trips

 drivers/thermal/samsung/exynos_tmu.c | 538 ++++++++++++++-------------
 1 file changed, 283 insertions(+), 255 deletions(-)

-- 
2.42.0


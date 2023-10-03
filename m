Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFE17B6799
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbjJCLRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjJCLRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:17:12 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9559A7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:17:06 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231003111705euoutp0135411f8a89e4d275fa043b76f114559f~KlM6yzh-H1141711417euoutp01o
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:17:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231003111705euoutp0135411f8a89e4d275fa043b76f114559f~KlM6yzh-H1141711417euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696331825;
        bh=ZhBY96cBP6gAaiohQ/UMT7LgySEcdy7SO3w5LIRu/1Q=;
        h=From:To:Cc:Subject:Date:References:From;
        b=H4bGR/n97o3CVb5O6mtY1uf8rE1BizUNgWCYwyRNs0fPPs0QxVneA3HW9shV81P+T
         rCb5wUvDhMs+liYSkYhJk6F1lDulCdeP+EieM1R7h7Z8UtKBaQhLI5gOaprOSWrKPX
         NXwOkMAFUsjHcxIvf2eRL9BgIb2aQb4l5k6nd7rg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231003111704eucas1p28ab24b3e2430da1bb40756fde9c5862b~KlM6S_aed2873528735eucas1p2l;
        Tue,  3 Oct 2023 11:17:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 47.F7.42423.038FB156; Tue,  3
        Oct 2023 12:17:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231003111703eucas1p271e5b007be186b73639f3b958e2544f8~KlM5uZ58G2873528735eucas1p2j;
        Tue,  3 Oct 2023 11:17:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231003111703eusmtrp181ebbcabe450e5587ef0adc9ac13ca83~KlM5qDw7m2246422464eusmtrp1O;
        Tue,  3 Oct 2023 11:17:03 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-b2-651bf8308760
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 77.CE.25043.F28FB156; Tue,  3
        Oct 2023 12:17:03 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231003111703eusmtip232904fb217ea4b7dbd4badffe018cc8c~KlM44gcpm2901629016eusmtip2V;
        Tue,  3 Oct 2023 11:17:03 +0000 (GMT)
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
Subject: [PATCH v3 0/8] Improve Exynos thermal driver
Date:   Tue,  3 Oct 2023 13:16:26 +0200
Message-ID: <20231003111638.241542-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djP87oGP6RTDdZskrV4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB7F
        ZZOSmpNZllqkb5fAlbHz5mXGgtfcFXfefmJqYDzN2cXIySEhYCJx/OFf1i5GLg4hgRWMEhs+
        nmWEcL4wSmw5s5cFwvnMKHFm61MmmJat+3ayQySWM0qsenuSCcJpZZJ4sOcnI0gVm4CBxIM3
        y9hBbBGBVkaJmU3qIEXMApeYJe7eXMsCkhAWMJX4OPs62FgWAVWJHS8ngDXwCthKdHV3MkOs
        k5fYs+g7E0RcUOLkzCdgvcxA8eats5lBhkoIPOGQ+LnnKtAbHECOi0TfO26IXmGJV8e3sEPY
        MhKnJ/ewQNj5EjM2v2eBKK+QuHvQC8K0lvh4hhnEZBbQlFi/Sx+i2FHi85EJjBAVfBI33gpC
        7OeTmLRtOjNEmFeio00IolpV4vieSVCnS0s8abkNDTUPiT+fesAuFBKIlXizzWECo8IsJE/N
        QvLULIQTFjAyr2IUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMYaf/Hf+0g3Huq496hxiZ
        OBgPMUpwMCuJ8IYdlUoV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzqttezJZSCA9sSQ1OzW1ILUI
        JsvEwSnVwKTUJXL/+zrVNdfLj56b/kh2Wtnkda8+MU39xbLX7oHA2okzTvz+lfmb4ddjzudl
        T/ZzhS4U1XMoqlHR4u59cEj5wNf5BbMufbRl3yHj6v1tL+sv3bPP7mtuOcOROfGX6INA1dQK
        5Ydmmt3x5y96Gt6zePIgrVqlYnrXPOtP3ae+/b//8/uWWw/UT25h/SN98V+xbkP7pLkp0/7f
        0Hk83aR2R/6M06pLJ6rdvcgfe+jRa/YMk/OLdj+bOctVRS8jL1ckIT7s84oFjdozvBmjXrfs
        SpoqXqB0lH+K5J20qG1PChZZuFTotfcslrvw7Fb1u9+qEheOOXJLzLT2jbXQyuD9Xp8XfnB/
        YnKU1e9ivROnlFiKMxINtZiLihMB7RSledADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7r6P6RTDW5/M7Z4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB6l
        Z1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7Hz5mXG
        gtfcFXfefmJqYDzN2cXIySEhYCKxdd9OdhBbSGApo8SkEyUQcWmJw1+msEPYwhJ/rnWxdTFy
        AdU0M0mc+LeRCSTBJmAg8eDNMnaQhIhAJ6NE1+ZzYAlmgVvMEvdfa4HYwgKmEh9nXweLswio
        Sux4OQFsKq+ArURXdyczxAZ5iT2LvjNBxAUlTs58wgIxR16ieets5gmMfLOQpGYhSS1gZFrF
        KJJaWpybnltspFecmFtcmpeul5yfu4kRGEPbjv3csoNx5auPeocYmTgYDzFKcDArifCGHZVK
        FeJNSaysSi3Kjy8qzUktPsRoCnTfRGYp0eR8YBTnlcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJ
        pCeWpGanphakFsH0MXFwSjUw2ZxNiH5WWGskwcc71aXpWvzSKfVXuaO4N6fGnE82a98soTp1
        54+Al9fcT02oOS+8pfmwhXBcx40PAhvWTo2dpRrTZlyv7yaeYpD2bvt8D0UPvmPi62ad2f19
        5mNf3SXHZI70Tgr/vGGJQLjiZhPFq9sX+33aG7zA4nKOoccXzT3/Eiy4uXSaPB6tKFhT+GaW
        6qvU6K8zbXYzHjbjXNKXqfDI4FhZwPwSy7gfEbvvT2teIevQFXhLUP+Ia+Gv1pvup2M/5R2b
        XdQTOVc0WEX7CufuJJ8TgflH+owK/D02nheNPu/267po0sr8zdfcJn49EX2EsYwrztCh1Jsj
        s0xU0Ggno6qvs10ZS9lK/TtKLMUZiYZazEXFiQAC+PziKgMAAA==
X-CMS-MailID: 20231003111703eucas1p271e5b007be186b73639f3b958e2544f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231003111703eucas1p271e5b007be186b73639f3b958e2544f8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231003111703eucas1p271e5b007be186b73639f3b958e2544f8
References: <CGME20231003111703eucas1p271e5b007be186b73639f3b958e2544f8@eucas1p2.samsung.com>
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

 drivers/thermal/samsung/exynos_tmu.c | 536 ++++++++++++++-------------
 1 file changed, 282 insertions(+), 254 deletions(-)

-- 
2.42.0


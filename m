Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53B38007A6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378152AbjLAJ4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378036AbjLAJ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:56:38 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3A310FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:56:41 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231201095639euoutp014f468a398655f89e2582d0a1f43509ac~crKiieoQF3271932719euoutp01H
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:56:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231201095639euoutp014f468a398655f89e2582d0a1f43509ac~crKiieoQF3271932719euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701424599;
        bh=eb8mbc98REMcBZ07pJdFy0917NkB5OE4nrZXufMorTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SjiNrOkVAavObxxJ1bYuJC1sZdbrgXVpJIWDWkXqf20PeYXczsAjYHR3/BHCiwQ9D
         qfyVdXjghW8BPX4+iGRKsKk5J6IRmsMtoARHh/962ipIgo7HV/7ek05Op+aRdvwWtK
         6q9ZUKvrSQZ52hTWtJJnfEclrwIHPaakC4G0QofE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231201095639eucas1p275186a94f3422adb0dca88500fdd48b3~crKiND2Np1612516125eucas1p2b;
        Fri,  1 Dec 2023 09:56:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C1.42.09814.7DDA9656; Fri,  1
        Dec 2023 09:56:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231201095638eucas1p1124e1028823c48efac89d2bc96cc1762~crKh2uNK30245502455eucas1p1_;
        Fri,  1 Dec 2023 09:56:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231201095638eusmtrp19c4635cc3ee18fcc8f426a358ddab7e7~crKh2BX040736407364eusmtrp10;
        Fri,  1 Dec 2023 09:56:38 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-e0-6569add71dc3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F3.20.09146.6DDA9656; Fri,  1
        Dec 2023 09:56:38 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231201095637eusmtip23de90d4c8028fcf21681096181e6cdd6~crKg8KX5n1179711797eusmtip29;
        Fri,  1 Dec 2023 09:56:37 +0000 (GMT)
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
        Lukasz Luba <lukasz.luba@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v6 1/9] thermal: exynos: remove an unnecessary field
 description
Date:   Fri,  1 Dec 2023 10:56:17 +0100
Message-ID: <20231201095625.301884-2-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201095625.301884-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djPc7rX12amGqxdwWrxYN42NovD8yss
        pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
        1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4Mo4dWQOW8Eq9orVew6xNDBOZuti5OCQEDCR
        2HBOsIuRi0NIYAWjxLZzf5ggnC+MEqc2fGCHcD4zSpw5Op21i5ETrKN7y1c2iMRyoMS3SSwQ
        TiuTRNe+I+wgVWwCBhIP3iwDs0UEWhklZjapg9jMAgtZJFr+5YLYwgJBEu83n2IBsVkEVCWu
        rDrPDGLzCthKbGi/wQSxTV5iz6LvYDangJ3E/EOtLBA1ghInZz5hgZgpL9G8dTYzyBESApM5
        JV6tu8oG0ewi8WfxXKhBwhKvjm9hh7BlJE5P7mGBsPMlZmx+zwIJjAqJuwe9IExriY9nmEFM
        ZgFNifW79CGKHSXOrv3BDlHBJ3HjrSDEAXwSk7ZNZ4YI80p0tAlBVKtKHN8ziRnClpZ40nIb
        6hQPiX07FrBPYFScheSVWUhemYWwdwEj8ypG8dTS4tz01GKjvNRyveLE3OLSvHS95PzcTYzA
        BHf63/EvOxiXv/qod4iRiYPxEKMEB7OSCO/1p+mpQrwpiZVVqUX58UWlOanFhxilOViUxHlV
        U+RThQTSE0tSs1NTC1KLYLJMHJxSDUwB5zxmxUZbMIauZTNMPtay3Fbls9OU192nGz+8uf1+
        85Yfene4M841f934zD2Oz/VMqnfgvcDlD/5djj16oc5kVoB/TdrE76tefpuWvX7C/qyijuj/
        ds3L+Phuqaq/1fntlzORq6Z3aUz0HMsN6/jz+Fc2aB1vuVZ+/a93J78PK9OFys7lPqsdTC4W
        Ny23ahSz6ruyT4o5kdHq8pSJ+f48UR9Oxhl4bDzG+ymcKWL3VM2v049dmCE+bxIT56tp7woV
        M3uDvWeF80a8TrP4WtAckHNjoumOVyv458hrSMslLyjN3fO38bH3Cf4rF8M/q2ax/7V8M0Mu
        ryXkzso+t5R3kkUX6s+XC+d0r6u5sUeJpTgj0VCLuag4EQACtN443wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xe7rX1mamGkyZoGnxYN42NovD8yss
        pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
        1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
        85J6j74tqxg9Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0Ms4dWQOW8Eq9orVew6xNDBOZuti5OSQEDCR6N7yFcjm4hASWMoo0fB3GwtE
        Qlri8Jcp7BC2sMSfa11QRc1MEtt/rQBLsAkYSDx4s4wdJCEi0Mko0bX5HBOIwyywmkXi2L7v
        TCBVwgIBEkt+bWAGsVkEVCWurDoPZvMK2EpsaL/BBLFCXmLPIoh6TgE7ifmHWsHOEAKq6dry
        nxGiXlDi5MwnYHFmoPrmrbOZJzAKzEKSmoUktYCRaRWjSGppcW56brGhXnFibnFpXrpecn7u
        JkZgVG479nPzDsZ5rz7qHWJk4mA8xCjBwawkwnv9aXqqEG9KYmVValF+fFFpTmrxIUZToLsn
        MkuJJucD00JeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAPTKR5F
        EW3u0PB8UX1VlY+BO8NOJmkxRJ248d6Tb7dtXl51TVVs+oTU360VT21rlj1iM456lhKU+0bu
        ztnF+Um/6/aE2yTIiNnM/n9h2a57C17+f5iju/1k4esMocLtS8OC7sv0/WNc4Pv8WD1Dp0IC
        v+25959ncYgXbz3gtNz15DzzLU9dPs7+oqSSlSAYu/rx/zsfVKK7/qz6Lp1j0xf74vO7mTZP
        HCpWsIRUZlVFZTpM1tq3l/GEB9u1hIbj1qZTnnO0+90Nm83CprSxWSLw2RuLa+YS2+f37Z16
        eF9WpHUG92eOOftmnr67xCBq5w7nBBOND0v/7mGfEnVzQdobHeX8fd++h7h/bvm44UieEktx
        RqKhFnNRcSIA1SWXxFMDAAA=
X-CMS-MailID: 20231201095638eucas1p1124e1028823c48efac89d2bc96cc1762
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231201095638eucas1p1124e1028823c48efac89d2bc96cc1762
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231201095638eucas1p1124e1028823c48efac89d2bc96cc1762
References: <20231201095625.301884-1-m.majewski2@samsung.com>
        <CGME20231201095638eucas1p1124e1028823c48efac89d2bc96cc1762@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the field has been removed in one of the previous commits,
but the description has been forgotten.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 123ec81e1943..187086658e8f 100644
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
2.42.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CF47B67A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbjJCLRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjJCLRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:17:13 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903DAAC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:17:07 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231003111706euoutp02bfeeb13b451ad89d01b30c7cca04968f~KlM8ABbNE1049610496euoutp02y
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:17:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231003111706euoutp02bfeeb13b451ad89d01b30c7cca04968f~KlM8ABbNE1049610496euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696331826;
        bh=/ca++/KHRk6o53rF+DzbG9/VMb831UCbsayQlJT1j9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VCFMF3iKQ7alTsayspALx/I9chVxIadsjjVjRlJCNqFR9a7t4fv4GPfOq4oOkimZi
         lXSPAZ4hGs4Du6Q+ZrVqxZ2Tmkmd7hMrn1yMQZN4/4LcILNcpjHWPAlQ9oa6VHBX0Z
         lcUObG+EEjvA7OU8xVJAaM9N9uOVt8yzvS9mQtbA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231003111706eucas1p1898517e6f35ba51c43e91baa3a3d879b~KlM7uOk_42602126021eucas1p1g;
        Tue,  3 Oct 2023 11:17:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 00.2F.37758.238FB156; Tue,  3
        Oct 2023 12:17:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231003111705eucas1p2f47a85d9c53d608654c5957cae88cf60~KlM7RmT7Q2468224682eucas1p2s;
        Tue,  3 Oct 2023 11:17:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231003111705eusmtrp1ce6d8e66ac6dd31a3c945b2745107f4e~KlM7Q2Qux2246422464eusmtrp1S;
        Tue,  3 Oct 2023 11:17:05 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-d7-651bf832c6af
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D6.D1.10549.138FB156; Tue,  3
        Oct 2023 12:17:05 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231003111704eusmtip22bf7e326c87e75be0083e005f8032a34~KlM6fh-e52844228442eusmtip2B;
        Tue,  3 Oct 2023 11:17:04 +0000 (GMT)
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
Subject: [PATCH v3 1/8] thermal: exynos: remove an unnecessary field
 description
Date:   Tue,  3 Oct 2023 13:16:27 +0200
Message-ID: <20231003111638.241542-2-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003111638.241542-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djPc7pGP6RTDU4/Z7F4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB7F
        ZZOSmpNZllqkb5fAldG0jLtgFXvFiu+bGBsYJ7N1MXJySAiYSExe+4ipi5GLQ0hgBaPE48s7
        2SCcL4wS0x5tZQapEhL4zCixc5cqTMfW/9cZIYqWM0q0rznMDOG0Mklc+dXFDlLFJmAg8eDN
        MjBbRKCVUWJmkzpIEbPAJWaJuzfXsoAkhAWCJGac/wR2CIuAqsTnhkesIDavgK3Eq/fLWCDW
        yUvsWfSdCcTmFLCTWPlzORNEjaDEyZlPwGqYgWqat84Gu0JCoJlT4sjctUCbOYAcF4lVTQEQ
        c4QlXh3fwg5hy0icntwDNT9fYsbm9ywQ5RUSdw96QZjWEh/PMIOYzAKaEut36UNEHSXad6tA
        mHwSN94KQqznk5i0bTozRJhXoqNNCGKyqsTxPZOYIWxpiSctt5kgbA+JJfd72CcwKs5C8sgs
        JI/MQli7gJF5FaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmD6Ov3v+NcdjCtefdQ7xMjE
        wXiIUYKDWUmEN+yoVKoQb0piZVVqUX58UWlOavEhRmkOFiVxXm3bk8lCAumJJanZqakFqUUw
        WSYOTqkGpvWp9dkfJjT8tdDsqCw1616/dMOO9f+b6tu495ZbduZO+VFvmBan95tnb8S3MB7h
        s6ayhpYBoksV16r+ZIwReMMhzM+WaBjlWbbm+sJpO3Y1bTy1RWeOWLwpV9Hue5MT9hROr+Cc
        /MbSQ1JyB0fWpt5iS620/w3qb1ZOn1vfInU0IfbXZOGtXdd6n3El3nx88lKFfJy2ng5LtUZf
        /i7pyM2xPJPVs5lLF03dZR/YHhSl75HRfuXFtmmpTfGNgUcaVE892K5Vq1UvJdb6VVaTVfCm
        JZeGp+uqh8vWGVR5K8+q+LPseoCZ17H/z3edSRZ8NEWofNqV+3Inzzece6e4Uf6NDntuR33N
        zicTTRYpsRRnJBpqMRcVJwIAwcSbKc4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xe7qGP6RTDc79VLJ4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBYTj01mtlh7
        5C67xdwvU5ktnjzsY3Pg99g56y67x+I9L5k8Nq3qZPO4c20Pm8fmJfUefVtWMXp83iQXwB6l
        Z1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl9G0jLtg
        FXvFiu+bGBsYJ7N1MXJySAiYSGz9f52xi5GLQ0hgKaNEx45bzBAJaYnDX6awQ9jCEn+udbFB
        FDUzSTx9tJsJJMEmYCDx4M0ydpCEiEAno0TX5nNgCWaBW8wS919rgdjCAgESi3Z3gk1iEVCV
        +NzwiBXE5hWwlXj1fhkLxAZ5iT2LvoP1cgrYSaz8uRzMFgKqubV8HwtEvaDEyZlPWCDmy0s0
        b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECY27bsZ+bdzDOe/VR
        7xAjEwfjIUYJDmYlEd6wo1KpQrwpiZVVqUX58UWlOanFhxhNge6eyCwlmpwPjPq8knhDMwNT
        QxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQamas4N/tbfVx6ZttKjXa8mJ2ii
        7msLWa41m+Qneqr3C+jtm1s439L3teF6iyefb3tNe/HiR+bzXZO28V6NONR+y9Mo89ye7sXx
        vh93ZrfWcW818jYKzOpS51Ft/y6XtGDf9zbDXRf/LrhwRS8nTUTpwaVz4i2N33+VXuG9fVnL
        /2ow55r+vlBBpuu3Mo70frlTOs9a+9JJPq3oldckyo7e2cgaYvFnfkLHmqPLgk/Xd6yOfLiw
        1GuN8/RztVNuLn/ydN0Cd8YDGVJat7+/Orpo+pbWXwGr5eb1zBNzMI49rGu2pGbrrCuL15Y/
        85tn17vsKNOemlevF5xxPabdqDDr2bwznQ1mQW2NnEdep9nM26nEUpyRaKjFXFScCAAqOo69
        QgMAAA==
X-CMS-MailID: 20231003111705eucas1p2f47a85d9c53d608654c5957cae88cf60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231003111705eucas1p2f47a85d9c53d608654c5957cae88cf60
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231003111705eucas1p2f47a85d9c53d608654c5957cae88cf60
References: <20231003111638.241542-1-m.majewski2@samsung.com>
        <CGME20231003111705eucas1p2f47a85d9c53d608654c5957cae88cf60@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
2.42.0


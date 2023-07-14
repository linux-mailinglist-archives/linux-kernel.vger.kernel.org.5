Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A46B7537B9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbjGNKPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbjGNKPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:15:10 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD24359E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:14:38 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230714101436epoutp0334184c575f181c8567923c1a498ad506~xtGPUqsI10695706957epoutp03t
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:14:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230714101436epoutp0334184c575f181c8567923c1a498ad506~xtGPUqsI10695706957epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689329676;
        bh=BUueTlTb1GY44yfxXatx1oK5LtS9J3wrB4ATu5iHCOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anLk/lIjdijFmnS+utmBp1wSoI/LlEFuwiXfWkRW8tKTkXSSZcjvyr4z8Htpqcl72
         bLyBBakFSYNYIBdYDy8Km3/48vhJrRiGnzGYq1lsmp7fI8tpiZNlN/Tr/oa/v9UnUV
         mXoQ34SSC6jeC84KnQ58ltpaatqoRijh9gTJECy0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230714101435epcas2p3b2a1986051f6adc541e33336e32d6fd1~xtGOm9PEF0818708187epcas2p3R;
        Fri, 14 Jul 2023 10:14:35 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.99]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4R2S570Bgcz4x9Pp; Fri, 14 Jul
        2023 10:14:35 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.8B.49913.A0021B46; Fri, 14 Jul 2023 19:14:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230714101434epcas2p3e2475698c527ca72dee797225d3dad37~xtGNedua00818708187epcas2p3P;
        Fri, 14 Jul 2023 10:14:34 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230714101434epsmtrp1e978c725921bcfca415f5a51b811ad95~xtGNdwh6N1161511615epsmtrp1i;
        Fri, 14 Jul 2023 10:14:34 +0000 (GMT)
X-AuditID: b6c32a45-5cfff7000000c2f9-95-64b1200a172d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.E9.64355.90021B46; Fri, 14 Jul 2023 19:14:34 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230714101433epsmtip1c6794cab3d2c11f4be5799b9bd8640b6~xtGNQKFAY0144301443epsmtip1K;
        Fri, 14 Jul 2023 10:14:33 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v2 2/3] pwm: samsung: Add compatible for ExynosAutov9 SoC
Date:   Fri, 14 Jul 2023 19:09:28 +0900
Message-Id: <20230714100929.94563-3-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230714100929.94563-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdljTQpdLYWOKwfGpVhYP5m1js7i8X9ti
        zd5zTBbzj5xjtdjRcITVou/FQ2aLTY+vsVpc3jWHzeLu3VWMFjPO72OyaN17hN3i5655LBa3
        J05mdOD12DnrLrvHplWdbB53ru1h89i8pN6j/6+BR9+WVYwenzfJBbBHZdtkpCampBYppOYl
        56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAN2qpFCWmFMKFApILC5W0rez
        KcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjOOPHmO3vBEraKU5vk
        GxhXs3YxcnJICJhIPDm1iL2LkYtDSGAHo0Tvxc/MEM4nRok3896xwjlb2/8wwrTMvfiCESKx
        k1Hi5uNeqKqPjBIzpnSDDWYT0Jb4vn4xmC0isJBJ4tn9MhCbWeAbo8TkPzwgtrCAp8TmC4tZ
        QGwWAVWJax/vgG3gFbCVmLZtERPENnmJ1RsOMIPYnAJ2Es/+bWIDWSYh8JNd4u6/z1AnuUjM
        2XMfqkFY4tXxLewQtpTEy/42KDtbon36H6ivKyQubpjNBmEbS8x61g40hwPoOE2J9bv0QUwJ
        AWWJI7dYIE7mk+g4/JcdIswr0dEmBNGoJnF/6jmoITISk46shDrAQ+LEgTvQIJkIDJK/hxkn
        MMrNQliwgJFxFaNYakFxbnpqsVGBITzCkvNzNzGCk6KW6w7GyW8/6B1iZOJgPMQowcGsJMKr
        sm1dihBvSmJlVWpRfnxRaU5q8SFGU2DYTWSWEk3OB6blvJJ4QxNLAxMzM0NzI1MDcyVx3nut
        c1OEBNITS1KzU1MLUotg+pg4OKUamNL2OXGclY3Uvi3PLv629+y8Z4fqpdYcPvzw/cno2Ufm
        8voteLNgV8Uzk+lOgtPnXXh34+TlDpt4RvdzWkrccQam7x4divd9+zDL1OTCv4dx5j+KWbbs
        dF5e2HnJtUnpxa5Tm25eW7dHnvWtbIiSR8qb8qIMLk6lSRsMvuj9nlt68bLBdT/Nidp1V8WE
        /ZVkNjVvLL+UsPX9Im62T9dLJuXtszx7X7f4+9ae2s7u8/+qPp5dFHlR48bft7sm7+ouKu1K
        /8WhVxpSnadv86axTWn50e1BRt+OqQfM3dJ18FTijquOsR5PlwvUpfra269t+vPweUZtV6/m
        dd2N+Zee5318YDff5OdEJaZHehJL7E8rsRRnJBpqMRcVJwIA/S9NKRMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnC6XwsYUg8Z2JosH87axWVzer22x
        Zu85Jov5R86xWuxoOMJq0ffiIbPFpsfXWC0u75rDZnH37ipGixnn9zFZtO49wm7xc9c8Fovb
        EyczOvB67Jx1l91j06pONo871/aweWxeUu/R/9fAo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0S
        uDJOvPnOXrCEreLUJvkGxtWsXYycHBICJhJzL75g7GLk4hAS2M4o8WvJYRaIhIzE8md9bBC2
        sMT9liOsEEXvGSWWrp3IBJJgE9CW+L5+MVhCRGAxk8Sb7odgDrPAH0aJ/qYVYDuEBTwlNl9Y
        DDaWRUBV4trHO4wgNq+ArcS0bYuYIFbIS6zecIAZxOYUsJN49m8T2GohoJoPj38wTWDkW8DI
        sIpRNLWgODc9N7nAUK84Mbe4NC9dLzk/dxMjOHS1gnYwLlv/V+8QIxMH4yFGCQ5mJRFelW3r
        UoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzKud0pggJpCeWpGanphakFsFkmTg4pRqYNDQsvNb+
        SQtuVH8e+NjPvPN8zdTrCd4v6wyOqF1MWMH2a/fT8lTRzXpq2xZZL7P1tou5lPtA48nG10w7
        vkRtNq56mz5lvoO16/3POZuc929xTPzLIFrxhkVgscdDuWY5E6Xapvt5guYmETLx2559scpg
        t0xIvfR138EnjSwdd29K/5hs1a+otj1s29k+9nccW2TTMhKrX/uf4friMSFt2t0DPx/7m4vJ
        JwktV8lfYfpCyHy1wmmW6FvvGIo3TZuotPdUv9XUkrfO651rxKujf04/xvA7ouP2C36W9avv
        2/kaWK9miVs2WXZdsela+2g1M3aB4y1yd2onO7xR9N4rLlN8q+XRPD6tuZ6afn+VWIozEg21
        mIuKEwEK9A30zAIAAA==
X-CMS-MailID: 20230714101434epcas2p3e2475698c527ca72dee797225d3dad37
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230714101434epcas2p3e2475698c527ca72dee797225d3dad37
References: <20230714100929.94563-1-jaewon02.kim@samsung.com>
        <CGME20230714101434epcas2p3e2475698c527ca72dee797225d3dad37@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible string to support ExynosAutov9 SoC.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/pwm/pwm-samsung.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index e8828f57ab15..50a88565c440 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -513,6 +513,7 @@ static const struct of_device_id samsung_pwm_matches[] = {
 	{ .compatible = "samsung,s5p6440-pwm", .data = &s5p64x0_variant },
 	{ .compatible = "samsung,s5pc100-pwm", .data = &s5pc100_variant },
 	{ .compatible = "samsung,exynos4210-pwm", .data = &s5p64x0_variant },
+	{ .compatible = "samsung,exynosautov9-pwm", .data = &s5p64x0_variant },
 	{},
 };
 MODULE_DEVICE_TABLE(of, samsung_pwm_matches);
-- 
2.17.1


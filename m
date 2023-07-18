Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4F8757285
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGRDrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjGRDrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:47:33 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD2210C8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:47:28 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230718034725epoutp02a21191d2318fbc6f49a99e4cd95482ab~y2ZU_czVV2724227242epoutp02j
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:47:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230718034725epoutp02a21191d2318fbc6f49a99e4cd95482ab~y2ZU_czVV2724227242epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689652045;
        bh=L5iesQnu6wEMqGN1E46p7ijr/52gAmlg78TCYwaaXOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4t+WWOWv7KV96MbiY2IIOR1TFmS17FppPDtNoV4k1Lu35tfzwUj11oiumCMKWlOV
         yfvQLzBvObvmqFR/TBDBVQZZCZgGspXOnUZmsYOkjSMW8ruqHPNkp2OX6mu0hPzKvV
         lHfF8EdL0DvjCegSejq41567l+x2jxzijHKsL5Ag=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230718034724epcas2p1fe80ed107287e78af9324f76d211eab2~y2ZUolLVS2175421754epcas2p1S;
        Tue, 18 Jul 2023 03:47:24 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4R4lJX3xkNz4x9Q6; Tue, 18 Jul
        2023 03:47:24 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.7A.32606.C4B06B46; Tue, 18 Jul 2023 12:47:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230718034723epcas2p3913ad208c70659965b4ec204570aa0a1~y2ZTsTuwx2780627806epcas2p3i;
        Tue, 18 Jul 2023 03:47:23 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230718034723epsmtrp1ca8a74cfe8d4fb4601332174acea49e5~y2ZTrmIHm2911129111epsmtrp1B;
        Tue, 18 Jul 2023 03:47:23 +0000 (GMT)
X-AuditID: b6c32a47-9cbff70000007f5e-b5-64b60b4cd286
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.03.64355.B4B06B46; Tue, 18 Jul 2023 12:47:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230718034723epsmtip10495c00da0e86785e60c4ac773b93a65~y2ZTeAuMF1656116561epsmtip1a;
        Tue, 18 Jul 2023 03:47:23 +0000 (GMT)
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
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v5 1/2] dt-bindings: pwm: samsung: add exynosautov9
 compatible
Date:   Tue, 18 Jul 2023 12:42:00 +0900
Message-Id: <20230718034201.136800-2-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230718034201.136800-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmha4P97YUg7XNEhYP5m1js1iz9xyT
        xfwj51gtdjQcYbXoe/GQ2WLT42usFpd3zWGzuHt3FaPFjPP7mCxa9x5ht/i5ax6Lxe2Jkxkd
        eDx2zrrL7rFpVSebx51re9g8Ni+p9+j/a+DRt2UVo8fnTXIB7FHZNhmpiSmpRQqpecn5KZl5
        6bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAdyoplCXmlAKFAhKLi5X07WyK8ktL
        UhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjM277zNXPCYu6J9knYD4zaO
        LkZODgkBE4nVy5vYQWwhgR2MEl1dCV2MXED2J0aJez+PssM5s6+uZIPpOHfjBxNEx05GiWfb
        ciCKPjJK9LdeAhvFJqAt8X39YlYQW0RgIZPEs/tlIEXMAqcZJdbeesICkhAWCJC4PbGPEcRm
        EVCV2LP4OFicV8BO4v6RI1Db5CVWbzjADGJzCthLTNi9B+wkCYGP7BJ/X91lhShykXh18iQj
        hC0s8er4FnYIW0riZX8blJ0t0T79D1R9hcTFDbOhFhhLzHrWDtTLAXSdpsT6XfogpoSAssSR
        W2DnMAvwSXQc/ssOEeaV6GgTgmhUk7g/9RzUEBmJSUdWMkHYHhJ33rUxQsJnEqPE5gvaExjl
        ZiHMX8DIuIpRLLWgODc9tdiowBgeXcn5uZsYwYlQy30H44y3H/QOMTJxMB5ilOBgVhLh/b5q
        U4oQb0piZVVqUX58UWlOavEhRlNg0E1klhJNzgem4rySeEMTSwMTMzNDcyNTA3Mlcd57rXNT
        hATSE0tSs1NTC1KLYPqYODilGpg67DyTmlbL5yd2N3vwqX6ZO0PsZqwT48I2/W4rlWK9A64s
        K47xrpisVbdd1+fPpNdV0vpK81jiGLqa5C3X+nqZRxV8ErnfuuvHruYj3hd3Wgd0PZS8NJf9
        rZlhscy7e5ufNf8v5vgQ/muxUO+OqUUfzm17qbx95rT7NVb+TL//mSRfq7g9083ww655ZcU6
        CV4RpxP3f1X/cW6NzpID3f9E+yO99uusvFXjGFtkblxaphU8s15kr7xP31EOVuffUw8ks78u
        Tlpgdi4qZcZVtVXXLbraAn353++bz9h7W9Y7PpV7b129p7HLiu1TEhIrU/5cfeIdLD7BI/jQ
        +rxt1zdmPHnYmLX+UEGQl802RiWW4oxEQy3mouJEAJtjrWQNBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSnK4397YUg0fNehYP5m1js1iz9xyT
        xfwj51gtdjQcYbXoe/GQ2WLT42usFpd3zWGzuHt3FaPFjPP7mCxa9x5ht/i5ax6Lxe2Jkxkd
        eDx2zrrL7rFpVSebx51re9g8Ni+p9+j/a+DRt2UVo8fnTXIB7FFcNimpOZllqUX6dglcGZt3
        3mYueMxd0T5Ju4FxG0cXIyeHhICJxLkbP5hAbCGB7YwSUz+bQsRlJJY/62ODsIUl7rccYe1i
        5AKqec8o0fb2DitIgk1AW+L7+sVgCRGBxUwSb7ofgjnMAhcZJU78ucIOUiUs4Cdx6Mk6sFEs
        AqoSexYfZwGxeQXsJO4fOQK1Ql5i9YYDzCA2p4C9xITde9ghTrKT+Lj0G+MERr4FjAyrGEVT
        C4pz03OTCwz1ihNzi0vz0vWS83M3MYIDVitoB+Oy9X/1DjEycTAeYpTgYFYS4f2+alOKEG9K
        YmVValF+fFFpTmrxIUZpDhYlcV7lnM4UIYH0xJLU7NTUgtQimCwTB6dUA1O6ZKSCxOKr0u8v
        cJ4M+fts4vrpd1rfXHJctId1m2X4n/2hnWtX2i5YllD/+lx6SlNJXo7o7dpLZ/xNWzOXcf29
        IVwas0z5XEBHXtaC5ILLZ7UqOpazGZxPU3h/o2xdxu4917YaLc5PqThi4CPuL+TL2/g0oDnh
        8Awfc9PIUte7Pbaad7M357ff57l4dfMGOxGr1jWTKrq0jry7v85ONFDB3kEredJ6hQThZ/M1
        UjuEXrRPY//ELNkmv71hhVWp97uz3HEhF9iq1KPcDqyU+cVSYtp7JEa24Osjh8C1r66zT/53
        1uS0YF495/I11QYaaTypux/mBUvt2Fz+LjxvYuah/Stl/67otDdVOD33oBJLcUaioRZzUXEi
        ABfuLazHAgAA
X-CMS-MailID: 20230718034723epcas2p3913ad208c70659965b4ec204570aa0a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230718034723epcas2p3913ad208c70659965b4ec204570aa0a1
References: <20230718034201.136800-1-jaewon02.kim@samsung.com>
        <CGME20230718034723epcas2p3913ad208c70659965b4ec204570aa0a1@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add samsung,exynosautov9-pwm compatible string to binding document.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 .../devicetree/bindings/pwm/pwm-samsung.yaml    | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
index fe603fb1b2cc..2162f661ed5a 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
@@ -20,12 +20,17 @@ description: |+
 
 properties:
   compatible:
-    enum:
-      - samsung,s3c2410-pwm             # 16-bit, S3C24xx
-      - samsung,s3c6400-pwm             # 32-bit, S3C64xx
-      - samsung,s5p6440-pwm             # 32-bit, S5P64x0
-      - samsung,s5pc100-pwm             # 32-bit, S5PC100, S5PV210, Exynos4210 rev0 SoCs
-      - samsung,exynos4210-pwm          # 32-bit, Exynos
+    oneOf:
+      - enum:
+          - samsung,s3c2410-pwm             # 16-bit, S3C24xx
+          - samsung,s3c6400-pwm             # 32-bit, S3C64xx
+          - samsung,s5p6440-pwm             # 32-bit, S5P64x0
+          - samsung,s5pc100-pwm             # 32-bit, S5PC100, S5PV210, Exynos4210 rev0 SoCs
+          - samsung,exynos4210-pwm          # 32-bit, Exynos
+      - items:
+          - enum:
+              - samsung,exynosautov9-pwm
+          - const: samsung,exynos4210-pwm
 
   reg:
     maxItems: 1
-- 
2.17.1


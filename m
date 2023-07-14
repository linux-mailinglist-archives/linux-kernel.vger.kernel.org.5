Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909D07537B5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbjGNKPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbjGNKPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:15:09 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C56435A5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:14:38 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230714101435epoutp01ff06840f49d6f5970e8c4f7f3bca059a~xtGPJLM7C0696506965epoutp01d
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:14:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230714101435epoutp01ff06840f49d6f5970e8c4f7f3bca059a~xtGPJLM7C0696506965epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689329675;
        bh=uGSnc0JtPp2z8O/U8yt8R+MI6mGEW0b3rIVnO2uh+5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iv87XONGLX9qEduRtX9FTzFpSJY/Jyi/9u0CfM/lxg0aSBjRHPhBRDOBbn1lt4Er8
         G/qD0E/mf7thnE0FgGIc+RkXYBeBFZnuWQ5Gyf0Xf6I+BVF5c9n5H1E/RihxtafjY5
         s/9Eb0MaKMrluOoyX6kdg5tA+/yRARpQJja3ic6o=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230714101435epcas2p4a88b89a1fea846169fbab88c72cd89db~xtGOnWCpT2146321463epcas2p4b;
        Fri, 14 Jul 2023 10:14:35 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4R2S570C4Pz4x9Q1; Fri, 14 Jul
        2023 10:14:35 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.8B.49913.A0021B46; Fri, 14 Jul 2023 19:14:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230714101434epcas2p1e0788544f244e59861f45b10e450075c~xtGNZizjn0423904239epcas2p1J;
        Fri, 14 Jul 2023 10:14:34 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230714101434epsmtrp11976297d84d9da54876f0d4f8c8443dc~xtGNYg1Up1161511615epsmtrp1h;
        Fri, 14 Jul 2023 10:14:34 +0000 (GMT)
X-AuditID: b6c32a45-83dfd7000000c2f9-94-64b1200a3bd2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.15.14748.90021B46; Fri, 14 Jul 2023 19:14:33 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230714101433epsmtip1f951c0c3a2df2b7d9ff5cff71ce6bce2~xtGNJnooJ0143601436epsmtip1b;
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
Subject: [PATCH v2 1/3] dt-bindings: pwm: samsung: add exynosautov9
 compatible
Date:   Fri, 14 Jul 2023 19:09:27 +0900
Message-Id: <20230714100929.94563-2-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230714100929.94563-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmhS6XwsYUg53/LC0ezNvGZnF5v7bF
        mr3nmCzmHznHarGj4QirRd+Lh8wWmx5fY7W4vGsOm8Xdu6sYLWac38dk0br3CLvFz13zWCxu
        T5zM6MDrsXPWXXaPTas62TzuXNvD5rF5Sb1H/18Dj74tqxg9Pm+SC2CPyrbJSE1MSS1SSM1L
        zk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpVSaEsMacUKBSQWFyspG9n
        U5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdcfr7EaaCZ2wVx96c
        Z29g3M3axcjJISFgIjF522KWLkYuDiGBHYwS/5omMUM4nxglbvbMYgSpEhL4xijRezcRpmPr
        3N1sEEV7GSXubrrNCOF8ZJRY93olM0gVm4C2xPf1i8F2iAgsZJJ4dr8MxGYGmTT5Dw+ILSwQ
        ILH92H8WEJtFQFXiyZk3YDavgK3E9739UPfJS6zecABsJqeAncSzf5vANksINHJIdF+cDLSZ
        A8hxkej7zA5RLyzx6vgWKFtK4mV/G5SdLdE+/Q/UzAqJixtms0HYxhKznrWDjWEW0JRYv0sf
        YqKyxJFbLBAX80l0HP7LDhHmlehoE4JoVJO4P/Uc1BAZiUlHVjJB2B4SR99+Z4eEyERGiY9b
        DrJMYJSbhbBgASPjKkax1ILi3PTUYqMCQ3h8JefnbmIEp0Qt1x2Mk99+0DvEyMTBeIhRgoNZ
        SYRXZdu6FCHelMTKqtSi/Pii0pzU4kOMpsCgm8gsJZqcD0zKeSXxhiaWBiZmZobmRqYG5kri
        vPda56YICaQnlqRmp6YWpBbB9DFxcEo1MG1492breZbcA/qfQs58Unx2syT/1bYjJ73U+d+E
        zYwxv3NssaEupyz7o9JpYjo5m4oy5DmKuGa/PZxw5aj0Xv1nLCHys1l1nb8mGfmpnVjWKxvr
        e2ehTdl+LU696ac3PZz17WS65b0Ze1QlHTru/Sl5xMYbvniLjaP87Jbi6Zcc419c3VQ5Ycvk
        32cKNvDtWWByMCz3fe3GRV8jnt5Y1PO9Qf/8xsX21afMBW0/akruzdp2PDox8J1IReky2fXT
        b3q6d93IXHi773PorV951ryPlxptyk+abvzN4dTJQ25ZPp9v/Zz+TKDqaeSGdw7Fn8NV+w1c
        DxTfvljgbjR9l9OOJ5zlqbt/Sqmx+SS+eHBAiaU4I9FQi7moOBEAELJHiBIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWy7bCSnC6nwsYUg9fzLCwezNvGZnF5v7bF
        mr3nmCzmHznHarGj4QirRd+Lh8wWmx5fY7W4vGsOm8Xdu6sYLWac38dk0br3CLvFz13zWCxu
        T5zM6MDrsXPWXXaPTas62TzuXNvD5rF5Sb1H/18Dj74tqxg9Pm+SC2CP4rJJSc3JLEst0rdL
        4Mo4/f0IU8Eztopjb86zNzDuZu1i5OSQEDCR2Dp3N1sXIxeHkMBuRolzzYtYIBIyEsuf9bFB
        2MIS91uOsEIUvWeUmLX6ChNIgk1AW+L7+sVgCRGBxUwSb7ofgjnMAn8YJfqbVoDtEBbwk1i3
        ciLYWBYBVYknZ96A2bwCthLf9/ZD3SEvsXrDAWYQm1PATuLZv01gq4WAaj48/sE0gZFvASPD
        KkbJ1ILi3PTcZMMCw7zUcr3ixNzi0rx0veT83E2M4CDW0tjBeG/+P71DjEwcjIcYJTiYlUR4
        VbatSxHiTUmsrEotyo8vKs1JLT7EKM3BoiTOazhjdoqQQHpiSWp2ampBahFMlomDU6qB6ci9
        M+eSlCzOeB7nvlE994yE5J++4GeVfMtn1m4ON+qz/iX5XqiiegXH7kuuqznmpOlvef6k6OTV
        o5t5O1SSV/NFXd2089yGR1Lz9V5Ny9eLPW9Xdvah4YkbCzSEWr/uUdIVCjS7L754EleZ3b6f
        R/lDpzILa+Ute7PdvVK+/J+cx7aXdza/CnJJ2Ptp2WHdx+xb/+0RS79/3qYp7I/vKeOmLL1d
        l6M8uoxklrpONJvXNM9gKXdK2O1L7lweFtvfLU6bvsmy5uiu6fUvdt48PJtd/fa66p7vQWrf
        fhvNnN/zn81hBe+laskTWetd57HMeu1w7fviI/ErF0Wsn+778d9Gl1VTFW18WyNzp5/9t3a2
        EktxRqKhFnNRcSIAtH1gRtECAAA=
X-CMS-MailID: 20230714101434epcas2p1e0788544f244e59861f45b10e450075c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230714101434epcas2p1e0788544f244e59861f45b10e450075c
References: <20230714100929.94563-1-jaewon02.kim@samsung.com>
        <CGME20230714101434epcas2p1e0788544f244e59861f45b10e450075c@epcas2p1.samsung.com>
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

Add samsung,exynosautov9-pwm compatible string to binding document.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 Documentation/devicetree/bindings/pwm/pwm-samsung.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
index fe603fb1b2cc..39a471083016 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
@@ -26,6 +26,7 @@ properties:
       - samsung,s5p6440-pwm             # 32-bit, S5P64x0
       - samsung,s5pc100-pwm             # 32-bit, S5PC100, S5PV210, Exynos4210 rev0 SoCs
       - samsung,exynos4210-pwm          # 32-bit, Exynos
+      - samsung,exynosautov9-pwm        # 32-bit, ExynosAutov9
 
   reg:
     maxItems: 1
-- 
2.17.1


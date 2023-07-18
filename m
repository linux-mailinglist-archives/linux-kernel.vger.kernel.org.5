Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9849757420
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjGRG1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjGRG1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:27:39 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58A31726
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:27:27 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230718062725epoutp0264c56b8750e7945eb4384626c8b6f14c~y4lB2hzaW1826018260epoutp02Z
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:27:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230718062725epoutp0264c56b8750e7945eb4384626c8b6f14c~y4lB2hzaW1826018260epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689661645;
        bh=AuiPCWEWR/H2A9GOfmwJJHkrf3gA1m989r4DeTYfrng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ua0iMA0FxxEi/RLgHs2JJYIIvRk2przwCbmdSWhtWT5C5MwSaIConNXFQzqZGAF/I
         PKBMcs8s8z3E6t8H1EvDUFoBnSjvupv/FEqaWCB4ufDmSgK89s+qopFcNvXWZIhKl4
         CwVC1gMPoaF2P9hS4inXtoXiFZjPUrWXJiCANHrE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230718062724epcas2p2ecb2ef9b77761949d99848f2941f93b1~y4lBRtIEV1962319623epcas2p2B;
        Tue, 18 Jul 2023 06:27:24 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4R4ps83Kbwz4x9QB; Tue, 18 Jul
        2023 06:27:24 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.56.40133.CC036B46; Tue, 18 Jul 2023 15:27:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230718062724epcas2p4c5e986c62fba72f722a37973e721a452~y4lAhZHPJ3019630196epcas2p4s;
        Tue, 18 Jul 2023 06:27:24 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230718062723epsmtrp1c57f8bf743b262a8fe28c060147f7040~y4lAgfv-P2369723697epsmtrp1D;
        Tue, 18 Jul 2023 06:27:23 +0000 (GMT)
X-AuditID: b6c32a46-6fdfa70000009cc5-75-64b630cc1111
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.68.14748.BC036B46; Tue, 18 Jul 2023 15:27:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230718062723epsmtip25ad045fd2df07990ee5f30ea8a4489bb~y4lAOAPyZ0231302313epsmtip2O;
        Tue, 18 Jul 2023 06:27:23 +0000 (GMT)
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
Subject: [PATCH v6 1/2] dt-bindings: pwm: samsung: add exynosautov9
 compatible
Date:   Tue, 18 Jul 2023 15:21:59 +0900
Message-Id: <20230718062200.79306-2-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230718062200.79306-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmue4Zg20pBk3fhS0ezNvGZrFm7zkm
        i/lHzrFa7Gg4wmrR9+Ihs8Wmx9dYLS7vmsNmcffuKkaLGef3MVm07j3CbvFz1zwWi9sTJzM6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79H/18Cjb8sqRo/Pm+QC2KOybTJSE1NSixRS85LzUzLz
        0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA7lRSKEvMKQUKBSQWFyvp29kU5ZeW
        pCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGfM/7marWAZT8Xh/sPMDYxf
        OLoYOTkkBEwkLp94xA5iCwnsYJS4sDKxi5ELyP7EKLH1RjcLhPONUWLih29sXYwcYB3n2tgh
        4nsZJboOtzBCdH9klNg0PwTEZhPQlvi+fjEriC0isJBJ4tn9MpAGZoHTjBJrbz1hAUkICwRI
        fH28BqyZRUBV4s2CL2ALeAVsJb7cLoO4Tl5i9YYDzCA2p4CdxOrdl5kg4o0cEo1N5RC2i0TH
        pfPsELawxKvjW6BsKYmX/W1QdrZE+/Q/rBB2hcTFDbPZIGxjiVnP2hlB1jILaEqs36UP8aKy
        xJFbYEcyC/BJdBz+yw4R5pXoaBOCaFSTuD/1HNQQGYlJR1ZCHeYhsffDFGioTQQG4f4VjBMY
        5WYhLFjAyLiKUSy1oDg3PbXYqMAIHlvJ+bmbGMFpUMttB+OUtx/0DjEycTAeYpTgYFYS4f2+
        alOKEG9KYmVValF+fFFpTmrxIUZTYMhNZJYSTc4HJuK8knhDE0sDEzMzQ3MjUwNzJXHee61z
        U4QE0hNLUrNTUwtSi2D6mDg4pRqYapSFLeUW/DEpSLE2EZqlVtHOyHZN8pzFsaNa047p6mqd
        Vwz8MYm7eOOvqoPum7Q5Jhyo/pbWVVy+o8RsbXvUlIytF/MmTY6aGxMxR5RXYPfX+IyS8G+/
        /uyYILGsS+mB40Rh/SdbFt5YWFP+8U3L24vbQxxKy+riCszVk152B5Usjs8wcr8uIC3PvPHi
        kn85pxka3l77X3nRZvLHNSd3LC948utv/bJvC6/f1DVcvnrxoj7XasdVUf4xnO972iTjbzRz
        8a5c9WJSyM6rkW+vG/1nLj8WNu30RZEDQi+Zsyvizm/QWRmbse7H2127r9mu7Q0Xmfaa6adb
        9vc/X6f1XUi6a/zoRNLrf0/PTdvkY6HEUpyRaKjFXFScCACU+dDGDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWy7bCSvO5pg20pBgtXm1k8mLeNzWLN3nNM
        FvOPnGO12NFwhNWi78VDZotNj6+xWlzeNYfN4u7dVYwWM87vY7Jo3XuE3eLnrnksFrcnTmZ0
        4PHYOesuu8emVZ1sHneu7WHz2Lyk3qP/r4FH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZcz/
        uZqtYBlPxeH+w8wNjF84uhg5OCQETCTOtbF3MXJxCAnsZpS4vegqaxcjJ1BcRmL5sz42CFtY
        4n7LEVaIoveMEh19ExlBEmwC2hLf1y8GS4gILGaSeNP9EMxhFrjIKHHizxV2kCphAT+J7V0L
        mEFsFgFViTcLvrCBrOYVsJX4crsMYoO8xOoNB8BKOAXsJFbvvswEYgsBlay4N49pAiPfAkaG
        VYySqQXFuem5yYYFhnmp5XrFibnFpXnpesn5uZsYwYGrpbGD8d78f3qHGJk4GA8xSnAwK4nw
        fl+1KUWINyWxsiq1KD++qDQntfgQozQHi5I4r+GM2SlCAumJJanZqakFqUUwWSYOTqkGJtkU
        w/g1k9f4hkf+EXnneUE86d6y8580Oiysy0J/MH/yXCf+3fbkxVnLo2TvqZxinhwVYv/g85+Q
        1L8CVnYLGuN29JqLJlvEr+76yH15uuPT5uOTUhWvz+dNvZb7W2fv+vkJqXvVchkC1GU3/eDc
        7ao58cy076kJ4monjSImvY7Zua89lPd56dXjD671fFrTcTGg8amaqtqGt19Pv+h9q7M6OmPF
        r28H7q+ZM/sVZ+ox1YxSmYLjjAe5FxxQb8qwvq01w7JlCr/z2prgzEuTTU9V80rEHnTTuXvt
        7ql1odNnfOy5ItK87OTjvW33PRU+XbFfue3Wh9sb158Wnzs5PiWYMX5nTlXlv5/hlSfVOkqV
        WIozEg21mIuKEwFX6sAvywIAAA==
X-CMS-MailID: 20230718062724epcas2p4c5e986c62fba72f722a37973e721a452
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230718062724epcas2p4c5e986c62fba72f722a37973e721a452
References: <20230718062200.79306-1-jaewon02.kim@samsung.com>
        <CGME20230718062724epcas2p4c5e986c62fba72f722a37973e721a452@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add samsung,exynosautov9-pwm compatible string to binding document.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


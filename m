Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE427EC003
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbjKOJ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbjKOJ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:59:09 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123A319B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:59:04 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231115095856epoutp026554494cac3e1f94b33e7e4524d281ef~Xw39lZnYc0239102391epoutp02_
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:58:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231115095856epoutp026554494cac3e1f94b33e7e4524d281ef~Xw39lZnYc0239102391epoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700042336;
        bh=vGEJOjivthvr73BNxlMLKnpgeM8pqA65OJWYGei4FeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tt8X6nILmf4674pQ7g+RXSW05Paz/hW4ptJkhVzRBcBAXLS7rCQWkiivzB/y5cNDj
         EzNT30r6Ah6pmV2r6x154Hrzt7op861DA5nS7TXzkCDyTienS9Ue4qcBd+KanDfinC
         RcNTdWoVnBa2qxp5RbLXRpFEAQke4YWRfoEZyqfc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231115095855epcas2p14354327a7e66af69fe8e67d77e4b2bb3~Xw39HU9TH0959709597epcas2p1s;
        Wed, 15 Nov 2023 09:58:55 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.91]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SVdsq33l5z4x9Q3; Wed, 15 Nov
        2023 09:58:55 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.34.18994.F5694556; Wed, 15 Nov 2023 18:58:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231115095855epcas2p41cfb2254bb7f5908612267ab254bb985~Xw38aMxIi0464704647epcas2p4q;
        Wed, 15 Nov 2023 09:58:55 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231115095855epsmtrp1318f70161c222803c4f679b79950d8e6~Xw38ZTOz-2856328563epsmtrp1N;
        Wed, 15 Nov 2023 09:58:55 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-a5-6554965f2ef3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.B2.07368.E5694556; Wed, 15 Nov 2023 18:58:54 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231115095854epsmtip2ae1ea63cad25751c01692d17dd63ba66~Xw37-7N3p2749427494epsmtip2e;
        Wed, 15 Nov 2023 09:58:54 +0000 (GMT)
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
Subject: [PATCH v2 07/12] dt-bindings: arm: samsung: Document exynosautov920
 SADK board binding
Date:   Wed, 15 Nov 2023 18:56:03 +0900
Message-ID: <20231115095609.39883-8-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115095609.39883-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKJsWRmVeSWpSXmKPExsWy7bCmhW78tJBUg6NXRS0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
        0NLCXEkhLzE31VbJxSdA1y0zB+gdJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        eYFecWJucWleul5eaomVoYGBkSlQYUJ2xq6GM4wFH9krTnyaxtzAuJyti5GTQ0LAROLy0x1A
        NheHkMAeRon5F38yQzifGCW2Pe1ihXC+MUpM/vSeqYuRA6xlxn9ukG4hgb2MEovvO0LUfGSU
        OHNqCytIgk1AW+L7+sVgtojAfWaJ123VIEXMAu1MEvO+vWQBGSQskChxaLUSSA2LgKrElLbl
        LCA2r4CtRM/+CewQ58lL7Fn0HWwvp4CdROt5LYgSQYmTM5+AlTMDlTRvnQ12tITADQ6JNW09
        LBC9LhKXr+9nhrCFJV4d3wI1U0riZX8blJ0t0T79DyuEXSFxccNsaLAYS8x61s4IspdZQFNi
        /S59iNeVJY7cglrLJ9Fx+C87RJhXoqNNCKJRTeL+1HNQQ2QkJh1ZyQRhe0i8e/8dGs4TGSVO
        LJ7BOIFRYRaSb2Yh+WYWwuIFjMyrGKVSC4pz01OTjQoMdfNSy+FRnJyfu4kRnL61fHcwvl7/
        V+8QIxMH4yFGCQ5mJRFec7mQVCHelMTKqtSi/Pii0pzU4kOMpsDgnsgsJZqcD8wgeSXxhiaW
        BiZmZobmRqYG5krivPda56YICaQnlqRmp6YWpBbB9DFxcEo1MEUcenS/3uty2Uef5AiNr3/2
        S/LnVdhanf3778F3PZv2z7KL1dk1efdvZ2t27ZY3uny8jOHfC7PHNQt7eZmSEmc+X/n656/t
        3x8/n5T7/HG+W2j0s4yTzKbib/77iR3Za7LIJ0q2drPEV92GySeu/t+jtn5OuG4E342diz2n
        fnDMbpS4vvaU8qrcZWtuKU24KOET/7/HcRp3fl2d5haNf9ZX3U6vLo4Oq+YP3ZhyuGmvErdY
        vfejdWI2PQXTXIpNt9zpYj/8+dBe06R2z4YXb07nPPj3chdv96LMA2m3IgJkzViCZnPlbDB4
        F5/9O0XT6mVc+O3zyRJLS2cb31Ir3/3yg8a+2btintZM/2mwbr4SS3FGoqEWc1FxIgBfEWx4
        aAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXjduWkiqwc6DFhYP5m1js1iz9xyT
        xfwj51gtmhevZ7PY0XCE1eLdXBmLva+3sltM+bOcyWLT42usFpvn/2G0uLxrDpvF3burGC1m
        nN/HZHFmcS+7ReveI+wWh9+0s1r83DWPxWLVLqC62xMnMzoIe+ycdZfdY9OqTjaPO9f2sHns
        n7uG3WPzknqP/r8GHn1bVjF6fN4kF8ARxWWTkpqTWZZapG+XwJWxq+EMY8FH9ooTn6YxNzAu
        Z+ti5OCQEDCRmPGfu4uRi0NIYDejxJuLHUxdjJxAcRmJ5c/62CBsYYn7LUdYQWwhgfeMEgv+
        GYPYbALaEt/XL2YFaRYReM4scfbPI2aQBLNAP5PE9U0JILawQLzEvzsXweIsAqoSU9qWs4DY
        vAK2Ej37J7BDLJCX2LPoOxPIQZwCdhKt57UgdtlKtO7+wQxRLihxcuYTFojx8hLNW2czT2AU
        mIUkNQtJagEj0ypGydSC4tz03GTDAsO81HK94sTc4tK8dL3k/NxNjOAY09LYwXhv/j+9Q4xM
        HIyHGCU4mJVEeM3lQlKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xrOmJ0iJJCeWJKanZpakFoE
        k2Xi4JRqYIpqmmvSYW//+My09af+/pL8cfPrXpFL0VfEe7UCL/MtKXXXZznx9eiu6WsS/B4W
        hYZoGip3P43QPTRL+05HesBi9uo1q7nWnPy2++bqiXtU1YO2L9/5f7PE/lS3BaXRew6/vrr2
        6QalY9GmHEuYD3GmRGy5vWji7qX3q1/PPLFBaMuKde/FJDVeWmv482bMfrRxzw+zTK1N3mah
        cp/PqTf08C9YeSL4ddSysA0hrMnVarJ1kXyxtxUST936bsjnULVhp1T/r5C9pw9s0F/NukGb
        k4Nnit/pJv9NzzvUGWX/hF4S5WOVyt0SsXCy/k3jnQ+duT/Y+rRU7Xfbua7caKLeHc7JCzNs
        ZIuP/45/NDtTiaU4I9FQi7moOBEAztoSiCADAAA=
X-CMS-MailID: 20231115095855epcas2p41cfb2254bb7f5908612267ab254bb985
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231115095855epcas2p41cfb2254bb7f5908612267ab254bb985
References: <20231115095609.39883-1-jaewon02.kim@samsung.com>
        <CGME20231115095855epcas2p41cfb2254bb7f5908612267ab254bb985@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the ExynosAutov920 SADK(Samsung Automotive Development Kit)
board.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index e3ffd8159ab6..01dcbd8aa703 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -230,6 +230,12 @@ properties:
               - samsung,exynosautov9-sadk   # Samsung Exynos Auto v9 SADK
           - const: samsung,exynosautov9
 
+      - description: Exynos Auto v920 based boards
+        items:
+          - enum:
+              - samsung,exynosautov920-sadk   # Samsung Exynos Auto v920 SADK
+          - const: samsung,exynosautov920
+
 required:
   - compatible
 
-- 
2.42.0


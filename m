Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552157EC01D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbjKOJ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbjKOJ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:59:09 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124FD19D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:59:04 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231115095856epoutp0485e6167cd40c3170a633450feee3636c~Xw39n6Dsl1018910189epoutp04c
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:58:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231115095856epoutp0485e6167cd40c3170a633450feee3636c~Xw39n6Dsl1018910189epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700042336;
        bh=bbHXku4ZiHfkwlGr3C6CnzWmWtT5dLDt3t2VFYzVqSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u4t+n0RHF23oYOAF5WzpY0GhkbfdT6QX7L9RhCbNQki87mLjQzVJpvX69IjieEhT9
         B0tyLHf0fTwR9NJaY7QkgRKB6fhm9sYkIlTYDR2qj4EDHz7Zps7+1+0uEnh2TRnvq6
         kYeuE7oToOsyW27feMHqgOD9Ugs7xvn4PkGhgycs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231115095855epcas2p43473f1a57f2126a956d633cfe81b27a4~Xw39F5B3_0940109401epcas2p4s;
        Wed, 15 Nov 2023 09:58:55 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SVdsq1VhSz4x9Py; Wed, 15 Nov
        2023 09:58:55 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.B1.09607.F5694556; Wed, 15 Nov 2023 18:58:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231115095854epcas2p457e0eedcd0b4a001eba8fba012f73920~Xw38KhuRm0464704647epcas2p4o;
        Wed, 15 Nov 2023 09:58:54 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231115095854epsmtrp1fd1a95164770b56dff6bbded45f63949~Xw38JvmgV2856328563epsmtrp1M;
        Wed, 15 Nov 2023 09:58:54 +0000 (GMT)
X-AuditID: b6c32a48-bcdfd70000002587-6f-6554965f2110
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.F0.18939.E5694556; Wed, 15 Nov 2023 18:58:54 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231115095854epsmtip2a7108cf51124bbcca52237ddf8587f3e~Xw37uoCkA2332523325epsmtip2i;
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
Subject: [PATCH v2 06/12] dt-bindings: pinctrl: samsung: add exynosautov920
 binding
Date:   Wed, 15 Nov 2023 18:56:02 +0900
Message-ID: <20231115095609.39883-7-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115095609.39883-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmqW78tJBUgw8trBYP5m1js1iz9xyT
        xfwj51gtmhevZ7PY0XCE1eLdXBmLva+3sltM+bOcyWLT42usFpvn/2G0uLxrDpvF3burGC1m
        nN/HZHFmcS+7ReveI+wWh9+0s1r83DWPxWLVLqC62xMnMzoIe+ycdZfdY9OqTjaPO9f2sHns
        n7uG3WPzknqP/r8GHn1bVjF6fN4kF8ARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhr
        aGlhrqSQl5ibaqvk4hOg65aZA/SOkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA
        vECvODG3uDQvXS8vtcTK0MDAyBSoMCE7492RdvaCOXwVEz9fYm5g3M/dxcjJISFgIrF+8X+2
        LkYuDiGBHYwSXxbdYodwPjFKLDv9mBnOWfzsLCtMS8/q+0wgtpDATqCWA2EQRR8ZJW5cf8QC
        kmAT0Jb4vn4xWIOIwH1middt1SBFzALtTBLzvr0EKuLgEBYIlej9Uw1SwyKgKtGx+gAbiM0r
        YCvROmMRO8QyeYk9i74zgZRzCthJtJ7XgigRlDg58wnYKmagkuats8EOlRC4wCHxYutZJohe
        F4nbP45A2cISr45vgZopJfGyvw3KzpZon/4H6rEKiYsbZrNB2MYSs561M4LsZRbQlFi/Sx/E
        lBBQljhyC2otn0TH4b/sEGFeiY42IYhGNYn7U89BDZGRmHRkJdQBHhIrzu5mgoTUREaJvdse
        M05gVJiF5JtZSL6ZhbB4ASPzKkax1ILi3PTUYqMCE3j8JufnbmIEJ24tjx2Ms99+0DvEyMTB
        eIhRgoNZSYTXXC4kVYg3JbGyKrUoP76oNCe1+BCjKTCoJzJLiSbnA3NHXkm8oYmlgYmZmaG5
        kamBuZI4773WuSlCAumJJanZqakFqUUwfUwcnFINTNoes6XzjwdViy5ZUNi15PvfeJGI/pNu
        jBXeG8R+9m3aeS2Eq9K9yYCzyPWZdczdp/vtco+9XLhkcop7+yedZ1vfXZMItjm89VPbDHND
        XkW/l7kZPWyGC0+EVnCGGhvb7K6qvbPZoSz5XOT1u/M+brivx/Dz3swqp9Drqd2TY7T5qu77
        KT6a+aZc/mab889qy1af23aRJq82Tvllta6i+dT0ntVvvP+8XzTDPl1Q4Ky+2NHZJr5HLu9+
        FuuyvEc7Y9vk9V8UHH9Hq5hOuWXk/3LtglO5yr/ymhfHLOX5+vBL259T5WFZIitnyU3dc/dc
        m/oPid8l3sqPni4y4N5+J2TiM666GMl7Eg2BhtKNt5RYijMSDbWYi4oTAQsX7TVlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXjduWkiqQXODqsWDedvYLNbsPcdk
        Mf/IOVaL5sXr2Sx2NBxhtXg3V8Zi7+ut7BZT/ixnstj0+Bqrxeb5fxgtLu+aw2Zx9+4qRosZ
        5/cxWZxZ3Mtu0br3CLvF4TftrBY/d81jsVi1C6ju9sTJjA7CHjtn3WX32LSqk83jzrU9bB77
        565h99i8pN6j/6+BR9+WVYwenzfJBXBEcdmkpOZklqUW6dslcGW8O9LOXjCHr2Li50vMDYz7
        ubsYOTkkBEwkelbfZ+pi5OIQEtjOKNH74gcrREJGYvmzPjYIW1jifssRVoii94wSC+7eZAdJ
        sAloS3xfvxgsISLwnFni7J9HzCAJZoF+JonrmxJAbGGBYImn06aCTWURUJXoWH0AbCqvgK1E
        64xF7BAb5CX2LPoOdAYHB6eAnUTreS2QsBBIye4fzBDlghInZz5hgRgvL9G8dTbzBEaBWUhS
        s5CkFjAyrWIUTS0ozk3PTS4w1CtOzC0uzUvXS87P3cQIji+toB2My9b/1TvEyMTBeIhRgoNZ
        SYTXXC4kVYg3JbGyKrUoP76oNCe1+BCjNAeLkjivck5nipBAemJJanZqakFqEUyWiYNTqoGp
        /YJRyL+3C+8eV/V0/il54oXg8aUufCfzp98r+8Tbs0mh+Pnvryeb9/Bmy4W9zj41aX/QnL23
        Q6puPt8ZzXBAXvAd+5HAO9OCziy1fPt0zaP/nzfLHK8UPW+7Q1BiT6F++JM71vubOj77rjl9
        b9r7i5+iPy8JXfXmhkPKUcl8seXTkpQ8xUW5T0+7xfvDINlSp/Fyxo/Jaza2nP9S6v/gjqNy
        6f4TX/bO4Rb49J/Z+MQ/fi73fTW8ZTbP99hpT3PaGME2O+2w0M13V4/0a/hfWy62MfKeVkCm
        3qL98e+fLr+afGheW/itr7Vet8RdRV6ce/nS0uhmw0bb+89OBdUaZEgul10rdWDilJOqHnee
        +T1UYinOSDTUYi4qTgQAc7lY6R4DAAA=
X-CMS-MailID: 20231115095854epcas2p457e0eedcd0b4a001eba8fba012f73920
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231115095854epcas2p457e0eedcd0b4a001eba8fba012f73920
References: <20231115095609.39883-1-jaewon02.kim@samsung.com>
        <CGME20231115095854epcas2p457e0eedcd0b4a001eba8fba012f73920@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for exynosautov920 pin controller.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 .../bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml      | 2 ++
 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
index 1c07af24d6cf..1b75abebb953 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
@@ -38,6 +38,7 @@ properties:
           - samsung,exynos7-wakeup-eint
           - samsung,exynos850-wakeup-eint
           - samsung,exynosautov9-wakeup-eint
+          - samsung,exynosautov920-wakeup-eint
       - items:
           - enum:
               - samsung,exynos5433-wakeup-eint
@@ -105,6 +106,7 @@ allOf:
             enum:
               - samsung,exynos850-wakeup-eint
               - samsung,exynosautov9-wakeup-eint
+              - samsung,exynosautov920-wakeup-eint
     then:
       properties:
         interrupts: false
diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
index 7509dc36af93..9f04a0c76403 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
@@ -53,6 +53,7 @@ properties:
       - samsung,exynos7885-pinctrl
       - samsung,exynos850-pinctrl
       - samsung,exynosautov9-pinctrl
+      - samsung,exynosautov920-pinctrl
       - tesla,fsd-pinctrl
 
   interrupts:
-- 
2.42.0


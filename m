Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B766C7EC00A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjKOJ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjKOJ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:59:04 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8633121
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:58:58 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231115095855epoutp02a4ade5de66d092bdc146973aef7192ce~Xw38ls-hM0279502795epoutp025
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:58:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231115095855epoutp02a4ade5de66d092bdc146973aef7192ce~Xw38ls-hM0279502795epoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700042335;
        bh=hopgT6J43l7rW84P4tBjhgGiFDOitoS2F4ykAHwp7rI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBKFzW8tj81z0Sk9RcHApdj1qcXcgQ/CUD466qpFDsIDSstcOj6uaNlKH7V25alEC
         gJCm93c1M8fIbU8bThvEa16BKsRmslR0Yx/BFXCapmDq7e15W6GrJij524kWYXY6h7
         OJ6184+yWqmjLG0i1A48EHbBTig5m6bykb3HF+1Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231115095854epcas2p23e93dbc422aa3ec09a8ed64ba391fd4a~Xw373R7eE3041230412epcas2p2F;
        Wed, 15 Nov 2023 09:58:54 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.68]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SVdsp0lfyz4x9Pw; Wed, 15 Nov
        2023 09:58:54 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.B1.09607.D5694556; Wed, 15 Nov 2023 18:58:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231115095853epcas2p45e2c5fe8ac771555a25b434cf86895fd~Xw37CyxH80940109401epcas2p4i;
        Wed, 15 Nov 2023 09:58:53 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231115095853epsmtrp22022fe9e34e5e66147e70286fc58bc8c~Xw37B7q6m2554225542epsmtrp2c;
        Wed, 15 Nov 2023 09:58:53 +0000 (GMT)
X-AuditID: b6c32a48-bcdfd70000002587-6d-6554965d81d0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.F0.18939.D5694556; Wed, 15 Nov 2023 18:58:53 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231115095853epsmtip2522ff670d63eb152b9ff8433536c4976~Xw36km-312498624986epsmtip2e;
        Wed, 15 Nov 2023 09:58:53 +0000 (GMT)
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
Subject: [PATCH v2 02/12] dt-bindings: soc: samsung: exynos-pmu: add
 exynosautov920 compatible
Date:   Wed, 15 Nov 2023 18:55:58 +0900
Message-ID: <20231115095609.39883-3-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115095609.39883-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmmW7stJBUg60PbCwezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
        0NLCXEkhLzE31VbJxSdA1y0zB+gdJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        eYFecWJucWleul5eaomVoYGBkSlQYUJ2xp6X0xgLrrFVNHZ7NTCuYe1i5OSQEDCRuPOiB8wW
        EtjBKLHlQngXIxeQ/YlRYvqiB4wQCSDn7Fk2mIYLu/eyQBTtZJRoXNTOBlH0kVHix052EJtN
        QFvi+/rFYFNFBO4zS7xuqwZpYBZoZ5KY9+0lC0hCWCBB4sq+/UxdjBwcLAKqEuv+JYKEeQVs
        JXa+WA61TF5iz6LvYCWcAnYSree1IEoEJU7OfAI2hRmopHnrbGaQ8RICZzgk1j49ygjR6yIx
        899LZghbWOLV8S3sELaUxOd3e6HmZ0u0T/8DDYkKiYsbZkPFjSVmPWtnBNnLLKApsX6XPogp
        IaAsceQW1Fo+iY7Df9khwrwSHW1CEI1qEvennoMaIiMx6chKJogSD4npc/wh4TSRUaLhe+EE
        RoVZSH6ZheSXWQhrFzAyr2IUSy0ozk1PLTYqMIFHbXJ+7iZGcLrW8tjBOPvtB71DjEwcjIcY
        JTiYlUR4zeVCUoV4UxIrq1KL8uOLSnNSiw8xmgLDeSKzlGhyPjBj5JXEG5pYGpiYmRmaG5ka
        mCuJ895rnZsiJJCeWJKanZpakFoE08fEwSnVwBQ79fVh69UFDaU/Xz6zfHzjwQyB9Bs89d8r
        5VjdGSpVxUx8mFovan+UKq3U+K0xV5iJu+CgbC7/lZnhYvuutJ13vOAh/ddta26S2KuHlZN3
        vLXnFA1u53m3eE1nkNkUU8YHmx+fbU0LSpkkdeH3+jVBYeZFt10/PbHX/ru94kRZweydEzfZ
        lc0Utcpfo+13f73fsYVMhw62RX+62sykXPpn5+mZdxbu+2r9bPKjlAlLDm8/VvNWL/fNw7hX
        7Dyq7YtFFgnevcd91r6+6X3o7Ge3pu5fIZv6cU/ZvgPf5md/3nG2yG/Xl54GwR8Ne23/OvNl
        bSlmX8bO+tHclfnY+fNS5nETbfvyVns8EEjy/e2nxFKckWioxVxUnAgAOuctDmAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJXjd2Wkiqweur4hYP5m1js1iz9xyT
        xfwj51gtmhevZ7PY0XCE1eLdXBmLva+3sltM+bOcyWLT42usFpvn/2G0uLxrDpvF3burGC1m
        nN/HZHFmcS+7ReveI+wWh9+0s1r83DWPxWLVLqC62xMnMzoIe+ycdZfdY9OqTjaPO9f2sHns
        n7uG3WPzknqP/r8GHn1bVjF6fN4kF8ARxWWTkpqTWZZapG+XwJWx5+U0xoJrbBWN3V4NjGtY
        uxg5OSQETCQu7N7L0sXIxSEksJ1R4vuxjcwQCRmJ5c/62CBsYYn7LUdYIYreM0psef+CCSTB
        JqAt8X39YrCEiMBzZomzfx6BdTML9DNJXN+UAGILC8RJNFyZwt7FyMHBIqAqse5fIkiYV8BW
        YueL5VAL5CX2LPrOBFLCKWAn0XpeCyQsBFTSuvsHM0S5oMTJmU9YIKbLSzRvnc08gVFgFpLU
        LCSpBYxMqxhFUwuKc9NzkwsM9YoTc4tL89L1kvNzNzGCY0sraAfjsvV/9Q4xMnEwHmKU4GBW
        EuE1lwtJFeJNSaysSi3Kjy8qzUktPsQozcGiJM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamBS
        jLpZbbjkl6aX/Ium+enBH2z/3Dn/wlun5u+EuTPn97PdP71TTnXeLv21/jWHJRWv5N3yvdy4
        UTLzl2RfQYDzrv23Cl081rMcOvb0Qk7IC+9H/kn5D5q7jlU8eHt75fXDH0zY5jm0C/IoV1mG
        xC3aPNNGvf30qUOLrULLrSZLaMpdmcC5Wa/ZcPlEtqm3py45co2twEIwQcpJSYzza2zeuUXP
        30QWnKo84n3aO37LzO92G15t4CnbnqJ4/W/VV+OV6yNe6Uma/DJc86Hj1hlN5dR8ft7ESYrZ
        CT4XL3YdzLKLkOK5FPWgzLbu7K2N1VPPTFujk6Zz19nsSzObRbIn4ynzdZynuEUL3We8SnJQ
        YinOSDTUYi4qTgQAaZ8qVhwDAAA=
X-CMS-MailID: 20231115095853epcas2p45e2c5fe8ac771555a25b434cf86895fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231115095853epcas2p45e2c5fe8ac771555a25b434cf86895fd
References: <20231115095609.39883-1-jaewon02.kim@samsung.com>
        <CGME20231115095853epcas2p45e2c5fe8ac771555a25b434cf86895fd@epcas2p4.samsung.com>
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

Add samsung,exynosautov920-pmu compatible for representing
pmu of ExynosAutov920 SoC.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
index 6492e92586d9..28e2cb50d85e 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
@@ -52,6 +52,7 @@ properties:
           - enum:
               - samsung,exynos7885-pmu
               - samsung,exynosautov9-pmu
+              - samsung,exynosautov920-pmu
           - const: samsung,exynos7-pmu
           - const: syscon
       - items:
-- 
2.42.0


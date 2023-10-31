Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA2D7DCA0D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343524AbjJaJvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbjJaJu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:50:56 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4859E103
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:50:35 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231031095020epoutp01acb5b81af10e4951e5614c2763546a7f~TKFLeApht1093910939epoutp01S
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:50:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231031095020epoutp01acb5b81af10e4951e5614c2763546a7f~TKFLeApht1093910939epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698745820;
        bh=RpHmonSDQlt1oVj6XBnTm5cHqGi8TIpKRz9BwudepnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/V2Hx8v1VfnUrG5HMZ1PmLANOn0Yt7ARkRPIFqVQt8hQ717qFS0/wE+eM7aYpMjl
         Hn1wlafOgO827XlMZq45AczeZHwd7e6cLP9LmzPHdypgNm5bzLtlZPN/8KqitEITrN
         b0aLLVsutKmkWbH12/UV429aQ4Y4fsgrjcLCFrq8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231031095020epcas2p2f36e87b8e37b2b512d540707eeafb734~TKFK648n01547915479epcas2p2y;
        Tue, 31 Oct 2023 09:50:20 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.70]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SKQNq49mqz4x9Px; Tue, 31 Oct
        2023 09:50:19 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.95.09607.BDDC0456; Tue, 31 Oct 2023 18:50:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231031095018epcas2p2e73b59954e76b14c928b7cb94bc3ac60~TKFJtHQuK1310813108epcas2p2v;
        Tue, 31 Oct 2023 09:50:18 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231031095018epsmtrp21a1d2d642ff573d3263e74470ca55318~TKFJsI8m31473914739epsmtrp2A;
        Tue, 31 Oct 2023 09:50:18 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-60-6540cddbdfb2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.9E.18939.ADDC0456; Tue, 31 Oct 2023 18:50:18 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231031095017epsmtip1145573b5339db5250670c8c0f23270fb~TKFIsfAAI2314323143epsmtip14;
        Tue, 31 Oct 2023 09:50:17 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH 05/10] dt-bindings: pinctrl: samsung: add exynosautov920
 pinctrl binding
Date:   Tue, 31 Oct 2023 18:47:47 +0900
Message-ID: <20231031094852.118677-6-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031094852.118677-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmqe7tsw6pBp+75SwezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
        0NLCXEkhLzE31VbJxSdA1y0zB+gdJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        eYFecWJucWleul5eaomVoYGBkSlQYUJ2xqIDK1gKbvNWtPVdZm1gXMndxcjJISFgIvGv6wpL
        FyMXh5DADkaJY/OeskI4nxglmvb1M8I5S9s+MsK0zF/dwgZiCwnsZJTYsrcQougjo8TMhT/B
        EmwC2hLf1y9mBbFFBL4wS0x/VA1SxCzQziQx79tLFpCEsECUxJmXjWA2i4CqxJbdu8E28ArY
        Saxft4sVYpu8xJ5F35lAbE4Be4mdPU1QNYISJ2c+AetlBqpp3jqbGWSBhMAZDolFbUdZIJpd
        JBoPLWSHsIUlXh3fAmVLSXx+t5cNws6WaJ/+B2pZhcTFDbOh4sYSs561Ay3jAFqgKbF+lz6I
        KSGgLHHkFtRaPomOw3/ZIcK8Eh1tQhCNahL3p56DGiIjMenISiYI20Oi/f5/aLhNYpQ4vst4
        AqPCLCTPzELyzCyEvQsYmVcxiqUWFOempxYbFZjAIzg5P3cTIzh1a3nsYJz99oPeIUYmDsZD
        jBIczEoivIdNHVKFeFMSK6tSi/Lji0pzUosPMZoCg3ois5Rocj4we+SVxBuaWBqYmJkZmhuZ
        GpgrifPea52bIiSQnliSmp2aWpBaBNPHxMEp1cDEfaX88nOLk0qbZgXNtTjvXCq07dJsQd7m
        Ns+gCaYTzr5bwnzB6oV64s2fUXG9Oz87G19MvBh5/vI/E8PVAYxK5Rd3r+85lFZU3xdZVPHR
        bHvx/kVPfzGmvxG8+ex7pOVrm8Nir0zk2loi7PZdZ2tRec9xvmauW2NVZLl+iv/q3PMsJb9b
        ovyX6xl28/z8L3JFt7zh3BIm574Wy4YNgYIfRFPmZ1rGXXvIJdy64tayxPdVE/Q9Jb+susCd
        s1Y4d9OP93x5aUoMPnmvF/y9WLU31cvylWDTYinxKpOKe/Z3L2duMD9Rr/tPtmhfXPCcbc4H
        hOpO/TwhcS9yuuvDW04TPjvuajb38l0z84JGxX8lluKMREMt5qLiRABXs61SZgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTvfWWYdUg0kvDS0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjissmJTUnsyy1SN8ugStj0YEVLAW3eSva+i6zNjCu
        5O5i5OSQEDCRmL+6ha2LkYtDSGA7o8SDVbMZIRIyEsuf9bFB2MIS91uOsEIUvWeU+LRhFlgR
        m4C2xPf1i8ESIgK/mCV2T7gLlmAW6GeSuL4pAcQWFoiQmPNtAjuIzSKgKrFl926wGl4BO4n1
        63axQmyQl9iz6DsTiM0pYC+xs6cJrEYIqObihptMEPWCEidnPmGBmC8v0bx1NvMERoFZSFKz
        kKQWMDKtYhRNLSjOTc9NLjDUK07MLS7NS9dLzs/dxAiOMK2gHYzL1v/VO8TIxMF4iFGCg1lJ
        hPewqUOqEG9KYmVValF+fFFpTmrxIUZpDhYlcV7lnM4UIYH0xJLU7NTUgtQimCwTB6dUA5NO
        6yJ2he9lbzdYlJkkn57f8EfIRve6zBS/KcXTbvRzW+y+nsSiO83Zf1rKAxu7Oc1OTTzqxheE
        372aNJHleJnl1lWMx6+eK2mNXSX1cZ5oaNUWlZ5FIS/eFlZ3Tdz5TcPrq6DeYo9/YUtsZ+Xn
        B56bERM61+7d2QPRG+0mJHIo/mRiSI/+vIj10vL/sbZmCZkh816qXzi8gFHoQvr2l8v8vwXs
        c7KZp6NaJy17vqMj63sIk5Gevtst9avlCwQbVrMcW3fy6JLYqWeYotl/7P/gKbRg55SZXwr/
        Mhp+2/Bky7xA67OFByY97FGc+F6M72H0oX1TF6UdFS9xLPhqz5lz2i+rhpOrxks06M/zrl1K
        LMUZiYZazEXFiQCbLlc4HwMAAA==
X-CMS-MailID: 20231031095018epcas2p2e73b59954e76b14c928b7cb94bc3ac60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031095018epcas2p2e73b59954e76b14c928b7cb94bc3ac60
References: <20231031094852.118677-1-jaewon02.kim@samsung.com>
        <CGME20231031095018epcas2p2e73b59954e76b14c928b7cb94bc3ac60@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 1de91a51234d..e508499cc1f0 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
@@ -37,6 +37,7 @@ properties:
       - samsung,exynos7-wakeup-eint
       - samsung,exynos850-wakeup-eint
       - samsung,exynosautov9-wakeup-eint
+      - samsung,exynosautov920-wakeup-eint
 
   interrupts:
     description:
@@ -99,6 +100,7 @@ allOf:
             enum:
               - samsung,exynos850-wakeup-eint
               - samsung,exynosautov9-wakeup-eint
+              - samsung,exynosautov920-wakeup-eint
     then:
       properties:
         interrupts: false
diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
index 26614621774a..c2e6ff290df3 100644
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


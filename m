Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D1A755FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjGQJrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGQJrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:47:31 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5053123
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:47:27 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230717094723epoutp04adb505eb653835e4fc97bd4bb54856a5~ynqVWpATu0477204772epoutp04H
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:47:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230717094723epoutp04adb505eb653835e4fc97bd4bb54856a5~ynqVWpATu0477204772epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689587243;
        bh=hSqi/S35ojzEsEC+p5nu+EzlKrVijorLEKMPbYfHXpg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=K4cKYjgtCUEt9ufdWZfRB/AnHWTIUFbWgRe+ASecWcOe8LB5st4XFILg1iGls+3Ud
         Vjp4CHpN4U+vpHAb6jCXkKQ+Er+uA2hnkJB/HA0oQuWzd8Z24OV7O2oRTtf4VjvQnb
         HCDoTOzYAC0xrmnFwY+2tips9IK7u4CeyCw73D+U=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230717094722epcas2p297c26ec37231df8fd3bead09540ff81f~ynqU6Su_p1018810188epcas2p2z;
        Mon, 17 Jul 2023 09:47:22 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.98]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4R4HLL2jLrz4x9Pt; Mon, 17 Jul
        2023 09:47:22 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.59.55279.A2E05B46; Mon, 17 Jul 2023 18:47:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230717094721epcas2p238ffd2f218899dc3c43f3fe68a079c54~ynqUHDVwr0714307143epcas2p2F;
        Mon, 17 Jul 2023 09:47:21 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230717094721epsmtrp11dfc1c9e10223d1b1301c41c62ffc27a~ynqUGPqQu2680726807epsmtrp1h;
        Mon, 17 Jul 2023 09:47:21 +0000 (GMT)
X-AuditID: b6c32a43-557fb7000001d7ef-f1-64b50e2a5c96
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.0D.30535.92E05B46; Mon, 17 Jul 2023 18:47:21 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230717094721epsmtip2104abcd272e0805cd0afccce9cab3eee~ynqT4FX080585405854epsmtip2n;
        Mon, 17 Jul 2023 09:47:21 +0000 (GMT)
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
Subject: [PATCH v4 0/2] support PWM for exynosautov9
Date:   Mon, 17 Jul 2023 18:42:00 +0900
Message-Id: <20230717094202.18296-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmqa4W39YUg+sdghYP5m1js1iz9xyT
        xfwj51gtdjQcYbXoe/GQ2WLT42usFpd3zWGzuHt3FaPFjPP7mCxa9x5ht/i5ax6Lxe2Jkxkd
        eDx2zrrL7rFpVSebx51re9g8Ni+p9+j/a+DRt2UVo8fnTXIB7FHZNhmpiSmpRQqpecn5KZl5
        6bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAdyoplCXmlAKFAhKLi5X07WyK8ktL
        UhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjN+rzvLXvCdpeLhpG6WBsaf
        zF2MnBwSAiYS784uYuti5OIQEtjBKLH59UMo5xOjxOm3N6Gcb4wSH1+dYYRp6T68mAkisZdR
        omnvHlYI5yOjxPTOmywgVWwC2hLf1y9mBbFFBBYySTy7XwZSxCxwmlFi7a0nYEXCQKMen1oM
        dgmLgKrE5nOrwRp4BWwljt04wwqxTl5i9YYDzCDNEgL32CV+zu2ASrhIvN/8jAnCFpZ4dXwL
        O4QtJfGyvw3KzpZon/4Hqr5C4uKG2WwQtrHErGftQP9wAF2kKbF+lz6IKSGgLHHkFthpzAJ8
        Eh2H/7JDhHklOtqEIBrVJO5PPQc1REZi0pGVUAd4SPRtfQD2iZBArMS1HRPZJzDKzkKYv4CR
        cRWjWGpBcW56arJRgSE8lpLzczcxgtOelvMOxivz/+kdYmTiYDzEKMHBrCTC+33VphQh3pTE
        yqrUovz4otKc1OJDjKbA4JrILCWanA9MvHkl8YYmlgYmZmaG5kamBuZK4rz3WuemCAmkJ5ak
        ZqemFqQWwfQxcXBKNTDt5+aa/9vvhld1ZvyZ3m2b3Sun7Q8LmFn7omJGQu76pwU7uGKvfjs9
        /dPRLbJFL5qrjijK/fFolfd/1LZj18e9HNvkBTc5aZZM0Aj92DWrYGmoyDW9EMOPiW4smT8n
        nfoa2pnBtujX+n+Vxstt7y9jYlKPZJ8jceWxRfblYPMZ+1TO/zaYfSQvJsF1evvJUynPX1ZV
        9B9x3fNEVG++cUrsk8ZY35/JJmcslzqta5haINuyQZhjzvEbdRfOif/Z3P/KocijsVKtXeiU
        0IbSopiKi9O6q6fOmBG/6tPZD+karv/d9ijvnrlE4HjBt5/60Ys3JNSf4r4XcjDx+5c4Md8F
        rXO3tesxqwnemC3NL+eqxFKckWioxVxUnAgAEfojhAQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSvK4m39YUgzmz9CwezNvGZrFm7zkm
        i/lHzrFa7Gg4wmrR9+Ihs8Wmx9dYLS7vmsNmcffuKkaLGef3MVm07j3CbvFz1zwWi9sTJzM6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79H/18Cjb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4Mn6v
        O8te8J2l4uGkbpYGxp/MXYycHBICJhLdhxczdTFycQgJ7GaU+PBlCTtEQkZi+bM+NghbWOJ+
        yxFWiKL3jBKHWz+zgiTYBLQlvq9fDJYQEVjMJPGm+yGYwyxwkVHixJ8rYKOEgXY8PrUYbB+L
        gKrE5nOrwbp5BWwljt04wwqxQl5i9YYDzBMYeRYwMqxilEwtKM5Nzy02LDDKSy3XK07MLS7N
        S9dLzs/dxAgORi2tHYx7Vn3QO8TIxMF4iFGCg1lJhPf7qk0pQrwpiZVVqUX58UWlOanFhxil
        OViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTBZ/rbfeExq8xfpR965v7533vAKmFo4uWn1
        6+fTI/h+nlr64LadP/ekOfverf9X8OuVdfmGntvxi5ab6S3Xk4vy0ZL6ILb3+BmTZ/uWHlut
        E6dj26Oz4sfvq14twl7lQb1Var8Kjq2X8udxeGCU93CvVfgDzfJzLyorA4Pi2o+9rpklZ+eQ
        pPsy1ufpgfMCO/MuSBo91k3fbREk+WmvZnpFsIKm2/0nQutYLv26J7PycMP3sPwjjYayrZuL
        n5o+0OY5u0hm6wNJ85ebjh1X+1/uYpUjwCDn9iRhkfWCrTOuN5ycNNPG7uUdu+v9Eun5zGq+
        eZPDTqy+ev5Z+pR0prXV9h5cp2+ZLL5i6Mc1v+yqEktxRqKhFnNRcSIAkZiUVrUCAAA=
X-CMS-MailID: 20230717094721epcas2p238ffd2f218899dc3c43f3fe68a079c54
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230717094721epcas2p238ffd2f218899dc3c43f3fe68a079c54
References: <CGME20230717094721epcas2p238ffd2f218899dc3c43f3fe68a079c54@epcas2p2.samsung.com>
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

Add pwm nodes to support PWM fan on exynosautov9-sadk board.

---
Changes in v4:
 - add document file.

Changes in v3:
 - removed adding compatible to driver.

Changes in v2:
 - add compatible string to driver.

Jaewon Kim (2):
  dt-bindings: pwm: samsung: add exynosautov9 compatible
  arm64: dts: exynos: add pwm node for exynosautov9-sadk

 .../devicetree/bindings/pwm/pwm-samsung.yaml     | 16 ++++++++++------
 arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts |  6 ++++++
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi     | 10 ++++++++++
 3 files changed, 26 insertions(+), 6 deletions(-)

-- 
2.17.1


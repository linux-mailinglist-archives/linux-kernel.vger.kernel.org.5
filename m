Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD7B79C66F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjILGGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjILGGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:06:49 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECBEE77
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:06:44 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230912060642epoutp013d25b75cc3e06cbf5722284b8a74f403~EEa7aVu_L0163201632epoutp01a
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:06:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230912060642epoutp013d25b75cc3e06cbf5722284b8a74f403~EEa7aVu_L0163201632epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694498802;
        bh=4bcw94gLGxDMnnKRk6uK6p6mnuHhueBZymKra7u5+yg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=hrc/iM8wEYKYUlvwoNsPNKt8zqCfohCznkIgCr6O4zqdqDjeOZryOalEt0WPAx+ck
         8PTVQIjD/11nsJYJ/+HzV2e1cm7tW6cAzHANeuX2oFz1XTltjVF565dG6aT8R1iOYD
         ObgQZphvbg5Ksz3n0+2ane2NfgeNwTdnYCa+3iO8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230912060641epcas2p162ecc6fb9bdabab137197d87fca8eea3~EEa6xBR-12481624816epcas2p1G;
        Tue, 12 Sep 2023 06:06:41 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.99]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RlClP1lXLz4x9Q1; Tue, 12 Sep
        2023 06:06:41 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.77.09660.1FFFFF46; Tue, 12 Sep 2023 15:06:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230912060640epcas2p43a9e6e11906d03641e76fb3df97462b8~EEa547k9Z1824418244epcas2p4X;
        Tue, 12 Sep 2023 06:06:40 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230912060640epsmtrp1999c83b72087890b491927e653b55e18~EEa529Cgb1194111941epsmtrp1X;
        Tue, 12 Sep 2023 06:06:40 +0000 (GMT)
X-AuditID: b6c32a47-d5dfa700000025bc-46-64fffff13a12
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.39.18916.0FFFFF46; Tue, 12 Sep 2023 15:06:40 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230912060640epsmtip1c23c5896519d7126e5219fb516eb67f6~EEa5NfEXc2007820078epsmtip1G;
        Tue, 12 Sep 2023 06:06:40 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH] arm64: dts: exynos: Use pinctrl macros for exynos5433-tm2
Date:   Tue, 12 Sep 2023 14:56:35 +0900
Message-ID: <20230912055635.49092-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdljTVPfj//8pBnsus1g8mLeNzWLN3nNM
        FvOPnGO12NFwhNWi78VDZotNj6+xWlzeNYfNYsb5fUwWrXuPsDtwemxa1cnmcefaHjaPzUvq
        Pfq2rGL0+LxJLoA1KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
        xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5e
        aomVoYGBkSlQYUJ2Rs/uC2wFzWwVLft2sjQwTmPtYuTkkBAwkXh++j07iC0ksINR4nNvTBcj
        F5D9iVFi9qrZjHDOzndXGWE6Zq/bA5XYySixctsOdgjnI6PE34NPwGaxCWhLfF+/mBUkISKw
        hlFi9afNLCAOs8AGRolj+1+AbRcW8JKY8GQjM4jNIqAq8e/bGbAdvAK2Eo3TVzND7JOX2LPo
        OxNEXFDi5MwnLCA2M1C8eetsqJpr7BLT2rghbBeJ7a8msEHYwhKvjm9hh7ClJF72t0HZ2RLt
        0/9AQ6BC4uKG2VD1xhKznrUD3cABNF9TYv0ufRBTQkBZ4sgtqK18Eh2H/7JDhHklOtqEIBrV
        JO5PPQc1REZi0pGVTBC2h8SvX8uYQcqFBGIlulutJzDKz0Lyyiwkr8xCWLuAkXkVo1hqQXFu
        emqxUYExPE6T83M3MYJTpJb7DsYZbz/oHWJk4mA8xCjBwawkwlty6G+KEG9KYmVValF+fFFp
        TmrxIUZTYOBOZJYSTc4HJum8knhDE0sDEzMzQ3MjUwNzJXHee61zU4QE0hNLUrNTUwtSi2D6
        mDg4pRqY9O2KPNtNw4J3y6rI1U6ULI3T6W8q2XZ/zcvzLApX4swULy+79m1LYYPnTOf+i39/
        zmrlf8n9+FbG2zMsIn/P7+sseOfcW3ZAgvGkxAM739cHF+TJ991+Xd6W1+Oc9ungmyneXGsO
        NWgKSNj8WLpbPi71ds6+Iz/5JNOSLL7Y5D2/3uD/b1H9kifrfkefem9YV2PR9ujFFTvjyOQs
        A9ETVvFLWsrXPunb7pp8wu3YzoysTXLLWM7efVDF8UKCu+C/7okzARwTz0t7zX60vbV3/cbF
        KZNVHD3cfQJl006pqQW7OJ+703Nhp2JBiVj+AtfT0161MLunlPe4nOWrMj5w7Mb5HeoM63Y9
        D9yWE26lxFKckWioxVxUnAgAF9yX4RoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSnO6H//9TDD590rF4MG8bm8WaveeY
        LOYfOcdqsaPhCKtF34uHzBabHl9jtbi8aw6bxYzz+5gsWvceYXfg9Ni0qpPN4861PWwem5fU
        e/RtWcXo8XmTXABrFJdNSmpOZllqkb5dAldGz+4LbAXNbBUt+3ayNDBOY+1i5OSQEDCRmL1u
        D2MXIxeHkMB2Ron1q+4yQyRkJJY/62ODsIUl7rccYYUoes8ocWznE0aQBJuAtsT39YvBEiIC
        6xglWr69BBvFLLCFUeLi8Wdg7cICXhITnmwEG8sioCrx79sZsG5eAVuJxumrodbJS+xZ9J0J
        Ii4ocXLmExYQmxko3rx1NvMERr5ZSFKzkKQWMDKtYhRNLSjOTc9NLjDUK07MLS7NS9dLzs/d
        xAgOWq2gHYzL1v/VO8TIxMF4iFGCg1lJhLfk0N8UId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzK
        OZ0pQgLpiSWp2ampBalFMFkmDk6pBqZNIQ86Q0qEsoskF7xjnef09LBm2pF/puvKLzapeLtK
        HZx5P/Vz+OO3KwJnPl83iVEq+KhpV0jSjau+yV82S88QPMImFFCRcztHjbF9GUe+8eV117vz
        NvfWB20+2N3a+GYm557O7viM3ZOVRB7t8uBZmDxn0cmKH+YPmg/kXPrYVCckrHr/a8dy94rg
        tp0cV3xz/Bkcn7lkl2u3Wn3e2LfqdsafSh8OHp/Y9c2TbBcEuYV/3hU0I333kjVP1hmcY+tS
        X6i9uuq58Ywt3FKz5ZXUihe65sQnP+fc8WFG8In5Ry5dWvVfoPF43jz33ewvp6c8PNDdWxJR
        /Ko74vgRq7J9K3gOTfUIFZKvK+T82KjEUpyRaKjFXFScCADM86RbyQIAAA==
X-CMS-MailID: 20230912060640epcas2p43a9e6e11906d03641e76fb3df97462b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230912060640epcas2p43a9e6e11906d03641e76fb3df97462b8
References: <CGME20230912060640epcas2p43a9e6e11906d03641e76fb3df97462b8@epcas2p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pinctrl macro instead of hard-coded number.
This makes the code more readable.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index d163891cd399..c2a9e59d36a0 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -1103,7 +1103,7 @@ initial_alive: initial-state {
 
 	te_irq: te-irq-pins {
 		samsung,pins = "gpf1-3";
-		samsung,pin-function = <0xf>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
 	};
 };
 
-- 
2.42.0


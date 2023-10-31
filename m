Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B177DC9EF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbjJaJuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjJaJug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:50:36 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774FEFD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:50:28 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231031095016epoutp03a8ba4cf56a203449ff27d23e47d775ab~TKFHWtTfo1157811578epoutp03d
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:50:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231031095016epoutp03a8ba4cf56a203449ff27d23e47d775ab~TKFHWtTfo1157811578epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698745816;
        bh=f+eG3CIC2Plg27fPLJc4QgCsVMHw3i2PoYyxHj/KQpc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rqFNF7rT4LevZWU8eiQz29c7i0Gku9zhQRB+R4LDmvGiMgSlYw5DRpuF0neyehVT0
         lHcrqNH7doalsshzDOXiNdjxevY6O4IaV+nVsm786T510czLsycPnohOnmBmWYpgHV
         BPS9JrXzcGhlsNY3bUKEGOBzJ85asfxqEpUv3iZw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231031095015epcas2p1f291e0f100a4d58694183e3ca63f1184~TKFG2V6EU0993809938epcas2p1j;
        Tue, 31 Oct 2023 09:50:15 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SKQNl2Q4xz4x9Pv; Tue, 31 Oct
        2023 09:50:15 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.95.09607.7DDC0456; Tue, 31 Oct 2023 18:50:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231031095014epcas2p2814fa2bb5f940ccb0d0951667df34f98~TKFF11lmE1547915479epcas2p2Y;
        Tue, 31 Oct 2023 09:50:14 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231031095014epsmtrp1cab88f028920d5ed826df45dae479e15~TKFF0sfGw2510325103epsmtrp1Y;
        Tue, 31 Oct 2023 09:50:14 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-52-6540cdd7522f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.11.08817.6DDC0456; Tue, 31 Oct 2023 18:50:14 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231031095013epsmtip1fe4d8fca1b9b45ad28fd0b758d4fbee9~TKFFD8EiG2325323253epsmtip1n;
        Tue, 31 Oct 2023 09:50:13 +0000 (GMT)
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
Subject: [PATCH 00/10] Introduce ExynosAutov920 SoC and SADK board
Date:   Tue, 31 Oct 2023 18:47:42 +0900
Message-ID: <20231031094852.118677-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xTVxjN7etrC67uUXRcCJnsEUAxQAsUrg4cYWqeigmiM5sZwYa+tEhp
        u7ZsbvtjTBQcOqEiiGXAaE1AwFVbYYVQIVDHHA4yJgxFELAhqYJBtll1YNby6uZ/5zv3nO/c
        7/7gYYKfOCG8PKWO1iglCpLjz+7o34Ri/vg1jRb+vPgGmq7v4KA2+xALNTiGcFRsMnOQrciB
        o8d1ocj+qJ2Lzi03sZDlwRiOrA3LAP3e9R0HTU62AFQzfJ2Fbpm+5aITdgcX9c+X4uh5Vz0b
        tXR5dBP6SpAWSHUaJrmUpeUbDnVvrJtD9dS1cSnrxa+o8hUhdeZaC6D+tLydyTuUnyKnJVJa
        E0Yrc1XSPKUsldyzP+f9HHGSUBQj2oKSyTClpIBOJbdnZMbszFN4xiHDPpUoCj1UpkSrJeO2
        pWhUhTo6TK7S6lJJWi1VqJPVsVpJgbZQKYtV0rqtIqEwXuwRHs6XuxaO4+pxwdHJcXYRuPpm
        GfDjQSIRtpoa8TLgzxMQNgCtnU42UywB6J6+4SueAjjS+zfnlWW65iHbiwWEHcDxaT4jegLg
        rPUxy7vAITZDt9mEe/E64i8Mnp/90ivCiFIWrH/qWnUHEumws2RstSubiIBL16dXeT6xDVa7
        WzEmbQPsNrpZDB8Ab15wrmowD1/cXot5m0LCxoMzF+bZjGE7PNb4zLfVQPhw4BqXwSHQVV7i
        w/mw9PwyzuCj8LcrtT59AjTMlYIywPMEbILmrjgvhEQ4dNz1xa6FJ/tXuAzNhydLBIwxEt6v
        GvI1CYVnHZdYDKZgT1MFzpxVNjzdZsYrwAbDa8MYXhvG8H/u9wBrAW/Ram2BjNbGqxP/u9Nc
        VYEFrD7oaMoGahcWY/sAiwf6AORh5Dp+vziNFvClks+/oDWqHE2hgtb2AbHnePVYyPpcledH
        KHU5osQtwsSkJFFyvFiYTAbxp07USQWETKKj82laTWte+Vg8v5AiVvYBZ/vQSNZ8TWXQzKxr
        reuqTZMyu2Y8fU2rcSdxp5I6sBRkv0zOGV3otrz6nN/w8O6v3bf+uR21z/rL4FSkiXTv2xFs
        KAfkB3sn7usXn0S92CrMCBefzr5rqYqcu7FLJKpIeHnHWKM3Jy6dUkTu+aHwZtGDHyt6P4vK
        qFXeC+9cj3PzS8LOOq6MaGY6mm1ZZ4z04McB+injxtaD0VFlzqbd6Qefy0T+HzZvfhncW9yQ
        Jv/k3YwBueWQc875LKD9FBFx/EU1HWHu2RF0xC4bXTAlvBNastA8agWGwUd1A43+A+8NYmnH
        9q50Z6Uf/iguOKFqZWJpdOORVrF05nJc/H45ydbKJaJoTKOV/As4v2dwWQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSnO61sw6pBu//qlk8mLeNzWLN3nNM
        FvOPnGO1aF68ns1iR8MRVot3c2Us9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWd++uYrSY
        cX4fk8WZxb3sFq17j7BbHH7Tzmrxc9c8FotVu4Dqbk+czOgg7LFz1l12j02rOtk87lzbw+ax
        f+4ado/NS+o9+v8aePRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfGy7ctrAU3hCru3mBpYNzI
        38XIySEhYCLxYMYrli5GLg4hgd2MErvmP2aGSMhILH/WxwZhC0vcbznCClH0nlFi4YkXYEVs
        AtoS39cvBkuICPxiltg94S4jSIJZoJ9J4vqmBBBbWMBJYmfbNbBJLAKqEp/2PWABsXkF7CSm
        fV8NtU1eYs+i70wQcUGJkzOfsEDMkZdo3jqbeQIj3ywkqVlIUgsYmVYxSqYWFOem5xYbFhjl
        pZbrFSfmFpfmpesl5+duYgTHjZbWDsY9qz7oHWJk4mA8xCjBwawkwnvY1CFViDclsbIqtSg/
        vqg0J7X4EKM0B4uSOO+3170pQgLpiSWp2ampBalFMFkmDk6pBqaUaT3L/vd1ys1M0awQOPtO
        dt0S9WdVKszl88xXTDOda3NUTMPIePejsuN9vN7xClf2KtQJaR64+UGqlGfurUMm/RqOq73d
        zhiKsDC2nb7/JjO332CBeMbKrsX5U6LOPPb33Vi0XK8oS2Oq49nu8oqvxp1MCxqnzbsb+f/8
        +b9uWc4zbjBebr0uu5iBZeOdSFExP+07jy6/t9dSm8g20X1bwoyO5deTuR7MaH0298Aazvv2
        p34xzVd9/pNhw3svKY4vneLhykxPJ6VfWP7iF8MV6UkJ03fOLeq8/4XRZ6Xsk/8epgfPHZ2S
        fWijkXdfp8a9WR1Zmy7LW5deOSRtdVYwzMZxQeDO8rkasRM+ydoqsRRnJBpqMRcVJwIAFeuF
        bgoDAAA=
X-CMS-MailID: 20231031095014epcas2p2814fa2bb5f940ccb0d0951667df34f98
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031095014epcas2p2814fa2bb5f940ccb0d0951667df34f98
References: <CGME20231031095014epcas2p2814fa2bb5f940ccb0d0951667df34f98@epcas2p2.samsung.com>
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

ExynosAutov920[1] is ARMv8-based automotive-oriented SoC.
This SoC is the next generation of exynosautov9 and AE(Automotive Enhanced)
IPs are used for safety.

This patchset is the minimal set to ExynosAutov920 SoC and SADK board.
Currently, ramdisk console is available and Clock, UFS, and USI will be
added after this patchset.

[1] : https://semiconductor.samsung.com/processor/automotive-processor/exynos-auto-v920/

Jaewon Kim (10):
  dt-bindings: soc: samsung: exynos-sysreg: add exynosautov920 sysreg
  dt-bindings: soc: samsung: usi: add exynosautov920-usi compatible
  dt-bindings: serial: samsung: add exynosautov920-uart compatible
  dt-bindings: pwm: samsung: add exynosautov9 compatible
  dt-bindings: pinctrl: samsung: add exynosautov920 pinctrl binding
  dt-bindings: arm: samsung: Document exynosautov920 SADK board binding
  soc: samsung: exynos-chipid: add exynosautov920 SoC support
  pinctrl: samsung: add exynosautv920 pinctrl
  arm64: dts: exynos: add initial support for exynosautov920 SoC
  arm64: dts: exynos: add minimal support for exynosautov920 sadk board

 .../bindings/arm/samsung/samsung-boards.yaml  |    6 +
 .../samsung,pinctrl-wakeup-interrupt.yaml     |    2 +
 .../bindings/pinctrl/samsung,pinctrl.yaml     |    1 +
 .../devicetree/bindings/pwm/pwm-samsung.yaml  |    1 +
 .../bindings/serial/samsung_uart.yaml         |    4 +-
 .../bindings/soc/samsung/exynos-usi.yaml      |    4 +-
 .../soc/samsung/samsung,exynos-sysreg.yaml    |    7 +
 arch/arm64/boot/dts/exynos/Makefile           |    3 +-
 .../dts/exynos/exynosautov920-pinctrl.dtsi    | 1266 +++++++++++++++++
 .../boot/dts/exynos/exynosautov920-sadk.dts   |   88 ++
 .../arm64/boot/dts/exynos/exynosautov920.dtsi |  318 +++++
 .../pinctrl/samsung/pinctrl-exynos-arm64.c    |  131 ++
 drivers/pinctrl/samsung/pinctrl-exynos.c      |   99 +-
 drivers/pinctrl/samsung/pinctrl-exynos.h      |   27 +
 drivers/pinctrl/samsung/pinctrl-samsung.c     |    5 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |   13 +
 drivers/soc/samsung/exynos-chipid.c           |    1 +
 17 files changed, 1966 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920.dtsi

-- 
2.42.0


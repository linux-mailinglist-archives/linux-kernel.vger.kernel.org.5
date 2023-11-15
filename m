Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195347EC00B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjKOJ7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjKOJ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:59:04 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A895912A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:58:58 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231115095854epoutp04b3d48215957fd9bbeaceea8e9340780e~Xw38EaGdu1018710187epoutp04Z
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:58:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231115095854epoutp04b3d48215957fd9bbeaceea8e9340780e~Xw38EaGdu1018710187epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700042334;
        bh=+xyxjTP8FlkiTMFrXXa0W/gjW4TDlH/6sRUSaQy2ih4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tTPlnTBxVI0HhCS3nkpdh0wXOQ7di9QVZx0XJBHvNR0z4hE5wXJoszhtrNkE20otP
         8PCSbAe+iVMqctdqFFWonbNS2/1td7wk8zsVmTMyqKpP6J3uw4c/h7QdhxxTSnSRuZ
         o7nSsFduyFa+QXpag7/CTRkQo8MTpaM9OjBnHL8c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231115095854epcas2p10dbad7d6683fff22c48dac482b4bf2fa~Xw37hGnKx0961209612epcas2p1m;
        Wed, 15 Nov 2023 09:58:54 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.101]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SVdsn3vVfz4x9Pw; Wed, 15 Nov
        2023 09:58:53 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.0D.09622.D5694556; Wed, 15 Nov 2023 18:58:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231115095852epcas2p21e067efe75275c6abd2aebf04c5c6166~Xw36fQ_Wl3241632416epcas2p2E;
        Wed, 15 Nov 2023 09:58:52 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231115095852epsmtrp238fa1f36703da144c5f3eeb63cab9209~Xw36eXIgI2554225542epsmtrp2b;
        Wed, 15 Nov 2023 09:58:52 +0000 (GMT)
X-AuditID: b6c32a46-d61ff70000002596-aa-6554965d8bf7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.B2.07368.C5694556; Wed, 15 Nov 2023 18:58:52 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231115095852epsmtip244f6135daaa656919ae8823313fbb2b5~Xw36BA7MM2498224982epsmtip2P;
        Wed, 15 Nov 2023 09:58:52 +0000 (GMT)
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
Subject: [PATCH v2 00/12] Introduce ExynosAutov920 SoC and SADK board
Date:   Wed, 15 Nov 2023 18:55:56 +0900
Message-ID: <20231115095609.39883-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmhW7stJBUg5M/xS0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
        0NLCXEkhLzE31VbJxSdA1y0zB+gdJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        eYFecWJucWleul5eaomVoYGBkSlQYUJ2xqtl/5gKzopVrHr9gL2B8bBQFyMnh4SAicSFn6uY
        uhi5OIQEdjBKbGi8wwLhfGKUWPZrG1TmG6PEz9WL2WBa1jXOZYdI7GWU+L+pFarqI6PEov07
        WUCq2AS0Jb6vX8wKYosI3GeWeN1WDVLELNDOJDHv20uwImEBV4nXH+eA2SwCqhJX350Ds3kF
        bCXudP5mhVgnL7Fn0XcmiLigxMmZT8BqmIHizVtnM4MMlRA4wyHxYetUdogGF4nJt+8yQdjC
        Eq+Ob4GKS0l8frcX6odsifbpf6AWVEhc3DAbKm4sMetZO2MXIwfQAk2J9bv0QUwJAWWJI7eg
        1vJJdBz+yw4R5pXoaIOGo5rE/annoIbISEw6shLqAA+Jkx37wBYJCcRKbLv3n2kCo/wsJM/M
        QvLMLIS9CxiZVzGKpRYU56anFhsVGMFjNTk/dxMjOElrue1gnPL2g94hRiYOxkOMEhzMSiK8
        5nIhqUK8KYmVValF+fFFpTmpxYcYTYHBO5FZSjQ5H5gn8kriDU0sDUzMzAzNjUwNzJXEee+1
        zk0REkhPLEnNTk0tSC2C6WPi4JRqYGLYcyzleflE9WYulhb1R1Wx3p8nvRUV/Bb2KHHJ9xtd
        S3+23TA/9Jqb++jGTd3HSz1kVvo+d3KbPV1s1uPtey+2G/zsWbPSjvHW+tLNEzIrzdI1ZkgZ
        lEZtf7xo8zVhO6XV67XPunadYde9snhins+nyUmZj0uavzabr9u9wUhn6/w1+5dJ6HNn/vxz
        aolMiofV05VmEptapqRtD2q3+/JQtHVhl43M6QkzmDvWmq1fMe0b8xrRHguOcz/lDihURDE0
        F7FpJ+bXVz0UyD8htjF35VKRP5Zvo8uDl7D+/8GVGyc8bWqT6cIFGyO6bFntFVqs2N10bSrW
        3z8ZX2LqKLHKtihTUVArUUbjxNNcZiWW4oxEQy3mouJEAGlteTxbBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXjdmWkiqwdkjehYP5m1js1iz9xyT
        xfwj51gtmhevZ7PY0XCE1eLdXBmLva+3sltM+bOcyWLT42usFpvn/2G0uLxrDpvF3burGC1m
        nN/HZHFmcS+7ReveI+wWh9+0s1r83DWPxWLVLqC62xMnMzoIe+ycdZfdY9OqTjaPO9f2sHns
        n7uG3WPzknqP/r8GHn1bVjF6fN4kF8ARxWWTkpqTWZZapG+XwJXxatk/poKzYhWrXj9gb2A8
        LNTFyMkhIWAisa5xLnsXIxeHkMBuRok/L6+wQSRkJJY/64OyhSXutxxhBbGFBN4zSsyZbQVi
        swloS3xfv5gVpFlE4DmzxNk/j5hBEswC/UwS1zclgNjCAq4Srz/OYQGxWQRUJa6+Owdm8wrY
        Stzp/M0KsUBeYs+i70wQcUGJkzOfANVwAM1Rl1g/TwhipLxE89bZzBMY+WchqZqFUDULSdUC
        RuZVjJKpBcW56bnJhgWGeanlesWJucWleel6yfm5mxjBMaalsYPx3vx/eocYmTgYDzFKcDAr
        ifCay4WkCvGmJFZWpRblxxeV5qQWH2KU5mBREuc1nDE7RUggPbEkNTs1tSC1CCbLxMEp1cD0
        MnCLUX5Si+mtosfKk9dPytvPFfFIp4Znotd/63tTJ6ysUdx1kCcrhPN56vFAKdtZLw9x7JvH
        vm9X8MN62bT9GvOmn7mwtVvRTGzdu9W/jevVLi7aZf9p021bR/Nce2U2toRJ6788Obs4j7cn
        ZlbUeUaZvgmHRQ3U26/aSqSZcv02X3yyg3fGtWy/Y0k2G88av/j87FLG/hu9db65K3fcT1rk
        J3JbKVi78s2d6ZNyFgqv7P1/uLAlJP9ls8OjpTxv5sy+L1Wiv05B8dBuEdH1Ukynjv6JXpSa
        986m+I7pr9csE1iKl7fsFpj4519rxKTd+6WMb3VZli0/2Dzr3uMHG3Y/5XTbtbPhSvXecwJ+
        PEosxRmJhlrMRcWJAE2o/okgAwAA
X-CMS-MailID: 20231115095852epcas2p21e067efe75275c6abd2aebf04c5c6166
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231115095852epcas2p21e067efe75275c6abd2aebf04c5c6166
References: <CGME20231115095852epcas2p21e067efe75275c6abd2aebf04c5c6166@epcas2p2.samsung.com>
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

ExynosAutov920[1] is ARMv8-based automotive-oriented SoC.
This SoC is the next generation of exynosautov9 and AE(Automotive Enhanced)
IPs are used for safety.

This patchset is the minimal set for ExynosAutov920 SoC and SADK board.
Currently, ramdisk console is available and Clock, UFS, and USI will be
added after this patchset.

[1] : https://semiconductor.samsung.com/processor/automotive-processor/exynos-auto-v920

---
Changes in v2:
 - Rebase to git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
             branch : for-v6.8/samsung-bindings-compatibles
 - Specific exynosautov920 compatible
 - Add dt-binding patch for pmu, chipid

Jaewon Kim (12):
  dt-bindings: soc: samsung: exynos-sysreg: add exynosautov920 sysreg
  dt-bindings: soc: samsung: exynos-pmu: add exynosautov920 compatible
  dt-bindings: soc: samsung: usi: add exynosautov920-usi compatible
  dt-bindings: serial: samsung: add exynosautov920-uart compatible
  dt-bindings: pwm: samsung: add exynosautov920 compatible
  dt-bindings: pinctrl: samsung: add exynosautov920 binding
  dt-bindings: arm: samsung: Document exynosautov920 SADK board binding
  dt-bindings: hwinfo: samsung,exynos-chipid: add exynosautov920
    compatible
  soc: samsung: exynos-chipid: add exynosautov920 SoC support
  pinctrl: samsung: add exynosautov920 pinctrl
  arm64: dts: exynos: add initial support for exynosautov920 SoC
  arm64: dts: exynos: add minimal support for exynosautov920 sadk board

 .../bindings/arm/samsung/samsung-boards.yaml  |    6 +
 .../hwinfo/samsung,exynos-chipid.yaml         |    1 +
 .../samsung,pinctrl-wakeup-interrupt.yaml     |    2 +
 .../bindings/pinctrl/samsung,pinctrl.yaml     |    1 +
 .../devicetree/bindings/pwm/pwm-samsung.yaml  |    1 +
 .../bindings/serial/samsung_uart.yaml         |    4 +-
 .../bindings/soc/samsung/exynos-pmu.yaml      |    1 +
 .../bindings/soc/samsung/exynos-usi.yaml      |    4 +-
 .../soc/samsung/samsung,exynos-sysreg.yaml    |    5 +
 arch/arm64/boot/dts/exynos/Makefile           |    3 +-
 .../dts/exynos/exynosautov920-pinctrl.dtsi    | 1266 +++++++++++++++++
 .../boot/dts/exynos/exynosautov920-sadk.dts   |   88 ++
 .../arm64/boot/dts/exynos/exynosautov920.dtsi |  312 ++++
 .../pinctrl/samsung/pinctrl-exynos-arm64.c    |  140 ++
 drivers/pinctrl/samsung/pinctrl-exynos.c      |  102 +-
 drivers/pinctrl/samsung/pinctrl-exynos.h      |   27 +
 drivers/pinctrl/samsung/pinctrl-samsung.c     |    5 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |   13 +
 drivers/soc/samsung/exynos-chipid.c           |    1 +
 19 files changed, 1972 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920.dtsi

-- 
2.42.0


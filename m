Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356DA809D94
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573330AbjLHHua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573283AbjLHHuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:50:22 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C5B1724
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:50:24 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231208075021epoutp0489c3ba02fb8f998643bde4b565d2f72c~ey9RM2tUx0920409204epoutp04g
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:50:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231208075021epoutp0489c3ba02fb8f998643bde4b565d2f72c~ey9RM2tUx0920409204epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702021821;
        bh=jf0IfkFwZ1DhJlD4BeDhp4v+pYjblUlZQuCAeIU8Emk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j7tdR86ukoJ/WT/emcDk7CDLozqYfjXopF/u8JqIs0fZ4kfY1z5CXeeFKpdRf32h1
         FONzztmKTa+jbI5JVr0vvfth7v+SoLWik1xpTggIUev/75mnrE0ybLE1oKT5QoX7mI
         lkRwMaQ9x+f/bgSAmFA0UGZuPYhVk4gSIb5nesYE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231208075021epcas2p384030ade76947fd563d54d1b9731ca12~ey9QpPT0x0598705987epcas2p3j;
        Fri,  8 Dec 2023 07:50:21 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Smjwr4m6Jz4x9Q7; Fri,  8 Dec
        2023 07:50:20 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.D3.10006.CBAC2756; Fri,  8 Dec 2023 16:50:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231208075020epcas2p30e46ea65e921664930b337510461892f~ey9Pqwdgm1398013980epcas2p3H;
        Fri,  8 Dec 2023 07:50:20 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231208075020epsmtrp121750879f0952f633efe0c28ae518131~ey9PppGt70202202022epsmtrp1z;
        Fri,  8 Dec 2023 07:50:20 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-7a-6572cabc8c6b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.40.18939.CBAC2756; Fri,  8 Dec 2023 16:50:20 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231208075019epsmtip22aa869371b7b30fef6916db6cafcccc5~ey9PVDIMi1340013400epsmtip2n;
        Fri,  8 Dec 2023 07:50:19 +0000 (GMT)
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
Subject: [PATCH v3 2/4] arm64: dts: exynos: add minimal support for
 exynosautov920 sadk board
Date:   Fri,  8 Dec 2023 16:45:25 +0900
Message-ID: <20231208074527.50840-3-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208074527.50840-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmhe6eU0WpBl8OqFg8mLeNzWLN3nNM
        FvOPnGO1aF68ns1iR8MRVot3c2Us9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWd++uYrSY
        cX4fk8WZxb3sFq17j7BbHH7Tzmrxc9c8FotVu4Dqbk+czOgg7LFz1l12j02rOtk87lzbw+ax
        f+4ado/NS+o9+v8aePRtWcXo8XmTXABHVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
        oaWFuZJCXmJuqq2Si0+ArltmDtA7SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC
        8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjI/9B9gKbopXdLw9xt7AOF+4i5GTQ0LAROLu9C2s
        XYxcHEICOxglji7ayg7hfGKUmPShhRnOOXLlADtMy6ftkxlBbCGBnYwSDw5yQBR9ZJS4P3s6
        WIJNQFvi+/rFrCC2iMB9ZonXbdUgRcwC7UwS8769ZAFJCAvES8xe9hHMZhFQlXjw8y/QOg4O
        XgFbidcP7SGWyUss3rGcGcTmFLCTWNC7A8zmFRCUODnzCVgrM1BN89bZYJdKCJzhkJjy7Qwz
        RLOLxPmX91ghbGGJV8e3QH0gJfGyvw3Kzpdou3IGyq6R2LjgEiOEbS8x6zcoYDiAFmhKrN+l
        D2JKCChLHLkFtZZPouPwX3aIMK9ER5sQRKOaxP2p59ggbBmJSUdWMkHYHhJPfi5igwTVREaJ
        15sPskxgVJiF5JtZSL6ZhbB4ASPzKkax1ILi3PTUYqMCQ3gEJ+fnbmIEp24t1x2Mk99+0DvE
        yMTBeIhRgoNZSYQ353x+qhBvSmJlVWpRfnxRaU5q8SFGU2BQT2SWEk3OB2aPvJJ4QxNLAxMz
        M0NzI1MDcyVx3nutc1OEBNITS1KzU1MLUotg+pg4OKUamFjkXcv+KZu2zzwQWWmbuthOJj/9
        tcIKm9+X8+48mXc/mC/JLlff3T4w9//GppvSn+8dT7+y9IW38j/7qcYv9Qp+bXtz/MP+1n8e
        U19ovmNYGzc3nUeiT7z32ZmCnfUfP96oPz5LSOyCn/j5Vfmf+nt+3NTWS1qdXNPWqFMovXe2
        SPyMGZ8TWffvtk1f6bI2/olXZGhzb3J/QOaMP/+03TdP0EpnEQuo8GS+qf8pwP9OQNS1FYYd
        jva73LfahjGfmek3OamvW2+a9UTZ1suvJlybJXlbNn7S8XOzTrsaLjuyIvrizPLDSca5elsU
        b0v/lLp6seBgbY9t5I2q20li4aYv93XLnDmzWjiq7kKmvRJLcUaioRZzUXEiAM80zBJmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXnfPqaJUg7ZPzBYP5m1js1iz9xyT
        xfwj51gtmhevZ7PY0XCE1eLdXBmLva+3sltM+bOcyWLT42usFpvn/2G0uLxrDpvF3burGC1m
        nN/HZHFmcS+7ReveI+wWh9+0s1r83DWPxWLVLqC62xMnMzoIe+ycdZfdY9OqTjaPO9f2sHns
        n7uG3WPzknqP/r8GHn1bVjF6fN4kF8ARxWWTkpqTWZZapG+XwJXxsf8AW8FN8YqOt8fYGxjn
        C3cxcnJICJhIfNo+mRHEFhLYzijRcyseIi4jsfxZHxuELSxxv+UIaxcjF1DNe0aJl2fOgyXY
        BLQlvq9fDJYQEXjOLHH2zyNmkASzQD+TxPVNCSC2sECsRPuGF2AbWARUJR78/AtUw8HBK2Ar
        8fqhPcQCeYnFO5aDtXIK2Eks6N3BDHGQrcSarR3sIDavgKDEyZlPWCDGy0s0b53NPIFRYBaS
        1CwkqQWMTKsYRVMLinPTc5MLDPWKE3OLS/PS9ZLzczcxgqNLK2gH47L1f/UOMTJxMB5ilOBg
        VhLhzTmfnyrEm5JYWZValB9fVJqTWnyIUZqDRUmcVzmnM0VIID2xJDU7NbUgtQgmy8TBKdXA
        FD0xq1DxPo/Gp4LF9w8xzxcwdld5xd3n+9T+svBDJrZWSetIoWebP1q6HTNUW/dA9/yT865J
        qhEv+pwVrVxFbwXpvHrSFL3bbd2fsr7ie2siVeQFnjlJzn1Yuz9jvdlOBi2x1wd1TvTGls9Z
        P5vPPe9AxpYarpXv4lM/ffF7KrckUuiN3H4pwxWZP//mnrzF7bdgWd2XTQ8N7+/VnWK9RUby
        GPfK5BObupvjd/3ktY88d5HxnuxJL5f3zkctPsxY0OFxuNHD77OSQ5NL0YyqC68boi9+jVA4
        ++L9igXt81l1nTUUNxny21sZi6yqO8Mk4nTW9zXLsWsrv87n1nd4JSL8NKbTJWRn3YsGFZYX
        SizFGYmGWsxFxYkAOCExrx0DAAA=
X-CMS-MailID: 20231208075020epcas2p30e46ea65e921664930b337510461892f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231208075020epcas2p30e46ea65e921664930b337510461892f
References: <20231208074527.50840-1-jaewon02.kim@samsung.com>
        <CGME20231208075020epcas2p30e46ea65e921664930b337510461892f@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ExynosAutov920 SADK is ExynosAutov920 SoC based SADK(Samsung Automotive
Development Kit) board. It has 16GB(8GB + 8GB) LPDDR5 RAM and 256GB
(128GB + 128GB) UFS.

This is minimal support board device-tree.
 * Serial console
 * GPIO Key
 * PWM FAN

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 arch/arm64/boot/dts/exynos/Makefile           |  3 +-
 .../boot/dts/exynos/exynosautov920-sadk.dts   | 88 +++++++++++++++++++
 2 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts

diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/exynos/Makefile
index 6e4ba69268e5..da06e1a9456c 100644
--- a/arch/arm64/boot/dts/exynos/Makefile
+++ b/arch/arm64/boot/dts/exynos/Makefile
@@ -5,4 +5,5 @@ dtb-$(CONFIG_ARCH_EXYNOS) += \
 	exynos7-espresso.dtb		\
 	exynos7885-jackpotlte.dtb	\
 	exynos850-e850-96.dtb		\
-	exynosautov9-sadk.dtb
+	exynosautov9-sadk.dtb		\
+	exynosautov920-sadk.dtb
diff --git a/arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts b/arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts
new file mode 100644
index 000000000000..e250b5594b58
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung's ExynosAutov920 SADK board device tree source
+ *
+ * Copyright (c) 2023 Samsung Electronics Co., Ltd.
+ *
+ */
+
+/dts-v1/;
+#include "exynosautov920.dtsi"
+#include "exynos-pinctrl.h"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Samsung ExynosAutov920 SADK board";
+	compatible = "samsung,exynosautov920-sadk", "samsung,exynosautov920";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &serial_0;
+	};
+
+	chosen {
+		stdout-path = &serial_0;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x70000000>,
+		      <0x8 0x80000000 0x1 0xfba00000>,
+		      <0xa 0x00000000 0x2 0x00000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&key_wakeup &key_back>;
+
+		key-wakeup {
+			label = "KEY_WAKEUP";
+			linux,code = <KEY_WAKEUP>;
+			gpios = <&gpa0 0 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+
+		key-back {
+			label = "KEY_BACK";
+			linux,code = <KEY_BACK>;
+			gpios = <&gpp6 3 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&pinctrl_alive {
+	key_wakeup: key-wakeup-pins {
+		samsung,pins = "gpa0-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+	};
+};
+
+&pinctrl_peric1 {
+	key_back: key-back-pins {
+		samsung,pins = "gpp6-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+	};
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_tout0>;
+	status = "okay";
+};
+
+&serial_0 {
+	status = "okay";
+};
+
+&usi_0 {
+	samsung,clkreq-on; /* needed for UART mode */
+	status = "okay";
+};
+
+&xtcxo {
+	clock-frequency = <38400000>;
+};
-- 
2.43.0


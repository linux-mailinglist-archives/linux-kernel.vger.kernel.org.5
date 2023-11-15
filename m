Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684D07EC02C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjKOKAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjKOJ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:59:41 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F088A130
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:59:06 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231115095858epoutp043bdb827d494e542c39ecff9bf6d7558b~Xw3-Wi1_n1013610136epoutp04c
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:58:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231115095858epoutp043bdb827d494e542c39ecff9bf6d7558b~Xw3-Wi1_n1013610136epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700042338;
        bh=t5IrulBEYs/pAFYmxibKmCqgtb1DKb9WLtc5ml9R97Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VTQvtkhIzzFuRkcH1y7RGB6SnNKrAHeYT2J9IFLzs8X8Tbe6CFKnjPmjzEfmjBGAY
         nUvkvVGqzUnPHFNSif92Zn5+eCO9584Qi4Uko46NIFbSwWIfRZsz6uwoNQmKH/h9fW
         fQ/IeWL5QQm7Bn6l6sRVk6Nv/o9vsOz8bh2SOUcc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231115095857epcas2p465687eaa11fd45b71f5552e2697d14ac~Xw3_2QNBg0464704647epcas2p41;
        Wed, 15 Nov 2023 09:58:57 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.68]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SVdss0Kblz4x9Q6; Wed, 15 Nov
        2023 09:58:57 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.0D.09622.06694556; Wed, 15 Nov 2023 18:58:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20231115095856epcas2p189ef50d3e97656a92df6fef64414690c~Xw395_vIO0734707347epcas2p1R;
        Wed, 15 Nov 2023 09:58:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231115095856epsmtrp27a1fbbf4c2addad9c7a808eea63526ce~Xw394kGge2585825858epsmtrp2s;
        Wed, 15 Nov 2023 09:58:56 +0000 (GMT)
X-AuditID: b6c32a46-5d04aa8000002596-b7-6554966063cc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.F6.08755.06694556; Wed, 15 Nov 2023 18:58:56 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231115095856epsmtip232c3ccc608c345f749a2f8215284d513~Xw39cuzZe2498624986epsmtip2g;
        Wed, 15 Nov 2023 09:58:56 +0000 (GMT)
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
Subject: [PATCH v2 12/12] arm64: dts: exynos: add minimal support for
 exynosautov920 sadk board
Date:   Wed, 15 Nov 2023 18:56:08 +0900
Message-ID: <20231115095609.39883-13-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115095609.39883-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAJsWRmVeSWpSXmKPExsWy7bCmmW7CtJBUg2vXrS0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
        0NLCXEkhLzE31VbJxSdA1y0zB+gdJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        eYFecWJucWleul5eaomVoYGBkSlQYUJ2xpv3zYwFN8UrXnY8ZWtgnC/cxcjJISFgInF98yGm
        LkYuDiGBHYwSTy+fZoRwPjFK7Hh8Fsr5xiixoL8VqIwDrKXpmTtIt5DAXkaJ3c1eEDUfGSU2
        /bjMApJgE9CW+L5+MSuILSJwn1nidVs1SBGzQDuTxLxvL1lABgkLJEq0nQ4AqWERUJXYcf8a
        E4jNK2An8enfGxaI8+Ql9iz6DraXEyjeel4LokRQ4uTMJ2AlzEAlzVtnM0OU3+CQuDXJDMJ2
        kWjZsYYdwhaWeHV8C5QtJfH53V42CDtbon36H1YIu0Li4obZUHFjiVnP2hlB1jILaEqs36UP
        8bmyxJFbUFv5JDoO/2WHCPNKdLQJQTSqSdyfeg5qiIzEpCMrmSBsD4mJe3dDA3Mio8TGtb3M
        ExgVZiF5ZhaSZ2YhLF7AyLyKUSy1oDg3PbXYqMAIHrvJ+bmbGMFJW8ttB+OUtx/0DjEycTAe
        YpTgYFYS4TWXC0kV4k1JrKxKLcqPLyrNSS0+xGgKDOmJzFKiyfnAvJFXEm9oYmlgYmZmaG5k
        amCuJM57r3VuipBAemJJanZqakFqEUwfEwenVAOTkrsNa14x229BK5Xc3P/2PPdZGab5c629
        f1IjOaTwYPKjOw+nX1Tr6hWWEp3Oks7yqFbp2YvE6uj/6wyLTvRtzmEMOZIgcZtlWXyIXKPr
        M5XH31NXFi00fXFX7pb7IS2vygM7GX/df9kt2rXw6odPBq+51+5IjWG7usKMuYlzu+O6Ldx7
        ZIWYc7Q2BDawWdja39x5/02TxUre6dvn3c86+cHiS8uumrU83bpdWgmnrl7pWJKv/eDnqTcR
        ktra+zoze/Zcakrcy3V0c0O4hYZ1183PjgLnHjG1azBJTzu+4t5Wv9n7n9z9/C3zn3H8D/2z
        c/zvsmrVOn8VmbRV+Zoyv5Fx54UlF4wMyy3V9+kqsRRnJBpqMRcVJwIAngHRvGMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXjdhWkiqwZHTUhYP5m1js1iz9xyT
        xfwj51gtmhevZ7PY0XCE1eLdXBmLva+3sltM+bOcyWLT42usFpvn/2G0uLxrDpvF3burGC1m
        nN/HZHFmcS+7ReveI+wWh9+0s1r83DWPxWLVLqC62xMnMzoIe+ycdZfdY9OqTjaPO9f2sHns
        n7uG3WPzknqP/r8GHn1bVjF6fN4kF8ARxWWTkpqTWZZapG+XwJXx5n0zY8FN8YqXHU/ZGhjn
        C3cxcnBICJhIND1z72Lk4hAS2M0oseDNP9YuRk6guIzE8md9bBC2sMT9liOsEEXvGSXOv93M
        DJJgE9CW+L5+MVhCROA5s8TZP4/AEswC/UwS1zclgGwQFoiXeHdREiTMIqAqseP+NSYQm1fA
        TuLTvzcsEAvkJfYs+s4EUs4JFG89rwUSFhKwlWjd/YMZolxQ4uTMJywQ0+UlmrfOZp7AKDAL
        SWoWktQCRqZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBMaaluYNx+6oPeocYmTgY
        DzFKcDArifCay4WkCvGmJFZWpRblxxeV5qQWH2KU5mBREucVf9GbIiSQnliSmp2aWpBaBJNl
        4uCUamCq3eBy5bJfmnhma/SDOUdY+jjOTpWyWs13U2/VxONr7b4zbZkv33dBqNXqfb2w4c01
        nX//bl1z9u1K8/szKz88WJ2RGScWNnOPZlPZ4x3c2RM+VC7+//sDA7PO3xqWvc4sARv26p0o
        FmJtYNl6O+zPad7Xteor728v/jFrdUu7yJe7bTc/1XzW27amRFnr5QTmx+8v8ogkdlntftLv
        xHJo0fs2mfX1inXyQdcmLc27pOgfO61d8ZnZzXeNq+LEGJKvlW7ODHu5cePfZYYL/9axJa4K
        1krPP3Q4ePX35R35v1Q27p5m8+uYr4SX84GrsuYLeZeUdJd9O3JwZqrYnuRde5fN3bRgroTR
        27VLj7CIXlZiKc5INNRiLipOBADm9AgPIAMAAA==
X-CMS-MailID: 20231115095856epcas2p189ef50d3e97656a92df6fef64414690c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231115095856epcas2p189ef50d3e97656a92df6fef64414690c
References: <20231115095609.39883-1-jaewon02.kim@samsung.com>
        <CGME20231115095856epcas2p189ef50d3e97656a92df6fef64414690c@epcas2p1.samsung.com>
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
2.42.0


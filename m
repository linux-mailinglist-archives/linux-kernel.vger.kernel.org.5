Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A36E809D95
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573360AbjLHHui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573336AbjLHHuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:50:25 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DBC1727
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:50:24 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231208075022epoutp031b11f953dc9f77d5706262e84b4301dc~ey9RX6YKc2125421254epoutp03q
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:50:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231208075022epoutp031b11f953dc9f77d5706262e84b4301dc~ey9RX6YKc2125421254epoutp03q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702021822;
        bh=wZ3IgL77MeFZ/9Rrlhi5qs4UP9lzox12UM0NcMZooL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qW81/EyOnvDEEK6zKQoNvL2GKt4fZANS4e7W+XCcAegEcJf5Pn+IMOwihmx8LCJE7
         TiAxlTXlaa4x8mU26bKnadONkDYYl86s9myJLvL+xzJ2BRzC/IPJG3QPNGX4QwbVu5
         WS6K/ZsLYUffpEI93rzwgwDtZeY0I0/M3JzddBPk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231208075021epcas2p35557cf4d03306140ee83e537eb952207~ey9QqyiPm1005910059epcas2p3P;
        Fri,  8 Dec 2023 07:50:21 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.100]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Smjwr4Lzkz4x9Q7; Fri,  8 Dec
        2023 07:50:20 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.42.09607.CBAC2756; Fri,  8 Dec 2023 16:50:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231208075020epcas2p25f18d225f91f185085078461b290cb19~ey9PiNv510115601156epcas2p2k;
        Fri,  8 Dec 2023 07:50:20 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231208075020epsmtrp2fcd52ee5987a4e1af20988cdcb276507~ey9Pddxwn0097200972epsmtrp2B;
        Fri,  8 Dec 2023 07:50:20 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-74-6572cabcac2a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.40.18939.BBAC2756; Fri,  8 Dec 2023 16:50:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231208075019epsmtip2102249b5f7cfa7c95417f86450d62003~ey9PMHbPk1333813338epsmtip2Y;
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
Subject: [PATCH v3 1/4] arm64: dts: exynos: add initial support for
 exynosautov920 SoC
Date:   Fri,  8 Dec 2023 16:45:24 +0900
Message-ID: <20231208074527.50840-2-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208074527.50840-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRmVeSWpSXmKPExsWy7bCmqe6eU0WpBh93y1k8mLeNzWLN3nNM
        FvOPnGO1aF68ns1iR8MRVot3c2Us9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWd++uYrSY
        cX4fk8WZxb3sFq17j7BbHH7Tzmrxc9c8FotVu4Dqbk+czOgg7LFz1l12j02rOtk87lzbw+ax
        f+4ado/NS+o9+v8aePRtWcXo8XmTXABHVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
        oaWFuZJCXmJuqq2Si0+ArltmDtA7SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC
        8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjHmrpArunWKqaPzTzdrAOKObqYuRk0NCwETizsVP
        LF2MXBxCAjsYJVa//MAM4XxilJix9zGCc/0piAPRMnvxAUaIxE5GidcTNjNBOB8ZJbbv+gtW
        xSagLfF9/WJWEFtE4D6zxOu2apAiZoF2Jol5316ygCSEBSIkbk9aBtbAIqAq8brzAxuIzStg
        K9Hce48VYp28xOIdy8FqOAXsJBb07mCGqBGUODnzCdgcZqCa5q2zwW6VEDjDIbF79SVGiGYX
        ib2PFkHdLSzx6vgWdghbSuLzu71sEHa+RNuVM1DxGomNC2B67SVm/d4CdAQH0AJNifW79EFM
        CQFliSO3oNbySXQc/ssOEeaV6GgTgmhUk7g/9RzUcBmJSUdWQsPaQ6Lr939oiE5klFi/cy7z
        BEaFWUi+mYXkm1kIixcwMq9iFEstKM5NTy02KjCBx3Fyfu4mRnAC1/LYwTj77Qe9Q4xMHIyH
        GCU4mJVEeHPO56cK8aYkVlalFuXHF5XmpBYfYjQFhvVEZinR5HxgDskriTc0sTQwMTMzNDcy
        NTBXEue91zo3RUggPbEkNTs1tSC1CKaPiYNTqoHpwDpeXdnGSQFZWpPiclQNV6rZH0s+1DKX
        MbVpl8cMn/Y0v5DHDPcLbpaV7bace7M53HRrseDpZ6EHJx5WMPe4FrZ6t6D0b8FHZziP14s2
        5kktL916Ze3XVVsjhd3W2b/z2Nj3fHXz3c75FzT1hEUePW2Merd57c97asu7tste1zWNnLsk
        rXyWbODWoz0xXq0ODg11HYf7G56xv3t4bRKnLuOkmetM11RZv9y7yyZE86RI6ZF4ftskpW03
        TxqulpITdBOeUt39RPCBR2CW1fYYjbu9zN5eD+MfnH08w0f7+KtFl89bZ3/OtJk9VyJQxaW9
        46ZwxLq9CVu92IQYEv/udlGc9/oL4ymZhTbsaoVKLMUZiYZazEXFiQAGeIaxaQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXnf3qaJUg7Z2C4sH87axWazZe47J
        Yv6Rc6wWzYvXs1nsaDjCavFurozF3tdb2S2m/FnOZLHp8TVWi83z/zBaXN41h83i7t1VjBYz
        zu9jsjizuJfdonXvEXaLw2/aWS1+7prHYrFqF1Dd7YmTGR2EPXbOusvusWlVJ5vHnWt72Dz2
        z13D7rF5Sb1H/18Dj74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4MqYt0qq4N4pporGP92sDYwz
        upm6GDk5JARMJGYvPsAIYgsJbGeUWLSwECIuI7H8WR8bhC0scb/lCGsXIxdQzXtGiYvzzrKA
        JNgEtCW+r18MlhAReM4scfbPI2aQBLNAP5PE9U0JILawQJjEvB3rwDawCKhKvO78ADaVV8BW
        orn3HivEBnmJxTuWg/VyCthJLOjdwQxxka3Emq0d7BD1ghInZz5hgZgvL9G8dTbzBEaBWUhS
        s5CkFjAyrWIUTS0ozk3PTS4w1CtOzC0uzUvXS87P3cQIjjCtoB2My9b/1TvEyMTBeIhRgoNZ
        SYQ353x+qhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe5ZzOFCGB9MSS1OzU1ILUIpgsEwenVAOT
        I6fkm4A/4TUHzAqXxjZlfOPh3MU+d1GR3apkk46CZ6eWZk9+LJ3xgmVFjv/nY4dbXJ+/Lqv5
        xvXanfP92n0HFPbEB6ctOhm0/VOp40/RqkOHpNR5dOw3P5M+aydiO2tz15yklZxTVtfq7jbe
        4P9VavWKtwWpLAslG7VynrQLiTBMzLEq71Pu3yd/XZGlKcjAujGDQfBK/Ww3XmWZzokC9orp
        AqUTqi1Yb21Kyvxi4ijFuNY2WED86Rzp4yWKrb6VO1h0rq5ou/hRMzNK6b6DX5lr/u8bz/uP
        vlu/muUYzxOG0O8dRye8unpEc1HJnfDcja//5vgYy/Tmux+6ultK99naNRdO1YW8M0viLFZi
        Kc5INNRiLipOBACyio4nHwMAAA==
X-CMS-MailID: 20231208075020epcas2p25f18d225f91f185085078461b290cb19
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231208075020epcas2p25f18d225f91f185085078461b290cb19
References: <20231208074527.50840-1-jaewon02.kim@samsung.com>
        <CGME20231208075020epcas2p25f18d225f91f185085078461b290cb19@epcas2p2.samsung.com>
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

Samsung ExynosAutov920 is ARMv8-based automotive-oriented SoC.
It has AE(Automotive Enhanced) IPs for safety.
 * Cortex-A78AE 10-cores
 * GIC-600AE

This is minimal support for ExynosAutov920 SoC.
 * Enumerate all pinctrl nodes
 * Enable Chip-Id
 * Serial0 for console
 * PWM

Since the clock driver is not yet implemented, it is supported as
fixed-clock.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 .../dts/exynos/exynosautov920-pinctrl.dtsi    | 1266 +++++++++++++++++
 .../arm64/boot/dts/exynos/exynosautov920.dtsi |  314 ++++
 2 files changed, 1580 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920.dtsi

diff --git a/arch/arm64/boot/dts/exynos/exynosautov920-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920-pinctrl.dtsi
new file mode 100644
index 000000000000..63b958b96c48
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynosautov920-pinctrl.dtsi
@@ -0,0 +1,1266 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung's ExynosAutov920 SoC pin-mux and pin-config device tree source
+ *
+ * Copyright (c) 2023 Samsung Electronics Co., Ltd.
+ *
+ * Samsung's ExynosAutov920 SoC pin-mux and pin-config options are listed as
+ * device tree nodes in this file.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#include "exynos-pinctrl.h"
+
+&pinctrl_alive {
+	gpa0: gpa0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpa1: gpa1-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpq0: gpq0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
+
+&pinctrl_aud {
+	gpb0: gpb0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb1: gpb1-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb2: gpb2-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb3: gpb3-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb4: gpb4-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb5: gpb5-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb6: gpb6-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
+
+&pinctrl_hsi0 {
+	gph0: gph0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gph1: gph1-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
+
+&pinctrl_hsi1 {
+	gph8: gph8-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
+
+&pinctrl_hsi2 {
+	gph3: gph3-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gph4: gph4-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gph5: gph5-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gph6: gph6-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
+
+&pinctrl_hsi2ufs {
+	gph2: gph2-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	ufs_rst_n: ufs-rst-n-pins {
+		samsung,pins = "gph2-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-con-pdn = <EXYNOS_PIN_PULL_DOWN>;
+	};
+
+	ufs_refclk_out: ufs-refclk-out-pins {
+		samsung,pins = "gph2-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-con-pdn = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	ufs_rst_n_1: ufs-rst-n-1-pins {
+		samsung,pins = "gph2-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-con-pdn = <EXYNOS_PIN_PULL_DOWN>;
+	};
+
+	ufs_refclk_out_1: ufs-refclk-out-1-pins {
+		samsung,pins = "gph2-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-con-pdn = <EXYNOS_PIN_PULL_DOWN>;
+	};
+};
+
+&pinctrl_peric0 {
+	gpp0: gpp0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpp1: gpp1-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpp2: gpp2-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpp3: gpp3-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpp4: gpp4-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg0: gpg0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg2: gpg2-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg3: gpg3-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg4: gpg4-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg5: gpg5-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	/* UART PERIC0_USI00 */
+	uart0_bus: uart0-bus-pins {
+		samsung,pins = "gpp0-0", "gpp0-1", "gpp0-2", "gpp0-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart0_bus_dual: uart0-bus-dual-pins {
+		samsung,pins = "gpp0-0", "gpp0-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* UART PERIC0_USI01 */
+	uart1_bus: uart1-bus-pins {
+		samsung,pins = "gpp0-4", "gpp0-5", "gpp0-6", "gpp0-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart1_bus_dual: uart1-bus-dual-pins {
+		samsung,pins = "gpp0-4", "gpp0-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* UART PERIC0_USI02 */
+	uart2_bus: uart2-bus-pins {
+		samsung,pins = "gpp1-0", "gpp1-1", "gpp1-2", "gpp1-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart2_bus_dual: uart2-bus-dual-pins {
+		samsung,pins = "gpp1-0", "gpp1-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* UART PERIC0_USI03 */
+	uart3_bus: uart3-bus-pins {
+		samsung,pins = "gpp1-4", "gpp1-5", "gpp1-6", "gpp1-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart3_bus_dual: uart3-bus-dual-pins {
+		samsung,pins = "gpp1-4", "gpp1-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* UART PERIC0_USI04 */
+	uart4_bus: uart4-bus-pins {
+		samsung,pins = "gpp2-0", "gpp2-1", "gpp2-2", "gpp2-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart4_bus_dual: uart4-bus-dual-pins {
+		samsung,pins = "gpp2-0", "gpp2-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* UART PERIC0_USI05 */
+	uart5_bus: uart5-bus-pins {
+		samsung,pins = "gpp2-4", "gpp2-5", "gpp2-6", "gpp2-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart5_bus_dual: uart5-bus-dual-pins {
+		samsung,pins = "gpp2-4", "gpp2-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* UART PERIC0_USI06 */
+	uart6_bus: uart6-bus-pins {
+		samsung,pins = "gpp3-0", "gpp3-1", "gpp3-2", "gpp3-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart6_bus_dual: uart6-bus-dual-pins {
+		samsung,pins = "gpp3-0", "gpp3-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* UART PERIC0_USI07 */
+	uart7_bus: uart7-bus-pins {
+		samsung,pins = "gpp3-4", "gpp3-5", "gpp3-6", "gpp3-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart7_bus_dual: uart7-bus-dual-pins {
+		samsung,pins = "gpp3-4", "gpp3-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* UART PERIC0_USI08 */
+	uart8_bus: uart8-bus-pins {
+		samsung,pins = "gpp4-0", "gpp4-1", "gpp4-2", "gpp4-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart8_bus_dual: uart8-bus-dual-pins {
+		samsung,pins = "gpp4-0", "gpp4-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI00  */
+	hsi2c0_bus: hsi2c0-bus-pins {
+		samsung,pins = "gpp0-0", "gpp0-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI00_I2C */
+	hsi2c1_bus: hsi2c1-bus-pins {
+		samsung,pins = "gpp0-2", "gpp0-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI01 */
+	hsi2c2_bus: hsi2c2-bus-pins {
+		samsung,pins = "gpp0-4", "gpp0-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI01_I2C */
+	hsi2c3_bus: hsi2c3-bus-pins {
+		samsung,pins = "gpp0-6", "gpp0-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI02 */
+	hsi2c4_bus: hsi2c4-bus-pins {
+		samsung,pins = "gpp1-0", "gpp1-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI02_I2C */
+	hsi2c5_bus: hsi2c5-bus-pins {
+		samsung,pins = "gpp1-2", "gpp1-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI03 */
+	hsi2c6_bus: hsi2c6-bus-pins {
+		samsung,pins = "gpp1-4", "gpp1-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI03_I2C */
+	hsi2c7_bus: hsi2c7-bus-pins {
+		samsung,pins = "gpp1-6", "gpp1-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI04 */
+	hsi2c8_bus: hsi2c8-bus-pins {
+		samsung,pins = "gpp2-0", "gpp2-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI04_I2C */
+	hsi2c9_bus: hsi2c9-bus-pins {
+		samsung,pins = "gpp2-2", "gpp2-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI05 */
+	hsi2c10_bus: hsi2c10-bus-pins {
+		samsung,pins = "gpp2-4", "gpp2-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI05_I2C */
+	hsi2c11_bus: hsi2c11-bus-pins {
+		samsung,pins = "gpp2-6", "gpp2-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI06 */
+	hsi2c12_bus: hsi2c12-bus-pins {
+		samsung,pins = "gpp3-0", "gpp3-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI06_I2C */
+	hsi2c13_bus: hsi2c13-bus-pins {
+		samsung,pins = "gpp3-2", "gpp3-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI07 */
+	hsi2c14_bus: hsi2c14-bus-pins {
+		samsung,pins = "gpp3-4", "gpp3-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI07_I2C */
+	hsi2c15_bus: hsi2c15-bus-pins {
+		samsung,pins = "gpp3-6", "gpp3-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI08 */
+	hsi2c16_bus: hsi2c16-bus-pins {
+		samsung,pins = "gpp4-0", "gpp4-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC0 USI08_I2C */
+	hsi2c17_bus: hsi2c17-bus-pins {
+		samsung,pins = "gpp4-2", "gpp4-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC0 USI00 */
+	spi0_bus: spi0-bus-pins {
+		samsung,pins = "gpp0-0", "gpp0-1", "gpp0-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi0_cs: spi0-cs-pins {
+		samsung,pins = "gpp0-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi0_cs_func: spi0-cs-func-pins {
+		samsung,pins = "gpp0-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC0 USI01 */
+	spi1_bus: spi1-bus-pins {
+		samsung,pins = "gpp0-4", "gpp0-5", "gpp0-6";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi1_cs: spi1-cs-pins {
+		samsung,pins = "gpp0-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi1_cs_func: spi1-cs-func-pins {
+		samsung,pins = "gpp0-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC0 USI02 */
+	spi2_bus: spi2-bus-pins {
+		samsung,pins = "gpp1-0", "gpp1-1", "gpp1-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi2_cs: spi2-cs-pins {
+		samsung,pins = "gpp1-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi2_cs_func: spi2-cs-func-pins {
+		samsung,pins = "gpp1-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC0 USI03 */
+	spi3_bus: spi3-bus-pins {
+		samsung,pins = "gpp1-4", "gpp1-5", "gpp1-6";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi3_cs: spi3-cs-pins {
+		samsung,pins = "gpp1-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi3_cs_func: spi3-cs-func-pins {
+		samsung,pins = "gpp1-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC0 USI04 */
+	spi4_bus: spi4-bus-pins {
+		samsung,pins = "gpp2-0", "gpp2-1", "gpp2-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi4_cs: spi4-cs-pins {
+		samsung,pins = "gpp2-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi4_cs_func: spi4-cs-func-pins {
+		samsung,pins = "gpp2-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC0 USI05 */
+	spi5_bus: spi5-bus-pins {
+		samsung,pins = "gpp2-4", "gpp2-5", "gpp2-6";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi5_cs: spi5-cs-pins {
+		samsung,pins = "gpp2-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi5_cs_func: spi5-cs-func-pins {
+		samsung,pins = "gpp2-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC0 USI06 */
+	spi6_bus: spi6-bus-pins {
+		samsung,pins = "gpp3-0", "gpp3-1", "gpp3-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi6_cs: spi6-cs-pins {
+		samsung,pins = "gpp3-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi6_cs_func: spi6-cs-func-pins {
+		samsung,pins = "gpp3-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC0 USI07 */
+	spi7_bus: spi7-bus-pins {
+		samsung,pins = "gpp3-4", "gpp3-5", "gpp3-6";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi7_cs: spi7-cs-pins {
+		samsung,pins = "gpp3-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi7_cs_func: spi7-cs-func-pins {
+		samsung,pins = "gpp3-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC0 USI08 */
+	spi8_bus: spi8-bus-pins {
+		samsung,pins = "gpp4-0", "gpp4-1", "gpp4-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi8_cs: spi8-cs-pins {
+		samsung,pins = "gpp4-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi8_cs_func: spi8-cs-func-pins {
+		samsung,pins = "gpp4-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I3C PERIC0 */
+	i3c0_bus: i3c0-bus-pins {
+		samsung,pins = "gpp2-6", "gpp2-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	i3c1_bus: i3c1-bus-pins {
+		samsung,pins = "gpp3-2", "gpp3-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	i3c2_bus: i3c2-bus-pins {
+		samsung,pins = "gpp3-6", "gpp3-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	i3c3_bus: i3c3-bus-pins {
+		samsung,pins = "gpp4-2", "gpp4-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* PWM PERIC0 */
+	pwm_tout0: pwm-tout0-pins {
+		samsung,pins = "gpg0-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	pwm_tout1: pwm-tout1-pins {
+		samsung,pins = "gpg0-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	pwm_tout2: pwm-tout2-pins {
+		samsung,pins = "gpg0-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	pwm_tout3: pwm-tout3-pins {
+		samsung,pins = "gpg0-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+};
+
+&pinctrl_peric1 {
+	gpp5: gpp5-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpp6: gpp6-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpp7: gpp7-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpp8: gpp8-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpp9: gpp9-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpp10: gpp10-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpp11: gpp11-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpp12: gpp12-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg1: gpg1-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	/* UART PERIC1 USI09 */
+	uart9_bus: uart9-bus-pins {
+		samsung,pins = "gpp5-0", "gpp5-1", "gpp5-2", "gpp5-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart9_bus_dual: uart9-bus-dual-pins {
+		samsung,pins = "gpp5-0", "gpp5-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* UART PERIC1 USI10 */
+	uart10_bus: uart10-bus-pins {
+		samsung,pins = "gpp5-4", "gpp5-5", "gpp5-6", "gpp5-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart10_bus_dual: uart10-bus-dual-pins {
+		samsung,pins = "gpp5-4", "gpp5-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* UART PERIC1 USI11 */
+	uart11_bus: uart11-bus-pins {
+		samsung,pins = "gpp10-0", "gpp10-1", "gpp10-2", "gpp10-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart11_bus_dual: uart11-bus-dual-pins {
+		samsung,pins = "gpp10-0", "gpp10-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* UART PERIC1_USI12 */
+	uart12_bus: uart12-bus-pins {
+		samsung,pins = "gpp7-0", "gpp7-1", "gpp7-2", "gpp7-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart12_bus_dual: uart12-bus-dual-pins {
+		samsung,pins = "gpp7-0", "gpp7-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* UART PERIC1_USI13 */
+	uart13_bus: uart13-bus-pins {
+		samsung,pins = "gpp7-4", "gpp7-5", "gpp7-6", "gpp7-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart13_bus_dual: uart13-bus-dual-pins {
+		samsung,pins = "gpp7-4", "gpp7-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* UART PERIC1 USI14 */
+	uart14_bus: uart14-bus-pins {
+		samsung,pins = "gpp8-0", "gpp8-1", "gpp8-2", "gpp8-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart14_bus_dual: uart14-bus-dual-pins {
+		samsung,pins = "gpp8-0", "gpp8-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* UART PERIC1 USI15 */
+	uart15_bus: uart15-bus-pins {
+		samsung,pins = "gpp11-0", "gpp11-1", "gpp11-2", "gpp11-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart15_bus_dual: uart15-bus-dual-pins {
+		samsung,pins = "gpp11-0", "gpp11-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* UART PERIC1 USI16 */
+	uart16_bus: uart16-bus-pins {
+		samsung,pins = "gpp9-0", "gpp9-1", "gpp9-2", "gpp9-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart16_bus_dual: uart16-bus-dual-pins {
+		samsung,pins = "gpp9-0", "gpp9-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* UART PERIC1 USI17 */
+	uart17_bus: uart17-bus-pins {
+		samsung,pins = "gpp12-0", "gpp12-1", "gpp12-2", "gpp12-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	uart17_bus_dual: uart17-bus-dual-pins {
+		samsung,pins = "gpp12-0", "gpp12-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI09 */
+	hsi2c18_bus: hsi2c18-bus-pins {
+		samsung,pins = "gpp5-0", "gpp5-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI09_I2C */
+	hsi2c19_bus: hsi2c19-bus-pins {
+		samsung,pins = "gpp5-2", "gpp5-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI10 */
+	hsi2c20_bus: hsi2c20-bus-pins {
+		samsung,pins = "gpp5-4", "gpp5-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI10_I2C */
+	hsi2c21_bus: hsi2c21-bus-pins {
+		samsung,pins = "gpp5-6", "gpp5-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI11 */
+	hsi2c22_bus: hsi2c22-bus-pins {
+		samsung,pins = "gpp10-0", "gpp10-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI11_I2C */
+	hsi2c23_bus: hsi2c23-bus-pins {
+		samsung,pins = "gpp10-2", "gpp10-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI12 */
+	hsi2c24_bus: hsi2c24-bus-pins {
+		samsung,pins = "gpp7-0", "gpp7-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI12_I2C */
+	hsi2c25_bus: hsi2c25-bus-pins {
+		samsung,pins = "gpp7-2", "gpp7-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI13 */
+	hsi2c26_bus: hsi2c26-bus-pins {
+		samsung,pins = "gpp7-4", "gpp7-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI13_I2C */
+	hsi2c27_bus: hsi2c27-bus-pins {
+		samsung,pins = "gpp7-6", "gpp7-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI14 */
+	hsi2c28_bus: hsi2c28-bus-pins {
+		samsung,pins = "gpp8-0", "gpp8-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI14_I2C */
+	hsi2c29_bus: hsi2c29-bus-pins {
+		samsung,pins = "gpp8-2", "gpp8-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI15 */
+	hsi2c30_bus: hsi2c30-bus-pins {
+		samsung,pins = "gpp11-0", "gpp11-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI15_I2C */
+	hsi2c31_bus: hsi2c31-bus-pins {
+		samsung,pins = "gpp11-2", "gpp11-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI16 */
+	hsi2c32_bus: hsi2c32-bus-pins {
+		samsung,pins = "gpp9-0", "gpp9-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI16_I2C */
+	hsi2c33_bus: hsi2c33-bus-pins {
+		samsung,pins = "gpp9-2", "gpp9-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI17 */
+	hsi2c34_bus: hsi2c34-bus-pins {
+		samsung,pins = "gpp12-0", "gpp12-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I2C PERIC1 USI17_I2C */
+	hsi2c35_bus: hsi2c35-bus-pins {
+		samsung,pins = "gpp12-2", "gpp12-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC1 USI09 */
+	spi9_bus: spi9-bus-pins {
+		samsung,pins = "gpp5-0", "gpp5-1", "gpp5-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi9_cs: spi9-cs-pins {
+		samsung,pins = "gpp5-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi9_cs_func: spi9-cs-func-pins {
+		samsung,pins = "gpp5-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC1 USI10 */
+	spi10_bus: spi10-bus-pins {
+		samsung,pins = "gpp5-4", "gpp5-5", "gpp5-6";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi10_cs: spi10-cs-pins {
+		samsung,pins = "gpp5-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi10_cs_func: spi10-cs-func-pins {
+		samsung,pins = "gpp5-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC1 USI11 */
+	spi11_bus: spi11-bus-pins {
+		samsung,pins = "gpp10-0", "gpp10-1", "gpp10-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi11_cs: spi11-cs-pins {
+		samsung,pins = "gpp10-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi11_cs_func: spi11-cs-func-pins {
+		samsung,pins = "gpp10-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC1 USI12 */
+	spi12_bus: spi12-bus-pins {
+		samsung,pins = "gpp7-0", "gpp7-1", "gpp7-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi12_cs: spi12-cs-pins {
+		samsung,pins = "gpp7-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi12_cs_func: spi12-cs-func-pins {
+		samsung,pins = "gpp7-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC1 USI13 */
+	spi13_bus: spi13-bus-pins {
+		samsung,pins = "gpp7-4", "gpp7-5", "gpp7-6";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi13_cs: spi13-cs-pins {
+		samsung,pins = "gpp7-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi13_cs_func: spi13-cs-func-pins {
+		samsung,pins = "gpp7-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC1 USI14 */
+	spi14_bus: spi14-bus-pins {
+		samsung,pins = "gpp8-0", "gpp8-1", "gpp8-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi14_cs: spi14-cs-pins {
+		samsung,pins = "gpp8-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi14_cs_func: spi14-cs-func-pins {
+		samsung,pins = "gpp8-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC1 USI15 */
+	spi15_bus: spi15-bus-pins {
+		samsung,pins = "gpp11-0", "gpp11-1", "gpp11-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi15_cs: spi15-cs-pins {
+		samsung,pins = "gpp11-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi15_cs_func: spi15-cs-func-pins {
+		samsung,pins = "gpp11-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC1 USI16 */
+	spi16_bus: spi16-bus-pins {
+		samsung,pins = "gpp9-0", "gpp9-1", "gpp9-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi16_cs: spi16-cs-pins {
+		samsung,pins = "gpp9-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi16_cs_func: spi16-cs-func-pins {
+		samsung,pins = "gpp9-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* SPI PERIC1 USI17 */
+	spi17_bus: spi17-bus-pins {
+		samsung,pins = "gpp12-0", "gpp12-1", "gpp12-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi17_cs: spi17-cs-pins {
+		samsung,pins = "gpp12-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	spi17_cs_func: spi17-cs-func-pins {
+		samsung,pins = "gpp12-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* I3C PERIC1 */
+	i3c4_bus: i3c4-bus-pins {
+		samsung,pins = "gpp7-2", "gpp7-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	i3c5_bus: i3c5-bus-pins {
+		samsung,pins = "gpp7-6", "gpp7-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	i3c6_bus: i3c6-bus-pins {
+		samsung,pins = "gpp8-2", "gpp8-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	i3c7_bus: i3c7-bus-pins {
+		samsung,pins = "gpp11-2", "gpp11-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+};
diff --git a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
new file mode 100644
index 000000000000..8756df584b10
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung's ExynosAutov920 SoC device tree source
+ *
+ * Copyright (c) 2023 Samsung Electronics Co., Ltd.
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/samsung,exynos-usi.h>
+
+/ {
+	compatible = "samsung,exynosautov920";
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	interrupt-parent = <&gic>;
+
+	aliases {
+		pinctrl0 = &pinctrl_alive;
+		pinctrl1 = &pinctrl_aud;
+		pinctrl2 = &pinctrl_hsi0;
+		pinctrl3 = &pinctrl_hsi1;
+		pinctrl4 = &pinctrl_hsi2;
+		pinctrl5 = &pinctrl_hsi2ufs;
+		pinctrl6 = &pinctrl_peric0;
+		pinctrl7 = &pinctrl_peric1;
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a78-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	xtcxo: clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-output-names = "oscclk";
+	};
+
+	/*
+	 * FIXME: Keep the stub clock for serial driver, until proper clock
+	 * driver is implemented.
+	 */
+	clock_usi: clock-usi {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>;
+		clock-output-names = "usi";
+	};
+
+	cpus: cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+				core1 {
+					cpu = <&cpu5>;
+				};
+				core2 {
+					cpu = <&cpu6>;
+				};
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+
+			cluster2 {
+				core0 {
+					cpu = <&cpu8>;
+				};
+				core1 {
+					cpu = <&cpu9>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+		};
+
+		cpu4: cpu@10000 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x0 0x10000>;
+			enable-method = "psci";
+		};
+
+		cpu5: cpu@10100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x0 0x10100>;
+			enable-method = "psci";
+		};
+
+		cpu6: cpu@10200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x0 0x10200>;
+			enable-method = "psci";
+		};
+
+		cpu7: cpu@10300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x0 0x10300>;
+			enable-method = "psci";
+		};
+
+		cpu8: cpu@20000 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x0 0x20000>;
+			enable-method = "psci";
+		};
+
+		cpu9: cpu@20100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x0 0x20100>;
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	soc: soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x0 0x20000000>;
+
+		chipid@10000000 {
+			compatible = "samsung,exynosautov920-chipid",
+				     "samsung,exynos850-chipid";
+			reg = <0x10000000 0x24>;
+		};
+
+		gic: interrupt-controller@10400000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x10400000 0x10000>,
+			      <0x10460000 0x140000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_alive: pinctrl@11850000 {
+			compatible = "samsung,exynosautov920-pinctrl";
+			reg = <0x11850000 0x10000>;
+
+			wakeup-interrupt-controller {
+				compatible = "samsung,exynosautov920-wakeup-eint",
+					     "samsung,exynos850-wakeup-eint",
+					     "samsung,exynos7-wakeup-eint";
+			};
+		};
+
+		pinctrl_aud: pinctrl@1a460000 {
+			compatible = "samsung,exynosautov920-pinctrl";
+			reg = <0x1a460000 0x10000>;
+		};
+
+		pinctrl_hsi0: pinctrl@16040000 {
+			compatible = "samsung,exynosautov920-pinctrl";
+			reg = <0x16040000 0x10000>;
+			interrupts = <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_hsi1: pinctrl@16450000 {
+			compatible = "samsung,exynosautov920-pinctrl";
+			reg = <0x16450000 0x10000>;
+			interrupts = <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_hsi2: pinctrl@16c10000 {
+			compatible = "samsung,exynosautov920-pinctrl";
+			reg = <0x16c10000 0x10000>;
+			interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_hsi2ufs: pinctrl@16d20000 {
+			compatible = "samsung,exynosautov920-pinctrl";
+			reg = <0x16d20000 0x10000>;
+			interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_peric0: pinctrl@10830000 {
+			compatible = "samsung,exynosautov920-pinctrl";
+			reg = <0x10830000 0x10000>;
+			interrupts = <GIC_SPI 753 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_peric1: pinctrl@10c30000 {
+			compatible = "samsung,exynosautov920-pinctrl";
+			reg = <0x10c30000 0x10000>;
+			interrupts = <GIC_SPI 781 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pmu_system_controller: system-controller@11860000 {
+			compatible = "samsung,exynosautov920-pmu",
+				     "samsung,exynos7-pmu","syscon";
+			reg = <0x11860000 0x10000>;
+		};
+
+		pwm: pwm@109b0000 {
+			compatible = "samsung,exynosautov920-pwm",
+				     "samsung,exynos4210-pwm";
+			reg = <0x109b0000 0x100>;
+			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
+			#pwm-cells = <3>;
+			clocks = <&xtcxo>;
+			clock-names = "timers";
+			status = "disabled";
+		};
+
+		syscon_peric0: syscon@10820000 {
+			compatible = "samsung,exynosautov920-peric0-sysreg",
+				     "syscon";
+			reg = <0x10820000 0x2000>;
+		};
+
+		syscon_peric1: syscon@10c20000 {
+			compatible = "samsung,exynosautov920-peric1-sysreg",
+				     "syscon";
+			reg = <0x10c20000 0x2000>;
+		};
+
+		usi_0: usi@108800c0 {
+			compatible = "samsung,exynosautov920-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x108800c0 0x20>;
+			samsung,sysreg = <&syscon_peric0 0x1000>;
+			samsung,mode = <USI_V2_UART>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&clock_usi>, <&clock_usi>;
+			clock-names = "pclk", "ipclk";
+			status = "disabled";
+
+			serial_0: serial@10880000 {
+				compatible = "samsung,exynosautov920-uart",
+					     "samsung,exynos850-uart";
+				reg = <0x10880000 0xc0>;
+				interrupts = <GIC_SPI 764 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart0_bus>;
+				clocks = <&clock_usi>, <&clock_usi>;
+				clock-names = "uart", "clk_uart_baud0";
+				samsung,uart-fifosize = <256>;
+				status = "disabled";
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+#include "exynosautov920-pinctrl.dtsi"
-- 
2.43.0


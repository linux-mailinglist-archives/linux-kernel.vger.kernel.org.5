Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677E07C4E20
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjJKJFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345633AbjJKJF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:05:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E517DB;
        Wed, 11 Oct 2023 02:05:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bdf4752c3cso41974345ad.2;
        Wed, 11 Oct 2023 02:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697015122; x=1697619922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiTSh9m7HGR0IUVKv1gXixjDk21h7Y2rh7ZI0qyQNOU=;
        b=M28+M0uAqhVb5K2zaqYavvq7fv9ZQGyDIdqWWB7jZwyWM2MgI6bZEpdtf6n2EZ+zZf
         IN+tcgiCvHNCIRg5mcN05pDoAfAF0+8xaE4g3VKB0uZorVnnnisiNhCNSTnq/1xd36hv
         EFhgJCJ276/KdQBdhNiUa9Wg8CmSGB4qYak4IPcmyaOihOJzFKi9J6CvZwWNR4JjBl+X
         ZJeKJyfbIViYrHm260Z9usndWNe8va3jeLInRFc4Vgas8gFTs4WYFeQRuSB8zqx+Qm1P
         uxfr7KCn5Jqp7KMHFvJ2pDrhnM47GA/FftRRBMAfBRtufS9IclS/3RsuhOC2o5ipAimg
         Fkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697015122; x=1697619922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiTSh9m7HGR0IUVKv1gXixjDk21h7Y2rh7ZI0qyQNOU=;
        b=a5bfS5QKYxFYBSct9fQ/Fpy/oh2CcSuUtHfaWeXcZcgowaxNfRiVdOzAYGcoO9ICZO
         ApqXwVfpzFHXld88kC1wqL0wD6YS6+T2hTa7jJjAUq5GGPrMRFcROFSEq9mVOEvt52dg
         J5CHCBsX7n3jn6VMj9RpOP/SsecNmzbQ0eTUKUMIWxP0fT5cfZmGbA8kGhVLW6s8LDkv
         GsTSgdd1vjMtWlXnFVDlanQgJMoD5Puo+Qsdzss21DLTf+mVG0YqTBlJ8fg/GniAehe+
         kj7qHZ4wUql+/nztNs5wdbcKfnH3QzBSlh+HFFZ8xhDZR4tLWI96IOEx6xDd+Bu+lNQo
         DSBg==
X-Gm-Message-State: AOJu0YwbhnerWZOtgzybEFDISk2n3qNjhThVCwyOTmb5cF46Et7Rol5C
        D+NNrxXDMegRe7QTG9D82c0=
X-Google-Smtp-Source: AGHT+IGn0nR4Swd6EEjTTxvCClIBu3uf1m2RJut0ERlNbj2DBtIL1tYJziBLbfE7VXJpJLPg7zAqSg==
X-Received: by 2002:a17:902:a511:b0:1c7:4707:964b with SMTP id s17-20020a170902a51100b001c74707964bmr15744176plq.25.1697015122493;
        Wed, 11 Oct 2023 02:05:22 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001c61df93afdsm13346699plg.59.2023.10.11.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 02:05:22 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 3/4] arm64: dts: nuvoton: Add pinctrl support for ma35d1
Date:   Wed, 11 Oct 2023 09:05:09 +0000
Message-Id: <20231011090510.114476-4-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011090510.114476-1-ychuang570808@gmail.com>
References: <20231011090510.114476-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add 'pinctrl' node and 'gpioa' ~ 'gpion' nodes to the dtsi of ma35d1
SoC and describe default pin configurations.

Enable all UART nodes presented on som and iot boards, and add pinctrl
function settings to these nodes.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  83 ++++++++-
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  86 ++++++++-
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 175 +++++++++++++++++-
 3 files changed, 335 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
index b89e2be6abae..ff0d2bf8f5bf 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
@@ -14,6 +14,10 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		serial10 = &uart10;
+		serial12 = &uart12;
+		serial13 = &uart13;
+		serial14 = &uart14;
 	};
 
 	chosen {
@@ -33,10 +37,6 @@ clk_hxt: clock-hxt {
 	};
 };
 
-&uart0 {
-	status = "okay";
-};
-
 &clk {
 	assigned-clocks = <&clk CAPLL>,
 			  <&clk DDRPLL>,
@@ -54,3 +54,78 @@ &clk {
 			   "integer",
 			   "integer";
 };
+
+&pinctrl {
+	uart0 {
+		pinctrl_uart0: uart0grp {
+			nuvoton,pins =
+				<MA35_SYS_REG_GPE_H 24 1 &pcfg_default>,
+				<MA35_SYS_REG_GPE_H 28 1 &pcfg_default>;
+		};
+	};
+
+	uart10 {
+		pinctrl_uart10: uart10grp {
+			nuvoton,pins =
+				<MA35_SYS_REG_GPH_L 16 2 &pcfg_default>,
+				<MA35_SYS_REG_GPH_L 20 2 &pcfg_default>,
+				<MA35_SYS_REG_GPH_L 24 2 &pcfg_default>,
+				<MA35_SYS_REG_GPH_L 28 2 &pcfg_default>;
+		};
+	};
+
+	uart12 {
+		pinctrl_uart12: uart12grp {
+			nuvoton,pins =
+				<MA35_SYS_REG_GPC_H 20 2 &pcfg_default>,
+				<MA35_SYS_REG_GPC_H 24 2 &pcfg_default>,
+				<MA35_SYS_REG_GPC_H 28 2 &pcfg_default>;
+		};
+	};
+
+	uart13 {
+		pinctrl_uart13: uart13grp {
+			nuvoton,pins =
+				<MA35_SYS_REG_GPH_H 16 3 &pcfg_default>,
+				<MA35_SYS_REG_GPH_H 20 3 &pcfg_default>;
+		};
+	};
+
+	uart14 {
+		pinctrl_uart14: uart14grp {
+			nuvoton,pins =
+				<MA35_SYS_REG_GPH_H 24 2 &pcfg_default>,
+				<MA35_SYS_REG_GPH_H 28 2 &pcfg_default>;
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+	status = "okay";
+};
+
+&uart10 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart10>;
+	status = "okay";
+};
+
+&uart12 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart12>;
+	status = "okay";
+};
+
+&uart13 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart13>;
+	status = "okay";
+};
+
+&uart14 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart14>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
index a1ebddecb7f8..c8c26f37116b 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -14,6 +14,10 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		serial11 = &uart11;
+		serial12 = &uart12;
+		serial14 = &uart14;
+		serial16 = &uart16;
 	};
 
 	chosen {
@@ -33,10 +37,6 @@ clk_hxt: clock-hxt {
 	};
 };
 
-&uart0 {
-	status = "okay";
-};
-
 &clk {
 	assigned-clocks = <&clk CAPLL>,
 			  <&clk DDRPLL>,
@@ -54,3 +54,81 @@ &clk {
 			   "integer",
 			   "integer";
 };
+
+&pinctrl {
+	uart0 {
+		pinctrl_uart0: uart0grp {
+			nuvoton,pins =
+				<MA35_SYS_REG_GPE_H 24 1 &pcfg_default>,
+				<MA35_SYS_REG_GPE_H 28 1 &pcfg_default>;
+		};
+	};
+
+	uart11 {
+		pinctrl_uart11: uart11grp {
+			nuvoton,pins =
+				<MA35_SYS_REG_GPL_L 0 2 &pcfg_default>,
+				<MA35_SYS_REG_GPL_L 4 2 &pcfg_default>,
+				<MA35_SYS_REG_GPL_L 8 2 &pcfg_default>,
+				<MA35_SYS_REG_GPL_L 12 2 &pcfg_default>;
+		};
+	};
+
+	uart12 {
+		pinctrl_uart12: uart12grp {
+			nuvoton,pins =
+				<MA35_SYS_REG_GPI_L 4 2 &pcfg_default>,
+				<MA35_SYS_REG_GPI_L 8 2 &pcfg_default>,
+				<MA35_SYS_REG_GPI_L 12 2 &pcfg_default>;
+		};
+	};
+
+	uart14 {
+		pinctrl_uart14: uart14grp {
+			nuvoton,pins =
+				<MA35_SYS_REG_GPI_L 20 2 &pcfg_default>,
+				<MA35_SYS_REG_GPI_L 24 2 &pcfg_default>,
+				<MA35_SYS_REG_GPI_L 28 2 &pcfg_default>;
+		};
+	};
+
+	uart16 {
+		pinctrl_uart16: uart16grp {
+			nuvoton,pins =
+				<MA35_SYS_REG_GPK_L 0 2 &pcfg_default>,
+				<MA35_SYS_REG_GPK_L 4 2 &pcfg_default>,
+				<MA35_SYS_REG_GPK_L 8 2 &pcfg_default>,
+				<MA35_SYS_REG_GPK_L 12 2 &pcfg_default>;
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+	status = "okay";
+};
+
+&uart11 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart11>;
+	status = "okay";
+};
+
+&uart12 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart12>;
+	status = "okay";
+};
+
+&uart14 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart14>;
+	status = "okay";
+};
+
+&uart16 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart16>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index 781cdae566a0..85431a074ab2 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
 #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+#include <dt-bindings/pinctrl/ma35d1-pinfunc.h>
 
 / {
 	compatible = "nuvoton,ma35d1";
@@ -83,7 +84,7 @@ soc {
 		ranges;
 
 		sys: system-management@40460000 {
-			compatible = "nuvoton,ma35d1-reset";
+			compatible = "nuvoton,ma35d1-reset", "syscon";
 			reg = <0x0 0x40460000 0x0 0x200>;
 			#reset-cells = <1>;
 		};
@@ -95,6 +96,178 @@ clk: clock-controller@40460200 {
 			clocks = <&clk_hxt>;
 		};
 
+		pinctrl: pinctrl@40040000 {
+			compatible = "nuvoton,ma35d1-pinctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			nuvoton,sys = <&sys>;
+			ranges = <0x0 0x0 0x40040000 0xc00>;
+
+			gpioa: gpioa@40040000 {
+				reg = <0x0 0x40>;
+				interrupts = <GIC_SPI  14 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPA_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiob: gpiob@40040040 {
+				reg = <0x40 0x40>;
+				interrupts = <GIC_SPI  15 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPB_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioc: gpioc@40040080 {
+				reg = <0x80 0x40>;
+				interrupts = <GIC_SPI  16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPC_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiod: gpiod@400400c0 {
+				reg = <0xc0 0x40>;
+				interrupts = <GIC_SPI  17 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPD_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioe: gpioe@40040100 {
+				reg = <0x100 0x40>;
+				interrupts = <GIC_SPI  73 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPE_GATE>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiof: gpiof@40040140 {
+				reg = <0x140 0x40>;
+				interrupts = <GIC_SPI  74 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPF_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiog: gpiog@40040180 {
+				reg = <0x180 0x40>;
+				interrupts = <GIC_SPI  75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPG_GATE>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioh: gpioh@400401c0 {
+				reg = <0x1c0 0x40>;
+				interrupts = <GIC_SPI  76 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPH_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioi: gpioi@40040200 {
+				reg = <0x200 0x40>;
+				interrupts = <GIC_SPI  77 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPI_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioj: gpioj@40040240 {
+				reg = <0x240 0x40>;
+				interrupts = <GIC_SPI  78 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPJ_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiok: gpiok@40040280 {
+				reg = <0x280 0x40>;
+				interrupts = <GIC_SPI  102 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPK_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiol: gpiol@400402c0 {
+				reg = <0x2c0 0x40>;
+				interrupts = <GIC_SPI  103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPL_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiom: gpiom@40040300 {
+				reg = <0x300 0x40>;
+				interrupts = <GIC_SPI  104 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPM_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpion: gpion@40040340 {
+				reg = <0x340 0x40>;
+				interrupts = <GIC_SPI  105 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPN_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			pcfg_default: pcfg-default {
+				slew-rate = <0>;
+				input-schmitt-disable;
+				bias-disable;
+				power-source = <3300>;
+				drive-strength = <0>;
+			};
+
+			pcfg_emac_3_3v: pcfg-emac-3.3v {
+				slew-rate = <0>;
+				input-schmitt-enable;
+				bias-disable;
+				power-source = <3300>;
+				drive-strength = <1>;
+			};
+
+			pcfg_emac_1_8v: pcfg-emac-1.8v {
+				slew-rate = <0>;
+				input-schmitt-enable;
+				bias-disable;
+				power-source = <1800>;
+				drive-strength = <1>;
+			};
+		};
+
 		uart0: serial@40700000 {
 			compatible = "nuvoton,ma35d1-uart";
 			reg = <0x0 0x40700000 0x0 0x100>;
-- 
2.34.1


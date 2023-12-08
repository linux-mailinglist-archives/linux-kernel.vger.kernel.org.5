Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2DA809FAD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573447AbjLHJmS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Dec 2023 04:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjLHJmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:42:14 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC1C10CA;
        Fri,  8 Dec 2023 01:42:15 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id D3A8824E199;
        Fri,  8 Dec 2023 17:42:13 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 8 Dec
 2023 17:42:13 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 8 Dec 2023 17:42:12 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Hal Feng" <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v9 3/4] riscv: dts: starfive: jh7100: Add PWM node and pins configuration
Date:   Fri, 8 Dec 2023 17:42:08 +0800
Message-ID: <20231208094209.1910934-4-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208094209.1910934-1-william.qiu@starfivetech.com>
References: <20231208094209.1910934-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add OpenCores PWM controller node and add PWM pins configuration
on VisionFive 1 board.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 .../boot/dts/starfive/jh7100-common.dtsi      | 24 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |  9 +++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
index b93ce351a90f..11876906cc05 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
@@ -84,6 +84,24 @@ GPO_I2C2_PAD_SDA_OEN,
 		};
 	};
 
+	pwm_pins: pwm-0 {
+		pwm-pins {
+			pinmux = <GPIOMUX(7,
+				  GPO_PWM_PAD_OUT_BIT0,
+				  GPO_PWM_PAD_OE_N_BIT0,
+				  GPI_NONE)>,
+				 <GPIOMUX(5,
+				  GPO_PWM_PAD_OUT_BIT1,
+				  GPO_PWM_PAD_OE_N_BIT1,
+				  GPI_NONE)>;
+			bias-disable;
+			drive-strength = <35>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
 	uart3_pins: uart3-0 {
 		rx-pins {
 			pinmux = <GPIOMUX(13, GPO_LOW, GPO_DISABLE,
@@ -154,6 +172,12 @@ &osc_aud {
 	clock-frequency = <27000000>;
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pins>;
+	status = "okay";
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index e68cafe7545f..4f5eb2f60856 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -280,6 +280,15 @@ watchdog@12480000 {
 				 <&rstgen JH7100_RSTN_WDT>;
 		};
 
+		pwm: pwm@12490000 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12490000 0x0 0x10000>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		sfctemp: temperature-sensor@124a0000 {
 			compatible = "starfive,jh7100-temp";
 			reg = <0x0 0x124a0000 0x0 0x10000>;
-- 
2.34.1


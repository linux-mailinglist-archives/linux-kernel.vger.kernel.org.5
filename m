Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90ED76331E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjGZKGX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 06:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjGZKGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:06:16 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE730BF;
        Wed, 26 Jul 2023 03:06:15 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 6215A810C;
        Wed, 26 Jul 2023 18:06:14 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Jul
 2023 18:06:14 +0800
Received: from ubuntu.localdomain (183.27.99.135) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Jul
 2023 18:06:13 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: [dt-for-next v1 2/2] riscv: dts: starfive: Add USB dts node for JH7110
Date:   Wed, 26 Jul 2023 03:06:09 -0700
Message-ID: <20230726100609.72550-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230726100609.72550-1-minda.chen@starfivetech.com>
References: <20230726100609.72550-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.99.135]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB wrapper layer and Cadence USB3 controller dts
configuration for StarFive JH7110 SoC and VisionFive2
Board.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         |  5 +++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 32 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 5feff4673503..36c402b4a726 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -273,6 +273,11 @@ &uart0 {
 	status = "okay";
 };
 
+&usb0 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
 &U74_1 {
 	cpu-supply = <&vdd_cpu>;
 };
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index dbc1243a0e75..c58489468cad 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -446,6 +446,38 @@ i2c2: i2c@10050000 {
 			status = "disabled";
 		};
 
+		usb0: usb@10100000 {
+			compatible = "starfive,jh7110-usb";
+			ranges = <0x0 0x0 0x10100000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			starfive,stg-syscon = <&stg_syscon 0x4>;
+			clocks = <&stgcrg JH7110_STGCLK_USB0_LPM>,
+				 <&stgcrg JH7110_STGCLK_USB0_STB>,
+				 <&stgcrg JH7110_STGCLK_USB0_APB>,
+				 <&stgcrg JH7110_STGCLK_USB0_AXI>,
+				 <&stgcrg JH7110_STGCLK_USB0_UTMI_APB>;
+			clock-names = "lpm", "stb", "apb", "axi", "utmi_apb";
+			resets = <&stgcrg JH7110_STGRST_USB0_PWRUP>,
+				 <&stgcrg JH7110_STGRST_USB0_APB>,
+				 <&stgcrg JH7110_STGRST_USB0_AXI>,
+				 <&stgcrg JH7110_STGRST_USB0_UTMI_APB>;
+			reset-names = "pwrup", "apb", "axi", "utmi_apb";
+			status = "disabled";
+
+			usb_cdns3: usb@0 {
+				compatible = "cdns,usb3";
+				reg = <0x0 0x10000>,
+				      <0x10000 0x10000>,
+				      <0x20000 0x10000>;
+				reg-names = "otg", "xhci", "dev";
+				interrupts = <100>, <108>, <110>;
+				interrupt-names = "host", "peripheral", "otg";
+				phys = <&usbphy0>;
+				phy-names = "cdns3,usb2-phy";
+			};
+		};
+
 		usbphy0: phy@10200000 {
 			compatible = "starfive,jh7110-usb-phy";
 			reg = <0x0 0x10200000 0x0 0x10000>;
-- 
2.25.1


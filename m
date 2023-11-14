Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08C67EAE76
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjKNK4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjKNK4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:56:31 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BC3D55;
        Tue, 14 Nov 2023 02:56:06 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFEAA2000C;
        Tue, 14 Nov 2023 10:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699959364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZKAGIL7tCosSaUSk8d96o5LmNKTOtXF6OZIhSqTXQM=;
        b=b6Bj/h2XqPg58e03lV7lvnuIUso2Fk7mPeo/2rsceinq5EroVHSLt9pk1HF2/fwdms1i5M
        ZFluwKh2qScGS14WUIkO45EU3B+KGp13zKru3018wcB+xJqFVVR34a5ZdKzXnJ9AgQtxOw
        teKb7aegdaUGaWmiB5LtEGGIFNDlDAIzvKkHAtEYwkYznD3q7Iuke2ivfF/IokDJE2Nl0g
        7P766aIET6JaJ4Ua+m1fKzeqJ2PxmlGut6Skm26PuxOk30cHb8PRmHiw7nsVcw2NKfLfrJ
        qUoNS7cQQXSCGCkeJG652aeLrON4QzQV6dKVY300HjPhCwT+HUheqAvZ7ZvavA==
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Romain Gantois <romain.gantois@bootlin.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH net-next v3 8/8] ARM: dts: qcom: ipq4019: Add description for the IPQ4019 ESS EDMA and switch
Date:   Tue, 14 Nov 2023 11:55:58 +0100
Message-ID: <20231114105600.1012056-9-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114105600.1012056-1-romain.gantois@bootlin.com>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm IPQ4019 includes a modified version of the QCA8K Ethernet
switch. The switch's CPU port is connected to the SoC through the internal
EDMA Ethernet controller. Add support for these two devices, which are
coupled tightly enough to justify treating them as a single device.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 .../boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi | 13 +++
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi      | 94 +++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi
index da67d55fa557..6a185b8b31c6 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi
@@ -242,6 +242,19 @@ &mdio {
 	pinctrl-names = "default";
 };
 
+&switch {
+	status = "okay";
+};
+
+&swport4 {
+	status = "okay";
+	label = "lan";
+};
+
+&swport5 {
+	status = "okay";
+};
+
 &wifi0 {
 	status = "okay";
 	nvmem-cell-names = "pre-calibration";
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
index 9844e0b7cff9..5a4e5d408f72 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
@@ -596,6 +596,100 @@ wifi1: wifi@a800000 {
 			status = "disabled";
 		};
 
+		switch: switch@c000000 {
+			compatible = "qcom,ipq4019-ess";
+			reg = <0xc000000 0x80000>, <0x98000 0x800>, <0xc080000 0x8000>;
+			reg-names = "base", "psgmii_phy", "edma";
+			resets = <&gcc ESS_PSGMII_ARES>, <&gcc ESS_RESET>;
+			reset-names = "psgmii", "ess";
+			clocks = <&gcc GCC_ESS_CLK>;
+			clock-names = "ess";
+			mdio = <&mdio>;
+			interrupts = <GIC_SPI  65 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  66 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  67 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  68 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  69 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  70 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  71 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  72 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  73 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  74 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  75 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  76 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  77 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  78 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  79 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI  80 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 240 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 241 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 242 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 243 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 244 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 245 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 246 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 247 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 248 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 249 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 251 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 252 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 253 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 254 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 255 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				swport1: port@1 { /* MAC1 */
+					reg = <1>;
+					label = "lan1";
+					phy-handle = <&ethphy0>;
+					phy-mode = "psgmii";
+
+					status = "disabled";
+				};
+
+				swport2: port@2 { /* MAC2 */
+					reg = <2>;
+					label = "lan2";
+					phy-handle = <&ethphy1>;
+					phy-mode = "psgmii";
+
+					status = "disabled";
+				};
+
+				swport3: port@3 { /* MAC3 */
+					reg = <3>;
+					label = "lan3";
+					phy-handle = <&ethphy2>;
+					phy-mode = "psgmii";
+
+					status = "disabled";
+				};
+
+				swport4: port@4 { /* MAC4 */
+					reg = <4>;
+					label = "lan4";
+					phy-handle = <&ethphy3>;
+					phy-mode = "psgmii";
+
+					status = "disabled";
+				};
+
+				swport5: port@5 { /* MAC5 */
+					reg = <5>;
+					label = "wan";
+					phy-handle = <&ethphy4>;
+					phy-mode = "psgmii";
+
+					status = "disabled";
+				};
+			};
+		};
+
 		mdio: mdio@90000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.42.0


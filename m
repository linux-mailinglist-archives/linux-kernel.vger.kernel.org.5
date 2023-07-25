Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAA8760DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjGYJAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjGYJAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:00:01 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E3E98;
        Tue, 25 Jul 2023 01:59:59 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36P8xeSs107055;
        Tue, 25 Jul 2023 03:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690275580;
        bh=PYv2F9TGO+8iiuiu+JUOxxqpOZW3GXXXquvGVj3k/sY=;
        h=From:To:CC:Subject:Date;
        b=RfbCii/09/IMnbxREzTK3YLKHZxyUc70obzKQjQI7jyKuO2K6i9XhBPuIbI7JgQLm
         85Tz6E5jJAyvN8b9h+zZNuwC1twBEx66RPH4N8Y3BD1ANvmPa8YPlIx0em/Lo+CH6F
         M2ZcoOJCEOuWI0I4ND2TaBsFrr0glRQtF/Mz28UU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36P8xePH031419
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 03:59:40 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 03:59:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 03:59:40 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36P8xdKm117679;
        Tue, 25 Jul 2023 03:59:40 -0500
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <kristo@kernel.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <u-kumar1@ti.com>, <b-kapoor@ti.com>
Subject: [PATCH v6] arm64: dts: ti: k3-j721s2: Add support for CAN instances 3 and 5 in main domain
Date:   Tue, 25 Jul 2023 14:29:39 +0530
Message-ID: <20230725085939.536766-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CAN instances 3 and 5 in the main domain are brought on the common
processor board through header J27 and J28. The CAN High and Low lines
from the SoC are routed through a mux on the SoM. The select lines need
to be set for the CAN signals to get connected to the transceivers on
the common processor board. Threfore, add respective mux, transceiver
dt nodes to add support for these CAN instances.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
changelog v5->v6:
- Changed node names for pins to match with json schema conversion

Link to v5 : https://lore.kernel.org/all/20230724111751.86422-1-b-kapoor@ti.com/

 .../dts/ti/k3-j721s2-common-proc-board.dts    | 46 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 12 +++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index 04d4739d7245..a2c5ccd6897f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -29,6 +29,8 @@ aliases {
 		can0 = &main_mcan16;
 		can1 = &mcu_mcan0;
 		can2 = &mcu_mcan1;
+		can3 = &main_mcan3;
+		can4 = &main_mcan5;
 	};
 
 	evm_12v0: fixedregulator-evm12v0 {
@@ -109,6 +111,22 @@ transceiver2: can-phy2 {
 		standby-gpios = <&wkup_gpio0 2 GPIO_ACTIVE_HIGH>;
 	};
 
+	transceiver3: can-phy3 {
+		compatible = "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&exp2 7 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&exp2 6 GPIO_ACTIVE_HIGH>;
+		mux-states = <&mux0 1>;
+	};
+
+	transceiver4: can-phy4 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&exp_som 7 GPIO_ACTIVE_HIGH>;
+		mux-states = <&mux1 1>;
+	};
 };
 
 &main_pmx0 {
@@ -152,6 +170,20 @@ main_usbss0_pins_default: main-usbss0-default-pins {
 			J721S2_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AG25) TIMER_IO1.USB0_DRVVBUS */
 		>;
 	};
+
+	main_mcan3_pins_default: main-mcan3-default-pins {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x080, PIN_INPUT, 0) /* (U26) MCASP0_AXR4.MCAN3_RX */
+			J721S2_IOPAD(0x07c, PIN_OUTPUT, 0) /* (T27) MCASP0_AXR3.MCAN3_TX */
+		>;
+	};
+
+	main_mcan5_pins_default: main-mcan5-default-pins {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x03c, PIN_INPUT, 0) /* (U27) MCASP0_AFSX.MCAN5_RX */
+			J721S2_IOPAD(0x038, PIN_OUTPUT, 0) /* (AB28) MCASP0_ACLKX.MCAN5_TX */
+		>;
+	};
 };
 
 &wkup_pmx2 {
@@ -460,3 +492,17 @@ adc {
 		ti,adc-channels = <0 1 2 3 4 5 6 7>;
 	};
 };
+
+&main_mcan3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan3_pins_default>;
+	phys = <&transceiver3>;
+};
+
+&main_mcan5 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan5_pins_default>;
+	phys = <&transceiver4>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
index d57dd43da0ef..594766482071 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
@@ -31,6 +31,18 @@ secure_ddr: optee@9e800000 {
 		};
 	};
 
+	mux0: mux-controller {
+		compatible = "gpio-mux";
+		#mux-state-cells = <1>;
+		mux-gpios = <&exp_som 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	mux1: mux-controller {
+		compatible = "gpio-mux";
+		#mux-state-cells = <1>;
+		mux-gpios = <&exp_som 2 GPIO_ACTIVE_HIGH>;
+	};
+
 	transceiver0: can-phy0 {
 		/* standby pin has been grounded by default */
 		compatible = "ti,tcan1042";
-- 
2.34.1


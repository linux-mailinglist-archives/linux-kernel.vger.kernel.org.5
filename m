Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04E075F4D3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjGXLSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjGXLSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:18:24 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F801133;
        Mon, 24 Jul 2023 04:18:11 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36OBHrih069702;
        Mon, 24 Jul 2023 06:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690197473;
        bh=0BErsuaEIKbeL37YxBiy8FvaJoxzWcjiVfUldm4NGLI=;
        h=From:To:CC:Subject:Date;
        b=Q+O+jMWhx6AjaWYX2s+LoXAlQYMyZ1126ZU2rNPruPGe5XCOPf2QxhXSEIyPhr1g6
         iPe82DLEiFoqlaPmM9+XBPVIFMa79e8JDhcFrIr/xqe6MKPUVoRiEw1zIS39QmH3KE
         We/CKwQMR/W/vSp6LbBQK1oZTl7u96vpCybaZPeY=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36OBHrwK041990
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jul 2023 06:17:53 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jul 2023 06:17:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jul 2023 06:17:53 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36OBHqeN055390;
        Mon, 24 Jul 2023 06:17:52 -0500
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <kristo@kernel.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <u-kumar1@ti.com>, <b-kapoor@ti.com>
Subject: [PATCH v5] arm64: dts: ti: k3-j721s2: Add support for CAN instances 3 and 5 in main domain
Date:   Mon, 24 Jul 2023 16:47:51 +0530
Message-ID: <20230724111751.86422-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Changelog v4->v5 : Modfied Mux Controller names

Link to v4 : https://lore.kernel.org/all/0070e00a-89c0-9b2b-8753-e1835b5aad15@ti.com/

 .../dts/ti/k3-j721s2-common-proc-board.dts    | 46 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 12 +++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index 04d4739d7245..e715fa12f9ca 100644
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
+	main_mcan3_pins_default: main-mcan3-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x080, PIN_INPUT, 0) /* (U26) MCASP0_AXR4.MCAN3_RX */
+			J721S2_IOPAD(0x07c, PIN_OUTPUT, 0) /* (T27) MCASP0_AXR3.MCAN3_TX */
+		>;
+	};
+
+	main_mcan5_pins_default: main-mcan5-pins-default {
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


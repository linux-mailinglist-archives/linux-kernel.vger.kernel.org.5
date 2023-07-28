Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A6B76738C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjG1Rf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbjG1RfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:35:10 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE913A81;
        Fri, 28 Jul 2023 10:35:08 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36SHYo1N084017;
        Fri, 28 Jul 2023 12:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690565690;
        bh=WXosTFhBmvc40yIlnCEZxsbe4Tld7z8DaEV7uLD4esE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Q5qBCln220tLiZkAfRnYOSLuZR5YxJOyF3XzF+HugHQSUYhHk+QNcKm04oNX7OwIO
         pMz3CK2+iy8KeNlgYNSMZdgWjEGPN+JcgeE2vQmxeT4N3tlcNVXAMWDP+kAYYMjbIF
         WfoF2iTap11a63MINI7/UGrOFCjlYTszXU8TcdQI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36SHYouE121043
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jul 2023 12:34:50 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jul 2023 12:34:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jul 2023 12:34:50 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36SHYnh5014035;
        Fri, 28 Jul 2023 12:34:49 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v3 7/8] arm64: dts: ti: k3-am625-beagleplay: Add HDMI support
Date:   Fri, 28 Jul 2023 23:04:37 +0530
Message-ID: <20230728173438.12995-8-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728173438.12995-1-a-bhatia1@ti.com>
References: <20230728173438.12995-1-a-bhatia1@ti.com>
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

From: Nishanth Menon <nm@ti.com>

Add support for HDMI audio and video output.

Beagleplay uses mcasp1 for its audio output, and ITE-IT66121 as its
on-board HDMI encoder.

The HDMI transmitter uses the DPI output from the VP2 of DSS as its
source and forwards the HDMI signals to the on-board Type-A HDMI
connector.

Signed-off-by: Nishanth Menon <nm@ti.com>
[a-bhatia1: Edit sound node properties]
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 63893d868623..93da57949b07 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -192,6 +192,34 @@ usr: button-usr {
 
 	};
 
+	hdmi0: connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&it66121hdmitx_out>;
+			};
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "it66121 HDMI";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&hdmi_dailink_master>;
+		simple-audio-card,frame-master = <&hdmi_dailink_master>;
+
+		hdmi_dailink_master: simple-audio-card,cpu {
+			sound-dai = <&mcasp1>;
+			system-clock-direction-out;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&it66121hdmitx>;
+		};
+	};
+
 	/* Workaround for errata i2329 - just use mdio bitbang */
 	mdio0: mdio {
 		compatible = "virtual,mdio-gpio";
@@ -480,6 +508,24 @@ AM62X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (AE4) OLDI0_CLK1N */
 			AM62X_IOPAD(0x02a4, PIN_OUTPUT, 0) /* (AD5) OLDI0_CLK1P */
 		>;
 	};
+
+	hdmi_gpio_pins_default: hdmi-gpio-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0094, PIN_INPUT_PULLUP | PIN_DEBOUNCE_CONF6, 7) /* (N20) GPMC0_BE1n.GPIO0_36 */
+			AM62X_IOPAD(0x0054, PIN_OUTPUT_PULLUP, 7) /* (P21) GPMC0_AD6.GPIO0_21 */
+		>;
+	};
+
+	mcasp_hdmi_pins_default: mcasp-hdmi-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0090, PIN_INPUT, 2) /* (M24) GPMC0_BE0n_CLE.MCASP1_ACLKX */
+			AM62X_IOPAD(0x0098, PIN_INPUT, 2) /* (U23) GPMC0_WAIT0.MCASP1_AFSX */
+			AM62X_IOPAD(0x008c, PIN_OUTPUT, 2) /* (L25) GPMC0_WEn.MCASP1_AXR0 */
+			AM62X_IOPAD(0x0088, PIN_INPUT, 2) /* (L24) GPMC0_OEn_REn.MCASP1_AXR1 */
+			AM62X_IOPAD(0x0084, PIN_INPUT, 2) /* (L23) GPMC0_ADVn_ALE.MCASP1_AXR2 */
+			AM62X_IOPAD(0x007c, PIN_INPUT, 2) /* (P25) GPMC0_CLK.MCASP1_AXR3 */
+		>;
+	};
 };
 
 &mcu_pmx0 {
@@ -728,6 +774,46 @@ &main_i2c2 {
 	pinctrl-0 = <&i2c2_1v8_pins_default>;
 	clock-frequency = <100000>;
 	status = "okay";
+
+	it66121hdmitx: hdmitx@4c {
+		compatible = "ite,it66121";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_gpio_pins_default>;
+		reg = <0x4c>;
+
+		#sound-dai-cells = <0>;
+
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <36 IRQ_TYPE_EDGE_FALLING>;
+
+		vcn33-supply = <&vdd_3v3>;
+		vcn18-supply = <&buck2_reg>;
+		vrf12-supply = <&buck3_reg>;
+
+		reset-gpios = <&main_gpio0 21 GPIO_ACTIVE_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				it66121hdmitx_in: endpoint {
+					bus-width = <24>;
+					remote-endpoint = <&dpi1_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				it66121hdmitx_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &main_i2c3 {
@@ -819,3 +905,36 @@ &dss {
 	pinctrl-names = "default";
 	pinctrl-0 = <&dss0_pins_default &oldi0_pins_default>;
 };
+
+&dss_ports {
+	/* VP2: DPI Output */
+	port@1 {
+		reg = <1>;
+
+		dpi1_out: endpoint {
+			remote-endpoint = <&it66121hdmitx_in>;
+		};
+	};
+};
+
+&mcasp1 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcasp_hdmi_pins_default>;
+
+	auxclk-fs-ratio = <2177>;
+
+	op-mode = <0>;          /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+	       1 0 0 0
+	       0 0 0 0
+	       0 0 0 0
+	       0 0 0 0
+	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+};
-- 
2.40.1


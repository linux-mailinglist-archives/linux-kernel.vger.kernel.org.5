Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F022D7696AD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjGaMp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjGaMpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:45:36 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B7B10EB;
        Mon, 31 Jul 2023 05:45:28 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36VCjIjX093269;
        Mon, 31 Jul 2023 07:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690807519;
        bh=REWNbZ8SiItHavRu5Xr75liX4rtZu7yd+LUYVSVGB60=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=Jy/oOn/dfEp+4XB25I9VVOw/ZDspRfViImY9nchj7RRzrI2u1TeGatHccLgsuzPDQ
         /5hQAe2jZ4fudL5ukLRc1bhnSlKunrTQKfMfBAvuz37kIkAc1A9BNZespy6HMoXQzg
         6ayDaG65QRT66Qco21b6bzslm+vVzKHt/FbBgzy8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36VCjI8Y031525
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 07:45:18 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 07:45:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 07:45:18 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36VCjHxj007902;
        Mon, 31 Jul 2023 07:45:18 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Mon, 31 Jul 2023 18:14:41 +0530
Subject: [PATCH 4/5] arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230731-mcasp_am62a-v1-4-8bd137ffa8f1@ti.com>
References: <20230731-mcasp_am62a-v1-0-8bd137ffa8f1@ti.com>
In-Reply-To: <20230731-mcasp_am62a-v1-0-8bd137ffa8f1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3223; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=dG2HlAj0l/1W60yjegoZ/2iv6cKF7jPAMqCN6mCOBY4=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx6zZGx5RcQzTMV6Ys4Bf4X3FQDRT0nblAoDK4
 dvuUodt/KOJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMes2QAKCRBD3pH5JJpx
 RYAAEADUIHRRuii1SMVK3yeXk8VTimTs9TFeDAfkMFs7YSPoi21B5/TqqldLW5NYc5u9bUO2kg+
 Cv1IzmAwIT4BbaAmIdgqp6kEYVenOlN0o/L4nAX5w41XDWb2zbnJgkxuxZO0NALxyG3daDQjwvx
 36S5jIwZVq8ob56grsZ2Y8oo0Dt8h1WxaiXn5Gmvr/nU2F+Ajw4uWqzxJxT1Nihin4XDjSdDmVT
 XmluOBs/lpEPzqQU401rcCZb9rpQbD4HEeg2mhvXZQZiI2JXZRNtxFLwNbeu2SEgZc/jBe0XArN
 GllPi/JpHrlkhMc1ioKimjLGvUYPYDcZhh2TrCHLtMfM5BDfX+C1d3alG4zIBVXBWygduUqkL2h
 DSbBepUygYQXtobqTMdeye+q/GeR2blVwrVIo7FdNg/uDtOsz/EqS5ZjOjueqq7rDtT8W/Lg7Ha
 Azj5rF5OpO6BxAlrc3EEydRs1D8BnRASGxszHUn3XblNM8BBsyx5CvxgtPuw6NQWMSnX1SKYcw4
 XaP0Z0Q5Yohg8Rg8eHzvTBFqQ404hEPcoXT/aDLFbCUyDRrkf4/XwK2JJgTrT3WjzDbZv+GDqKK
 4CXqV/D0advWLb0oQ0DT16gYvVMaVvYmSRd8DnD0rZOSqopqYkXYBm7g3PZxeWuVyVDpOJwZ8jG
 BBQOJI47/EQgK3g==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for audio codec and sound card, enable the audio serializer
(McASP1) under use and update pinmux.

Link: https://www.ti.com/lit/zip/sprr459
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 77 +++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 752c2f640f63..5f68d2eefe0f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -125,6 +125,41 @@ led-0 {
 			default-state = "off";
 		};
 	};
+
+	tlv320_mclk: clk-0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <12288000>;
+	};
+
+	codec_audio: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "AM62Ax-SKEVM";
+		simple-audio-card,widgets =
+			"Headphone",	"Headphone Jack",
+			"Line",		"Line In",
+			"Microphone",	"Microphone Jack";
+		simple-audio-card,routing =
+			"Headphone Jack",	"HPLOUT",
+			"Headphone Jack",	"HPROUT",
+			"LINE1L",		"Line In",
+			"LINE1R",		"Line In",
+			"MIC3R",		"Microphone Jack",
+			"Microphone Jack",	"Mic Bias";
+		simple-audio-card,format = "dsp_b";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+		simple-audio-card,bitclock-inversion;
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp1>;
+		};
+
+		sound_master: simple-audio-card,codec {
+			sound-dai = <&tlv320aic3106>;
+			clocks = <&tlv320_mclk>;
+		};
+	};
 };
 
 &mcu_pmx0 {
@@ -230,6 +265,15 @@ AM62AX_IOPAD(0x130, PIN_INPUT, 0) /* (AB17) RGMII1_TXC */
 			AM62AX_IOPAD(0x12c, PIN_INPUT, 0) /* (W16) RGMII1_TX_CTL */
 		>;
 	};
+
+	main_mcasp1_pins_default: main-mcasp1-pins-default {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x090, PIN_INPUT, 2) /* (L19) GPMC0_BE0n_CLE.MCASP1_ACLKX */
+			AM62AX_IOPAD(0x098, PIN_INPUT, 2) /* (R18) GPMC0_WAIT0.MCASP1_AFSX */
+			AM62AX_IOPAD(0x08c, PIN_OUTPUT, 2) /* (K19) GPMC0_WEn.MCASP1_AXR0 */
+			AM62AX_IOPAD(0x084, PIN_INPUT, 2) /* (L18) GPMC0_ADVn_ALE.MCASP1_AXR2 */
+		>;
+	};
 };
 
 &mcu_pmx0 {
@@ -359,6 +403,19 @@ exp1: gpio@22 {
 				   "MCASP1_FET_SEL", "UART1_FET_SEL",
 				   "PD_I2C_IRQ", "IO_EXP_TEST_LED";
 	};
+
+	tlv320aic3106: audio-codec@1b {
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3106";
+		reg = <0x1b>;
+		ai3x-micbias-vg = <1>;	/* 2.0V */
+
+		/* Regulators */
+		AVDD-supply = <&vcc_3v3_sys>;
+		IOVDD-supply = <&vcc_3v3_sys>;
+		DRVDD-supply = <&vcc_3v3_sys>;
+		DVDD-supply = <&buck5>;
+	};
 };
 
 &sdhci1 {
@@ -434,3 +491,23 @@ cpsw3g_phy0: ethernet-phy@0 {
 		ti,min-output-impedance;
 	};
 };
+
+&mcasp1 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcasp1_pins_default>;
+
+	op-mode = <0>;          /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+	       1 0 2 0
+	       0 0 0 0
+	       0 0 0 0
+	       0 0 0 0
+	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+};

-- 
2.41.0


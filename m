Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A69765E78
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjG0Vx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjG0Vx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:53:28 -0400
Received: from qs51p00im-qukt01072101.me.com (qs51p00im-qukt01072101.me.com [17.57.155.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224D735B6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1690494776; bh=gvNeBYQHG/KwbIMbUxyFv2rdxHKz+V5JxrelDTmwgko=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=UrudoX9E/s9ccv2NPUtiHGP6/7r373Ir0cRWUuGa/tE+rgS1hAt45sznpxCRv0hlA
         xDEhBLq0j6GKqkY4wSN52ySdbZuU6LlFChZfhHSaoq5fwrSRO8lJxJ7B72fytJC5dz
         L1C4bDFthl8882dfE0Gpji2ofWOt34JJ6sjXSIblKiZYbpOxAj9QiXC7sg3oRC7RZT
         G4VfJJpLO4gJJFT62ISkKEPj3B2vBznIQlC0g+wpr3OV9EacVd8zGDYCLH+UAVYBOz
         Ogu9JSgY41zmnMjLlbZmhxGho1NQKrFp7gF8gbEf1gCSB/Eixy6vO2rSv0YZk2TDlq
         dJE2DlHaa7C8g==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01072101.me.com (Postfix) with ESMTPSA id CCA75408EA;
        Thu, 27 Jul 2023 21:52:55 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alain Volmat <avolmat@me.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] ARM: dts: sti: addition of display nodes for stih418 platform
Date:   Thu, 27 Jul 2023 21:51:36 +0000
Message-Id: <20230727215141.53910-13-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727215141.53910-1-avolmat@me.com>
References: <20230727215141.53910-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JEtiDP0icZMa981b3oKj86PhBrbLmwDb
X-Proofpoint-GUID: JEtiDP0icZMa981b3oKj86PhBrbLmwDb
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2307270199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addition of a first set of nodes (compositor/tvout/hdmi/dvo) in order
to allow graphic plane usage via HDMI or DVO on the stih418 based boards.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/st/stih418-clock.dtsi |   2 +-
 arch/arm/boot/dts/st/stih418.dtsi       | 154 ++++++++++++++++++++++++
 2 files changed, 155 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stih418-clock.dtsi b/arch/arm/boot/dts/st/stih418-clock.dtsi
index e1749e92a2e7..93641df58bf2 100644
--- a/arch/arm/boot/dts/st/stih418-clock.dtsi
+++ b/arch/arm/boot/dts/st/stih418-clock.dtsi
@@ -17,7 +17,7 @@ clk_sysin: clk-sysin {
 	clk_tmdsout_hdmi: clk-tmdsout-hdmi {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
-		clock-frequency = <0>;
+		clock-frequency = <594000000>;
 	};
 
 	clocks {
diff --git a/arch/arm/boot/dts/st/stih418.dtsi b/arch/arm/boot/dts/st/stih418.dtsi
index b35b9b7a7ccc..b41de235fffa 100644
--- a/arch/arm/boot/dts/st/stih418.dtsi
+++ b/arch/arm/boot/dts/st/stih418.dtsi
@@ -6,6 +6,7 @@
 #include "stih418-clock.dtsi"
 #include "stih407-family.dtsi"
 #include "stih410-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 / {
 	cpus {
 		#address-cells = <1>;
@@ -114,5 +115,158 @@ thermal@91a0000 {
 			clocks = <&clk_sysin>;
 			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
 		};
+
+		sti-display-subsystem@0 {
+			compatible = "st,sti-display-subsystem";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0 0>;
+			assigned-clocks = <&clk_s_d2_quadfs 0>,
+					  <&clk_s_d2_quadfs 1>,
+					  <&clk_s_d2_flexgen CLK_TMDS_HDMI_DIV2>,
+					  <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
+					  <&clk_s_d2_flexgen CLK_PIX_MAIN_DISP>,
+					  <&clk_s_d2_flexgen CLK_PIX_AUX_DISP>,
+					  <&clk_s_c0_flexgen CLK_MAIN_DISP>,
+					  <&clk_s_c0_flexgen CLK_AUX_DISP>,
+					  <&clk_s_c0_flexgen CLK_COMPO_DVP>,
+					  <&clk_s_c0_flexgen CLK_PROC_MIXER>;
+
+			assigned-clock-parents = <0>,
+						 <0>,
+						 <&clk_tmdsout_hdmi>,
+						 <&clk_tmdsout_hdmi>,
+						 <&clk_s_d2_quadfs 0>,
+						 <&clk_s_d2_quadfs 1>,
+						 <&clk_s_c0_pll1 0>,
+						 <&clk_s_c0_pll1 0>,
+						 <&clk_s_c0_pll0 0>,
+						 <&clk_s_c0_pll0 0>;
+
+			assigned-clock-rates = <297000000>,
+					       <108000000>,
+					       <297000000>,
+					       <0>,
+					       <74250000>,
+					       <13500000>,
+					       <400000000>,
+					       <400000000>,
+					       <355000000>,
+					       <355000000>;
+
+			ranges;
+
+			sti_compo: sti-compositor@a600000 {
+				compatible = "st,stih418-compositor";
+				reg = <0xa600000 0x200000>;
+
+				clock-names = "compo_main",
+					      "compo_aux",
+					      "pix_main",
+					      "pix_aux",
+					      "proc_mixer";
+
+				clocks = <&clk_s_c0_flexgen CLK_COMPO_DVP>,
+					 <&clk_s_c0_flexgen CLK_COMPO_DVP>,
+					 <&clk_s_d2_flexgen CLK_PIX_MAIN_DISP>,
+					 <&clk_s_d2_flexgen CLK_PIX_AUX_DISP>,
+					 <&clk_s_c0_flexgen CLK_PROC_MIXER>;
+
+				reset-names = "compo-main", "compo-aux";
+				resets = <&softreset STIH407_COMPO_SOFTRESET>,
+					 <&softreset STIH407_COMPO_SOFTRESET>;
+				st,vtg = <&vtg_main>, <&vtg_aux>;
+
+				status = "disabled";
+			};
+
+			sti_tvout: sti-tvout@a900000 {
+				compatible = "st,stih418-tvout";
+				reg = <0xa900000 0x1000>;
+				reg-names = "tvout-reg";
+				reset-names = "tvout";
+				resets = <&softreset STIH407_HDTVOUT_SOFTRESET>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				assigned-clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
+						  <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
+						  <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
+						  <&clk_s_d0_flexgen CLK_PCM_0>,
+						  <&clk_s_d2_flexgen CLK_PIX_HDDAC>,
+						  <&clk_s_d2_flexgen CLK_HDDAC>;
+
+				assigned-clock-parents = <&clk_s_d2_quadfs 0>,
+							 <&clk_tmdsout_hdmi>,
+							 <&clk_s_d2_quadfs 0>,
+							 <&clk_s_d0_quadfs 0>,
+							 <&clk_s_d2_quadfs 0>,
+							 <&clk_s_d2_quadfs 0>;
+				assigned-clock-rates = <74250000>,
+						       <0>,
+						       <74250000>,
+						       <0>,
+						       <74250000>,
+						       <148500000>;
+
+				status = "disabled";
+			};
+
+			sti_dvo: sti-dvo@a800400 {
+				compatible = "st,stih407-dvo";
+				reg = <0xa800400 0x200>;
+				reg-names = "dvo-reg";
+				clock-names = "dvo_pix", "dvo",
+					      "main_parent", "aux_parent";
+				clocks = <&clk_s_d2_flexgen CLK_PIX_DVO>,
+					 <&clk_s_d2_flexgen CLK_DVO>,
+					 <&clk_s_d2_quadfs 0>, <&clk_s_d2_quadfs 1>;
+				status = "disabled";
+			};
+
+			sti_hdmi: sti-hdmi@a804000 {
+				compatible = "st,stih418-hdmi";
+				reg = <0xa804000 0x1000>;
+				reg-names = "hdmi-reg";
+				#sound-dai-cells = <0>;
+				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "irq";
+				clock-names = "pix",
+					      "tmds",
+					      "phy",
+					      "audio",
+					      "main_parent",
+					      "aux_parent";
+
+				clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
+					 <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
+					 <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
+					 <&clk_s_d0_flexgen CLK_PCM_0>,
+					 <&clk_s_d2_quadfs 0>,
+					 <&clk_s_d2_quadfs 1>;
+
+				hdmi,hpd-gpio = <&pio5 3 GPIO_ACTIVE_LOW>;
+				reset-names = "hdmi";
+				resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
+
+				status = "disabled";
+			};
+		};
+
+		vtg_main: sti-vtg-main@a802800 {
+			compatible = "st,stih418-vtg";
+			reg = <0xa802800 0x200>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+
+			status = "disabled";
+		};
+
+		vtg_aux: sti-vtg-aux@a800200 {
+			compatible = "st,stih418-vtg";
+			reg = <0xa800200 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1


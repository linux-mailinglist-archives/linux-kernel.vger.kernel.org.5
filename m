Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC9476995E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjGaOWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjGaOV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:21:57 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50313B6;
        Mon, 31 Jul 2023 07:21:53 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 3DA3620798;
        Mon, 31 Jul 2023 16:21:49 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jai Luthra <j-luthra@ti.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 1/4] arm64: dts: ti: k3-am62x: Enable AUDIO_REFCLKx
Date:   Mon, 31 Jul 2023 16:21:32 +0200
Message-Id: <20230731142135.108477-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731142135.108477-1-francesco@dolcini.it>
References: <20230731142135.108477-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jai Luthra <j-luthra@ti.com>

On AM62-based SoCs the AUDIO_REFCLKx clocks can be used as an input to
external peripherals when configured through CTRL_MMR, so add the
clock nodes.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 18 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 33b6aadc9083..3a1b387bbf49 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -60,6 +60,24 @@ epwm_tbclk: clock@4130 {
 			reg = <0x4130 0x4>;
 			#clock-cells = <1>;
 		};
+
+		audio_refclk0: clock@82e0 {
+			compatible = "ti,am62-audio-refclk";
+			reg = <0x82e0 0x4>;
+			clocks = <&k3_clks 157 0>;
+			assigned-clocks = <&k3_clks 157 0>;
+			assigned-clock-parents = <&k3_clks 157 8>;
+			#clock-cells = <0>;
+		};
+
+		audio_refclk1: clock@82e4 {
+			compatible = "ti,am62-audio-refclk";
+			reg = <0x82e4 0x4>;
+			clocks = <&k3_clks 157 10>;
+			assigned-clocks = <&k3_clks 157 10>;
+			assigned-clock-parents = <&k3_clks 157 18>;
+			#clock-cells = <0>;
+		};
 	};
 
 	dmss: bus@48000000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 8397cb80f559..30b163a9b248 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -60,6 +60,24 @@ epwm_tbclk: clock-controller@4130 {
 			reg = <0x4130 0x4>;
 			#clock-cells = <1>;
 		};
+
+		audio_refclk0: clock@82e0 {
+			compatible = "ti,am62-audio-refclk";
+			reg = <0x82e0 0x4>;
+			clocks = <&k3_clks 157 0>;
+			assigned-clocks = <&k3_clks 157 0>;
+			assigned-clock-parents = <&k3_clks 157 8>;
+			#clock-cells = <0>;
+		};
+
+		audio_refclk1: clock@82e4 {
+			compatible = "ti,am62-audio-refclk";
+			reg = <0x82e4 0x4>;
+			clocks = <&k3_clks 157 10>;
+			assigned-clocks = <&k3_clks 157 10>;
+			assigned-clock-parents = <&k3_clks 157 18>;
+			#clock-cells = <0>;
+		};
 	};
 
 	dmss: bus@48000000 {
-- 
2.25.1


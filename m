Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A8B805DDA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjLESnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLESnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:43:15 -0500
X-Greylist: delayed 1222 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 10:43:22 PST
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4636410D3;
        Tue,  5 Dec 2023 10:43:22 -0800 (PST)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1rAa4A-00BDe6-Vq; Tue, 05 Dec 2023 18:22:43 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm64: dts: imx8mm-venice-gw7: Fix pci sub-nodes
Date:   Tue,  5 Dec 2023 10:22:41 -0800
Message-Id: <20231205182241.2550284-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several schema warnings were fixed in commit
d61c5068729a ("arm64: dts: imx8mm-venice-gw7: Fix pci sub-nodes")
however the node names and the ethernet NIC node were not quite correct.

Fix the node names as the ethernet device should have a node name of
'ethernet' and remove the device_type, #address-cells, #size-cells, and
ranges properties that should only be on busses/bridges.

Fixes: d61c5068729a ("arm64: dts: imx8mm-venice-gw7: Fix pci sub-nodes")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 .../dts/freescale/imx8mm-venice-gw72xx.dtsi    | 18 +++++++-----------
 .../dts/freescale/imx8mm-venice-gw73xx.dtsi    | 18 +++++++-----------
 .../dts/freescale/imx8mm-venice-gw7902.dts     | 10 +++-------
 3 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
index a337e8f20441..31f16f7cf37c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
@@ -157,33 +157,29 @@ &pcie0 {
 				 <&clk IMX8MM_SYS_PLL2_250M>;
 	status = "okay";
 
-	pcie@0,0 {
-		reg = <0x0000 0 0 0 0>;
+	pcie@0 {
 		device_type = "pci";
+		reg = <0x0000 0 0 0 0>;
 		#address-cells = <3>;
 		#size-cells = <2>;
 		ranges;
 
-		pcie@0,0 {
-			reg = <0x0000 0 0 0 0>;
+		pcie@0 {
 			device_type = "pci";
+			reg = <0x0000 0 0 0 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges;
 
-			pcie@3,0 {
-				reg = <0x1800 0 0 0 0>;
+			pcie@3 {
 				device_type = "pci";
+				reg = <0x1800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				ranges;
 
-				eth1: pcie@0,0 {
+				eth1: ethernet@0 {
 					reg = <0x0000 0 0 0 0>;
-					device_type = "pci";
-					#address-cells = <3>;
-					#size-cells = <2>;
-					ranges;
 
 					local-mac-address = [00 00 00 00 00 00];
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
index 2247d1c4e2af..6f5a6d91c95e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
@@ -177,33 +177,29 @@ &pcie0 {
 				 <&clk IMX8MM_SYS_PLL2_250M>;
 	status = "okay";
 
-	pcie@0,0 {
-		reg = <0x0000 0 0 0 0>;
+	pcie@0 {
 		device_type = "pci";
+		reg = <0x0000 0 0 0 0>;
 		#address-cells = <3>;
 		#size-cells = <2>;
 		ranges;
 
-		pcie@0,0 {
-			reg = <0x0000 0 0 0 0>;
+		pcie@0 {
 			device_type = "pci";
+			reg = <0x0000 0 0 0 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges;
 
-			pcie@4,0 {
-				reg = <0x2000 0 0 0 0>;
+			pcie@4 {
 				device_type = "pci";
+				reg = <0x2000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				ranges;
 
-				eth1: pcie@0,0 {
+				eth1: ethernet@0 {
 					reg = <0x0000 0 0 0 0>;
-					device_type = "pci";
-					#address-cells = <3>;
-					#size-cells = <2>;
-					ranges;
 
 					local-mac-address = [00 00 00 00 00 00];
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index 7ef17c2b0e9d..4bb22fdc5d2e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -633,19 +633,15 @@ &pcie0 {
 				 <&clk IMX8MM_SYS_PLL2_250M>;
 	status = "okay";
 
-	pcie@0,0 {
-		reg = <0x0000 0 0 0 0>;
+	pcie@0 {
 		device_type = "pci";
+		reg = <0x0000 0 0 0 0>;
 		#address-cells = <3>;
 		#size-cells = <2>;
 		ranges;
 
-		eth1: pcie@0,0 {
+		eth1: ethernet@0 {
 			reg = <0x0000 0 0 0 0>;
-			device_type = "pci";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
 
 			local-mac-address = [00 00 00 00 00 00];
 		};
-- 
2.25.1


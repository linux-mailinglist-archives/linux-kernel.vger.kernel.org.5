Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1457FFB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376332AbjK3TSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjK3TSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:18:23 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB64B1A4;
        Thu, 30 Nov 2023 11:18:29 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b88f6c3719so831176b6e.0;
        Thu, 30 Nov 2023 11:18:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371909; x=1701976709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JeC+bxbswOpfRxMX3LTa+uNsaqclwQLJC93WcWVC8Y=;
        b=GMC/aIMd2m4vIV5LHCqI+UJTje5MxygfNbg/eSGGUx7IpvmgPPlpjIw+M1bO9I31OE
         xM/ajePI9B2MgiGQVCOLpz52N0PYzYgsbVyBHtb2c/ZX4keeDaJZ80bbgMoppNKZ/PeP
         NlcQ+Mb2yHwZpajEz+zt3eNSyM+OMlAzFJ0TZtA3Lor4ZXF5lXXwPax74jhFHrXyLHIB
         OY6hktj50DStY15lm4rGIFMRDMaZ92nLf2H5DVuX597vCcH2+x/6sRz0/4PgvbomLkS4
         xH6kQoQZnDfhjVKRKo15sbZudxlgVIuhSKlaBXQrTy4+mwQJIT/skNSoZt9iROMM8ri3
         Hpyg==
X-Gm-Message-State: AOJu0Yy20HEDt7rgJgw86iHndXZqh16AZMZexDKi+fHNLWQZQOFdxPHR
        KY/c2/FCX3rjUHDF7b7vWQ==
X-Google-Smtp-Source: AGHT+IHrxv80+4qIsq72TsqaG/MJf8+o6YE4t8B0J7LVU8Og1acit3wxdCuf69m8eCRuJxiNXT033Q==
X-Received: by 2002:a05:6808:1310:b0:3b8:4585:b39b with SMTP id y16-20020a056808131000b003b84585b39bmr688121oiv.5.1701371908856;
        Thu, 30 Nov 2023 11:18:28 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ev25-20020a056808291900b003b2f2724c48sm274641oib.11.2023.11.30.11.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:18:28 -0800 (PST)
Received: (nullmailer pid 2424005 invoked by uid 1000);
        Thu, 30 Nov 2023 19:18:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm-venice: Fix PCI bus nodes
Date:   Thu, 30 Nov 2023 13:18:14 -0600
Message-ID: <20231130191815.2421978-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx8mm-venice boards PCI bus nodes are a complete mess. The
unit-addresses are wrong. The PCI bridge nodes are incomplete missing
"device_type" and "ranges" and just wrong for "#address-cells" and
"#size-cells" values.

All of these issues are reported warnings if anyone bothered to pay
attention. Sigh.

The kernel may have happened to work because it only looks at "reg"
to assign the DT nodes to PCI devices. Based on that, I'm assuming "reg"
is correctly matching the devices present, and the unit-addresses are
wrong. Presumably the bootloader fills in "local-mac-address" with
something valid. Hopefully it too uses "reg" rather than the path.

Fixes: afb424b99e0f ("arm64: dts: imx8mm-venice*: add PCIe support")
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../dts/freescale/imx8mm-venice-gw72xx.dtsi   | 28 +++++++++++--------
 .../dts/freescale/imx8mm-venice-gw73xx.dtsi   | 28 +++++++++++--------
 .../dts/freescale/imx8mm-venice-gw7902.dts    | 12 ++++----
 3 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
index 3a0a10e835a2..ff461b004dc5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
@@ -150,25 +150,29 @@ &pcie0 {
 				 <&clk IMX8MM_SYS_PLL2_250M>;
 	status = "okay";
 
-	pcie@0,0 {
+	pcie@0 {
+		device_type = "pci";
 		reg = <0x0000 0 0 0 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
 
-		pcie@1,0 {
+		pcie@0 {
+			device_type = "pci";
 			reg = <0x0000 0 0 0 0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
 
-			pcie@2,3 {
+			pcie@3 {
+				device_type = "pci";
 				reg = <0x1800 0 0 0 0>;
-				#address-cells = <1>;
-				#size-cells = <0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
 
-				eth1: pcie@5,0 {
+				eth1: ethernet@0 {
 					reg = <0x0000 0 0 0 0>;
-					#address-cells = <1>;
-					#size-cells = <0>;
 
 					local-mac-address = [00 00 00 00 00 00];
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
index d79fe9f62b95..6f5a6d91c95e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
@@ -177,25 +177,29 @@ &pcie0 {
 				 <&clk IMX8MM_SYS_PLL2_250M>;
 	status = "okay";
 
-	pcie@0,0 {
+	pcie@0 {
+		device_type = "pci";
 		reg = <0x0000 0 0 0 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
 
-		pcie@1,0 {
+		pcie@0 {
+			device_type = "pci";
 			reg = <0x0000 0 0 0 0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
 
-			pcie@2,4 {
+			pcie@4 {
+				device_type = "pci";
 				reg = <0x2000 0 0 0 0>;
-				#address-cells = <1>;
-				#size-cells = <0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
 
-				eth1: pcie@6,0 {
+				eth1: ethernet@0 {
 					reg = <0x0000 0 0 0 0>;
-					#address-cells = <1>;
-					#size-cells = <0>;
 
 					local-mac-address = [00 00 00 00 00 00];
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index 06a394a41d7c..4bb22fdc5d2e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -633,15 +633,15 @@ &pcie0 {
 				 <&clk IMX8MM_SYS_PLL2_250M>;
 	status = "okay";
 
-	pcie@0,0 {
+	pcie@0 {
+		device_type = "pci";
 		reg = <0x0000 0 0 0 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
 
-		eth1: pcie@1,0 {
+		eth1: ethernet@0 {
 			reg = <0x0000 0 0 0 0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 
 			local-mac-address = [00 00 00 00 00 00];
 		};
-- 
2.42.0


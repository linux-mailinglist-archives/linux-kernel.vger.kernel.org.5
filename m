Return-Path: <linux-kernel+bounces-128650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5204895D80
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD1BB2619B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDA615D5D1;
	Tue,  2 Apr 2024 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dadBzVxF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB24A59B41;
	Tue,  2 Apr 2024 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089461; cv=none; b=i/lVL1MM8ysMEZ3FNZjaelwYTh4m/MyP6d/sWzCo2OqXA5H4GD46hqZXOhxQbcf0lgdqSYbfndchCM+D5/tKe810C4Dcz+x+K3GUO2DgwcOR9OKGZL0rHwOjprCvL43Lgla+NfHnAXPi7uKjiviuJWpL+aw448sxalvxVtGaDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089461; c=relaxed/simple;
	bh=ueMPMa7Wa04+ZFktkd2Z6B4anKiLlzjqo1vxs3xrVm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NK/ARPqlTztucd5YiTz6k7v2jWlrF/6kT3PuMGTT+xaeA4SiTab/5pm7EQSJff26FNZNlgaRJpepdH8QqZxh753AY7xWGKrYLjVj7PPIjqdk6e/fR+mTtAHztoGLXhd8taYOJu9VYP5chKEk77jM9jPDFWGmLEBVvL16wvPaQrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dadBzVxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D310C43394;
	Tue,  2 Apr 2024 20:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712089461;
	bh=ueMPMa7Wa04+ZFktkd2Z6B4anKiLlzjqo1vxs3xrVm0=;
	h=From:To:Cc:Subject:Date:From;
	b=dadBzVxF0eifc7/RW5NahmvsfQtrZYmXy4zPDfmszEjxWMsKn+HiiNHNBUm01JxYu
	 cAxM+B741Lhl7hPPxWl3u/sI+tm9UXIS808eD7ogPzIpmCMuI7m6ZkMz1U1t5t1030
	 nXjPGxq0r+s6QZUG0EQAFe8MRl5RSqsAxgaYpr+GD8RapWqws1PCcAJeJew7Qhar2O
	 +pLmMbwruGXhTXSkUANq5LkOgi6Dz8VYHt8UPQjB/lm7biLyDG367t6UUCHMNE4qY6
	 cUygLGS3GSHTXts0wQMfCSxRPVzoGiGp9fmzYbEeap1SI+VFMPlkxIVILjnHUgT6Cp
	 RxB9QkE6O4fjQ==
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: mfd: syscon: Add missing simple syscon compatibles
Date: Tue,  2 Apr 2024 15:24:11 -0500
Message-ID: <20240402202413.757283-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add various "simple" syscon compatibles which were undocumented or
still documented with old text bindings.

apm,xgene-csw, apm,xgene-efuse, apm,xgene-mcb, apm,xgene-rb,
fsl,ls1088a-reset, marvell,armada-3700-cpu-misc,
mediatek,mt2712-pctl-a-syscfg, mediatek,mt6397-pctl-pmic-syscfg, and
mediatek,mt8173-pctl-a-syscfg were all undocumented, but are in use
already. Remove the old text binding docs for the others.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../arm/altera/socfpga-sdram-controller.txt   | 12 -------
 .../devicetree/bindings/arm/apm/scu.txt       | 17 ----------
 .../bindings/arm/marvell/armada-37xx.txt      | 32 -------------------
 .../bindings/mfd/brcm,iproc-cdru.txt          | 16 ----------
 .../bindings/mfd/brcm,iproc-mhb.txt           | 18 -----------
 .../devicetree/bindings/mfd/syscon.yaml       | 15 +++++++++
 6 files changed, 15 insertions(+), 95 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/apm/scu.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/brcm,iproc-cdru.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/brcm,iproc-mhb.txt

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
deleted file mode 100644
index 77ca635765e1..000000000000
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-Altera SOCFPGA SDRAM Controller
-
-Required properties:
-- compatible : Should contain "altr,sdr-ctl" and "syscon".
-  syscon is required by the Altera SOCFPGA SDRAM EDAC.
-- reg : Should contain 1 register range (address and length)
-
-Example:
-	sdr: sdr@ffc25000 {
-		compatible = "altr,sdr-ctl", "syscon";
-		reg = <0xffc25000 0x1000>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/apm/scu.txt b/Documentation/devicetree/bindings/arm/apm/scu.txt
deleted file mode 100644
index b45be06625fd..000000000000
--- a/Documentation/devicetree/bindings/arm/apm/scu.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-APM X-GENE SoC series SCU Registers
-
-This system clock unit contain various register that control block resets,
-clock enable/disables, clock divisors and other deepsleep registers.
-
-Properties:
- - compatible : should contain two values. First value must be:
-		   - "apm,xgene-scu"
-		second value must be always "syscon".
-
- - reg : offset and length of the register set.
-
-Example :
-	scu: system-clk-controller@17000000 {
-		compatible = "apm,xgene-scu","syscon";
-		reg = <0x0 0x17000000 0x0 0x400>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
deleted file mode 100644
index 29fa93dad52b..000000000000
--- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Power management
-----------------
-
-For power management (particularly DVFS and AVS), the North Bridge
-Power Management component is needed:
-
-Required properties:
-- compatible     : should contain "marvell,armada-3700-nb-pm", "syscon";
-- reg            : the register start and length for the North Bridge
-		    Power Management
-
-Example:
-
-nb_pm: syscon@14000 {
-	compatible = "marvell,armada-3700-nb-pm", "syscon";
-	reg = <0x14000 0x60>;
-}
-
-AVS
----
-
-For AVS an other component is needed:
-
-Required properties:
-- compatible     : should contain "marvell,armada-3700-avs", "syscon";
-- reg            : the register start and length for the AVS
-
-Example:
-avs: avs@11500 {
-	compatible = "marvell,armada-3700-avs", "syscon";
-	reg = <0x11500 0x40>;
-}
diff --git a/Documentation/devicetree/bindings/mfd/brcm,iproc-cdru.txt b/Documentation/devicetree/bindings/mfd/brcm,iproc-cdru.txt
deleted file mode 100644
index 82f82e069563..000000000000
--- a/Documentation/devicetree/bindings/mfd/brcm,iproc-cdru.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Broadcom iProc Chip Device Resource Unit (CDRU)
-
-Various Broadcom iProc SoCs have a set of registers that provide various
-chip specific device and resource configurations. This node allows access to
-these CDRU registers via syscon.
-
-Required properties:
-- compatible: should contain:
-		"brcm,sr-cdru", "syscon" for Stingray
-- reg: base address and range of the CDRU registers
-
-Example:
-	cdru: syscon@6641d000 {
-		compatible = "brcm,sr-cdru", "syscon";
-		reg = <0 0x6641d000 0 0x400>;
-	};
diff --git a/Documentation/devicetree/bindings/mfd/brcm,iproc-mhb.txt b/Documentation/devicetree/bindings/mfd/brcm,iproc-mhb.txt
deleted file mode 100644
index 4421e9771b8a..000000000000
--- a/Documentation/devicetree/bindings/mfd/brcm,iproc-mhb.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Broadcom iProc Multi Host Bridge (MHB)
-
-Certain Broadcom iProc SoCs have a multi host bridge (MHB) block that controls
-the connection and configuration of 1) internal PCIe serdes; 2) PCIe endpoint
-interface; 3) access to the Nitro (network processing) engine
-
-This node allows access to these MHB registers via syscon.
-
-Required properties:
-- compatible: should contain:
-		"brcm,sr-mhb", "syscon" for Stingray
-- reg: base address and range of the MHB registers
-
-Example:
-	mhb: syscon@60401000 {
-		compatible = "brcm,sr-mhb", "syscon";
-		reg = <0 0x60401000 0 0x38c>;
-	};
diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 9d55bee155ce..0327e779e327 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -38,11 +38,20 @@ properties:
               - allwinner,sun8i-h3-system-controller
               - allwinner,sun8i-v3s-system-controller
               - allwinner,sun50i-a64-system-controller
+              - altr,sdr-ctl
               - amd,pensando-elba-syscon
+              - apm,xgene-csw
+              - apm,xgene-efuse
+              - apm,xgene-mcb
+              - apm,xgene-rb
+              - apm,xgene-scu
               - brcm,cru-clkset
+              - brcm,sr-cdru
+              - brcm,sr-mhb
               - freecom,fsg-cs2-system-controller
               - fsl,imx93-aonmix-ns-syscfg
               - fsl,imx93-wakeupmix-syscfg
+              - fsl,ls1088a-reset
               - hisilicon,dsa-subctrl
               - hisilicon,hi6220-sramctrl
               - hisilicon,pcie-sas-subctrl
@@ -51,9 +60,15 @@ properties:
               - intel,lgm-syscon
               - loongson,ls1b-syscon
               - loongson,ls1c-syscon
+              - marvell,armada-3700-cpu-misc
+              - marvell,armada-3700-nb-pm
+              - marvell,armada-3700-avs
               - marvell,armada-3700-usb2-host-misc
+              - mediatek,mt2712-pctl-a-syscfg
+              - mediatek,mt6397-pctl-pmic-syscfg
               - mediatek,mt8135-pctl-a-syscfg
               - mediatek,mt8135-pctl-b-syscfg
+              - mediatek,mt8173-pctl-a-syscfg
               - mediatek,mt8365-syscfg
               - microchip,lan966x-cpu-syscon
               - microchip,sparx5-cpu-syscon
-- 
2.43.0



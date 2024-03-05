Return-Path: <linux-kernel+bounces-92151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8C0871BF5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815571F22D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBB65813A;
	Tue,  5 Mar 2024 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv7Br/f7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548FC33D5;
	Tue,  5 Mar 2024 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634922; cv=none; b=R39qzQF3PQvA4j5to7k/MSJbr20HtQ6bSngd0T1vpe/tIHoE9PNdaY7PQY/ezmP3HC1lhxKIDA9yTsIty5ARygUuELGdf8A6MvE4+OC1T59kiCEhcnkReevHK4p4QLLr9Wp4vdxcHHreEg1Mv5X3uru3iySvfPLya5SKNBGqrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634922; c=relaxed/simple;
	bh=FbE8QWyceyw6MPgSjjLEwzvEk0fumYCrTj/GDmXXnmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=URSdtDFnN+Mifx25lFWeksIiDH+O8vxCr3NzUeLeewbdpnGrU2Qsnza9EJUR+y+7qZ23S3ATNAtWr+9L3p4g4OhcVYgMvd1DyWxvZL6lFVpw5XaXL7MWOLdkR8IB0tGqsXsdKq2Hu69QKAoV9ev7Z597qlnQjUQ7SxNJKTOBR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv7Br/f7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F86EC433F1;
	Tue,  5 Mar 2024 10:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709634921;
	bh=FbE8QWyceyw6MPgSjjLEwzvEk0fumYCrTj/GDmXXnmI=;
	h=From:Date:Subject:To:Cc:From;
	b=kv7Br/f73CNd/pjg8ShjwNXLSjd/MrdxPKpecCEuzxgxbW/wRcLIJwscGP1U11dej
	 cXtZ6LV9lGgGEd5EwiGBUZ7X06YEGf+swstS7pWhUVjzWWhz8z20UlhoXwheULv1yz
	 xcbwsUbrUAhnANwh+2Cm5w6prbBeXFp/0Z8V51GFBQ4gBN0DgB+NFgjZPSQW2RgKmt
	 4HTjqCojL0jZB2HblmLPVN5+HrFsvMdNOYMwwNmht0mK9rNkgvtmbWNgrJ+reVxa4Q
	 vSvicNz5dcoRB9ML2qPgwTjJC1V/+lkJkJgs96eZu7xq2gyY9psOaHqt6Es40udhE3
	 cATt7Qr8aRD3w==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 05 Mar 2024 12:35:11 +0200
Subject: [PATCH v4] arm64: dts: ti: am642-evm: Add overlay for NAND
 expansion card
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-for-v6-9-am642-evm-nand-v4-1-641a4e9217a6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAF715mUC/x3MTQqAIBBA4avErBsws9+rRAvLsWahhYIE4d2Tl
 t/ivRciBaYIc/VCoMSRL1+g6gr2U/uDkE0xSCGVaEWH9gqYepxQu15JpOTQa29wM4M2jR3FSBO
 U+g5k+fnPy5rzB1QAPEdpAAAA
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: afd@ti.com, srk@ti.com, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=7396; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=FbE8QWyceyw6MPgSjjLEwzvEk0fumYCrTj/GDmXXnmI=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl5vVm4E9hGwiMHqhsiASt9qeKfYBQCxLE1hfTK
 tYzolFnSuaJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZeb1ZgAKCRDSWmvTvnYw
 kwF0D/0bFbfw+FDQuM/Yj+lyjCI9xpAyXOX15tshQyaV4isZ027Fl5FAC9tvyTHpfMtH/mObmaW
 juSZ0eDZA37/39/20cE6/1X/NpwGpAmh4VdWi0R7im6Ki8cFDXz647W/5hZAmNtY/0U2DL5ssDw
 Ewo5Qo2j+8m1luzjqOw8m2a+ReSJftXPERLW3Gfsh2B5Q0OlGCPU/rz0mKucQieoHCf3+JkeIFG
 Au7YYkxTCFJWfz8XjUpObINrbtlW15/b1VowpJPdbHQlu/zLy/MDjd31bIAgMvak+W1s3rckktI
 mfI2GibtEWdij3Hvvcm4+hFBZV80GhNRyUEcFYJpDtkQCwLbMeEm/D4moasSfVtsBij1D1XTZN0
 CfCrxq4nu2uW7AUgjcVkwUvI2jp4b5bm+Or1p0+khbSR0w6saJXTxCMLmbAqyYmXltw81CGTbr/
 r/zLfdO7SVKLxDH+X6zFzviX1X5qNWYdeT/OlAxMG6oi5zQ9GgLeVMDc9sOCMI3ixvav2fgL4yM
 7LuMY7elFNIacxann4mOYsc6ySjLCLMnKG62CpG8nWPy2ehKzRYD1m/YmzhBwUc7NRgBbNwQGMp
 y+ZiH4cvu9oOjsWx5BHW3nftWnfqsAJ0b3LmwOiw8ZTLeUyHjrODTBOZxv8FmPCMPC/PPAZwoip
 kDuC7b8nnMAW90Q==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

The NAND expansion card plugs in over the HSE (High Speed Expansion)
connector. Add support for it.

We add the ranges property to the GPMC node instead of the NAND
overlay file to prevent below warnings.

/fragment@3/__overlay__: Relying on default #address-cells value
/fragment@3/__overlay__: Relying on default #size-cells value

As GPMC is dedicated for NAND use on this board, it should be OK.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changelog:
v4:
- Rebased on ti-next/ti-k3-dt-for-v6.9

v3:
https://lore.kernel.org/all/20240123201312.23187-1-rogerq@kernel.org/
- Fix dtc warning by moving ranges property into the GPMC node
- update licence to GPL-2.0-only OR MIT and Copyright year to 2024
- don't drop k3-am642-evm.dtb target from Makefile

v2:
- Don't leave k3-am642-evm-nand.dtbo as an orphan. Make k3-am642-evm-nand.dtb
with the overlay applied on the base board.
---
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso | 139 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |   4 +
 3 files changed, 145 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 9a722c2473fb..8cceca6d6756 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -47,6 +47,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-pcie.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-usb3.dtb
+k3-am642-evm-nand-dtbs := k3-am642-evm.dtb k3-am642-evm-nand.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-nand.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
new file mode 100644
index 000000000000..3d1c2111ec88
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * DT overlay for HSE NAND expansion card on AM642 EVM
+ *
+ * Copyright (C) 2021-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "k3-pinctrl.h"
+
+&main_pmx0 {
+	gpmc0_pins_default: gpmc0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0094, PIN_INPUT, 7) /* (T19) GPMC0_BE1n.GPIO0_36 */
+
+			AM64X_IOPAD(0x003c, PIN_INPUT, 0) /* (T20) GPMC0_AD0 */
+			AM64X_IOPAD(0x0040, PIN_INPUT, 0) /* (U21) GPMC0_AD1 */
+			AM64X_IOPAD(0x0064, PIN_INPUT, 0) /* (R16) GPMC0_AD10 */
+			AM64X_IOPAD(0x0068, PIN_INPUT, 0) /* (W20) GPMC0_AD11 */
+			AM64X_IOPAD(0x006c, PIN_INPUT, 0) /* (W21) GPMC0_AD12 */
+			AM64X_IOPAD(0x0070, PIN_INPUT, 0) /* (V18) GPMC0_AD13 */
+			AM64X_IOPAD(0x0074, PIN_INPUT, 0) /* (Y21) GPMC0_AD14 */
+			AM64X_IOPAD(0x0078, PIN_INPUT, 0) /* (Y20) GPMC0_AD15 */
+			AM64X_IOPAD(0x0044, PIN_INPUT, 0) /* (T18) GPMC0_AD2 */
+			AM64X_IOPAD(0x0048, PIN_INPUT, 0) /* (U20) GPMC0_AD3 */
+			AM64X_IOPAD(0x004c, PIN_INPUT, 0) /* (U18) GPMC0_AD4 */
+			AM64X_IOPAD(0x0050, PIN_INPUT, 0) /* (U19) GPMC0_AD5 */
+			AM64X_IOPAD(0x0054, PIN_INPUT, 0) /* (V20) GPMC0_AD6 */
+			AM64X_IOPAD(0x0058, PIN_INPUT, 0) /* (V21) GPMC0_AD7 */
+			AM64X_IOPAD(0x005c, PIN_INPUT, 0) /* (V19) GPMC0_AD8 */
+			AM64X_IOPAD(0x0060, PIN_INPUT, 0) /* (T17) GPMC0_AD9 */
+			AM64X_IOPAD(0x0098, PIN_INPUT_PULLUP, 0) /* (W19) GPMC0_WAIT0 */
+			AM64X_IOPAD(0x009c, PIN_INPUT_PULLUP, 0) /* (Y18) GPMC0_WAIT1 */
+			AM64X_IOPAD(0x00a8, PIN_OUTPUT_PULLUP, 0) /* (R19) GPMC0_CSn0 */
+			AM64X_IOPAD(0x00ac, PIN_OUTPUT_PULLUP, 0) /* (R20) GPMC0_CSn1 */
+			AM64X_IOPAD(0x00b0, PIN_OUTPUT_PULLUP, 0) /* (P19) GPMC0_CSn2 */
+			AM64X_IOPAD(0x00b4, PIN_OUTPUT_PULLUP, 0) /* (R21) GPMC0_CSn3 */
+			AM64X_IOPAD(0x007c, PIN_OUTPUT, 0) /* (R17) GPMC0_CLK */
+			AM64X_IOPAD(0x0084, PIN_OUTPUT, 0) /* (P16) GPMC0_ADVn_ALE */
+			AM64X_IOPAD(0x0088, PIN_OUTPUT, 0) /* (R18) GPMC0_OEn_REn */
+			AM64X_IOPAD(0x008c, PIN_OUTPUT, 0) /* (T21) GPMC0_WEn */
+			AM64X_IOPAD(0x0090, PIN_OUTPUT, 0) /* (P17) GPMC0_BE0n_CLE */
+			AM64X_IOPAD(0x00a0, PIN_OUTPUT_PULLUP, 0) /* (N16) GPMC0_WPn */
+			AM64X_IOPAD(0x00a4, PIN_OUTPUT, 0) /* (N17) GPMC0_DIR */
+		>;
+	};
+};
+
+&main_gpio0 {
+	gpio0-36 {
+		gpio-hog;
+		gpios = <36 0>;
+		input;
+		line-name = "GPMC0_MUX_DIR";
+	};
+};
+
+&elm0 {
+	status = "okay";
+};
+
+&gpmc0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpmc0_pins_default>;
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	nand@0,0 {
+		compatible = "ti,am64-nand";
+		reg = <0 0 64>;		/* device IO registers */
+		interrupt-parent = <&gpmc0>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc0 0 GPIO_ACTIVE_HIGH>;	/* gpmc_wait0 */
+		ti,nand-xfer-type = "prefetch-polled";
+		ti,nand-ecc-opt = "bch8";	/* BCH8: Bootrom limitation */
+		ti,elm-id = <&elm0>;
+		nand-bus-width = <8>;
+		gpmc,device-width = <1>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <40>;
+		gpmc,cs-wr-off-ns = <40>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <25>;
+		gpmc,adv-wr-off-ns = <25>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <20>;
+		gpmc,oe-on-ns = <3>;
+		gpmc,oe-off-ns = <30>;
+		gpmc,access-ns = <30>;
+		gpmc,rd-cycle-ns = <40>;
+		gpmc,wr-cycle-ns = <40>;
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "NAND.tiboot3";
+				reg = <0x00000000 0x00200000>;	/* 2M */
+			};
+			partition@200000 {
+				label = "NAND.tispl";
+				reg = <0x00200000 0x00200000>;	/* 2M */
+			};
+			partition@400000 {
+				label = "NAND.tiboot3.backup";	/* 2M */
+				reg = <0x00400000 0x00200000>;	/* BootROM looks at 4M */
+			};
+			partition@600000 {
+				label = "NAND.u-boot";
+				reg = <0x00600000 0x00400000>;	/* 4M */
+			};
+			partition@a00000 {
+				label = "NAND.u-boot-env";
+				reg = <0x00a00000 0x00040000>;	/* 256K */
+			};
+			partition@a40000 {
+				label = "NAND.u-boot-env.backup";
+				reg = <0x00a40000 0x00040000>;	/* 256K */
+			};
+			partition@a80000 {
+				label = "NAND.file-system";
+				reg = <0x00a80000 0x3f580000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 53fe1d065ddb..44ac324fc7bb 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -818,3 +818,7 @@ icssg1_phy1: ethernet-phy@f {
 		rx-internal-delay-ps = <2000>;
 	};
 };
+
+&gpmc0 {
+	ranges = <0 0 0x00 0x51000000 0x01000000>; /* CS0 space. Min partition = 16MB */
+};

---
base-commit: bbef42084cc170cbfc035bf784f2ff055c939d7e
change-id: 20240305-for-v6-9-am642-evm-nand-bd7ad1f808e9

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>



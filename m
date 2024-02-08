Return-Path: <linux-kernel+bounces-58191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10BF84E28C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F091C25E72
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0738E76C75;
	Thu,  8 Feb 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLjiG6vV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374317CF2B;
	Thu,  8 Feb 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400350; cv=none; b=cCfLYp0Gs6WE/rgsp6A3HzKn19iq2HFPlfAY6uL0sQIu38AfAgs56nzFMAwy3T8bhqPOHfDdKvMte5gokdiD2A6GJ1I0yKZ3dprc13D+/bAVDX66Kh+AwYuQ2T/QwbtwlxNG8a3P4dRRXN949guopGI0D1/zSL2yz/EEoSuinKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400350; c=relaxed/simple;
	bh=kYztuwBHKj80b91I8rCKfMS/3L636fHRS+pTX9G+Poc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q4zbr8TXGcVGYaaGYUH98oCrLyR+jWQtU3zXeaFwYBGKxeGzScYW4esxdXbN5/F/t7qK5WAFo+JLht0/LRGAbjWH12IECW2o8NnUFlkNBSH3YJLRIWYXP1XlmP63vkWhRwwn0P2A3+4miIGeV+5POQnHvcn8Iua3gsCq0620wCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLjiG6vV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A4AC43399;
	Thu,  8 Feb 2024 13:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707400349;
	bh=kYztuwBHKj80b91I8rCKfMS/3L636fHRS+pTX9G+Poc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PLjiG6vVM0s3p+fyOguNaTY5WlAKfZxfIpsNuncBhDt7LZOasVt8cHoQk7tYOJDms
	 Jcbzwh11Hn8AEcf9gl3qOW0T0FglczA1D8pJkfSGI9rgfNkPiVLE0aEirCIaZQZSHV
	 eKEgEcgfgg2uvLYB/pDUdzs+QbVdFJ7HIx0rQZzE1SY+r0itspBDaU3I3P0uzYjZ9D
	 Oa/zMHYj17dNI3c59dxN2q2hHgwgRcwLVATEklo0NG37x6vClOsqyWe2OGNUd4OBVp
	 u4FE0EpwHYCVbzqIFcnKY8vsgYvA/1uPoZTj8E18tCZhk7ytQGI6fqszQ5T2jVWLfw
	 g8kZY4Xq+qvgQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Thu, 08 Feb 2024 15:51:45 +0200
Subject: [PATCH v2 3/3] arm64: dts: ti: Add DT overlay for PCIe + USB3.0
 SERDES personality card
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-for-v6-9-am65-overlays-2-0-v2-3-70bae3e91597@kernel.org>
References: <20240208-for-v6-9-am65-overlays-2-0-v2-0-70bae3e91597@kernel.org>
In-Reply-To: <20240208-for-v6-9-am65-overlays-2-0-v2-0-70bae3e91597@kernel.org>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andrew Davis <afd@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Aradhya Bhatia <a-bhatia1@ti.com>, Nikhil Devshatwar <nikhil.nd@ti.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>, srk@ti.com, 
 r-gunasekaran@ti.com, Kishon Vijay Abraham I <kishon@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3697; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=QXycpi9i6PTUYgnWc7XUT7n2X/NNWxiXbCqvtx5c3DI=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBlxNyNOGciqQDX2eC55qyEZqsPQY3lP/ckM0rjB
 ZnwpftmC1GJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZcTcjQAKCRDSWmvTvnYw
 kxgqD/9OMh55y/8CG9uEpPg4NQ2Xa4ZnVgCISNYgI6jzVxdmuO1yCTrfSBDVV7bJrTgNAOdd2Mo
 DV1peZ6MWhLmagQhOm1SfZARFeOYcNXtEi15Y662wtQdQxIDOQLWAYt+W7m40Jv5r3ZyXm3Qxfe
 5/8z0VQcLXMWcQivshpAWF/dUGuypxlGjiWOCVwZbd+i+Q+2yLpIIw9rut17hrQD0XQybCg5PuW
 C4GfpmpebVGRuzFz8pzdL8d6fbPut935RZKlgF3af7JRDJjyHHFMBDBBPP9H8WU4YF6WugogIia
 EeSFqB13Kf8RDzuFYwZeTnhkaBT7NR2vIJR+0KFpOqoTB/ZUMBEP+5ZTcLKjWfvicOsUklqMIq9
 f73UnzthNc1O3St/71eBdZtTqNhuD09xEdzLUKVyfqN8rcoHUTePyZ/+GyFObWprB9ZDiOAwiuv
 XGBOKJHBGjMSs8O/Y7Sdn0fFlD5BjWObTAA66e/vasSiYq5TVnDQH/vuiWgjJHb2jJfcw1SFLz7
 7iQ2B8eSV2e0BBBrjjoQx5jDA2kjpOvrUzTB6RN+f3bf7EAlbJnM4RmGDIOGM4zRuh5Hu2TZsDO
 +DmU84NdtdqKT4/RGVkrViYNZdT95vf4izZ1wjMtezybht/TB4mNrpnd7QMemG8SIbNzKGXENhr
 5azW5u176kcnjvQ==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

From: Kishon Vijay Abraham I <kishon@ti.com>

Add overlay for PCIe (uses the second instance of PCIe in AM654x) and
USB3.0 SERDES personality card

The PCI3/USB3 card is provided with the AM65x GP EVM configurtion [1]
so apply the overlay to k3-am654-gp-evm.dtb

[1] https://www.ti.com/lit/ug/spruim7/spruim7.pdf

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changelog:

v2:
- drop PCIe endpoint settings as it no longer exists in base tree.

v1: https://lore.kernel.org/all/20240126114530.40913-4-rogerq@kernel.org/
---
 arch/arm64/boot/dts/ti/Makefile                |  5 ++-
 arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso | 61 ++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index f534c373c958..75033b6e8693 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -45,7 +45,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
 
 # Boards with AM65x SoC
-k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb k3-am654-base-board-rocktech-rk101-panel.dtbo
+k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb \
+	k3-am654-base-board-rocktech-rk101-panel.dtbo \
+	k3-am654-pcie-usb3.dtbo
 k3-am654-evm-dtbs := k3-am654-base-board.dtb k3-am654-icssg2.dtbo
 k3-am654-idk-dtbs := k3-am654-evm.dtb k3-am654-idk.dtbo k3-am654-pcie-usb2.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
@@ -59,6 +61,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am654-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-idk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board-rocktech-rk101-panel.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am654-pcie-usb2.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am654-pcie-usb3.dtbo
 
 # Boards with J7200 SoC
 k3-j7200-evm-dtbs := k3-j7200-common-proc-board.dtb k3-j7200-evm-quad-port-eth-exp.dtbo
diff --git a/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso
new file mode 100644
index 000000000000..e463163f2b7b
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * DT overlay for SERDES personality card: 1lane PCIe + USB3.0 DRD on AM654 EVM
+ *
+ * Copyright (C) 2018-2024 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-am654-serdes.h>
+
+#include "k3-pinctrl.h"
+
+&serdes1 {
+	status = "okay";
+};
+
+&pcie1_rc {
+	num-lanes = <1>;
+	phys = <&serdes1 PHY_TYPE_PCIE 0>;
+	phy-names = "pcie-phy0";
+	reset-gpios = <&pca9555 5 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&main_pmx0 {
+	usb0_pins_default: usb0_pins_default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0) /* (AD9) USB0_DRVVBUS */
+		>;
+	};
+};
+
+&serdes0 {
+	status = "okay";
+	assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
+	assigned-clock-parents = <&k3_clks 153 7>, <&k3_clks 153 4>;
+};
+
+&dwc3_0 {
+	status = "okay";
+	assigned-clock-parents = <&k3_clks 151 4>,      /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
+	<&k3_clks 151 8>;      /* set PIPE3_TXB_CLK to WIZ8B2M4VSB */
+	phys = <&serdes0 PHY_TYPE_USB3 0>;
+	phy-names = "usb3-phy";
+};
+
+&usb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins_default>;
+	dr_mode = "host";
+	maximum-speed = "super-speed";
+	snps,dis-u1-entry-quirk;
+	snps,dis-u2-entry-quirk;
+};
+
+&usb0_phy {
+	status = "okay";
+};

-- 
2.34.1



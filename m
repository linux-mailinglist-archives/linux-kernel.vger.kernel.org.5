Return-Path: <linux-kernel+bounces-40061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6310883D98E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F6A295E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A96175BC;
	Fri, 26 Jan 2024 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQd7Shze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A5C1AAA5;
	Fri, 26 Jan 2024 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706269545; cv=none; b=JRKv0gGOdzcRGvOzxH2eLitM56HewjOP44v1OyCZb+p36qN2YlTyWhwUQvHF8mBAXfQ+KaAJ4RZ1NLC+Qo1tuOItggR9qpUxDUfYN7yKjIo3FdDc7dSLmOFPv1NTKiGVWhY+7/or7XwDpOnonVQPMjbO4aUEg0L2VJ8/g3wfitk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706269545; c=relaxed/simple;
	bh=OuirhCCHZ98J4MrOZEW1SlsIyTfgSodFP1d/+6512CQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qN8UOjLrxoz0HN6ORa1nsLj5aSsYROEQlBog4zOgy+Eney6Nd/Jw62Zc67TfU4qGFTdkRFtSgWf2ee7xWhFcXjqiXxJYoAzs6nOIXJf+uU7j4gXjXHihKdOPyc4eHIP7w103GzMegcv5Cl9BHTK/rj80SpzGMCj6060y+MYZnUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQd7Shze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2C7C433F1;
	Fri, 26 Jan 2024 11:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706269545;
	bh=OuirhCCHZ98J4MrOZEW1SlsIyTfgSodFP1d/+6512CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQd7Shzed29xtU+vRhQ/dTiK9gLFasan4qNcpfCP2Kq3lYs4PQ2hpYM5somYXQiwC
	 Muaj9S7YySwYdbfMKagl/wm+9uGcmog5dpvd1LQfDhdnfO6FIi5wFKJGkTrTbzurf1
	 BxRo7DEL4E+AcOOgYf6hiUQngPXHyDB9QLE8hy4wF79mTo4Colp5vTMFKo3KIA8HLD
	 cy0/9ulWZEk55KnXoUMrDlMbNbV2fI1nvj+4IXQdNWKXCcFMaJjgXLzz8s7/je5EAC
	 GBSyrBYpOcDBxx6XKut0Lo+lIsjqKt8GXJs5GiIdK62xnKiQTvjL8Dn6zE5MCDobty
	 KcDseFxmxgvKQ==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	vigneshr@ti.com
Cc: afd@ti.com,
	a-bhatia1@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	srk@ti.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@ti.com>,
	Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: Add DT overlay for PCIe + USB2.0 SERDES personality card
Date: Fri, 26 Jan 2024 13:45:29 +0200
Message-Id: <20240126114530.40913-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126114530.40913-1-rogerq@kernel.org>
References: <20240126114530.40913-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roger Quadros <rogerq@ti.com>

Enable both Serdes and PCIe dt nodes in order to get PCIe working in
the SERDES PCIe x2 personality card.

The daughter card also has a USB 2.0 dual-role port. As the base board
already supports a 2.0 dual-role port, enable the port on the SERDES
card to be a host only port.

This will prevent user confusion as having 2 ports in device mode often
leads to confusion as to which port is bound to the gadget function driver.

The PCIe x2 card is provided with the AM65x IDK configuration [1]
so apply the overlay to k3-am654-idk.dtb

[1] https://www.ti.com/lit/ug/spruim6a/spruim6a.pdf

Co-developed-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  3 +-
 .../arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso | 65 +++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 08ce34d21d5d..3c008623b693 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -47,7 +47,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
 # Boards with AM65x SoC
 k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb k3-am654-base-board-rocktech-rk101-panel.dtbo
 k3-am654-evm-dtbs := k3-am654-base-board.dtb k3-am654-icssg2.dtbo
-k3-am654-idk-dtbs := k3-am654-evm.dtb k3-am654-idk.dtbo
+k3-am654-idk-dtbs := k3-am654-evm.dtb k3-am654-idk.dtbo k3-am654-pcie-usb2.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
@@ -58,6 +58,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am654-gp-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-idk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board-rocktech-rk101-panel.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am654-pcie-usb2.dtbo
 
 # Boards with J7200 SoC
 k3-j7200-evm-dtbs := k3-j7200-common-proc-board.dtb k3-j7200-evm-quad-port-eth-exp.dtbo
diff --git a/arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso
new file mode 100644
index 000000000000..477027b033da
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * DT overlay for SERDES personality card: 2lane PCIe + USB2.0 Host on AM654 EVM
+ *
+ * Copyright (C) 2018-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-am654-serdes.h>
+#include "k3-pinctrl.h"
+
+&serdes0 {
+	assigned-clocks = <&k3_clks 153 4>,
+			  <&serdes0 AM654_SERDES_CMU_REFCLK>,
+			  <&serdes0 AM654_SERDES_RO_REFCLK>;
+	assigned-clock-parents = <&k3_clks 153 8>,
+				 <&k3_clks 153 4>,
+				 <&k3_clks 153 4>;
+	status = "okay";
+};
+
+&serdes1 {
+	assigned-clocks = <&serdes1 AM654_SERDES_CMU_REFCLK>;
+	assigned-clock-parents = <&serdes0 AM654_SERDES_RO_REFCLK>;
+	status = "okay";
+};
+
+&pcie0_rc {
+	num-lanes = <2>;
+	phys = <&serdes0 PHY_TYPE_PCIE 1>, <&serdes1 PHY_TYPE_PCIE 1>;
+	phy-names = "pcie-phy0", "pcie-phy1";
+	reset-gpios = <&pca9555 5 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&pcie0_ep {
+	num-lanes = <2>;
+	phys = <&serdes0 PHY_TYPE_PCIE 1>, <&serdes1 PHY_TYPE_PCIE 1>;
+	phy-names = "pcie-phy0", "pcie-phy1";
+};
+
+&main_pmx0 {
+       usb0_pins_default: usb0-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0) /* (AD9) USB0_DRVVBUS */
+		>;
+	};
+};
+
+&dwc3_0 {
+	status = "okay";
+};
+
+&usb0_phy {
+	status = "okay";
+};
+
+&usb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins_default>;
+	dr_mode = "host";
+};
-- 
2.34.1



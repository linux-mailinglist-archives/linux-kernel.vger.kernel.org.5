Return-Path: <linux-kernel+bounces-40062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30C283D991
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76434296163
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2035F17BAF;
	Fri, 26 Jan 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOHHiy1E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677E51B5AC;
	Fri, 26 Jan 2024 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706269549; cv=none; b=u0Urnz/0n3tFUHRqRbbXc6EWoj8qRmwY80809vB9+KQmODlv5i+WzI3Xpj3Z4jBwTqkutdN9UQ/4Hzh+RlUIVSYsnjdQwjb0WrXskPDHacOGDXO/4F/1KnTBm58ACfUhPrQdv3Y/L/sboS5ki4KjnWqBRkgaebvmspPIcXIsvF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706269549; c=relaxed/simple;
	bh=IGnu6V+EK7ZTYpTxE7bCrz1gKJQ+SJzi8haKHQ1r4dE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r7C0eMWUgoqmEESmDy+E06Odkg/gEVC5PpJf1seoFCuVLlO3xtttgYyLttmTqZl73KcqSXMX8jH/7fxQvhc3e2yF9SawSDd7PO8d0ByrFvJw53i6vBqrK36KQH7d1db3fv9WXSei667js9uBVss/LADa5ymu1oQKaVyL/q+5sWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOHHiy1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A258FC433F1;
	Fri, 26 Jan 2024 11:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706269548;
	bh=IGnu6V+EK7ZTYpTxE7bCrz1gKJQ+SJzi8haKHQ1r4dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DOHHiy1EzqUQyK/xafhAoVcmG/8Dj3yEVLHJdVM5+RXNgVfu98JNgVVKCFHyCqExk
	 udervGxyrCnL5rfvvkzCQmH0QREqAwl+kMpGUOBpLGkHWDldVinLn6B3CU1yIRplvn
	 s2GFd0kMEyMU2Gz0BQ/PdMw+1qPzEi1LVlYt0Xwp/Iu+4gsDNB2xqIqhXs6ueJ1Ch0
	 KwnYatwxotjme/cUQ4V4A/58b/7KW0wfIYZJwBewrWxkypB3MdkE0QrVCpr4XDTvpl
	 xe7sXxENS2ylKvuHsyiaeM7KrYr+aaZQV4/v3OGvBvHKVGbJew6Tkmq7bP3IgzKLKS
	 C8YH0HuyZB66A==
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
	Kishon Vijay Abraham I <kishon@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 3/3] arm64: dts: ti: Add DT overlay for PCIe + USB3.0 SERDES personality card
Date: Fri, 26 Jan 2024 13:45:30 +0200
Message-Id: <20240126114530.40913-4-rogerq@kernel.org>
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

From: Kishon Vijay Abraham I <kishon@ti.com>

Add overlay for PCIe (uses the second instance of PCIe in AM654x) and
USB3.0 SERDES personality card

The PCI3/USB3 card is provided with the AM65x GP EVM configurtion [1]
so apply the overlay to k3-am654-gp-evm.dtb

[1] https://www.ti.com/lit/ug/spruim7/spruim7.pdf

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/Makefile               |  5 +-
 .../arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso | 67 +++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 3c008623b693..91fc14044ee3 100644
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
index 000000000000..c63b7241c005
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso
@@ -0,0 +1,67 @@
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
+&pcie1_ep {
+	num-lanes = <1>;
+	phys = <&serdes1 PHY_TYPE_PCIE 0>;
+	phy-names = "pcie-phy0";
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



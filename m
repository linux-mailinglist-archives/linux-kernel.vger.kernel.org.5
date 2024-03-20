Return-Path: <linux-kernel+bounces-108708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815FF880EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10B91C20F71
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E78C3D3BB;
	Wed, 20 Mar 2024 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHFWHRCO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180283B7AC;
	Wed, 20 Mar 2024 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927869; cv=none; b=WzeTrnjXuO0GdkeOQePyDRZnTZzlJUFgq9qrOhpHbSOqrN6KW6sFBAEyC3csP7SNFbG3jU7KOHcz7OZjSgDNEE7PKKTOgNONItSX1WhzzFKO/5vpDRos6BZhhMb/RNyD6zbiIeEUdzWPIm7Pen5sp2AWafyGtOCx5/IwZlGyDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927869; c=relaxed/simple;
	bh=u8mfXGf5B72rCyQC3VDhY6iqSlG2v8pfM8qbOzy0uyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mNheknbnKu0ddZFAdSpGxAhTBlU0MjfRPxjKLvgHlCmO6MERaYrcrehMY+abjzNiRZOn+BJQp+7Vp0sv+g0KXUSmgcmojOTxFZiCDZNg4RWgoIH3TGXjcOk/IPuVU68hJWEqntz+Ql4pUrsfjNni3ddCHvEXJDC0WJPnF/TaJco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHFWHRCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A98C6C43330;
	Wed, 20 Mar 2024 09:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710927868;
	bh=u8mfXGf5B72rCyQC3VDhY6iqSlG2v8pfM8qbOzy0uyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FHFWHRCOE58pWF2huWdFnbYA4lpx5vhyRLj+83iJ9Y6EVDy75OkMC87Aew16l29s2
	 mUH78raCK54S2sHTnwBU0MsKOEtm4bNr1oWc94VbgTsnD1JNNPTc44XllSwHF8Q/rg
	 Wmpsq5Yvo2zOQoGIRMSrNKXEEUyRpZQXsTBw3nUcDKB0cira0VeZJp9UmI7zsSedUs
	 0MpWbTUv7gE/DSKtdpyNCEQ/9u01WPiUN5+3cXAU6ZJLyejU6amAbarDa8Zx+NJGtC
	 L1gXzobsvxJLQhefYabqH5h0hoOzBaKTpp34X/J2CYp5UGGQisKudruIBiU+nsJH6F
	 lbwwNxDlBoubA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98398CD11DD;
	Wed, 20 Mar 2024 09:44:28 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 20 Mar 2024 17:44:16 +0800
Subject: [PATCH v2 4/5] arm64: dts: add support for A4 based Amlogic BA400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-basic_dt-v2-4-681ecfb23baf@amlogic.com>
References: <20240320-basic_dt-v2-0-681ecfb23baf@amlogic.com>
In-Reply-To: <20240320-basic_dt-v2-0-681ecfb23baf@amlogic.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-serial@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710927866; l=5465;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=SFjI1BLUCKxCYAtB6G93CSaHjcRWfiPNSsuscwbBSHg=;
 b=Yau//iYfYinyB0SFsrI91rCkzVwxerH9m6bMksa8pXMuWbl8AOV82J4DEsO2zz07L2GUCPz9a
 UHLb5UoVooeAUJk6d5uNu3TA3xx/5ua5WSASj9tWN9ok8RLifdtaSlc
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Amlogic A4 is an application processor designed for smart audio
and IoT applications.

Add basic support for the A4 based Amlogic BA400 board, which describes
the following components: CPU, GIC, IRQ, Timer and UART.
These are capable of booting up into the serial console.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/Makefile               |  1 +
 .../boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts   | 42 ++++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi | 66 ++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 40 +++++++++++++
 4 files changed, 149 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 1ab160bf928a..9a50ec11bb8d 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_MESON) += amlogic-a4-a113l2-ba400.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-an400.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts b/arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts
new file mode 100644
index 000000000000..43a9c666e1de
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "amlogic-a4.dtsi"
+
+/ {
+	model = "Amlogic A113L2 ba400 Development Board";
+	compatible = "amlogic,ba400","amlogic,a4";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart_b;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 10 MiB reserved for ARM Trusted Firmware */
+		secmon_reserved: secmon@5000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x05000000 0x0 0xa00000>;
+			no-map;
+		};
+	};
+};
+
+&uart_b {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
new file mode 100644
index 000000000000..b6106ad4a072
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/gpio/gpio.h>
+/ {
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	xtal: xtal-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "xtal";
+		#clock-cells = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller@fff01000 {
+			compatible = "arm,gic-400";
+			reg = <0x0 0xfff01000 0 0x1000>,
+			      <0x0 0xfff02000 0 0x2000>,
+			      <0x0 0xfff04000 0 0x2000>,
+			      <0x0 0xfff06000 0 0x2000>;
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		apb: bus@fe000000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xfe000000 0x0 0x480000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
+
+			uart_b: serial@7a000 {
+				compatible = "amlogic,a4-uart",
+					     "amlogic,meson-s4-uart";
+				reg = <0x0 0x7a000 0x0 0x18>;
+				interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&xtal>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
new file mode 100644
index 000000000000..73ca1d7eed81
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
+ */
+
+#include "amlogic-a4-common.dtsi"
+/ {
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+		};
+	};
+};

-- 
2.37.1




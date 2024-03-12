Return-Path: <linux-kernel+bounces-100015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 159D98790C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81929B2353C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372F879B89;
	Tue, 12 Mar 2024 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTAstBbp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419BE78283;
	Tue, 12 Mar 2024 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235141; cv=none; b=Osds4gYoKXMVAksSjJ3Uf3Msg4oU2J2iB/wNly0c1CXATyo4HyPMswfGRrnimjeFgdxpBElKbli39P2jgA+10imbo4XD7NF5Trajqu9rGiUno16iVCkYyo9Xn57X0XIc+juxtpvNGsdO7TiM2YwIRJKURTc1XI+aMNPwk+hxeMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235141; c=relaxed/simple;
	bh=VUv3NkQu+JmNcsjP/ny6setNiV7uCjzIctFGtpXJ0RA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P9TckZRcpaZkVKkuQdjQJKuygsjvo6jlWx4aAInVaankYpbFd+7n20ydDKMN9vhTtcWEw/LOJ1BCbGqpYdFHanQsVExkUSg4/JCLiBovVu7w0XNvrVUy3cLQSjO1JTnc0TA8bSghC0COAfQmHbx60EloSKwmbtUvtaqembd5sDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTAstBbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBF57C433B2;
	Tue, 12 Mar 2024 09:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710235140;
	bh=VUv3NkQu+JmNcsjP/ny6setNiV7uCjzIctFGtpXJ0RA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BTAstBbpuoYupU5df0ZCY5nnbUX/Ob38Hf5MtJbEaFFnkmqjAs/UXwNMtoYH7sxyK
	 PiWjihqLLZdY8bCSfpULeipsp3/XF2O5qS/SsFa5rdoBbtJHsn8Y1A3OoFsMEsaWBL
	 kkCxOrYqIOoXIdr1R4x5MjeqP+3dDUvKz76+HAYO2Y4iV3OSS6F6VpwSsNdTFUdCsi
	 bsaTY7o50tcqjnHNX1ZbdH58xIQYECY+u6mdR7Eite4CPH0nRfoshRFfR+GomwbAjA
	 aDTYvuf6N7yNyDi9OUAFKnEPAxVXYHgIfaCOKBkzpbdALA+LH2PPVCgf/lN+Nfb47q
	 yO49QCt64JnLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB611C54E68;
	Tue, 12 Mar 2024 09:19:00 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 12 Mar 2024 17:19:00 +0800
Subject: [PATCH 4/4] arm64: dts: add support for A5 based Amlogic AV400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240312-basic_dt-v1-4-7f11df3a0896@amlogic.com>
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
In-Reply-To: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710235139; l=4989;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=pH0aL+QTvYtYOKVMhXMKqMBAqECW+id7MYJXdKVvDyA=;
 b=zTLhLa0fC+whvD1zBxSOnpPljy86ucekmboHv/IJuadP1H2lr772ji7ySx6N+nbsnxAu6wzX8
 m2E2ut97xNHDKrPyjsbuvqQ5ujdutSq3rPAziqrW5bfLOxWcghEQtO6
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received:
 by B4 Relay for xianwei.zhao@amlogic.com/20231208 with auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: <xianwei.zhao@amlogic.com>

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Amlogic A5 is an application processor designed for smart audio
and IoT applications.

Add basic support for the A5 based Amlogic AV400 board, which describes
the following components: CPU, GIC, IRQ, Timer and UART.
These are capable of booting up into the serial console.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/Makefile               |  1 +
 .../boot/dts/amlogic/amlogic-a5-a113x2-av400.dts   | 43 ++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 94 ++++++++++++++++++++++
 3 files changed, 138 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 9a50ec11bb8d..154c9efb26e4 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_MESON) += amlogic-a4-a113l2-ba400.dtb
+dtb-$(CONFIG_ARCH_MESON) += amlogic-a5-a113x2-av400.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-an400.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5-a113x2-av400.dts b/arch/arm64/boot/dts/amlogic/amlogic-a5-a113x2-av400.dts
new file mode 100644
index 000000000000..e36fae1cf844
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a5-a113x2-av400.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "amlogic-a5.dtsi"
+
+/ {
+	model = "Amlogic A113X2 av400 Development Board";
+	compatible = "amlogic,av400","amlogic,a5";
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
+		/* 52 MiB reserved for ARM Trusted Firmware */
+		secmon_reserved:linux,secmon {
+			compatible = "shared-dma-pool";
+			no-map;
+			alignment = <0x0 0x400000>;
+			reg = <0x0 0x05000000 0x0 0x3400000>;
+		};
+	};
+};
+
+&uart_b {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
new file mode 100644
index 000000000000..bfb9f13f84ec
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/gpio/gpio.h>
+/ {
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
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
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xfff01000 0 0x1000>,
+			      <0x0 0xfff02000 0 0x2000>,
+			      <0x0 0xfff04000 0 0x2000>,
+			      <0x0 0xfff06000 0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		apb@fe000000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xfe000000 0x0 0x480000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
+
+			uart_b: serial@7a000 {
+				compatible = "amlogic,meson-s4-uart",
+					     "amlogic,meson-ao-uart";
+				reg = <0x0 0x7a000 0x0 0x18>;
+				interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&xtal>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
+		};
+	};
+};

-- 
2.37.1



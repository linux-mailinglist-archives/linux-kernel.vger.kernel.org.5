Return-Path: <linux-kernel+bounces-80664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB28866B04
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2417A288A11
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168CD53391;
	Mon, 26 Feb 2024 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYogSAN1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBDA1D52B;
	Mon, 26 Feb 2024 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932684; cv=none; b=fJ+EFBDZRtOqzuzPhCoUOQx7pDCVXARtBVhAKJMsCuMBBb9xw9iQXkry4caM9MI+mQTAYvAdGt/7zTTu3xKtOqs+iAAcD7G4m1UHiKmxRilWszuZA/p6c2V/NscO7mMtlwQ9rm3vOB9Tac5i3Cw1qgVsST1QQpuNGFw/ZSESMuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932684; c=relaxed/simple;
	bh=QxXyV+4znc/zev1U+GCmM5SgxTS+tx1I8YHe7cbBQAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TeMo6F6X/EtI6IzPtBWEzB9cCSGCie1kl3bFb36q0y+hEva9Wu/JB5JqOYdjdqaTt01sgCJrHMduqkM+2BfBcBCtawaIk1jZWPaGfQi41qEBjcAAF0n5LXS4kWpr1pUWklbCqx5uwVGkRg65Wl7wBmRbxJL+bFNyQRC1B6GRQx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYogSAN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9953CC4E756;
	Mon, 26 Feb 2024 07:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708932683;
	bh=QxXyV+4znc/zev1U+GCmM5SgxTS+tx1I8YHe7cbBQAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CYogSAN1onIIEgzr2Ae96xehCkraRpZ7gHueigctVq+czDT/jhbzWl/I/Ru1XTpj7
	 m8C2pzTbYp0zI73GGs1dR/hUfgnIV8U2EoRKo/vC+KDD2RgN/c1PZsrf1qlHhTbjdb
	 bhgLsrXk1VQUJhO4R2F54m1p7zQHk5uObtuQrNJXywUf/E2WNVVaJ0yqOoC9DcUK4E
	 1OMRd9AgoqvXnyxzxVWllHvokBCS9qRSC8OtIRvE687gAMyfdEYQmf3X/gRcoh9bvj
	 TpZE4+/4SBBj3qN6qmDulv6HUIeeSDrU2ygZLhmlGid8mmeV0vX+98qdZx8uBnj3kZ
	 yqoZtY0PNkxdA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A69C54E55;
	Mon, 26 Feb 2024 07:31:23 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 26 Feb 2024 10:30:26 +0300
Subject: [PATCH v8 30/38] ARM: dts: ep93xx: add ts7250 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-ep93xx-v8-30-3136dca7238f@maquefel.me>
References: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
In-Reply-To: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, Peter Rosin <peda@axentia.se>, 
 Baruch Siach <baruch@tkos.co.il>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>, 
 Jisheng Zhang <jszhang@kernel.org>, Rob Herring <robh@kernel.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708932678; l=6189;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=nFAzcOth5DIkxc0/jY6Pz4HPUfRPm3ZyzaiBWKElNNs=; =?utf-8?q?b=3D4pY15hqmmeFH?=
 =?utf-8?q?d8zbvI/BIYdoTmFtFgQQ4X/dOW2W4x7eckftAvkhYEqUMxAOAtlxNF1IYp4a+QEH?=
 zIpPDeHED4VEZiMQrReceFa9B81D56aZjxnDr3KcQ+Mb41N44Dnw
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add device tree file for Technologic Systems ts7250 board and
Liebherr bk3 board which have many in common, both are based on
ep9302 SoC variant.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/boot/dts/cirrus/Makefile          |   3 +
 arch/arm/boot/dts/cirrus/ep93xx-bk3.dts    | 126 +++++++++++++++++++++++++
 arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts | 145 +++++++++++++++++++++++++++++
 3 files changed, 274 insertions(+)

diff --git a/arch/arm/boot/dts/cirrus/Makefile b/arch/arm/boot/dts/cirrus/Makefile
index e944d3e2129d..211a7e2f2115 100644
--- a/arch/arm/boot/dts/cirrus/Makefile
+++ b/arch/arm/boot/dts/cirrus/Makefile
@@ -3,3 +3,6 @@ dtb-$(CONFIG_ARCH_CLPS711X) += \
 	ep7211-edb7211.dtb
 dtb-$(CONFIG_ARCH_CLPS711X) += \
 	ep7211-edb7211.dtb
+dtb-$(CONFIG_ARCH_EP93XX) += \
+	ep93xx-bk3.dtb \
+	ep93xx-ts7250.dtb
diff --git a/arch/arm/boot/dts/cirrus/ep93xx-bk3.dts b/arch/arm/boot/dts/cirrus/ep93xx-bk3.dts
new file mode 100644
index 000000000000..5409a700cdfe
--- /dev/null
+++ b/arch/arm/boot/dts/cirrus/ep93xx-bk3.dts
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for Liebherr controller BK3.1 based on Cirrus EP9302 SoC
+ */
+/dts-v1/;
+#include "ep93xx.dtsi"
+
+/ {
+	model = "Liebherr controller BK3.1";
+	compatible = "liebherr,bk3", "cirrus,ep9301";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {
+	};
+
+	memory@0 {
+		device_type = "memory";
+		/* should be set from ATAGS */
+		reg = <0x00000000 0x02000000>,
+		      <0x000530c0 0x01fdd000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "grled";
+			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+		};
+
+		led-1 {
+			label = "rdled";
+			gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_FAULT;
+		};
+	};
+};
+
+&ebi {
+	nand-controller@60000000 {
+		compatible = "technologic,ts7200-nand";
+		reg = <0x60000000 0x8000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		nand@0 {
+			reg = <0>;
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					label = "System";
+					reg = <0x00000000 0x01e00000>;
+					read-only;
+				};
+
+				partition@1e00000 {
+					label = "Data";
+					reg = <0x01e00000 0x05f20000>;
+				};
+
+				partition@7d20000 {
+					label = "RedBoot";
+					reg = <0x07d20000 0x002e0000>;
+					read-only;
+				};
+			};
+		};
+	};
+};
+
+&eth0 {
+	phy-handle = <&phy0>;
+};
+
+&i2s {
+	dmas = <&dma0 0 1>, <&dma0 0 2>;
+	dma-names = "tx", "rx";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s_on_ac97_pins>;
+	status = "okay";
+};
+
+&gpio1 {
+	/* PWM */
+	gpio-ranges = <&syscon 6 163 1>;
+};
+
+&gpio4 {
+	gpio-ranges = <&syscon 0 97 2>;
+	status = "okay";
+};
+
+&gpio6 {
+	gpio-ranges = <&syscon 0 87 2>;
+	status = "okay";
+};
+
+&gpio7 {
+	gpio-ranges = <&syscon 2 199 4>;
+	status = "okay";
+};
+
+&mdio0 {
+	phy0: ethernet-phy@1 {
+		reg = <1>;
+		device_type = "ethernet-phy";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
diff --git a/arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts b/arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts
new file mode 100644
index 000000000000..9e03f93d9fc8
--- /dev/null
+++ b/arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for Technologic Systems ts7250 board based on Cirrus EP9302 SoC
+ */
+/dts-v1/;
+#include "ep93xx.dtsi"
+
+/ {
+	compatible = "technologic,ts7250", "cirrus,ep9301";
+	model = "TS-7250 SBC";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {
+	};
+
+	memory@0 {
+		device_type = "memory";
+		/* should be set from ATAGS */
+		reg = <0x00000000 0x02000000>,
+		      <0x000530c0 0x01fdd000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "grled";
+			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+		};
+
+		led-1 {
+			label = "rdled";
+			gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_FAULT;
+		};
+	};
+};
+
+&ebi {
+	nand-controller@60000000 {
+		compatible = "technologic,ts7200-nand";
+		reg = <0x60000000 0x8000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		nand@0 {
+			reg = <0>;
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					label = "TS-BOOTROM";
+					reg = <0x00000000 0x00020000>;
+					read-only;
+				};
+
+				partition@20000 {
+					label = "Linux";
+					reg = <0x00020000 0x07d00000>;
+				};
+
+				partition@7d20000 {
+					label = "RedBoot";
+					reg = <0x07d20000 0x002e0000>;
+					read-only;
+				};
+			};
+		};
+	};
+
+	rtc@10800000 {
+		compatible = "st,m48t86";
+		reg = <0x10800000 0x1>,
+			<0x11700000 0x1>;
+	};
+
+	watchdog@23800000 {
+		compatible = "technologic,ts7200-wdt";
+		reg = <0x23800000 0x01>,
+			<0x23c00000 0x01>;
+		timeout-sec = <30>;
+	};
+};
+
+&eth0 {
+	phy-handle = <&phy0>;
+};
+
+&gpio1 {
+	/* PWM */
+	gpio-ranges = <&syscon 6 163 1>;
+};
+
+/* ts7250 doesn't have GPIO Port D present */
+&gpio3 {
+	status = "disabled";
+};
+
+&gpio4 {
+	gpio-ranges = <&syscon 0 97 2>;
+};
+
+&gpio6 {
+	gpio-ranges = <&syscon 0 87 2>;
+};
+
+&gpio7 {
+	gpio-ranges = <&syscon 2 199 4>;
+};
+
+&spi0 {
+	cs-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+	dmas = <&dma1 10 2>, <&dma1 10 1>;
+	dma-names = "rx", "tx";
+	status = "okay";
+
+	tmp122: temperature-sensor@0 {
+		compatible = "ti,tmp122";
+		reg = <0>;
+		spi-max-frequency = <2000000>;
+	};
+};
+
+&mdio0 {
+	phy0: ethernet-phy@1 {
+		reg = <1>;
+		device_type = "ethernet-phy";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};

-- 
2.41.0



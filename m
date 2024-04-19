Return-Path: <linux-kernel+bounces-151098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 375C08AA915
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B23B2184C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BC34CB45;
	Fri, 19 Apr 2024 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUO+QHgD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97811405EC;
	Fri, 19 Apr 2024 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511370; cv=none; b=BfwVEhE/gqgfcpC3KpXVLhWau2CcWUn6IsBL99n0J8fi/twXl4h0b0qjUKHon4mgxqKhDR1joJM/42+czovIjBkFHpNHQJuk94Zy8xtIIi5zEgwCibQ8k8VCBBwb8rqL1zj371qQia2SsA7Q8Wm0tKuQjFOlHgPNZlPhi5Tj+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511370; c=relaxed/simple;
	bh=4Ik0UZOlbw3Z3LMJKu2pwTT/PbiG0sj24vexdGr9IGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ssRg5Gn8p8rfBevLefe/C8mo+YldlTTZGJIJso9kb4sq9YMqqMjzZVzKW8CohtI1uw/m5y07hXSlr2djmKSCK6eH/w9rRg7u4IPwUwQYvdcwWLFyytgjowGzAdosOIIzU/GaGoKUbnRQNHQVA2m245VvMFPe+9YVlP2L62CQWB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUO+QHgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B0D3C32786;
	Fri, 19 Apr 2024 07:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713511370;
	bh=4Ik0UZOlbw3Z3LMJKu2pwTT/PbiG0sj24vexdGr9IGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uUO+QHgDj63egrPp5c/Y2a1iCCTU57sTBeMr/wZ25NWy+xeWUBuId3ZZ1jwnX9Uh2
	 LJZSN7YHaXD00BpdzbhMZvaBypobW5XuIvSLS4P8bhonB8hrAVjKZ72fzWmFV6DBt7
	 euagRyf1c3MSlRfi/mpDOhy7mQVNu5Bw7kl5DC3nO0PFPmbERg8dAlTTfylc/jnH0C
	 /qxeRM0WZI5LEptqS0OvbDCf74IsrXmPk+S+Paw5FkK3L4lnvoNyXhYTan9pNRi47n
	 vFaJneTzjVfGrDfAa9rDhwJRaLCs4PO3Y1u9Gs4MS6fxxsY9rRk5jYlskkChHQtVpc
	 iShUZoXoPSyKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D315C4345F;
	Fri, 19 Apr 2024 07:22:50 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 19 Apr 2024 10:22:50 +0300
Subject: [PATCH v2 3/4] ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240419-for-soc-asus-rt-ac3200-ac5300-v2-3-f95ff50c2a4d@arinc9.com>
References: <20240419-for-soc-asus-rt-ac3200-ac5300-v2-0-f95ff50c2a4d@arinc9.com>
In-Reply-To: <20240419-for-soc-asus-rt-ac3200-ac5300-v2-0-f95ff50c2a4d@arinc9.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Tom Brautaset <tbrautaset@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713511368; l=4241;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=rklNeSeHydZb09yDIp9GSRvPGoSJXke/gDxS0QfH2sE=;
 b=V+VrImDYtcK4gkGCH6AB9ZmLFos7T+hSKiGEmjxpzdmFnbq+Z2gfn/UT2yhSUR/aG2ZYw//X1
 LIPs6T5G0zHA0HwLVd77tdBsFFSedOwYdR92JM4fH/YjCJ2tOKyJ4X/
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Add the device tree for ASUS RT-AC3200 which is an AC3200 router featuring
5 Ethernet ports over the integrated Broadcom switch.

Hardware info:
* Processor: Broadcom BCM4709A0 dual-core @ 1.0 GHz
* Switch: BCM53012 in BCM4709A0
* DDR3 RAM: 256 MB
* Flash: 128 MB
* 2.4GHz: BCM43602 3x3 single chip 802.11b/g/n SoC
* 5GHz: BCM43602 3x3 two chips 802.11a/n/ac SoC
* Ports: 4 LAN Ports, 1 WAN Port

Co-developed-by: Tom Brautaset <tbrautaset@gmail.com>
Signed-off-by: Tom Brautaset <tbrautaset@gmail.com>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/broadcom/Makefile                |   1 +
 .../boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts   | 150 +++++++++++++++++++++
 2 files changed, 151 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/Makefile b/arch/arm/boot/dts/broadcom/Makefile
index 7099d9560033..c61fca514775 100644
--- a/arch/arm/boot/dts/broadcom/Makefile
+++ b/arch/arm/boot/dts/broadcom/Makefile
@@ -64,6 +64,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm47081-luxul-xap-1410.dtb \
 	bcm47081-luxul-xwr-1200.dtb \
 	bcm47081-tplink-archer-c5-v2.dtb \
+	bcm4709-asus-rt-ac3200.dtb \
 	bcm4709-asus-rt-ac87u.dtb \
 	bcm4709-buffalo-wxr-1900dhp.dtb \
 	bcm4709-linksys-ea9200.dtb \
diff --git a/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts b/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts
new file mode 100644
index 000000000000..9cfae1fafc5f
--- /dev/null
+++ b/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Author: Tom Brautaset <tbrautaset@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "bcm4709.dtsi"
+#include "bcm5301x-nand-cs0-bch8.dtsi"
+
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "asus,rt-ac3200", "brcm,bcm4709", "brcm,bcm4708";
+	model = "ASUS RT-AC3200";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x08000000>,
+		      <0x88000000 0x08000000>;
+	};
+
+	nvram@1c080000 {
+		compatible = "brcm,nvram";
+		reg = <0x1c080000 0x00180000>;
+
+		et0macaddr: et0macaddr {
+			#nvmem-cell-cells = <1>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-power {
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-on";
+		};
+
+		led-wan-red {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_WAN;
+			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-wps {
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_WPS;
+			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-reset {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
+		};
+
+		button-wifi {
+			label = "Wi-Fi";
+			linux,code = <KEY_RFKILL>;
+			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
+		};
+
+		button-wps {
+			label = "WPS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&usb2 {
+	vcc-gpio = <&chipcommon 9 GPIO_ACTIVE_HIGH>;
+};
+
+&usb3_phy {
+	status = "okay";
+};
+
+&gmac0 {
+	nvmem-cells = <&et0macaddr 0>;
+	nvmem-cell-names = "mac-address";
+};
+
+&gmac1 {
+	nvmem-cells = <&et0macaddr 1>;
+	nvmem-cell-names = "mac-address";
+};
+
+&gmac2 {
+	nvmem-cells = <&et0macaddr 2>;
+	nvmem-cell-names = "mac-address";
+};
+
+&srab {
+	status = "okay";
+
+	ports {
+		port@0 {
+			label = "wan";
+		};
+
+		port@1 {
+			label = "lan1";
+		};
+
+		port@2 {
+			label = "lan2";
+		};
+
+		port@3 {
+			label = "lan3";
+		};
+
+		port@4 {
+			label = "lan4";
+		};
+	};
+};
+
+&nandcs {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "boot";
+			reg = <0x00000000 0x00080000>;
+			read-only;
+		};
+
+		partition@80000 {
+			label = "nvram";
+			reg = <0x00080000 0x00180000>;
+		};
+
+		partition@200000 {
+			label = "firmware";
+			reg = <0x00200000 0x07e00000>;
+			compatible = "brcm,trx";
+		};
+	};
+};

-- 
2.40.1




Return-Path: <linux-kernel+bounces-76165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBA785F3B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A7528505E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A1E374CF;
	Thu, 22 Feb 2024 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T597HkXS"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7A37168;
	Thu, 22 Feb 2024 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592366; cv=none; b=Aaa80pwrjb7Z+jHrBIIE+Iq24ZYl5+H3NUOUaLRURNpW0ByvYaGYahUfrRUUaFoCmEDuyNkCFtEHEKDKf6j86DsEjTEClpPCaS2RgDAxszLQsehZrI1EOGP1Ih5G3cguIN1qoqHm5lLKUev/th+dV9V04RRXgpH8eDyP2WKju9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592366; c=relaxed/simple;
	bh=ld/whN1QBZ1X1IWOnV1u2ZQ1myBCEPxWzS20mfyje58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UBJT+91v3YIvZWh0p6EMKy6G3nVCL+M7le/0KOx7u77a9ETXSpdCKbIwLKtH2ZuZuYb5CeN8JTHn6yakk+RyoaZ9myE5JgcKFjA4aXaMGPQ4Ou64Ao+3ZPCdLqMLc6K6yLDNFQbQdEHJ/Vcp5tnmbeO7vdNFuJc2fUtBRU5Zcyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T597HkXS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e332bc65b3so2862258b3a.3;
        Thu, 22 Feb 2024 00:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708592364; x=1709197164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trYxxZ+/Lm0Rn0ryVdX34mx7IUSuqT5Jn/BfPqT0uC4=;
        b=T597HkXSnj/RGyj1S8kNxV58jgV5dW9cmod0FDdQUGsHWCFLcXCiV+8pYHMD82rYaL
         mK/OCBPd+aQ7cJaFs6bOrwFOlQh03OSRtvEOGH4kXthX8kctq0e0Kmub8FIcCYNPBPTj
         97WQBbTqD/0CSpVODoe1Kjxh1sKgi58tko5y2d2/cQKv1cwVvUrfuyvn3Q2ZpDVlRQ+R
         oOvecAevwUaqmqevmaHm0bhN0+ms+UNkIQgEBQUuZmzpIb2D5qDJWoBk59b1wBXqf6y6
         FymsPYw6gPjNhyM1jA56pcMAgEFz2//kM81gDGvP4SNz36pBKgYM5jxuHtVCt2gk6zZr
         SMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708592364; x=1709197164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trYxxZ+/Lm0Rn0ryVdX34mx7IUSuqT5Jn/BfPqT0uC4=;
        b=dL38BVBoxWvy66zGvOIXGLhnyepdmwEzVKL89Dbb3Klfyr+eFrX9F5WVzr1KBal6JB
         1ccDLUH37twglN5o8GW8m/ni5V7DzIQr/EPRYQXYSrmJgVtfS+0ZIGm3Qj9RTIDD5cFz
         vPSd/HzP8McUA7SdgykMn4zJaRdgDtMT891eveSf7yoig/WhnCe7SyqvIMq+TWbtRxhF
         jPAnW2d4xvOS/HhnTwbpYdEWrA++2vBY6upzDqGAswTrHhWudLndz/NnmxtNKavcMzpM
         EdtQUL6olR8DrwL4fbe3Aqb1rFofphvCIKjOZjmJSOSV4k0yo/YEDv21g6vis3PO+PUo
         VDNw==
X-Forwarded-Encrypted: i=1; AJvYcCV+xWzRjzf/JVfXTDTZ+LQWIlAvrbB/6xBYc8A1KWmdCGVBSTMXPQwlnzNhBjPZXjrLnzV1fEW9JaYURY5Gyd7yolMNn/XFbNzoYk15XfFrScfk1xUKBettl5t4FeX1f4r4xSTWpWd1zQ==
X-Gm-Message-State: AOJu0YxGkpYjj3HGuUwxhIsKIafCnXplQahm13jnBTdJr1H5jHSx7giY
	2s8TfGhhgEJi5uAX6ztaveLJzEPRhJEt/9jGwKGWePwj3yWXfoTh51Yz8A4qgx4=
X-Google-Smtp-Source: AGHT+IG58MH/TqyW1MoOHanFjR6V/dfbREu4W8jCCD3ntjW04hXqN5T6b/5XGh2CFlvsmHnMXlVykg==
X-Received: by 2002:aa7:8583:0:b0:6e4:6a74:ee5b with SMTP id w3-20020aa78583000000b006e46a74ee5bmr9463310pfn.14.1708592364260;
        Thu, 22 Feb 2024 00:59:24 -0800 (PST)
Received: from localhost.localdomain (125-229-150-10.hinet-ip.hinet.net. [125.229.150.10])
        by smtp.gmail.com with ESMTPSA id k18-20020aa788d2000000b006e4cb7f4393sm922356pff.165.2024.02.22.00.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:59:23 -0800 (PST)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kelly_hung@asus.com,
	Allenyy_Hsu@asus.com,
	Kelly Hung <Kelly_Hung@asus.com>
Subject: [PATCH 2/2] ARM: dts: aspeed: x4tf: Add dts for asus x4tf project
Date: Thu, 22 Feb 2024 16:59:14 +0800
Message-Id: <20240222085914.1218037-2-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240222085914.1218037-1-Kelly_Hung@asus.com>
References: <20240222085914.1218037-1-Kelly_Hung@asus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Base on aspeed-g6.dtsi and can boot into BMC console.

Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  | 592 ++++++++++++++++++
 2 files changed, 593 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index d3ac20e31..32c41f3d9 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
 	aspeed-bmc-asrock-e3c246d4i.dtb \
 	aspeed-bmc-asrock-romed8hm3.dtb \
+	aspeed-bmc-asus-x4tf.dtb \
 	aspeed-bmc-bytedance-g220a.dtb \
 	aspeed-bmc-delta-ahe50dc.dtb \
 	aspeed-bmc-facebook-bletchley.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
new file mode 100644
index 000000000..1bda14a66
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
@@ -0,0 +1,592 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2024 ASUS Corp.
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include "aspeed-g6-pinctrl.dtsi"
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "ASUS-X4TF";
+	compatible = "asus,x4tf", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = "serial4:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		video_engine_memory: video {
+			size = <0x04000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+				<&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
+				<&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-heartbeat {
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-uid {
+			gpios = <&gpio0 ASPEED_GPIO(P, 1) (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+			default-state = "off";
+		};
+
+		led-status_Y {
+			gpios = <&gpio1 ASPEED_GPIO(B, 1) GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-sys_boot_status {
+			gpios = <&gpio1 ASPEED_GPIO(B, 0) GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
+};
+
+&adc0 {
+	vref = <2500>;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		&pinctrl_adc2_default &pinctrl_adc3_default
+		&pinctrl_adc4_default &pinctrl_adc5_default
+		&pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	vref = <2500>;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+		&pinctrl_adc10_default &pinctrl_adc11_default
+		&pinctrl_adc12_default &pinctrl_adc13_default
+		&pinctrl_adc14_default &pinctrl_adc15_default>;
+};
+
+&peci0 {
+	status = "okay";
+};
+
+&lpc_snoop {
+	snoop-ports = <0x80>;
+	status = "okay";
+};
+
+&mac2 {
+	status = "okay";
+	phy-mode = "rmii";
+	use-ncsi;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+};
+
+&mac3 {
+	status = "okay";
+	phy-mode = "rmii";
+	use-ncsi;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc-spi";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-128.dtsi"
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+
+	flash@0 {
+		status = "okay";
+		label = "bios-spi";
+		spi-max-frequency = <50000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			biosfullimg@0 {
+				reg = <0x0 0x2000000>; //32768 *1024 = 32 MB
+				label = "biosfullimg";
+			};
+		};
+	};
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+
+	temperature-sensor@48 {
+		compatible = "ti,tmp75";
+		reg = <0x48>;
+	};
+
+	temperature-sensor@49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
+
+	pca9555_4_20: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca9555_4_22: gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca9555_4_24: gpio@24 {
+		compatible = "nxp,pca9555";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+		/*A0 - A3 0*/	"", "STRAP_BMC_BATTERY_GPIO1", "", "",
+		/*A4 - A7 4*/	"", "", "", "",
+		/*B0 - B7 8*/	"", "", "", "", "", "", "", "";
+	};
+
+	pca9555_4_26: gpio@26 {
+		compatible = "nxp,pca9555";
+		reg = <0x26>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9546";
+		status = "okay";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel_1: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		channel_2: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		channel_3: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		channel_4: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c5 {
+	status = "okay";
+
+	pca9555_5_24: gpio@24 {
+		compatible = "nxp,pca9555";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	i2c-mux@70  {
+		compatible = "nxp,pca9546";
+		status = "okay";
+		reg = <0x70 >;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel_5: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			pca9555_5_5_20: gpio@20 {
+				compatible = "nxp,pca9555";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-line-names =
+					"", "", "", "", "", "", "", "",
+					"", "", "SYS_FAN6", "SYS_FAN5",
+					"SYS_FAN4", "SYS_FAN3",
+					"SYS_FAN2", "SYS_FAN1";
+			};
+
+			pca9555_5_5_21: gpio@21 {
+				compatible = "nxp,pca9555";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina219";
+				reg = <0x44>;
+				shunt-resistor = <2>;
+			};
+		};
+
+		channel_6: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		channel_7: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		channel_8: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	pca9555_6_27: gpio@27 {
+		compatible = "nxp,pca9555";
+		reg = <0x27>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca9555_6_20: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+		/*A0 0*/	"", "", "", "", "", "", "", "",
+		/*B0 8*/	"Drive_NVMe1", "Drive_NVMe2", "", "",
+		/*B4 12*/	"", "", "", "";
+	};
+
+	pca9555_6_21: gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9546";
+		status = "okay";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		idle-state = <1>;
+
+		channel_9: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			temperature-sensor@48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+
+			temperature-sensor@49 {
+				compatible = "ti,tmp75";
+				reg = <0x49>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina219";
+				reg = <0x40>;
+				shunt-resistor = <2>;
+			};
+
+			power-monitor@41 {
+				compatible = "ti,ina219";
+				reg = <0x41>;
+				shunt-resistor = <5>;
+			};
+		};
+
+		channel_10: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		channel_11: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		channel_12: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		status = "okay";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		channel_13: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		channel_14: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		channel_15: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		channel_16: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c8 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9546";
+		status = "okay";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		channel_17: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		channel_18: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			temperature-sensor@48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+
+			power-monitor@41 {
+				compatible = "ti,ina219";
+				reg = <0x41>;
+				shunt-resistor = <5>;
+			};
+		};
+
+		channel_19: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		channel_20: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c14 {
+	status = "okay";
+	multi-master;
+
+	eeprom@50 {
+		compatible = "atmel,24c08";
+		reg = <0x50>;
+	};
+
+	eeprom@51 {
+		compatible = "atmel,24c08";
+		reg = <0x51>;
+	};
+};
+
+&sgpiom0 {
+	status = "okay";
+	ngpios = <128>;
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
+
+&sdc {
+	status = "okay";
+};
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+&kcs1 {
+	aspeed,lpc-io-reg = <0xca0>;
+	status = "okay";
+};
+
+&kcs2 {
+	aspeed,lpc-io-reg = <0xca8>;
+	status = "okay";
+};
+
+&kcs3 {
+	aspeed,lpc-io-reg = <0xca2>;
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&gpio0 {
+	gpio-line-names =
+	/*A0 0*/	"", "", "", "", "", "", "", "",
+	/*B0 8*/	"", "", "", "", "", "", "PS_PWROK", "",
+	/*C0 16*/	"", "", "", "", "", "", "", "",
+	/*D0 24*/	"", "", "", "", "", "", "", "",
+	/*E0 32*/	"", "", "", "", "", "", "", "",
+	/*F0 40*/	"", "", "", "", "", "", "", "",
+	/*G0 48*/	"", "", "", "", "", "", "", "",
+	/*H0 56*/	"", "", "", "", "", "", "", "",
+	/*I0 64*/	"", "", "", "", "", "", "", "",
+	/*J0 72*/	"", "", "", "", "", "", "", "",
+	/*K0 80*/	"", "", "", "", "", "", "", "",
+	/*L0 88*/	"", "", "", "", "", "", "", "",
+	/*M0 96*/	"", "", "", "", "", "", "", "",
+	/*N0 104*/	"", "", "", "",
+	/*N4 108*/	"POST_COMPLETE", "ESR1_GPIO_AST_SPISEL", "", "",
+	/*O0 112*/	"", "", "", "", "", "", "", "",
+	/*P0 120*/	"ID_BUTTON", "ID_OUT", "POWER_BUTTON", "POWER_OUT",
+	/*P4 124*/	"RESET_BUTTON", "RESET_OUT", "", "HEARTBEAT",
+	/*Q0 128*/	"", "", "", "", "", "", "", "",
+	/*R0 136*/	"", "", "", "", "", "", "", "",
+	/*S0 144*/	"", "", "", "", "", "", "", "",
+	/*T0 152*/	"", "", "", "", "", "", "", "",
+	/*U0 160*/	"", "", "", "", "", "", "", "",
+	/*V0 168*/	"", "", "", "", "", "", "", "",
+	/*W0 176*/	"", "", "", "", "", "", "", "",
+	/*X0 184*/	"", "", "", "", "", "", "", "",
+	/*Y0 192*/	"", "", "", "", "", "", "", "",
+	/*Z0 200*/	"", "", "", "", "", "", "", "";
+};
-- 
2.25.1



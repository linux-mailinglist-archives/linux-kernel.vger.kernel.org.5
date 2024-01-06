Return-Path: <linux-kernel+bounces-18730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5328261EF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 23:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC241C20F71
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 22:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9299E101CD;
	Sat,  6 Jan 2024 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6OBQTpB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4707B101D3;
	Sat,  6 Jan 2024 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d8902da73so6368495e9.2;
        Sat, 06 Jan 2024 14:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704579853; x=1705184653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZIA5zf/VHPtEHf5BZda2vmVXuJ+Vs5INvQNZOIe84E=;
        b=V6OBQTpB5sZBkqHa6eGS4C9ZS7yI4rLqHlZFdgmdySdVuQVPKiFR1jCdwXWlevASDH
         lG2XL8fNSn0P+VUFYDh3iF4koUooY5FxCIXtDKx0F+40kaD2MdJT3lVuoJ9Z2xPZW5bH
         pP9xfmLLd6gFrUrqlnc4xcN66zcnWXdjXuhS6Rk6w8+sJ8VrE34DK1mHkOwafLPSqL7v
         mbI7IiN6f4jBzSEaHYIN/0NTKl82iVN+Y2gbfLGMbVEIzV7fns3xAEeLoj62c3pTYErj
         lmN1Q3l4vCWVsZaEtgveMdotzzoPTo9fZTP1E2kgiKQoygksAW02iw/HPHCerAmgE/vn
         zHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704579853; x=1705184653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZIA5zf/VHPtEHf5BZda2vmVXuJ+Vs5INvQNZOIe84E=;
        b=imSwucjlfo6w9jw9BDwTrWw8nfkmhvUYw5JLR3o6f5Y8qw8uqdptAMkxG+WrHF+osL
         vBxA/0h9adQ2IoNy4v71VWw+euenYzrLsudnM2cQ30RPl6VqRzey1cDFbBORbw8gwcSn
         014m8T3kYKnfUpyLwnOwAFyoRhgZc4flVrXpypDCYrOrrEnXNp+I8NjTYUjhu+zJ8Xc3
         O2JWtn6uNFdPgTZGPv2SeJA5m0PV0LpUrU4u4x300KH9sx6VHlPqlYzKsokH0V0hF7Cq
         XER0POvtFhqxOmqAZFoA1RSUi9oJOeDQfRAH9yh31QFPkhdsjL1o341X35v5kyNQ+xmG
         Sr8A==
X-Gm-Message-State: AOJu0Yw9vCDtzp6WD17rqFxeXyXeZ2fy+I5NxyxZK546Eofd/FWFDDf9
	nE1gt37oAkPoEPeOeiKzPPc=
X-Google-Smtp-Source: AGHT+IFQBfnhjijD8pVRIVBENGEVDkxMXR9G87JnBQZcxtG2UjML/FicHu+tauxYcJphro1u3Ie9NA==
X-Received: by 2002:a05:600c:5027:b0:40e:43e5:f33f with SMTP id n39-20020a05600c502700b0040e43e5f33fmr39936wmr.65.1704579853213;
        Sat, 06 Jan 2024 14:24:13 -0800 (PST)
Received: from latitude-fedora.lan ([2001:8f8:183b:50fb::d35])
        by smtp.gmail.com with ESMTPSA id w15-20020adfe04f000000b00336471bc7ffsm4078128wrh.109.2024.01.06.14.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 14:24:12 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Christopher Obbard <chris.obbard@collabora.com>,
	=?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <szucst@iit.uni-miskolc.hu>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Alexey Charkov <alchark@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: enable built-in thermal monitoring on rk3588
Date: Sun,  7 Jan 2024 02:23:42 +0400
Message-ID: <20240106222357.23835-1-alchark@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include thermal zones information in device tree for rk3588 variants
and enable the built-in thermal sensing ADC on RADXA Rock 5B

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |   4 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 143 ++++++++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index a5a104131403..f9d540000de3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -772,3 +772,7 @@ &usb_host1_ehci {
 &usb_host1_ohci {
 	status = "okay";
 };
+
+&tsadc {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 8aa0499f9b03..8235991e3112 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/reset/rockchip,rk3588-cru.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/ata/ahci.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "rockchip,rk3588";
@@ -2112,6 +2113,148 @@ tsadc: tsadc@fec00000 {
 		status = "disabled";
 	};
 
+	thermal_zones: thermal-zones {
+		soc_thermal: soc-thermal {
+			polling-delay-passive = <20>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+			sustainable-power = <2100>; /* milliwatts */
+
+			thermal-sensors = <&tsadc 0>;
+			trips {
+				threshold: trip-point-0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				target: trip-point-1 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				soc_crit: soc-crit {
+					/* millicelsius */
+					temperature = <115000>;
+					/* millicelsius */
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&target>;
+					cooling-device = <&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					contribution = <1024>;
+				};
+				map1 {
+					trip = <&target>;
+					cooling-device = <&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					contribution = <1024>;
+				};
+				map2 {
+					trip = <&target>;
+					cooling-device = <&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					contribution = <1024>;
+				};
+			};
+		};
+
+		bigcore0_thermal: bigcore0-thermal {
+			polling-delay-passive = <20>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+			thermal-sensors = <&tsadc 1>;
+
+			trips {
+				big0_crit: big0-crit {
+					/* millicelsius */
+					temperature = <115000>;
+					/* millicelsius */
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		bigcore1_thermal: bigcore1-thermal {
+			polling-delay-passive = <20>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+			thermal-sensors = <&tsadc 2>;
+
+			trips {
+				big1_crit: big1-crit {
+					/* millicelsius */
+					temperature = <115000>;
+					/* millicelsius */
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		little_core_thermal: littlecore-thermal {
+			polling-delay-passive = <20>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+			thermal-sensors = <&tsadc 3>;
+
+			trips {
+				little_crit: little-crit {
+					/* millicelsius */
+					temperature = <115000>;
+					/* millicelsius */
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		center_thermal: center-thermal {
+			polling-delay-passive = <20>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+			thermal-sensors = <&tsadc 4>;
+
+			trips {
+				center_crit: center-crit {
+					/* millicelsius */
+					temperature = <115000>;
+					/* millicelsius */
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu_thermal: gpu-thermal {
+			polling-delay-passive = <20>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+			thermal-sensors = <&tsadc 5>;
+
+			trips {
+				gpu_crit: gpu-crit {
+					/* millicelsius */
+					temperature = <115000>;
+					/* millicelsius */
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		npu_thermal: npu-thermal {
+			polling-delay-passive = <20>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+			thermal-sensors = <&tsadc 6>;
+
+			trips {
+				npu_crit: npu-crit {
+					/* millicelsius */
+					temperature = <115000>;
+					/* millicelsius */
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	saradc: adc@fec10000 {
 		compatible = "rockchip,rk3588-saradc";
 		reg = <0x0 0xfec10000 0x0 0x10000>;
-- 
2.43.0



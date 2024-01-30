Return-Path: <linux-kernel+bounces-45094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD57842BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5421C2486C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5234F1586E0;
	Tue, 30 Jan 2024 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvU6J9rb"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81AB157E8D;
	Tue, 30 Jan 2024 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638898; cv=none; b=IZSh/P1j36C/8wBelFGNLSzKadS4b9HajgjwUufVYD0lWdHVogrko9ilkZkD010nqsFld0EoncAwBDggy7zz0mmmDjBrjFK0CU4dcfE7qMaNCB35W4e8zya+MXfyWoe8XkXdNYPHDR1JCCM4drYskX2s14h6j8n9xeDWgewyEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638898; c=relaxed/simple;
	bh=fCfoUfUeuTXNntoGw9T456yCjjoCfY2uRUXUTCDsblU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RpTt/x/me+FVXoh4IziOirjLPdzZlf8q0qoaD/nJvByNiW2lEaZIO2stFNtGgRMz9sfCGIexxNQep4ROU1hYcGAHkl8EiEMgn+0Hl/nMjbGLE0UEIFf886va5PYlQOJYfV0zRbXlHK0MsHL0yXXYlU4k0SC2RXFjJZOjFObsRYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvU6J9rb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33af4a0beb3so1275839f8f.2;
        Tue, 30 Jan 2024 10:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706638895; x=1707243695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqlN95Bcph0ryerpvRwmwQ9kxuNXxSW2/nlGsHCgEN0=;
        b=NvU6J9rbATJfBH6R6t4yECT+m8IRVGx9JVnp9eym5j2KPf5vU+tDZLFzCH2D/V0Jme
         u5rOdAirmcHFga3V6zwgMoS7walIay0wQBcborCSJpYNnV24zYMVntwmVaUY/4bb6Ox6
         S8BuBGSL1fWL+lXCLyl8nOOQ4gSOeHeXPPOE6juf8z/TlobrCQTIxVJY1ImBceXCLFYU
         7Wk+7w5E96Ju2Tj9YWjadZHShNhXn3X322pijO+IXybZ0eMsJHJQlXHeSIlu/isGD7s5
         5VUN7BYT6t3dO50LIR8wqChrj9QVdYK4lPkdFpuN0U8jF7BJ/TszDHeUir7qIxAZ+KV+
         izKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706638895; x=1707243695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqlN95Bcph0ryerpvRwmwQ9kxuNXxSW2/nlGsHCgEN0=;
        b=xDj80K0WJxxhDCjcGcXCsOrpoPMuEhzLn2xYudax3jif5p8zKd5W2MkrkmCwRSLd0c
         nUrRB44XObM0Ho1HROJ+jZn4TzbWZIPodDLchllc8sKhNlDE6tvtKuDB/zLBagwg4MXz
         I0Gy/yTCc6PYXMX5AzbDqGRZQHqthAxCNScjifpiIpV7FGRed4SAYyENDdDzHX1+9JBk
         ptx5WmKeHFMXRWUO3FjiA49UH1UWvrCQOtmGbausLPXbmgKarr7Q9m3RvyxW+0s7+Q7M
         h3el2NtXmvrC77bAELiAxJRM9JfEDCiV5ve5VqNLBJ4qOQ9e3B4Wh+E2eSo13wB779jZ
         9Xmg==
X-Gm-Message-State: AOJu0YzyFHQvPeEB2+dEw4NCqZkxHOARYRyuoPzF3PTPexdvvrQDGZ9l
	CTUjwJxN6L4jgTTAvveVtGUsdzgdy9sH8JWFgD/Ap4FGnJBq7igtHm14NVUvoECvew==
X-Google-Smtp-Source: AGHT+IGV8PVRX9AQyC9p+e6vL7VR3Zupnh4AdLJs/QrDTP1zkkDAnrjagLpwo1eppu5bXrA1nqQOeg==
X-Received: by 2002:adf:d1cf:0:b0:33a:ed44:6679 with SMTP id b15-20020adfd1cf000000b0033aed446679mr5203255wrd.71.1706638894784;
        Tue, 30 Jan 2024 10:21:34 -0800 (PST)
Received: from [172.30.32.188] ([2001:8f8:183b:50fb::d35])
        by smtp.gmail.com with ESMTPSA id u18-20020a5d4352000000b003392b1ebf5csm11374254wrr.59.2024.01.30.10.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:21:34 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 30 Jan 2024 22:21:13 +0400
Subject: [PATCH v2 1/4] arm64: dts: rockchip: enable built-in thermal
 monitoring on rk3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-rk-dts-additions-v2-1-c6222c4c78df@gmail.com>
References: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
In-Reply-To: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706638888; l=4798;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=fCfoUfUeuTXNntoGw9T456yCjjoCfY2uRUXUTCDsblU=;
 b=aO57hvBqNqPfjxPFyPrWgDTbq9NuGgOfrJGG4SAQHvQ+I3lK5x94C8MT4cM+HoaElGPHYV8ch
 4kNATPZefPiDSe7kJRQ2HjXZNiAf2M/k5Fe8XqiwLOjUwegIT3ejpSq
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

Include thermal zones information in device tree for rk3588 variants

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 162 ++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 36b1b7acfe6a..696cb72d75d0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/reset/rockchip,rk3588-cru.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/ata/ahci.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "rockchip,rk3588";
@@ -2228,6 +2229,167 @@ tsadc: tsadc@fec00000 {
 		status = "disabled";
 	};
 
+	thermal_zones: thermal-zones {
+		/* sensor near the center of the whole chip */
+		package_thermal: package-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 0>;
+
+			trips {
+				package_crit: package-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		/* sensor between A76 cores 0 and 1 */
+		bigcore0_thermal: bigcore0-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 1>;
+
+			trips {
+				bigcore0_alert0: bigcore0-alert0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				bigcore0_alert1: bigcore0-alert1 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				bigcore0_crit: bigcore0-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&bigcore0_alert1>;
+					cooling-device =
+						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		/* sensor between A76 cores 2 and 3 */
+		bigcore2_thermal: bigcore2-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 2>;
+
+			trips {
+				bigcore2_alert0: bigcore2-alert0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				bigcore2_alert1: bigcore2-alert1 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				bigcore2_crit: bigcore2-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&bigcore2_alert1>;
+					cooling-device =
+						<&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		/* sensor between the four A55 cores */
+		little_core_thermal: littlecore-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 3>;
+
+			trips {
+				littlecore_alert0: littlecore-alert0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				littlecore_alert1: littlecore-alert1 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				littlecore_crit: littlecore-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&littlecore_alert1>;
+					cooling-device =
+						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		/* sensor near the PD_CENTER power domain */
+		center_thermal: center-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 4>;
+
+			trips {
+				center_crit: center-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu_thermal: gpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 5>;
+
+			trips {
+				gpu_crit: gpu-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		npu_thermal: npu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 6>;
+
+			trips {
+				npu_crit: npu-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
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



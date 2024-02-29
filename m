Return-Path: <linux-kernel+bounces-87347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F6A86D320
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4511C2200A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B6913C9C9;
	Thu, 29 Feb 2024 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU7yoYRe"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9113F443;
	Thu, 29 Feb 2024 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234828; cv=none; b=t06RQHL0AryRNg2jrBZ0fhBC7Xk+t30lFM8uNfyAbVA4GbGRXk7Q6+Ze+MmkPrXGjzMCVK5xvFCrwcEWcT9zn6ZpUb0MIVyt/63uupIMZNgNISPLq9T2omeJVahz8Cf71p0T7VoogmIpKwTF7hUtrnJyi7mGnPmg9tK+S7dSeho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234828; c=relaxed/simple;
	bh=KE5Jvpu3STLZrEvVNxKi1wKt+ErCjU4LRTI7OASbqGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KEPz8cuKElRkjYhC1mKI9eW+K8WYZWz9dfkiVS0dkEAPFuMjWm/kR3Dwjuy0s9PJFtZsGJpXAfj/V9lw74/XPCH8W0AQPBedDl5GGecndfqScqjQuZYlYBCqvITuiyfTNY3jMRLQujL8ssapm+5U1T8W8nTvjTEbI48wUUkxinw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU7yoYRe; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d2533089f6so15716211fa.1;
        Thu, 29 Feb 2024 11:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709234823; x=1709839623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20EWnaUkI15CtQikfFG0yCSv5fORGteC+QDCYIVPCHg=;
        b=PU7yoYRePou2p1Z+d4Uty6nOI4cAWnsuUCF8eV1FHF9DESDxZqrr2AAN15L9BggGkP
         YN9SHrblLMYpCefuu6R8SgaxvcMqzq8TU6uBVK86FwbpXFK3sGE/40o25qRHCNabQMJA
         5Xb9phlACwrnzczkg+E0BaQwtkhoSim0V2rniQK4XtzzMaPFLyZpJlZhjiwxhvMM+8n8
         CTk+SZCGhbW+vcNzTc8OKiWRrQvdLdgpKY9LacnOqTxpRdJKToM1B0txhLFXvjCdU0hV
         Nj3zBaqVrltmFMYizTodDQjq9yR3dZCbLzIvouDAfPjQaliVYC/Cum+eJC7uPh1XUrPp
         mzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709234823; x=1709839623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20EWnaUkI15CtQikfFG0yCSv5fORGteC+QDCYIVPCHg=;
        b=l2NPbqugdLPJITEAQZADuWWYdUNZ6D9xW/ir9mid+RioP/zruCStk9x/O9K7IkpRjV
         Jiv0lOm/7Lst3V9p1xczMWd0TO8SKEzmjlMCwJnVGEuKKQLJQm+jdusINoqNE3zDKJ8m
         sP2CLGd/EnlrH08AbNorQVp0m/7ovsm8jMg1GjtCJFN4PvOcRI1uy4aasME95YYaXuwY
         +PDNsF1LUXRTUn8juIcQkxotIprFes+OZrtssA+Y1gGqjnG3yW9N0hXgGXF1JnmpRMub
         T9Iw7/V41p0c4qaFtwwd+fYjlPdFe5V3R9E8gfbWdVoAYQKvb6sWtHzpxl0OxfhKckHl
         bNGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhAEuDM7XC5upKOf2r7MK2cMiv1+67oTAxSAVZrHWK+uqfDA+k5h/qFVgO0wMtg/q0NnsVvvvlLCVs6O0ariir1eZZmqR7ZF7UhR+hQqdu1MV+b70ZfAsI+WKg5Fqk68wI5P+worWLzw==
X-Gm-Message-State: AOJu0YxZWiui/7+u9dJRPbiNPNH48VQr0wxJX4qrWKixCisUUU6F3V75
	p1V7XUVSRQ4MVh0VQYrR3cOGa27DklkldPSzeslE+xeebrkpW5AWqjU55yl3ehMziQ==
X-Google-Smtp-Source: AGHT+IH3R5JqvSl7iaLlefeqBIeHTHtBwxmWhlq8gm37t6m5FX4GXWbwvL7dT8f3PxOK3XKgFqihwg==
X-Received: by 2002:a05:6512:285:b0:513:1957:de76 with SMTP id j5-20020a056512028500b005131957de76mr2197376lfp.48.1709234823266;
        Thu, 29 Feb 2024 11:27:03 -0800 (PST)
Received: from [172.30.32.188] ([2001:8f8:183b:6ebc::d35])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c1c1400b00412bca49a5bsm2853944wms.42.2024.02.29.11.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 11:27:02 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 29 Feb 2024 23:26:32 +0400
Subject: [PATCH v3 1/5] arm64: dts: rockchip: enable built-in thermal
 monitoring on RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
In-Reply-To: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709234816; l=6298;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=KE5Jvpu3STLZrEvVNxKi1wKt+ErCjU4LRTI7OASbqGw=;
 b=WH671zV4Gx1dsodJR5Ul9TBvyZalFimp/hbN9jjKVBKh2Amf8fkBDaPZra42YOGRQgbPYBftN
 F8zzCzWzudFAP4SVsEHs6YyCIyOZXkDj5DuVGTZFnlp40VGLGzIbtKl
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

Include thermal zones information in device tree for RK3588 variants.

This also enables the TSADC controller unconditionally on all boards
to ensure that thermal protections are in place via throttling and
emergency reset, once OPPs are added to enable CPU DVFS.

The default settings (using CRU as the emergency reset mechanism)
should work on all boards regardless of their wiring, as CRU resets
do not depend on any external components. Boards that have the TSHUT
signal wired to the reset line of the PMIC may opt to switch to GPIO
tshut mode instead (rockchip,hw-tshut-mode = <1>;)

It seems though that downstream kernels don't use that, even for
those boards where the wiring allows for GPIO based tshut, such as
Radxa Rock 5B [1], [2], [3]

[1] https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts#L540
[2] https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/dts/rockchip/rk3588s.dtsi#L5433
[3] https://dl.radxa.com/rock5/5b/docs/hw/radxa_rock_5b_v1423_sch.pdf page 11 (TSADC_SHUT_H)

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 176 +++++++++++++++++++++++++++++-
 1 file changed, 175 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 36b1b7acfe6a..9bf197358642 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/reset/rockchip,rk3588-cru.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/ata/ahci.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "rockchip,rk3588";
@@ -2225,7 +2226,180 @@ tsadc: tsadc@fec00000 {
 		pinctrl-1 = <&tsadc_shut>;
 		pinctrl-names = "gpio", "otpout";
 		#thermal-sensor-cells = <1>;
-		status = "disabled";
+		status = "okay";
+	};
+
+	thermal_zones: thermal-zones {
+		/* sensor near the center of the SoC */
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
+				/* threshold to start collecting temperature
+				 * statistics e.g. with the IPA governor
+				 */
+				bigcore0_alert0: bigcore0-alert0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				/* actual control temperature */
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
+				/* threshold to start collecting temperature
+				 * statistics e.g. with the IPA governor
+				 */
+				bigcore2_alert0: bigcore2-alert0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				/* actual control temperature */
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
+				/* threshold to start collecting temperature
+				 * statistics e.g. with the IPA governor
+				 */
+				littlecore_alert0: littlecore-alert0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				/* actual control temperature */
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
 	};
 
 	saradc: adc@fec10000 {

-- 
2.44.0



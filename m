Return-Path: <linux-kernel+bounces-37650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6EC83B30E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AD81F22F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221D9134723;
	Wed, 24 Jan 2024 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dc0cSr1P"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4F13399B;
	Wed, 24 Jan 2024 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706128239; cv=none; b=sg7o8D4GCBaKFox2nvxMMs+k3bj0D+MIxAGAtPo+7gESvBt7lWHNWhZm9gSOTcaL41yUkdmJOtFylH6yspewqMIoX3kw/CJxYoqchFyzasM7EKXxVtVAUkJTBD1irAl/kye10qWsnVJQO+TPx7TFAXzW8A9bw5H2vkn7uiSUIEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706128239; c=relaxed/simple;
	bh=bZ/Ku33h3h7tLZHhbK7X7TnJBS+ojPkPkQBizuVj/J8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Io/75CT2etLAra0881JuIkjRlLjy5/IK59JImX6beBPvjfJbhNH92X4ontor5bZSEBCaY1qizroDoErEfJfdzznR/Ci0WUo8XJmzKj/TFZUHgqm3WUhYxfmpIXrqCeh6s4az0TWP7HDv2rfuHTi27bHPYrXitADEqMhQCkAWo6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dc0cSr1P; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40ec715f1efso9593695e9.2;
        Wed, 24 Jan 2024 12:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706128236; x=1706733036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3ca0jnd9j+2aNrco01AKV5rkL7ji04a+DuuunuBda4=;
        b=Dc0cSr1PwMC8zP3nYgKRDo0Yb0jWiRC1aVAkuC3C6jnLkhP1EomTK7g0Ge5sp3Hdk1
         BmMQ377S4dKrTE5uI1bSzdcKVejbJLhCW3w8Ym6UXMyL3EYXaFk32qiyAXHFAdkUT0Tw
         DfOSoJoxlUgu1WNfdOeHW6tVJw3n6w3m0pLagRvG0uOVt1ju2YEvgmPH82orj8cFuPwK
         +x2QvxvPi2eMQyiugujy1NZ8YbJzV5Usz3LCh9Y1gZU7qQlCJaBJt61vlQ28icqQvI3A
         Gft5zIDHXetoMJmFuTDo8T/cFpDCmcX2p6UBfTE5LcsYnVg4F4KrkQXKlGoXI2xGPmmB
         COiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706128236; x=1706733036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3ca0jnd9j+2aNrco01AKV5rkL7ji04a+DuuunuBda4=;
        b=tiNQtaHAms4wg9m9qYyDfmba5kYYGxX+M0+s0aG9vi0VpW64hEcZmsR1SAZQ7vbP83
         q9cmLKFfBi+pQLUgR42O3m0JUHUVz2Irtf2XX8Ma3a0X5sWYOcRZfKSvzFWmsHuxdyxE
         FqPONOy/DYKGiks6vcT4U6ktcDxG6kKbO2pxHHw2bJs4W+5hrILZTrkwd//gxO30LqH4
         fN3pF5KCBJjaAIyK2Q4S/mNzcOXVKMgPQnmyLyNXudntZnJmxwRrE65gGm1oryK06ZVn
         KPN50YRiPTXrshrOIs81UJ0w9Xw3R/SvsfvgQ80dguwxK12xnKPLP+5f+KdDtpAOSKJi
         m97A==
X-Gm-Message-State: AOJu0YxTYedun7+sgC/ZBwf1x49V0Fgy5P+aG9cRehA6U/1gvjdByhm6
	hoDd2KvtIH72P4w5GtJOHnkKhoe5R0NNXkGrLEb0YSEDegl2rY0K4c99/y1OPlN+2Q==
X-Google-Smtp-Source: AGHT+IGbydoCGkGeBHV8wihvYw3DZSaWysGkFdyH6pwvnawkRmgiVYqqL/OBW+Q7g6b6iIomR4frKw==
X-Received: by 2002:a05:600c:9a3:b0:40e:5996:2291 with SMTP id w35-20020a05600c09a300b0040e59962291mr1781320wmp.138.1706128235667;
        Wed, 24 Jan 2024 12:30:35 -0800 (PST)
Received: from [172.30.32.188] ([2001:8f8:183b:50fb::d35])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c458f00b0040d62f89381sm174073wmo.35.2024.01.24.12.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 12:30:35 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 25 Jan 2024 00:30:05 +0400
Subject: [PATCH 2/4] arm64: dts: rockchip: enable built-in thermal
 monitoring on rk3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-rk-dts-additions-v1-2-5879275db36f@gmail.com>
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
In-Reply-To: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706128223; l=4885;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=bZ/Ku33h3h7tLZHhbK7X7TnJBS+ojPkPkQBizuVj/J8=;
 b=i07iNxqPSC1JCmuGjfx9B7DczeuyAJWfhY5fMC/Swk//raeORACzzOzr3C99W4a6z0SHHPHWC
 60hFkjtkxMqCao/u1EZTx/FEHcYsXXW7YAUKAi+j7FF3aAH9XTAw6jt
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

Include thermal zones information in device tree for rk3588 variants

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 165 ++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 36b1b7acfe6a..131b9eb21398 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/reset/rockchip,rk3588-cru.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/ata/ahci.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "rockchip,rk3588";
@@ -2228,6 +2229,170 @@ tsadc: tsadc@fec00000 {
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
+			polling-delay-passive = <20>;
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
+					contribution = <1024>;
+				};
+			};
+		};
+
+		/* sensor between A76 cores 2 and 3 */
+		bigcore2_thermal: bigcore2-thermal {
+			polling-delay-passive = <20>;
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
+				map1 {
+					trip = <&bigcore2_alert1>;
+					cooling-device =
+						<&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					contribution = <1024>;
+				};
+			};
+		};
+
+		/* sensor between the four A55 cores */
+		little_core_thermal: littlecore-thermal {
+			polling-delay-passive = <20>;
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
+				map2 {
+					trip = <&littlecore_alert1>;
+					cooling-device =
+						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					contribution = <1024>;
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



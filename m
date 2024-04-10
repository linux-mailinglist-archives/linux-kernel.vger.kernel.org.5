Return-Path: <linux-kernel+bounces-138171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3469189EDA8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D1D1C20E47
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A10713DDD2;
	Wed, 10 Apr 2024 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Te2T5ZgP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A313D8BE;
	Wed, 10 Apr 2024 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737817; cv=none; b=DgMLUyi8wSt/ZwpftuKxvuAB4eMCjwF2o9ukdfjKPixvUYR4xU6rls+kMmSIFFjl7P721pHFNuQbvURJzjbYQh6df6kmg02Ozov8QNWcZ4qY7RD8K2XZ9vIxhtmC0ctycXQNx/oumG0ThQoQeKFtBRo058aXG3O1641yIO0eejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737817; c=relaxed/simple;
	bh=b4MLchRiNSL52tqLOyPY8VBf2E7n/dezst1uYn65DhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYd0GItI+Mn81nL2C+Y7rOXowz6SjnuZ6Cbkh7rcqTsc1JI+PBYh3ufQx0D2f7Wi8V8JTxqWMHOXWp5P+fsmaXdo1JZ2vzWY63AlsJ8QETPT9pskTaACcIppunOCzJ4SdhA63IBAAEPIrXhQN1T1brMP5kXJif9IPfy7QjKw6g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Te2T5ZgP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712737814;
	bh=b4MLchRiNSL52tqLOyPY8VBf2E7n/dezst1uYn65DhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Te2T5ZgPV2LKbzTtO1oH+ZWGnawgmIKS/5/7aEQPrwB53c/40JzpVJ+gLcD6vHXgq
	 iTZmLGzypNDGZYY98NIiFSlBzs1+cP/119Dd6W6ve7LM3BK4HXv1mnNAJSF7bYTuFr
	 blUjDzwH78OLhW/mUxxv4u919c630QxyROJMmMswD2nghmMT/ELq73VCjxQyaSstkA
	 i00APPQ8HAdllwHsQeOzldtkfIHIsAnuqNnn02KyIp5OB3MjnJVn7gn1CL8o4ife1k
	 lJZ8cWjIaIjJfPBpGZmvHDZtYzipzix1xcRXckJ/gv5H7UWDeYrUez4IOQqZugWwGQ
	 UT1KecdF/7B0w==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F22B537820E2;
	Wed, 10 Apr 2024 08:30:12 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bchihi@baylibre.com,
	bero@baylibre.com,
	amergnat@baylibre.com,
	nfraprado@collabora.com,
	michael.kao@mediatek.com,
	mka@chromium.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 3/3] arm64: dts: mediatek: mt8183: Refactor thermal zones
Date: Wed, 10 Apr 2024 10:30:02 +0200
Message-ID: <20240410083002.1357857-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410083002.1357857-1-angelogioacchino.delregno@collabora.com>
References: <20240410083002.1357857-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The thermal zones in MT8183 had cryptic names and all of them, apart
from the cpu-thermal zone, had no thermal trips, hence those were not
probed at all.

Refactor the tzts1..5 and tztsABB thermal zones to add the correct
thermal trips and give them a meaningful name, corresponding to the
actually monitored thermal zone.
While at it, also rename the thermal sensor node to "thermal-sensor".

Now the thermal zones are probing and their temperatures can be read.

Fixes: b325ce39785b ("arm64: dts: mt8183: add thermal zone node")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 136 +++++++++++++++++------
 1 file changed, 102 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 93dfbf130231..1978156cae76 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1183,7 +1183,7 @@ spi0: spi@1100a000 {
 			status = "disabled";
 		};
 
-		thermal: thermal@1100b000 {
+		thermal: thermal-sensor@1100b000 {
 			#thermal-sensor-cells = <1>;
 			compatible = "mediatek,mt8183-thermal";
 			reg = <0 0x1100b000 0 0xc00>;
@@ -2089,61 +2089,129 @@ THERMAL_NO_LIMIT
 			};
 		};
 
-		/* The tzts1 ~ tzts6 don't need to polling */
-		/* The tzts1 ~ tzts6 don't need to thermal throttle */
-
-		tzts1: tzts1 {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
+		tzts1: soc-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&thermal 1>;
 			sustainable-power = <5000>;
-			trips {};
-			cooling-maps {};
+			trips {
+				soc_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				soc_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 
-		tzts2: tzts2 {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
+		tzts2: gpu-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&thermal 2>;
 			sustainable-power = <5000>;
-			trips {};
-			cooling-maps {};
+
+			trips {
+				gpu_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 
-		tzts3: tzts3 {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
+		tzts3: md1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&thermal 3>;
 			sustainable-power = <5000>;
-			trips {};
-			cooling-maps {};
+
+			trips {
+				md1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				md1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 
-		tzts4: tzts4 {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
+		tzts4: cpu-little-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&thermal 4>;
 			sustainable-power = <5000>;
-			trips {};
-			cooling-maps {};
+
+			trips {
+				cpul_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpul_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 
-		tzts5: tzts5 {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
+		tzts5: cpu-big-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&thermal 5>;
 			sustainable-power = <5000>;
-			trips {};
-			cooling-maps {};
+
+			trips {
+				cpub_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpub_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 
-		tztsABB: tztsABB {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
+		tztsABB: tsabb-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&thermal 6>;
 			sustainable-power = <5000>;
-			trips {};
-			cooling-maps {};
+
+			trips {
+				tsabb_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				tsabb_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 	};
 };
-- 
2.44.0



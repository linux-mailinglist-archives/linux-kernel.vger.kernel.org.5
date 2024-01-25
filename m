Return-Path: <linux-kernel+bounces-39340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BF283CEF8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E1DB279D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47D213B791;
	Thu, 25 Jan 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="FWqk6gH4"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4FF13A25D;
	Thu, 25 Jan 2024 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219793; cv=none; b=QidKAh3n2dKRfaD9y0ksEcErzLT3LaCzEqA9hyga4mtbh41S2vEkXoaTHyjPgjWDFtpnwPBdygI4CsuW7GBgZsOuKdbu4h+gKg549SfquIavWJ0FGxXdwz/sw66y/+2WfZ0zovRK+HbAZypMIR+DkSBooaAb8oYkyveyRUuBtdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219793; c=relaxed/simple;
	bh=Oqyozkp+3yIVzn78FJIm4wo9l8cFnDnRA86nkZK/rME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mGpa3X9eP8NOkawquJtSVSbOdbdGnSUaqRPfJWu5GEwX4dX2qVCgiSFVB0JmDDIP555uswQDgW0/+7rVoSqhn7EFKWkETuIwl9H4RZMGVwg8rTs+4cOHJhukP2bee9JxuZY+7WZKhgFOj0ghmZtlrnO+ZkFVU1BwN429Y0sJhkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=FWqk6gH4; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1706219789; bh=Oqyozkp+3yIVzn78FJIm4wo9l8cFnDnRA86nkZK/rME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FWqk6gH4SXpC2psEycIdHU/CVfUyW4vur7C0aJS36GTNhjIxuWiR8IBAXm4rq1Wkv
	 oq02yrBUliIW/ZInetRbZAtE4n7ebdy5p5leoKifisJ9lX1wJlm48DpgEvkbArc8mE
	 x7l49g5ey8AtsnUuaYUQSpHqZzvyZtYBE0kStd6U=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Thu, 25 Jan 2024 22:56:26 +0100
Subject: [PATCH RFC 2/2] arm64: dts: qcom: msm8953: Add GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-msm8953-gpu-v1-2-f6493a5951f3@z3ntu.xyz>
References: <20240125-msm8953-gpu-v1-0-f6493a5951f3@z3ntu.xyz>
In-Reply-To: <20240125-msm8953-gpu-v1-0-f6493a5951f3@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Vladimir Lypak <vladimir.lypak@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5530; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=uxlKtlyhduTvOfdocjjZ8QA65zmTpmpXVNCWTg8SbYg=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlstkLT23pPvklj9ZVYTuNZCeUf+xI5SlD7A/Pi
 NF34HTMp4SJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZbLZCwAKCRBy2EO4nU3X
 VmSeD/9GZ5NSNz0lBhI9KRyrbfH5Zm43r2g8/U70M2nZlrcHIVT1+/3d/1QcX2KOLpobK3lqx4z
 EnnyYuK74Qh+dqOdcepbvrNDs7uV3hUOGYSDOk2ULexLoS1JAU8b4Pb3LkQPQOJTtuqXhtjY95h
 mRaBGQLrFiOrEQbJbF5GLoXkhkhh96ezMqB74otxvdMSSBxKzGQtljh1GdXvSSwSwsvSR0XSs1/
 beQIlsZr4+FnffcySH3fom6BO87IEop3O8HpUPUJc64x5lKC4O7b5Bx/F7D0WOb8AK2Q+ass52i
 BtM3k/iQaKkGl+7uNJdP4uePPhQZWQPG5ANc4OPAbj/GFfapYeY+4n90wCjVBnYMl1mOYeNJhKL
 kKZtQTVBHFoWkWTHNLrTtD3S48czekxbDJ8yhuWjP0wy9i2YBD9eSOOme0Fcat9bb6W4YE1xEcx
 wPRuzPlQ7n4xgyL01OwTbclzjitaw2U3D7KMfdbR+Orin/Nmgh1Swq65A/XmahDu5A6WZqkwXRj
 dLbRs7sKaWG3H6leXONwKFN/I7fovRZDah3NzhU3dMeecrAWXhmEOMg8R6j295L/Ae1bLKSG7tF
 SmjuD86vTn1wJFLYgWohjGQ8TlpvmehEPzUEWKXYdvssX1zf5ktTnV1W3GRcei3cjqTrtnWJpeT
 YO8kPGWAPjO6KSg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

From: Vladimir Lypak <vladimir.lypak@gmail.com>

Add the GPU node for the Adreno 506 found on this family of SoCs. The
clock speeds are a bit different per SoC variant, SDM450 maxes out at
600MHz while MSM8953 (= SDM625) goes up to 650MHz and SDM632 goes up to
725MHz.

To achieve this, create a new sdm450.dtsi to hold the 600MHz OPP and
use the new dtsi for sdm450-motorola-ali.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Co-developed-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi            | 115 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts |   2 +-
 arch/arm64/boot/dts/qcom/sdm450.dtsi             |  14 +++
 arch/arm64/boot/dts/qcom/sdm632.dtsi             |   8 ++
 4 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 91d083871ab0..1fe0c0c4fd15 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -1046,6 +1046,94 @@ mdss_dsi1_phy: phy@1a96400 {
 			};
 		};
 
+		gpu: gpu@1c00000 {
+			compatible = "qcom,adreno-506.0", "qcom,adreno";
+			reg = <0x01c00000 0x40000>;
+			reg-names = "kgsl_3d0_reg_memory";
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_OXILI_GFX3D_CLK>,
+				 <&gcc GCC_OXILI_AHB_CLK>,
+				 <&gcc GCC_BIMC_GFX_CLK>,
+				 <&gcc GCC_BIMC_GPU_CLK>,
+				 <&gcc GCC_OXILI_TIMER_CLK>,
+				 <&gcc GCC_OXILI_AON_CLK>;
+			clock-names = "core",
+				      "iface",
+				      "mem_iface",
+				      "alt_mem_iface",
+				      "rbbmtimer",
+				      "alwayson";
+			power-domains = <&gcc OXILI_GX_GDSC>;
+
+			iommus = <&gpu_iommu 0>;
+			operating-points-v2 = <&gpu_opp_table>;
+
+			#cooling-cells = <2>;
+
+			status = "disabled";
+
+			zap-shader {
+				memory-region = <&zap_shader_region>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-19200000 {
+					opp-hz = /bits/ 64 <19200000>;
+					opp-supported-hw = <0xff>;
+					required-opps = <&rpmpd_opp_min_svs>;
+				};
+
+				opp-133300000 {
+					opp-hz = /bits/ 64 <133300000>;
+					opp-supported-hw = <0xff>;
+					required-opps = <&rpmpd_opp_min_svs>;
+				};
+
+				opp-216000000 {
+					opp-hz = /bits/ 64 <216000000>;
+					opp-supported-hw = <0xff>;
+					required-opps = <&rpmpd_opp_low_svs>;
+				};
+
+				opp-320000000 {
+					opp-hz = /bits/ 64 <320000000>;
+					opp-supported-hw = <0xff>;
+					required-opps = <&rpmpd_opp_svs>;
+				};
+
+				opp-400000000 {
+					opp-hz = /bits/ 64 <400000000>;
+					opp-supported-hw = <0xff>;
+					required-opps = <&rpmpd_opp_svs_plus>;
+				};
+
+				opp-510000000 {
+					opp-hz = /bits/ 64 <510000000>;
+					opp-supported-hw = <0xff>;
+					required-opps = <&rpmpd_opp_nom>;
+				};
+
+				opp-560000000 {
+					opp-hz = /bits/ 64 <560000000>;
+					opp-supported-hw = <0xff>;
+					required-opps = <&rpmpd_opp_nom_plus>;
+				};
+
+				/*
+				 * This opp is only available on msm8953 and
+				 * sdm632, the max for sdm450 is 600MHz.
+				 */
+				opp-650000000 {
+					opp-hz = /bits/ 64 <650000000>;
+					opp-supported-hw = <0xff>;
+					required-opps = <&rpmpd_opp_turbo>;
+				};
+			};
+		};
+
 		gpu_iommu: iommu@1c48000 {
 			compatible = "qcom,msm8953-iommu", "qcom,msm-iommu-v2";
 			ranges = <0 0x01c48000 0x8000>;
@@ -2045,6 +2133,33 @@ map0 {
 				};
 			};
 		};
+
+		gpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsens0 15>;
+
+			trips {
+				gpu_alert: trip-point0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu_crit: crit {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
 	};
 
 	timer {
diff --git a/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts b/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
index 362be5719dd2..e27f3c5d5bba 100644
--- a/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
+++ b/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
@@ -4,7 +4,7 @@
  */
 /dts-v1/;
 
-#include "msm8953.dtsi"
+#include "sdm450.dtsi"
 #include "pm8953.dtsi"
 #include "pmi8950.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sdm450.dtsi b/arch/arm64/boot/dts/qcom/sdm450.dtsi
new file mode 100644
index 000000000000..b222aeb459a3
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm450.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/* Copyright (c) 2023, Luca Weiss <luca@z3ntu.xyz> */
+
+#include "msm8953.dtsi"
+
+&gpu_opp_table {
+	/delete-node/ opp-650000000;
+
+	opp-600000000 {
+		opp-hz = /bits/ 64 <600000000>;
+		opp-supported-hw = <0xff>;
+		required-opps = <&rpmpd_opp_turbo>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm632.dtsi b/arch/arm64/boot/dts/qcom/sdm632.dtsi
index 645b9f6a801f..95b025ea260b 100644
--- a/arch/arm64/boot/dts/qcom/sdm632.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm632.dtsi
@@ -79,3 +79,11 @@ &CPU7 {
 	compatible = "qcom,kryo250";
 	capacity-dmips-mhz = <1980>;
 };
+
+&gpu_opp_table {
+	opp-725000000 {
+		opp-hz = /bits/ 64 <725000000>;
+		opp-supported-hw = <0xff>;
+		required-opps = <&rpmpd_opp_turbo>;
+	};
+};

-- 
2.43.0



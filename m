Return-Path: <linux-kernel+bounces-60635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E244F8507C5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 05:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1268F1C2241B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 04:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42901171DC;
	Sun, 11 Feb 2024 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9IqMTrV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598FC187F;
	Sun, 11 Feb 2024 04:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707626253; cv=none; b=Qrj5kg7xCFHMBLGcTeOZFRd6nIeXNXMHY5DqINhvSdu1zSxPPQoFqRFODe5Gb83lH5riM3PD9FOff4aOD1VtBMEqgM/FUWxwFflya2fs90D7GkKpndCLXRm4OTXbRy0b5p2RR057rW7IVN7iWASzEX4IASzVsmkln4e1KurTRFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707626253; c=relaxed/simple;
	bh=3kdaHklZ7qs2X5runW2E7tzMn/ra6AmKvRJeohJIfKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNBULM8XfAPsHUOWKwb9F9+jwfBoWON2nI2ed+pjLFWNue35kU7OzPBtDI5mvrhgtGMOTn9l7eLq2O0UBynvDhM7DV9HPwwUPGFPEEGHAqYwoOKO56FakCNs97l79wXOVyMr1okTzv9GkylMT1+0HOxSrOvufWQCfqtk9Dgvu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9IqMTrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C95EFC433C7;
	Sun, 11 Feb 2024 04:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707626252;
	bh=3kdaHklZ7qs2X5runW2E7tzMn/ra6AmKvRJeohJIfKQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=a9IqMTrVQpkEnNj+k45caj9xYcU+1e4kzPoJKuhxW0WeaD9FiVufxNjma6JelMBLc
	 wo1jDW2CJasPvwp1d5x/WE0uzspilV5670XTzQOFpP8P0Dmxui5cvDKSuZqfd9mhdY
	 efidrdaPgEkFfhchfdamf3jgrjAof3bT7yH/BDs2reLeIm7I2tHpzQ8DUqwqJeN4SN
	 mdHcD5xI976MyPIT4Uql8o/ugEeXxdaVxHsczaKTuJkiWHBtVmoK6WK01iwfKE+9B1
	 VfKcw3UFhng00OlFEVPjklJEDYFRxyfdWeyEVW1Tsph52W9mdWcCtaU5sVYTvKBUqN
	 AXGDRv5qhn4fg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A080AC4829A;
	Sun, 11 Feb 2024 04:37:32 +0000 (UTC)
From:
 Bjorn Andersson via B4 Relay <devnull+quic_bjorande.quicinc.com@kernel.org>
Date: Sat, 10 Feb 2024 20:41:59 -0800
Subject: [PATCH 1/2] arm64: dts: qcom: sc8280xp-crd: Add PMIC die-temp vadc
 channels
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-sc8280xp-pmic-thermal-v1-1-a1c215a17d10@quicinc.com>
References: <20240210-sc8280xp-pmic-thermal-v1-0-a1c215a17d10@quicinc.com>
In-Reply-To: <20240210-sc8280xp-pmic-thermal-v1-0-a1c215a17d10@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4497;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=JE6dXqJeCJwTlMybhGWArcVWwFZnYe1FeEabXIeH8MU=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBlyFAX6WBiHumNqoBNjl4WQ1BZEzjukhy4hmA4A
 FbFN9C0UjmJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZchQFxUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcWMlw//dUSEEopXhApys7H1JJr+bphVigTOYenqWCVVrYR
 3x+WUGFN8tp3O1FZQs0QSAOiGzG3k32BRZEhxzRMAvLULB6j3DjLkAHLp4NmAf1bZEJFmM7bRxz
 AWc7Jp56xniCY541Z0WLfqSn5G77BrS0xcohYYxv3zwaujV2HzPiFXDd8BkJu7DQQK5ThnJ0/cJ
 Y8uJwi4YOKNRTjVjYsbaIyS6XwO8KfK/dbAhcuU9us/mwH+jiFUY7O6QkbIpJVN697gwybVDNjf
 bXItqYDPwnI+oNfLmYhReAzoXJKAUoZGhw6BE1NNfukodgRq6zBRKL4bXl9rcTmFMfuY9gPLcK8
 SdPIFwX0mBoT91yYjZ8pPXzONWgllv1Ay2nKjLPNXaXnEnHZAdqKKI+/7pKnGRi1382Afy2HiyN
 pkwdBCBOcThKjY9KcsFvJFdPbES3+A4/2c6w4aj4mAtHY1Lg4N0KZJMrNP+vN5yFqJE6PJDLJWJ
 zDA6vRPY5PasLgF853GaBoqW3ecT1j5XYQT/xWc02QJ7lLAWJIWOVWE7w14UeSrSPpxXwXsCEuL
 paHz6frEbSXFWlgpWpiW5cTl/T6IN5fTq1ioOu3vnFiBcOCGa9A12BN7BCGdbS9OpvBrWGobisx
 ecngBcsg0lpXbYMJi1o1OU8qpxHyPhhiPY9cJQqhX6u4=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Endpoint-Received:
 by B4 Relay for quic_bjorande@quicinc.com/default with auth_id=118
X-Original-From: Bjorn Andersson <quic_bjorande@quicinc.com>
Reply-To: <quic_bjorande@quicinc.com>

From: Bjorn Andersson <quic_bjorande@quicinc.com>

The die-temp vadc channels are not defined for the CRD, but describing
them directly would directly duplicate the definition from the Lenovo
Thinkpad X13s DeviceTree.

The sc8280xp-pmics file describes the common configuration of PMK8280,
two PMC8280, PMC8280C, and PMR735a. As such, even though these vadc
channels makes references across PMICs, it's suitable to define them in
the shared file.

Do this, and enable the pmk8280 vadc for the CRD.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          |  4 +++
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     | 35 +---------------------
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi       | 34 +++++++++++++++++++++
 3 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index ffc4406422ae..22f10813aa3c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -604,6 +604,10 @@ rtc_offset: rtc-offset@bc {
 	};
 };
 
+&pmk8280_vadc {
+	status = "okay";
+};
+
 &qup0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index def3976bd5bb..ce2564a6c26e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -6,10 +6,8 @@
 
 /dts-v1/;
 
-#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
@@ -855,25 +853,6 @@ rtc_offset: rtc-offset@bc {
 &pmk8280_vadc {
 	status = "okay";
 
-	channel@3 {
-		reg = <PMK8350_ADC7_DIE_TEMP>;
-		qcom,pre-scaling = <1 1>;
-		label = "pmk8350_die_temp";
-	};
-
-	channel@44 {
-		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
-		qcom,hw-settle-time = <200>;
-		qcom,ratiometric;
-		label = "pmk8350_xo_therm";
-	};
-
-	channel@103 {
-		reg = <PM8350_ADC7_DIE_TEMP(1)>;
-		qcom,pre-scaling = <1 1>;
-		label = "pmc8280_1_die_temp";
-	};
-
 	channel@144 {
 		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
 		qcom,hw-settle-time = <200>;
@@ -902,12 +881,6 @@ channel@147 {
 		label = "sys_therm4";
 	};
 
-	channel@303 {
-		reg = <PM8350_ADC7_DIE_TEMP(3)>;
-		qcom,pre-scaling = <1 1>;
-		label = "pmc8280_2_die_temp";
-	};
-
 	channel@344 {
 		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(3)>;
 		qcom,hw-settle-time = <200>;
@@ -935,12 +908,6 @@ channel@347 {
 		qcom,ratiometric;
 		label = "sys_therm8";
 	};
-
-	channel@403 {
-		reg = <PMR735A_ADC7_DIE_TEMP>;
-		qcom,pre-scaling = <1 1>;
-		label = "pmr735a_die_temp";
-	};
 };
 
 &qup0 {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index 80ee12ded4f4..58fea376f0e2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -3,6 +3,9 @@
  * Copyright (c) 2022, Linaro Limited
  */
 
+#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
@@ -85,6 +88,37 @@ pmk8280_vadc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 			status = "disabled";
+
+			channel@3 {
+				reg = <PMK8350_ADC7_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+				label = "pmk8350_die_temp";
+			};
+
+			channel@44 {
+				reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+				qcom,hw-settle-time = <200>;
+				qcom,ratiometric;
+				label = "pmk8350_xo_therm";
+			};
+
+			channel@103 {
+				reg = <PM8350_ADC7_DIE_TEMP(1)>;
+				qcom,pre-scaling = <1 1>;
+				label = "pmc8280_1_die_temp";
+			};
+
+			channel@303 {
+				reg = <PM8350_ADC7_DIE_TEMP(3)>;
+				qcom,pre-scaling = <1 1>;
+				label = "pmc8280_2_die_temp";
+			};
+
+			channel@403 {
+				reg = <PMR735A_ADC7_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+				label = "pmr735a_die_temp";
+			};
 		};
 
 		pmk8280_adc_tm: adc-tm@3400 {

-- 
2.43.0



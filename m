Return-Path: <linux-kernel+bounces-99972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8907A87900F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB441F21F67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A904F78263;
	Tue, 12 Mar 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="HmpIIgtn"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC9177F06;
	Tue, 12 Mar 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233549; cv=none; b=eEn1lrbq876FzgqAhwcD/qRzpvVAdMMrA2vcK11hHWMYXKz/FVZuHBq/IjSPigGnO7/AuUomBg0pBeBl769IzfYgDy2+sYYP3F5uM/M4YJCj0eWc2lHGKEV0X/uFKojL5J93vPN7e4SkcbYqSKnHYOiq/boCfUiXv8iyr7takHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233549; c=relaxed/simple;
	bh=3SdRLYZ3Z+9SbuVBto4NNdKldL11u55/Rfex0dOOF1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZvWX9q6myz+IUjVSszqWJl9pXGRbiguy5TBS9fv6NwWGYrN5qA2EQnhI2ximkA8nJavtoBRTst78TzqaxdcUv2dRBLCl2qErmLjON8nvy7M5qgp8qEPyxsrd1eD3hmzzACcwjbI0FClSKSrcWbZleAyGsITpg01JxqlndWkDUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=HmpIIgtn; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id ED4C741DDD;
	Tue, 12 Mar 2024 13:42:23 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1710232944; bh=3SdRLYZ3Z+9SbuVBto4NNdKldL11u55/Rfex0dOOF1E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HmpIIgtnNZoKS1Zr2NkaS/2JEglvF4JkU9ZUOFjz/qtSF+jTKwQjc7Gqw5+boDDK6
	 brtx33BZ9oY73lzRf+AmTAM2XmUtj5fwQ2A0USRe4zDk0cSVYLGyIaDp64fv+DmH3S
	 5fkCQRkKUycm+SLIBWONzjBu/GicTIU7ZK6gsi2whO9igYeCfRWhzctq8IeTxsew7S
	 GFK0X+6Exr5V8AW4KSR2I+msGutzRMB+Q9Dm5TtVeZhnwtw+QM1dMzmRzXGcXCzWlO
	 WPDdqgtrsNiKhZL3ouHH+M0ObhbhPpaC3gu4l3pdu3hKohpikp08jr7CFHtE2k9nso
	 1lrDAkobUSP5g==
From: Nikita Travkin <nikita@trvn.ru>
Date: Tue, 12 Mar 2024 13:42:10 +0500
Subject: [PATCH v4 4/4] arm64: dts: qcom: acer-aspire1: Add embedded
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240312-aspire1-ec-v4-4-bd8e3eea212f@trvn.ru>
References: <20240312-aspire1-ec-v4-0-bd8e3eea212f@trvn.ru>
In-Reply-To: <20240312-aspire1-ec-v4-0-bd8e3eea212f@trvn.ru>
To: Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2209; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=3SdRLYZ3Z+9SbuVBto4NNdKldL11u55/Rfex0dOOF1E=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBl8BVrccxopNDy05Gy0/m6i1aDHJfSPZjMCUERj
 2DmLQYPDhqJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZfAVawAKCRBDHOzuKBm/
 dYCHD/9gU6VDWMdigpmmBvodBpEXHEGimk/bDIpQeSkoResC6yw/CVJzdxaVVwdK8J2ZXybC34b
 sZw8i8mBFwLDN2REtfMOQysJ8YEciKUbv6OKkls6Cpe52TFTLrFPJCbINDak6m8TCJ2NKcGuE/G
 GmECsRnMNXEejm8z2nOWzWnLV9xT4u73IlozvzcDJOmice5PfXyUEjDEMC0gzjlyEWt97CqGGGW
 dwPqcNisa61gZFA+D/Gl9JbUcELupfQt6wL4luY89RfMQ/aQLJlfzR7csLswIw5xSiVKRgjLKZY
 oYNgMV3bdPQsPgmDXFpa8G1xE9NESwnR962w1Sq95JjpjlzRlEj5cmIp8c+xOQWF55zGTWwNFcO
 TYugld5bEOgkxRU15ukWxT0tqJOfmSPYllhaL00VLQFb/ANwA8pwDdJ/sgu0iu7PFWrTR7kqxk0
 uMS4KnqG8eHpKJUc04XfsOlKT8lTCaAIVBwC+wAP30aYF3obBeIP2hkd+S6O0yr1MrxwTV6oMqV
 06L0bWgub5xPvjpYcIN9z9EH3E1KGPxB68WcLZAoJCC+056XbNdj/oY6OhT/JO71n0I1HfQXLHS
 uvaJpQfpdiSKmcFghl2CDvyTMw4+GeD0wckOy3V6XG779km/S0cPJRlG1UOc7X7VuPlgP4CLMul
 46ujk4mxtBANnHA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

The laptop contains an embedded controller that provides a set of
features:

- Battery and charger monitoring
- USB Type-C DP alt mode HPD monitoring
- Lid status detection
- Small amount of keyboard configuration*

[*] The keyboard is handled by the same EC but it has a dedicated i2c
bus and is already enabled. This port only provides fn key behavior
configuration.

Add the EC to the device tree and describe the relationship between the
EC-managed type-c port and the SoC DisplayPort.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 40 +++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
index 5afcb8212f49..3f0d3e33894a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
@@ -255,7 +255,25 @@ &i2c2 {
 	clock-frequency = <400000>;
 	status = "okay";
 
-	/* embedded-controller@76 */
+	embedded-controller@76 {
+		compatible = "acer,aspire1-ec";
+		reg = <0x76>;
+
+		interrupts-extended = <&tlmm 30 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&ec_int_default>;
+		pinctrl-names = "default";
+
+		connector {
+			compatible = "usb-c-connector";
+
+			port {
+				ec_dp_in: endpoint {
+					remote-endpoint = <&mdss_dp_out>;
+				};
+			};
+		};
+	};
 };
 
 &i2c4 {
@@ -419,6 +437,19 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dp {
+	data-lanes = <0 1>;
+
+	vdda-1p2-supply = <&vreg_l3c_1p2>;
+	vdda-0p9-supply = <&vreg_l4a_0p8>;
+
+	status = "okay";
+};
+
+&mdss_dp_out {
+	remote-endpoint = <&ec_dp_in>;
+};
+
 &mdss_dsi0 {
 	vdda-supply = <&vreg_l3c_1p2>;
 	status = "okay";
@@ -857,6 +888,13 @@ codec_irq_default: codec-irq-deault-state {
 		bias-disable;
 	};
 
+	ec_int_default: ec-int-default-state {
+		pins = "gpio30";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	edp_bridge_irq_default: edp-bridge-irq-default-state {
 		pins = "gpio11";
 		function = "gpio";

-- 
2.43.2



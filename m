Return-Path: <linux-kernel+bounces-46101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA5F843A55
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB62D1F2AEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF5563504;
	Wed, 31 Jan 2024 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8W6VO2D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBC15813B;
	Wed, 31 Jan 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691887; cv=none; b=Ik/InyM8UxePWzF75XNsTX5YLH34asrF2zNLWxf+SqZBwHyyEknhsm4E8VCBcfs/kCA6nRR1CFy8tHx8u0ME8r2dmLDyM8nhhpu1JnHXrKoKmi8t4D4/e/FR53Dnd7mG6Q30ji5lWn/ZHQRmDiovfOlceBwhxZB1g1fzMDD7clQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691887; c=relaxed/simple;
	bh=QlP98aSQSqBpclGKVx9/GrrG73fSHvaxlFUeCcBcyCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kfFFrrvofbHKgTiHcwHMEi93YEPYX9jwL4A2g6238/RFWOr22K5eaYD5WTVyy4NW4rS9/VNWvQ/3Z5CPwpLuS6QDOuvf9IF/XA1fLLabw1gyd+AYC9m/XVGb9gAdzOU2p5jBjM+RQGHAKuU+u78k4qxXo+Nk1PnonneX9nZvetI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8W6VO2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36C93C43390;
	Wed, 31 Jan 2024 09:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706691887;
	bh=QlP98aSQSqBpclGKVx9/GrrG73fSHvaxlFUeCcBcyCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=O8W6VO2DtjQRTH84AM5vGi+Rkudj9MGURJ6TmVkEF+a175CpOq1jPESfQfOYZVbXK
	 mZirgbsyqAvFtg56GSwrzJWChf4joEPSmT0VquvC7LbEIRBBSiPqmNadjQI3Rs8El3
	 OqSid/oyMr3pnNC0jCKu68RHWDLv/XKt72/3FhPtv6OvaQ+qi1SxldMGlAsTpSzoOt
	 kzEvfZLBSrAVZ3R1Sz3gEVSPi2N/SPaH9cnc6AaPOfiw/e4jtXdQD8T64dU5PQbmXb
	 mqSM2W8U3NgD2tslfdELDA54CliEyLf00TF7E6hVTS6LpTClbKzTP6RPvI8j1XTIOI
	 qnhFu+9sWCOYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B96C48285;
	Wed, 31 Jan 2024 09:04:47 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Wed, 31 Jan 2024 01:04:47 -0800
Subject: [PATCH v2 2/2] ARM: dts: qcom: msm8960: expressatt: Add mXT224S
 touchscreen
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240131-expressatt_mxt224s_touchscreen-v2-2-4463ae0414b5@gmail.com>
References:
 <20240131-expressatt_mxt224s_touchscreen-v2-0-4463ae0414b5@gmail.com>
In-Reply-To:
 <20240131-expressatt_mxt224s_touchscreen-v2-0-4463ae0414b5@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rudraksha Gupta <guptarud@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706691886; l=1620;
 i=guptarud@gmail.com; s=20240120; h=from:subject:message-id;
 bh=4Gi3ILnitkF34hh7B1r4k2VP7IMCG7Hjj/6AwpaU750=;
 b=aToJeq7bdKkloeO+pbha6Cimk77XwMqWEyri7P45ecOMZaHTkdN4Cy1Gcpli+x+loyRp/LVf6
 SNTmxUSdiqZDmTcl8lGZNOvhSgthxCwy1F5lkuFNrb/xQprQc/fsi0B
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=RGmug3GRHS4XYTXDcT2VrlTGXlEF2gY4L9/swGIU1ko=
X-Endpoint-Received:
 by B4 Relay for guptarud@gmail.com/20240120 with auth_id=114
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: <guptarud@gmail.com>

From: Rudraksha Gupta <guptarud@gmail.com>

Add mXT224S touchscreen

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 .../dts/qcom/qcom-msm8960-samsung-expressatt.dts   | 31 +++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts b/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
index 47e0e26ad9f0..af6cc6393d74 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
@@ -85,6 +85,27 @@ &gsbi1_spi {
 	status = "okay";
 };
 
+&gsbi3 {
+	qcom,mode = <GSBI_PROT_I2C>;
+	status = "okay";
+};
+
+&gsbi3_i2c {
+	status = "okay";
+
+	// Atmel mXT224S touchscreen
+	touchscreen@4a {
+		compatible = "atmel,maxtouch";
+		reg = <0x4a>;
+		interrupt-parent = <&msmgpio>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+		vdda-supply = <&pm8921_lvs6>;
+		vdd-supply = <&pm8921_l17>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen>;
+	};
+};
+
 &msmgpio {
 	spi1_default: spi1-default-state {
 		mosi-pins {
@@ -123,6 +144,14 @@ gpio_keys_pin_a: gpio-keys-active-state {
 		drive-strength = <8>;
 		bias-disable;
 	};
+
+	touchscreen: touchscreen-int-state {
+		pins = "gpio11";
+		function = "gpio";
+		output-enable;
+		bias-disable;
+		drive-strength = <2>;
+	};
 };
 
 &pm8921 {
@@ -285,7 +314,7 @@ pm8921_l16: l16 {
 		};
 
 		pm8921_l17: l17 {
-			regulator-min-microvolt = <1800000>;
+			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 			bias-pull-down;
 		};

-- 
2.43.0



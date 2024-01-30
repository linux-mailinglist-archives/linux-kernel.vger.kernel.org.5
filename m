Return-Path: <linux-kernel+bounces-43846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C08284197A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED3E1C24E81
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B7736B1D;
	Tue, 30 Jan 2024 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5MrxK81"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CA7364C6;
	Tue, 30 Jan 2024 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582587; cv=none; b=RZDIZOKceeDCuzcdZPYB+PulrX1LDKx3GJHikc2oDOy9A+LKvdFmWGBPy/caddlfelez6nfRix5M13brmtvkQpS48UMvXDVosy19tDwfAHZ9XRodKvJBb8ekv/f2jbi3BkCA7qLcxVFrb92CUUe/D4Bslk4s5Hr1iRSYlu4XLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582587; c=relaxed/simple;
	bh=QlP98aSQSqBpclGKVx9/GrrG73fSHvaxlFUeCcBcyCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ogA2ToRUjDxTq9eA43gtKKGUHwJ/f93lZWfTmINnF/3tU44fiXc24mn3/PUIZ2tGG7MqrG9qrKmp2dhofxW07xjr+5SIqHE7wD8qqRM7Nqbsk6AayQ221v92lbGs7e8vLcTJS+3QZ/3y11Zad6bADTHu7yGj5hoVLy3ZKmfOuOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5MrxK81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5EA7C43390;
	Tue, 30 Jan 2024 02:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706582586;
	bh=QlP98aSQSqBpclGKVx9/GrrG73fSHvaxlFUeCcBcyCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e5MrxK81lePY5Kev89+qPYsObInOnXJTN/ByIyW5q5hQUha9pPeOjZxLTq+WJ6ENs
	 N22i8FkszyHKOTKxk9RZjD9qv/l5lw1CbBajAWtGb6QALPgveJOtDjoeONxZXBi6e/
	 GqMIC0C7x4MUyWhe9TZVbyiVBY9M3qp6MryGw0DWlFIOV/QQ2vuzzApFO/ZlCFd0hs
	 XkjMoPislaeZ37/ilcEXocZ+gMDYXh/kI9Z8jzPBLeUEqrnqJc9XR39aFO4s6IXh6W
	 cWKvMbEd31qHDQmMZ8s13Vrqqbt5ACYms1o8Wa6VrSWoN2d9BFSd9aGd35+04NU9mT
	 5xH6cBPVJ6tLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8C2C47DB3;
	Tue, 30 Jan 2024 02:43:06 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Mon, 29 Jan 2024 18:43:07 -0800
Subject: [PATCH 2/2] ARM: dts: qcom: msm8960: expressatt: Add mXT224S
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
 <20240129-expressatt_mxt224s_touchscreen-v1-2-fb8552e1c32c@gmail.com>
References:
 <20240129-expressatt_mxt224s_touchscreen-v1-0-fb8552e1c32c@gmail.com>
In-Reply-To:
 <20240129-expressatt_mxt224s_touchscreen-v1-0-fb8552e1c32c@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rudraksha Gupta <guptarud@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706582586; l=1620;
 i=guptarud@gmail.com; s=20240120; h=from:subject:message-id;
 bh=4Gi3ILnitkF34hh7B1r4k2VP7IMCG7Hjj/6AwpaU750=;
 b=glGc0tlN1FYtvPmVUQWslsCsjE5EMGR/UNEHeqUB2jpo5OOSQO5qq9wIE5HbwMCkwH2BzXEJs
 H7KAFnIl4ahC7MfYyk65Voe0WfqTNP70P9KSDCsySRwDT6Coc1/JoRf
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



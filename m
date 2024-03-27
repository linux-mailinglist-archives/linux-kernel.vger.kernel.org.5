Return-Path: <linux-kernel+bounces-122134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD8288F24E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D6E29D804
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4D21552E8;
	Wed, 27 Mar 2024 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crrbfUFt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED15B04F;
	Wed, 27 Mar 2024 22:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580238; cv=none; b=lanwdxgms/r2m1O2Zh8KmFvq6XZ6JBi9M7Ca0D2Fpk0tK5gxeL8yYjFFD8ftsy0lsYLmNBDSY/cEI859cLKpCLCpGYoyto6pevdkB0hMUW6n9BsSO5u9vSMO1K9KPL7taulf08eJFQOxfa7+J3ba4ojKs7MPLYvYNB6Xijw4N3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580238; c=relaxed/simple;
	bh=npQsuKJCSjPU1CmK2mJzpdJDvL/vcRiQ7VqJraBwVjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TtbAsnuRl/BEWN2ig7h1lyjaqYX/mxHupA/sewnm6euowBugsNfr39zz8yjrMp359bITEZvc3/B3jewa6lf7PDH2JIwvFk76HKMZtmas8nvdQ/Sh7lFp2C50VHwn4fTCy9MXdLgc9/SBi0xVM5WpoV5Ajndg5pDSssX0t8J3sz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crrbfUFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56FC3C433B2;
	Wed, 27 Mar 2024 22:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711580238;
	bh=npQsuKJCSjPU1CmK2mJzpdJDvL/vcRiQ7VqJraBwVjk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=crrbfUFt4FnQpyZ4+QjsvTDSGKm8EyB46er3u95Nn6HudZB4npbee5M0eCrznZUXg
	 A+ViTPMzInZZqT/3ThzU52pulk/9nH7JflMaxOIm08nFQYW35bL5aVBaeJHEff4+d9
	 uLzVdQlsd8e4v/lDtDI6gZQRItXH5RIRq58oM/B3BpiKPLHPQHY+8ucAYDaB1ek1EN
	 3dh0xAtkmp5wnyovWi/fv44Wmgzo675wKp2RIRzgVf78mDbVtJRxOl6AebdRAYzQRL
	 3I/Vo9CN2dz6+LEgPYrKxBajo0+sr+OUFp8J6kTR3yySGf5hxZaPRhH1bEy9KCEq3T
	 fb3MGp8jJR8UA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496B7C47DD9;
	Wed, 27 Mar 2024 22:57:18 +0000 (UTC)
From: =?utf-8?q?Andr=C3=A9_Apitzsch_via_B4_Relay?= <devnull+git.apitzsch.eu@kernel.org>
Date: Wed, 27 Mar 2024 23:51:35 +0100
Subject: [PATCH 3/3] arm64: dts: qcom: msm8939-longcheer-l9100: Add rear
 flash
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240327-sy7802-v1-3-db74ab32faaf@apitzsch.eu>
References: <20240327-sy7802-v1-0-db74ab32faaf@apitzsch.eu>
In-Reply-To: <20240327-sy7802-v1-0-db74ab32faaf@apitzsch.eu>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711580236; l=1408;
 i=git@apitzsch.eu; s=20240325; h=from:subject:message-id;
 bh=nJ8Y+0v6j8LoIOHmDYBEGHd/SEM9XgaMCtxGw6/naMk=;
 b=7YhV4IWxeA0uTjafhzehr06WhwClOrLv0Z9w//XgT1anNQEKbXAToFkwKreQMKxwJmYDP48oP
 4E2F9vOI8xRAc/0N4ULPU7CxQP3nKCjp4dHJID8mzbmDZ+EOCvkaXce
X-Developer-Key: i=git@apitzsch.eu; a=ed25519;
 pk=wxovcZRfvNYBMcTw4QFFtNEP4qv39gnBfnfyImXZxiU=
X-Endpoint-Received: by B4 Relay for git@apitzsch.eu/20240325 with
 auth_id=142
X-Original-From: =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Reply-To: git@apitzsch.eu

From: André Apitzsch <git@apitzsch.eu>

The phone has a Silergy SY7802 flash LED controller.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 .../boot/dts/qcom/msm8939-longcheer-l9100.dts      | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts b/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts
index e3404c4455cf..528737929274 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts
@@ -159,6 +159,25 @@ led@2 {
 			};
 		};
 	};
+
+	flash-led-controller@53 {
+		compatible = "silergy,sy7802";
+		reg = <0x53>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		enable-gpios = <&tlmm 16 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&camera_rear_flash_default>;
+		pinctrl-names = "default";
+
+		led@0 {
+			reg = <0>;
+			function = LED_FUNCTION_FLASH;
+			color = <LED_COLOR_ID_WHITE>;
+			led-sources = <0>, <1>;
+		};
+	};
 };
 
 &blsp_i2c3 {
@@ -318,6 +337,13 @@ camera_front_flash_default: camera-front-flash-default-state {
 		bias-disable;
 	};
 
+	camera_rear_flash_default: camera-rear-flash-default-state {
+		pins = "gpio9", "gpio16", "gpio51";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	gpio_hall_sensor_default: gpio-hall-sensor-default-state {
 		pins = "gpio20";
 		function = "gpio";

-- 
2.44.0




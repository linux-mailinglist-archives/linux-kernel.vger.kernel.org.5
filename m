Return-Path: <linux-kernel+bounces-127087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C557A894693
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65CE6B23C85
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA3358100;
	Mon,  1 Apr 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdMA86/Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA6F54FAD;
	Mon,  1 Apr 2024 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006655; cv=none; b=GSSI8nQCnx4QlHrApN8vFSfPYByVDDxsbA3lOLIUPhoXwb/WBskgszNbxCXHlP6wps+3cF4dQb4RT2WolKzqAVy5lbrpEBEmwVj8VIhjcHccEIiV2RlhtH+eRVhZWJ9mtbke+YbHrzOLBvvr5NRmXFEevQmX2V20HGIi191DFHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006655; c=relaxed/simple;
	bh=npQsuKJCSjPU1CmK2mJzpdJDvL/vcRiQ7VqJraBwVjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHmU2lg3QZgkjYmETQCdgLM1/Xd1MLhqIl6+RTKg8L4mfU2VH3Ij9gkS6sUmopOV5VALhJsUSyiCCx7xqkMNJDYf3AU5IL5/0y4vHUXyzavU4n7CQcZu4u0Wl5n3iwERY5o2mAjjXkXvXwyaU5dJptqCpn/6nqF8Wovo9/sjwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdMA86/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D58A2C433A6;
	Mon,  1 Apr 2024 21:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712006654;
	bh=npQsuKJCSjPU1CmK2mJzpdJDvL/vcRiQ7VqJraBwVjk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SdMA86/YEPcmQGsy+iEO9KDVIHZrZ1MKkpZ0+DVJFcLp7IVVfJxoajkUA17yUxiTM
	 fC+MHpRwUxXhvmKENybn6YFALrfsnHPCg8wTTlinI6BVc6WuyfrmQ4RzQWQaFx5eqI
	 EUqgHnCIfgSSDVVcS5izJH00f09+SMgkf5dDV9zaJ6ty4VX/dvgTeY6gVzBQn8yfB0
	 5W8bUGRqOtU31vfuBqIYuuqa5N378JBX6b7rxFOt+AXB1oimAi9furnHa4wcdEQk4W
	 GM8wxhco7NvxPBVwemI5B2nFiuLN5MNZIHFgV708XYLAZwH0MZ6DpfnacRw0mAhUls
	 IPO2mgnTjSgSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8321CD1297;
	Mon,  1 Apr 2024 21:24:14 +0000 (UTC)
From: =?utf-8?q?Andr=C3=A9_Apitzsch_via_B4_Relay?= <devnull+git.apitzsch.eu@kernel.org>
Date: Mon, 01 Apr 2024 23:23:57 +0200
Subject: [PATCH v2 3/3] arm64: dts: qcom: msm8939-longcheer-l9100: Add rear
 flash
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240401-sy7802-v2-3-1138190a7448@apitzsch.eu>
References: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
In-Reply-To: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
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
 phone-devel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712006653; l=1408;
 i=git@apitzsch.eu; s=20240325; h=from:subject:message-id;
 bh=nJ8Y+0v6j8LoIOHmDYBEGHd/SEM9XgaMCtxGw6/naMk=;
 b=gqfbtPehMV8+wP3w7HI3sn6C+xAFx3683GBQL2w0H7Hf+9K/ARgklPCxZQJXzmeCi1/76iRa0
 McESBGTHjzqCsfs46R/pCp0ajvP5etuZo8YkNnmKLPYU3ITM/2bjw1Z
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




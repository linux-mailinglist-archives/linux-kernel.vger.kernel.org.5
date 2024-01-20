Return-Path: <linux-kernel+bounces-31745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FD0833348
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 09:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79DAAB231AE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 08:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5665346A8;
	Sat, 20 Jan 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwTJDo9U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7133D7F;
	Sat, 20 Jan 2024 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705740325; cv=none; b=nSmUePOuCXIzJyG8UXKmn3ROKuaJnPr+P5DmSz86M3n8FZxKsuWN+JPk2GIlt15KIrsmqR3eiHKwErH2KaHv3MzyNflzUnBtn22kzK6mccKCiXd5fHRa1xzKEsr8744YQ3Oud408euhdRIhLdvKO4vZqXGuSMwBFmiQJ5WqBNU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705740325; c=relaxed/simple;
	bh=a1DPUX1cmvhpZrjctxn5ECPNE3NiEQ76qsFCiU+2mGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z9aFn6zShcd4NfTcK+XtChSmxBa+Ojqfu7DYtWIMT9itj8qXa8qHj/mzKGsYXUz8IF+ouDyAIQZNdngLdvVY/2bbRRxP9HPwM02z3c9pK1pZT42s0a1PM+IG6DnBq/VacCANKyYrpZ5if+/IXLCRCK2y+7UW3yFnAW3E0+1P9P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwTJDo9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F051EC433C7;
	Sat, 20 Jan 2024 08:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705740325;
	bh=a1DPUX1cmvhpZrjctxn5ECPNE3NiEQ76qsFCiU+2mGg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=jwTJDo9UY2tJCPoVoo/tdIHgO65sMPVzuwMHYERjh575UroXUF7WUqOuueuQDGjsF
	 8ohGWzKRWej9TyQ8v0sR+O2JoYNMBs4D4L7KxCfdjdAEHYlgdy1pveZhf0vT49QK0V
	 JCstGOqY+VSKRSPTRv8kddGiMiNm8zNOs1B+lRWwMQxoWNDpNi1jI/3ckmRq6KTXWB
	 NzSJ8H+sJJ/qaGlyAnoeQRu4hHXxx2u4S8d1s3O5s0gvUConMKWMYbO2a506pyZTII
	 qAYoLQjddkfbT1nbueDp97lOPL2S3q20CFEhYckm0p6rylrbPd8yfo+EjoXfN6Zdf/
	 O96NLVdmLgkng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D419EC47258;
	Sat, 20 Jan 2024 08:45:24 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Sat, 20 Jan 2024 00:45:23 -0800
Subject: [PATCH] ARM: dts: qcom: msm8960: expressatt: Add gpio-keys
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240120-expressatt-gpio-keys-v1-1-4da7e37440b1@gmail.com>
X-B4-Tracking: v=1; b=H4sIACKIq2UC/x2MWwqAIBAAryL73YLak64SfYRttQQWrkQR3j3pc
 2BmXhAKTAK9eiHQxcKHz2AKBW6b/ErIc2aw2lbaWI10n4FEphhxPfnAnR5B17i608vcmpIgp1l
 Z+P63w5jSBwpOfn9mAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rudraksha Gupta <guptarud@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705740324; l=2136;
 i=guptarud@gmail.com; s=20240120; h=from:subject:message-id;
 bh=T+B5s38HvE5wvfTx+enY1qi1SBEpEVBTYASUCLQBqwU=;
 b=5UsFmbupML19LrX80fkEWOLZlRS9ScDP+D8wWQsRQdb5oi45aWI0aU0X8kJPWiAA2zsSUDwt8
 JJWsV1VM4FBCOU6k8dRT6Emu/ieTQkcfTXdNy7HOfdTvgUn6zzY5diW
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=RGmug3GRHS4XYTXDcT2VrlTGXlEF2gY4L9/swGIU1ko=
X-Endpoint-Received:
 by B4 Relay for guptarud@gmail.com/20240120 with auth_id=114
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: <guptarud@gmail.com>

From: Rudraksha Gupta <guptarud@gmail.com>

Adds volume up, volume down, and home keys to expressatt

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
Adds volume up, volume down, and home keys to expressatt.

Applies on top of 5c903b859aaced384c0cd01d515f3e43a115fd9e
---
 .../dts/qcom/qcom-msm8960-samsung-expressatt.dts   | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts b/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
index 1a5116336ff0..47e0e26ad9f0 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
@@ -4,6 +4,9 @@
 
 #include "qcom-msm8960.dtsi"
 #include "pm8921.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/input/gpio-keys.h>
 
 / {
 	model = "Samsung Galaxy Express SGH-I437";
@@ -19,6 +22,36 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_pin_a>;
+
+		key-home {
+			label = "Home";
+			gpios = <&msmgpio 40 GPIO_ACTIVE_LOW>;
+			debounce-interval = <5>;
+			linux,code = <KEY_HOMEPAGE>;
+			wakeup-event-action = <EV_ACT_ASSERTED>;
+			wakeup-source;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&msmgpio 50 GPIO_ACTIVE_LOW>;
+			debounce-interval = <5>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&msmgpio 81 GPIO_ACTIVE_LOW>;
+			debounce-interval = <5>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+	};
 };
 
 &gsbi5 {
@@ -83,6 +116,13 @@ clk-pins {
 			bias-disable;
 		};
 	};
+
+	gpio_keys_pin_a: gpio-keys-active-state {
+		pins = "gpio40", "gpio50", "gpio81";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
 };
 
 &pm8921 {

---
base-commit: 9d64bf433c53cab2f48a3fff7a1f2a696bc5229a
change-id: 20240120-expressatt-gpio-keys-c6c580fd713e

Best regards,
-- 
Rudraksha Gupta <guptarud@gmail.com>



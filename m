Return-Path: <linux-kernel+bounces-156725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C99FE8B075D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED77F1C20CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525521598F3;
	Wed, 24 Apr 2024 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT/JUf2z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BB315956F;
	Wed, 24 Apr 2024 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954525; cv=none; b=mfaVrBpxAMRu4ScDiwXS8yRrCayuLxCStvHByx5+WVrIeijk37sAy8BmyICWie0/Bom79tnkGtv+pvb0Xkv9d+AfiJnvE1j67MToMU6M4iUkQ9vIU3z+XK9YYV/OFj1ci4BNCoNsbwui9AnWG2uLlfrygwaeHWH7ruduK65GQmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954525; c=relaxed/simple;
	bh=gortqEOsO/yuPJEH7+s0bpeCQjgJMory7BCL8cwxXnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jE7nJLDQ1B/f2GT0d6+ySb8O8IZtU8b+IuJr8H1UM2cj2mopHfDyi5TDHcxRBprR9zsI7x4YTLMovWLRMlkiyZkb9O6/wF2ZYBzTsO+zO46EAGkYOgcMw2AC2DjIy7zHUpzhVlI9UBH1LQYxPlytS+KJ/CM3FiXcOL2RzlW3HQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT/JUf2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BEA8C2BD10;
	Wed, 24 Apr 2024 10:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713954525;
	bh=gortqEOsO/yuPJEH7+s0bpeCQjgJMory7BCL8cwxXnI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XT/JUf2zQC0rWC2UIw/MbPlaY/92sOTikY/TERJ5GJ6yHEjJmWolfrGTXq5fniK6g
	 uKnGL0Mvlkr00tHTGYyDQvandQwffSdrOOaE4hJgIZFs9gI+YWsGmk1aGXr1gAyu41
	 c973BIqft6cNf+aLBL08EZKPJudBVDpnobZp/7uRWiw75+OY259W0JF2SkCkzDeYC9
	 pxOBHccUcVllH8wADkM5asCLMV4LQy8+IuDlf0c9nJavnfQwriMlqVojk9ZdBlOWBM
	 hur0WBUhvHkblL5iv7WKxyIMgVOXSvEWuLDBZ8l6X2TGfuLFc5BoGdIfTOibGUufJ2
	 7ioG6/mMfcj9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0085EC10F16;
	Wed, 24 Apr 2024 10:28:45 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Wed, 24 Apr 2024 18:28:35 +0800
Subject: [PATCH v4 2/2] arm64: dts: amlogic: Add Amlogic S4 PWM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-s4-pwm-v4-2-ee22effd40d0@amlogic.com>
References: <20240424-s4-pwm-v4-0-ee22effd40d0@amlogic.com>
In-Reply-To: <20240424-s4-pwm-v4-0-ee22effd40d0@amlogic.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kelvin Zhang <kelvin.zhang@amlogic.com>, 
 Junyi Zhao <junyi.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713954523; l=5107;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=Wdbl9C4qxCA5ehEmpbCc7nMHnQDKo3VG8DPUHKZUfJI=;
 b=cU5Y3Hz/+DQ928ZpnIt+3BcjOuX0nYjgRDbCLkkZkeLAWxuSgXophbWkMj4vSDJtYBJn4rF3p
 nl06tnqdjDNC2WgqdZb9DD9UvyljBm7J+NpXbkEOqUySHJBAQsfQ51M
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

From: Junyi Zhao <junyi.zhao@amlogic.com>

Add device nodes for PWM_AB, PWM_CD, PWM_EF, PWM_GH and PWM_IJ
along with GPIO PIN configs of each channel.

Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 207 ++++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index 10896f9df682..8165b263ab92 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -292,6 +292,168 @@ mux {
 					};
 				};
 
+				pwm_a_pins1: pwm_a_pins1 {
+					mux {
+						groups = "pwm_a_d";
+						function = "pwm_a";
+					};
+				};
+
+				pwm_a_pins2: pwm_a_pins2 {
+					mux {
+						groups = "pwm_a_x";
+						function = "pwm_a";
+					};
+				};
+
+				pwm_a_pins: pwm_a_pins {
+					mux {
+						groups = "pwm_a_d";
+						function = "pwm_a";
+					};
+				};
+
+				pwm_b_pins1: pwm_b_pins1 {
+					mux {
+						groups = "pwm_b_d";
+						function = "pwm_b";
+					};
+				};
+
+				pwm_b_pins2: pwm_b_pins2 {
+					mux {
+						groups = "pwm_b_x";
+						function = "pwm_b";
+					};
+				};
+
+				pwm_c_pins1: pwm_c_pins1 {
+					mux {
+						groups = "pwm_c_d";
+						function = "pwm_c";
+					};
+				};
+
+				pwm_c_pins2: pwm_c_pins2 {
+					mux {
+						groups = "pwm_c_x";
+						function = "pwm_c";
+					};
+				};
+
+				pwm_d_pins1: pwm_d_pins1 {
+					mux {
+						groups = "pwm_d_d";
+						function = "pwm_d";
+					};
+				};
+
+				pwm_d_pins2: pwm_d_pins2 {
+					mux {
+						groups = "pwm_d_h";
+						function = "pwm_d";
+					};
+				};
+
+				pwm_e_pins1: pwm_e_pins1 {
+					mux {
+						groups = "pwm_e_x";
+						function = "pwm_e";
+						drive-strength-microamp = <500>;
+					};
+				};
+
+				pwm_e_pins2: pwm_e_pins2 {
+					mux {
+						groups = "pwm_e_z";
+						function = "pwm_e";
+					};
+				};
+
+				pwm_f_pins1: pwm_f_pins1 {
+					mux {
+						groups = "pwm_f_x";
+						function = "pwm_f";
+					};
+				};
+
+				pwm_f_pins2: pwm_f_pins2 {
+					mux {
+						groups = "pwm_f_z";
+						function = "pwm_f";
+					};
+				};
+
+				pwm_g_pins1: pwm_g_pins1 {
+					mux {
+						groups = "pwm_g_d";
+						function = "pwm_g";
+					};
+				};
+
+				pwm_g_pins2: pwm_g_pins2 {
+					mux {
+						groups = "pwm_g_z";
+						function = "pwm_g";
+					};
+				};
+
+				pwm_h_pins: pwm_h_pins {
+					mux {
+						groups = "pwm_h";
+						function = "pwm_h";
+					};
+				};
+
+				pwm_i_pins1: pwm_i_pins1 {
+					mux {
+						groups = "pwm_i_d";
+						function = "pwm_i";
+					};
+				};
+
+				pwm_i_pins2: pwm_i_pins2 {
+					mux {
+						groups = "pwm_i_h";
+						function = "pwm_i";
+					};
+				};
+
+				pwm_j_pins: pwm_j_pins {
+					mux {
+						groups = "pwm_j";
+						function = "pwm_j";
+					};
+				};
+
+				pwm_a_hiz_pins: pwm_a_hiz_pins {
+					mux {
+						groups = "pwm_a_hiz";
+						function = "pwm_a_hiz";
+					};
+				};
+
+				pwm_b_hiz_pins: pwm_b_hiz_pins {
+					mux {
+						groups = "pwm_b_hiz";
+						function = "pwm_b_hiz";
+					};
+				};
+
+				pwm_c_hiz_pins: pwm_c_hiz_pins {
+					mux {
+						groups = "pwm_c_hiz";
+						function = "pwm_b_hiz";
+					};
+				};
+
+				pwm_g_hiz_pins: pwm_g_hiz_pins {
+					mux {
+						groups = "pwm_g_hiz";
+						function = "pwm_g_hiz";
+					};
+				};
+
 				nand_pins: nand-pins {
 					mux {
 						groups = "emmc_nand_d0",
@@ -449,6 +611,51 @@ i2c4: i2c@6e000 {
 				status = "disabled";
 			};
 
+			pwm_ab: pwm@58000 {
+				compatible = "amlogic,meson-s4-pwm";
+				reg = <0x0 0x58000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_A>,
+						<&clkc_periphs CLKID_PWM_B>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_cd: pwm@5a000 {
+				compatible = "amlogic,meson-s4-pwm";
+				reg = <0x0 0x5a000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_C>,
+						<&clkc_periphs CLKID_PWM_D>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_ef: pwm@5c000 {
+				compatible = "amlogic,meson-s4-pwm";
+				reg = <0x0 0x5c000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_E>,
+						<&clkc_periphs CLKID_PWM_F>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_gh: pwm@5e000 {
+				compatible = "amlogic,meson-s4-pwm";
+				reg = <0x0 0x5e000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_G>,
+						<&clkc_periphs CLKID_PWM_H>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_ij: pwm@60000 {
+				compatible = "amlogic,meson-s4-pwm";
+				reg = <0x0 0x60000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_I>,
+						<&clkc_periphs CLKID_PWM_J>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			nand: nand-controller@8c800 {
 				compatible = "amlogic,meson-axg-nfc";
 				reg = <0x0 0x8c800 0x0 0x100>, <0x0 0x8c000 0x0 0x4>;

-- 
2.37.1




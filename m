Return-Path: <linux-kernel+bounces-103888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7190287C649
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF715B2305D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09D145BEF;
	Thu, 14 Mar 2024 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="M70ru5P3"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A212562F;
	Thu, 14 Mar 2024 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458597; cv=none; b=kJDgg9WeVy28Eoo2UqtuH9oZPcdpCrAZRdjRP4+Szo2o7DOwoYApOjwG/Fkz5zIHL96i8/p8sJuKUH3WCMa6yRTB2znOeCnGoPbBfqe97YIo8DbSw6ARDP1jeCKGIuTvAvTd3OSRqkxSX9jXH5eKFb92RsWtlip/MrxwBTytfm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458597; c=relaxed/simple;
	bh=66wp3jnAGp1xOU7TQZSRM0tSG896/Gz30D1sxNVaS6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlmMrYYtCTOUjh1pt4qRjt6PFJZs1RnThBdIeUDu5PomtQv4oXSUnW/uVLlKK69yq4IGPGLJKcn3qAnjkXkV2j7BZkuKrGwlvFPx4tmfS0XTZfXjaNBNvP2bN2IHnUAUhdgnlggnAqnfsmYOwCpu0kCiR+nDPHJsU8ddGjKzPmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=M70ru5P3; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id DD85710001D;
	Fri, 15 Mar 2024 02:23:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DD85710001D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710458589;
	bh=oqZUNzb9EejInf+1S98aJFvRrIcXoZ0lddVRALyKqEQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=M70ru5P3wE2cJ4xyX4rcsVFpNGNl9xjoAOfDdS85VUZ3gUrU0Wh3mwd0AbVxFQcrI
	 FnBEmPgnIKlW1ioyCNRFNQY0cXzwV3aPfZWPwHvGZnMUP48fnVlRW0Fcy6JjmzHvpF
	 rYBZAKcQbrqjWyiPidBV9sNRBYaB0RilEvbrRpzeVXDoTe1ub/A2Ve5P13KSShupiJ
	 KcKaVINNQJfibv2cjakdyniyOI7SH07amius0rzDOPNmBxjxKqnLXM6zRw0ndBXDGP
	 hD6we2O5dWnNl4qV6cPJfOP6QhoiPjOktm2x9QSoElIPv46tSKzpAubqGq7bPKQZ7W
	 fYbVbkXB+iLZw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 15 Mar 2024 02:23:09 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Mar 2024 02:23:09 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>
CC: <kernel@salutedevices.com>
Subject: [PATCH 24/25] arm64: dts: meson: a1: add audio devices
Date: Fri, 15 Mar 2024 02:22:00 +0300
Message-ID: <20240314232201.2102178-25-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_smtp_not_equal_from}, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped

This commit adds the declarartion of currently supported audio devices
and their pins found Amlog A1 SoC family. SPDIF declaration is missing
here becase there are no publicly available boards with it.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 471 ++++++++++++++++++++++
 1 file changed, 471 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index c03e207ea6c5..eaedc2d849db 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -5,11 +5,15 @@
 
 #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
 #include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
+#include <dt-bindings/clock/amlogic,a1-audio-clkc.h>
 #include <dt-bindings/gpio/meson-a1-gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/power/meson-a1-power.h>
 #include <dt-bindings/reset/amlogic,meson-a1-reset.h>
+#include <dt-bindings/reset/amlogic,meson-a1-audio-reset.h>
+#include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
+#include <dt-bindings/sound/meson-g12a-toacodec.h>
 
 / {
 	compatible = "amlogic,a1";
@@ -280,6 +284,250 @@ mux {
 						function = "spif";
 					};
 				};
+
+				tdm_a_din0_pins: tdm-a-din0 {
+					mux {
+						groups = "tdm_a_din0";
+						function = "tdm_a";
+						bias-disable;
+					};
+				};
+
+				tdm_a_din1_pins: tdm-a-din1 {
+					mux {
+						groups = "tdm_a_din1";
+						function = "tdm_a";
+						bias-disable;
+					};
+				};
+
+				tdm_a_dout0_pins: tdm-a-dout0 {
+					mux {
+						groups = "tdm_a_dout0";
+						function = "tdm_a";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_a_dout1_pins: tdm-a-dout1 {
+					mux {
+						groups = "tdm_a_dout1";
+						function = "tdm_a";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_a_fs_pins: tdm-a-fs {
+					mux {
+						groups = "tdm_a_fs";
+						function = "tdm_a";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_a_sclk_pins: tdm-a-sclk {
+					mux {
+						groups = "tdm_a_sclk";
+						function = "tdm_a";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_a_slv_fs_pins: tdm-a-slv-fs {
+					mux {
+						groups = "tdm_a_slv_fs";
+						function = "tdm_a";
+						bias-disable;
+					};
+				};
+
+				tdm_a_slv_sclk_pins: tdm-a-slv-sclk {
+					mux {
+						groups = "tdm_a_slv_sclk";
+						function = "tdm_a";
+						bias-disable;
+					};
+				};
+
+				tdm_b_din0_pins: tdm-b-din0 {
+					mux {
+						groups = "tdm_b_din0";
+						function = "tdm_b";
+						bias-disable;
+					};
+				};
+
+				tdm_b_din1_pins: tdm-b-din1 {
+					mux {
+						groups = "tdm_b_din1";
+						function = "tdm_b";
+						bias-disable;
+					};
+				};
+
+				tdm_b_din2_pins: tdm-b-din2 {
+					mux {
+						groups = "tdm_b_din2";
+						function = "tdm_b";
+						bias-disable;
+					};
+				};
+
+				tdm_b_dout0_pins: tdm-b-dout0 {
+					mux {
+						groups = "tdm_b_dout0";
+						function = "tdm_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_b_dout1_pins: tdm-b-dout1 {
+					mux {
+						groups = "tdm_b_dout1";
+						function = "tdm_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_b_dout2_pins: tdm-b-dout2 {
+					mux {
+						groups = "tdm_b_dout2";
+						function = "tdm_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_b_dout3_pins: tdm-b-dout3 {
+					mux {
+						groups = "tdm_b_dout3";
+						function = "tdm_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_b_dout4_pins: tdm-b-dout4 {
+					mux {
+						groups = "tdm_b_dout4";
+						function = "tdm_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_b_dout5_pins: tdm-b-dout5 {
+					mux {
+						groups = "tdm_b_dout5";
+						function = "tdm_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_b_fs_pins: tdm-b-fs {
+					mux {
+						groups = "tdm_b_fs";
+						function = "tdm_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_b_sclk_pins: tdm-b-sclk {
+					mux {
+						groups = "tdm_b_sclk";
+						function = "tdm_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				tdm_b_slv_fs_pins: tdm-b-slv-fs {
+					mux {
+						groups = "tdm_b_slv_fs";
+						function = "tdm_b";
+						bias-disable;
+					};
+				};
+
+				tdm_b_slv_sclk_pins: tdm-b-slv-sclk {
+					mux {
+						groups = "tdm_b_slv_sclk";
+						function = "tdm_b";
+						bias-disable;
+					};
+				};
+
+				pdm_din0_a_pins: pdm-din0-a {
+					mux {
+						groups = "pdm_din0_a";
+						function = "pdm";
+						bias-disable;
+					};
+				};
+
+				pdm_din0_x_pins: pdm-din0-x {
+					mux {
+						groups = "pdm_din0_x";
+						function = "pdm";
+						bias-disable;
+					};
+				};
+
+				pdm_din1_a_pins: pdm-din1-a {
+					mux {
+						groups = "pdm_din1_a";
+						function = "pdm";
+						bias-disable;
+					};
+				};
+
+				pdm_din1_x_pins: pdm-din1-x {
+					mux {
+						groups = "pdm_din1_x";
+						function = "pdm";
+						bias-disable;
+					};
+				};
+
+				pdm_din2_a_pins: pdm-din2-a {
+					mux {
+						groups = "pdm_din2_a";
+						function = "pdm";
+						bias-disable;
+					};
+				};
+
+				pdm_din2_x_pins: pdm-din2-x {
+					mux {
+						groups = "pdm_din2_x";
+						function = "pdm";
+						bias-disable;
+					};
+				};
+
+				pdm_dclk_a_pins: pdm-dclk-a {
+					mux {
+						groups = "pdm_dclk_a";
+						function = "pdm";
+						bias-disable;
+					};
+				};
+
+				pdm_dclk_x_pins: pdm-dclk-x {
+					mux {
+						groups = "pdm_dclk_x";
+						function = "pdm";
+						bias-disable;
+					};
+				};
 			};
 
 			gpio_intc: interrupt-controller@440 {
@@ -435,6 +683,207 @@ sd_emmc: sd@10000 {
 				power-domains = <&pwrc PWRC_SD_EMMC_ID>;
 				status = "disabled";
 			};
+
+			acodec: audio-controller@4800 {
+				compatible = "amlogic,t9015-a1";
+				reg = <0x0 0x4800 0x0 0x14>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "ACODEC";
+				clocks = <&clkc_periphs CLKID_AUDIO>;
+				clock-names = "pclk";
+				resets = <&reset RESET_ACODEC>;
+				power-domains = <&pwrc PWRC_ACODEC_ID>;
+			};
+
+			audio: bus@50000 {
+				compatible = "simple-bus";
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges = <0x0 0x0 0x0 0x50000 0 0x4980>;
+				power-domains = <&pwrc PWRC_AUDIO_ID>;
+
+				clkc_audio: audio-clock-controller@0 {
+					compatible = "amlogic,a1-audio-clkc";
+					reg = <0x0 0x0 0x0 0xb0>,
+					      <0x0 0x4800 0x0 0x20>;
+					#clock-cells = <1>;
+					#reset-cells = <1>;
+					clocks = <&clkc_periphs CLKID_AUDIO>,
+						 <&clkc_periphs CLKID_DDS_IN>,
+						 <&clkc_pll CLKID_FCLK_DIV2>,
+						 <&clkc_pll CLKID_FCLK_DIV3>,
+						 <&clkc_pll CLKID_HIFI_PLL>,
+						 <&xtal>;
+					clock-names = "pclk", "dds_in",
+						      "fclk_div2", "fclk_div3",
+						      "hifi_pll", "xtal";
+				};
+
+				toddr_a: audio-controller@100 {
+					compatible = "amlogic,a1-toddr",
+						     "amlogic,sm1-toddr",
+						     "amlogic,axg-toddr";
+					reg = <0x0 0x100 0x0 0x2c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "TODDR_A";
+					interrupts = <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_TODDR_A>;
+					resets = <&arb AXG_ARB_TODDR_A>,
+						 <&clkc_audio AUD_RESET_TODDR_A>;
+					reset-names = "arb", "rst";
+					amlogic,fifo-depth = <128>;
+				};
+
+				toddr_b: audio-controller@140 {
+					compatible = "amlogic,a1-toddr",
+						     "amlogic,sm1-toddr",
+						     "amlogic,axg-toddr";
+					reg = <0x0 0x140 0x0 0x2c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "TODDR_B";
+					interrupts = <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_TODDR_B>;
+					resets = <&arb AXG_ARB_TODDR_B>,
+						 <&clkc_audio AUD_RESET_TODDR_B>;
+					reset-names = "arb", "rst";
+					amlogic,fifo-depth = <128>;
+				};
+
+				frddr_a: audio-controller@1c0 {
+					compatible = "amlogic,a1-frddr",
+						     "amlogic,sm1-frddr",
+						     "amlogic,axg-frddr";
+					reg = <0x0 0x1c0 0x0 0x2c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "FRDDR_A";
+					interrupts = <GIC_SPI 40 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
+					resets = <&arb AXG_ARB_FRDDR_A>,
+						 <&clkc_audio AUD_RESET_FRDDR_A>;
+					reset-names = "arb", "rst";
+					amlogic,fifo-depth = <128>;
+				};
+
+				frddr_b: audio-controller@200 {
+					compatible = "amlogic,a1-frddr",
+						     "amlogic,sm1-frddr",
+						     "amlogic,axg-frddr";
+					reg = <0x0 0x200 0x0 0x2c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "FRDDR_B";
+					interrupts = <GIC_SPI 41 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_FRDDR_B>;
+					resets = <&arb AXG_ARB_FRDDR_B>,
+						 <&clkc_audio AUD_RESET_FRDDR_B>;
+					reset-names = "arb", "rst";
+					amlogic,fifo-depth = <128>;
+				};
+
+				arb: reset-controller@280 {
+					compatible = "amlogic,meson-a1-audio-arb",
+						     "amlogic,meson-sm1-audio-arb";
+					reg = <0x0 0x280 0x0 0x4>;
+					#reset-cells = <1>;
+					clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
+				};
+
+				tdmin_a: audio-controller@300 {
+					compatible = "amlogic,a1-tdmin",
+						     "amlogic,sm1-tdmin";
+					reg = <0x0 0x300 0x0 0x40>;
+					sound-name-prefix = "TDMIN_A";
+					clocks = <&clkc_audio AUD_CLKID_TDMIN_A>,
+						 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					resets = <&clkc_audio AUD_RESET_TDMIN_A>;
+				};
+
+				tdmin_b: audio-controller@340 {
+					compatible = "amlogic,a1-tdmin",
+						     "amlogic,sm1-tdmin";
+					reg = <0x0 0x340 0x0 0x40>;
+					sound-name-prefix = "TDMIN_B";
+					clocks = <&clkc_audio AUD_CLKID_TDMIN_B>,
+						 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					resets = <&clkc_audio AUD_RESET_TDMIN_B>;
+				};
+
+				tdmin_lb: audio-controller@3c0 {
+					compatible = "amlogic,a1-tdmin",
+						     "amlogic,sm1-tdmin";
+					reg = <0x0 0x3c0 0x0 0x40>;
+					sound-name-prefix = "TDMIN_LB";
+					clocks = <&clkc_audio AUD_CLKID_TDMIN_LB>,
+						 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					resets = <&clkc_audio AUD_RESET_TDMIN_LB>;
+				};
+
+				tdmout_a: audio-controller@500 {
+					compatible = "amlogic,a1-tdmout",
+						     "amlogic,sm1-tdmout";
+					reg = <0x0 0x500 0x0 0x40>;
+					sound-name-prefix = "TDMOUT_A";
+					clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					resets = <&clkc_audio AUD_RESET_TDMOUT_A>;
+				};
+
+				tdmout_b: audio-controller@540 {
+					compatible = "amlogic,a1-tdmout",
+						     "amlogic,sm1-tdmout";
+					reg = <0x0 0x540 0x0 0x40>;
+					sound-name-prefix = "TDMOUT_B";
+					clocks = <&clkc_audio AUD_CLKID_TDMOUT_B>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					resets = <&clkc_audio AUD_RESET_TDMOUT_B>;
+				};
+
+				toacodec: audio-controller@740 {
+					compatible = "amlogic,a1-toacodec",
+						     "amlogic,g12a-toacodec";
+					reg = <0x0 0x740 0x0 0x4>;
+					#sound-dai-cells = <1>;
+					sound-name-prefix = "TOACODEC";
+					resets = <&clkc_audio AUD_RESET_TOACODEC>;
+				};
+
+				pdm: audio-controller@1000 {
+					compatible = "amlogic,a1-pdm",
+						     "amlogic,axg-pdm";
+					reg = <0x0 0x1000 0x0 0x34>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "PDM";
+					clocks = <&clkc_audio AUD2_CLKID_PDM>,
+						 <&clkc_audio AUD2_CLKID_PDM_DCLK>,
+						 <&clkc_audio AUD2_CLKID_PDM_SYSCLK>;
+					clock-names = "pclk", "dclk", "sysclk";
+					power-domains = <&pwrc PWRC_PDMIN_ID>;
+				};
+			};
 		};
 
 		usb: usb@fe004400 {
@@ -517,4 +966,26 @@ xtal: xtal-clk {
 		clock-output-names = "xtal";
 		#clock-cells = <0>;
 	};
+
+	tdmif_a: audio-controller-0 {
+		compatible = "amlogic,a1-tdm-iface",
+			     "amlogic,axg-tdm-iface";
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TDM_A";
+		clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_A_LRCLK>,
+			 <&clkc_audio AUD_CLKID_MST_A_MCLK>;
+		clock-names = "sclk", "lrclk", "mclk";
+	};
+
+	tdmif_b: audio-controller-1 {
+		compatible = "amlogic,a1-tdm-iface",
+			     "amlogic,axg-tdm-iface";
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TDM_B";
+		clocks = <&clkc_audio AUD_CLKID_MST_B_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_B_LRCLK>,
+			 <&clkc_audio AUD_CLKID_MST_B_MCLK>;
+		clock-names = "sclk", "lrclk", "mclk";
+	};
 };
-- 
2.34.1



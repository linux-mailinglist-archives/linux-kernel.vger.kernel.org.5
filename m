Return-Path: <linux-kernel+bounces-103889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC03687C648
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FD52B22CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FBB4594A;
	Thu, 14 Mar 2024 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="G26JHzXC"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A336AFF;
	Thu, 14 Mar 2024 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458598; cv=none; b=SZKPUWNoaNeAwPHkIJITFrH3RLyE04xx2EFpWkWIe073hoXe8TZ24JmqQKm0J9odFM0QdMxgMRffYuJTuudxYUXo895hZ9chFLUjTriE4XXUbL1qrdTD/nSi1jlvQ1EumkKggLHc9e+i3ejD+O2OChDBtlHxxhofT0EHTPa251M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458598; c=relaxed/simple;
	bh=hOSFz8IqviIayTF9NX2uZ9af/0U6rooCXBTE0GSBCko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fN+IDcklkaIDBjo/8dDKaILIRxj2SfJA9nhdjk9P7BWb/Kfu0KCQMrLeSt/KSnR4rLXsd2pyakhXMN6oOVdChH6qqAesXskt4X/rtE7xm2bNy1G70/AzOgTW4uiNkEuvm2fdg49yum7rNwd1vKpnE5OO35dATQZWOjcwgElru/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=G26JHzXC; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4AA63120018;
	Fri, 15 Mar 2024 02:23:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4AA63120018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710458590;
	bh=EsZkg7PsNgeBq/F6pkLPHW4XZGjF5/748MlZOP2PBl4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=G26JHzXCwUXkf5+fNL9hrJJaEQdjxSF00tPbOiMwxhkEobOtNk9MZUPOD+IoWeBzE
	 n+3h7+SpGvrawGKENtFgplBVU8Gwmc33+ZoA3n+uCbAsKCmH0Ge4fewlzWCaGpAwgY
	 T6D2P1vcTjRM4sOeobxCNMrX8IkX63wPXu3ZzV5vzZ3DEmX2RNUuJYEZyabyaR56rs
	 X3Ft1UZjeVaxnu03F3HH9kEb2a21OrJ1+pzGpRTxkiTJDJKnhVIxuupmqMhbi8FhMH
	 x/0enhqmF/rkEsHjvDcuYjp5IMpZ+fLlS2JrLEd3xGfA+qreSVH8k+yziStOokW0q+
	 e/aWVeXJ685Jw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 15 Mar 2024 02:23:10 +0300 (MSK)
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
CC: <kernel@salutedevices.com>, Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH 25/25] arm64: dts: ad402: enable audio
Date: Fri, 15 Mar 2024 02:22:01 +0300
Message-ID: <20240314232201.2102178-26-jan.dakinevich@salutedevices.com>
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

 * playback to speaker

   - setup:
     $ amixer set "FRDDR_A SINK 1 SEL" "OUT 0"
     $ amixer set "FRDDR_A SRC 1 EN" "on"
     $ amixer set "TDMOUT_A SRC SEL" "IN 0"
     $ amixer set "TOACODEC Source" "I2S A"
     $ amixer set "TOACODEC Lane Select" "0"
     $ amixer set "TOACODEC EN" "on"
     $ amixer set "ACODEC" "70%"
     $ amixer set "ACODEC Playback Channel Mode" "Mono"
     $ amixer set "ACODEC Right+ Driver Sel" "Right DAC"
     $ amixer set "ACODEC Left+ Driver Sel" "Right DAC Inverted"

   - usage:
     $ aplay -D hw:0,0 -f S16_LE -r 48000 /path/to/sample.wav

 * capture from digital mics

   - setup:
     $ amixer set "TODDR_A SRC SEL" "IN 4"

   - usage:
     $ arecord -D hw:0,1 -f S32_LE -r 48000 -c 2 -t wav /path/to/sample.wav

 * capture from analog mics

   - setup:
     $ amixer set "TDMIN_A SRC SEL" "IN 3"
     $ amixer set "TODDR_B SRC SEL" "IN 0"
     $ amixer set "TOACODEC Source" "I2S A"
     $ amixer set "TOACODEC Lane Select" "0"
     $ amixer set "TOACODEC EN" "on"
     $ amixer set "ACODEC ADC" "70%"
     $ amixer set "ACODEC ADC Filter" "on"
     $ amixer set "ACODEC ADC Filter Mode" "HiFi"
     $ amixer set "ACODEC ADC Mic Bias" "on"
     $ amixer set "ACODEC ADC Mic Bias Level" "2.5V"
     $ amixer set "ACODEC ADC PGA" "50%"
     $ amixer set "ACODEC ADC PGA Right Sel" "Differential"
     $ amixer set "ACODEC ADC PGA Left Sel" "Differential"

   - usage:
     $ arecord -D hw:0,2 -f S16_LE -r 48000 -c 2 -t wav /path/to/sample.wav

 * capture from TDM loopback

   - setup:
     $ amixer set "TDMIN_LB SRC SEL" "IN 0"
     $ amixer set "TODDR_A SRC SEL" "IN 6"

   - usage:
     $ arecord -D hw:0,1 -f S16_LE -r 48000 -c 2 -t wav /path/to/sample.wav

   or

   - setup:
     $ amixer set "TDMIN_LB SRC SEL" "IN 0"
     $ amixer set "TODDR_B SRC SEL" "IN 6"

   - usage:
     $ arecord -D hw:0,2 -f S16_LE -r 48000 -c 2 -t wav /path/to/sample.wav

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 .../arm64/boot/dts/amlogic/meson-a1-ad402.dts | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts b/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
index 4bc30af05848..4e0865a4b44e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
@@ -8,6 +8,8 @@
 
 #include "meson-a1.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	compatible = "amlogic,ad402", "amlogic,a1";
 	model = "Amlogic Meson A1 AD402 Development Board";
@@ -83,6 +85,100 @@ vddio_1v8: regulator-vddio-1v8 {
 		vin-supply = <&vddao_3v3>;
 		regulator-always-on;
 	};
+
+	amplifier: amplifier {
+		compatible = "simple-audio-amplifier";
+		sound-name-prefix = "AMPLIFIER";
+		enable-gpios = <&gpio GPIOF_4 GPIO_ACTIVE_HIGH>;
+		VCC-supply = <&battery_4v2>;
+	};
+
+	dmics: dmics {
+		compatible = "dmic-codec";
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "MIC";
+		num-channels = <4>;
+		wakeup-delay-ms = <50>;
+	};
+
+	sound {
+		compatible = "amlogic,a1-sound-card",
+			     "amlogic,axg-sound-card";
+		model = "AD402";
+		audio-aux-devs = <&tdmout_a>,
+				 <&amplifier>,
+				 <&tdmin_lb>,
+				 <&tdmin_a>;
+		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
+				"TDM_A Playback", "TDMOUT_A OUT",
+				"AMPLIFIER INL", "ACODEC LOLP",
+				"AMPLIFIER INR", "ACODEC LORP",
+
+				"TODDR_A IN 4", "PDM Capture",
+
+				"TDMIN_A IN 3", "TDM_A Capture",
+				"TODDR_B IN 0", "TDMIN_A OUT",
+
+				"TDMIN_LB IN 0", "TDM_A Loopback",
+				"TODDR_A IN 6", "TDMIN_LB OUT",
+				"TDMIN_LB IN 0", "TDM_A Loopback",
+				"TODDR_B IN 6", "TDMIN_LB OUT";
+
+		dai-link-0 {
+			link-name = "speaker";
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			link-name = "dmics";
+			sound-dai = <&toddr_a>;
+		};
+
+		dai-link-2 {
+			link-name = "amics";
+			sound-dai = <&toddr_b>;
+		};
+
+		dai-link-3 {
+			sound-dai = <&tdmif_a>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-rx-mask-0 = <1 1>;
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&toacodec TOACODEC_IN_A>;
+			};
+
+			codec-1 {
+				sound-dai = <&toacodec TOACODEC_CAPTURE_OUT_A>;
+			};
+		};
+
+		dai-link-4 {
+			sound-dai = <&toacodec TOACODEC_OUT>;
+
+			codec {
+				sound-dai = <&acodec>;
+			};
+		};
+
+		dai-link-5 {
+			sound-dai = <&toacodec TOACODEC_CAPTURE_IN>;
+
+			codec {
+				sound-dai = <&acodec>;
+			};
+		};
+
+		dai-link-6 {
+			sound-dai = <&pdm>;
+
+			codec {
+				sound-dai = <&dmics>;
+			};
+		};
+	};
 };
 
 /* Bluetooth HCI H4 */
@@ -145,3 +241,33 @@ &sd_emmc {
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_1v8>;
 };
+
+&clkc_audio {
+	assigned-clocks = <&clkc_pll CLKID_HIFI_PLL>,
+			  <&clkc_audio AUD_CLKID_MST_A_MCLK_SEL>,
+			  <&clkc_audio AUD_CLKID_MST_A_MCLK>,
+			  <&clkc_audio AUD2_CLKID_PDM_SYSCLK_SEL>,
+			  <&clkc_audio AUD2_CLKID_PDM_DCLK_SEL>;
+	assigned-clock-parents = <0>,
+				 <&clkc_pll CLKID_HIFI_PLL>,
+				 <0>,
+				 <&clkc_pll CLKID_FCLK_DIV3>,
+				 <&clkc_pll CLKID_FCLK_DIV2>;
+	assigned-clock-rates = <614400000>,
+			       <0>,
+			       <12288000>,
+			       <512000000>,
+			       <768000000>;
+};
+
+&acodec {
+	AVDD-supply = <&vddio_1v8>;
+};
+
+&pdm {
+	sysrate = <256000000>;
+	pinctrl-0 = <&pdm_din0_a_pins>,
+		    <&pdm_din1_a_pins>,
+		    <&pdm_dclk_a_pins>;
+	pinctrl-names = "default";
+};
-- 
2.34.1



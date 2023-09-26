Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CFB7AF150
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjIZQwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbjIZQwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:52:05 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FE3139;
        Tue, 26 Sep 2023 09:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695747101; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=I087cDp+xqCYUjw6/43+b5IuBfqjjY6U6CmaqPglsDk5tyvQlmQJ5j7tlS+rtHq0+K
    jkQ23XY/qOr45HELq4UqyS/RyGIo3fWEg9QHXoJ2S4PkvY8u1WuqsEu946cWJ6+xa0bQ
    0qUXwFMSRgs4FMr37+9Lb4SLosg0GwD0pxSRh50yTYicQfsr4PaheQJ2mQc9+dPaRLrf
    6Ngq6N6C2ppyBhlTFmEeZ4xV7zq351pR7H2fBaamUnyPYESI/D5F+j/5oPh5LaHyiwLw
    tHMJ6K+XI9oT7s1WjZtXbjJkj/2I4QGzkMFv7IBZ2WkU8oyOxzRB+8fHr3NXQse0GLD0
    xzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695747101;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=JwD/YT0S8yNhTCX5nf+jLPmde3EQ0AXW+GeRKTVLvbw=;
    b=dnGJmcpVZ1d5GakmBFVsDSSM7em1lRvSdWRW4i3ElRdIN7OQZ4HluWmsYPX/ONWaJK
    h07mj3xnhwz7z5VV/LHnkXHp5akXjsxaIr/Qk/VRle8AWlTfnfISuT7iP6uTdxABY/Kk
    8Gb6DsxJTfGmS4MTQJ/wUGHFI543EopsqM/EXcyN/q+UQY8hPIPkbRa0M1MPKF0Ys9GB
    nytBggnN5RrvuQwGP1LdfBBno88ab+U8NKPDEvTYSK3QuT8pafS0zWvqvHKmCbRsReS0
    FSDQW8RuZVxWZSt7v1SgQI00F7AiVFd7CrTkdB2/D2aJ0LjhlmqSH7D2nMH4CSShdVBF
    t10A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695747101;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=JwD/YT0S8yNhTCX5nf+jLPmde3EQ0AXW+GeRKTVLvbw=;
    b=Yq8hJp6irxQ1QoPlCzPl76eK/okNwWk37pTerBop+4dO0vZCjdYp6LTQD0j0c84Xqe
    twZLJKBBwjhhgwRN3x9lCRWUSfFgVmjrJFKL5nnqMZ3Ngmg/pAHWIsmPQ7QmYDnbRjkU
    byXkOiGNvxl6fg+S/kXLSIW7umIwLgiA4h4YbqSuYcCJ/Llf4PcMvAsB4Ny3XJGjlM5V
    dlp2r9Svyi1G6u1Qee/S/iMconY4FCZAaNn1arQijow5w8iJj8TaqViJZSGhKqZ8N6sN
    Xtn/0kzJfxYYCA+6NDqdxXeOUz9r8djnRUZR8Dh++3EVZiNPMiovNlHFdv9vaIHbL0IX
    MKNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695747101;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=JwD/YT0S8yNhTCX5nf+jLPmde3EQ0AXW+GeRKTVLvbw=;
    b=KZXwupghlVW6i2gIsokdIWWYxx7hweWEv8zBCynMkjuLNPfkql0GFIl89LOdTikzZX
    M0cpBLyaKNeOhPNiEDBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOH+nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QGpeg5i
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 18:51:40 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 26 Sep 2023 18:51:25 +0200
Subject: [PATCH 11/13] arm64: dts: qcom: msm8916-samsung-gt5: Add sound and
 modem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-msm8916-modem-v1-11-398eec74bac9@gerhold.net>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
In-Reply-To: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Jasper Korten <jja2000@gmail.com>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Nikita Travkin <nikita@trvn.ru>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jasper Korten <jja2000@gmail.com>

Enable sound and modem for the Samsung Galaxy Tab A 2015 tablets.
The setup is similar to most MSM8916 devices, i.e.:

 - QDSP6 audio
 - Headphones/microphones via digital/analog codec in
   MSM8916/PM8916. Earpiece exists on samsung-gt58 only.
 - WWAN Internet via BAM-DMUX

except:

 - gt510: Stereo Maxim MAX98357A codecs for speaker on Quaternary MI2S
 - gt58: Mono NXP TFA9895 codec for speaker on Quaternary MI2S
   - For some reason connected to GPIOs where no hardware I2C
     controller is available -> need to use i2c-gpio
- Samsung-specific audio jack detection (not supported yet)

Signed-off-by: Jasper Korten <jja2000@gmail.com>
Co-developed-by: Siddharth Manthan <siddharth.manthan@gmail.com>
Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
Co-developed-by: Nikita Travkin <nikita@trvn.ru>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
[Stephan: Add consistent commit message]
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  | 36 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts | 23 ++++++++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts  | 43 ++++++++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index 6a16eb5ce07b..396853fcece5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -3,9 +3,12 @@
 /dts-v1/;
 
 #include "msm8916-pm8916.dtsi"
+#include "msm8916-modem-qdsp6.dtsi"
+
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/sound/apq8016-lpass.h>
 
 / {
 	aliases {
@@ -116,6 +119,17 @@ &blsp_uart2 {
 	status = "okay";
 };
 
+&lpass {
+	dai-link@3 {
+		reg = <MI2S_QUATERNARY>;
+		qcom,playback-sd-lines = <1>;
+	};
+};
+
+&mpss_mem {
+	reg = <0x0 0x86800000 0x0 0x5400000>;
+};
+
 &pm8916_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 	status = "okay";
@@ -133,6 +147,13 @@ &pm8916_usbin {
 	status = "okay";
 };
 
+&q6afedai {
+	dai@22 {
+		reg = <QUATERNARY_MI2S_RX>;
+		qcom,sd-lines = <1>;
+	};
+};
+
 &sdhc_1 {
 	status = "okay";
 };
@@ -147,6 +168,21 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&sound {
+	audio-routing =
+		"AMIC1", "MIC BIAS External1",
+		"AMIC2", "MIC BIAS Internal2",
+		"AMIC3", "MIC BIAS External1";
+};
+
+&sound_dai_quaternary {
+	status = "okay";
+
+	codec {
+		sound-dai = <&speaker_codec>;
+	};
+};
+
 &usb {
 	dr_mode = "peripheral";
 	extcon = <&pm8916_usbin>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
index c3f1acc55078..f393e9efa72c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
@@ -9,6 +9,14 @@ / {
 	compatible = "samsung,gt510", "qcom,msm8916";
 	chassis-type = "tablet";
 
+	speaker_codec: audio-codec {
+		compatible = "maxim,max98357a";
+		sdmode-gpios = <&tlmm 55 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <0>;
+		pinctrl-0 = <&audio_sdmode_default>;
+		pinctrl-names = "default";
+	};
+
 	clk_pwm: pwm {
 		compatible = "clk-pwm";
 		#pwm-cells = <2>;
@@ -146,7 +154,22 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&sound {
+	model = "samsung-gt510";
+	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default>;
+	pinctrl-1 = <&cdc_pdm_sleep &sec_mi2s_sleep>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+};
+
 &tlmm {
+	audio_sdmode_default: audio-sdmode-default-state {
+		pins = "gpio55";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	buckbooster_en_default: buckbooster-en-default-state {
 		pins = "gpio51";
 		function = "gpio";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
index 998625abd409..3f2165556986 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
@@ -35,6 +35,26 @@ reg_vdd_tsp: regulator-vdd-tsp {
 		pinctrl-names = "default";
 	};
 
+	i2c-amplifier {
+		compatible = "i2c-gpio";
+		sda-gpios = <&tlmm 55 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&tlmm 56 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+		pinctrl-0 = <&amp_i2c_default>;
+		pinctrl-names = "default";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		speaker_codec: audio-codec@34 {
+			compatible = "nxp,tfa9895";
+			reg = <0x34>;
+			vddd-supply = <&pm8916_l5>;
+			sound-name-prefix = "Speaker";
+			#sound-dai-cells = <0>;
+		};
+	};
+
 	vibrator {
 		compatible = "gpio-vibrator";
 		enable-gpios = <&tlmm 76 GPIO_ACTIVE_HIGH>;
@@ -98,7 +118,22 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&sound {
+	model = "samsung-a2015";
+	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default &secondary_mic_default>;
+	pinctrl-1 = <&cdc_pdm_sleep &sec_mi2s_sleep &secondary_mic_default>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+};
+
 &tlmm {
+	amp_i2c_default: amp-i2c-default-state {
+		pins = "gpio55", "gpio56";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	buckbooster_en_default: buckbooster-en-default-state {
 		pins = "gpio8";
 		function = "gpio";
@@ -127,6 +162,14 @@ reg_tsp_en_default: reg-tsp-en-default-state {
 		bias-disable;
 	};
 
+	secondary_mic_default: secondary-mic-default-state {
+		pins = "gpio98";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-high;
+	};
+
 	tsp_int_default: tsp-int-default-state {
 		pins = "gpio13";
 		function = "gpio";

-- 
2.42.0


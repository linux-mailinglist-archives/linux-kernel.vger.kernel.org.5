Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10EA7B6A44
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbjJCNTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbjJCNS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:18:59 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8D8D3;
        Tue,  3 Oct 2023 06:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696339128; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sBTOCYL0l7xpzClqzSaMp1yAB+TbcIG0/h+JA1rplR1ec06wItNwxweMhv8iR8CCSW
    8ubxVOrPS44ovxVBBGV8QqHhfrG+ntjnDzd8LbrDNJzrbgvEmKm5kdQdnmf5J1tj+ZvA
    WJGudu03eOChKkhboox6R7KZzB3BSNB/N/aniSUIjj4RCRRw9VFeFjMZG2BGlNGLJjZx
    55DwQD/JksF79TBsJOCYB1mwtIlxAFAqcbpAaq1WGWrwC3N8yCtJc2+TFkowHY5hXfNv
    SMEe7110tvV2j3Hx8yL6NDjAMKYeDtwV1b+M23fYzOHE/wTy1HV89ffr8S9DzC6UfXw7
    iQaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339128;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ABcr19tRNPJA9WwA6xu4YglVdNWC2sFiJ/DvAai4lIo=;
    b=n+5mtP/7v2dRfGdBn8FC2cQEDqZz4nUXdZP8O654BJCrtbaUrRouH54pq+F6Pa+cYD
    32f2ac0KAfmyRm5Y/hvxCVcDqwKT//49ZwHK1D9lDC3bMp3GzCXTpfYaAEtdszAYvuRj
    LKsanQSFDxSr+IxI2NoHhmK3LLcDbQUgj4P1/siUW2gSNNWREe3NHIo1hnkYLZIgm0BK
    AR6vaKU9L1TtwqpMJApzauyb2zN9soGYOGYuCds/596vWfIJDMisLYC1g7ZE94wCbMIO
    GLXrU1rViq/I7lUzHpkeC41/QxV9ahLjf4wP3lvb0mK2Mekk/ATR7yUkJv/7yzSqrOMA
    pdAg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339128;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ABcr19tRNPJA9WwA6xu4YglVdNWC2sFiJ/DvAai4lIo=;
    b=mtGigz86apnLDj4Aef2RFkKeMYEQ4Fj06SefhLGT8Mjc9F+Pd+TGxdNGqDhBCARhEA
    ke+fm003Xb6as6voEbHMBN5/LsG8e7x1KmQyCWa+YxqygUDUPMP/JmEMOuzgnAxH1oJS
    baXA+edN4EGbQg5w7pvBAs90gqMyrOAP238dHYRTXsgTyur/n+/XlZVUUs6IplXMTymi
    G3rFarBl3Ba8qWBiU8E8DuQgELKIJ8a8hRfxHWzNY1iqBoliwIR1SZ53KYPDkgmCicgA
    dwlbPJMGRiI/QVfD22X5pYhp+ukAJPPkL4mTjQ2UcEdXqmD50LPN4e5tdVzx1ygaIv+3
    JMxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696339128;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ABcr19tRNPJA9WwA6xu4YglVdNWC2sFiJ/DvAai4lIo=;
    b=0rBD6xGGMzYpccoyDhR5F3E2OKkHPicRep76JrYZNxJE09AEt7xPEWwEbMgYxtlCVH
    pgcSghTHcwohbkBWCXDg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z93DIm2OO
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Oct 2023 15:18:48 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 03 Oct 2023 15:18:30 +0200
Subject: [PATCH v2 12/14] arm64: dts: qcom: msm8916-samsung-gt5: Add sound
 and modem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-msm8916-modem-v2-12-61b684be55c0@gerhold.net>
References: <20231003-msm8916-modem-v2-0-61b684be55c0@gerhold.net>
In-Reply-To: <20231003-msm8916-modem-v2-0-61b684be55c0@gerhold.net>
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
[Stephan: Add consistent commit message, minor refactoring]
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  | 54 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts | 22 +++++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts  | 42 +++++++++++++++++
 3 files changed, 118 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index 6a16eb5ce07b..fbd2caf405d5 100644
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
@@ -116,6 +119,29 @@ &blsp_uart2 {
 	status = "okay";
 };
 
+/*
+ * For some reason the speaker amplifier is connected to the second SD line
+ * (MI2S_2_D1) instead of the first (MI2S_2_D0). This must be configured in the
+ * device tree, otherwise audio will seemingly play fine on the wrong SD line
+ * but the speaker stays silent.
+ *
+ * When routing audio via QDSP6 (the default) the &lpass node is reserved and
+ * the definitions from &q6afedai are used. When the modem is disabled audio can
+ * be alternatively routed directly to the LPASS hardware with reduced latency.
+ * The definitions for &lpass are here for completeness to simplify changing the
+ * setup with minor changes to the DT (either manually or with DT overlays).
+ */
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
@@ -133,6 +159,13 @@ &pm8916_usbin {
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
@@ -147,6 +180,27 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&sound {
+	audio-routing =
+		"AMIC1", "MIC BIAS External1",
+		"AMIC2", "MIC BIAS Internal2",
+		"AMIC3", "MIC BIAS External1";
+
+	sound_link_backend2: backend2-dai-link {
+		link-name = "Quaternary MI2S";
+
+		cpu {
+			sound-dai = <&q6afedai QUATERNARY_MI2S_RX>;
+		};
+		platform {
+			sound-dai = <&q6routing>;
+		};
+		codec {
+			sound-dai = <&speaker_codec>;
+		};
+	};
+};
+
 &usb {
 	dr_mode = "peripheral";
 	extcon = <&pm8916_usbin>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
index c3f1acc55078..5b34529b816c 100644
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
@@ -146,7 +154,21 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&sound {
+	model = "samsung-gt510";
+	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default>;
+	pinctrl-1 = <&cdc_pdm_sleep &sec_mi2s_sleep>;
+	pinctrl-names = "default", "sleep";
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
index 998625abd409..579312ed53ce 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
@@ -35,6 +35,26 @@ reg_vdd_tsp: regulator-vdd-tsp {
 		pinctrl-names = "default";
 	};
 
+	i2c-amplifier {
+		compatible = "i2c-gpio";
+		sda-gpios = <&tlmm 55 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&tlmm 56 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
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
@@ -98,7 +118,21 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&sound {
+	model = "samsung-a2015";
+	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default &secondary_mic_default>;
+	pinctrl-1 = <&cdc_pdm_sleep &sec_mi2s_sleep &secondary_mic_default>;
+	pinctrl-names = "default", "sleep";
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
@@ -127,6 +161,14 @@ reg_tsp_en_default: reg-tsp-en-default-state {
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


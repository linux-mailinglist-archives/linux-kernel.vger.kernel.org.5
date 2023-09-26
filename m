Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20E37AF144
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbjIZQwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjIZQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:52:04 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C53124;
        Tue, 26 Sep 2023 09:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695747098; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=k/rKQBb2dF9ATI80TPY5GeU+GDXwp8btyYSvV7lXIE9fIo+1xaK4aBlId1hZt3Zn4p
    dCKxzzOIiUGmDnJykSCbobgvLgUidW7soVjUnj0SGsyUisgatrOxq5cUaVDoDf4rWxPx
    tZ2Jymo/Nq3qC9YNKyo5fkx3OGzXiSnuUhEPkii5Qlda7VdCZ7iiYnamJQdoWKpPFOpd
    VSQP/hZBjMhfa/CN/4S9sKyYC+IJ7Kuy/PHpQb/9et1qsdWnKwKk9DLb8uo+aKVt+pB5
    Bjm11F0Cqm/JZNWjV6+d/2af8NJN1mCMmbRsxVufn8mkgsVY2MMYYQPjPibkXS8cWPiy
    jJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695747098;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=T07F4EQbQn/5OhhvTsQJCuEuYJbCRTqeoJsSzoUsJB4=;
    b=Cuo5OmzPvHviifAilu+MPo75WomBntft5H5EHYvh/NZlmzI9BweSPNrP6PNnsjAnGO
    aimNjrD78uKTFATUiMk/ST2u0ov2HOaSVo6o5fGW35ihMHxg++bv+z3FsU5YVMsR+q/J
    mXFaeh9nbxG8SbPyTz0jSgB7jOyXatv2pPIsOgj8SCkBvGjUcZAVI5008FPh1ve4hMto
    wbC0Tu7jRyKm9nrh9m3iXLCS8nGmkjKDarMSs18ca9FR4DGF14PaxAdm+XL8xLMlbLi2
    h9c65QBugH0kzx+sW0YzLIoA/Lb1Pkwxhr5BGg/f+BTQIuyKz17FhzprL9UFCdqOZMn6
    aTOg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695747098;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=T07F4EQbQn/5OhhvTsQJCuEuYJbCRTqeoJsSzoUsJB4=;
    b=NRwYpKAMjSLyaRZn/1zRX+en2LxRUOsr4QeiXfyx2uFDUzQiSKiz5eyDcFI/nGzUvI
    vMImm2I2wieMFoUPSpfNfAZvjwsg9OAuq/3ExaRLEUAMoOWbjE7dkSQXDeUawebIOYcB
    FviX5mprGUQVmqq01be9ytcHI5KbvzSDmKb5sLRk6R66Ke1b6ba68BwO4g1xO+ET7F+q
    JaqlH/HcLgPalZcvVbZec1ECNNTnjMonmLCWQkk0dcvqHQtEFvbh/scttpfVPwbhrgEG
    yYgESSinaWEyz6op6il6b12wHYn44NboqsaVVjPE80XHSSEf4uYgnjPvbtQuCnsG0nF/
    PxyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695747098;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=T07F4EQbQn/5OhhvTsQJCuEuYJbCRTqeoJsSzoUsJB4=;
    b=x9Rdz8G7gfyyVlgEQ6VB8y5XO1BTiX5HjDy6pfrFXGF6UcP8COOL7aVzJNgE33tLRJ
    dHMFf82MKetj4mKWnkAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOH+nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QGpcg5b
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 18:51:38 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 26 Sep 2023 18:51:18 +0200
Subject: [PATCH 04/13] arm64: dts: qcom: msm8916-samsung-a2015: Add sound
 and modem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-msm8916-modem-v1-4-398eec74bac9@gerhold.net>
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
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sound and modem for the Samsung A2015 based devices (A3, A5, E5,
E7, Grand Max). The setup is similar to most MSM8916 devices, i.e.:

 - QDSP6 audio
 - Earpiece/headphones/microphones via digital/analog codec in
   MSM8916/PM8916
 - WWAN Internet via BAM-DMUX

except:

 - NXP TFA9895 codec for speaker on Quaternary MI2S
 - Samsung-specific audio jack detection (not supported yet)

[Lin: Add e2015 and grandmax]
Co-developed-by: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Signed-off-by: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi     | 55 ++++++++++++++++++++++
 .../dts/qcom/msm8916-samsung-e2015-common.dtsi     |  4 ++
 .../boot/dts/qcom/msm8916-samsung-grandmax.dts     |  4 ++
 3 files changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 0b29132b74e1..f71b18d89bf9 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "msm8916-pm8916.dtsi"
+#include "msm8916-modem-qdsp6.dtsi"
+
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/sound/apq8016-lpass.h>
 
 / {
 	aliases {
@@ -196,6 +199,18 @@ vibrator: vibrator {
 	};
 };
 
+&blsp_i2c1 {
+	status = "okay";
+
+	speaker_codec: audio-codec@34 {
+		compatible = "nxp,tfa9895";
+		reg = <0x34>;
+		vddd-supply = <&pm8916_l5>;
+		sound-name-prefix = "Speaker";
+		#sound-dai-cells = <0>;
+	};
+};
+
 &blsp_i2c2 {
 	status = "okay";
 
@@ -243,6 +258,13 @@ &gpu {
 	status = "okay";
 };
 
+&lpass {
+	dai-link@3 {
+		reg = <MI2S_QUATERNARY>;
+		qcom,playback-sd-lines = <1>;
+	};
+};
+
 &mdss {
 	status = "okay";
 };
@@ -253,6 +275,10 @@ &mdss_dsi0 {
 	pinctrl-1 = <&mdss_sleep>;
 };
 
+&mpss_mem {
+	reg = <0x0 0x86800000 0x0 0x5400000>;
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
@@ -265,6 +291,13 @@ pm8916_l17: l17 {
 	};
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
@@ -279,6 +312,28 @@ &sdhc_2 {
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
 
+&sound {
+	status = "okay";
+
+	model = "samsung-a2015";
+	audio-routing =
+		"AMIC1", "MIC BIAS External1",
+		"AMIC2", "MIC BIAS Internal2",
+		"AMIC3", "MIC BIAS External1";
+
+	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default>;
+	pinctrl-1 = <&cdc_pdm_sleep &sec_mi2s_sleep>;
+	pinctrl-names = "default", "sleep";
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
 	status = "okay";
 	extcon = <&muic>, <&muic>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
index 0824ab041d80..3c49dac92d2d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
@@ -65,6 +65,10 @@ accelerometer@1d {
 	};
 };
 
+&mpss_mem {
+	reg = <0x0 0x86800000 0x0 0x5a00000>;
+};
+
 &reg_motor_vdd {
 	regulator-min-microvolt = <3300000>;
 	regulator-max-microvolt = <3300000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
index 3f145dde4059..5882b3a593b8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
@@ -49,6 +49,10 @@ &reg_touch_key {
 	status = "disabled";
 };
 
+&sound {
+	model = "samsung-gmax"; /* No secondary microphone */
+};
+
 &tlmm {
 	gpio_leds_default: gpio-led-default-state {
 		pins = "gpio60";

-- 
2.42.0


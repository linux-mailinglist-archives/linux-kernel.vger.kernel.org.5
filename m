Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1C27B6A3C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbjJCNTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbjJCNSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:18:52 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90469BD;
        Tue,  3 Oct 2023 06:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696339126; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=L1oQY7PnVX/f6k10ssuj3NeRvAvSwmvEvpCWMQ7B8o3qWsQB8fxtjpA8rWmehWX+Gv
    Agtb7WK0WCsF4tL+jAI//5JmtobedGbkAb5hjJLB6lKLoAppta40KQYTrA0hGUWVQuFy
    qcvXhW5oiBGd7DE8xE631leYAfa1Y0dRz7u6jLc96hoSRiCWxhIUL5hHD9h54xrX++fb
    tN91gPUr3pmZDhZAQCCZNwrLJZHxEdvAB3BCvvY8HZ93hAbMeEV9Y+FUp9lyq+33YF/R
    Zp8fhO3w11iMgIQmvVfB652kp8tEBhA6z8ZEJwuMrfQU63jQkfuqf2/HOw4Y38QFs5pu
    itng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339126;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=CJfhHqq4bYPkDlzc+To1FAdUVzbIpBsNH1YlvpKh7/I=;
    b=GeCizgeOuxN19DGUGNvSNXNywnok/uHOL1mE25O4V0d/egFPgQVoIJlE49hg6E/5cp
    GI5Im/xIkWSfIrcX3qqhB6YwNdiEacnPmFrR+6E0WbizE7+SfSaO1+/dg16dr78DcAFT
    fd05xQNOOhXQqWD8OKnLAZna9VVuhGAlG0GPCSMfgTZlg/gBdoCBmiNgcQiIzkb6fzwc
    8G5BZQXg6VTnD+G/kEweLFpcHNQugXX10Xexx9KlNl8cUik6bDWOTNVm3frD66gOsebW
    52BE8cJUNVTfXjkVJ38gXXe97KA8CqvQ8UXkOxI3kKGDjhVsgNm6AgH70uTu2jQJ9GyZ
    gZbQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339126;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=CJfhHqq4bYPkDlzc+To1FAdUVzbIpBsNH1YlvpKh7/I=;
    b=EfvDZSgkuR9Cx98wiizOeEeMWht+xrpoEDw1AB/0eRTxZwK20bcFaDJqFSvLdMonng
    meP1aURrKGxzzGHq3lxQI+7Kwu8LaO89Day/IwpJIgG3y2nWNFDqe3f9Y4mdgB3ONJAV
    W3CwPpXtKCXGWr/um0B14pom0TylTpgJ5eZpNVWGpjNEEOf6MMNm4C+cvGw4Y3a7+gkw
    UXscrg/YPMaRhnQGt90KtuGolUaAJ6bIgI2LrTV0H8xLFkFYFTVUMZxdKdHwdSujQ9k/
    yGYTyYbBFJxi5F9hijx8Pe5fUVvQLplzutpYgZoWEm0lXXWj2Kt156oyi3j30dztV2Pc
    tJtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696339126;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=CJfhHqq4bYPkDlzc+To1FAdUVzbIpBsNH1YlvpKh7/I=;
    b=fvq1pFVmORGTNpEVVlqgoTlioAa5Ef0OxDhYhkMTxHkkD847h4/mvZAJv1yny9obVy
    HAIj2Y043r2904QSHsCg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z93DIk2OJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Oct 2023 15:18:46 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 03 Oct 2023 15:18:25 +0200
Subject: [PATCH v2 07/14] arm64: dts: qcom: msm8916-wingtech-wt88047: Add
 sound and modem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-msm8916-modem-v2-7-61b684be55c0@gerhold.net>
References: <20231003-msm8916-modem-v2-0-61b684be55c0@gerhold.net>
In-Reply-To: <20231003-msm8916-modem-v2-0-61b684be55c0@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sound and modem for the Xiaomi Redmi 2. The setup
is similar to most MSM8916 devices, i.e.:

 - QDSP6 audio
 - Earpiece/headphones/microphones via digital/analog codec in
   MSM8916/PM8916
 - Audio jack detection via analog codec in PM8916
 - WWAN Internet via BAM-DMUX

except:

 - Speaker amplifier is connected to HPH_R (headphones) output of the
   analog codec. There is a separate analog switch that allows disabling
   playback via the headphone jack.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../boot/dts/qcom/msm8916-wingtech-wt88047.dts     | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
index 419f35c1fc92..d4b88c787e59 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
@@ -6,6 +6,8 @@
 /dts-v1/;
 
 #include "msm8916-pm8916.dtsi"
+#include "msm8916-modem-qdsp6.dtsi"
+
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
@@ -25,6 +27,28 @@ chosen {
 		stdout-path = "serial0";
 	};
 
+	speaker_amp: audio-amplifier {
+		compatible = "simple-audio-amplifier";
+		enable-gpios = <&tlmm 117 GPIO_ACTIVE_HIGH>;
+		sound-name-prefix = "Speaker Amp";
+		pinctrl-0 = <&speaker_amp_default>;
+		pinctrl-names = "default";
+	};
+
+	/*
+	 * This seems to be actually an analog switch that either routes audio
+	 * to the headphone jack or nowhere. Given that we need to enable a GPIO
+	 * to get sound on headphones, modelling it as simple-audio-amplifier
+	 * works just fine.
+	 */
+	headphones_switch: audio-switch {
+		compatible = "simple-audio-amplifier";
+		enable-gpios = <&tlmm 8 GPIO_ACTIVE_HIGH>;
+		sound-name-prefix = "Headphones Switch";
+		pinctrl-0 = <&headphones_switch_default>;
+		pinctrl-names = "default";
+	};
+
 	flash-led-controller {
 		compatible = "ocs,ocp8110";
 		enable-gpios = <&tlmm 31 GPIO_ACTIVE_HIGH>;
@@ -146,6 +170,18 @@ &blsp_uart2 {
 	status = "okay";
 };
 
+&mpss_mem {
+	reg = <0x0 0x86800000 0x0 0x5100000>;
+};
+
+&pm8916_codec {
+	qcom,micbias1-ext-cap;
+	qcom,micbias-lvl = <2800>;
+	qcom,mbhc-vthreshold-low = <75 100 120 180 500>;
+	qcom,mbhc-vthreshold-high = <75 100 120 180 500>;
+	qcom,hphl-jack-type-normally-open;
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
@@ -180,6 +216,30 @@ &sdhc_2 {
 	non-removable;
 };
 
+&sound {
+	/*
+	 * Provide widgets/pin-switches to allow enabling speaker and headphones
+	 * separately. Both are routed via the HPH_L/HPH_R pins of the codec.
+	 */
+	model = "wt88047";
+	widgets =
+		"Speaker", "Speaker",
+		"Headphone", "Headphones";
+	pin-switches = "Speaker", "Headphones";
+	audio-routing =
+		"Speaker", "Speaker Amp OUTL",
+		"Speaker", "Speaker Amp OUTR",
+		"Speaker Amp INL", "HPH_R",
+		"Speaker Amp INR", "HPH_R",
+		"Headphones", "Headphones Switch OUTL",
+		"Headphones", "Headphones Switch OUTR",
+		"Headphones Switch INL", "HPH_L",
+		"Headphones Switch INR", "HPH_R",
+		"AMIC1", "MIC BIAS External1",
+		"AMIC2", "MIC BIAS Internal2";
+	aux-devs = <&speaker_amp>, <&headphones_switch>;
+};
+
 &usb {
 	status = "okay";
 	extcon = <&usb_id>, <&usb_id>;
@@ -226,6 +286,13 @@ gpio_keys_default: gpio-keys-default-state {
 		bias-pull-up;
 	};
 
+	headphones_switch_default: headphones-switch-default-state {
+		pins = "gpio8";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	imu_default: imu-default-state {
 		pins = "gpio115";
 		function = "gpio";
@@ -234,6 +301,13 @@ imu_default: imu-default-state {
 		bias-disable;
 	};
 
+	speaker_amp_default: speaker-amp-default-state {
+		pins = "gpio117";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	touchscreen_default: touchscreen-default-state {
 		touchscreen-pins {
 			pins = "gpio13";

-- 
2.42.0


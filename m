Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725167B6A41
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbjJCNTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjJCNSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:18:54 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844F6A3;
        Tue,  3 Oct 2023 06:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696339128; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sz9sAkCK8nYQM08RmK+Niu0nJ96gXHB4dcHE7dOH1tgAQQmQahK0C4qw450TSd+YXn
    OVAtib9CITCBZXjUkjWKbfhKogzDbWkhH0f7oIkm8GQWXayGE18e8p2GdAmgx5NSOUR9
    cNf4JjvsdPtHEpmMYbHsVnZm1nQjbIm51PVJ7tE/EXomPNkNyN9s0EM+Sq5NuLJAfgQ6
    aOAMFZu0YimOtaaef57T+lCpGBgA8QJ8fFQWvHEE/ADlvl4SiMx0lVbxDkgfLAmGRBvl
    gXBaqcq9kJL9oqscBGSZ+mFv9lQPDmKsDl+AEfmfp7bxL+NVdDrsekU5TdvfFNj2zO3A
    7tvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339128;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Ii17T7VAoR8+UlL8LnMJpVNUDvOUl5el80hXLnYIkJo=;
    b=n33Db94ywl7q0QOxk9RuBpvzP0ErDHw+X1mkcGQDZ8g4z+iBftMiQQtVeRkjgvZUZd
    cyAB95mDA0qjk6uvMm9XGlSlh8zraT1FZRTzhsGfwoqA6fYhZJ3b9rG/IWWJ9Pv6YyFj
    xgqBtuFSD90jJOlsYpgtkIdd/Lxh98P64zXbIMQjkKUxce6DPPlwtCiKqUKERNV4b6m5
    n59W8kLUWLIMoPy+rF1aR606J4Skp1z1VM+XXY7vvJKxsFV4i2XbkmO9MgADi5ru8JpT
    Ng90G+8WO1V2Vk8uRvqyeDr6+vAyRZqD8M9ZBXMqmfMV2LsukuzCfZmdZE8eE/5KwfZN
    Sjuw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339128;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Ii17T7VAoR8+UlL8LnMJpVNUDvOUl5el80hXLnYIkJo=;
    b=jT9t3bAZE2QwYwGkFuOj+LzsQKPjVaK6gKO1iar8yikAlW7zHRC7Ad6/rdqODbwVeN
    io4NcpB04oYMW/Mcm0ZKyRNfZKH1MgpzhPuHApVVR9XojThYVSyfSVz0uaT5+3F6Qdyh
    L8L8vfeNxsFtBsL5/ks0Sma7rJvHITCoXSZylW1qu5AOLqyoP+cvuhvjoDRu1Itz2Jh7
    wVJdc4WrqVsFdLEUp1XjbW6uCcDVeO+/Npe8ggAfQ8hqvQX+LgB6YH2jGOHNjBUOkpFm
    3VehuW6LDCP6qEsQA0/VS5nuqn92I06+ZfYihVzVS2qQ+FhRBLR40N3MCFDo9p89c4x4
    9xgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696339128;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Ii17T7VAoR8+UlL8LnMJpVNUDvOUl5el80hXLnYIkJo=;
    b=1AL1PwhzDlQEgjQnEhg9f6KfmcMyaS2vsWoz1Se02CpydRblR6Qka2UXpdzthnjMK5
    chEX3takA9dtJ+mNG7CQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z93DIm2ON
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Oct 2023 15:18:48 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 03 Oct 2023 15:18:29 +0200
Subject: [PATCH v2 11/14] arm64: dts: qcom: msm8916-longcheer-l8910: Add
 sound and modem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-msm8916-modem-v2-11-61b684be55c0@gerhold.net>
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
        Jonathan Albrieux <jonathan.albrieux@gmail.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Albrieux <jonathan.albrieux@gmail.com>

Enable sound and modem for the Longcheer L8910 (BQ Aquaris X5).
The setup is similar to most MSM8916 devices, i.e.:

 - QDSP6 audio
 - Earpiece/headphones/microphones via digital/analog codec in
   MSM8916/PM8916
 - Audio jack detection via analog codec in PM8916
 - WWAN Internet via BAM-DMUX

except:

 - Awinic AW8738 connected to HPH_R (headphones) output of the analog
   codec. Note that unlike for wingtech-wt88047 there is no analog
   switch that would allow disabling output via the headphone jack
   when the speaker is enabled.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts      | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index 41cadb906b98..e64bf687ca7d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -3,6 +3,8 @@
 /dts-v1/;
 
 #include "msm8916-pm8916.dtsi"
+#include "msm8916-modem-qdsp6.dtsi"
+
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
@@ -22,6 +24,16 @@ chosen {
 		stdout-path = "serial0";
 	};
 
+	speaker_amp: audio-amplifier {
+		compatible = "awinic,aw8738";
+		mode-gpios = <&tlmm 114 GPIO_ACTIVE_HIGH>;
+		awinic,mode = <5>;
+		sound-name-prefix = "Speaker Amp";
+
+		pinctrl-0 = <&spk_ext_pa_default>;
+		pinctrl-names = "default";
+	};
+
 	flash-led-controller {
 		compatible = "ocs,ocp8110";
 		enable-gpios = <&tlmm 49 GPIO_ACTIVE_HIGH>;
@@ -107,6 +119,17 @@ &blsp_uart2 {
 	status = "okay";
 };
 
+&mpss_mem {
+	reg = <0x0 0x86800000 0x0 0x5000000>;
+};
+
+&pm8916_codec {
+	qcom,micbias-lvl = <2800>;
+	qcom,mbhc-vthreshold-low = <75 100 120 180 500>;
+	qcom,mbhc-vthreshold-high = <75 100 120 180 500>;
+	qcom,hphl-jack-type-normally-open;
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
@@ -137,6 +160,28 @@ &sdhc_2 {
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
 
+&sound {
+	/*
+	 * Provide widgets/pin-switches to allow enabling speaker separately.
+	 * The hardware does not provide a way to disable the output via the
+	 * headphone jack when the speaker is enabled.
+	 */
+	model = "bq-paella";
+	widgets =
+		"Speaker", "Speaker",
+		"Headphone", "Headphones";
+	pin-switches = "Speaker";
+	audio-routing =
+		"Speaker", "Speaker Amp OUT",
+		"Speaker Amp IN", "HPH_R",
+		"Headphones", "HPH_L",
+		"Headphones", "HPH_R",
+		"AMIC1", "MIC BIAS External1",
+		"AMIC2", "MIC BIAS Internal2",
+		"AMIC3", "MIC BIAS External1";
+	aux-devs = <&speaker_amp>;
+};
+
 &usb {
 	status = "okay";
 	extcon = <&usb_id>, <&usb_id>;
@@ -205,6 +250,13 @@ sdc2_cd_default: sdc2-cd-default-state {
 		bias-disable;
 	};
 
+	spk_ext_pa_default: spk-ext-pa-default-state {
+		pins = "gpio114";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	usb_id_default: usb-id-default-state {
 		pins = "gpio110";
 		function = "gpio";

-- 
2.42.0


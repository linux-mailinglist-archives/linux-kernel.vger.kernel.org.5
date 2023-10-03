Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64D17B6A40
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjJCNTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjJCNSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:18:53 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F99BF;
        Tue,  3 Oct 2023 06:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696339127; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=deyQBF1qDu2pB+WCeifvnr3fxdE7k/s7EX/ejVGlu3s8YyOqVe2bDtzgR1B+q2Iggs
    BV455oysg3m0vOv5v0Wd4FCyjSeD1MARkGVzro43RbAQr8Zf6UUu3uDVZJRDoL9/nSdx
    ZmP74Rc6dEtUQP07lo3K1r1eouN4MOVuAd5ZYZ+2R/tWWmwxK4HhlOp656n1YOxv27WE
    hB91feAgaHuv3QBkdwCJTCWAqAgI9ScO9xvkiD0NZH2tXQefHPgkZH5mVIU/Z+jP3QlC
    xG36YlvyN4e84mC9HbzBENdsHLuda/SA1wVpHOiQjh9ODDI8p4rdbVRrSMy4chtVOenv
    MVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339127;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=V80D4xHlpO7GexIpJNi9sjTtC2eqOZQwsBpEhLVnXdA=;
    b=ZpBuZ+ckmBj0Mo59Ii7EEfyS356gptNaGBpU13KrlK71EUC1SShpZArWGuYuayxez4
    RaIPr4ZPG0LrzOl5sHCzkIiZ+b3x8alzoMi7EZSaScFxxJUrvOQ2G+1DsggI6eQWbPmi
    +nj8X+UIXPidQJkV50O1czrvLzsUjLv/OJaHZHBmiihWVd/CsbLEQRfiEi8SXK5FktJY
    on+V5vwkhxvwwHY197iaHFVuSCPdif4C+YjxzP2E9LTIDxFm1pv+gBCWFiVKzEyLtzJR
    aAgYYavuhtFgLWvzK7Y+EeFkAUEMy+BcokGZtaOEwoLb6Oe4KxQOSizth4xbwGR+T4J6
    VBnQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339127;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=V80D4xHlpO7GexIpJNi9sjTtC2eqOZQwsBpEhLVnXdA=;
    b=ATbsn7AUMsIQfZAhkJyhSGFmVgCziAecdOqs8nrCV6Uw2Tsjgp3VXmyXdnJx1GmpAC
    Y14ghcXrBJR5sbLzTrqn2Rp2fuAv8OUkdiOFmpu1C1ch+nw1ZyfprotHXpUqYrcsteZ6
    PFyX3SBN8g6T0OAOOSbKy9zgGJSvMj5Qp5Zm4v+Ae2Y/iBJaZe8zU0uc+FaK8f43/nw5
    V530PFiNiJnC4Pi5CrO7idbRnOB70Bc77+dAzvUrtcyyKLhhRASVmYDTMsjzzFTbMcHI
    TuxA9MKmOo0p99h7ibHv6vEl/vHWmMOssItDutjZEfLYg8F3eOyF3beCeuhFavT07l2F
    R4KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696339127;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=V80D4xHlpO7GexIpJNi9sjTtC2eqOZQwsBpEhLVnXdA=;
    b=ZNivYSztKdV3G2A8O0/E4qj7yTR6QnV71U0XKyi2fIeuATyD0wf6VVzaWa+2cYzOfq
    0uu76QzpQfs5xQ8VhpCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z93DIl2OK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Oct 2023 15:18:47 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 03 Oct 2023 15:18:26 +0200
Subject: [PATCH v2 08/14] arm64: dts: qcom: msm8916-alcatel-idol347: Add
 sound and modem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-msm8916-modem-v2-8-61b684be55c0@gerhold.net>
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
        Vincent Knecht <vincent.knecht@mailoo.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Knecht <vincent.knecht@mailoo.org>

Enable sound and modem for the Alcatel Idol 3 (4.7"). The setup is
similar to most MSM8916 devices, i.e.:

 - QDSP6 audio
 - Microphones via digital/analog codec in MSM8916/PM8916
 - WWAN Internet via BAM-DMUX

except:

 - Stereo NXP TFA9890 codecs for speakers on Quaternary MI2S
   - These are also used as earpieces at the top/bottom.
 - Asahi Kasei AK4375 headphone codec on Secondary MI2S
 -> Primary MI2S is not used for playback

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
[Stephan: Minor refactoring, add consistent commit message]
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
There are some trivial conflicts unless
https://lore.kernel.org/linux-arm-msm/20230921-msm8916-rmem-fixups-v1-3-34d2b6e721cf@gerhold.net/
is applied first. But given that there are important fixups for the
dynamic reserved memory changes in that series it should preferably
get applied before this one anyway.
---
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts      | 171 +++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index fade93c55299..3459145516a1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -3,6 +3,8 @@
 /dts-v1/;
 
 #include "msm8916-pm8916.dtsi"
+#include "msm8916-modem-qdsp6.dtsi"
+
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
@@ -22,6 +24,19 @@ chosen {
 		stdout-path = "serial0";
 	};
 
+	reserved-memory {
+		/delete-node/ reserved@86680000;
+		/delete-node/ rmtfs@86700000;
+
+		rmtfs: rmtfs@86680000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0x86680000 0x0 0x160000>;
+			no-map;
+
+			qcom,client-id = <1>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -50,6 +65,17 @@ led-0 {
 		};
 	};
 
+	reg_headphones_avdd: regulator-headphones-avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "headphones_avdd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&tlmm 121 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-0 = <&headphones_avdd_default>;
+		pinctrl-names = "default";
+	};
+
 	usb_id: usb-id {
 		compatible = "linux,extcon-usb-gpio";
 		id-gpios = <&tlmm 69 GPIO_ACTIVE_HIGH>;
@@ -58,6 +84,43 @@ usb_id: usb-id {
 	};
 };
 
+&blsp_i2c3 {
+	status = "okay";
+
+	headphones: audio-codec@10 {
+		compatible = "asahi-kasei,ak4375";
+		reg = <0x10>;
+		avdd-supply = <&reg_headphones_avdd>;
+		tvdd-supply = <&pm8916_l6>;
+		pdn-gpios = <&tlmm 114 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&headphones_pdn_default>;
+		pinctrl-names = "default";
+		#sound-dai-cells = <0>;
+	};
+
+	speaker_codec_top: audio-codec@34 {
+		compatible = "nxp,tfa9897";
+		reg = <0x34>;
+		vddd-supply = <&pm8916_l6>;
+		rcv-gpios = <&tlmm 50 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&speaker_top_default>;
+		pinctrl-names = "default";
+		sound-name-prefix = "Speaker Top";
+		#sound-dai-cells = <0>;
+	};
+
+	speaker_codec_bottom: audio-codec@36 {
+		compatible = "nxp,tfa9897";
+		reg = <0x36>;
+		vddd-supply = <&pm8916_l6>;
+		rcv-gpios = <&tlmm 111 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&speaker_bottom_default>;
+		pinctrl-names = "default";
+		sound-name-prefix = "Speaker Bottom";
+		#sound-dai-cells = <0>;
+	};
+};
+
 &blsp_i2c4 {
 	status = "okay";
 
@@ -153,6 +216,18 @@ &blsp_uart2 {
 	status = "okay";
 };
 
+&mpss_mem {
+	reg = <0x0 0x86800000 0x0 0x5000000>;
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
@@ -169,6 +244,17 @@ &pm8916_vib {
 	status = "okay";
 };
 
+&q6afedai {
+	dai@18 {
+		reg = <SECONDARY_MI2S_RX>;
+		qcom,sd-lines = <0>;
+	};
+	dai@22 {
+		reg = <QUATERNARY_MI2S_RX>;
+		qcom,sd-lines = <0>;
+	};
+};
+
 &sdhc_1 {
 	status = "okay";
 };
@@ -183,6 +269,54 @@ &sdhc_2 {
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
 
+&sound {
+	/* Add pin switches for speakers to allow disabling them individually */
+	model = "alcatel-idol3";
+	widgets =
+		"Speaker", "Speaker Top",
+		"Speaker", "Speaker Bottom";
+	pin-switches = "Speaker Top", "Speaker Bottom";
+	audio-routing =
+		"Speaker Top", "Speaker Top OUT",
+		"Speaker Bottom", "Speaker Bottom OUT",
+		"AMIC1", "MIC BIAS External1",
+		"AMIC2", "MIC BIAS Internal2",
+		"AMIC3", "MIC BIAS External1";
+
+	pinctrl-0 = <&cdc_pdm_default &pri_mi2s_default &pri_mi2s_ws_default &sec_mi2s_default>;
+	pinctrl-1 = <&cdc_pdm_sleep &pri_mi2s_sleep &pri_mi2s_ws_sleep &sec_mi2s_sleep>;
+	pinctrl-names = "default", "sleep";
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
+			sound-dai = <&speaker_codec_top>, <&speaker_codec_bottom>;
+		};
+	};
+};
+
+&sound_link_backend0 {
+	/* Primary MI2S is not used, replace with Secondary MI2S for headphones */
+	link-name = "Secondary MI2S";
+
+	cpu {
+		sound-dai = <&q6afedai SECONDARY_MI2S_RX>;
+	};
+	platform {
+		sound-dai = <&q6routing>;
+	};
+	codec {
+		sound-dai = <&headphones>;
+	};
+};
+
 &usb {
 	status = "okay";
 	extcon = <&usb_id>, <&usb_id>;
@@ -212,6 +346,15 @@ &wcnss_mem {
 	status = "okay";
 };
 
+/* Only some of the pins are used */
+&pri_mi2s_default {
+	pins = "gpio113", "gpio115";
+};
+
+&pri_mi2s_sleep {
+	pins = "gpio113", "gpio115";
+};
+
 &tlmm {
 	accel_int_default: accel-int-default-state {
 		pins = "gpio31";
@@ -245,6 +388,20 @@ gyro_int_default: gyro-int-default-state {
 		bias-disable;
 	};
 
+	headphones_avdd_default: headphones-avdd-default-state {
+		pins = "gpio121";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	headphones_pdn_default: headphones-pdn-default-state {
+		pins = "gpio114";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	/*
 	 * The OEM wired an additional GPIO to be asserted so that
 	 * the si-en,sn3190 LED IC works. Since this GPIO is not
@@ -291,6 +448,20 @@ sdc2_cd_default: sdc2-cd-default-state {
 		bias-disable;
 	};
 
+	speaker_bottom_default: speaker-bottom-default-state {
+		pins = "gpio111";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	speaker_top_default: speaker-top-default-state {
+		pins = "gpio50";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	ts_int_reset_default: ts-int-reset-default-state {
 		pins = "gpio13", "gpio100";
 		function = "gpio";

-- 
2.42.0


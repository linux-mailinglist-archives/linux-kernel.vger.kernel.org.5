Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B287AF13E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbjIZQwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjIZQwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:52:01 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B932811F;
        Tue, 26 Sep 2023 09:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695747100; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DrT7d0EoBEjte4zmnLlGHPYfKKaN2tMoRKImlvAv3lbIaU7RbP8z6hiRw9q11U1Nxt
    tfd7MQrr2+GYLk3fjQNmt6O6B0l0u6WtWedroQL+EYtzeby3crJj/AN22DAdoTZb2cFu
    ZPXbA+OYXQxFzGRO6087+wYW5pZmszhKfviZUkDl8JqxwxCLxTFDxEBC/Y+pcRFGq/ZE
    msWCnFOPSDlnvZWpTaURreIMwy22qLPmrKs1oI4qdWwZKu7EraWxXRM5L+fUKA4n1aP6
    u9s6ZTZ+aiyUz+UmfkzwHuAQrfvgqo4oYevxYrtSyyyhgksY6iSRl/Ami0D5Yan2MoRf
    JyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695747100;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=TjlGsMrVPvSVvQFf2520Dzig5Hy6M5stTmN9mxXlD8U=;
    b=doYsI8WcSk87MTjUWy5FMc1Wv2GQH/GE8Z8H5T02uUC+/ThsE3aXlf2sXFmc+yfM4R
    uUCBARxNWA/tDJCXiAMUZoJOTJ2eVEd91OxzPgRRX329kdS3nxDh51QNE558pDKm+V6A
    gNLyNbKV6zrrYggDtR15rx7Ji0UG9bCntodGYZKwF7ATh67kQTxzRHOp7wFE8wuMfZe+
    /477PS9B9GFtCaHw4elmk3JtZIOPCZhooQ+02dTGCPbyrEqHVU5qTpMTjKDbC00HHT03
    6VkoSSRHNZuawa8NP3b4Z5z14fkDr8GHyCDFbSJmzHWqFjAyMvr2HqhYIzfCJHEdKVUU
    GsAQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695747100;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=TjlGsMrVPvSVvQFf2520Dzig5Hy6M5stTmN9mxXlD8U=;
    b=VeP9YNUlw3wmwzA/UDIjTmTGDX1DyDpKfRz/Eb3KOc+ISqC6T1iJf5bk6WOAHu0xcU
    BJkIvJ38Pu1eLrECV0NWZAL2Dk+p4ixvyUF2ZlTd5ulNLru6v+1PwdRqRvpX/G1iZNhR
    kIaTBAcxIsLu0RvQ19/jpv/9dgAmWhtk45c8TfasP7gXvtjFZbFgmFnZfM8ASjaSftHW
    qJMxxE92RvI2ixizCZZhdU6LfWkH0MB0T0F15oqHaG+kZSqYujykhJyjc6xw7igjqRvF
    KPHqxXJ4IodRW+qQUQDobRPqYFx9/+OprjNgKFPvq3qrH9zqnWvwdMncmfvF2tepTI72
    JADg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695747100;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=TjlGsMrVPvSVvQFf2520Dzig5Hy6M5stTmN9mxXlD8U=;
    b=Nes1SYo+Pb3s8ekeJe04W4ujCF+piDyaVgv/P3iUlhshqA8rkF2oo883qVnOWvcksd
    6WHC5LQF9CwcgQe1BOBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOH+nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QGpeg5h
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 18:51:40 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 26 Sep 2023 18:51:24 +0200
Subject: [PATCH 10/13] arm64: dts: qcom: msm8916-longcheer-l8910: Add sound
 and modem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-msm8916-modem-v1-10-398eec74bac9@gerhold.net>
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
        Jonathan Albrieux <jonathan.albrieux@gmail.com>
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
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts      | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index 41cadb906b98..c0dc9a3bbac4 100644
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
@@ -137,6 +160,30 @@ &sdhc_2 {
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
 
+&sound {
+	status = "okay";
+
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
@@ -205,6 +252,13 @@ sdc2_cd_default: sdc2-cd-default-state {
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


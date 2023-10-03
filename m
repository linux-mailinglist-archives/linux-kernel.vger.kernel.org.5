Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CAD7B6A38
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbjJCNTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjJCNSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:18:51 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF76B4;
        Tue,  3 Oct 2023 06:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696339126; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aVgM+IvjYki+e6m03nYvuqPVuUudpgj3brw1fubF1/D0uXwih5JJo5hAdpMRJbqMFl
    EEx3JS47drXV7/eOm38fJCymgKL8PSR+f7zFY+opt4JJ2bGKOP6VDUHY9edI7jnIK5i7
    fHQ0bpe83Ut1QL5oJQHYRhvrVpwspb6EyrJFzmIo1Q6st4r/3MisCmB3DXiDuqMScCny
    EXs7pSbPsLfzm7s9mhMiiFHcEFVOF6Hcb5mgNHsNDCCWZNcRunE9Wowxt364OC3x70JF
    raxAQVgxhnxp8ichqABmcylugQaIYOW/rbMerk3U+YZ2AwO3p9A0F++w/rLK0PF/lL2x
    dDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339126;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=KXUcWTcA9b6HuhOlbQlLI1PnL8fJ2J/EZHn+uesquek=;
    b=AV4/OhY3AaERy8MdxKMdvt3/Txm9qEu/f7TFoHpN0h13WzIFmDhnrdCuPKB0DQLwRf
    J/bzdkOZsL3kQiVIE5vkixUcLqY4lgQQ3K+p1gKutRtZywu5OCDme8d0Cl9Pt18N5oi0
    FOHLkZd/rLZa7fWD1ASRlNyuvo8T3CALPaQB1fDP6m0tLPntffL8tTYZq0ODU78w6IpR
    0CIyHftunN/dvJTRho/09hYWeAvOsvqZPD+zqqAH9TiNc3zlaURkwkC3UN4xRAY5s0f+
    Fc/K51WvKSCz2w83czRpdeh1B6TdadFkWxly3rJ+uBEKEJrvOnuwgEWMtsC0qGulC31O
    WdEA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339126;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=KXUcWTcA9b6HuhOlbQlLI1PnL8fJ2J/EZHn+uesquek=;
    b=TxShZE2YDdsni6N0gmA6ElBz62zsKCOSxM1tIgUkvAP+m/bAsBhtiddhdGLpM6rOp4
    0HZxBP/9FagVXR1B+N4/TQhxehPv5KTzLf1uPpNivVWbkWPcK1aDpmgTPtLQV0A/aT51
    2LYKZ2pPlZ7raOPP8AITxV3Rq1gKdBWCb45nvQpHIEmGYnvf7KktJ2+KPZ4B2HXz63Xv
    lbQUcpotscHodVSedRYJgIvDQOT1m6MLzCfhH47deiDx8k1BxpZ8rH/H7W9yUy6Iz8wJ
    pj+deeNHEOkyvbtNTgwKUK6pZWq9WNGkXsyAM4qrSWPguEC5YJQAkhaER1Vyy54vEgvZ
    wpvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696339126;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=KXUcWTcA9b6HuhOlbQlLI1PnL8fJ2J/EZHn+uesquek=;
    b=e6/VmJm9jzo7SdTpCy/zciG2cqfjI1yuFWwrkybuCLiyMVA1DWWPQvOUtRWx/JRknm
    MF1/7A6RL0hlMJeyrfBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z93DIj2OH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Oct 2023 15:18:45 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 03 Oct 2023 15:18:23 +0200
Subject: [PATCH v2 05/14] arm64: dts: qcom: msm8916-samsung-a2015: Add
 sound and modem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-msm8916-modem-v2-5-61b684be55c0@gerhold.net>
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
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi     | 71 ++++++++++++++++++++++
 .../dts/qcom/msm8916-samsung-e2015-common.dtsi     |  4 ++
 .../boot/dts/qcom/msm8916-samsung-grandmax.dts     |  4 ++
 3 files changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 0b29132b74e1..2937495940ea 100644
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
 
@@ -243,6 +258,25 @@ &gpu {
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
 &mdss {
 	status = "okay";
 };
@@ -253,6 +287,10 @@ &mdss_dsi0 {
 	pinctrl-1 = <&mdss_sleep>;
 };
 
+&mpss_mem {
+	reg = <0x0 0x86800000 0x0 0x5400000>;
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
@@ -265,6 +303,13 @@ pm8916_l17: l17 {
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
@@ -279,6 +324,32 @@ &sdhc_2 {
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
 
+&sound {
+	model = "samsung-a2015";
+	audio-routing =
+		"AMIC1", "MIC BIAS External1",
+		"AMIC2", "MIC BIAS Internal2",
+		"AMIC3", "MIC BIAS External1";
+
+	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default>;
+	pinctrl-1 = <&cdc_pdm_sleep &sec_mi2s_sleep>;
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
+			sound-dai = <&speaker_codec>;
+		};
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


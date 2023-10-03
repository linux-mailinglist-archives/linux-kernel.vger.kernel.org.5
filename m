Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED1A7B6A46
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbjJCNTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbjJCNTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:19:02 -0400
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [81.169.146.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F690A1;
        Tue,  3 Oct 2023 06:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696339129; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FfXHI5z85pFW5Y617fsif0hDGFdhByWmGZKgyC6ItfYRrl6e1uxDUztu58PDnWw1sG
    ggE0w0gBXVVI3Dz21GwEWXMeC7qxh8V4lR/5Tp28a7VM5r8WiX5OLAKmejzSNk6GNbFB
    RAb/4XDrZOkbQ+XBnc6PijJwgZkOWkuSQq4g7q/uyqgovRDTmpy2GB2cXDHZhZrtF/tl
    C6z0fXXMl75uJrXCV8R86uWk6IE+xBHGENy00ZsnfZmlKSyP9v9iOgd7BSWR6qhH9QmH
    KpiAkfUFu0SRy+0Yo0XvfhunwlatvDK9dRADIBBySCjJx05uLCBKVMVEp797h0YC1QBX
    Hjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339129;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Gthy3JZsd0POCax8iakG2TwMg0evFgfpOwFOAF4TfGU=;
    b=OIxGCXWXBRM8TQ0arBmYXi0iUmNH0KTrIJTF40U0/mfTFHE9sfrNt5L34/eqOshA/p
    Nu9rfTA6Cn/9fh9baQwgDO7oNFX4+yMOO/uzDp/lU1iy5bbxDeZqBdDtvKTiZV+8FuUB
    y0aJjREap5C9HMXMIf54nS2xX/7+MMNykC4JaZivWwHHgEVcPoyFyrQtdFyPhqdBKApq
    zfS3RyxuvKDWmMwPRL4YVHsgPf37OLbK0oHEMfK34sDk+a++egG2pCJRE8Iql+xO+pSs
    JqF0Ly9IoTAw/a21azfUWgM2yI/XQV5Tj9prZBvYdUcYteuoVGlAWNYZT31Paq4WSQi9
    LJhw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339129;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Gthy3JZsd0POCax8iakG2TwMg0evFgfpOwFOAF4TfGU=;
    b=KpgqbqGlCBEbqsIh5Z5cnOA9nM8SvKhW1z4HpDvLrq56BdRL3uh2MeeFPcYb7Eaaif
    gixvA/zzA7054hPv/qDNNUx9vLqor+1GNmC/nzxt/mm/YtQ8OOiAsQ7OVnqcY3k1dG+3
    ylM6zaZKu1WsF/4y/+VTWOU0z0NcB4Mh3294xL7JEMdNUb0mazI1XecGKTNrpAMArraa
    EY9wPYMjHEaPg4qQsRXeQv3WwxfU25frVHyiJRTxIeoVNRe5rEVWugcPqw1yvlkZHwPZ
    12V8Uuyj1xcGbxLYsSnWTp4qC2WJnnPU9Lx6Bh0l9WeBI78LCrbIViaGenSlW/j4VECM
    TOaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696339129;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Gthy3JZsd0POCax8iakG2TwMg0evFgfpOwFOAF4TfGU=;
    b=DKuerXdB9UpbvEy5/to8ka0g/S5knTp24S+f3VVpez6j1EOLt8x/FNCqbE2XNjw5wo
    uuGsMjzl7cSS1/tGCyBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z93DIn2OQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Oct 2023 15:18:49 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 03 Oct 2023 15:18:32 +0200
Subject: [PATCH v2 14/14] arm64: dts: qcom: msm8939-samsung-a7: Add sound
 and modem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-msm8916-modem-v2-14-61b684be55c0@gerhold.net>
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

From: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>

Enable sound and modem for the Samsung A7. The setup is similar to most
MSM8916 devices, i.e.:

 - QDSP6 audio
 - Earpiece/headphones/microphones via digital/analog codec in
   MSM8916/PM8916
 - WWAN Internet via BAM-DMUX

except for the same differences as the MSM8916-based Samsung A2015
devices:

 - NXP TFA9895 codec for speaker on Quaternary MI2S
 - Samsung-specific audio jack detection (not supported yet)

Signed-off-by: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
[Stephan: Add consistent commit message, minor refactoring]
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts | 70 +++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
index fccd8fec8b8f..aa6c39482a2f 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
@@ -3,10 +3,12 @@
 /dts-v1/;
 
 #include "msm8939-pm8916.dtsi"
+#include "msm8916-modem-qdsp6.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/sound/apq8016-lpass.h>
 
 / {
 	model = "Samsung Galaxy A7 (2015)";
@@ -287,6 +289,18 @@ muic: extcon@25 {
 	};
 };
 
+&blsp_i2c2 {
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
 &blsp_i2c5 {
 	status = "okay";
 
@@ -309,6 +323,29 @@ &blsp_uart2 {
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
+	reg = <0x0 0x86800000 0x0 0x5800000>;
+};
+
 &pm8916_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 	status = "okay";
@@ -321,6 +358,13 @@ pm8916_l17: l17 {
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
@@ -335,6 +379,32 @@ &sdhc_2 {
 	status = "okay";
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
 	extcon = <&muic>, <&muic>;
 	status = "okay";

-- 
2.42.0


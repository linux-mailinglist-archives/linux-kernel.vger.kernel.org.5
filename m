Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F777AF14D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbjIZQwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjIZQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:52:04 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87035136;
        Tue, 26 Sep 2023 09:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695747101; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oX0OUl60dqkGoVI54R7HrEoRF04f6UnPz6Y8x5nxA4PGCc8BafGVmfqPGNo/YV1Yel
    eySgDh9M3pIQ8v14bnXSeXSUm/0/Ym/xSMSCe6fCrgFHmAIvYvbDguHQRQbOoDX85kRG
    Dz2V2PSp8ordMPy17avmBAJHajOEsKWfbZX32/N6wLj8KYYe/PU3iHuP5KdTMsXq9BDp
    4sW9aU807i8IcfSMfuy9Vf3dy9sgJvqbAy72RoNh9Fcuhai+/h68QPnOa+VpauafXKs0
    oqUPYFwBvGW4vxlwCpDeC3DZB2IQNXFDYkaQI+BALtP1EtFyMzOiNCEK2coHCrRMNOwM
    x8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695747101;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=A/XrVYjcUCNSKSvfCQZickf7SKDX4aDHb6KOg+W+CCo=;
    b=GF6ucFMhmQXy2sl3bo0J6xsMwDFf1CHSCn+obpe4CyTPf9NNqOMocH5cBLlj0FAuiO
    y4ocj5CrZADOaB/l+VSCUCzh18zPxyHiyV3+nStxynC267yk9mmWDZ33pl22EN1HC1jA
    g8rXHveREBVdy1qG9ajvB5eMDHgVrHfrMfPIgccfCO+kwCAr1Fqb7WiGJ4781SOGjYQJ
    yiQtjH0rGt5yc+lC1nEHvXO4F7Cko9FDoxGwWsgcgkErv8qCLy3FVD99kszUHNHeqb/T
    mEMRu9qDjjKcQXH9hpEEqmUfrbEb7wINzW4mOcHtwL0zsz02pePMcIemSsi7uOrMDXTf
    OKpw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695747101;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=A/XrVYjcUCNSKSvfCQZickf7SKDX4aDHb6KOg+W+CCo=;
    b=deevSVjmGYXJYdSJ5qhdXybM8kGnZhulYYmEd7SZnWdLHrSutbOoEGwDDge5OVzsB3
    hVht+7bAJJECkRlzJWtQ+zsqXH/vu4CQ1tNkUMaiSLszOHjaA/3Yu3KXxYm1b9xGnaE3
    VSsSDt0jw6heR8hkhF4bnBAFctuMEUiQz7CmXK+Yn3ApBX+RXjTe6Sxyr4KtWu4APquj
    3Pta4/NforJvntynXzHCbtDVFDEDmEPro5qFA+8DEnJKZXLCErez8zIXQlTkzF9kaVoH
    B/r+fy97B7LD123yrs78uMiykJS78YEPXh5UaApj7q4++k2vEAm7/xpbQM5ZLPmJX6ov
    9JGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695747101;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=A/XrVYjcUCNSKSvfCQZickf7SKDX4aDHb6KOg+W+CCo=;
    b=3iq7OZgpqQgWUjkQ6WtVAavIeXJZhZyeuPqsqoeqgNeOlFtEtLejP6NvJnqixJskxw
    WATb2Bp8ui6wlurOdKDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOH+nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QGpfg5k
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 18:51:41 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 26 Sep 2023 18:51:27 +0200
Subject: [PATCH 13/13] arm64: dts: qcom: msm8939-samsung-a7: Add sound and
 modem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-msm8916-modem-v1-13-398eec74bac9@gerhold.net>
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
[Stephan: Add consistent commit message]
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
index fccd8fec8b8f..4951b3e265d2 100644
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
 
@@ -309,6 +323,17 @@ &blsp_uart2 {
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
+	reg = <0x0 0x86800000 0x0 0x5800000>;
+};
+
 &pm8916_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 	status = "okay";
@@ -321,6 +346,13 @@ pm8916_l17: l17 {
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
@@ -335,6 +367,28 @@ &sdhc_2 {
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
+	status = "okay";
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
 	extcon = <&muic>, <&muic>;
 	status = "okay";

-- 
2.42.0


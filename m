Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29077AA2FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjIUVpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjIUVpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:45:16 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855CD6E450;
        Thu, 21 Sep 2023 11:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695322581; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=La2lI10AHReOVsOLEaAaBCfMUjgo33GwclpWxr4VBFvkLnkQ2vKzeUbIMVnqnAEBsX
    nUpLN6FEtys2th9w+8DqgZki8xBXI4wpgGJpmtIsWpECHi0dUyy+tSLwIaJG9w4dvDSx
    5rtryHxx3lwDP9N8zm30XYVgL2HArbRAUjJTjzx1Vh5S9+hY6HerJn0SjDHJcDO5D2La
    73Nh+pteXR7SLLtTb8yDBjpQOFKhy/67Zt+C3uioWN53/PGHxJdfF7BZRAP0GmqqeAV5
    C3bWwBmtnXoYms1pGg4sRxRjv3CXN+cLXfQn5qBIyWF7Ulk9cpojEa1wdAV81g4VE73W
    msYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695322581;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=sNsuc/cVbMbRdNBjQCRPjm92mdLb+04XdjQTrvYtj8M=;
    b=ZC3+98An6vfI2VcwMX3OifTOdBHm7yoBgtW0BtiY9cEzU4rphkS19KSIzAtByv2RVv
    LfNWjkDmeZg2ES/OuRATLfjxi6ZamSidSKuD2k7d4tn8v8iA0Xbocj0ccC2UbaQ34dWn
    1F+qo7NkQ9kAbZ3OPEC8703wc/nc/yuLCzV9FDB1w58rvYcT1dXKWFPSIlQc0Oh2p+8/
    4ou94KAHofUrQMZn9KNUMhyn+y1umEIrac3uDgl1rr5mN1GWox3fUcr9JH5LOpaRvXoV
    f2Yxf+Jgb2/zrAD4Kn0k76QmMHAl4NcqQNoMUGdE7nDBd4pd3ipytpsnjLilEsN0J9O/
    gUeg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695322581;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=sNsuc/cVbMbRdNBjQCRPjm92mdLb+04XdjQTrvYtj8M=;
    b=ZE/0E8s4eMz3vvSA5W7eNzbQg94Q7l6GHSPv1ig4Cs13Ywm8RkYrnBW05xfSbwznwj
    KyQMeVR/RXFOBNjmkBQ6F3xn19ZSqXvEBRrQLApjHPXUqypENJBbn7yzMHvWQVcqV3aE
    H+Ll9m7Do3ADFvavYy16Z5ZccDw2zExbzL+GU1+MzjgRzBhzrfFPR9dlalDU4If2h55J
    Dw3rSOnduK6sxZ0I++BZD/9DTTdr75WA1K6hLouj1Swot8wPKABHpMI6U4NjgUr6thJ7
    kiZwlxMvRwim3QOVFhshDuRUBTIDCBjQknQwwV3SursnyUfLNvSzqEGWanTWeHfNbDHy
    04/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695322581;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=sNsuc/cVbMbRdNBjQCRPjm92mdLb+04XdjQTrvYtj8M=;
    b=lmGhp4aKpj9euBg4cgB7QjhiyKCs2KWh0TNZPDOWM3ZTXmRDvpwM59jooQjxrLsURi
    2kJioi6eRiElBC9sybAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4p39TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8LIuLRS1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 21 Sep 2023 20:56:21 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 21 Sep 2023 20:56:06 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: msm8916-*: Fix alphabetic node order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230921-msm8916-rmem-fixups-v1-3-34d2b6e721cf@gerhold.net>
References: <20230921-msm8916-rmem-fixups-v1-0-34d2b6e721cf@gerhold.net>
In-Reply-To: <20230921-msm8916-rmem-fixups-v1-0-34d2b6e721cf@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a couple of instances of incorrectly sorted nodes in the MSM8916
boards. They should be ordered alphabetically for consistency.

No functional change.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changing the RGB LED node order to BGR is a bit funny but this is how
alphabetic ordering works. :-)
---
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts      |  8 ++---
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts      | 10 +++---
 .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  | 38 +++++++++++-----------
 arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts    |  8 ++---
 arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts  |  8 ++---
 .../arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts |  8 ++---
 6 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index aa4c1ab1e673..fade93c55299 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -58,10 +58,6 @@ usb_id: usb-id {
 	};
 };
 
-&blsp_uart2 {
-	status = "okay";
-};
-
 &blsp_i2c4 {
 	status = "okay";
 
@@ -153,6 +149,10 @@ led@1 {
 	};
 };
 
+&blsp_uart2 {
+	status = "okay";
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
index f5a808369518..3b934f5eba47 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
@@ -49,11 +49,6 @@ reg_key_led: regulator-key-led {
 	};
 };
 
-&touchkey {
-	vcc-supply = <&reg_touch_key>;
-	vdd-supply = <&reg_key_led>;
-};
-
 &accelerometer {
 	mount-matrix = "0", "1", "0",
 		       "1", "0", "0",
@@ -108,6 +103,11 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&touchkey {
+	vcc-supply = <&reg_touch_key>;
+	vdd-supply = <&reg_key_led>;
+};
+
 &vibrator {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index c19cf20d7427..6a16eb5ce07b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -65,25 +65,6 @@ hall-sensor-switch {
 	};
 };
 
-&blsp_i2c4 {
-	status = "okay";
-
-	fuelgauge@36 {
-		compatible = "maxim,max77849-battery";
-		reg = <0x36>;
-
-		maxim,rsns-microohm = <10000>;
-		maxim,over-heat-temp = <600>;
-		maxim,over-volt = <4400>;
-
-		interrupt-parent = <&tlmm>;
-		interrupts = <121 IRQ_TYPE_EDGE_FALLING>;
-
-		pinctrl-0 = <&fuelgauge_int_default>;
-		pinctrl-names = "default";
-	};
-};
-
 &blsp_i2c2 {
 	status = "okay";
 
@@ -112,6 +93,25 @@ accelerometer@1d {
 	};
 };
 
+&blsp_i2c4 {
+	status = "okay";
+
+	fuelgauge@36 {
+		compatible = "maxim,max77849-battery";
+		reg = <0x36>;
+
+		maxim,rsns-microohm = <10000>;
+		maxim,over-heat-temp = <600>;
+		maxim,over-volt = <4400>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <121 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-0 = <&fuelgauge_int_default>;
+		pinctrl-names = "default";
+	};
+};
+
 &blsp_uart2 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts b/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
index 6fe1850ba20e..f34997500891 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
@@ -13,16 +13,16 @@ &button_restart {
 	gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
 };
 
-&led_r {
-	gpios = <&tlmm 82 GPIO_ACTIVE_HIGH>;
+&led_b {
+	gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
 };
 
 &led_g {
 	gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
 };
 
-&led_b {
-	gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
+&led_r {
+	gpios = <&tlmm 82 GPIO_ACTIVE_HIGH>;
 };
 
 &button_default {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts b/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
index 16d4a91022be..6cb3911ba1c9 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
@@ -13,16 +13,16 @@ &button_restart {
 	gpios = <&tlmm 37 GPIO_ACTIVE_HIGH>;
 };
 
-&led_r {
-	gpios = <&tlmm 22 GPIO_ACTIVE_HIGH>;
+&led_b {
+	gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
 };
 
 &led_g {
 	gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
 };
 
-&led_b {
-	gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
+&led_r {
+	gpios = <&tlmm 22 GPIO_ACTIVE_HIGH>;
 };
 
 &mpss {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts b/arch/arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts
index 5e6ba8c58bb5..a98efcfe78b7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts
@@ -13,16 +13,16 @@ &button_restart {
 	gpios = <&tlmm 23 GPIO_ACTIVE_LOW>;
 };
 
-&led_r {
-	gpios = <&tlmm 7 GPIO_ACTIVE_HIGH>;
+&led_b {
+	gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
 };
 
 &led_g {
 	gpios = <&tlmm 8 GPIO_ACTIVE_HIGH>;
 };
 
-&led_b {
-	gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+&led_r {
+	gpios = <&tlmm 7 GPIO_ACTIVE_HIGH>;
 };
 
 &button_default {

-- 
2.42.0


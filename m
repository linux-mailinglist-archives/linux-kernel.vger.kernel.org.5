Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF06B804E11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344898AbjLEJjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjLEJjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:39:14 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A83D3;
        Tue,  5 Dec 2023 01:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1701769153; x=1702028353;
        bh=QcKHROOlD70tSBgeyrg9Gb4CwNJ1/AK3OXnbcfoLKSw=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=GG6MAauxDb9EbHo9vRQxPQHAWkw7QFpwTHDgi4T/g0DZBl40HUjFF7ZyJoDb/3q5k
         JfgLNq8g33S6BaIt+WJdNRLMzgb/38qgGhFFx9b5o1dU5yhKHipvQX6etTZOyu6BLF
         iiPOj3lK3W9s81OlX91b659AbTYnNgm/d5SU/7gfo5ceQOwUE+2hnVkbOTsg7vQGzX
         wQjhnVt+Ggzz8/ZA01QhyervVe4ESGFmmLJbDexFAMiy8TAa1rST6Vk6IIo3wrQc1+
         RQ0h2l5mFdjHQhrJNITu5/THYktmHgWyeIxvwHW6mpBtfTfOvBiwFw6eHS9uLnBLaU
         3App9X+uRSdxw==
Date:   Tue, 05 Dec 2023 09:38:57 +0000
To:     linux-kernel@vger.kernel.org
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH] arm64: dts: qcom: msm8916/39-samsung-a2015: Add PMIC and charger
Message-ID: <20231205093841.24325-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phones listed below have Richtek RT5033 PMIC and charger.
Add them to the device trees.

- Samsung Galaxy A3/A5/A7 2015
- Samsung Galaxy E5/E7
- Samsung Galaxy Grand Max

Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 .../qcom/msm8916-samsung-a2015-common.dtsi    | 59 +++++++++++++++++-
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts |  6 ++
 .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts |  6 ++
 .../qcom/msm8916-samsung-e2015-common.dtsi    |  6 ++
 .../boot/dts/qcom/msm8916-samsung-e5.dts      |  6 ++
 .../boot/dts/qcom/msm8916-samsung-e7.dts      |  7 +++
 .../dts/qcom/msm8916-samsung-grandmax.dts     |  6 ++
 .../boot/dts/qcom/msm8939-samsung-a7.dts      | 62 ++++++++++++++++++-
 8 files changed, 156 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 2937495940ea..e6355e5e2177 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -28,6 +28,12 @@ tz-apps@85500000 {
 =09=09};
 =09};
=20
+=09battery: battery {
+=09=09compatible =3D "simple-battery";
+=09=09precharge-current-microamp =3D <450000>;
+=09=09precharge-upper-limit-microvolt =3D <3500000>;
+=09};
+
 =09clk_pwm: pwm {
 =09=09compatible =3D "clk-pwm";
 =09=09#pwm-cells =3D <2>;
@@ -128,6 +134,12 @@ muic: extcon@25 {
=20
 =09=09=09pinctrl-names =3D "default";
 =09=09=09pinctrl-0 =3D <&muic_int_default>;
+
+=09=09=09usb_con: connector {
+=09=09=09=09compatible =3D "usb-b-connector";
+=09=09=09=09label =3D "micro-USB";
+=09=09=09=09type =3D "micro";
+=09=09=09};
 =09=09};
 =09};
=20
@@ -239,7 +251,7 @@ magnetometer@12 {
 &blsp_i2c4 {
 =09status =3D "okay";
=20
-=09battery@35 {
+=09fuel-gauge@35 {
 =09=09compatible =3D "richtek,rt5033-battery";
 =09=09reg =3D <0x35>;
 =09=09interrupt-parent =3D <&tlmm>;
@@ -247,6 +259,44 @@ battery@35 {
=20
 =09=09pinctrl-names =3D "default";
 =09=09pinctrl-0 =3D <&fg_alert_default>;
+
+=09=09power-supplies =3D <&charger>;
+=09};
+};
+
+&blsp_i2c6 {
+=09status =3D "okay";
+
+=09pmic@34 {
+=09=09compatible =3D "richtek,rt5033";
+=09=09reg =3D <0x34>;
+
+=09=09interrupts-extended =3D <&tlmm 62 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09pinctrl-0 =3D <&pmic_int_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09regulators {
+=09=09=09rt5033_reg_safe_ldo: SAFE_LDO {
+=09=09=09=09regulator-min-microvolt =3D <4900000>;
+=09=09=09=09regulator-max-microvolt =3D <4900000>;
+=09=09=09=09regulator-always-on;
+=09=09=09};
+
+=09=09=09/*
+=09=09=09 * Needed for camera, but not used yet.
+=09=09=09 * Define empty nodes to allow disabling the unused
+=09=09=09 * regulators.
+=09=09=09 */
+=09=09=09LDO {};
+=09=09=09BUCK {};
+=09=09};
+
+=09=09charger: charger {
+=09=09=09compatible =3D "richtek,rt5033-charger";
+=09=09=09monitored-battery =3D <&battery>;
+=09=09=09richtek,usb-connector =3D <&usb_con>;
+=09=09};
 =09};
 };
=20
@@ -470,6 +520,13 @@ nfc_i2c_default: nfc-i2c-default-state {
 =09=09bias-disable;
 =09};
=20
+=09pmic_int_default: pmic-int-default-state {
+=09=09pins =3D "gpio62";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09sdc2_cd_default: sdc2-cd-default-state {
 =09=09pins =3D "gpio38";
 =09=09function =3D "gpio";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts b/arch/ar=
m64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
index 3b934f5eba47..906d31f1ea21 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
@@ -55,6 +55,12 @@ &accelerometer {
 =09=09       "0", "0", "1";
 };
=20
+&battery {
+=09charge-term-current-microamp =3D <150000>;
+=09constant-charge-current-max-microamp =3D <1000000>;
+=09constant-charge-voltage-max-microvolt =3D <4350000>;
+};
+
 &blsp_i2c5 {
 =09status =3D "okay";
=20
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts b/arch/ar=
m64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
index 391befa22bb4..fe39be7a742b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
@@ -29,6 +29,12 @@ &accelerometer {
 =09=09=09"0", "0", "1";
 };
=20
+&battery {
+=09charge-term-current-microamp =3D <200000>;
+=09constant-charge-current-max-microamp =3D <1500000>;
+=09constant-charge-voltage-max-microvolt =3D <4350000>;
+};
+
 &blsp_i2c5 {
 =09status =3D "okay";
=20
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
index 3c49dac92d2d..c50f81a68897 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
@@ -23,6 +23,12 @@ muic: extcon@14 {
=20
 =09=09=09pinctrl-names =3D "default";
 =09=09=09pinctrl-0 =3D <&muic_int_default>;
+
+=09=09=09usb_con: connector {
+=09=09=09=09compatible =3D "usb-b-connector";
+=09=09=09=09label =3D "micro-USB";
+=09=09=09=09type =3D "micro";
+=09=09=09};
 =09=09};
 =09};
=20
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e5.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-e5.dts
index fad2535255f7..800cb1038da0 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e5.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e5.dts
@@ -23,6 +23,12 @@ / {
 =09chassis-type =3D "handset";
 };
=20
+&battery {
+=09charge-term-current-microamp =3D <200000>;
+=09constant-charge-current-max-microamp =3D <1500000>;
+=09constant-charge-voltage-max-microvolt =3D <4350000>;
+};
+
 &blsp_i2c5 {
 =09status =3D "okay";
=20
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e7.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-e7.dts
index b412b61ca258..ec1debd2e245 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e7.dts
@@ -23,6 +23,13 @@ / {
 =09chassis-type =3D "handset";
 };
=20
+&battery {
+=09charge-term-current-microamp =3D <200000>;
+=09constant-charge-current-max-microamp =3D <1500000>;
+=09constant-charge-voltage-max-microvolt =3D <4350000>;
+};
+
+
 &pm8916_l17 {
 =09regulator-min-microvolt =3D <3000000>;
 =09regulator-max-microvolt =3D <3000000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts b/arch/a=
rm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
index 5882b3a593b8..135df1739dbd 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
@@ -41,6 +41,12 @@ led-keyled {
 =09};
 };
=20
+&battery {
+=09charge-term-current-microamp =3D <150000>;
+=09constant-charge-current-max-microamp =3D <1000000>;
+=09constant-charge-voltage-max-microvolt =3D <4400000>;
+};
+
 &reg_motor_vdd {
 =09gpio =3D <&tlmm 72 GPIO_ACTIVE_HIGH>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts b/arch/arm64/b=
oot/dts/qcom/msm8939-samsung-a7.dts
index aa6c39482a2f..91acdb160227 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
@@ -33,6 +33,15 @@ tz-apps@85500000 {
 =09=09};
 =09};
=20
+=09battery: battery {
+=09=09compatible =3D "simple-battery";
+=09=09charge-term-current-microamp =3D <150000>;
+=09=09constant-charge-current-max-microamp =3D <1500000>;
+=09=09constant-charge-voltage-max-microvolt =3D <4300000>;
+=09=09precharge-current-microamp =3D <450000>;
+=09=09precharge-upper-limit-microvolt =3D <3500000>;
+=09};
+
 =09gpio-hall-sensor {
 =09=09compatible =3D "gpio-keys";
=20
@@ -82,7 +91,7 @@ i2c-fg {
 =09=09#address-cells =3D <1>;
 =09=09#size-cells =3D <0>;
=20
-=09=09battery@35 {
+=09=09fuel-gauge@35 {
 =09=09=09compatible =3D "richtek,rt5033-battery";
 =09=09=09reg =3D <0x35>;
=20
@@ -91,6 +100,8 @@ battery@35 {
=20
 =09=09=09pinctrl-0 =3D <&fg_alert_default>;
 =09=09=09pinctrl-names =3D "default";
+
+=09=09=09power-supplies =3D <&charger>;
 =09=09};
 =09};
=20
@@ -286,6 +297,12 @@ muic: extcon@25 {
=20
 =09=09pinctrl-0 =3D <&muic_int_default>;
 =09=09pinctrl-names =3D "default";
+
+=09=09usb_con: connector {
+=09=09=09compatible =3D "usb-b-connector";
+=09=09=09label =3D "micro-USB";
+=09=09=09type =3D "micro";
+=09=09};
 =09};
 };
=20
@@ -319,6 +336,42 @@ touchscreen@24 {
 =09};
 };
=20
+&blsp_i2c6 {
+=09status =3D "okay";
+
+=09pmic@34 {
+=09=09compatible =3D "richtek,rt5033";
+=09=09reg =3D <0x34>;
+
+=09=09interrupts-extended =3D <&tlmm 62 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09pinctrl-0 =3D <&pmic_int_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09regulators {
+=09=09=09rt5033_reg_safe_ldo: SAFE_LDO {
+=09=09=09=09regulator-min-microvolt =3D <4900000>;
+=09=09=09=09regulator-max-microvolt =3D <4900000>;
+=09=09=09=09regulator-always-on;
+=09=09=09};
+
+=09=09=09/*
+=09=09=09 * Needed for camera, but not used yet.
+=09=09=09 * Define empty nodes to allow disabling the unused
+=09=09=09 * regulators.
+=09=09=09 */
+=09=09=09LDO {};
+=09=09=09BUCK {};
+=09=09};
+
+=09=09charger: charger {
+=09=09=09compatible =3D "richtek,rt5033-charger";
+=09=09=09monitored-battery =3D <&battery>;
+=09=09=09richtek,usb-connector =3D <&usb_con>;
+=09=09};
+=09};
+};
+
 &blsp_uart2 {
 =09status =3D "okay";
 };
@@ -504,6 +557,13 @@ nfc_i2c_default: nfc-i2c-default-state {
 =09=09bias-disable;
 =09};
=20
+=09pmic_int_default: pmic-int-default-state {
+=09=09pins =3D "gpio62";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09reg_tsp_en_default: reg-tsp-en-default-state {
 =09=09pins =3D "gpio73";
 =09=09function =3D "gpio";
--=20
2.39.2



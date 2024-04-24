Return-Path: <linux-kernel+bounces-157082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDFF8B0C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6C6B242B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CEB15E809;
	Wed, 24 Apr 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="GenqAOoC"
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811481E511;
	Wed, 24 Apr 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969145; cv=none; b=RhTVb5kp3LxZTCWW5bYfEjT/LEsejdqNjpBvh6h3uviZsq76z7UyXMklTXAIwEaA19owp937TB3wEvMUovbeNfmoGqwgP2ejwVOs+t/LPLQs7KnT1Raz/TAb6x008QLzpYJL7QVWUI5GdQr8YV+uKdbRqzZQH3V9iTBnm8uJ1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969145; c=relaxed/simple;
	bh=OcXTtqLaYOxzjC/irdoJBlXwf4PVEJPy2lAV3KR7dys=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=G26HGL0dtnZti0DiHar26syEyeZjJ8DXxni5/lFoK8JnggVXBsqICETnWzQ4oT17U/mhLl90Zbzw+V28eFOVvBzfpB7PXraudXyLH7oE+RWHqBoxv14FDf7GXXV0K8aCIrkIYTyUGHgLq2x9hkpRrOafTnAKLSCR+8c1ikGtazI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=GenqAOoC; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1713969135; x=1714228335;
	bh=a90d4TBjcJascEIB8j4K3VPbbCBfHLdOQNkr92BO7lU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GenqAOoCTpOKGa3FEgK0rPfVlqnG6dl0FDxoYXGDJ3+gEceU8X229p8v6QGGHwz4W
	 wKksJclsFqr8BXvnyXq59+6tNBFbBHvfdUTVH4o0jWRHfg9JLTY/j4tLPf6uPNiCy/
	 jVI0+ZRXUGh51z+WwI5b63hzo9JdqpDtZ3i+wV1DLnZ2e0y6JIBAVYkGDNNLhVuxyT
	 pe2qGCzxNIwvkfaJOTpoUDP1DXqiiqV5iRBop3QFDLJmk2UP4waW9AOxgcz9M/DUeo
	 8Ji8I4rNPz9zMSrVnhxVDd9uBKc2K+F/BCCvrksE4XtOKu43eLcsH4gOtQ67I8bslp
	 rNWVk28OQgboA==
Date: Wed, 24 Apr 2024 14:32:10 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Jakob Hauser <jahau@rocketmail.com>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [RESEND PATCH v3] arm64: dts: qcom: msm8916/39-samsung-a2015: Add PMIC and charger
Message-ID: <20240424143158.24358-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
X-Pm-Message-ID: c8244e3c633f411f6facc3e5d95595234df5a988
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The phones listed below have Richtek RT5033 PMIC and charger.
Add them to the device trees.

- Samsung Galaxy A3/A5/A7 2015
- Samsung Galaxy E5/E7
- Samsung Galaxy Grand Max

Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
v2: Split the connector into another patch
v3: Skip applied conntector patch
RESEND v3: Fix threading
---
 .../qcom/msm8916-samsung-a2015-common.dtsi    | 53 +++++++++++++++++-
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts |  6 ++
 .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts |  6 ++
 .../boot/dts/qcom/msm8916-samsung-e5.dts      |  6 ++
 .../boot/dts/qcom/msm8916-samsung-e7.dts      |  7 +++
 .../dts/qcom/msm8916-samsung-grandmax.dts     |  6 ++
 .../boot/dts/qcom/msm8939-samsung-a7.dts      | 56 ++++++++++++++++++-
 7 files changed, 138 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 4bbbee80b5e4..e6355e5e2177 100644
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
@@ -245,7 +251,7 @@ magnetometer@12 {
 &blsp_i2c4 {
 =09status =3D "okay";
=20
-=09battery@35 {
+=09fuel-gauge@35 {
 =09=09compatible =3D "richtek,rt5033-battery";
 =09=09reg =3D <0x35>;
 =09=09interrupt-parent =3D <&tlmm>;
@@ -253,6 +259,44 @@ battery@35 {
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
@@ -476,6 +520,13 @@ nfc_i2c_default: nfc-i2c-default-state {
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
index 0c599e71a464..91acdb160227 100644
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
@@ -325,6 +336,42 @@ touchscreen@24 {
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
@@ -510,6 +557,13 @@ nfc_i2c_default: nfc-i2c-default-state {
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




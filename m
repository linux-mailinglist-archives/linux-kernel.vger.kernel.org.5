Return-Path: <linux-kernel+bounces-132951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FC5899C65
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8672228379C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBD216C857;
	Fri,  5 Apr 2024 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="We98t24d"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6E16C842;
	Fri,  5 Apr 2024 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318933; cv=none; b=eCn+vWaxxa9s+vsdriFtFc4XUvm8NViq/S6UOiOON2OOnPTdRZ7WNJ5Awx7R9LQoOuyqHm7ce777ViSkIfTeIDfaZSBMmohD9Tfmc4u2dhXH3LGx8+H8dweWtx2pwngltSkBKEKBZB/8Ujmu68SZPC7DSJoFpnNAKEr67NNSQ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318933; c=relaxed/simple;
	bh=a47454EdCwraOlJHbDpA8w0pS4WuEE+DQis9OxZ5xXg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HT1W1EWoKgYj4G63vetBnVeJEDLDyHKUdFMVG/NMlyyD1/n6hmDLUv6ai93OKE0EU58mswAz9HNpHEBif5XZKHNanu+mEIq5iwvwLQ7uKAvkE+4o7J35vqmUJ4BF8tBn2X6f83fVgluGl8wL+uSF6kXQDs3NlR8SRay5QENSULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=We98t24d; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1712318919; x=1712578119;
	bh=zZR/8orMxcDNlLMhBF0vomamSOmdppTI1jFoJaHA6aE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=We98t24dS2Po1jPmx5qHu0E+UfQuwBn6M8iGyckVjrCTBSkomf71Ae8z6cx6XR+Iq
	 ASfGYuHP7i30456fQvH8ij8D5OK5lf2skh9IKf6DKwLTVOalb5qZoUD0KFM35Ot1CN
	 uVYENvP+rqceu3Jup1ujgVoq00/DIXSS1J34TSKsxBPYzAMWk0DDqfEsep1ILrFbP8
	 vechrwBru0ya6lJ+7WRJZIIeIJ4d8BQmb0NdwnDOQ1yXt1SXpwR+A1zR3og0DqgI3k
	 1XEMlfLssw4m6g1kKWN7WaLsjQ0x618szXWFROhgtNDsiPg9vwhNKyu09rH1/2OXUL
	 VkCJC37sH+X+A==
Date: Fri, 05 Apr 2024 12:08:35 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Joe Mason <buddyjojo06@outlook.com>, Raymond Hackley <raymondhackley@protonmail.com>
Subject: [PATCH 1/3] arm64: dts: qcom: msm8916-samsung-fortuna: Add BMC150 accelerometer/magnetometer
Message-ID: <20240405120803.20754-2-raymondhackley@protonmail.com>
In-Reply-To: <20240405120803.20754-1-raymondhackley@protonmail.com>
References: <20240405120803.20754-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Joe Mason <buddyjojo06@outlook.com>

Some Grand Prime use a Bosch BMC150 accelerometer/magnetometer combo.
The chip provides two separate I2C devices for the accelerometer
and magnetometer that are already supported by the bmc150-accel
and bmc150-magn driver.

Signed-off-by: Joe Mason <buddyjojo06@outlook.com>
[Stephan: Move sensors to common dtsi, disabled by default]
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
[Raymond: Add it to grandprimelte. Use interrupts-extended]
Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 .../qcom/msm8916-samsung-fortuna-common.dtsi  | 44 +++++++++++++++++++
 .../dts/qcom/msm8916-samsung-gprimeltecan.dts |  8 ++++
 .../qcom/msm8916-samsung-grandprimelte.dts    |  8 ++++
 3 files changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi b=
/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
index 5e933fb8b363..b6e1fe8b0056 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
@@ -117,6 +117,43 @@ muic: extcon@25 {
 =09};
 };
=20
+&blsp_i2c2 {
+=09/* Available sensors vary depending on model variant */
+=09status =3D "okay";
+
+=09bosch_accel: accelerometer@10 {
+=09=09compatible =3D "bosch,bmc150_accel";
+=09=09reg =3D <0x10>;
+=09=09interrupts-extended =3D <&tlmm 115 IRQ_TYPE_EDGE_RISING>;
+
+=09=09vdd-supply =3D <&pm8916_l5>;
+=09=09vddio-supply =3D <&pm8916_l5>;
+
+=09=09pinctrl-0 =3D <&accel_int_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09mount-matrix =3D "0", "-1", "0",
+=09=09=09      "-1",  "0", "0",
+=09=09=09       "0",  "0", "1";
+
+=09=09status =3D "disabled";
+=09};
+
+=09bosch_magn: magnetometer@12 {
+=09=09compatible =3D "bosch,bmc150_magn";
+=09=09reg =3D <0x12>;
+
+=09=09vdd-supply =3D <&pm8916_l5>;
+=09=09vddio-supply =3D <&pm8916_l5>;
+
+=09=09mount-matrix =3D "0", "-1", "0",
+=09=09=09      "-1",  "0", "0",
+=09=09=09       "0",  "0", "1";
+
+=09=09status =3D "disabled";
+=09};
+};
+
 &blsp_i2c4 {
 =09status =3D "okay";
=20
@@ -223,6 +260,13 @@ &wcnss_mem {
 };
=20
 &tlmm {
+=09accel_int_default: accel-int-default-state {
+=09=09pins =3D "gpio115";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09backlight_en_default: backlight-en-default-state {
 =09=09pins =3D "gpio98";
 =09=09function =3D "gpio";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts b/ar=
ch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts
index 9d65fa58ba92..4dc74e8bf1d8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts
@@ -21,6 +21,14 @@ tz-apps@85500000 {
 =09};
 };
=20
+&bosch_accel {
+=09status =3D "okay";
+};
+
+&bosch_magn {
+=09status =3D "okay";
+};
+
 &mpss_mem {
 =09/* Firmware for gprimeltecan needs more space */
 =09reg =3D <0x0 0x86800000 0x0 0x5400000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts
index a66ce4b13547..cffad734c4df 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts
@@ -10,6 +10,14 @@ / {
 =09chassis-type =3D "handset";
 };
=20
+&bosch_accel {
+=09status =3D "okay";
+};
+
+&bosch_magn {
+=09status =3D "okay";
+};
+
 &mpss_mem {
 =09/* Firmware for grandprimelte needs more space */
 =09reg =3D <0x0 0x86800000 0x0 0x5400000>;
--=20
2.39.2




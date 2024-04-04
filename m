Return-Path: <linux-kernel+bounces-131399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F4A898721
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A094C1C229B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4F12AAEA;
	Thu,  4 Apr 2024 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="a0KOPJNx"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072212AACD;
	Thu,  4 Apr 2024 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233080; cv=none; b=CwyudC9Tmb8ecBLdFlQSYUDxNSdm1gIIBkmo6dA2XelxV4ZMHgXdjsrpOylHVoOtirmdutCihGUH7nhuNKaHC4Iv2bx2CPtWZd2C195EGDUl0RK/G1ZAb5RcmaRmbsOGjHHQ6Di7ZUtmwLw2hbAlb8u8AKVzhFUzmIOHdv8m20E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233080; c=relaxed/simple;
	bh=PMo0OLo9NByjtxB884A1QBdj+5JMaimmtB5wEDa9g6M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vdloyq2+/iBHGCGTycBWdMbDswsFmFToaWf3kJZuT3bIRzNE+YIZ4XCKfa5q80AaxuXvnc8YsouHBFVtPDRo2j6Fi7VxfqbBveeOyAhAbJ1vPyNXvN/FmrBqSGYaOIEMdcS/3uqG38fk//o/xulc1QLVyygXHdZDADxKozbw2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=a0KOPJNx; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1712233068; x=1712492268;
	bh=ZsI0Kc59ub2NORBP4S91yZ4LzBptO868mH5JmTS46x4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=a0KOPJNxRpVAgGvQQYWcatFOR8SBFPE0fV8QtQzMPixtScHJ7r/KG7mzkKAtt2dTy
	 RwDZO/bqfdXeqqIaImfacf1YgwBlwkJ64Y9h1jKukUPxspVFXsysrKES1aW5giZUQE
	 WtrpGxzO0cBX/mkep9sUZ/sbmnj0NKwoZqJUEW+cWTPJGgsu9LsIizmV0HedQNTFaF
	 2rxfzjaH3caefISmiZic9IvFp+FimpOjlzwur0b07I/kiXycQUeiElY5OYLUWTJDDl
	 TV5tCMviY2m+UzQ8nWuOTr8ZISACOorym5U2idXPJtU8c+KKf1WA7rfd890ZcznAlt
	 GPF1h6zDn2/uQ==
Date: Thu, 04 Apr 2024 12:17:44 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Joe Mason <buddyjojo06@outlook.com>
Subject: [PATCH v3 1/2] arm64: dts: qcom: msm8916-samsung-fortuna: Add touchscreen
Message-ID: <20240404121703.17086-2-raymondhackley@protonmail.com>
In-Reply-To: <20240404121703.17086-1-raymondhackley@protonmail.com>
References: <20240404121703.17086-1-raymondhackley@protonmail.com>
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

Like msm8916-samsung-a3u-eur, the Grand Prime uses a Zinitix BT541
touchscreen. Add it together with the necessary fixed-regulator to the
device tree.

Signed-off-by: Joe Mason <buddyjojo06@outlook.com>
[Raymond: Move to fortuna-common. Use interrupts-extended]
Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../qcom/msm8916-samsung-fortuna-common.dtsi  | 47 +++++++++++++++++++
 .../qcom/msm8916-samsung-rossa-common.dtsi    |  3 ++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi b=
/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
index c2800ad2dd5b..6c66a24ef1af 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
@@ -66,6 +66,19 @@ reg_motor_vdd: regulator-motor-vdd {
 =09=09pinctrl-0 =3D <&motor_en_default>;
 =09=09pinctrl-names =3D "default";
 =09};
+
+=09reg_vdd_tsp_a: regulator-vdd-tsp-a {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "vdd_tsp_a";
+=09=09regulator-min-microvolt =3D <3000000>;
+=09=09regulator-max-microvolt =3D <3000000>;
+
+=09=09gpio =3D <&tlmm 73 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-0 =3D <&tsp_en_default>;
+=09=09pinctrl-names =3D "default";
+=09};
 };
=20
 &blsp_i2c1 {
@@ -94,6 +107,26 @@ fuel-gauge@35 {
 =09};
 };
=20
+&blsp_i2c5 {
+=09status =3D "okay";
+
+=09touchscreen: touchscreen@20 {
+=09=09compatible =3D "zinitix,bt541";
+=09=09reg =3D <0x20>;
+
+=09=09interrupts-extended =3D <&tlmm 13 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09touchscreen-size-x =3D <540>;
+=09=09touchscreen-size-y =3D <960>;
+
+=09=09vcca-supply =3D <&reg_vdd_tsp_a>;
+=09=09vdd-supply =3D <&pm8916_l6>;
+
+=09=09pinctrl-0 =3D <&tsp_int_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+};
+
 &blsp_uart2 {
 =09status =3D "okay";
 };
@@ -200,4 +233,18 @@ sdc2_cd_default: sdc2-cd-default-state {
 =09=09drive-strength =3D <2>;
 =09=09bias-disable;
 =09};
+
+=09tsp_en_default: tsp-en-default-state {
+=09=09pins =3D "gpio73";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09tsp_int_default: tsp-int-default-state {
+=09=09pins =3D "gpio13";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
index 42843771ae2a..4048b72efcdc 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
@@ -5,6 +5,9 @@
 /* SM5504 MUIC instead of SM5502 */
 /delete-node/ &muic;
=20
+/* Touchscreen varies depending on model variant */
+/delete-node/ &touchscreen;
+
 &blsp_i2c1 {
 =09muic: extcon@14 {
 =09=09compatible =3D "siliconmitus,sm5504-muic";
--=20
2.39.2




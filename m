Return-Path: <linux-kernel+bounces-99915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E4C878F29
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A96B21604
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E470E69969;
	Tue, 12 Mar 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Lb56FpPP"
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA586995B;
	Tue, 12 Mar 2024 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229559; cv=none; b=h3NL46ommc9TtY0razVuUGohNEA9HHvaxANAD1jnwP50YaOYsTWOW5YeIMdToyjqChwc7mnLgZwa1e1lJpVt+wAuvo1AoJO6UYURgy9iyMb9qpmKs7kZQK+ffofDtaL9s+h/4MgMvr1QLIRXGyUzajBG9nuRUX6VokGWrHWQmFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229559; c=relaxed/simple;
	bh=nAKaAzfxM+TFh5Qpz2J4wCa6Dr9859dg3apghxnoja0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OMwb0mEt4VgpOPhLLkQdZlwevv51Chho9/G2U/rTq0FwSU9tfp6EzbhPxC5sTwcQGirNv2axguL+tn6uJjK12DGs1g0NA/PiyLTxTWtJeOiXct0pQe5ynrH77hBkp3V2DqrPfj3ziBtVf7zhJI1XVRS2cQkUiMeqv8+RGxgyfos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Lb56FpPP; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1710229555; x=1710488755;
	bh=DaPBnbbEkmUycyEZJwv4LHBaiqagj1bYs7NPHk20HRs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Lb56FpPPyy6Z6YqvkokT76iv1PogGPvWLj86UZds8I5ywqZhda9mfdNpzv2w46CML
	 43JceMkwEzhuQVdPqobuJtQJvodzZkUDiYnfRIiEdXpKARWScYC/2I8jP/3Dg37zFF
	 zaEOcARVidVp+TEx4tnDDIK0BlkvNGr9ul8nPquxMUvRv4voEVnY13GdWvEVVTz2Sf
	 Hc+l8P+cGyTwQMz+w1DOYfbnMnRUIIFgSUi16JPUVKCGtCestT74RH4kCwCCkJZQal
	 aCd9aP7mOFBgQa4Zrr0oGWF3/NPsoeWgsdqUK0x8loBxU0xe1U+fJm977ZJNh//YV2
	 IggAdobIYJ1GQ==
Date: Tue, 12 Mar 2024 07:45:42 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Joe Mason <buddyjojo06@outlook.com>
Subject: [PATCH v2] arm64: dts: qcom: msm8916-samsung-fortuna: Add touchscreen
Message-ID: <20240312074536.62964-1-raymondhackley@protonmail.com>
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
---
v2: Add &touchscreen. Keep i2c5 enabled
---
 .../qcom/msm8916-samsung-fortuna-common.dtsi  | 49 +++++++++++++++++++
 .../qcom/msm8916-samsung-rossa-common.dtsi    |  3 ++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi b=
/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
index c2800ad2dd5b..d16647e687ef 100644
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
@@ -94,6 +107,28 @@ fuel-gauge@35 {
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
+
+=09=09linux,keycodes =3D <KEY_APPSELECT KEY_BACK>;
+=09};
+};
+
 &blsp_uart2 {
 =09status =3D "okay";
 };
@@ -200,4 +235,18 @@ sdc2_cd_default: sdc2-cd-default-state {
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




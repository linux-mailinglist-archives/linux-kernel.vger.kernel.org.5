Return-Path: <linux-kernel+bounces-71222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3309385A224
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B891B22C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6397A2D03B;
	Mon, 19 Feb 2024 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="cQHVru/F"
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08E2C6B8
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342742; cv=none; b=OoCM5yFQcQPgE/Suac9ReLVygFOID3Rkad0n78dIQcTlqt0RpUyGpTNs1FIrpfiOFcXhXkXiWPTAgIRM0TdvLZa80Lq/4S5bIJ7J4rQQPzbHM8J8vszQtEoX5JwZelDtVDnFzAr91y9374U5//tzTBZsqeHtimEfd7SUTXlf+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342742; c=relaxed/simple;
	bh=h1IIIWSe4qRLlBhLMEFmMIBQFe/eyV1n6swvwGxnTbo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=b9E5KEq4QQu6EQ4+NtgR8R2S4bJ2Q5i8hubV3bE6BC8Q9EZRe41nmVUFci3BwiAbXuSEM69oUUXt/Aevo/Fg++OIi/cJVn0GSN9jtqyt97sqnm8nJ27WWptdqu+VfoZ6PNvi5WNHjN+Ew/QDgmylHGW5aPYRp9+OWjXNWvxv0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=cQHVru/F; arc=none smtp.client-ip=185.70.40.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1708342731; x=1708601931;
	bh=RghR81ILLrY+u/jsCEPpXuUrAFRZYkdrd5pCcF3xLH0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=cQHVru/FnkVeZV6g1iU74VPlLwzYoItNu6+AYcp+QpUmOSMVw1bjptzzcjP39KR21
	 69ryUwJ1iWHxnMl969SnhMsGzV+0ccrlEQtg98vTyUSkzFvQT3FY1VIjFQ9h5Zsm1n
	 zrk0IZNuAXVQL5tLot/ML50iESDO5t3bkK3wucQiD+Wth0z6GmME3sI8chnvOij4PR
	 HRAeydwZtrMpVILa6NgrZmhKN7urO1INzbhZeyU+nSL4UidhWkDa9biJOe6G9YXNRi
	 cin97ASuCSsT9AAnV5j15uAdalS9BnWU97JVIqizJ4vxbajR3cvDVsYQ1SLpF7NUhr
	 k0FeEqpbWeE1A==
Date: Mon, 19 Feb 2024 11:38:33 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Joe Mason <buddyjojo06@outlook.com>
Subject: [PATCH] arm64: dts: qcom: msm8916-samsung-fortuna: Add touchscreen
Message-ID: <20240219113823.4189-1-raymondhackley@protonmail.com>
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
 .../qcom/msm8916-samsung-fortuna-common.dtsi  | 49 +++++++++++++++++++
 .../qcom/msm8916-samsung-rossa-common.dtsi    |  7 +++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi b=
/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
index c2800ad2dd5b..6fe0a08db08e 100644
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
+=09touchscreen@20 {
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
index 42843771ae2a..ee55c4669e5f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
@@ -14,3 +14,10 @@ muic: extcon@14 {
 =09=09pinctrl-names =3D "default";
 =09};
 };
+
+&blsp_i2c5 {
+=09status =3D "disabled";
+
+=09/* Touchscreen varies depending on model variant */
+=09/delete-node/ touchscreen@20;
+};
--=20
2.39.2




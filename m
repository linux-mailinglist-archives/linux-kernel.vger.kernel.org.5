Return-Path: <linux-kernel+bounces-108181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F0488072B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F1B2827B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BBD51C5B;
	Tue, 19 Mar 2024 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="plw5HfNa"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5E03FBB1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710886427; cv=none; b=TZ1ANVHD0/VuJjO5sWld55V15YTOCNm0rakHlpuwrrOdt1QmSZ6OnfRTN8NRsoN+oyDfJ5ZsIL69zWrTaIWOxsJsue8mrisatX06p9v0NQx+z1oJuI8tgD79Z/XmhCMXxb8aRpnSzVWzEtT+mB5PY0hKDkgKw95pJFEiQI7+Fno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710886427; c=relaxed/simple;
	bh=udVUFUWX2J/xUXDGTNFqtziCw0vdxH6hWQRY3LHyu8c=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=VCZCWn/cK6vSQmhQCWKYerIeEMjb47R6qNaJCfiRPg6mqq3Rj54cUPfYGP5CUHXV2riDPL9Ebh6zBpmVGqMfzvWdMvXYqL7M5Tv1Enm4ZB8JZk3ZAox1YkF/kb4RilqtOlJwNtxoD1B18ctEerFN4755D0SHFSLMt7khP1YoXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=plw5HfNa; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1710886423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mw9oB0GIX+79BFcxVVSixrKnoz3G0x8yQvNbfMRcMYU=;
	b=plw5HfNa9iIwNfa7udFoR4dM2lapOwmFGbjXJkkxKEU9kDu9vt6qxOLHXOa1PaFKZY5YEV
	E19wI44COKQBh8vIB/6bgdb7AUVCAuMk33Hv9ZhO5X4+WnIg84InGJoncVkeqWeJTenQI1
	j0YZUK+0/s5D9RytcwvRToj2HERoGpHa3Ik7u8TYEe4G8p5+1H7PeCnl+AYqjmNxys2l4m
	5U90TXJXNFixNVT6cat0Y+WO1RxQaE0cY7M1D7qJHiPpLBj9hSQrCZDXc6vCEgudAZQugy
	pjG2OoJS5bkqlLjifc1rYLqyuZdxUekRv5BPiFP8sKpilr/qoReRLmWk/X//sQ==
Date: Tue, 19 Mar 2024 22:13:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Anton Bambura" <jenneron@postmarketos.org>
Message-ID: <87c34b2d0a062497488aa1c7e3f0d12d3a029828@postmarketos.org>
TLS-Required: No
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sc8180x-lenovo-flex-5g: enable
 touchscreen
To: "Bjorn Andersson" <andersson@kernel.org>
Cc: "Konrad Dybcio" <konrad.dybcio@linaro.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <2tq6m75m3skcu5wlvrwpwnn53kay3pzo2aeecofxpfnll7mwqn@whtnrabrrivw>
References: <20240203191200.99185-1-jenneron@postmarketos.org>
 <20240203191200.99185-5-jenneron@postmarketos.org>
 <2tq6m75m3skcu5wlvrwpwnn53kay3pzo2aeecofxpfnll7mwqn@whtnrabrrivw>
X-Migadu-Flow: FLOW_OUT

March 18, 2024 at 4:43 AM, "Bjorn Andersson" <andersson@kernel.org> wrote=
:



>=20
>=20On Sat, Feb 03, 2024 at 09:11:58PM +0200, Anton Bambura wrote:
>=20
>=20>=20
>=20> Set regulators, reset gpio and delays according to ACPI tables.
> >=20
>=20>=20=20
>=20>=20
>=20>  Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
> >=20
>=20>  ---
> >=20
>=20>  .../boot/dts/qcom/sc8180x-lenovo-flex-5g.dts | 30 ++++++++++++++++=
++-
> >=20
>=20>  1 file changed, 29 insertions(+), 1 deletion(-)
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b=
/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> >=20
>=20>  index 6ae6cb030b70..5bf6285f905f 100644
> >=20
>=20>  --- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> >=20
>=20>  +++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> >=20
>=20>  @@ -271,6 +271,12 @@ vreg_l3c_1p2: ldo3 {
> >=20
>=20>  regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >=20
>=20>  };
> >=20
>=20>=20=20
>=20>=20
>=20>  + vreg_l4c_3p3: ldo4 {
> >=20
>=20>  + regulator-min-microvolt =3D <3296000>;
> >=20
>=20>  + regulator-max-microvolt =3D <3304000>;
> >=20
>=20>  + regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >=20
>=20>  + };
> >=20
>=20>  +
> >=20
>=20>  vreg_l10c_3p3: ldo10 {
> >=20
>=20>  regulator-min-microvolt =3D <3000000>;
> >=20
>=20>  regulator-max-microvolt =3D <3312000>;
> >=20
>=20>  @@ -337,6 +343,12 @@ vreg_l10e_2p9: ldo10 {
> >=20
>=20>  regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >=20
>=20>  };
> >=20
>=20>=20=20
>=20>=20
>=20>  + vreg_l12e_1p8: ldo12 {
> >=20
>=20>  + regulator-min-microvolt =3D <1800000>;
> >=20
>=20>  + regulator-max-microvolt =3D <1800000>;
> >=20
>=20>  + regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> >=20
>=20>  + };
> >=20
>=20>  +
> >=20
>=20>  vreg_l16e_3p0: ldo16 {
> >=20
>=20>  regulator-min-microvolt =3D <3072000>;
> >=20
>=20>  regulator-max-microvolt =3D <3072000>;
> >=20
>=20>  @@ -365,11 +377,19 @@ &i2c1 {
> >=20
>=20>  touchscreen@10 {
> >=20
>=20>  compatible =3D "hid-over-i2c";
> >=20
>=20>  reg =3D <0x10>;
> >=20
>=20>  +
> >=20
>=20>  hid-descr-addr =3D <0x1>;
> >=20
>=20>  + reset-gpios =3D <&tlmm 54 GPIO_ACTIVE_LOW>;
> >=20
>=20>  +
> >=20
>=20>  + vdd-supply =3D <&vreg_l4c_3p3>;
> >=20
>=20>  + vddl-supply =3D <&vreg_l12e_1p8>;
> >=20
>=20>  +
> >=20
>=20>  + post-power-on-delay-ms =3D <3>;
> >=20
>=20>  + post-reset-deassert-delay-ms =3D <200>;
> >=20
>=20
> As I ran into with the X13s, post-reset-deassert-delay-ms is not an
>=20
>=20accepted property for hid-over-i2c. I think the desired path forward =
is
>=20
>=20to extend elan,ekth6915.yaml and i2c-hid-of-elan.c and hard code thes=
e
>=20
>=20values there instead.
>=20
>=20But I suspect you, like me, are unaware of the actual name of the
>=20
>=20device? Perhaps it's acceptable to make something up based on the
>=20
>=20reported product id?

Indeed, I don't know the actual IC. evtest reports this:

Input device ID: bus 0x18 vendor 0x4f3 product 0x2a7d version 0x100
Input device name: "hid-over-i2c 04F3:2A7D"

>=20
>=20Regards,
>=20
>=20Bjorn
>=20
>=20>=20
>=20> interrupts-extended =3D <&tlmm 122 IRQ_TYPE_LEVEL_LOW>;
> >=20
>=20>=20=20
>=20>=20
>=20>  - pinctrl-0 =3D <&ts_int_default>;
> >=20
>=20>  + pinctrl-0 =3D <&ts_int_default>, <&ts_reset_default>;
> >=20
>=20>  pinctrl-names =3D "default";
> >=20
>=20>  };
> >=20
>=20>  };
> >=20
>=20>  @@ -735,6 +755,14 @@ ts_int_default: ts-int-default-state {
> >=20
>=20>  drive-strength =3D <2>;
> >=20
>=20>  };
> >=20
> >=20=20
>=20>=20
>=20>  + ts_reset_default: ts-reset-default-state {
> >=20
>=20>  + pins =3D "gpio54";
> >=20
>=20>  + function =3D "gpio";
> >=20
>=20>  +
> >=20
>=20>  + bias-disable;
> >=20
>=20>  + drive-strength =3D <16>;
> >=20
>=20>  + };
> >=20
>=20>  +
> >=20
>=20>  usbprim_sbu_default: usbprim-sbu-state {
> >=20
>=20>  oe-n-pins {
> >=20
>=20>  pins =3D "gpio152";
> >=20
>=20>  --=20
>=20>=20
>=20>  2.42.0
> >
>


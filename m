Return-Path: <linux-kernel+bounces-98208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB160877679
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 12:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDC41C20935
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BAC208D4;
	Sun, 10 Mar 2024 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="UHWFaz3X"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993B1EB42;
	Sun, 10 Mar 2024 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710071579; cv=none; b=JoWhB9oG9kzh3aI3qi6HcGR6a4KeCrHHjgvzbDKqos4IyCfXflyWF9OHm+r7jKj//3cgAncwx07cKsg9OsvnIVaFQthdUN+UirH2JNRMQ8DDF/xcnq8uAK6jq9+cUFF2TEnPKh7BsCHUdJbhhT6IlaVlungIwKP+8IG0pj0u4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710071579; c=relaxed/simple;
	bh=giPghFoQJnhBMzSSFaHrY0+Uapgo7d3tzYcduldTdj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEkW0s+Fn5l0yVugtH7hS5M8uGVKG0ejUZsqP8ivzSPNtQqxJsF4Pog6Dum9ArbCJGo98wkLLB1cEbs+F4H/5w3uptRqqgPAJbY7/RojVZ8g3NG+9wS9kH+ZjaOcplGdC5ZAsaRrtER7r+ArN+O7KOAE0hAoeSJWPdqKknYgCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=UHWFaz3X; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710071576; bh=giPghFoQJnhBMzSSFaHrY0+Uapgo7d3tzYcduldTdj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHWFaz3X69ki7mPyDg3cc7owB6qAGkU5uoz/FO3eES/nfQZWl0OT2yokhx8ptFp4Y
	 I0oHDmLUbgksmq3PlJkCixI6wVRTQKtdmAkU13pe4yWGkDmM45R9QHviUKeAJejqk+
	 Jh9Xbdo0v1Y92Y+FoWgEh91Rp6FGP0Bl95KWp2TU=
From: Luca Weiss <luca@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: qcom: Add Sony Xperia Z3 smartphone
Date: Sun, 10 Mar 2024 12:52:55 +0100
Message-ID: <6022941.lOV4Wx5bFT@g550jk>
In-Reply-To: <20240310-shinano-common-v1-3-d64cd322ebca@z3ntu.xyz>
References:
 <20240310-shinano-common-v1-0-d64cd322ebca@z3ntu.xyz>
 <20240310-shinano-common-v1-3-d64cd322ebca@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Sonntag, 10. M=C3=A4rz 2024 12:41:09 CET Luca Weiss wrote:
> Add the dts for the Xperia Z3 smartphone which is based on Sony's
> shinano platform, so at the moment there's little device-specific dts to
> add on top of the common parts.
>=20
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../qcom-msm8974pro-sony-xperia-shinano-leo.dts    | 44 ++++++++++++++++=
+++
+++
>  1 file changed, 44 insertions(+)

Of course I forgot to add the dtb to the Makefile...

Apparently "make qcom/qcom-msm8974pro-sony-xperia-shinano-leo.dtb" doesn't=
=20
care about whether the dtb is in the Makefile so I didn't notice.

Will fix in v2 but I'm going to wait for any comments on this or the other=
=20
patches for at least a day or so.

Regards
Luca

>=20
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-
leo.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-leo.dts
> new file mode 100644
> index 000000000000..1ed6e1cc21d5
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-leo.dts
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "qcom-msm8974pro-sony-xperia-shinano-common.dtsi"
> +
> +/ {
> +	model =3D "Sony Xperia Z3";
> +	compatible =3D "sony,xperia-leo", "qcom,msm8974pro", "qcom,msm8974";
> +	chassis-type =3D "handset";
> +
> +	gpio-keys {
> +		key-camera-snapshot {
> +			label =3D "camera_snapshot";
> +			gpios =3D <&pm8941_gpios 3 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_CAMERA>;
> +			debounce-interval =3D <15>;
> +		};
> +
> +		key-camera-focus {
> +			label =3D "camera_focus";
> +			gpios =3D <&pm8941_gpios 4 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_CAMERA_FOCUS>;
> +			debounce-interval =3D <15>;
> +		};
> +	};
> +};
> +
> +&gpio_keys_pin_a {
> +	pins =3D "gpio2", "gpio3", "gpio4", "gpio5";
> +};
> +
> +&smbb {
> +	usb-charge-current-limit =3D <1500000>;
> +	qcom,fast-charge-safe-current =3D <3000000>;
> +	qcom,fast-charge-current-limit =3D <2150000>;
> +	qcom,fast-charge-safe-voltage =3D <4400000>;
> +	qcom,fast-charge-high-threshold-voltage =3D <4350000>;
> +	qcom,auto-recharge-threshold-voltage =3D <4280000>;
> +	qcom,minimum-input-voltage =3D <4200000>;
> +
> +	status =3D "okay";
> +};
> +
> +&synaptics_touchscreen {
> +	vio-supply =3D <&pm8941_s3>;
> +};
>=20
>=20






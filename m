Return-Path: <linux-kernel+bounces-43307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5698411F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1F2285DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0356F074;
	Mon, 29 Jan 2024 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfG+FvT3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7131076C89;
	Mon, 29 Jan 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552607; cv=none; b=TOT+BfKMAmJ7RNli0GOB2gi0Nnc7XdwGpgbTWKIlDdAH7PCCNKmtjL808Hq7NkmIQc10WFPig6Q2uohLKxXi/PsIh/TDoPbUZfT8zZXlUDztkJH1iBu+Zq+VfhxdwFIo6V46D0iXnZsH63UPGm1ts8TA2ma5cegaY2YY8Oaq3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552607; c=relaxed/simple;
	bh=uUo/ELYi1fV8xAUVfjuo4eyyTGGvc7vWvgOiqe8dV14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTI7sF4IkB68hLNEz/nAK+4YtR+P0LiijY/vG339vsj0yOdf75+OUsIjt39W4o0F1IyaXWLZ4Uof7vYHwxaOopQ+7PHHrqsYrHoIMS4R4kPfOJtCffHni06iAZqTdoSay9vktoUkUpLgo1keqS7cnegbosBChA3YRp5XfdKjSBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfG+FvT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD826C433F1;
	Mon, 29 Jan 2024 18:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706552606;
	bh=uUo/ELYi1fV8xAUVfjuo4eyyTGGvc7vWvgOiqe8dV14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tfG+FvT3q1AsmbYw16QbLQI0fh0TXJ4OnH6FmcVreTiYjM1O+vXf9ZwfIQcq3Nt5p
	 Gew4I+1mmvxxhW9qenu2t6NSosDPmk30SE0TdHfl4ZdZ/hWcIX/JNtcvbuU2fsxIIL
	 OXKVo+NgoXkg4CKPsFrLxSaYTqHOOclsVaU8nXZrZZr2fm96Heq5nIYe1GlwzG1IxL
	 Iye3thIRZuqpu1fuwJEtSLnoGbvchioHZZX1K8k9ss4nKTfrQQV7wKGoij/3w4f4Sr
	 VbI3fh3dvz4+ksbQ6/ReUpH30mgf1Kc5KfqhUr39ufApqg9P3oZ94lykoGD1Ks/BRr
	 QL9M0pB87e2Xw==
Date: Mon, 29 Jan 2024 18:23:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Nylon Chen <nylon.chen@sifive.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
	thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
	vincent.chen@sifive.com, zong.li@sifive.com, nylon7717@gmail.com
Subject: Re: [PATCH v8 1/3] riscv: dts: sifive: unleashed/unmatched: Remove
 PWM controlled LED's active-low properties
Message-ID: <20240129-subsoil-reapprove-a60fedd1caf0@spud>
References: <20240126074045.20159-1-nylon.chen@sifive.com>
 <20240126074045.20159-2-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5A9FXQwnSGACEOHc"
Content-Disposition: inline
In-Reply-To: <20240126074045.20159-2-nylon.chen@sifive.com>


--5A9FXQwnSGACEOHc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 03:40:43PM +0800, Nylon Chen wrote:
> This removes the active-low properties of the PWM-controlled LEDs in
> the HiFive Unmatched device tree.
>=20
> The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-schemat=
ics-v3.pdf[1].
>=20
> Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf845=
3f8698_hifive-unleashed-a00-schematics-1.pdf [0]
> Link: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce7=
6f4192_hifive-unmatched-schematics-v3.pdf [1]
>=20
> Co-developed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Uwe, take this with the driver, if that is ready to be taken.

Thanks,
Conor.

> ---
>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 12 ++++--------
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++--------
>  2 files changed, 8 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/r=
iscv/boot/dts/sifive/hifive-unleashed-a00.dts
> index 900a50526d77..06731b8c7bc3 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> @@ -49,32 +49,28 @@ led-controller {
>  		compatible =3D "pwm-leds";
> =20
>  		led-d1 {
> -			pwms =3D <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> -			active-low;
> +			pwms =3D <&pwm0 0 7812500 0>;
>  			color =3D <LED_COLOR_ID_GREEN>;
>  			max-brightness =3D <255>;
>  			label =3D "d1";
>  		};
> =20
>  		led-d2 {
> -			pwms =3D <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
> -			active-low;
> +			pwms =3D <&pwm0 1 7812500 0>;
>  			color =3D <LED_COLOR_ID_GREEN>;
>  			max-brightness =3D <255>;
>  			label =3D "d2";
>  		};
> =20
>  		led-d3 {
> -			pwms =3D <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
> -			active-low;
> +			pwms =3D <&pwm0 2 7812500 0>;
>  			color =3D <LED_COLOR_ID_GREEN>;
>  			max-brightness =3D <255>;
>  			label =3D "d3";
>  		};
> =20
>  		led-d4 {
> -			pwms =3D <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
> -			active-low;
> +			pwms =3D <&pwm0 3 7812500 0>;
>  			color =3D <LED_COLOR_ID_GREEN>;
>  			max-brightness =3D <255>;
>  			label =3D "d4";
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/r=
iscv/boot/dts/sifive/hifive-unmatched-a00.dts
> index 07387f9c135c..b328ee80693f 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> @@ -51,8 +51,7 @@ led-controller-1 {
>  		compatible =3D "pwm-leds";
> =20
>  		led-d12 {
> -			pwms =3D <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> -			active-low;
> +			pwms =3D <&pwm0 0 7812500 0>;
>  			color =3D <LED_COLOR_ID_GREEN>;
>  			max-brightness =3D <255>;
>  			label =3D "d12";
> @@ -68,20 +67,17 @@ multi-led {
>  			label =3D "d2";
> =20
>  			led-red {
> -				pwms =3D <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
> -				active-low;
> +				pwms =3D <&pwm0 2 7812500 0>;
>  				color =3D <LED_COLOR_ID_RED>;
>  			};
> =20
>  			led-green {
> -				pwms =3D <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
> -				active-low;
> +				pwms =3D <&pwm0 1 7812500 0>;
>  				color =3D <LED_COLOR_ID_GREEN>;
>  			};
> =20
>  			led-blue {
> -				pwms =3D <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
> -				active-low;
> +				pwms =3D <&pwm0 3 7812500 0>;
>  				color =3D <LED_COLOR_ID_BLUE>;
>  			};
>  		};
> --=20
> 2.42.0
>=20

--5A9FXQwnSGACEOHc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbftGQAKCRB4tDGHoIJi
0qmQAQDiGfd+UdqYAlnM1Owz93rDgiV//gS7COZORlmIezU51QEAmkFGRrFJVT4J
CbDqiy1NWDk9D2Bs4c4i0NknaV33bw4=
=FahO
-----END PGP SIGNATURE-----

--5A9FXQwnSGACEOHc--


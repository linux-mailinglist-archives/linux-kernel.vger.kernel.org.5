Return-Path: <linux-kernel+bounces-2803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A5081622C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84A9282ECC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484AA481C9;
	Sun, 17 Dec 2023 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZynxvG4T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E00481C0;
	Sun, 17 Dec 2023 20:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B8CC433C7;
	Sun, 17 Dec 2023 20:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702846080;
	bh=MsOuiC4vjp3GdwgSh5eqIM9fcQPx/rrlgv5IxgSP46c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZynxvG4Tt6oSL1swR5Cb+u56TisQK3Ah/s8oc8bzpLfAUMStsu3RebVPXV5a1Ebqf
	 h7B5V4+Ckwwn0nePxNSySGCZxCUnfj1DoHNIcLf1CzXE+CeSIzCimePmb9Woqt6V7Y
	 f2Z5iNE1/oml2IoyzA041E1xbe35MzrRyAvkIZcW8gJO+vzGoBuCriO++6Tt29fo6K
	 aexYdwirgkyxF3/Dy87ZU0L2RcfT9bqVRHlWcYDJ3csPwvQrGPAglRSzsujKuprheI
	 1xovbfuFV+1DEeNOKf1lPZZ+aE4Ilp4qwCmGkmSoP5bzNvuyzBZAb7UitI2DZBoPpp
	 fvGt3ZTG19V+w==
Date: Sun, 17 Dec 2023 20:47:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	chao.wei@sophgo.com, unicorn_wang@outlook.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlan@gentoo.org
Subject: Re: [PATCH v2 3/3] riscv: dts: sophgo: add rtc dt node for CV1800
Message-ID: <20231217-congenial-unwoven-8067fcbff9d5@spud>
References: <20231217110952.78784-1-qiujingbao.dlmu@gmail.com>
 <20231217110952.78784-4-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j0DE3vb0WktsyfMc"
Content-Disposition: inline
In-Reply-To: <20231217110952.78784-4-qiujingbao.dlmu@gmail.com>


--j0DE3vb0WktsyfMc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 07:09:52PM +0800, Jingbao Qiu wrote:
> Add the rtc device tree node to cv1800 SoC.
>=20
> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> ---
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dt=
s/sophgo/cv1800b.dtsi
> index df40e87ee063..429bee76f677 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -119,5 +119,12 @@ clint: timer@74000000 {
>  			reg =3D <0x74000000 0x10000>;
>  			interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc 7>;
>  		};
> +
> +		rtc@5025000 {
> +			compatible =3D "sophgo,cv1800-rtc";

This is a cv1800b, not a cv1800.

> +			reg =3D <0x5025000 0x1000>, <0x5026000 0x1000>;
> +			clocks =3D <&osc>;
> +			interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> +		};
>  	};
>  };
> --=20
> 2.25.1
>=20

--j0DE3vb0WktsyfMc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZX9eegAKCRB4tDGHoIJi
0suWAQDf7i2v9PVtd8LXOAuotFiLnMgZ+BZYKwPFZcKeSpXBxAD+LpHq5X11sPQe
2e5AtZfiLnIAjR4b+HZ5vPS4SA7pOgU=
=zCPu
-----END PGP SIGNATURE-----

--j0DE3vb0WktsyfMc--


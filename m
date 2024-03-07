Return-Path: <linux-kernel+bounces-95993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E782B8755C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A378A284A5F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22F7131E28;
	Thu,  7 Mar 2024 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6gknGiK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9A812A15C;
	Thu,  7 Mar 2024 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834779; cv=none; b=RnOXynmqcW8vY4Vs+XMtNWOIrIEl6URbywumtjMw7V6/VI3rukRSOoHOkxiQAGJ35FlcmxZiVMxbhgvsGWMhisxN3N813k69yOVQSLKxNmgTvAbfRrVBmrhP+WTuDze2DbbDG0wNkeXUbRTHp0OHy4IxNxXdunK5G6CEFtyBuhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834779; c=relaxed/simple;
	bh=/qMweurkufToMwoadZe649Pm1lLjarPn8VuQ/oC8ncI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5Zi6W/OlAtWhK6kLF9PC2n5+5qdsTPwTNaSJrnQELoiINp92tmSnXIk688DT76pDI9nCI9AaxlKqTlODcxwwyG82nb6rKZluZRpj3davsBZ9eDjO0gQhk5vz1CQxgfC8NvFCaqjw7fXtaUYNO1eZS0WjEuVFiyMv/lwSueohjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6gknGiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04474C433C7;
	Thu,  7 Mar 2024 18:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709834778;
	bh=/qMweurkufToMwoadZe649Pm1lLjarPn8VuQ/oC8ncI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6gknGiKUfVSiH36Wno+U/gRqlQxWa4hxGU7U9gID7kxMoztJxP20vaHs1m6jR177
	 bqMFRJCxHQMgCX5H+x7hyipP0S+W2H0W5bb0PQW9/COve6uqhpK9oETQGc2ZSjk0jT
	 O9Bfd7uuQaB0IGK6ILJc6EUPAgVacvPz4Ph2rDrmHClaCQZ3uBluNP40UgDvH117KO
	 UXvXfWKPgAQX8QA2R1RWi46nlhcSwkkMxvihCr5LjyuJmNKooRxTMHtDj80JvCywPs
	 Fv3q/S33/W7UHE5f9nIGG35UZ3fUIwVLXBTgViIy3njxz21pcdpJsHmG2F+4wWEHAA
	 mYZiAYeC4sQYw==
Date: Thu, 7 Mar 2024 18:06:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: ganboing@gmail.com, kernel@esmil.dk, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: starfive: Remove PMIC interrupt info for
 Visionfive 2 board
Message-ID: <20240307-underpaid-anyplace-9fe1241643d3@spud>
References: <TY3P286MB26116B828A34D614C09F4E8898202@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e3+Vcw8nCCVh8dqu"
Content-Disposition: inline
In-Reply-To: <TY3P286MB26116B828A34D614C09F4E8898202@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>


--e3+Vcw8nCCVh8dqu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 08:21:12PM +0800, Shengyu Qu wrote:
> Interrupt line number of the AXP15060 PMIC is not a necessary part of
> its device tree. And this would cause kernel to try to enable interrupt
> line 0, which is not expected. So delete this part from device tree.
>=20
> Cc: stable@vger.kernel.org
> Reported-by: Bo Gan <ganboing@gmail.com>
> Link: https://lore.kernel.org/all/c8b6e960-2459-130f-e4e4-7c9c2ebaa6d3@gm=
ail.com/
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>

Thanks for resending. Just to note that I already sent all 6.8 and 6.9
material, so since this is only something that manifests with that
"improved" version of OpenSBI I'm gonna pick this up after the merge
window.

Fixes: 2378341504de ("riscv: dts: starfive: Enable axp15060 pmic for cpufre=
q")

And hopefully I remember to re-write the commit message to mention that
the board doesn't actually connect the interrupt link to a GPIO etc, so
the original patch was invalid and a hack.

I should have rejected it and got the driver fixed at the time to allow
not having an interrupt, but clearly I didn't register that that zero
was a plic interrupt, not a GPIO.

Thanks,
Conor.

> ---
>  arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dt=
si b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 45b58b6f3df8..7783d464d529 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -238,7 +238,6 @@ &i2c5 {
>  	axp15060: pmic@36 {
>  		compatible =3D "x-powers,axp15060";
>  		reg =3D <0x36>;
> -		interrupts =3D <0>;
>  		interrupt-controller;
>  		#interrupt-cells =3D <1>;
> =20
> --=20
> 2.39.2
>=20

--e3+Vcw8nCCVh8dqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeoCFQAKCRB4tDGHoIJi
0ps6AQD2oxPKg4y3LidQr++C4Vz9xtSEzczxjTPFfkTwQdm2fAD9GvuuDnBLY6Zh
NLzH0HrR9oVi/bBt+4DJIiPqHnKywQY=
=BFh/
-----END PGP SIGNATURE-----

--e3+Vcw8nCCVh8dqu--


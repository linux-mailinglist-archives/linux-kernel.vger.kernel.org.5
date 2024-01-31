Return-Path: <linux-kernel+bounces-46611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A018441F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A14FB25605
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C5C83CBD;
	Wed, 31 Jan 2024 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/qcrKiU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C988287D;
	Wed, 31 Jan 2024 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711794; cv=none; b=TjsCVe5JGgFn0v+aXJjEuGCu7oe2jm5jHU9st+GALrDTUd31KYDMBjxLNdn6HlX8yshg3mXq9soo1Prxg9UdQ2/tkO1yvZCkIExfyfAnC7Kdyb72aKvZwsCtbeCnQhQomsQXi0Lw8R8JmvuZ0Xt9FSSjHmd4DSxACoEYjRF1L5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711794; c=relaxed/simple;
	bh=hJ+XW2fv/7c4oP2Hm+5FY6Z2FZRxNXmDtEx1scYcuKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F50X25xg1DA/Hjv8XKaHFaOxN5dMTD+TudwevumvQMQw+vZFnGR7XKfWcRzerJyumPRzgEDiOsld+veYxW9gS8bU0xRWe9oQLEZNip47V1caME+XHdxefgGmPEIaINpOVlUg/80wPxFy6m613ZNLApQi1l66OF9Sv+6x0Ft/BHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/qcrKiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C76C433F1;
	Wed, 31 Jan 2024 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706711793;
	bh=hJ+XW2fv/7c4oP2Hm+5FY6Z2FZRxNXmDtEx1scYcuKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/qcrKiUHr3R1zdZ6ueRxhVHbjIE36TksoTuqq3vRIuuZUagwUzQ1qMMdox/KrNeO
	 wQR9R4DSLgs/QTZsLPR6dBZBiBmmvi0tvubLIQA+8jFH3YuC4U+WPyj2v88xmU/oVd
	 lQJboA+5ntxwJWtMJYwFXNva6EPUfst7xqfhUI/at8UR5f8x+am3/j9vySclg8RzFn
	 IMnaJwlS/BX/b6bUt/iQe5m3K5tb4QlTVwfE43RPWcRSKR0xd0jn6OBZKtXhx34Rep
	 giJJQe1WJ4x09mMkji1B5Y32pOUNE9s+QGF6D02G6v+/AwrtEKuMAkjK3S0AO6wXcu
	 3JGJc50OL1Lww==
Date: Wed, 31 Jan 2024 14:36:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jack Zhu <jack.zhu@starfivetech.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [v2] riscv: dts: starfive: jh7110: Add camera subsystem nodes
Message-ID: <20240131-recycling-entering-b742e0e835eb@spud>
References: <20240130082509.217683-1-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q8uPg8RLNm85EpwJ"
Content-Disposition: inline
In-Reply-To: <20240130082509.217683-1-changhuang.liang@starfivetech.com>


--Q8uPg8RLNm85EpwJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 12:25:09AM -0800, Changhuang Liang wrote:
> Add camera subsystem nodes for the StarFive JH7110 SoC. They contain the
> imx219, dphy-rx, csi2rx, camss nodes.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 103 ++++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  67 ++++++++++++
>  2 files changed, 170 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dt=
si b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index b89e9791efa7..e0027bb379ef 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -30,6 +30,37 @@ cpus {
>  		timebase-frequency =3D <4000000>;
>  	};
> =20
> +	imx219_clk: imx219-clock {
> +		compatible =3D "fixed-clock";
> +		clock-output-names =3D "imx219_clk";
> +		clock-frequency =3D <24000000>;
> +		#clock-cells =3D <0>;
> +	};

Why do you need an output name here?
Also, where does this clock come from? Is it an oscillator on the board?

> +	imx219_vana_2v8: 2p8v {

For all of these regulators, please put "regular-" as a prefix for the
node names.

Cheers,
Conor.

--Q8uPg8RLNm85EpwJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbpa1gAKCRB4tDGHoIJi
0htJAP926uU2I31XT3Lgqjc+bRiJN/IujQZChYy/z+0X+iurnQD8Ca60fxV3t1q8
5cLQMdnaSwEe56ewCzw3aTA82hkzQAU=
=t0pB
-----END PGP SIGNATURE-----

--Q8uPg8RLNm85EpwJ--


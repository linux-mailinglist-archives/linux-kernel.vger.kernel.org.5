Return-Path: <linux-kernel+bounces-127560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C76D5894DA6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828AB28391B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806E650271;
	Tue,  2 Apr 2024 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfr3sTaj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36B94B5CD;
	Tue,  2 Apr 2024 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046896; cv=none; b=OVHlC5PNKEjiX3AWZewnAxqebfB12XARd8nO2/Q5a7Q8bKaXvIBbgBJx/IhplrGZtipAp+Ts+5Y8NW7CWnACewAYNjPwbH0EmRj2phtfN7+TDljoeKfJT7YtZZKcyvGDc6lVsOOgguv/JqfGmzGZI9kieHyO+ZQbucdTMGMlKuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046896; c=relaxed/simple;
	bh=7kWQsmRpXpQp3bKZs819yi3gZoHSA+71Gnw2aAmVD8Q=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=rm6QVZhAV6vHYcsEGaAzXHlDO0zREuAiHT7VeBJGwiS9Kjx661VZYNT3oPhYDv14PIU5i1eDh7r9n5mtG017t1m4aVYBmSvE4kVdMxLdU5bY7Rt7Ep9zkn8dGwF+jrnzEJ6PxdEp5Egc0Te4QlspRQ9XP/GL9YdFg+BoNKWS7PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfr3sTaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09764C433F1;
	Tue,  2 Apr 2024 08:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712046896;
	bh=7kWQsmRpXpQp3bKZs819yi3gZoHSA+71Gnw2aAmVD8Q=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=bfr3sTajNmvYKWQlCUAOLZDhOZDixacRj748vqrWjfjM0XS4/InLHeTeh2ikZ6d13
	 NUTKGQm4P31n041l8D5MMKx+41+Q5Lciqwy1rq1t/W+Wx5yZJdApWwpDy/tvw1y7MU
	 UgTTB3iDt1q7Vq6SLtgKLg2jZ50crK7SPj6YLO6Yasn87sun6XiVDGVmti69ZhdNzk
	 LNIRLNTFve5yE8tlAmLmp2nBq+bCYGsqOkydJ1g7HTrnIws30bbyLy0LQaPhO7CklW
	 SG5lQ/SiIKXiGx+KomnfjSc6KtFf4LQd4PihFEk8BuMJBpAaj1aTHSWc5gxIgfuKHk
	 bu2jpx34peFfg==
Content-Type: multipart/signed;
 boundary=92633de13f80d4722cab62876e75f1f46a1ce5d8254bdf21234f6f54d746;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 02 Apr 2024 10:34:52 +0200
Message-Id: <D09HZ0PN0QB9.2TJR29LQ2F570@kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: macronix: Add support for mx25um51245g
Cc: <linux-mtd@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Witold Sadowski" <wsadowski@marvell.com>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <broonie@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240328115225.1783-1-wsadowski@marvell.com>
In-Reply-To: <20240328115225.1783-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--92633de13f80d4722cab62876e75f1f46a1ce5d8254bdf21234f6f54d746
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

[+ linux-mtd ]

Hi,

On Thu Mar 28, 2024 at 12:52 PM CET, Witold Sadowski wrote:
> The Macronix mx25um51245g is a 1.8V, 512Mbit (64MB) device that
> supports x1, or x8 operation.
>
> Tested on Marvell Octeon SoC hardware with a Cadence xSPI controller.
>
> Signed-off-by: Witold Sadowski <wsadowski@marvell.com>

You haven't CC'ed the correct list, therefore it's unlikely this
will get a proper review/getting merged at all.

As Krzysztof already pointed out on another series of yours, please
read submitting-patches.rst.

For nor flash related submissions please also read:
https://docs.kernel.org/driver-api/mtd/spi-nor.html

> ---
>  drivers/mtd/spi-nor/macronix.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macroni=
x.c
> index ea6be95e75a5..f5fbdb7912e0 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -182,6 +182,12 @@ static const struct flash_info macronix_nor_parts[] =
=3D {
>  		.name =3D "mx25l3255e",
>  		.size =3D SZ_4M,
>  		.no_sfdp_flags =3D SECT_4K,
> +	}, {
> +                .id =3D SNOR_ID(0xc2, 0x80, 0x3a),

Wrong indentation?. Please use checkpatch.pl.

> +                .name =3D "mx25um51245g",

drop the name.

> +                .size =3D SZ_64M,

This is also autodetected. Drop it.

> +                .no_sfdp_flags =3D SECT_4K,

No "no_sfdp_flags" for SFDP capable flashes. Drop it.


> +                .fixup_flags =3D SPI_NOR_4B_OPCODES,

Doesn't the flash have proper a 4BAIT table?

-michael

--92633de13f80d4722cab62876e75f1f46a1ce5d8254bdf21234f6f54d746
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZgvDLRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jOzgF+KSOzHoPsP7oOG25ae5P4lNDk1qp6LWMv
Vx6iQft3Sn8zwAqBytHxaG7tzw/x0wHnAYDnH/uN4T9V/ZDc5xhO/0oHsFXQWxFt
fOsRGlwuKLLrxY3mTAs9UnSXSxXQ2GA+iKY=
=MbwG
-----END PGP SIGNATURE-----

--92633de13f80d4722cab62876e75f1f46a1ce5d8254bdf21234f6f54d746--


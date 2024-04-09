Return-Path: <linux-kernel+bounces-136851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8313089D900
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366941F22939
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D00512BEBE;
	Tue,  9 Apr 2024 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfWIgrm9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C4E85636;
	Tue,  9 Apr 2024 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664817; cv=none; b=ehpYBHXF9YxBFuGtyD644TJ3bKiHz7GCNMNKjriiK6DP7vjyoN2BO2mICh14hEnfKtjZup3X7/VIhl6eZi8jTCB96XP6DcWzzpkp0EqiaA+SLlB8PJKfilc7lQFd/lREvuQ4EMBFUKXbOFEIrIdTjBtBD/gf+BoAIl/vTk0nfkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664817; c=relaxed/simple;
	bh=Bn2d67M9B+2xeCfZnams3peFE9ObQAOACMbR2Qme3us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTF8QYQzIzYePE9mNn4bzv6fDrFFYU3dM3a+tOVAcYjqBH8bnpGcLhPXGVXOpKL7ZZcAoGcP014n76JWasxhEDoumDpai0uv4zpHbsWBpfHgwQ9QlTwII5rvj8SeTKRCx68LmWfIabDGeBaomRgDItSzImKJckKou0sGzzbla2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfWIgrm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873BBC433C7;
	Tue,  9 Apr 2024 12:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712664817;
	bh=Bn2d67M9B+2xeCfZnams3peFE9ObQAOACMbR2Qme3us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KfWIgrm9GkrO20P2GPcz8gLnutCwdqiOD7KhP/75f6ZXZdPdV3csBdMv5QQ7gEtUV
	 8zd1sPalZHLyxqZJodRfkqkcm6HTbONvxVoEW8ni0vbwL3tH5WNS5fFY+VJDEbIDzm
	 gnZMIqo/3gzCVaj4gHQ2NPKdhNGEQuysBcQpkntrrzK/e9VpxZbmI8KjDNrfAFz6Qy
	 NEw+3L+dZ7qgo/nEu7t3eV9+5jSUV0lScgww1+XT4VCl8T1zaxP8MYaR3hpmg3IwV0
	 nni2pLn7wFziLrMyC4I/NnJpLiOn2lPWT/XisRV3mjfYqT2wFYQuIpmxaW78lflTM5
	 g8PvhYG6lZ5Yw==
Date: Tue, 9 Apr 2024 13:13:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: michael.opdenacker@bootlin.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: add initial Milk-V Duo S board
 device tree
Message-ID: <20240409-prevent-deepness-2d22bf009b16@spud>
References: <20240409064504.4010353-1-michael.opdenacker@bootlin.com>
 <IA1PR20MB49532A8D4294ADCE0C33A654BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9NJ+1qh0mf0Ujp8a"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49532A8D4294ADCE0C33A654BB072@IA1PR20MB4953.namprd20.prod.outlook.com>


--9NJ+1qh0mf0Ujp8a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 03:17:35PM +0800, Inochi Amaoto wrote:
> On Tue, Apr 09, 2024 at 08:45:04AM +0200, michael.opdenacker@bootlin.com =
wrote:
> > From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> >=20
> > This adds initial support for the Milk-V Duo S board
> > (https://milkv.io/duo-s), enabling the serial port and
> > read-only SD card support, allowing to boot Linux to the
> > command line.
> >=20
>=20
> Hi Michael,
>=20
> I think your patch losts the board binding and have wrong compatiable.=20
> Also, the SD can have rw support with proper property. See link [1]=20
> (need 'disable-wp').

[1] doesn't go anywhere useful.

> I suggest you resubmitting this patch after applying clk patchs.=20
> This could reduce some unnecessary change. For now, you can just=20
> use the dts for huashan-pi (with changed memory size).

Why would using patched huashan-pi dts be more suitable than carrying
a local patch for duo-s devicetree? What am I missing?

Cheers,
Conor.

>=20
> [1]: https://lore.kernel.org/linux-riscv/IA1PR20MB4953B158F6F575840F3D426=
7BB7D2@IA1PR20MB4953.namprd20.prod.outlook.com/

--9NJ+1qh0mf0Ujp8a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhUw7AAKCRB4tDGHoIJi
0hxeAP9Gq5pqIE8VbwzobCLZkAoeBFVSPzoXf7wBfFedcwFlTgEA3f5KH2ThJh6z
E/9yUOzC5dwl7/X9hqNhekc6IjRtSgo=
=DmrY
-----END PGP SIGNATURE-----

--9NJ+1qh0mf0Ujp8a--


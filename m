Return-Path: <linux-kernel+bounces-137408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D78C789E1A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91582284DCD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA8D156678;
	Tue,  9 Apr 2024 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DASQG1HX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E4F13C66C;
	Tue,  9 Apr 2024 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683928; cv=none; b=dOFkZp1RrBUGZ759O/YrgkShZugMYDHydBwCFziOZqPlB6OArzo3d77rDRKFSp/TNv2mCzjyTHWtu++6oKfp3pVsVgHRQR0hUFcR+8Qsi4vzglrtDx5916ianW2wvZ7KxBxD025OwteMqIzx8MSfqBgyRn4OqotT/RP+eH27Fsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683928; c=relaxed/simple;
	bh=zbXpp6bn5v5mcNZu3t/YEPHaxpHKSpvxYnywNRsqWZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXm1pHwtdz1zDaedcc5J4nibR+6Dzuy4iZHPkSBf6fQWQBjQTqX1mjykelU74yY0OnJb196ARVxdT/UnhGejNHuKyfB9HMGsTbw2GZeoeeBkwttCxkpTVIRlFp7NZFEsxL7hBe+okipXQ3et8/QfesF7mgjQuUvM3af0Xj88yfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DASQG1HX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87116C433F1;
	Tue,  9 Apr 2024 17:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712683928;
	bh=zbXpp6bn5v5mcNZu3t/YEPHaxpHKSpvxYnywNRsqWZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DASQG1HXpYfghCLFflKgrm2W/ERgMoKMROXeIyJI8cqz/LXS9Pf0QW2Uk6OfYSO+j
	 a+b8s6CXW75opqaN5bC2vCK4J6/zuXckexmD96fYduhxvcDEfwGTVfKTr3O995cwIZ
	 Ow6//QuPTL1GyepbdGPFBRF59v5Twa0UD1S2qEDeKUBhh0A0zSrrWxSwop4K7eFWKa
	 xQbaR6TV0ypTjovR/qkVF3IwDy0tTywLQne0DhTX7Hck1YIT8X4/g7Rzan+UcQ50FD
	 wdK9HVIjppLmJdUVplLUFPIMvjcRDIfggByEMDGkkwW9dWbp3oen9oGmgZdOHFG1Dg
	 8G50LBIOxEnhQ==
Date: Tue, 9 Apr 2024 18:32:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Nikita Shubin <nikita.shubin@maquefel.me>,
	Arnd Bergmann <arnd@arndb.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 0/4] DONOTMERGE: ep93xx-clk from ep93xx device tree
 conversion
Message-ID: <20240409-unselect-denatured-6af8a07dbd9a@spud>
References: <20240408-ep93xx-clk-v1-0-1d0f4c324647@maquefel.me>
 <20240408-friction-mosaic-ba48bc27788d@spud>
 <42f9da044fdc11e2495f6845c061afefa796f7cf.camel@maquefel.me>
 <73fd3f42c2d63467bb1b04888659e829f9e54f52.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hfWycvtu4zQBs5eK"
Content-Disposition: inline
In-Reply-To: <73fd3f42c2d63467bb1b04888659e829f9e54f52.camel@gmail.com>


--hfWycvtu4zQBs5eK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 05:09:35PM +0200, Alexander Sverdlin wrote:
> Hi Nikita,
>=20
> On Tue, 2024-04-09 at 14:48 +0300, Nikita Shubin wrote:
> > On Mon, 2024-04-08 at 18:03 +0100, Conor Dooley wrote:
> > > On Mon, Apr 08, 2024 at 11:09:52AM +0300, Nikita Shubin via B4 Relay
> > > wrote:
> > > > The goal is to recieve ACKs.
> > >=20
> > > I dont see a maintainers entry in -rc1 for the drivers/soc/cirrus
> > > portion. Who is gonna give you an Ack for that portion? If you
> > > intended
> > > maintaining that driver, should you not add a MAINTAINERS entry for
> > > it?
> >=20
> > drivers/soc/cirrus got it's ACK from ep93xx MAINTAINER - Alexander
> > Sverdlin.
> >=20
> > Arnd, Alexander - should we add it now ?
>=20
> seems that we have couple of things to fix:
>=20
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #51:=20
> new file mode 100644
>=20
> WARNING: please write a help paragraph that fully describes the config sy=
mbol
> #60: FILE: drivers/soc/cirrus/Kconfig:5:
> +config EP93XX_SOC
> +	bool "Cirrus EP93xx chips SoC"
> +	select SOC_BUS
> +	select AUXILIARY_BUS
> +	default y if !EP93XX_SOC_COMMON
> +	help
> +	  Support SoC for Cirrus EP93xx chips.
> +
>=20
> total: 0 errors, 2 warnings, 269 lines checked

FWIW, I wouldn't be too worried about meeting the minimum line check for
the Kconfig option that checkpatch requires - but the description here
is not clear what the driver does.=20

--hfWycvtu4zQBs5eK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhV7kwAKCRB4tDGHoIJi
0sK2AQC8a1isyFTn6fekLdOTJ4w8j4r0IrldzsHLvayDPHqQRwD+IxgI3A8hZ5Iz
7lJYuGUc1y73HVsn2n9d/ZbXPDzCGA8=
=jf+f
-----END PGP SIGNATURE-----

--hfWycvtu4zQBs5eK--


Return-Path: <linux-kernel+bounces-133297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F3589A1E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59CC1C23F50
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5666171649;
	Fri,  5 Apr 2024 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om3T7B+X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE248171084;
	Fri,  5 Apr 2024 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332353; cv=none; b=tJILLuSavG02VEZ58XPTSus+Qg1QM7bsrpCiyHdkGS9Cucj8OC8sn6i4RnOIgTPqvY0REZuRHhRl62xUKfiVHsg0y2CulpNTnFRUEnRBUp4TQWgRk7t6Szz85pmYAdy/IMJ0wDNTeabSNXrQRr9b3idW2vGdO8MWZE4MMPOKeBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332353; c=relaxed/simple;
	bh=1TYQ2nOf7m5eWfWsRNd18xHaQuIeo9EkWggomHT0qUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVNJHrwVF3whS360w/NyQETjavxYRVT2DYBNoY8uWMtltLrzRtp68/XpkBZYve9gZAKAnd0grt+dP2OS62CaMSiEovjfISjmSEpu+OwDPudWgYBmgrTbzRsuee9mwjvqmgM9u0KI86AU73JsPdaZZeBMJ380D1zqGdIh1WE92cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om3T7B+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C456C433F1;
	Fri,  5 Apr 2024 15:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712332352;
	bh=1TYQ2nOf7m5eWfWsRNd18xHaQuIeo9EkWggomHT0qUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Om3T7B+XSv2dLDaDtUMT1+Bj89NktWuLG9ZRiHO6pDXJCKOFbWt3CuoJPum7E3X2j
	 TWI7MtUFfRcF7Mdq4DvRdXsYGbaMY2y8A53XSgX6Wr06fq4MvfRcCohMT/67DUID7J
	 jn9BmSmUHZ5xj+761vczmdGa3K6e386tRbc4MsOnT11ooeZlA5p18lWpvUUq4Ljj6T
	 Y5/S5MbstQZLh48LDyA8yYRFhk+Y3YmpoD9RevHhIJuUa7C1CecIPzSAkWhza6DnPK
	 RlmUbsLkYrUKL8Nxk0yFvPuDgLFb64V2/yFNrQ/Zyj7TvtVGTJYWQJ3iNjxsB06OXr
	 IxlcVyAXZ0RvQ==
Date: Fri, 5 Apr 2024 16:52:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: Icenowy Zheng <uwu@icenowy.me>, linux-riscv@lists.infradead.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/11] riscv: dts: add initial canmv-k230 and k230-evb
 dts
Message-ID: <20240405-election-stubble-6b7e3d530d3c@spud>
References: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com>
 <tencent_DF5D7CD182AFDA188E0FB80E314A21038D08@qq.com>
 <c052918c13069cfcf768d03518560c65c990b220.camel@icenowy.me>
 <tencent_1C21558D2A7C7B8251DA4E8E08B82E313C08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zGrM3zVsiNMs8DNg"
Content-Disposition: inline
In-Reply-To: <tencent_1C21558D2A7C7B8251DA4E8E08B82E313C08@qq.com>


--zGrM3zVsiNMs8DNg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 11:10:49AM +0800, Yangyu Chen wrote:
> > On Mar 25, 2024, at 00:23, Icenowy Zheng <uwu@icenowy.me> wrote:
> > =E5=9C=A8 2024-03-23=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 20:12 +0800=EF=
=BC=8CYangyu Chen=E5=86=99=E9=81=93=EF=BC=9A
> >> - Svpbmt and T-Head MAEE both supported
> >>=20
> >> T-Head C908 does support both Svpbmt and T-Head MAEE for page-based
> >> memory
> >> attributes and is controlled by BIT(21) on CSR.MXSTATUS. The Svpbmt
> >> is used
> >> here for mainline kernel support for K230. If the kernel wants to use
> >> Svpbmt, the M-Mode software should unset BIT(21) of CSR.MXSTATUS
> >> before
> >> entering the S-Mode kernel. Otherwise, the kernel will not boot, as 0
> >> on
> >> T-Head MAEE is NonCachable Memory. Once the kernel switches from bare
> >> metal
> >> to Sv39, It will lose dirty cache line modifications that haven't
> >> been
> >> written back to the memory.
> >=20
> > As MXSTATUS has a S-mode read-only mirror known as SXSTATUS, maybe the
> > kernel should detect SXSTATUS to decide whether to use Svpbmt or
> > Xtheadpbmt (BTW Svnapot conflicts with Xtheadpbmt too).
> >=20
>=20
> Thanks for this hint. I may need to change some code in the T-Head PBMT p=
robe.

For now, I'd rather we just focused on supporting the standard
extensions on this SoC in mainline. I've applied the patches re-doing
the Kconfig options just now, feel free to resend these patches
whenever.

Thanks,
Conor.

--zGrM3zVsiNMs8DNg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhAeOgAKCRB4tDGHoIJi
0s3NAP9jV2FX5X2ERdKTaT8zG4y7prr8i8ld575p2m0u1mmbNQD/SIHdnbGSOOp0
XurrRRps4Y469JrQ/R9fmQG+RFel5AY=
=Xusz
-----END PGP SIGNATURE-----

--zGrM3zVsiNMs8DNg--


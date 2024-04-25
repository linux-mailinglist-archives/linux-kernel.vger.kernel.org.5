Return-Path: <linux-kernel+bounces-158868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEC78B2604
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE571C214E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D159A14C58E;
	Thu, 25 Apr 2024 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMWkQFx+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102A214C5A1;
	Thu, 25 Apr 2024 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061346; cv=none; b=TpuFpwYP6jsIxXbiuvKhCcQcttRPeMC/YEPE9YUEZ6kV36tlrTjoNHodQMPNXFnNH7uHiymtCR6W87Lm+YA1I70381UUUaPwTDv0wDLylJJWQoaDxx4QBM42Naf5WhZRHkVrD1whq8JHTCpIwWBcQsL/PdDLp0jNjHF3eAzuMLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061346; c=relaxed/simple;
	bh=FTrKsEK9u+1f+WVvM2+molxlrqj0kgxFuQGWcVqqr7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQPmyddEFe/BS41uqtUCz/YXRe9tA4ahHRPGw48lfdGAtvStKoUHysxwK+FkppraKt+GxHKLjsYhSobM5/W0rih58jfq72bBDH0vBOjd4Im0dHsEz8gOzk0REiRl6tq9HbpCLB3pQJ+QmRVXp5d03e6NXeQBQv5f8q92cO8J+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMWkQFx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC1CC113CC;
	Thu, 25 Apr 2024 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714061345;
	bh=FTrKsEK9u+1f+WVvM2+molxlrqj0kgxFuQGWcVqqr7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMWkQFx+x/CCWQeoUDVJPUbbOgW4mPlz09ekJzbhigPPuGd6Atk2xoiLq1+m6hFjN
	 TDf0FMt7LkHtPRYpQmTcXErgNoscc2Hig9jimJ32RyxG2wAc+rlBbqlNgeNs7d366S
	 va1LfGEmKf6S5ulBmUbbo4PWoZBAfqkM68q97SGAbnkrlvXF6TlFJRo6nyz4Dm0SWZ
	 HLwBPde9lFS9C4gVm6lIOszZxTFgXG978zL6ITa2UI3mU7DXrJfZHX3JxMFy14J3Am
	 lcqa+L5wpn+Lz1ONTxRaEcuNubfOichSvrGBMXf6RTKilkZoiDJmVPoYUa4W+WyMZZ
	 rRefHBz9rP/uA==
Date: Thu, 25 Apr 2024 17:08:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
	Neil Jones <neil.jones@blaize.com>,
	Matt Redfearn <matthew.redfearn@blaize.com>,
	James Cowgill <james.cowgill@blaize.com>,
	"heiko.stuebner@cherry.de" <heiko.stuebner@cherry.de>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"macromorgan@hotmail.com" <macromorgan@hotmail.com>,
	"sre@kernel.org" <sre@kernel.org>,
	"hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
	"andre.przywara@arm.com" <andre.przywara@arm.com>,
	"rafal@milecki.pl" <rafal@milecki.pl>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andersson@kernel.org" <andersson@kernel.org>,
	"konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"nfraprado@collabora.com" <nfraprado@collabora.com>,
	"u-kumar1@ti.com" <u-kumar1@ti.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/5] Add support for Blaize BLZP1600 SoC
Message-ID: <20240425-purity-sniff-e17c1bcae41e@spud>
References: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t3SiQWMSb1DFPZBL"
Content-Disposition: inline
In-Reply-To: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>


--t3SiQWMSb1DFPZBL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 09:15:02AM +0000, Niko Pasaloukos wrote:
> Adds basic support for the Blaize BLZP1600 SoC.
> This SoC contains two cores of Cortex-A53 CPUs, one Blaize
> Graph Streaming Processor (GSP) and several other IPs.
>=20
> V3 changes:
>  * Removed unnecessary dt-bindings
>  * Update SoBs
>=20
> V2 changes:
>  * Update SoBs
>  * `make dtbs_check` has no warnings
>  * Fix dts names and removed dead code
>  * DTS is separated from anything else
>=20
> Nikolaos Pasaloukos (5):
>   dt-bindings: Add Blaize vendor prefix
>   dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
>   arm64: Add Blaize BLZP1600 SoC family
>   arm64: Add initial support for Blaize BLZP1600 CB2
>   arm64: defconfig: Enable ARCH_BLAIZE_BLZP1600
>=20
>  .../devicetree/bindings/arm/blaize.yaml       |  40 ++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm64/Kconfig.platforms                  |   5 +
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/blaize/Makefile           |   2 +
>  .../boot/dts/blaize/blaize-blzp1600-cb2.dts   |  84 +++++++
>  .../boot/dts/blaize/blaize-blzp1600-som.dtsi  |  23 ++
>  .../boot/dts/blaize/blaize-blzp1600.dtsi      | 209 ++++++++++++++++++
>  arch/arm64/configs/defconfig                  |   1 +

I dunno if you've yet had any comment from Arnd on this series, but I'd
expect that the blaize patches follow the same path via the soc tree as
any other platform. I presume either you or one of the other Blaize guys
on this patchset will be taking care of that, so it would be a good idea
to add a MAINTAINERs entry covering the new arch/arm64/boot/dts/blaize
directory. There should be some more info about some of the expectations
at:
https://docs.kernel.org/process/maintainer-soc.html

--t3SiQWMSb1DFPZBL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiqAGQAKCRB4tDGHoIJi
0r/KAQDcecWoUKa9ZVb67zgNMKGcUaACpAVq/7o/0yGK05aTCgD/SxtOa05ISKUg
UkKxK6lXzfAPkCs9yRyq0dJFOAEDcg0=
=9uV6
-----END PGP SIGNATURE-----

--t3SiQWMSb1DFPZBL--


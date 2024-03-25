Return-Path: <linux-kernel+bounces-116915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D5988A517
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF37C1F2AAC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC33A19F53A;
	Mon, 25 Mar 2024 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXek09c6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4289815664F;
	Mon, 25 Mar 2024 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365061; cv=none; b=kN1aGVkHYg5HU2+M9gKRwBEts5oVM4jzI8yR1nFiveAwS6WgGICS790kkk77l6lTK28b3LBnLT+Xw9+p9hZBYOU/LroUvH5Tm6519aLYbLZzXDuSSN4BLbX68NRc/IsUEbtZmqygT+QnWpiDeUQg22+u0vENn0Ls+eJMDW6ueGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365061; c=relaxed/simple;
	bh=nM8sx42xDx95HRJ1wPccausmC0pYy6OVh8wnJGrVyxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8IjNvAJfNhojIqY+o2/dbekQMsRBSoj9h9eCB7RvoAIDP10QrE+yM+ZSnzZGN9oPcWsq2uSpMBBAQliYiVfW3HhUDwpfFZzS6dO1/cTbCDBx/k13fVjmcE+1TiPLTJnv87k4BkCMokKL+UggBkPvIAeFYD7oMJ1T99PIR3UGFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXek09c6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3897CC433F1;
	Mon, 25 Mar 2024 11:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711365060;
	bh=nM8sx42xDx95HRJ1wPccausmC0pYy6OVh8wnJGrVyxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXek09c6cW+G+x6iB1Jv6w5GUQmW9OLkvmUdoL+mdCU1yXcp6oJfVVuTBUC3Q/Cyk
	 NX3khylkoegm4UxLO1a0/ubyu6hdMd3PDa2CfU6mEA6W8YvYR2h2XJjTTef1YDIHYc
	 mj7rziUUjF9kvF6abIm7GB1Lkb2WOZcIWmrns4EPMTsA3YoWh8H3yKDJzFLRQ+F2fJ
	 O4/4Vo2/eaChhs1clAYhDWr1XbaTG0p6zqKNeO9LefMbklD84RICylMiSLMkmnU+CI
	 C9l6dyDXhurJtzLvruf9J7nlugslgxzuiSkKw2UtQdbuwZ6hPXXVhDMvw0RAyfJQ5A
	 8tKoT0ncUKN/g==
Date: Mon, 25 Mar 2024 11:10:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yangyu Chen <cyy@cyyself.name>, linux-riscv@lists.infradead.org,
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
Subject: Re: [PATCH v6 05/11] riscv: Kconfig.socs: Split ARCH_CANAAN and
 SOC_CANAAN_K210
Message-ID: <20240325-slept-collie-9cdb65f2a94c@spud>
References: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com>
 <tencent_F208A26B5338C6E14AC6648730368AF0FD0A@qq.com>
 <e255a964-27bf-4eb9-8e9a-4f60d1ccd12b@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wGBS4mUdIPIRsN3V"
Content-Disposition: inline
In-Reply-To: <e255a964-27bf-4eb9-8e9a-4f60d1ccd12b@moroto.mountain>


--wGBS4mUdIPIRsN3V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 01:52:42PM +0300, Dan Carpenter wrote:
> On Sat, Mar 23, 2024 at 08:12:17PM +0800, Yangyu Chen wrote:
> > Since SOC_FOO should be deprecated from patch [1], and cleanup for other
> > SoCs is already on the mailing list [2,3,4], we remove the use of
> > SOC_CANAAN and use ARCH_CANAAN for SoCs vendored by Canaan instead from
> > now on. And allows ARCH_CANAAN to be selected for other Canaan SoCs.
> >=20
> > Then, since we have Canaan Kendryte K230 with MMU now, the use of
> > SOC_CANAAN is no longer only referred to K210. Thus, we introduce a new
> > symbol SOC_CANAAN_K210 for any conditional code or driver selection
> > specific to the K210, so users will not try to build some K210-specific
> > things when MMU is enabled and see it fails to boot on K210.
> >=20
> > [1] https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@k=
ernel.org/
> > [2] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7e=
d0a@spud/
> > [3] https://lore.kernel.org/linux-riscv/20240305-fled-undrilled-41dc0c4=
6bb29@spud/
> > [4] https://lore.kernel.org/linux-riscv/20240305-stress-earflap-d7ddb86=
55a4d@spud/
> >=20
> > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> > ---
> >  arch/riscv/Kconfig.socs                        | 8 +++++---
> >  arch/riscv/Makefile                            | 2 +-
> >  arch/riscv/configs/nommu_k210_defconfig        | 3 ++-
> >  arch/riscv/configs/nommu_k210_sdcard_defconfig | 3 ++-
> >  4 files changed, 10 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 623de5f8a208..5710aee456ac 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -72,11 +72,13 @@ config SOC_VIRT
> >  	  This enables support for QEMU Virt Machine.
> > =20
> >  config ARCH_CANAAN
> > -	def_bool SOC_CANAAN
> > +	bool "Canaan Kendryte SoC"
> > +	help
> > +	  This enables support for Canaan Kendryte SoC platform hardware.
> > =20
> > -config SOC_CANAAN
> > +config SOC_CANAAN_K210
>=20
> This breaks git bisect, right?  There are references to SOC_CANAAN that
> are get updated later in the patch series.  You can't delete SOC_CANAAN
> and leave the other references dangling.

Right. I thought that I had said to resend the patch from v5 and solicit
acks to take it via the soc tree [1]. Splitting it out like this means you
have to introduce a symbol that shadows the original one and then switch
only once all references have been removed. If this series went into 6.10,
which it should, the switch would be in 6.11. I think the chances of a
meaningful conflict are low with the treewide swap so it should be safe
to do.


1 - https://lore.kernel.org/all/20240320-ideology-pasty-d3aea07cc519@spud/

--wGBS4mUdIPIRsN3V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgFbvwAKCRB4tDGHoIJi
0uSwAP95G4FiQlISuzAR9Fwa0rZx0NdUZQm9zCWUnZVjAvWBpwD/TRvaSY/ZlNhe
Uuf98Lvqw1twNosFPzpGll8glXobsQ4=
=Ztlu
-----END PGP SIGNATURE-----

--wGBS4mUdIPIRsN3V--


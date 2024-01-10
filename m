Return-Path: <linux-kernel+bounces-22284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D611E829BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60163B21B06
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FDF495CC;
	Wed, 10 Jan 2024 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1LOsVQs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2F48CEC;
	Wed, 10 Jan 2024 13:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C05C433C7;
	Wed, 10 Jan 2024 13:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704894796;
	bh=jlMp/lpi2wGBwS24WgYMjKdamYROtFScTQ27uHssC90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1LOsVQsdC6C0Ev+AVzJ6qcas/m9YtdmXZwSJirqRWZMAASZHZJSzm7BmlZbb3LdO
	 A/+bAeG0/3+OvM5+cG3kismKx4ZWGKn9JGzIXmqx/+uWOLXL5stNY1cFlhmF+/XbPm
	 G46Ip3Z39F6OLqeeTO3FPoUDZZ1nTvXcuaAIw0oinmOzZnKy7lr6UCFQbldsJR1fiy
	 43crXl/NLmVHV8fhegmrW9mp4Do+WkH8a8emgIkguxqtP88veZRVVeRBN7psiKffOz
	 DPaDY6BBtVBeUr3JrbJvvBYkIt6SH2Sh6V9ecRAT38GHi1JHQJ5At/sogKFLzig3So
	 PapKmX/sgVHoQ==
Date: Wed, 10 Jan 2024 13:53:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] riscv: dts: starfive: add Milkv Mars board device
 tree
Message-ID: <20240110-eternal-proofing-8a33201ff727@spud>
References: <20231202153353.635-1-jszhang@kernel.org>
 <CAJM55Z-9Y=QitvAX+z=XTTMM0CGRzGMD5z0H_Bzv=Q85b49rpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ggN6li4P/Qv8olF8"
Content-Disposition: inline
In-Reply-To: <CAJM55Z-9Y=QitvAX+z=XTTMM0CGRzGMD5z0H_Bzv=Q85b49rpQ@mail.gmail.com>


--ggN6li4P/Qv8olF8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 02:07:50PM -0800, Emil Renner Berthing wrote:
> Jisheng Zhang wrote:
> > The Milkv Mars is a development board based on the Starfive JH7110 SoC.
> > The board features:
> >
> > - JH7110 SoC
> > - 1/2/4/8 GiB LPDDR4 DRAM
> > - AXP15060 PMIC
> > - 40 pin GPIO header
> > - 3x USB 3.0 host port
> > - 1x USB 2.0 host port
> > - 1x M.2 E-Key
> > - 1x eMMC slot
> > - 1x MicroSD slot
> > - 1x QSPI Flash
> > - 1x 1Gbps Ethernet port
> > - 1x HDMI port
> > - 1x 2-lane DSI and 1x 4-lane DSI
> > - 1x 2-lane CSI
> >
> > patch1 adds 'cpus' label
> > patch2 adds "milkv,mars" board dt-binding
> > patch3 adds the devicetree file describing the currently supported
> > features:
> > Namely PMIC, UART, I2C, GPIO, SD card, QSPI Flash, eMMC and Ethernet.
> >
> > Since v1:
> >  - add two new patches which add "cpus" label and board dt-binding
> >  - adopt Krzysztof's suggestions, thanks
> >
> > Hi Conor,
> >
> > I see you have sent a patch which moves the timebase-frequency property
> > to soc dtsi, but this series doesn't rebase on that. I can update it
> > once your patch is merged.
>=20
> Hi Jisheng,
>=20
> Thanks for working on this! On the JH7110 the mtime derives almost direct=
ly
> from the external oscillator like this:
>=20
> osc (24MHz) -> rtc_toggle (div 6) -> mtime (4MHz)
>=20
> So to me it makes sense to define the timebase-frequency in the same file=
 as
> the frequency of the external oscillator.
>=20
> In general it looks good, but if you do
>=20
>   diff -Naur jh7110-{starfive-visionfive-2.dtsi,milkv-mars.dts}
>=20
> you'll see that those two files are almost identical. Even external clock
> speeds and all the pin configuration are the same. I'd strongly prefer to=
 have
> all that factored out in a common .dtsi so fixes don't get out of sync.

I'm gonna mark this as changes requested on patchwork because of this
comment. LMK if you don't think this is worth another version Emil.

Cheers,
Conor.

--ggN6li4P/Qv8olF8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ6hRwAKCRB4tDGHoIJi
0ogBAP4x6iIaTIAS0a/hkKmtjptbBiq1ANLlQfOZxqAPiMlsUwEA5dWpLAZgdPrE
K8VcCEsLp5nb905zt+fOFYC1bPFoEQY=
=aqtW
-----END PGP SIGNATURE-----

--ggN6li4P/Qv8olF8--


Return-Path: <linux-kernel+bounces-13395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E231782048D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7242DB20CA1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9C38827;
	Sat, 30 Dec 2023 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZFzg4qV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D4679DF;
	Sat, 30 Dec 2023 11:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B258FC433C8;
	Sat, 30 Dec 2023 11:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703935579;
	bh=1OU6bdZKEl1WLY5wGxuQyuaZq2DtMwE1qATuY4qDn68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZFzg4qVLDXV07uKa0HE1SS7SlNAQO4dpWs6Bgk7Zxpoeut9Yi1uqqN0p2Q1zPfBc
	 HlZM596sgELuISXmOcsZ0h2lDgV5QjRztUcQ6imtp3bfIvzPmbL7TliTvftA2aZlsm
	 26i8flLTQd+aUbzUCbt6Hbrq2QtG2xZkrVwppFndotRFwFNEQ+LVn7eQBEZpcjjqUP
	 ohdnO4AvDcpdeFD/Yis952QulkZP/rVFcAuyD+unrQokSt3evYc2ywZ3jPfvMD1dT/
	 8y5HnculLF/Y95KH4vLLJlKwOTmrjCQypyW6J+uO5LI/c4AWv6aNHBOfMY9oKkBItx
	 6hjx4242WDRsg==
Date: Sat, 30 Dec 2023 11:26:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: dfustini@baylibre.com, Paul Walmsley <paul.walmsley@sifive.com>,
	aou@eecs.berkeley.edu, jszhang@kernel.org, guoren@kernel.org,
	wefu@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/4] riscv: defconfig: Enable mmc and dma drivers for
 T-Head TH1520
Message-ID: <20231230-drudge-snarl-d7a84f843161@spud>
References: <20231129-th1520_mmc_dts-v7-1-c77fc19caa6f@baylibre.com>
 <mhng-577f4913-06ac-4f80-8793-6336132d503e@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6xe6WHVqFSp45+hX"
Content-Disposition: inline
In-Reply-To: <mhng-577f4913-06ac-4f80-8793-6336132d503e@palmer-ri-x1c9>


--6xe6WHVqFSp45+hX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 06:42:01PM -0800, Palmer Dabbelt wrote:
> On Wed, 29 Nov 2023 17:48:47 PST (-0800), dfustini@baylibre.com wrote:
> > Enable the mmc controller driver and dma controller driver needed for
> > T-Head TH1520 based boards, like the LicheePi 4A and BeagleV-Ahead, to
> > boot from eMMC storage.
> >=20
> > Reviewed-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> >  arch/riscv/configs/defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> > index 905881282a7c..e635dc9d1997 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -214,6 +214,7 @@ CONFIG_MMC=3Dy
> >  CONFIG_MMC_SDHCI=3Dy
> >  CONFIG_MMC_SDHCI_PLTFM=3Dy
> >  CONFIG_MMC_SDHCI_CADENCE=3Dy
> > +CONFIG_MMC_SDHCI_OF_DWCMSHC=3Dy
> >  CONFIG_MMC_SPI=3Dy
> >  CONFIG_MMC_DW=3Dy
> >  CONFIG_MMC_DW_STARFIVE=3Dy
> > @@ -223,6 +224,7 @@ CONFIG_RTC_CLASS=3Dy
> >  CONFIG_RTC_DRV_SUN6I=3Dy
> >  CONFIG_DMADEVICES=3Dy
> >  CONFIG_DMA_SUN6I=3Dm
> > +CONFIG_DW_AXI_DMAC=3Dy
> >  CONFIG_RZ_DMAC=3Dy
> >  CONFIG_VIRTIO_PCI=3Dy
> >  CONFIG_VIRTIO_BALLOON=3Dy
>=20
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> in case folks want to keep this with the DTS updates.  Thanks!

Just echoing what I said on irc, I already send the subsequent version
of the series to Arnd, minus the defconfig patch, so if you could take
this yourself Palmer, that'd be great.

Cheers,
Conor.


--6xe6WHVqFSp45+hX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZY/+VgAKCRB4tDGHoIJi
0s/JAQDtPyBlwd7KEb9L4HtWe6TX6DE+iVwM/agBaJp+y5GadAD/RCu9FNnwEiak
OoUzBlhASe6hIOwwJuoTkjeNRl57kQM=
=FY5q
-----END PGP SIGNATURE-----

--6xe6WHVqFSp45+hX--


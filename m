Return-Path: <linux-kernel+bounces-91211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B255870B40
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418181F2115E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B079A7A731;
	Mon,  4 Mar 2024 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k85dEHj8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E693962171;
	Mon,  4 Mar 2024 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583193; cv=none; b=SElJdsKfK5Jc8KI9giwMScnQzM1fPAMJ6B2Om3iBbGzDNyFQfT0gdwXKuzw/B+eNkIke9+fHTx+tQqy7w9d0FAAy7YPGw79o2OB53okR5Uj9HPalmO6YZ4G+sBkVOLXiKG9wx7vqTiS4WV8DKwLjzfJZAI4e9z9QAfneFDMUHQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583193; c=relaxed/simple;
	bh=Jarf+3xgm31a5ItvIpY/7IPTj0Vs8zmgBoIbgY65ZsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S20gJAshz2YikDTv17kjrr7UPCxho2F52f6k77wdzK70ZoyLxx9qyy/OenGAeyKa2f6jiOAlPs7g9HRPdkuNY2OnsT5B9iTUH+G9aHtyAIVERudF8br+F5ZPVAWY5n7wwQeeImc0ib3Nkxi3v3rc3TEBaixK3NYHceHLbYaX384=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k85dEHj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424EFC433F1;
	Mon,  4 Mar 2024 20:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709583192;
	bh=Jarf+3xgm31a5ItvIpY/7IPTj0Vs8zmgBoIbgY65ZsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k85dEHj8+jTdrQGFPCxKUTyZPYtvSW8yVrZPUefH7fCrOBySUGu/XDD0+cXAil+Ro
	 UVIh278q4HvcZPCDWkfAm4xmc/qbitRfQFj6C2AO35cx8ZwNppPqtPdSbIssr18miG
	 mBKplj0BBKFKN2LuTbpAa3rG2oO3bzCGESDE9m1/W4DiOolIFHAanor8J+OVwLuoyu
	 KJ0G2b7tczan5XxTPfVhF/GjEPvSX+n7eKt9dYVbqYVe720b62X1DvKsyIgy4isBAm
	 h8CpL64c69YnJoq4LiRG7iYPrnTmRjiImLi4cYEFrzKKrL1hR6NY1HLfAK2a8CjSHt
	 gxEdL2IZSXYHQ==
Date: Mon, 4 Mar 2024 20:13:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <20240304-cape-saloon-80f241bfd6df@spud>
References: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
 <20240227-asrc_8qxp-v2-3-521bcc7eb1c0@nxp.com>
 <20240229-husband-penalty-8c1ab0f57f55@spud>
 <20240229-rundown-isotope-954ba9ea4c57@spud>
 <ZeDdMJlxBL4SGkws@lizhi-Precision-Tower-5810>
 <20240301-crudeness-resale-3c0a1228850d@spud>
 <ZeIGXEJ3l4tgjmxT@lizhi-Precision-Tower-5810>
 <20240301-deluxe-tiptoeing-741af7d620b9@spud>
 <ZeIPmGG7+5cKZkO3@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G/bhWJ7YMFFq+jSj"
Content-Disposition: inline
In-Reply-To: <ZeIPmGG7+5cKZkO3@lizhi-Precision-Tower-5810>


--G/bhWJ7YMFFq+jSj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 12:25:44PM -0500, Frank Li wrote:
> On Fri, Mar 01, 2024 at 05:07:07PM +0000, Conor Dooley wrote:
> > On Fri, Mar 01, 2024 at 11:46:20AM -0500, Frank Li wrote:
> > > On Fri, Mar 01, 2024 at 04:05:25PM +0000, Conor Dooley wrote:
> > > > On Thu, Feb 29, 2024 at 02:38:24PM -0500, Frank Li wrote:
> > > > > On Thu, Feb 29, 2024 at 06:57:29PM +0000, Conor Dooley wrote:
> > > > > > On Thu, Feb 29, 2024 at 06:55:58PM +0000, Conor Dooley wrote:
> > > > > > > On Tue, Feb 27, 2024 at 03:54:11PM -0500, Frank Li wrote:
> > > > > > > > Some sai only connect one direction. So allow only "rx" or =
"tx" for
> > > > > > > > dma-names.
> > > > > > >=20
> > > > > > > Which sai? Can you restrict this per compatible please, so th=
at someone
> > > > > > > cannot add 2 dmas for ones where only the tx is supported.
> > > > > > >=20
> > > > > > > |  dmas:
> > > > > > > |    minItems: 1
> > > > > > > |    items:
> > > > > > > |      - description: DMA controller phandle and request line=
 for RX
> > > > > > > |      - description: DMA controller phandle and request line=
 for TX
> > > > > > >=20
> > > > > > > The binding already allows only one, but it documents that th=
e first dma
> > > > > > > is always the RX dma, and that doesn't change with this patch=
=2E.
> > > > > >=20
> > > > > > I said "doesn't change" - but I don't think you can change this
> > > > > > trivially, as something could rely on the first dma being the r=
x one.
> > > > > > You'd have to check that there is nothing using these using ind=
ices
> > > > > > rather than names before making any changes here.
> > > > >=20
> > > > > Linux driver and dts with tx only work well. Only issue is dtb_ch=
eck will
> > > > > report error. I want to eliminate these DTB_CHECK warning.
> > > >=20
> > > > Linux is not the only user of these bindings, citing linux as your
> > > > evidence here is only sufficient if no other users exist. Do they?
> > >=20
> > > But, 'dmas' should be common property for all these bindings? I don't=
 think
> > > they use 'descriptions:' property, which should guide dts writer to w=
rite
> > > dts file. actually words 'DMA controller phandle and request line' ju=
st
> > > nonsense words. let 'regs', it'd better descript at 'reg-names' inste=
ad
> > > of 'regs' if reg-names exist. Only meansful words is "RX" and "TX", w=
hich
> > > already show at "dma-names".
> >=20
> > None of this matters. If there's a documented order for these, which
> > there is, software is not obligated to use the names and can rely on the
> > order alone. You need to check that there are no other users which will
> > be broken by your proposed change.
>=20
> As my best knowledge, only linux use this binding.

If you've checked and there are no users, that's fine. Please mention
in the commit message that there are no users that will be affected as
justification for the ABI change.

--G/bhWJ7YMFFq+jSj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeYrUgAKCRB4tDGHoIJi
0kXGAP0ZXQDdSBHtYgiW6KEtRSeHnNW+Qzp4Xi6aG6/WngSB7wEAkXcAGBBLZxUQ
3gj8XZWrnoAYzbHNua6AJZOzWa0FEQY=
=OdYx
-----END PGP SIGNATURE-----

--G/bhWJ7YMFFq+jSj--


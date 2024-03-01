Return-Path: <linux-kernel+bounces-88797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EFF86E6BA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9111F259EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D095C9A;
	Fri,  1 Mar 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o79NRdtq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5108259B;
	Fri,  1 Mar 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312833; cv=none; b=JBc4IYK37bA6OsxXJbVBKrEJC/KliTuqHcQQNm5N+v2tthntPHBGTs89SAeGwWpySc5GWviMFZxpcTcWvPLI2V23xU8dkMM/DkCOaonSqXyRGh/wErqvOw7XlnuVezy5d1XMp4f9nf3KkXEvScRj8Rj3H2wqLziYperLOiERKN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312833; c=relaxed/simple;
	bh=rykT00e9RnV6xM7py0pfTSN+OEy9OLvHdbWKnJFpStA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEz9CZyyF1Ff9AvVGP4WxGe4vY16VK2Qw91bfCRWK5Fzt8GGVRhekqYee3EZj6zkVOYHQZ0q6GZJXs0/0jIwuetyjDrmzf+FbkuwUELzK2NGj/7E8vp8FrnXiss8mOJJmXvXYdtFw4JGdchWZq0h0KNmh2I6IwPpPzXuduc5hpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o79NRdtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F3FC433C7;
	Fri,  1 Mar 2024 17:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709312833;
	bh=rykT00e9RnV6xM7py0pfTSN+OEy9OLvHdbWKnJFpStA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o79NRdtq9bnUSEFuF4Du6Ce8be3X47MSFGfJJNzs56mnVYLPYxQiBGiXr1huhMbNE
	 kg2dvmcCHxih7O+06875vfQwdNGSxLpawql30wk4YhOc2xYqW5aaQ92GjGdSfr2qvZ
	 dRO8zWESf++QVH+HN/32QC+23RiTm5t3dBYfNAd9xacDfrQMv2sz1xYEoSla4j80Cm
	 M3SmxxeT8WTryqGBobvVx4jOUgu3JQc7Qoq6fPDxc2wi8g6D9rIxz0LHmKP9naKeeE
	 Au+jvNRTKsDC+o49XFE6S4cROK3wkgZY18iw8mUdD/oUSAK1ZzyuoJUafeLo/25vJ6
	 NgiP3JyZCul3Q==
Date: Fri, 1 Mar 2024 17:07:07 +0000
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
Message-ID: <20240301-deluxe-tiptoeing-741af7d620b9@spud>
References: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
 <20240227-asrc_8qxp-v2-3-521bcc7eb1c0@nxp.com>
 <20240229-husband-penalty-8c1ab0f57f55@spud>
 <20240229-rundown-isotope-954ba9ea4c57@spud>
 <ZeDdMJlxBL4SGkws@lizhi-Precision-Tower-5810>
 <20240301-crudeness-resale-3c0a1228850d@spud>
 <ZeIGXEJ3l4tgjmxT@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6B1Z/Uo6ygJQ4MXY"
Content-Disposition: inline
In-Reply-To: <ZeIGXEJ3l4tgjmxT@lizhi-Precision-Tower-5810>


--6B1Z/Uo6ygJQ4MXY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 11:46:20AM -0500, Frank Li wrote:
> On Fri, Mar 01, 2024 at 04:05:25PM +0000, Conor Dooley wrote:
> > On Thu, Feb 29, 2024 at 02:38:24PM -0500, Frank Li wrote:
> > > On Thu, Feb 29, 2024 at 06:57:29PM +0000, Conor Dooley wrote:
> > > > On Thu, Feb 29, 2024 at 06:55:58PM +0000, Conor Dooley wrote:
> > > > > On Tue, Feb 27, 2024 at 03:54:11PM -0500, Frank Li wrote:
> > > > > > Some sai only connect one direction. So allow only "rx" or "tx"=
 for
> > > > > > dma-names.
> > > > >=20
> > > > > Which sai? Can you restrict this per compatible please, so that s=
omeone
> > > > > cannot add 2 dmas for ones where only the tx is supported.
> > > > >=20
> > > > > |  dmas:
> > > > > |    minItems: 1
> > > > > |    items:
> > > > > |      - description: DMA controller phandle and request line for=
 RX
> > > > > |      - description: DMA controller phandle and request line for=
 TX
> > > > >=20
> > > > > The binding already allows only one, but it documents that the fi=
rst dma
> > > > > is always the RX dma, and that doesn't change with this patch..
> > > >=20
> > > > I said "doesn't change" - but I don't think you can change this
> > > > trivially, as something could rely on the first dma being the rx on=
e.
> > > > You'd have to check that there is nothing using these using indices
> > > > rather than names before making any changes here.
> > >=20
> > > Linux driver and dts with tx only work well. Only issue is dtb_check =
will
> > > report error. I want to eliminate these DTB_CHECK warning.
> >=20
> > Linux is not the only user of these bindings, citing linux as your
> > evidence here is only sufficient if no other users exist. Do they?
>=20
> But, 'dmas' should be common property for all these bindings? I don't thi=
nk
> they use 'descriptions:' property, which should guide dts writer to write
> dts file. actually words 'DMA controller phandle and request line' just
> nonsense words. let 'regs', it'd better descript at 'reg-names' instead
> of 'regs' if reg-names exist. Only meansful words is "RX" and "TX", which
> already show at "dma-names".

None of this matters. If there's a documented order for these, which
there is, software is not obligated to use the names and can rely on the
order alone. You need to check that there are no other users which will
be broken by your proposed change.

> > > And it also reasonable, only rx or tx for a special SAI.
> > >=20
> > > Can we remove 'description'? dmas should already descripted at common=
 place
> > > and 'RX' and 'TX' are listed at 'dma-names'
> >=20
> > Removing the description has the same problem. The existing binding has
> > set a fixed order that you now want to make flexible.
>=20
> Actually original set minItems: is 1, which means allow 1 channel. but
> set items to force two channel.=20
>=20
> Does it work
>=20
> oneOf:
>   items:=20
>   	- description: TX
> 	- description: RX
>   items:
> 	- description: TX
>   items:
> 	- description: RX
>=20
> >=20
> > Thanks,
> > Conor.
>=20
>=20

--6B1Z/Uo6ygJQ4MXY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeILOwAKCRB4tDGHoIJi
0vPRAQD30nLmqvnQSjER93Ue59P+ueynbOrDKfMBE0R2y7D7TAD+NnAAqA7ycgcG
24A0m2khdUZJAoZ7TGqfgOL5wSHiMww=
=Mxzk
-----END PGP SIGNATURE-----

--6B1Z/Uo6ygJQ4MXY--


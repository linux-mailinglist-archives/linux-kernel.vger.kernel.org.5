Return-Path: <linux-kernel+bounces-88661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AD786E4F5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E03284A80
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F5C70CB1;
	Fri,  1 Mar 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QK6yF6U2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AC338DC3;
	Fri,  1 Mar 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309131; cv=none; b=Tt+0qk+/7TKO55mQ48Qevh8bK3nPYHdyrcEggpqJZGhDhYcipn1MRiWuFn0dXBG7pm6LT1sTfDZ60VeNrGkszN72rvEkdaNEO47HdmV2W2CDNktPA//OIaPGwJmxasIAe+CzAqzxvOpOaKOXdTAwLQj8eZUC8K+Y6i7lR9NJjWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309131; c=relaxed/simple;
	bh=rVW9AEO5L6z97bsCb2BGNYw/xLkhAfUG8wSYzGdCvpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dibLd5t1C3dt2hJnlH95khW3F4qFSiEw+Vi+qCMwik+yWhSXtbA6/d/1cJetOf9c7snJk+yiN4ZJ+0T0wH2jOwbQsECcUJ3cOuSbp6E3bEDinvEuaPk7y2Z94wtadl9qOZ2UWAja9TeTORJnmsqGCDgsT6mQkrEg7iH23gqIMD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QK6yF6U2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A74EC433C7;
	Fri,  1 Mar 2024 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709309130;
	bh=rVW9AEO5L6z97bsCb2BGNYw/xLkhAfUG8wSYzGdCvpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QK6yF6U22HPa80VMPZAdA7clsYc9ldvaMPHwnU5+38ck6ghTDFZTooOQEeB8XCJZs
	 kW7HIAMXb1aBdpmlDNYlNpXMaHrXb8WGYbRDCkEZ4P2VCIL66n2Mc/0WQxWdwepQZo
	 1SMRFqzIMYdySBoKVlUAckwRDxejhqFJFfvf0ErfsO2cB6eepTJPRKNW2v3sJABQDb
	 EV6un8ZY706NeKCMb+Zk/xnbcqLyAbWNApVzoI1ub9muV9nHm7m6fnRtv2w9xSeOwk
	 o7rTs79dzwurOW1hSiSAmcJGfEmZo+/JGuNOGMAZrZFAY6kgMXY4cHi+FYDXEgwaDM
	 1/+LzEuz/alOg==
Date: Fri, 1 Mar 2024 16:05:25 +0000
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
Message-ID: <20240301-crudeness-resale-3c0a1228850d@spud>
References: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
 <20240227-asrc_8qxp-v2-3-521bcc7eb1c0@nxp.com>
 <20240229-husband-penalty-8c1ab0f57f55@spud>
 <20240229-rundown-isotope-954ba9ea4c57@spud>
 <ZeDdMJlxBL4SGkws@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zZCgftqPN9gmkuL1"
Content-Disposition: inline
In-Reply-To: <ZeDdMJlxBL4SGkws@lizhi-Precision-Tower-5810>


--zZCgftqPN9gmkuL1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 02:38:24PM -0500, Frank Li wrote:
> On Thu, Feb 29, 2024 at 06:57:29PM +0000, Conor Dooley wrote:
> > On Thu, Feb 29, 2024 at 06:55:58PM +0000, Conor Dooley wrote:
> > > On Tue, Feb 27, 2024 at 03:54:11PM -0500, Frank Li wrote:
> > > > Some sai only connect one direction. So allow only "rx" or "tx" for
> > > > dma-names.
> > >=20
> > > Which sai? Can you restrict this per compatible please, so that someo=
ne
> > > cannot add 2 dmas for ones where only the tx is supported.
> > >=20
> > > |  dmas:
> > > |    minItems: 1
> > > |    items:
> > > |      - description: DMA controller phandle and request line for RX
> > > |      - description: DMA controller phandle and request line for TX
> > >=20
> > > The binding already allows only one, but it documents that the first =
dma
> > > is always the RX dma, and that doesn't change with this patch..
> >=20
> > I said "doesn't change" - but I don't think you can change this
> > trivially, as something could rely on the first dma being the rx one.
> > You'd have to check that there is nothing using these using indices
> > rather than names before making any changes here.
>=20
> Linux driver and dts with tx only work well. Only issue is dtb_check will
> report error. I want to eliminate these DTB_CHECK warning.

Linux is not the only user of these bindings, citing linux as your
evidence here is only sufficient if no other users exist. Do they?

> And it also reasonable, only rx or tx for a special SAI.
>=20
> Can we remove 'description'? dmas should already descripted at common pla=
ce
> and 'RX' and 'TX' are listed at 'dma-names'

Removing the description has the same problem. The existing binding has
set a fixed order that you now want to make flexible.

Thanks,
Conor.

--zZCgftqPN9gmkuL1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeH8xQAKCRB4tDGHoIJi
0jzLAQDD7qaiVIh5k+1icra1khOuagWcwolMz38Pf4nuzJIXjwEAnnqTFIXEW5NP
EVc5LseIyIToZ1a+TcVfIdL4iMIvTwA=
=0N5o
-----END PGP SIGNATURE-----

--zZCgftqPN9gmkuL1--


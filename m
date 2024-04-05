Return-Path: <linux-kernel+bounces-133336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AA989A274
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8972C1F24B5F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008AD17164C;
	Fri,  5 Apr 2024 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcsClS20"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F016FF5D;
	Fri,  5 Apr 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334302; cv=none; b=AxLZqr3XVVLLhVNfApvFY3/1nj10rTs9Oep70blvJxbr9ANP9FxCdZsAW4mXNCXJnFIR51iPGwrorkEgJqtvQ6z7F5isT+MUT78R1j1MpEJ49kveUZ8z1gF6/lBfJLZm3E9Nz/N4EbRIJt5JckujHaTIYLJpnZ7dxDCExt2aVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334302; c=relaxed/simple;
	bh=e631Y6MEiUM4bdY0i8+RqUnFcYHrbYvYh4AY3c2OKqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVrxTCX+tX/B9ibu9opIwh0uV9hzcPholw7mXzxyRVvPWMXOFe/yyFPdFbAx5ujnK8Z08+5YJywaiIQmERJoiZiacIOTzqgiIphNHV7PXGMjoMQ7/KL9f4Za9ywtCUrr6y8hhUY0kHQjeJAWp/eZ10PK1Gerd/mCH40S+OMvy28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcsClS20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E052C433F1;
	Fri,  5 Apr 2024 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712334301;
	bh=e631Y6MEiUM4bdY0i8+RqUnFcYHrbYvYh4AY3c2OKqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcsClS20Fq4SLI/FbUZXI/30MEJwCw0mPfLZrr/R0EkMRetSPyJ5iYwp1vzcFPnTQ
	 3UfE9PH7aWXRdPKCpMlC36hJ2kQCuN4x6MzeGumMdjC0VsDAd3F6duoKVW+rSNrAfZ
	 +0HA8OL2NfF/FCSaULcSPyMmeRTMwuBJOcfpwaQw83HmXIJ2GmQROXqP0I8bdntGM5
	 YbxT4k39KnYQwO8QadL/IFPXiVgcc06YtlbIYY5ImjqSKvXgnQMi7YwHaMmA94jJln
	 9lFAWQ1KpmN5HlwVEOqF+1b/prbhr/0cAHdjnhCF2E8gP9x72z2l9XpeBwpuUzC0bH
	 A3LaECE2Q8gig==
Date: Fri, 5 Apr 2024 17:24:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: git@luigi311.com, linux-media@vger.kernel.org,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pavel@ucw.cz, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 18/25] dt-bindings: media: imx258: Add alternate
 compatible strings
Message-ID: <20240405-citizen-rendering-a8345fc96fb0@spud>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-19-git@luigi311.com>
 <20240403-vista-defendant-ebadbaa52059@spud>
 <CAPY8ntC9SHJ6Ma17s0Vf2coB-0NUk-xgCLK9KCkxFMuXKHXNwg@mail.gmail.com>
 <20240405-affair-cruelly-a7e9d23b597c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J+r6cgI5MeerLX5y"
Content-Disposition: inline
In-Reply-To: <20240405-affair-cruelly-a7e9d23b597c@spud>


--J+r6cgI5MeerLX5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 05:24:11PM +0100, Conor Dooley wrote:
> On Fri, Apr 05, 2024 at 11:25:50AM +0100, Dave Stevenson wrote:
> > Hi Conor
> >=20
> > On Wed, 3 Apr 2024 at 17:14, Conor Dooley <conor@kernel.org> wrote:
> > >
> > > On Wed, Apr 03, 2024 at 09:03:47AM -0600, git@luigi311.com wrote:
> > > > From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > >
> > > > There are a number of variants of the imx258 modules that can not
> > > > be differentiated at runtime, so add compatible strings for the
> > > > PDAF variant.
> > > >
> > > > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > > Signed-off-by: Luis Garcia <git@luigi311.com>
> > > > ---
> > > >  .../devicetree/bindings/media/i2c/sony,imx258.yaml       | 9 +++++=
++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx25=
8.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> > > > index bee61a443b23..c978abc0cdb3 100644
> > > > --- a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> > > > +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> > > > @@ -13,11 +13,16 @@ description: |-
> > > >    IMX258 is a diagonal 5.867mm (Type 1/3.06) 13 Mega-pixel CMOS ac=
tive pixel
> > > >    type stacked image sensor with a square pixel array of size 4208=
 x 3120. It
> > > >    is programmable through I2C interface.  Image data is sent throu=
gh MIPI
> > > > -  CSI-2.
> > > > +  CSI-2. The sensor exists in two different models, a standard var=
iant
> > > > +  (IMX258) and a variant with phase detection autofocus (IMX258-PD=
AF).
> > > > +  The camera module does not expose the model through registers, s=
o the
> > > > +  exact model needs to be specified.
> > > >
> > > >  properties:
> > > >    compatible:
> > > > -    const: sony,imx258
> > > > +    enum:
> > > > +      - sony,imx258
> > > > +      - sony,imx258-pdaf
> > >
> > > Does the pdaf variant support all of the features/is it register
> > > compatible with the regular variant? If it is, the regular variant
> > > should be a fallback compatible.
> >=20
> > It has the same register set, but certain registers have to be
> > programmed differently so that the image is corrected for the
> > partially shielded pixels used for phase detect auto focus (PDAF).
> > Either compatible will "work" on either variant of the module, but
> > you'll get weird image artifacts when using the wrong one.
>=20
> To paraphase, a fallback compatible is not suitable.

Whoops, I forgot this:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--J+r6cgI5MeerLX5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhAl1wAKCRB4tDGHoIJi
0kUVAPsHQcxSj1YlxmEykZ2pdEnrRssajk9+59xTX2aSDtjvjgD/QiU/zXLjFTnh
wmmKk8lfqMokfNL4ZXerYYFKC/oSUAY=
=wHSR
-----END PGP SIGNATURE-----

--J+r6cgI5MeerLX5y--


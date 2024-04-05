Return-Path: <linux-kernel+bounces-133335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4389A270
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E7D9B23EF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148C5171090;
	Fri,  5 Apr 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgzQSD8g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEED171078;
	Fri,  5 Apr 2024 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334257; cv=none; b=r7pHueQ1J9r57f2JuGOP2PYlHXgmQ0GHTdAv1HkaPq4GVn6gTven+48YYigKncxY2RucyZpJCw/QTLnNKzlgi4XtolyfzjxXor/xgcXsM9ynrsDm0fO/+2Z/G3hQ2jR6CFEjCJyzzuEuTnKMnJf8DRgW87MeNcbsU1XLMAaCmpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334257; c=relaxed/simple;
	bh=6JpRDvCOuHegc46R7erCygMAd1uj2iB5Om6sD8dxs6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHGOg5u2cgT/vylOfvzn15jLVeY0Rgduyd/+YmuArbD3KlDUEN025yglZOY0BpPClSpokRCGV7YsCe6tgcL7AxmSo0iWZJKFIL3Av/MsoUpGhM+1h0kFb5KeHk/swjR4Le7EBlFPJAsCYwLA2b7WPJOvaLODDb1S/dMCi97FBQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgzQSD8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2935FC433C7;
	Fri,  5 Apr 2024 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712334256;
	bh=6JpRDvCOuHegc46R7erCygMAd1uj2iB5Om6sD8dxs6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LgzQSD8g6+0ukVg19qWTPxYqtTPJlfP4azdnG0YKeUGXpgUogSoC/jh7iZDyaEwyI
	 n7KZd65j8+X0DFnKSfEAUp1s2gyyNpQQZcuE857C6bIUQ1GsWHsrTviIT3EsYMUt+l
	 SozHICPe1KDgb1Ul7AV1682paZ9MJY961AF+fqJ+eRsnF+ooW5MrRg6yXOhNfZzSMa
	 UGogYM6cWamzWapOQIOTUEwZ/VPu9jJTzw2MpdOhTw3oPI5ETQPHDYrekSGqFMnVHw
	 0XXiqX0jBf31eR/uoOCIvqc62m6vvhFn8J1yQPU8DjX0ffZPUuWe4R/hit26yKBPCt
	 wx0YrMOhSQWvA==
Date: Fri, 5 Apr 2024 17:24:11 +0100
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
Message-ID: <20240405-affair-cruelly-a7e9d23b597c@spud>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-19-git@luigi311.com>
 <20240403-vista-defendant-ebadbaa52059@spud>
 <CAPY8ntC9SHJ6Ma17s0Vf2coB-0NUk-xgCLK9KCkxFMuXKHXNwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4VSlIssbWGjCqHBw"
Content-Disposition: inline
In-Reply-To: <CAPY8ntC9SHJ6Ma17s0Vf2coB-0NUk-xgCLK9KCkxFMuXKHXNwg@mail.gmail.com>


--4VSlIssbWGjCqHBw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 11:25:50AM +0100, Dave Stevenson wrote:
> Hi Conor
>=20
> On Wed, 3 Apr 2024 at 17:14, Conor Dooley <conor@kernel.org> wrote:
> >
> > On Wed, Apr 03, 2024 at 09:03:47AM -0600, git@luigi311.com wrote:
> > > From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > >
> > > There are a number of variants of the imx258 modules that can not
> > > be differentiated at runtime, so add compatible strings for the
> > > PDAF variant.
> > >
> > > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > Signed-off-by: Luis Garcia <git@luigi311.com>
> > > ---
> > >  .../devicetree/bindings/media/i2c/sony,imx258.yaml       | 9 +++++++=
--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx258.=
yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> > > index bee61a443b23..c978abc0cdb3 100644
> > > --- a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> > > +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> > > @@ -13,11 +13,16 @@ description: |-
> > >    IMX258 is a diagonal 5.867mm (Type 1/3.06) 13 Mega-pixel CMOS acti=
ve pixel
> > >    type stacked image sensor with a square pixel array of size 4208 x=
 3120. It
> > >    is programmable through I2C interface.  Image data is sent through=
 MIPI
> > > -  CSI-2.
> > > +  CSI-2. The sensor exists in two different models, a standard varia=
nt
> > > +  (IMX258) and a variant with phase detection autofocus (IMX258-PDAF=
).
> > > +  The camera module does not expose the model through registers, so =
the
> > > +  exact model needs to be specified.
> > >
> > >  properties:
> > >    compatible:
> > > -    const: sony,imx258
> > > +    enum:
> > > +      - sony,imx258
> > > +      - sony,imx258-pdaf
> >
> > Does the pdaf variant support all of the features/is it register
> > compatible with the regular variant? If it is, the regular variant
> > should be a fallback compatible.
>=20
> It has the same register set, but certain registers have to be
> programmed differently so that the image is corrected for the
> partially shielded pixels used for phase detect auto focus (PDAF).
> Either compatible will "work" on either variant of the module, but
> you'll get weird image artifacts when using the wrong one.

To paraphase, a fallback compatible is not suitable.

Thanks Dave,
Conor.

--4VSlIssbWGjCqHBw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhAlqgAKCRB4tDGHoIJi
0kW8AP9KV3LJt1DLGYbcIRYYQzVjf5OtXnW7AC81UNn0epIypwEAwwW/zJA3Q3J0
t6MuHgfu+Sabt0Z5TRNsffWfpDbtfwI=
=6umV
-----END PGP SIGNATURE-----

--4VSlIssbWGjCqHBw--


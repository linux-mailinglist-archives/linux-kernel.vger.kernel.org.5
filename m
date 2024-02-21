Return-Path: <linux-kernel+bounces-75557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8671B85EB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81F41C23EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D17912839D;
	Wed, 21 Feb 2024 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUwpgeHS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5F25619;
	Wed, 21 Feb 2024 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551480; cv=none; b=hx8qS3rhGsg4T3XD6BoMLp1elz2s7ZlC1urW+uLUTLjgAtZAaML2Fj/X/92jr2ZUsDBd2djEh/2xAiAhUn+sDXDeZELF0CgaivcDB45cfZAicubrJqu8iSNOEN2ExcaHDT7cpKcvthF5b9hxuLbOGLpmG3WumwRNaoad7Wr0B+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551480; c=relaxed/simple;
	bh=9oOl86N850lxplmi/fO/ptHo5glf8VI/jrIlpQnN4nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=altsWRO64cvSk5owsplFmr1vQKWBwYEKtXad2qswvYXdetsfVgvnpfPAjrOrsWHPwhxkfM14dvkfcEk5CdE4erLNDRVxAg4NGIf45QVMjevSgcMW1VWGKVDArz4qpSNnDNrALHNWdD9SfU0u+t4/eqJeuDED1kK8N7e2Ux8yy4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUwpgeHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38A2C433C7;
	Wed, 21 Feb 2024 21:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708551480;
	bh=9oOl86N850lxplmi/fO/ptHo5glf8VI/jrIlpQnN4nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUwpgeHSO142RKuGwIXhScBu/2cWKaelACWeOtQaATMpwLNtmAhe7poC6xPinYXbi
	 Pw0h3MgztfEi/qIXYF4mTyADgknquKPVgPLWiDPGfUKSPJSkGugrBQpwooGSCI5ykE
	 PTJ1B7I9pd3+cNrqFs6TUychg9izY9QUcKU0XKL5Fcgp5faOxC9TwvqMJARlVuctr1
	 zXwUV3b4PUd9uAW4vxP1qrfXqMeSARav+HY9fub4BB6q1p+eiMb7mPyNguEK7ULMTt
	 CLAXyxk0TWXK+F62AuVAzwbnUpt8avb8GaWIV0Id0n7h+mCLi7n0+tMy37jeISGSIT
	 gbmzKWRLlukmg==
Date: Wed, 21 Feb 2024 21:37:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	denis.ciocca@st.com, linus.walleij@linaro.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: iio: st-sensors: Add IIS2MDC magnetometer
Message-ID: <20240221-lubricant-machine-79054f117eb0@spud>
References: <20240221175810.3581399-1-m.felsch@pengutronix.de>
 <20240221-undecided-union-4078db711693@spud>
 <20240221191644.5r3ylr5w3cnfnrzj@pengutronix.de>
 <20240221-imitate-molar-81d93285ac77@spud>
 <20240221194518.3sm4o5i274ldpvzf@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aCdhMTuN5ae1nNlN"
Content-Disposition: inline
In-Reply-To: <20240221194518.3sm4o5i274ldpvzf@pengutronix.de>


--aCdhMTuN5ae1nNlN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 08:45:18PM +0100, Marco Felsch wrote:
> Hi Conor,
>=20
> On 24-02-21, Conor Dooley wrote:
> > On Wed, Feb 21, 2024 at 08:16:44PM +0100, Marco Felsch wrote:
> > > On 24-02-21, Conor Dooley wrote:
> > > > On Wed, Feb 21, 2024 at 06:58:10PM +0100, Marco Felsch wrote:
> > > > > Add the iis2mdc magnetometer support which is equivalent to the l=
is2mdl.
> > > > >=20
> > > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.=
yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> > > > > index fff7e3d83a02..ee593c8bbb65 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> > > > > +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> > > > > @@ -64,6 +64,7 @@ properties:
> > > > >            - st,lsm9ds0-gyro
> > > > >        - description: STMicroelectronics Magnetometers
> > > > >          enum:
> > > > > +          - st,iis2mdc
> > > >=20
> > > > Without a fallback compatible to the equivilent device, how does a
> > > > driver bind to this device?
> > >=20
> > > I skimed the datasheets and the driver already handles this binding
> > > exactly the same as the st,lis2mdl, so my assumption is they do match.
> > >=20
> > > Why do I you think we need a fallback compatible here?
> >=20
> > I didn't look at the driver, there was no mention of the driver already
> > having (undocumented) support for it. Since there was no driver change
> > alongside this patch, I thought you'd need a fallback compatible to
> > allow the driver to match against a compatible it recognises.
>=20
> I explicitly did not mention the driver in the commit message else I
> would have got a response like "dt-bindings have no dependency to
> drivers" ;)

Putting it under the --- line is always an option. Where there are
existing users but the compatible is just undocumented, this it's
helpful to do.

> > Besides, having fallback compatibles is the norm when one device has the
> > same programming model as another.
>=20
> Not for this binding according the driver.

If they don't have the same programming model, then describing them as
"equivalent" wouldn't be correct. That said, they seem to use the same
sensor settings when alls said and done (see st_magn_sensors_settings),
so I think they are actually compatible even if the driver has separate
match data for each.

Cheers,
Conor.

--aCdhMTuN5ae1nNlN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdZtMgAKCRB4tDGHoIJi
0mhFAP4uPT1KilNvuJy11JVEqyK46NkPn3I0vD5H1rPev9iSUQD/c2IAJZDAfJpg
j6ckgYP2rWSx/t9GqIONxFD8RfJMegM=
=nU5D
-----END PGP SIGNATURE-----

--aCdhMTuN5ae1nNlN--


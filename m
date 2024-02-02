Return-Path: <linux-kernel+bounces-50129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B05A84749F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686021C26332
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70B71474CF;
	Fri,  2 Feb 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr4y2Q11"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C6F145356;
	Fri,  2 Feb 2024 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891058; cv=none; b=t4CURAYt52/VVN/27H5czvJbI12gvlAMeOVk6LJtfyKCDP++l15iHo9tDNjJWKijPI8HZq3rnwDbVO0RihHneqymsxh3iyL/hxvKB85wKoEWgfQEi2QI52s4X5eCNw36OyE+N+g72iu0zL9/9CoVy9k4yY+iEj86vHDqvKqw2v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891058; c=relaxed/simple;
	bh=nf1dgIwaXauoxmAsRA//GzUzQl0CfZAGGsi0S4FzkvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NN4QTq+OFxeCGh/zOxuwcsJtVLJ8UdQKxoWbjK9lEVnXL3xuCWyO3VlGAuag5ARvwXAjOzrPdrR9RQjAdk0UdQftdPPkpWQgj4HaZlS5MGuD9BmCTec/iC4eS720UMnIRUs5uNcbxREcR7HLCS3VgblBuDSnnEVS/yf8ugu0VAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr4y2Q11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DD8C433C7;
	Fri,  2 Feb 2024 16:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706891057;
	bh=nf1dgIwaXauoxmAsRA//GzUzQl0CfZAGGsi0S4FzkvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rr4y2Q11L9RwT8FjB0w/nagDTfTZiK483vQYqXr5WwkPDH7uNTlsMxQqlXnfTVEgz
	 DpcAkkSbr7J4tKmqqs78L6n4aceggFNGh991i60akq32dkGZigDafAjqDMGQGXkd+n
	 fDSk1KPWGJfl4m/5cowpIl8vStyrvN3W/DsVPYFhxLFOebVgo+VKf07ZBCzIqoZlqt
	 y7ECYFpSnvIu6OlqjJP/8wif5xMzWhsTKcv0fo/wPAHSxu92XPYIJHDsstFQm+KMrp
	 DQmC7Ovzp1F/qZIi0DPJBYgd25qzcDIsbH888juk5W0TvfXfAzOXjWsWFejocBCt1F
	 +IhuRox8t6Bhg==
Date: Fri, 2 Feb 2024 16:24:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	mazziesaccount@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: Add regulator-compatible property
Message-ID: <20240202-carbon-jumbo-0a577c19b62f@spud>
References: <20240126114614.1424592-1-naresh.solanki@9elements.com>
 <20240126-deflate-ashy-158a91efb25a@spud>
 <CABqG17g+wQ5brngLDYObV+t2y+CEf+85rzqTSYTcmS5jckWZRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OGS3hiZ1Wh3iWLl3"
Content-Disposition: inline
In-Reply-To: <CABqG17g+wQ5brngLDYObV+t2y+CEf+85rzqTSYTcmS5jckWZRg@mail.gmail.com>


--OGS3hiZ1Wh3iWLl3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 05:27:10PM +0530, Naresh Solanki wrote:
> Hi Conor,
>=20
>=20
> On Fri, 26 Jan 2024 at 21:50, Conor Dooley <conor@kernel.org> wrote:
> >
> > On Fri, Jan 26, 2024 at 05:16:14PM +0530, Naresh Solanki wrote:
> > > Add regulator-compatible property.
> >
> > Why? I can see that this is what you did, but there's no justification
> > for it.
> >
> > grepping for this property, the first thing I see is:
> > rg "regulator-compatible"
> > drivers/regulator/of_regulator.c
> > 389: * based on either the deprecated property regulator-compatible if =
present,
> > 428:                                    "regulator-compatible", NULL);
> > 486:            name =3D of_get_property(child, "regulator-compatible",=
 NULL);
> >
> >
> > The property is deprecated, so you'll need twice as good a justification
> > for adding it!
> Yes this is deprecated property. I missed noticing that earlier.
> Will remove this dependency. Thanks for pointing that out.

What do you mean "remove this dependency"? If you remove this there is
nothing useful left in the patch.

Confused,
Conor.

>=20
> Regards,
> Naresh
> >
> > > Also update example.
> > >
> > > TEST=3DRun below command & make sure there is no error
> > > make DT_CHECKER_FLAGS=3D-m dt_binding_check
> >
> > Same comment here as my other mail.
> >
> > Thanks,
> > Conor.
> >
> > >
> > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/maxim,max5970.yaml | 9 +++++++=
++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml=
 b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> > > index 0da5cae3852e..75175098cbc2 100644
> > > --- a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> > > +++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> > > @@ -74,6 +74,9 @@ properties:
> > >              description: |
> > >                The value of current sense resistor in microohms.
> > >
> > > +          regulator-compatible:
> > > +            pattern: "^SW[0-1]$"
> > > +
> > >          required:
> > >            - shunt-resistor-micro-ohms
> > >
> > > @@ -111,6 +114,8 @@ examples:
> > >
> > >              regulators {
> > >                  sw0_ref_0: sw0 {
> > > +                    regulator-compatible =3D "SW0";
> > > +                    regulator-name =3D "p5v";
> > >                      shunt-resistor-micro-ohms =3D <12000>;
> > >                  };
> > >              };
> > > @@ -145,9 +150,13 @@ examples:
> > >
> > >              regulators {
> > >                  sw0_ref_1: sw0 {
> > > +                    regulator-compatible =3D "SW0";
> > > +                    regulator-name =3D "p5v_aux";
> > >                      shunt-resistor-micro-ohms =3D <12000>;
> > >                  };
> > >                  sw1_ref_1: sw1 {
> > > +                    regulator-compatible =3D "SW1";
> > > +                    regulator-name =3D "p3v3_aux";
> > >                      shunt-resistor-micro-ohms =3D <10000>;
> > >                  };
> > >              };
> > >
> > > base-commit: ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
> > > --
> > > 2.42.0
> > >

--OGS3hiZ1Wh3iWLl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZb0XLQAKCRB4tDGHoIJi
0t4fAP4p2F8BI/5T3p/OhE42EZgDqs1Mj5cPA7gfcqNWa2dYHgD9HIwbLyGmWwQi
EhgTB422mCYY4MX1rS8e9zsaXD2lPg0=
=DZBo
-----END PGP SIGNATURE-----

--OGS3hiZ1Wh3iWLl3--


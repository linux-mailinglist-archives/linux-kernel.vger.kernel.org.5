Return-Path: <linux-kernel+bounces-168338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A098BB6F3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC9D1C244CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A12B5BAC3;
	Fri,  3 May 2024 22:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fgck2mNa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC401EB21;
	Fri,  3 May 2024 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714774455; cv=none; b=CALuxEe8T3HMfcFwfduAp5ICml87CDklbU4lK2RgocitygV0e7rCRkuEOYhj3h66PKmUwla0xXolfb2OIaMZvT3lJUbHTep46wI/yiVOEx5AnDwVpnMV72udDYrjB3eD0mA0VJWYg+CP5afm+H24CAP/1due6D66MQojd1jKk44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714774455; c=relaxed/simple;
	bh=zHMgoQFGqXCS0wSQQOdTlljNIzCktqC8tmQAhXSc1bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjfEnomaFp1KbodBdCmhbBp7/hCr8KhfnjoGZhNNG6vzPKp/dtSD/P17HYw2e5LqxkGXkxlnLYFs8LolHdcBhoHJLwXotZLowuBYd9h+hxm86C8vduy1ktXlVFodDl9AwKbDxNG7ncPVK1g+UZp+3wU/be44EwUZvLXvRga2IYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fgck2mNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C948C116B1;
	Fri,  3 May 2024 22:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714774455;
	bh=zHMgoQFGqXCS0wSQQOdTlljNIzCktqC8tmQAhXSc1bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fgck2mNae+YY4hsUBEkQ5FJ/w2FO1bLtdG/4lsuVeURk392XWBZw9mf/DK4zQ8zXS
	 atnZG7SkpVc6tZaFIWSuz7UF3jj7p2oL49MrDDKiFrZBFWVnbyZnJi8Br50QLSXv50
	 yyhqns4c8VeTjQGcWcOPzI4kwmM864riDRG3JFavF1HJ+5wo/XV1tcPiHfn6qM1IuT
	 LYTJZd93I6/ld+8K/C1g2CCuvSAVaTxs+LvVbHOoYH5j9Gkksu09k/od9vSrC6evfQ
	 lHjtaruLnjto5a7Lkus5bBGeT/FyBAmfFPRpalDstko2sTF6bX2s0EvvL3yLxQbFRA
	 D/BxYTeggJ9Yw==
Date: Fri, 3 May 2024 23:14:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
	linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel =?iso-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: mips: brcm: Document mips-cbr-reg
 property
Message-ID: <20240503-dreamboat-satin-4e51e27643b1@spud>
References: <20240503135455.966-1-ansuelsmth@gmail.com>
 <20240503135455.966-4-ansuelsmth@gmail.com>
 <20240503-oncoming-taste-bab71375b67c@spud>
 <66353c11.5d0a0220.bb93c.fb57@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KIHwxf5kbowPiFqn"
Content-Disposition: inline
In-Reply-To: <66353c11.5d0a0220.bb93c.fb57@mx.google.com>


--KIHwxf5kbowPiFqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 09:33:35PM +0200, Christian Marangi wrote:
> On Fri, May 03, 2024 at 05:21:41PM +0100, Conor Dooley wrote:
> > On Fri, May 03, 2024 at 03:54:03PM +0200, Christian Marangi wrote:
> > > Document mips-cbr-reg and mips-broken-cbr-reg property.
> > >=20
> > > Some SoC suffer from a BUG where read_c0_brcm_cbr() might return 0
> > > if called from TP1. The CBR address is always the same on the SoC
> > > hence it can be provided in DT to handle broken case where bootloader
> > > doesn't init it or SMP where read_c0_brcm_cbr() returns 0 from TP1.
> > >=20
> > > Usage of this property is to give an address also in these broken
> > > configuration/bootloader.
> > >=20
> > > If the SoC/Bootloader ALWAYS provide a broken CBR address the property
> > > "mips-broken-cbr-reg" can be used to ignore any value already set in =
the
> > > registers for CBR address.
> > >=20
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  .../devicetree/bindings/mips/brcm/soc.yaml    | 32 +++++++++++++++++=
++
> > >  1 file changed, 32 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.yaml b/D=
ocumentation/devicetree/bindings/mips/brcm/soc.yaml
> > > index 975945ca2888..12d394b7e011 100644
> > > --- a/Documentation/devicetree/bindings/mips/brcm/soc.yaml
> > > +++ b/Documentation/devicetree/bindings/mips/brcm/soc.yaml
> > > @@ -55,6 +55,21 @@ properties:
> > >           under the "cpus" node.
> > >          $ref: /schemas/types.yaml#/definitions/uint32
> > > =20
> > > +      mips-broken-cbr-reg:
> > > +        description: Declare that the Bootloader init a broken
> > > +          CBR address in the registers and the one provided from
> > > +          DT should always be used.
> >=20
> > Why is this property even needed, is it not sufficient to just add the
> > mips-cbr-reg property to the DT for SoCs that need it and use the
> > property when present?
> >
>=20
> I described this in the cover letter.

It needs to be described in /this patch/. Cover letters usually don't
end up in the commit history and I din't read them while looking for the
justification for a change :)

> CBR might be set by the Bootloader
> and might be not 0. In that case the value is ignored as an extra
> precaution and the broken propetry is needed.

I dunno, if the bootloader is bad, you need to set a property anyway,
so why not set mips-cbr-reg?

> > > +        type: boolean
> > > +
> > > +      mips-cbr-reg:
> >=20
> > Missing a vendor prefix.
> >=20
>=20
> I will change this to bmips,cbr-reg hope it's O.K.
>=20
> > > +        description: Reference address of the CBR.
> > > +          Some SoC suffer from a BUG where read_c0_brcm_cbr() might
> > > +          return 0 if called from TP1. The CBR address is always the
> > > +          same on the SoC hence it can be provided in DT to handle
> > > +          broken case where bootloader doesn't init it or SMP where
> >=20
> > s/init/initialise/ please :)
> >=20
>=20
> Sure!
>=20
> > Thanks,
> > Conor.
> >=20
> > > +          read_c0_brcm_cbr() returns 0 from TP1.
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +
> > >      patternProperties:
> > >        "^cpu@[0-9]$":
> > >          type: object
> > > @@ -64,6 +79,23 @@ properties:
> > >      required:
> > >        - mips-hpt-frequency
> > > =20
> > > +dependencies:
> > > +  mips-broken-cbr-reg: [ mips-cbr-reg ]
> > > +
> > > +if:
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        anyOf:
> > > +          - const: brcm,bcm6358
> > > +          - const: brcm,bcm6368
> > > +
> > > +then:
> > > +  properties:
> > > +    cpus:
> > > +      required:
> > > +        - mips-cbr-reg
> > > +
> > >  additionalProperties: true
> > > =20
> > >  examples:
> > > --=20
> > > 2.43.0
> > >=20
>=20
>=20
>=20
> --=20
> 	Ansuel

--KIHwxf5kbowPiFqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjVhsgAKCRB4tDGHoIJi
0hnUAP9FW/ZnwZiInKq0TjTp29MaHp+FKIvw21I9oy9q1490XAEA9Sbv1NW3gSNK
H7aTa7HcDyIr55Qx/JZmKHV8oKeXnQQ=
=zLrm
-----END PGP SIGNATURE-----

--KIHwxf5kbowPiFqn--


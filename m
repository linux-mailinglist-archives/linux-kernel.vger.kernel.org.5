Return-Path: <linux-kernel+bounces-35881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B196A83980D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDD3288439
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E63C82D97;
	Tue, 23 Jan 2024 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgzdAMJf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CF2823BC;
	Tue, 23 Jan 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035353; cv=none; b=UcW17QE3e4b0YTpj/rFzozsLa/taHMsmz635zN2JIKxklu1Tm2K80kCe+S57uzj45Pbq2mU/jlc8hVtu8/YgP1TORrZ2IM/ZdJ0JXHRYYdgDU7glCqGfrH3hvjh1PSUd7kZ4jsWETV7I5Or1XbRXk8lFbCu2OQlJfL8bipntkH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035353; c=relaxed/simple;
	bh=L5CiyhJ7VmjD8jqZZfrKBqOIr3FlCEqBLQ1Y4nvSv68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNqlk3FRi3/UtTaGrCsKRUWX3FPxRNl2EtitgI9ONcXL4l+kPkhjV73jAShLAGLeJPY/u6oeRcIXOG5GvSCuVJXBrE3c3EvLJGhAcReIcei4ktTBfozbhGck69GFajJ6rcQZrZP1QL3D4o+nx9L/94l2jX8AD3OI91qYXjd7tQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgzdAMJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EC4C433F1;
	Tue, 23 Jan 2024 18:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706035352;
	bh=L5CiyhJ7VmjD8jqZZfrKBqOIr3FlCEqBLQ1Y4nvSv68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QgzdAMJfpJGkJP1P9EMq4+0ZzDYohgQmMHPDjUvtqtXyx5DMV15NtBUl0PnG1XST9
	 beJUdItmGbSaGAIfuZG2DyrcA8oukAqMR7wItzJ3+ut+2T4cV7PJXhKK3ItVmSYw7f
	 l5nrwQ5CJ64qBT8arwFKilK9Q4E2zkIvTRjRXCgUIh1i9YHKA60Z6IHTgVPOolfIUa
	 gV0QJ/uxDzFuz/6byKUvH7hH9BD18SrRJtyaERw9At4bbXpPEkoVerXMD1Ny5/2pmk
	 kzdc153g6ZoydVJyXhi2HUbk5LgyBYuhb0ElD4/fKbP84+7bP3XKPGuOkvAUI7fhrg
	 NTUHIMlpHqwCg==
Date: Tue, 23 Jan 2024 18:42:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: thinh.nguyen@synopsys.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	balbi@kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mark.rutland@arm.com, mathias.nyman@intel.com, pku.leo@gmail.com,
	sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add system bus request info
Message-ID: <20240123-nanometer-atlantic-6465b270043a@spud>
References: <20240123170206.3702413-1-Frank.Li@nxp.com>
 <20240123-poking-geography-33be2b5ae578@spud>
 <Za/8J8MDJaZEPEKO@lizhi-Precision-Tower-5810>
 <20240123-anew-lilly-0d645bdbfb30@spud>
 <Za//LX9U6QG5A5NW@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gjo83bA3bLxaSiQd"
Content-Disposition: inline
In-Reply-To: <Za//LX9U6QG5A5NW@lizhi-Precision-Tower-5810>


--gjo83bA3bLxaSiQd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 01:02:21PM -0500, Frank Li wrote:
> On Tue, Jan 23, 2024 at 05:51:48PM +0000, Conor Dooley wrote:
> > On Tue, Jan 23, 2024 at 12:49:27PM -0500, Frank Li wrote:
> > > On Tue, Jan 23, 2024 at 05:27:13PM +0000, Conor Dooley wrote:
> > > > On Tue, Jan 23, 2024 at 12:02:05PM -0500, Frank Li wrote:
> > > > > Add device tree binding allow platform overwrite default value of=
 *REQIN in
> > > > > GSBUSCFG0.
> > > >=20
> > > > Why might a platform actually want to do this? Why does this need t=
o be
> > > > set at the board level and being aware of which SoC is in use is not
> > > > sufficient for the driver to set the correct values?
> > >=20
> > > In snps,dwc3.yaml, there are already similary proptery, such as
> > > snps,incr-burst-type-adjustment. Use this method can keep whole dwc3 =
usb
> > > driver keep consistent. And not all platform try enable hardware
> > > dma_cohenrence. It is configable for difference platform.
> >=20
> > When you say "platform", what do you mean? I understand that term to
> > mean a combination of board, soc and firmware.
>=20
> In my company's environment, "platform" is "board". I will use "board" in
> future. Is it big difference here?

Nah, that's close enough that it makes no difference here.

I'd still like an explanation for why a platform would need to actually
set these properties though, and why information about coherency cannot
be determined from whether or not the boss the usb controller is on is
communicated to be dma coherent via the existing devicetree properties
for that purpose.

Thanks,
Conor.

> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > >  .../devicetree/bindings/usb/snps,dwc3.yaml    | 36 +++++++++++++=
++++++
> > > > >  1 file changed, 36 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml=
 b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > index 8f5d250070c78..43e7fea3f6798 100644
> > > > > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > @@ -439,6 +439,42 @@ properties:
> > > > >      items:
> > > > >        enum: [1, 4, 8, 16, 32, 64, 128, 256]
> > > > > =20
> > > > > +  snps,des-wr-reqinfo:
> > > > > +    description: Value for DESEWRREQIN of GSBUSCFG0 register.
> > > > > +      ----------------------------------------------------------=
------
> > > > > +       MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
> > > > > +      ----------------------------------------------------------=
------
> > > > > +       AHB      |Cacheable     |Bufferable   |Privilegge |Data
> > > > > +       AXI3     |Write Allocate|Read Allocate|Cacheable  |Buffer=
able
> > > > > +       AXI4     |Allocate Other|Allocate     |Modifiable |Buffer=
able
> > > > > +       AXI4     |Other Allocate|Allocate     |Modifiable |Buffer=
able
> > > > > +       Native   |Same as AXI   |Same as AXI  |Same as AXI|Same a=
s AXI
> > > > > +      ----------------------------------------------------------=
------
> > > > > +      The AHB, AXI3, AXI4, and PCIe busses use different names f=
or certain
> > > > > +      signals, which have the same meaning:
> > > > > +      Bufferable =3D Posted
> > > > > +      Cacheable =3D Modifiable =3D Snoop (negation of No Snoop)
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > > > +    maxItem: 15
> > > > > +
> > > > > +  snps,des-rd-reqinfo:
> > > > > +    description: Value for DESRDREQIN of GSBUSCFG0 register. ref
> > > > > +      snps,des-wr-reqinfo
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > > > +    maxItem: 15
> > > > > +
> > > > > +  snps,dat-wr-reqinfo:
> > > > > +    description: Value for DATWRREQIN of GSBUSCFG0 register. ref
> > > > > +      snps,des-wr-reqinfo
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > > > +    maxItem: 15
> > > > > +
> > > > > +  snps,des-wr-reqinfo:
> > > > > +    description: Value for DATWRREQIN of GSBUSCFG0 register. ref
> > > > > +      snps,des-wr-reqinfo
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > > > +    maxItem: 15
> > > > > +
> > > > >    num-hc-interrupters:
> > > > >      maximum: 8
> > > > >      default: 1
> > > > > --=20
> > > > > 2.34.1
> > > > >=20
> > >=20
> > >=20
>=20
>=20

--gjo83bA3bLxaSiQd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbAIkwAKCRB4tDGHoIJi
0l5GAP93pP2+n9c7Ngq/2+2ZuBy0n/72VkccR8Xbv37y/t5J7AEA8kXs+aWNxxUF
VyPexfs8f5y1gAB5zsysERG64YvLhgk=
=ndMa
-----END PGP SIGNATURE-----

--gjo83bA3bLxaSiQd--


Return-Path: <linux-kernel+bounces-35820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AD48396F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994EBB284E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B334B81AC1;
	Tue, 23 Jan 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTzbS7Rx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D4180020;
	Tue, 23 Jan 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032314; cv=none; b=O11roFyplGljMlkv2Om4nJ8fxutEgjqHX+xwEzlMITiXKCXGEl7Ay+foMM6ktyogu5zIdmzXNZDcAs/4cq0860DR1ITSj7GwTqaYzoZnjoxiZkV1Mrtt2+QfO+5k3unf6xb6fTFlpAEnKXw6Vjn5RrVVZYHN54UXBGrXT0v/6l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032314; c=relaxed/simple;
	bh=DUrySEkASJXrQsX7gXqyvxTHWOTdXS9Ah3TVqTfEIos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDMFqwhsZMNOJ2M+IBbH5Kggi4ysFH1JxeWVol+1962LAF5l2ccrwnotWFNhTRMaby5kbn9pZhtBMz/qhJm1WmNExm0i2OECheDkSS/0vDCpcyrxOyGHqHNiMXZoftx76sB3C9BscGCmDJlgTm4tMer52Tu/eDwdAxRDl0bAOco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTzbS7Rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609AAC433F1;
	Tue, 23 Jan 2024 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706032313;
	bh=DUrySEkASJXrQsX7gXqyvxTHWOTdXS9Ah3TVqTfEIos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTzbS7RxhUEMQtHxBRWpVfuu8+SCjvta5g+ipYJozKjuaOxcx9fhk8sWPFaAhQ9lZ
	 k0442yIf6304QIov2YfOuUiIuFhg33fp+2QGCJR6w7sELyeybxpkmPIjJ4NypR3dCL
	 lUfuexFpe9Z1/k4JWaeHeM0b/fAN8lG3m/qlD2FhWxDIY1bUgACswsHsPWAOB2F6GC
	 PZyQu3Vqb0rNm5+4DinoKx6p6E7tYAvkToIGoE4RLZwSsLVd2dSjqKhcINbv3/6TxA
	 00KGaHmBMkqVzCx6F58ikjdT4K2xVGBWJr/WhG9LY8oiIVYGSnZrC7LhlJGcWK+4Lk
	 0mX3wqMmcC55Q==
Date: Tue, 23 Jan 2024 17:51:48 +0000
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
Message-ID: <20240123-anew-lilly-0d645bdbfb30@spud>
References: <20240123170206.3702413-1-Frank.Li@nxp.com>
 <20240123-poking-geography-33be2b5ae578@spud>
 <Za/8J8MDJaZEPEKO@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5XYrnAPk+u2li9K1"
Content-Disposition: inline
In-Reply-To: <Za/8J8MDJaZEPEKO@lizhi-Precision-Tower-5810>


--5XYrnAPk+u2li9K1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 12:49:27PM -0500, Frank Li wrote:
> On Tue, Jan 23, 2024 at 05:27:13PM +0000, Conor Dooley wrote:
> > On Tue, Jan 23, 2024 at 12:02:05PM -0500, Frank Li wrote:
> > > Add device tree binding allow platform overwrite default value of *RE=
QIN in
> > > GSBUSCFG0.
> >=20
> > Why might a platform actually want to do this? Why does this need to be
> > set at the board level and being aware of which SoC is in use is not
> > sufficient for the driver to set the correct values?
>=20
> In snps,dwc3.yaml, there are already similary proptery, such as
> snps,incr-burst-type-adjustment. Use this method can keep whole dwc3 usb
> driver keep consistent. And not all platform try enable hardware
> dma_cohenrence. It is configable for difference platform.

When you say "platform", what do you mean? I understand that term to
mean a combination of board, soc and firmware.

> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  .../devicetree/bindings/usb/snps,dwc3.yaml    | 36 +++++++++++++++++=
++
> > >  1 file changed, 36 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/D=
ocumentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > index 8f5d250070c78..43e7fea3f6798 100644
> > > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > @@ -439,6 +439,42 @@ properties:
> > >      items:
> > >        enum: [1, 4, 8, 16, 32, 64, 128, 256]
> > > =20
> > > +  snps,des-wr-reqinfo:
> > > +    description: Value for DESEWRREQIN of GSBUSCFG0 register.
> > > +      --------------------------------------------------------------=
--
> > > +       MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
> > > +      --------------------------------------------------------------=
--
> > > +       AHB      |Cacheable     |Bufferable   |Privilegge |Data
> > > +       AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
> > > +       AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
> > > +       AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
> > > +       Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
> > > +      --------------------------------------------------------------=
--
> > > +      The AHB, AXI3, AXI4, and PCIe busses use different names for c=
ertain
> > > +      signals, which have the same meaning:
> > > +      Bufferable =3D Posted
> > > +      Cacheable =3D Modifiable =3D Snoop (negation of No Snoop)
> > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > +    maxItem: 15
> > > +
> > > +  snps,des-rd-reqinfo:
> > > +    description: Value for DESRDREQIN of GSBUSCFG0 register. ref
> > > +      snps,des-wr-reqinfo
> > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > +    maxItem: 15
> > > +
> > > +  snps,dat-wr-reqinfo:
> > > +    description: Value for DATWRREQIN of GSBUSCFG0 register. ref
> > > +      snps,des-wr-reqinfo
> > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > +    maxItem: 15
> > > +
> > > +  snps,des-wr-reqinfo:
> > > +    description: Value for DATWRREQIN of GSBUSCFG0 register. ref
> > > +      snps,des-wr-reqinfo
> > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > +    maxItem: 15
> > > +
> > >    num-hc-interrupters:
> > >      maximum: 8
> > >      default: 1
> > > --=20
> > > 2.34.1
> > >=20
>=20
>=20

--5XYrnAPk+u2li9K1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa/8swAKCRB4tDGHoIJi
0tRwAP9r1mGJcSdOfVMegDS+Ns3RRr/Kzo7ZdGQ1DPmmog12XAEAi/GTOWWWPSj3
36ussaCCWX9H1N3Gt6LJ1x0kC72Ubgk=
=FRdh
-----END PGP SIGNATURE-----

--5XYrnAPk+u2li9K1--


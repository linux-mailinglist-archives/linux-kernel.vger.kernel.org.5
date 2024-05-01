Return-Path: <linux-kernel+bounces-165623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 086B78B8EC0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AEE81F2195A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E2B17BCE;
	Wed,  1 May 2024 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbJ274z8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C81FBEA;
	Wed,  1 May 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583133; cv=none; b=RhEOoAAKutiNxskisqgSsAN5HMjwJtbkvyJhln3FL9lTOvLIJGGU0ZjFF7Ho/DYc5+ozuTmCufiHaMbhoPIVZW4Q9L7jWTd/i6dIJftJW077GalKu25djSau50cGG6zMOoJSl94g6tqlSTlpYTUjf14IbYYjgVljga6vHVkZYYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583133; c=relaxed/simple;
	bh=WZbKbkoibAOTBbyLIFnKVCRX0lYAJryMRAupW0LKaZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/sJ7A1hu3+TNbTUMG2R+3vnzVJ7mc8XRzfzz7SC2WOhPlPCUIBgUNnQPqpQqr8TfrLujWsaE8++uM3XrJPBb6L66BRBoHajKAkLi4Wk3ex8s19u4zI6hARw7JyKqUEuaqKeVWwkL+787cIxvCIjjvJkFJD1+iT/034MM0girRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbJ274z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BA0C072AA;
	Wed,  1 May 2024 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714583133;
	bh=WZbKbkoibAOTBbyLIFnKVCRX0lYAJryMRAupW0LKaZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PbJ274z89ZKqvddIWUlErvreEXL2V5sEkkcHpFlGnb02y5xe8Hekk0wgyw9Ofyl5O
	 BQ//NtU1UWaYaHe5XRzSoCLwdqdbr5oaWFkTosiOa9wAcRLhIUsOaxcEzrXBf+x1Em
	 XW0JaNNeV3vnmbz3kJ6p6kb254xEnm/fD82mxFJgP2GtlRKrMtWRbm0yzSBuyFF0tr
	 uoWbMMZ5YUwCe5O88R88euN/uy4lGyWse1sL0Q3a0dGREE+i5NTouyObaGO5tc/KOO
	 WUNmMIHVJkS/08OGJVpiOaXCK7zln5tLNdBolFH88tkt91VO33eAoiEaYBn13nt0Gq
	 FNlvjG8a1Mrng==
Date: Wed, 1 May 2024 18:05:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add Sophgo CV1800 USB phy
Message-ID: <20240501-effort-virus-9baa07daf429@spud>
References: <IA1PR20MB4953182B8EDB465430289400BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB495355A4186420B78BD78F49BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240430-crummiest-overnight-0f46dba32bb8@spud>
 <IA1PR20MB49535665CF1C89FFB4E1E46DBB192@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LScSdEfhhOhhxX79"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49535665CF1C89FFB4E1E46DBB192@IA1PR20MB4953.namprd20.prod.outlook.com>


--LScSdEfhhOhhxX79
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 08:28:47AM +0800, Inochi Amaoto wrote:
> On Tue, Apr 30, 2024 at 06:09:20PM GMT, Conor Dooley wrote:
> > On Mon, Apr 29, 2024 at 08:31:11AM +0800, Inochi Amaoto wrote:
> > > The USB phy of Sophgo CV18XX series SoC needs to sense a pin called
> > > "VBUS_DET" to get the right operation mode. If this pin is not
> > > connected, it only supports setting the mode manually.
> > >=20
> > > Add USB phy bindings for Sophgo CV18XX/SG200X series SoC.
> > >=20
> > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > ---
> > >  .../bindings/phy/sophgo,cv1800-usb-phy.yaml   | 68 +++++++++++++++++=
++
> > >  1 file changed, 68 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv18=
00-usb-phy.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-=
phy.yaml b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > > new file mode 100644
> > > index 000000000000..7e3382c18d44
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > > @@ -0,0 +1,68 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/phy/sophgo,cv1800-usb-phy.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Sophgo CV18XX/SG200X USB 2.0 PHY
> > > +
> > > +maintainers:
> > > +  - Inochi Amaoto <inochiama@outlook.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: sophgo,cv1800-usb-phy
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  "#phy-cells":
> > > +    const: 0
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: PHY clock
> > > +      - description: PHY app clock
> > > +      - description: PHY stb clock
> > > +      - description: PHY lpm clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: phy
> > > +      - const: app
> > > +      - const: stb
> > > +      - const: lpm
> > > +
> > > +  vbus_det-gpios:
> >=20
> > "vbus_det-gpios" isn't a common property AFAICT, why does it not get a
> > vendor prefix when the other gpios property does?
> >=20
>=20
> I have seen other binding (such as sunxi phy) uses this property without=
=20
> vendor prefix. So I think it is a common property and don't add perfix=20
> for it. But it is OK for me add the vendor prefix, thanks.

I asked yesterday and Krzysztof said:
"gpios just like supplies - no prefixes, I think."
The other phy used a different property (they're not identical), I did
check that yesterday.

>=20
> > > +    description: GPIO to the USB OTG VBUS detect pin. This should no=
t be
> > > +      defined if vbus_det pin and switch pin are connected, which may
> > > +      break the VBUS detection.
> > > +    maxItems: 1
> > > +
> > > +  sophgo,switch-gpios:
> > > +    description: GPIO array for the phy to control connected switch.=
 For
> > > +      host mode, the driver will set these GPIOs to low one by one. =
For
> > > +      device mode, the driver will set these GPIOs to high in reverse
> > > +      order.
> > > +    maxItems: 2
> >=20
> > You're still missing the itemised description of what each of the gpios
> > here are - how would I know which order to put the GPIOs in?
> >=20
> > Cheers,
> > Conor.
>=20
> In most case, the order depends on hardware design. But following the
> guide sophgo provides, it does have an common order. Is it good to add
> this description as a reference guide? If so, I will add it.

If we can say "gpio 1 connects to xyz on the switch" & "gpio 2 connects
to tuv" then it'll be easier to understand how to write the node.

>=20
> Regards,
> Inochi
>=20
> >=20
> > > +
> > > +required:
> > > +  - compatible
> > > +  - "#phy-cells"
> > > +  - clocks
> > > +  - clock-names
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    phy@48 {
> > > +      compatible =3D "sophgo,cv1800-usb-phy";
> > > +      reg =3D <0x48 0x4>;
> > > +      #phy-cells =3D <0>;
> > > +      clocks =3D <&clk 92>, <&clk 93>,
> > > +               <&clk 94>, <&clk 95>;
> > > +      clock-names =3D "phy", "app", "stb", "lpm";
> > > +    };
> > > +
> > > +...
> > > --
> > > 2.44.0
> > >=20
>=20
>=20

--LScSdEfhhOhhxX79
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjJ2WAAKCRB4tDGHoIJi
0t3pAP0SMmeNRY7MkfCW54V9OEGUp1dtBrR5XDLqYPsCAYvb5QEA17rw7TzzPlPc
Is2n9IJ026qIajuo2X0UOUZlLuZiRwU=
=S11l
-----END PGP SIGNATURE-----

--LScSdEfhhOhhxX79--


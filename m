Return-Path: <linux-kernel+bounces-153699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67478AD1CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4541F23142
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96816153572;
	Mon, 22 Apr 2024 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwEfKmyw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61D615380D;
	Mon, 22 Apr 2024 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802892; cv=none; b=igWZha/4Rk3FDo5xX1W6eiN6wRing8oQat9YOsQiAIBjlKAttal4GNZKWkqoTBHt6uzb1zicP0pa70KAQRA+d5ryDIFO4t7QPsJTO7XR2E4KZ0jbv4FNxUarRVyfeOBDztyR35zE0StFZg9bK6Wi9nz5y7a13tKyGv9Vt0nXDjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802892; c=relaxed/simple;
	bh=AFRCwPy48IRqorUVwWw91pu04QMTojwYvcp8gaaxSg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jr6hPJB5WIaBsDwOFzistBZ41OAbrHnJ7ObIx7uexNwHVgDWRuJYzLF7kcgcU61dPnrEkMALNEwGewW1wJv93EUU/YyfCdipGwWe30yDUG7p2Waet5u0AQqR/U2yC7mgqgIC/LckoywhoE0dVQ+sz3ECby2Qt/yPoBLPdR/G68o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwEfKmyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7896C113CC;
	Mon, 22 Apr 2024 16:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713802892;
	bh=AFRCwPy48IRqorUVwWw91pu04QMTojwYvcp8gaaxSg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwEfKmyw82HsaUL37rAvvwNItHpyNTg1GIg4F221ja1a+s0OhbrcRDX70Jgm16kUT
	 vtLXqqSOky87PY/5F8n6SXjoV5HGzkM+gVF9EiYx38t93a9DukxQ3vyTS++Bn9KNPw
	 thg1unZuJLGivIPRQ3096RmQEAcje2tsQR0dbzo7oba/aEc3aYY2YQBu1Uy6d1n8W+
	 kZSQUT8H2NdxkoO3JG0MnoLT0arPg2iP/nF1/Dz4Bl+h12ceknFXltsMdXLuvDels/
	 aTeU6Jyjs7+jjtEinE1t5/3zVhFqRJ4OJSrr3WPxtFAoitQtxlDOD+GCjfLypqx1V4
	 P7GRQ6DfgwGyw==
Date: Mon, 22 Apr 2024 17:21:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Sophgo CV1800 USB phy
Message-ID: <20240422-folic-obtuse-570b1747e7b9@spud>
References: <IA1PR20MB4953780F4617823F7173B6D6BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953040232A4D41E41F2D2A9BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240419-harmful-neutron-d0db367cf659@spud>
 <IA1PR20MB49536E7548B65B41F4F33FDEBB0C2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zBWc+J/izNiVp8j0"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49536E7548B65B41F4F33FDEBB0C2@IA1PR20MB4953.namprd20.prod.outlook.com>


--zBWc+J/izNiVp8j0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 09:39:18AM +0800, Inochi Amaoto wrote:
> On Fri, Apr 19, 2024 at 03:26:53PM GMT, Conor Dooley wrote:
> > On Fri, Apr 12, 2024 at 03:22:24PM +0800, Inochi Amaoto wrote:
> > > The USB phy of Sophgo CV18XX series SoC needs to sense a pin called
> > > "VBUS_DET" to get the right operation mode. If this pin is not
> > > connected, it only supports setting the mode manually.
> > >=20
> > > Add USB phy bindings for Sophgo CV18XX/SG200X series SoC.
> > >=20
> > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > ---
> > >  .../bindings/phy/sophgo,cv1800-usb-phy.yaml   | 90 +++++++++++++++++=
++
> > >  1 file changed, 90 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv18=
00-usb-phy.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-=
phy.yaml b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > > new file mode 100644
> > > index 000000000000..cb394ac5d8c4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> > > @@ -0,0 +1,90 @@
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
> > > +  dr_mode:
> > > +    description: PHY device mode when initing.
> >=20
> > "initing" isn't a word, "initialising" is the correct word. Or
> > "initializing" if you speak American. But if it is just the value during
> > initialisation, why do we need to know - we can just overwrite it in
> > software, right?
> >=20
> > Are you sure that this is limited to initialisation? I would have
> > thought that it describes the configuration that the board is in, and is
> > a fixed property of the system?
> >=20
> > > +    enum: [host, peripheral, otg]
> >=20
> > Rob, I know this is a phy rather than a controller, so referencing
> > usb-drd.yaml doesn't really make sense, but there are several PHYs using
> > dr_mode so it feels like there should be something to reference here
> > rather than defining the property anew.
> >=20
>=20
> Yes, you are right. Using dr_mode in initialisation is not necessary.
> We can just let it go and using the default mode. In fact, for most
> boards with this SoC, host mode is just enough. And it is just easy=20
> to overwrite the mode value in the driver if we want another mode.=20
> For the OTG, it can just check the `vbus_det-gpios`. I will remove=20
> this property, thanks.

Just to be clear, it's valid to have a dr_mode property in cases that
you cannot detect what the mode is dynamically. What I was questioning
was the wording about only valid for init.

> > > +  vbus_det-gpios:
> > > +    description: GPIO to the USB OTG VBUS detect pin. This should no=
t be
> > > +      defined if vbus_det gpio and switch gpio are connected.
> >=20
> > I don't understand the second sentence here.

Ah, with your explanation below I now understand what you mean here. I
think this needs to be re-written - I think it would be easier to
understand with s/gpio/pin/ in the second line.

> > > +    maxItems: 1
> > > +
> > > +  sophgo,switch-gpios:
> > > +    description: GPIO for the phy to control connected switch.
> > > +    maxItems: 2
> >=20
> > You've got two items here, they should be described. /But/ the property
> > above says "switch gpio", which is singular. Which is it?
> >=20
>=20
> `switch-gpios` is gpios to controll USB switch connected to the
> phy. Sophgo recommends that phy use a switch to separate device
> port and host port if it supports both. I know this is weird,
> but many board follows this design, such as Huashan PI and=20
> Milkv Duo S. As for item number, it is just an array of gpios
> to process one by one, I mark it as two just because Milkv=20
> Duo S use two gpios to controll the USB switch.

Right, but what I'm looking for is a description for what each GPIO
does, so that someone can know how the dts should be written.

> For vbus_det gpio description, There is because the design of=20
> Milk-v Duo S, which connect the switch gpio and VBUS detect=20
> gpio. In this case the OTG function is broken and we can just=20
> change the mode by toggling switch gpios. So I suggest not=20
> defining this property.

Okay. See my comment on it above.

Thanks,
Conor.

--zBWc+J/izNiVp8j0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiaOhgAKCRB4tDGHoIJi
0q3VAQCrGsXppmUynfWM7SA2AFjgkUzDreJrN1u78Q9BRRDXjgD/c6kSQbgAQB85
O/F2pHE5G5vYsnXHPejmMURPSVfkmQ4=
=AGnu
-----END PGP SIGNATURE-----

--zBWc+J/izNiVp8j0--


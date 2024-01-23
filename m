Return-Path: <linux-kernel+bounces-35875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E148397E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5827628ACF3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B82C823BD;
	Tue, 23 Jan 2024 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGkHDMw8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE3664D6;
	Tue, 23 Jan 2024 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035081; cv=none; b=KiQeC4PaTKPTmOFK+lvWXIvlS9rR4WmePCkCSBfAfHh93+QwRrrkXwV12UZRYA9cCE2DhlffcwabhGxijVZrhZpisMhTP1tIh2Av0qGPzgxqJ8xw5x+N/42y0TvDedNzZldZK8GGM9CVaNcIDgaPAjvxtmlwIk7dqFkDWQR/vZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035081; c=relaxed/simple;
	bh=ms7HuGoB0WMtLxCgb4lhxa49rU0d6Hu6IGv4vgOcDCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bH+hL6PEA2T+P7nMxGhOzunZTE37msn5q/QNXbI14M065e+Bmbin/SXOnK5dP6duevPqGiHGqvcKXVLmobJhhPzZy8J9cXbIRDSUsNBmkOv20BaVuzzvsV802hhoCW1EncTmhW63Jp9Y84q4bjXtr26ekkiO3er97xmMOBDgBIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGkHDMw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD26BC433F1;
	Tue, 23 Jan 2024 18:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706035081;
	bh=ms7HuGoB0WMtLxCgb4lhxa49rU0d6Hu6IGv4vgOcDCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGkHDMw8EVoDlJnJazDQpNl57NWN6ArILT6SrQxb9Nsz4UHUgKCZimb0/ZeKwyQf2
	 mzcp4XgCWLoLADMN41MVYry4TTRDyuU4G6ZF0JjBfec1cF/bVy0eA9Z+qbJOzu27AE
	 ltPvAQLvsuJToY2yMHaZoWzwhf5Hr4Q13noLtqRmosSBQ1WJUoSyJ0uWhRcnCbyy4Y
	 g3hEPuFgZuLg0aJ5B/1LJn0KNpxdbQAljfwrcbk2Q2gSsjEOf4pO+xdVuyJ+zQEB9+
	 vVq8dXzW7lzRVi6qG/6N3IVPjYYxUrMvMYTNe6UM6kcqzbeBAuI2EvN2A4Nj+IutXB
	 R+z2QO2hI/lqw==
Date: Tue, 23 Jan 2024 18:37:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Philippe Schenker <dev@pschenker.ch>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Marek Vasut <marex@denx.de>,
	Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH net-next v1 1/2] dt-bindings: net: dsa: Add KSZ8567
 switch support
Message-ID: <20240123-carpool-avatar-c1e51ab3cc32@spud>
References: <20240123135014.614858-1-dev@pschenker.ch>
 <20240123-ripening-tabby-b97785375990@spud>
 <b2e232de11cee47a5932fccc2d151a9c7c276784.camel@pschenker.ch>
 <20240123-atlas-dart-7e955e7e24e5@spud>
 <979b1e77b5bb62463d52e7b9d3f9ca1415f4006a.camel@pschenker.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S5tG8E3ZGHoQ0xVt"
Content-Disposition: inline
In-Reply-To: <979b1e77b5bb62463d52e7b9d3f9ca1415f4006a.camel@pschenker.ch>


--S5tG8E3ZGHoQ0xVt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 06:30:16PM +0100, Philippe Schenker wrote:
>=20
>=20
> On Tue, 2024-01-23 at 17:23 +0000, Conor Dooley wrote:
> > On Tue, Jan 23, 2024 at 05:17:53PM +0100, Philippe Schenker wrote:
> > >=20
> > >=20
> > > On Tue, 2024-01-23 at 16:06 +0000, Conor Dooley wrote:
> > > > On Tue, Jan 23, 2024 at 02:50:13PM +0100, Philippe Schenker
> > > > wrote:
> > > > > From: Philippe Schenker <philippe.schenker@impulsing.ch>
> > > > >=20
> > > > > This commit adds the dt-binding for KSZ8567, a robust 7-port
> > > > > Ethernet switch. The KSZ8567 features two RGMII/MII/RMII
> > > > > interfaces,
> > > > > each capable of gigabit speeds, complemented by five 10/100
> > > > > Mbps
> > > > > MAC/PHYs.
> > > > >=20
> > > > > Signed-off-by: Philippe Schenker
> > > > > <philippe.schenker@impulsing.ch>
> > > >=20
> > > > This device has all the same constraints as the other ones in
> > > > this
> > > > binding, why is it not compatible with any of them? If it isn't,
> > > > the
> > > > compatible should mention why it is not.
> > >=20
> > > Hi Conor, Thanks for your message!
> > >=20
> > > I need the compatible to make sure the correct ID of the switch is
> > > being set in the driver as well as its features.
> >=20
> > Are the features of this switch such that a driver for another ksz
> > switch would not work (even in a limited capacity) with the 8567?
> > Things like the register map changing or some feature being removed
> > are
> > examples of why it may not work.
>=20
> Yes the ksz dsa driver is made so that it checks the ID of the attached
> chip and refuses to work if it doesn't match. [1]

That sounds counter productive to be honest. Why does the driver not
trust that the dt is correct? I saw this recently in some IIO drivers,
but it was shot down for this sort of reason.

> It is a very similar chip and uses the same regmap as KSZ9567 but with
> lower phy-speeds on its 5 switch ports. The two upstream CPU ports are
> gigabit capable. All this information is set-up in the second patch of
> this series. [2]

That, to me, means the lack of a fallback is justified. If it were the
other way around, then a fallback sounds like it would be suitable.

>=20
> I will include a description to the second series. Thanks for your
> feedback.

Okay, thanks. You can add
Acked-by: Conor Dooley <conor.dooley@microchip.com>
when you do.

And despite the email, I have nothing to do with these switches, I am
just a sucker that signed up to review dt-bindings...

Thanks,
Conor.

>=20
> Philippe
>=20
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/net/dsa/microchip/ksz_common.c?h=3Dv6.8-rc1#n3181
> [2]
> https://patchwork.kernel.org/project/netdevbpf/patch/20240123135014.61485=
8-2-dev@pschenker.ch/
>=20
> >=20
> > > You mean I shall mention the reason in the commit-message, or
> > > where?
> >=20
> > Yes.
> >=20
> > Thanks,
> > Conor
> >=20
> > > > > =A0Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml |
> > > > > 1 +
> > > > > =A01 file changed, 1 insertion(+)
> > > > >=20
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > > > b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > > > index c963dc09e8e1..52acc15ebcbf 100644
> > > > > ---
> > > > > a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > > > +++
> > > > > b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > > > @@ -31,6 +31,7 @@ properties:
> > > > > =A0=A0=A0=A0=A0=A0 - microchip,ksz9893
> > > > > =A0=A0=A0=A0=A0=A0 - microchip,ksz9563
> > > > > =A0=A0=A0=A0=A0=A0 - microchip,ksz8563
> > > > > +=A0=A0=A0=A0=A0 - microchip,ksz8567
> > > > > =A0
> > > > > =A0=A0 reset-gpios:
> > > > > =A0=A0=A0=A0 description:
> > > > > --=20
> > > > > 2.34.1
> > > > >=20

--S5tG8E3ZGHoQ0xVt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbAHgwAKCRB4tDGHoIJi
0kvHAQCBF6xD/BKHadO7iZFN9iMOo2RaLe3K9v7g7p0g+HgK8wEAlb9ipxRogUDd
63FgSdIHfEYOSZlEpaFfRO6sFvdPHQk=
=5ynU
-----END PGP SIGNATURE-----

--S5tG8E3ZGHoQ0xVt--


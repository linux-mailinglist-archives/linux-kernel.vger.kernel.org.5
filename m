Return-Path: <linux-kernel+bounces-128455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D63895B0B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F641F22CBD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D138415AAB0;
	Tue,  2 Apr 2024 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fi/8z9ry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E715AAB3;
	Tue,  2 Apr 2024 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080023; cv=none; b=psJ+rT9Zlg4+A1NyYDuDGZIX8rZXyqWBzZIi4CkpmWzhRbVyRNnhLkjwcUSflDdux7VoyYqdgqYYidTWz2cZgkLacXzwywJzJAzSnb6hAgVBDQTTRnOFp61UHmeuzKTGNNLnseBDrVAes27ibScgPKVYh7k9jUH/jiCLuD8e/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080023; c=relaxed/simple;
	bh=6qtbcXbgPT258MwDHIMMVnVJMOfvk/DPTeiD+9wwTxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWPtgO78HxTzn/IwED12ZjFqOEd4KMvb8QWHUFNdyVnIrfChzfpd13EBWyWqX7V6QzPTfY4PA1IVptELpTaBZcr8SKezVOJPmoxDMnhZ81QtLfKd8ejD/FeibiHKN6VJ2nc3mPeFp4CSHE5X7ujNwd7XsLPnAzBkx4r0AgHJftY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fi/8z9ry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB79C433C7;
	Tue,  2 Apr 2024 17:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712080022;
	bh=6qtbcXbgPT258MwDHIMMVnVJMOfvk/DPTeiD+9wwTxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fi/8z9ryH9DA63j38wP2nPgPrAlEmUb4Q0Y0T69imsrnRqrdzITdr/fahb11gp21z
	 KKN1E2imygXDCPznJnJs0qFcZ6u0GtXA5S4QR8pMQjPywi5vdYFThIjdkihZ4Lsee3
	 yosHVJqIi0WM4MlahhuZ4ol6ZR/30P3YjrPX9FK/AeU6gwD5HFkl3OmydvHeI1goQv
	 g8Uk2J5t3NiwUkA6pkvWyVfvFmK/jV1c3LLFmv/WFdkREZ2hlVAC4ig/eWtW2+yT10
	 E9XBQNfNr3krf4eJ9C6bRHdXMqJA8OZNTKY3OUnnbAQJaRNEo6LYliSe0QHYwy8Wm0
	 6w2IpUAJiOfIg==
Date: Tue, 2 Apr 2024 18:46:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Steen Hegelund <steen.hegelund@microchip.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT 01/10] arm64: dts: microchip: sparx5: fix mdio reg
Message-ID: <20240402-drizzly-risotto-eac556bbe95b@spud>
References: <20240401153740.123978-1-krzk@kernel.org>
 <b3d818df8819d2fb3e96fa61b277d49941d9b01b.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RilKgIjVf/M7rXnH"
Content-Disposition: inline
In-Reply-To: <b3d818df8819d2fb3e96fa61b277d49941d9b01b.camel@microchip.com>


--RilKgIjVf/M7rXnH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Apr 02, 2024 at 04:00:32PM +0200, Steen Hegelund wrote:
> On Mon, 2024-04-01 at 17:37 +0200, Krzysztof Kozlowski wrote:
> > [Some people who received this message don't often get email from
> > krzk@kernel.org. Learn why this is important at
> > https://aka.ms/LearnAboutSenderIdentification=A0]
> >=20
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > Correct the reg address of mdio node to match unit address.=A0 Assume
> > the
> > reg is not correct and unit address was correct, because there is
> > alerady node using the existing reg 0x110102d4.
> >=20
> > =A0 sparx5.dtsi:443.25-451.5: Warning (simple_bus_reg):
> > /axi@600000000/mdio@6110102f8: simple-bus unit address format error,
> > expected "6110102d4"
> >=20
> > Fixes: d0f482bb06f9 ("arm64: dts: sparx5: Add the Sparx5 switch
> > node")
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >=20
> > ---
> >=20
> > Not tested on hardware
> > ---
> > =A0arch/arm64/boot/dts/microchip/sparx5.dtsi | 2 +-
> > =A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > index 24075cd91420..5d820da8c69d 100644
> > --- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > +++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > @@ -447,7 +447,7 @@ mdio2: mdio@6110102f8 {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p=
inctrl-names =3D "default";
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #=
address-cells =3D <1>;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #=
size-cells =3D <0>;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg=
 =3D <0x6 0x110102d4 0x24>;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg=
 =3D <0x6 0x110102f8 0x24>;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };
> >=20
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mdio3: mdio@61101031c {
> > --
> > 2.34.1
> >=20
>=20
> I did a check of our current Sparx5 EVBs and none of them uses
> controller 2 in any revision, so this is probably why it has not come
> up before, so as it stands we have no platform to test this change on
> currently.
>=20
> Besides that the change looks good to me.
>=20
> Best Regards
> Steen
>=20
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>

Are you okay with the rest of the series, or have you only looked at
this one patch?

--RilKgIjVf/M7rXnH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgxEkQAKCRB4tDGHoIJi
0lSrAQCZbgAp+hHzEbAZUy5ZEACDMf4lJMuQXFA1tS+/Cwh2vgEA/UsYcqeBcYpx
rn636eS2o+9iXzVq75hhahrnTAKyjAA=
=1JM2
-----END PGP SIGNATURE-----

--RilKgIjVf/M7rXnH--


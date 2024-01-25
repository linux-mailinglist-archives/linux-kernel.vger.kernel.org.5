Return-Path: <linux-kernel+bounces-39214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6234983CCDC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B121F22B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A2E13541E;
	Thu, 25 Jan 2024 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9UfcKJA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C6135A45;
	Thu, 25 Jan 2024 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212306; cv=none; b=MCgqJY0ShqtbmuQjYj/Xz7g8CWAEnlyWavdOfz9BcpsRN6cB6p3tXoDdnBV9GiIW0+BrTrjuxgr8IIRyGvBcal3pKa69JSDjMmvUwloqUyaZBdW2FLaRQAb+TvPnfS4JOoUiaTYTrRWtkWwsORICpQJnW3U1jTd5FLpORhRWA+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212306; c=relaxed/simple;
	bh=QLNP0M6wu4KA/+kIwFsIjRRWbd6oSMe76sDMN+UZ/8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXmaaosOWH6eaxIHyflCSt2C8IoWVnGDhNPV1WM4A9tAr376t4KjT8BjEluC8o+oN3xKy5q8VSIQWfLFpPsm6pslKD3Ts19HwTbBdyae/lTX2NcKOHJEnmvXCsXwQRiKvvAW9EhKHR1PV1Kelzl53nOf67RksLi2tivkLnQZIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9UfcKJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F5FC433F1;
	Thu, 25 Jan 2024 19:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706212306;
	bh=QLNP0M6wu4KA/+kIwFsIjRRWbd6oSMe76sDMN+UZ/8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F9UfcKJAbwbyYCix1Nh6V5qWadMYyiZAV2p539hBA1MWSHPZWLkfhez7LHCPFSmix
	 EbCqYhvAXI+y2s2qTnbomlY9fodvlCegz3bS8hp0zabaKCf8vuHDdCggddgeIQW3fc
	 0IN5x3/hC8mIPwm0QS4Lt5U+7lL5y71SXjvuxpkpDcdU6jiys9U2SLZhXJV/NbgAKL
	 SxVgkxaYHAD9jNsfp63b428BELvneKpGGaPa/nXATkdva/b2r2aB2vCIZkvwd8bzhx
	 pLuv7u9NBbCLReXQ9bGpu8Ww+5B/TdvWbIciXgLFz9CoSzB4nZSWSsvywKtRGAsF2R
	 dCDPiVXPaLQ0A==
Date: Thu, 25 Jan 2024 19:51:38 +0000
From: Conor Dooley <conor@kernel.org>
To: William Zhang <william.zhang@broadcom.com>
Cc: David Regan <dregan@broadcom.com>, dregan@mail.com,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, computersforpeace@gmail.com,
	kdasu.kdev@gmail.com, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	joel.peshkin@broadcom.com, tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com, anand.gore@broadcom.com,
	kursad.oney@broadcom.com, florian.fainelli@broadcom.com,
	rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
	andre.przywara@arm.com, baruch@tkos.co.il,
	linux-arm-kernel@lists.infradead.org, dan.carpenter@linaro.org
Subject: Re: [PATCH v3 01/10] dt-bindings: mtd: brcmnand: Updates for bcmbca
 SoCs
Message-ID: <20240125-drove-undiluted-5d822b7fd4fa@spud>
References: <20240124030458.98408-1-dregan@broadcom.com>
 <20240124030458.98408-2-dregan@broadcom.com>
 <20240124-direness-outpost-bbc22550a161@spud>
 <451151f3-33df-4de8-ab62-a683ad4b7cb1@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RBywQ9RMWc8iS1B8"
Content-Disposition: inline
In-Reply-To: <451151f3-33df-4de8-ab62-a683ad4b7cb1@broadcom.com>


--RBywQ9RMWc8iS1B8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Wed, Jan 24, 2024 at 07:01:48PM -0800, William Zhang wrote:
> On 1/24/24 09:24, Conor Dooley wrote:
> > On Tue, Jan 23, 2024 at 07:04:49PM -0800, David Regan wrote:
> > > From: William Zhang <william.zhang@broadcom.com>
> > >=20
> > > Update the descriptions to reflect different families of broadband So=
C and
> > > use the general name bcmbca for ARM based SoC.
> > >=20
> > > Add brcm,nand-use-wp property to have an option for disabling this
> > > feature on broadband board design that does not use write protection.
> > >=20
> > > Add brcm,nand-ecc-use-strap to get ecc setting from board boot strap =
for
> > > broadband board designs because they do not specify ecc setting in dts
> > > but rather using the strap setting.
> > >=20
> > > Remove the requirement of interrupts property to reflect the driver
> > > code. Also add myself to the list of maintainers.
> > >=20
> > > Signed-off-by: William Zhang <william.zhang@broadcom.com>
> > > Reviewed-by: David Regan <dregan@broadcom.com>
> > > ---
> > > Changes in v3:
> > > - Update brcm,nand-use-wp description
> > > - Revert the description change to BCM63168 SoC-specific NAND control=
ler
> > > ---
> > > Changes in v2:
> > > - Revert the new compatible string nand-bcmbca
> > > - Drop the BCM63168 compatible fix to avoid any potential ABI
> > > incompatibility issue
> > > - Simplify the explanation for brcm,nand-use-wp
> > > - Keep the interrupt name requirement when interrupt number is specif=
ied
> > > ---
> > >   .../bindings/mtd/brcm,brcmnand.yaml           | 37 ++++++++++++++++=
---
> > >   1 file changed, 32 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml=
 b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> > > index f57e96374e67..752c6ee98a7d 100644
> > > --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> > > +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> > > @@ -9,6 +9,7 @@ title: Broadcom STB NAND Controller
> > >   maintainers:
> > >     - Brian Norris <computersforpeace@gmail.com>
> > >     - Kamal Dasu <kdasu.kdev@gmail.com>
> > > +  - William Zhang <william.zhang@broadcom.com>
> > >   description: |
> > >     The Broadcom Set-Top Box NAND controller supports low-level acces=
s to raw NAND
> > > @@ -18,9 +19,10 @@ description: |
> > >     supports basic PROGRAM and READ functions, among other features.
> > >     This controller was originally designed for STB SoCs (BCM7xxx) bu=
t is now
> > > -  available on a variety of Broadcom SoCs, including some BCM3xxx, B=
CM63xx, and
> > > -  iProc/Cygnus. Its history includes several similar (but not fully =
register
> > > -  compatible) versions.
> > > +  available on a variety of Broadcom SoCs, including some BCM3xxx, M=
IPS based
> > > +  Broadband SoC (BCM63xx), ARM based Broadband SoC (BCMBCA) and iPro=
c/Cygnus.
> > > +  Its history includes several similar (but not fully register compa=
tible)
> > > +  versions.
> > >     -- Additional SoC-specific NAND controller properties --
> > > @@ -53,7 +55,7 @@ properties:
> > >                 - brcm,brcmnand-v7.2
> > >                 - brcm,brcmnand-v7.3
> > >             - const: brcm,brcmnand
> > > -      - description: BCM63138 SoC-specific NAND controller
> > > +      - description: BCMBCA SoC-specific NAND controller
> > >           items:
> > >             - const: brcm,nand-bcm63138
> > >             - enum:
> > > @@ -111,6 +113,20 @@ properties:
> > >         earlier versions of this core that include WP
> > >       type: boolean
> > > +  brcm,nand-use-wp:
> > > +    description:
> > > +      Use this property to indicate if board design uses
> > > +      controller's write protection feature and connects its
> > > +      NAND_WPb pin to nand chip's WP_L pin.
> >=20
> > > By default the driver
> > > +      uses a module parameter with default value set to enable to
> > > +      control this feature for all boards. Use this dts property to
> > > +      override the default behavior and enable/disable this feature
> > > +      through board dts on a per board basis.
> >=20
> > None of this information about module parameters is relevant in the
> > binding, as it should be independent of the implementation of one
> > particular operating system.
> >=20
> Agree this is OS related stuff. I was trying to make it more clean by
> explaining how it is implemented in linux. And if we were to implement the
> driver for another OS, there will be at least a default value for wp_on. I
> will remove any mention of module parameter from this doc.
>=20
> > If the module parameter is not provided, what does the driver do?
> > If "wp_on" is the module parameter, then the default is to enable the
> > write protection feature. If that's correct, it seems to me that the
> > property should be called something like "brcm,no-wp". This property
> > would be a boolean that indicates that the NAND_WPb and WP_L pins are
> > not connected & nothing more. Clearly if the module param tries to
> > enable WP and the DT property indicates that it is not supported you
> > can decline to enable the feature, but that is up to the drivers in
> > the OS to decide.
> >=20
> If I were to implement this from day one, I certainly will choose the same
> approach as you suggested here.  But there is existing brcm,nand-has-wp
> property for other purpose and now if we have brcm,no-wp, it will be more
> confusing with that property IMHO. I prefer to keep use the "has" for
> feature availability and "use" for feature being used or not.

"brcm,wp-not-connected" then, since I want it to become a boolean and it
would better communicate what the problem is than "brcm,dont-use-wp"
would.

> And the reason I keep it as int is because there could be a potential val=
ue
> of 2 for another mode that the current driver could set the wp_on to.

Can you explain, in driver independent terms, what this other mode has
to do with how the WP is connected?
Either you've got the standard scenario where apparently "NAND_WPb" and
"WP_L" are connected and another situation where they are not.
Is there another pin configuration in addition to that, that this 3rd
mode represents?

> I
> don't see it is being used in BCMBCA product but I am not sure about other
> SoC family. So I don't want to completely close the door here just in cas=
e.

If you ever need it, you could have a "brcm,wp-in-wacky-configuration"
property that indicates that the hardware is configured in that way
(providing that this hardware configuration is not just "NAND_WPb" and
"WP_L" pins connected. The property can very easily be made mutually
exclusive with "brcm,wp-not-connected" iff it ever comes to be.

> > > +      Set to 0 if WP pins are not connected and feature is not
> > > +      used. Set to 1 if WP pins are connected and feature is used.
> >=20
> > As it stands, this property is firmly in the "software policy" side
> > of things, as it is being used as an override for a module parameter,
> > particularly given you have properties for each direction. Whether or
> > not the feature is to be used by the operating system is not relevant to
> > the binding.
> >=20
> I don't understand why this is a software policy.  This is the board desi=
gn
> choice although it does override the driver default value. But it is still
> board or device setting and describe the hardware. OS has to follow this
> hardware configuration and set up accordingly.

The software policy side of things is that you are instructing the
software what to do with "use" nature of it and the force enable &
disable options for the property. A boolean property that tells software
that the wp is not connected is all you need, as far as I can tell.
That should be sufficient information for the operating system to know
whether or not it can use the wp.

> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [0, 1]
> > > +
> > >   patternProperties:
> > >     "^nand@[a-f0-9]$":
> > >       type: object
> > > @@ -137,6 +153,16 @@ patternProperties:
> > >             layout.
> > >           $ref: /schemas/types.yaml#/definitions/uint32
> > > +      brcm,nand-ecc-use-strap:
> > > +        description:
> > > +          This flag is used by the driver to get the ecc strength and
> > > +          spare area size from the SoC NAND boot strap setting. This
> > > +          is commonly used by the BCMBCA SoC board design.
> >=20
> > Quoting from v1, as I didn't get to it in time:
> >=20
> > | > This property I'm not all that sure about either. If the specific
> > | > properties that you mention here are not set in the DT what happens=
 at
> > | > the moment?
> > | >
> > | In that case, the ecc strength and oob size come from ONFI or nand id
> > | decoding.  But that is usually the minimum requirement and user can
> > | choose to use stronger ecc as long as there is enough oob spare area =
in
> > | the nand chip.
> > |
> > | > I suppose what I am getting at is why are the bootstrap settings not
> > | > always used in the absence of specific values provided in the DT?
> > | >
> > | This is because the STB, iProc and other chip and their board design =
may
> > | not have or use the strap setting. But for BCMBCA SoC and board
> > | reference design, we always use the strap setting.
> >=20
> > My main question here I suppose is why would you need this property at
> > all? If the specific properties are provided (nand-ecc-strength etc)
> > then use them, and if they are not use the strap settings?If
> > nand-ecc-strength does not exist, the current driver implementation
> use the auto detected ecc strength from the NAND chip ONFI parameter which
> is okay. But for BCABCM SoC and our reference board design, we don't use
> nand-ecc-strength and don't want to use the auto detected value(as they a=
re
> typically minimum requirement) but rather use strap setting so I need a
> third choice.

That seems reasonable. Please limit the property though to the SoCs
where it is relevant if you had not done so already.
Thanks for the explanation.

> > If there's no properties and no strap settings, the this property does
> > not help. If there's properties and strap settings, but properties are
> > wrong, then you just have some devicetrees that incorrectly describe the
> > hardware and need to be fixed.
> >=20
> True but manually setting nand-ecc-strength can be error prone like
> copy/paste error. The hardware strap setting does not involve such edit in
> the dts file so no error can happen.

Copy paste errors are not really an argument here, you could use that as
an excuse for anything DT property in the world.. You could copy paste
the wrong thing into the strap, and idk about you, but on the systems I
have it is far easier to change the DT passed to the kernel than what I
assume is an early bootloader stage? (I tried googling for "broadcom
strap" but there was nothing relevant)

> > > If ecc
> > > +          strength and spare area size are set by nand-ecc-strength
> > > +          and brcm,nand-oob-sector-size in the dts, these settings
> > > +          have precedence and override this flag.
> >=20
> > Again, IMO, this is not for the binding to decide. That is a decision
> > for the operating system to make.
> >=20
> Again this is just for historic reason and BCMBCA as late player does not
> want to break any existing dts setting.  So I thought it is useful to
> explain here.  I can remove this text if you don't think it should be in =
the
> binding document.

I don't, at least not in that form. I think it is reasonable to explain
why these values are better though.

Thanks,
Conor.

--RBywQ9RMWc8iS1B8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbK7ygAKCRB4tDGHoIJi
0s+HAP0dTWSerDmmb/ifwIBohH15b3yqgvrNaY7FwwskT/dfigD+NZV2yWisvM9H
zw3klP3GLMQGXl+H2IZHG3/i19rUxww=
=2try
-----END PGP SIGNATURE-----

--RBywQ9RMWc8iS1B8--


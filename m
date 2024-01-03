Return-Path: <linux-kernel+bounces-15133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596A182278C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9881C22E00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B4ECA71;
	Wed,  3 Jan 2024 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="quwu6wqF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fBJcxNxI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2554017981;
	Wed,  3 Jan 2024 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwcx.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id F022B3200B3E;
	Tue,  2 Jan 2024 22:21:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 02 Jan 2024 22:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704252117; x=1704338517; bh=Vx7gAZqcX1
	T28qVZAMMb06W1dpVHsSeRGs3le6ELFdI=; b=quwu6wqF765KNAVZVnVssxC5zd
	Qk1Cfum5IF8R1thR8YdxV9m4bmNqYIQ5Adjp3+cWBjC3tbOxLB4kbKeaa9eZqcGc
	IwPg4+B+1fbXeyCvkb9Hz4w8WcNGZZgxfq/+2lF80wzmntWV1YRmXl+XytOoS2EK
	CVWLa/HDNaJSLtpVFnLJVMNLZMnDDoYn3pb2jx+S5UxtMsLoVKqjZ9c7JtsGXcrp
	I/qxsP9ICw6GEoGq5oiL/bzgRMPZxFNRcx9IYjSexJW4U5geu7WibHIxrDWMWIBX
	2Gs7KF4Ey23xy2RL0fc3lKm93Ph4v/zRKHNIucFmjFvrHUhi0W8FyiOGY/IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704252117; x=1704338517; bh=Vx7gAZqcX1T28qVZAMMb06W1dpVH
	sSeRGs3le6ELFdI=; b=fBJcxNxI6skA8Mx1ZH3B5eSODxHn4LqIoY9cGHIf44Hg
	lUvQIJBcsqIfWZoLduLlC+PiuKa9LRubVMXPjlSDlAXOZ8hxp+B7KHQehBuWIllD
	SaBLFI0R02NGg5CZdW6PEeC8TN+Vi5pBpehqglLf2x1iBE+zvYQcr4pnjF41W08D
	20jT3wLk9J7GVC7BLybGWs4VHpb7xo9F+UhHCzgZ6j/Jxrwrwhhyl9pol/Oe6MeJ
	KipFStQ12rgvuJpDq3nnXpGHHN6O0ODbN8/scwdWil9sS29nuiPQh0bYXmeIK9ry
	FH2T0cecfU535sOodZDC0ztTVovSyzijfOU+DBw+EQ==
X-ME-Sender: <xms:1NKUZWPdTBMosocJoVlGBa_taJHJLWlS9wa4nROkNID7eOzD9Kw8nw>
    <xme:1NKUZU9R23_x1rNxd8S9KhDHp8-2by5lYZktXFNBB4xY-rU6_fQnn-IzGNWK5bGrR
    8mIJjC2oi9sa7E_uvg>
X-ME-Received: <xmr:1NKUZdTwouk9KjrO6OAvYtOoiScr7lEMAsYZYEE3TvVQzXA3XLqoEU3AlyE6TGbMBdemleqaXKQCx6h3Wyt1W7KoEQvfhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludejmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeelkeehhfffjeffhefhueehfeef
    keeuteetudfhuefgveduveehheeiuefhjeevjeenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:1NKUZWtuEv9y7xpfc8LOhtMkpzJ2Jvsk-aDBS1VxECWIu9foRuC0Gw>
    <xmx:1NKUZefp9PqVPc_eBuvRVM4THRFQx-oRbv_1lyUut-UOv2ZZ6ay_Kg>
    <xmx:1NKUZa29R1gVvKjEd1--O2uDw29jVXlvPM81AJlBPS6PxQQxsdQH9g>
    <xmx:1dKUZa2VrAoim_rD-ofdb5Q1xCKZwAXwYgCBQU1niV1ZE8S8yWl8RQ>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jan 2024 22:21:55 -0500 (EST)
Date: Tue, 2 Jan 2024 21:21:54 -0600
From: Patrick Williams <patrick@stwcx.xyz>
To: Lukas Wunner <lukas@wunner.de>
Cc: Howard Chiu <howard10703049@gmail.com>, robh+dt@kernel.org,
	joel@jms.id.au, andrew@aj.id.au, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, potin.lai@quantatw.com,
	Howard Chiu <howard.chiu@quantatw.com>,
	linux-integrity@vger.kernel.org, rentao.bupt@gmail.com
Subject: Re: [PATCH v8] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Message-ID: <ZZTS0p1hdAchIbKp@heinlein.vulture-banana.ts.net>
References: <20231220080733.GA30641@wunner.de>
 <F444BFCC-1D44-4AF6-A0E1-B153A217FFE3@stwcx.xyz>
 <20231220170012.GA10387@wunner.de>
 <ZYYP1C0h4ms9kEjA@heinlein.vulture-banana.ts.net>
 <20231223083623.GA17734@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hwM5F1OEC+dSLR9t"
Content-Disposition: inline
In-Reply-To: <20231223083623.GA17734@wunner.de>


--hwM5F1OEC+dSLR9t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 09:36:23AM +0100, Lukas Wunner wrote:
> On Fri, Dec 22, 2023 at 04:38:12PM -0600, Patrick Williams wrote:
> > On Wed, Dec 20, 2023 at 06:00:12PM +0100, Lukas Wunner wrote:
> > > If chips are dual-sourced or triple-sourced, as you say, and they
> > > behave identically, then I think it is fine to specify all of their
> > > compatible strings plus the generic compatible. =20
> >=20
> > This has explicitly been rejected before; having multiple incompatible
> > chips listed in the same compatible.  I've tried to search lore but I
> > can't find a reference unfortunately.
>=20
> I'll let devicetree maintainers comment on that.
>=20
>=20
> > Furthermore, what you're suggesting does not jive with what is in the
> > devicetree binding documentation for tpm_tis-spi [2]:
> >=20
> > - compatible: should be **one** of the following (emphasis mine)
>=20
> That's superseded by:
>=20
> https://lore.kernel.org/all/cover.1702806810.git.lukas@wunner.de/
>=20
> I don't really have a dog in this fight, I merely stepped up to
> convert TPM DT bindings to YAML.  There have been multiple attempts
> to convert them in the past but none of them have been pursued into
> mainline.

Thank you for the effort and context.  I wasn't aware of this pending
change.

> I looked at compatible string usage in arch/arm{,64}/boot/dts
> and was under the impression that the majority of devicetrees
> use a combo matching this pattern:
> "vendor,chip", "tcg,tpm[_-]tis-{spi,i2c,mmio}"
>=20
> So that's what I went for in the conversion.  It would be inconsistent
> to enforce a generic compatible for i2c and mmio, but not for spi.
>=20
> I ran the validator against all arm/arm64 devicetrees and there are
> four devicetrees which only use a generic compatible and not a
> "vendor,chip" compatible:
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
> arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
> arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
> arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi

After some investigation, it should be safe to use "infineon,slb9670"
for all of the facebook systems.  If you want to add that to your patch
set you can cc me and Tao Ren (rentao.bupt@gmail.com) and I will at
least give my Reviewed-by.

> So, three Aspeed Facebook and one Moxa.  There's a fifth case (phyTEC)
> but the devicetree author clarified it's an Infineon SLB9670.
> The authors of the other four devicetrees listed above did not respond.
>=20
> Patches to fix up schema violations are here:
> https://github.com/l1k/linux/commit/7813a455ed15393df7d9d353173635b98ae23=
387
> https://github.com/l1k/linux/commit/a958be44952b1de170100be1007780a72ce7d=
861
>=20
>=20
> > As I said,
> > these are pluggable modules and not simply second-source builds.  There
> > are a collection of modules that can all be plugged into the same heade=
r.
> > They might not even be shipped with the device...
>=20
> If those TPM modules might not even be plugged in or are interchangeable,
> I think they ought to be represented as DT overlays.

I still don't think DT overlays are appropriate for TPMs as it
effectively extends the attack surface for the kernel PCRs all the way
until you can run enough code to load the appropriate DT overlay,
which is likely somewhere in userspace.  This seriously diminishes the
value of measured boot.

> Honestly I'm wondering how common the scenario you're describing is.
> If it's an edge case, it might not be worth holding up the YAML
> conversion because of it.  The missing YAML conversion is a constant
> cause of pain for a lot of people.

Understood.

Since any of the chips we might be using are currently equivalent from a
driver perspective with the generic TCG spec (and the infineon,slb9670
compatible) we should be fine.  If there becomes an incompatibility in
the future with the tpm_tis_spi code we'll cross that bridge at that
time.

--=20
Patrick Williams

--hwM5F1OEC+dSLR9t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmWU0tAACgkQqwNHzC0A
wRldVw/9F9/Ybs0KhE/j89cPIXbUTw5eqIFIv9vbH83SoCUDpD2ZQS6DvHA1JTC8
osLolgZpMQSZbk80qnDLwd6xZyedkCzXAIuWFB/HWCB2HMVhLCHSfWG6Em5rNH+A
cChn24384cGoKr2gv+HKW+rjOut7rjus8+7zdRJoRXOtvovDRT6p86fqn+mlJjh8
Eo1b50oaoW3+IEN+P7sdpIn9ryLTK/MF8bnKT6gwijyXigGo3EV5CJ0TRkd53XaH
IrUpQZKKMZ0uTp9FMO1FTH68FWqKQ9/8cN6uL5kdDw3CnxI4ImfQWnVyKuK7w18m
dA0GdGKp5ew5pSmuhixkjufMQJwP+tTNAAHlBAXiEtNaXncJqn7gVkF0v3dmdkXV
6pAh68Zs59ob8hgPu1X85ndS7l9miuezALJ2tSZcKK/ZiaPB72N2LeGIQPdwAhBn
aBPay31GF+/ew6IB1eJoPXcKGOKgUdebafsHnXLXpajBHW2L4txIz5QLPXBxopbn
zvGTmb9xH6mCnAmA0zjUv5ddzhzO00V0kll8fmnVFZ/KVj2D9xh/5KKBkcjKvp23
GW18pHYbSxEPDWjosf30+qzW3pnbnTTnhXD79PlqPx8Bpi16CQd1rcaIoKbYMYCv
suW4zaGjWhTyGCISp8dujMdDdWMGWdHUy3BL5iK0STfI7BDY4jI=
=inLs
-----END PGP SIGNATURE-----

--hwM5F1OEC+dSLR9t--


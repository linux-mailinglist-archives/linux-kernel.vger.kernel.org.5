Return-Path: <linux-kernel+bounces-10084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B22381CFD7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9454B1F24280
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD542E85E;
	Fri, 22 Dec 2023 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="lHECv2H0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EEs74KvM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F311EB37;
	Fri, 22 Dec 2023 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwcx.xyz
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 28ADB5C025B;
	Fri, 22 Dec 2023 17:38:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 22 Dec 2023 17:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1703284694; x=1703371094; bh=/41xo+PgsU
	6BMJfQdmIBbnZG36MQnMC6lXFKf5V3ln0=; b=lHECv2H0/3MzwSqA+HM3sTqnY7
	w0W2Je0aveo3bUZ9Ze60PgAM8iugwNGsSAYt7e1/XV8hKDaRscf14WGo+Cz970z0
	EmU25JPlbfyztsOuPJPYZSa1BeC6fUqbQ7tVb+PvRJ2hzP4EFipW4UbpV+5u0pMx
	lfM85irt67KA8UrjHxuUKl/+ZCCjra+Z+2JWU5rU4VGOfQs+WST4TE/gmRa4+3Ar
	8ngZL49ZSBPddByIJpH/clUptH/loOKadZfQigH4OlOGPB5jeD1ElHOu4dsUI2Vq
	GTvv6G8+lpbvz/gyn7C6e8yhpPmtRzH4C7viXQ+b7cLKkXFIMg77SMp3Cu7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703284694; x=1703371094; bh=/41xo+PgsU6BMJfQdmIBbnZG36MQ
	nMC6lXFKf5V3ln0=; b=EEs74KvMB9STSi74yK0MEsMjXS0SdviaIBnWISrsDx2z
	8mrOGIjI2X0thmLryHks6aJtQsEU32oHZqICJCJiDfbul67TZEedh5p3nQxbKpLP
	z1KH3NaY187b7R7v8bsT5b1DtA1G0TnahphCeK6qIwopjfH36BcIa5T8C0L6ysJe
	95BphITNVPB+2UwvLVMw/IJwed6sfXk1y85ahhO+JgJiilpa5hMYzTa5vuk9FsDy
	nVpBLcWfVpHrBtzyxCI9YmIyC/XQqZZg6BwFY1cSCe8sPYU2VS72/bY39ezA/cYT
	FYq0p2QL6j/OSGo30PLfPLlvHB0PX6GMMY5Vnd7LZQ==
X-ME-Sender: <xms:1Q-GZdkMd629aLlbFa4BT017-dWtGAmRIevn5N6mAYHV3k5ZxgMIFQ>
    <xme:1Q-GZY2KPR8C3ZPUxDVyeiTZD72p5tuEmDoTegtE8oh6z-bpeopgighQJfsmEZGPf
    xjDO4XjbYUaHbVlMms>
X-ME-Received: <xmr:1Q-GZToEC4_A6vCkVShmQ0TmM__SRY6AD_GOhAtulsyi4Dn8LUt3pjaTQ6Zo5m45d_6PWeO5OJE_PL95WvYYDUjhpTIifA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddukecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculddugedmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvden
    ucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhesshhtfi
    gtgidrgiihiieqnecuggftrfgrthhtvghrnhepleekhefhffejffehhfeuheeffeekueet
    teduhfeugfevudevheehieeuhfejveejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    dpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:1Q-GZdlU2EMYnv76jhyo3h5CNH5sAhIs1tsIuETXt22yzN1FlpfIPw>
    <xmx:1Q-GZb3apuHtOWBKjhrRkYdQoDDEuC2Rbm38UPTRYzdFBPlZqhN3xQ>
    <xmx:1Q-GZcuMswmJ3YoQJmrn56y0YsZEZPfVryhbCLB4KSoH7JOqRX1OWA>
    <xmx:1g-GZUuWHSdA7l9IseMrsIBgyWm61LDwVXdhnGYH-thcOID0Bq9q-Q>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Dec 2023 17:38:12 -0500 (EST)
Date: Fri, 22 Dec 2023 16:38:12 -0600
From: Patrick Williams <patrick@stwcx.xyz>
To: Lukas Wunner <lukas@wunner.de>
Cc: Howard Chiu <howard10703049@gmail.com>, robh+dt@kernel.org,
	joel@jms.id.au, andrew@aj.id.au, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, potin.lai@quantatw.com,
	Howard Chiu <howard.chiu@quantatw.com>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v8] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Message-ID: <ZYYP1C0h4ms9kEjA@heinlein.vulture-banana.ts.net>
References: <20231220080733.GA30641@wunner.de>
 <F444BFCC-1D44-4AF6-A0E1-B153A217FFE3@stwcx.xyz>
 <20231220170012.GA10387@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OQcMnazqIYJ69ZvE"
Content-Disposition: inline
In-Reply-To: <20231220170012.GA10387@wunner.de>


--OQcMnazqIYJ69ZvE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(cc'd TPM mailing list for awareness)

On Wed, Dec 20, 2023 at 06:00:12PM +0100, Lukas Wunner wrote:
> On Wed, Dec 20, 2023 at 06:38:59AM -0600, Patrick Williams wrote:
> > On Dec 20, 2023, at 2:07AM, Lukas Wunner <lukas@wunner.de> wrote:
> > > On Tue, Dec 07, 2021 at 05:49:24PM +0800, Howard Chiu wrote:
> > > > Initial introduction of Facebook Bletchley equipped with
> > > > Aspeed 2600 BMC SoC.
> > > [...]
> > > > +        tpmdev@0 {
> > > > +            compatible =3D "tcg,tpm_tis-spi";
> > >=20
> > > What's the chip used on this board?  Going forward, the DT schema for=
 TPMs
> > > requires the exact chip name in addition to the generic "tcg,tpm_tis-=
spi".
> >=20
> > Why is this a requirement?  This assumes there is exactly one chip.
> > TPMs are often placed on a pluggable module in which multiple vendors
> > could be used. There is no way in the DTS to specify multiple compatible
> > chips.
>=20
> It seems to be a convention to provide the name of the chip that's
> actually used, in addition to the generic compatible.

My impression is that this is subsystem dependent.  The MTD SPI-NOR
subsystem, for example, does not want any compatible or additional devices
added and instead `compatible =3D "jedic,spi-nor"` is all you need.  The
subsystem does the SFDP detection of the specific device (and
parameters) [1].

> One advantage I see is that specific properties can be enforced per-chip.
> E.g. Infineon SLB9670 TPMs support an SPI clock of up to 43 MHz,
> whereas Atmel ATTPM20P support 36 MHz.  The devicetree schema may
> contain those maximum speeds and the validator can check whether
> devicetrees observe them.

Noble goal.

For the Aspeed SOC that we use to interact with the TPM module, the
hardware logic doesn't properly implement bi-directional access, so we
end up using the SPI-GPIO driver and running at speeds far far below any
device maximum (obviously this isn't everyone's problem).

> Similarly, a device driver may use chip-specific quirks based on the
> compatible string.

IMO, if a chip requires quirks in order to function properly then it
isn't compatible with "tcg,tpm_tis-spi" is it?  Standards exist for a
reason.  If a chip can't follow them, don't claim it does.

> Last not least, it is useful for documentation purposes to specify which
> chip is used.
>=20
> If chips are dual-sourced or triple-sourced, as you say, and they
> behave identically, then I think it is fine to specify all of their
> compatible strings plus the generic compatible. =20

This has explicitly been rejected before; having multiple incompatible
chips listed in the same compatible.  I've tried to search lore but I
can't find a reference unfortunately.  We've had similar scenarios with
second-source scenarios and have been told to: change the DTS in u-boot,
use user-space bind calls, or work with the DTS overlay project to get
that working.  Frankly, all of those options are a challenge for
something fundamental like the TPM.

Furthermore, what you're suggesting does not jive with what is in the
devicetree binding documentation for tpm_tis-spi [2]:

- compatible: should be **one** of the following (emphasis mine)

> If they do not
> behave identically, separate devicetrees should be used for each
> board version with a different chip.

I am not following how that would work in a reasonable way.  As I said,
these are pluggable modules and not simply second-source builds.  There
are a collection of modules that can all be plugged into the same header.
They might not even be shipped with the device...  You might want TPM
modules provisioned under control of your own process, rather than the
device manufacturer, and you plug them in prior to using the device.

The only way I can conceive of doing this is to have a good chunk of u-boot
code that detects which module is plugged in and manually modifies the
compatible string in the DTS before loading the kernel.  Of course,
doing this changes your measurements and has to be done in the CRTM,
both of which decrease your security posture.

1. https://lore.kernel.org/lkml/4817515e-2833-6d39-03c3-30470344ac3a@microc=
hip.com/
2. https://github.com/torvalds/linux/blob/c0f65a7c112b3cfa691cead54bcf24d6c=
c2182b5/Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt#L2

--=20
Patrick Williams

--OQcMnazqIYJ69ZvE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmWGD9IACgkQqwNHzC0A
wRmWYxAAlDTf5ibEEie/2tY+6Ye3F23Zs2JKQIBmmFJhOhVPx59wzNM4gZ4VESoX
93pM9mZ5zqK9isCRUTKARNL/KcB/A23Q6T/iXccbMW3DMo/xKtTMKN9oHh5fWqxh
QWv1uNOGxYbuuIHlMjsvArdoA5sFxQpL0gJvg20nee6uhmtYxvQk4KPDOgMaF7zv
ZUY42FAiAfu96VLC1okPmHJC45O59QMPbvTb1JjFxyijzwXyXWpPrOBywZozWqr+
BNlJuhPjHZ1GE0yylsGeCQyTLgVPoPxPRLtZgd2meWBgQO45pqxzmw12acQphjrc
ua7mjfK0bCsphvQNJUR0Qy45zCJ3LQBB2MxSkkNN/mPPh0xce/C7uqX/vBCZ0wOf
Uu9tg92VTDcPn1blCYb6vGdnaVwWodJ24XikdZ4n+KGIkaw7lbK2n7Ldpze9NaAq
Xn4ZZHfWTKe1aHHBAW+17neq6+zaZdQYd4UUas96uAJJpD1ywnQQY1zWdgOqaKld
HkfnbWCDaimZg5haf7U5+sD3DbS+HEMtvIzrYwzvy/H1lSq/0j/B1pB8aysILrXm
zsS2jPZDs8+btNneH80zlZkkTEQmT5If2IOKxcGrDxRKz/z5w6CUKlgY+2j03yXv
M+7UcXeKjx5fsy5s9rj36P3vrHL/R7DuKeNMRqaajkLkJB5wc9E=
=BJb0
-----END PGP SIGNATURE-----

--OQcMnazqIYJ69ZvE--


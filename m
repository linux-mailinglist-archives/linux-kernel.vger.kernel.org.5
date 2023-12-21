Return-Path: <linux-kernel+bounces-8055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851E81B1B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 970E3B25CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEB84BA98;
	Thu, 21 Dec 2023 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1Q8ENqa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00F64A995;
	Thu, 21 Dec 2023 09:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7F4C433C8;
	Thu, 21 Dec 2023 09:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703149377;
	bh=p5dHoof6CpVRm8H51oSiaRXPqfim6y17RnxB7xY56tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1Q8ENqaz4vYwDVkG3agH8Y4nWY+t+vf+dRK4CWAox6pMkmw0lE5CiewwHUcSFbp4
	 RkWIsVyItgSe8hLDbVe7XR+8+z2jsXtz39K9l++LNfCrEsMCoGDX4J/MON0Esni2Wq
	 iqrEvVOXEmgR6BzB7qFtyB6TBQUBqZsN45F0aj+iNwKZJOMYPXJ+ALJKqxfvUPDBQl
	 rhlhXxneBAsPHxzhYuLmXAXUstbegLTSelvwcYG7NV5MOIsYEKj9nW+wOHWTOrkTWg
	 ptmFIbWZj+VriBf6p9Woko7ugLT2AK5cwSkli+QHtfdeHxaYVqcZc5AQiBUtk0h6/e
	 /8F23EhrD4POQ==
Date: Thu, 21 Dec 2023 10:02:54 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, 
	Frank Binns <frank.binns@imgtec.com>, Donald Robson <donald.robson@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, Adam Ford <aford173@gmail.com>, 
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH RFC 01/10] dt-bindings: gpu: Add PowerVR Series5 SGX GPUs
Message-ID: <3dggaesvunebogkqvclz4imruhynrftkhsvmndm75vfccqwpa6@3zp3dgzpzta6>
References: <B3A1B8A7-0363-4ECB-AFBF-576FECA569FA@goldelico.com>
 <vawv2mwhonuyvgmp7uox4rfgdcjwg5fa7hmbcfgl3wiase6e4p@tyavpclppfvu>
 <6BC60156-89E2-4734-BD00-B49A9A6C1D7A@goldelico.com>
 <6gpehpoz54f5lxhmvirqbfwmq7dpgiroy27cljpvu66wtn7aqy@lgrh7wysyxnp>
 <D8AB6CC4-DCA5-40DD-A311-94A16FF59254@goldelico.com>
 <oobcl2kfsuph27er7rflfqvt3lu6athufomxv5chf3uctx4emh@x6rzjtlskhbf>
 <F58855EC-D87D-4747-A363-0E7AA5DB1AEC@goldelico.com>
 <22cny5aumc5wafsrjd3j55zcjbjf2viip64kfbjiqis2grtd6t@wg5dxeuzil6l>
 <3E03E913-48E1-49EC-A6C9-EAC1612E65E7@goldelico.com>
 <a3feaf42-17fb-46e5-bbb0-3ffc4ad40bfd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xdjqplvcfzg6bqbd"
Content-Disposition: inline
In-Reply-To: <a3feaf42-17fb-46e5-bbb0-3ffc4ad40bfd@ti.com>


--xdjqplvcfzg6bqbd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 11:19:49AM -0600, Andrew Davis wrote:
> On 12/18/23 4:54 AM, H. Nikolaus Schaller wrote:
> >=20
> >=20
> > > Am 18.12.2023 um 11:14 schrieb Maxime Ripard <mripard@kernel.org>:
> > >=20
> > > On Mon, Dec 18, 2023 at 10:28:09AM +0100, H. Nikolaus Schaller wrote:
> > > > Hi Maxime,
> > > >=20
> > > > > Am 15.12.2023 um 14:33 schrieb Maxime Ripard <mripard@kernel.org>:
> > > > >=20
> > > > > > >=20
> > > > > > > It's for a separate architecture, with a separate driver, mai=
ntained out
> > > > > > > of tree by a separate community, with a separate set of requi=
rements as
> > > > > > > evidenced by the other thread. And that's all fine in itself,=
 but
> > > > > > > there's very little reason to put these two bindings in the s=
ame file.
> > > > > > >=20
> > > > > > > We could also turn this around, why is it important that it's=
 in the
> > > > > > > same file?
> > > > > >=20
> > > > > > Same vendor. And enough similarity in architectures, even a log=
ical sequence
> > > > > > of development of versions (SGX =3D Version 5, Rogue =3D Versio=
n 6+) behind.
> > > > > > (SGX and Rogue seem to be just trade names for their architectu=
re development).
> > > > >=20
> > > > > Again, none of that matters for *where* the binding is stored.
> > > >=20
> > > > So what then speaks against extending the existing bindings file as=
 proposed
> > > > here?
> > >=20
> > > I mean, apart from everything you quoted, then sure, nothing speaks
> > > against it.
> > >=20
> > > > > > AFAIK bindings should describe hardware and not communities or =
drivers
> > > > > > or who is currently maintaining it. The latter can change, the =
first not.
> > > > >=20
> > > > > Bindings are supposed to describe hardware indeed. Nothing was ev=
er said
> > > > > about where those bindings are supposed to be located.
> > > > >=20
> > > > > There's hundreds of other YAML bindings describing devices of the=
 same
> > > > > vendors and different devices from the same generation.
> > > >=20
> > > > Usually SoC seem to be split over multiple files by subsystem. Not =
by versions
> > > > or generations. If the subsystems are similar enough they share the=
 same bindings
> > > > doc instead of having one for each generation duplicating a lot of =
code.
> > > >=20
> > > > Here is a comparable example that combines multiple vendors and gen=
erations:
> > > >=20
> > > > Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > >=20
> > > EHCI is a single interface for USB2.0 controllers. It's a standard AP=
I,
> > > and is made of a single driver that requires minor modifications to d=
eal
> > > with multiple devices.
> > >=20
> > > We're very far from the same situation here.
> >=20
> > How far are we really? And, it is the purpose of the driver to handle d=
ifferent cases.
> >=20
> > That there are currently two drivers is just a matter of history and no=
t a necessity.
> >=20
> > >=20
> > > > > If anything it'll make it easier for you. I'm really not sure why=
 it is
> > > > > controversial and you're fighting this so hard.
> > > >=20
> > > > Well, you made it controversial by proposing to split what IMHO bel=
ongs together.
> > >=20
> > > No, reviews aren't controversial.
> > > The controversy started when you chose
> > > to oppose it while you could have just rolled with it.
> >=20
> > Well, you asked
> >=20
> > "I think it would be best to have a separate file for this, img,sgx.yaml
> > maybe?"
> >=20
> > and
> >=20
> > "Because it's more convenient?"
> >=20
> > I understood that as an invitation for discussing the pros and cons and=
 working out the
> > most convenient solution. And that involves playing the devil's advocat=
e which of course
> > is controversial by principle.
> >=20
> > Now, IMHO all the pros and cons are on the table and the question is wh=
o makes a decision
> > how to go.
> >=20
>=20
> As much as I would land on the side of same file for both, the answer to =
this question
> is simple: the maintainer makes the decision :) So I'll respin with separ=
ate binding files.
>
> The hidden unaddressed issue here is that by making these bindings separa=
te it implies
> they are not on equal footing (i.e. pre-series6 GPUs are not true "powerv=
r" and so do not
> belong in img,powervr.yaml).

No, not really. As far as I'm concerned, the only unequal footing here
is that one driver is in-tree and the other isn't, but this situation
was handled nicely for Mali GPUs and lima that used to be in the same
situation for example.

The situation is simple, really: bindings are supposed to be backward
compatible, period. If we ever make a change to that binding that isn't,
you will be well within your right to complain because your driver is
now broken.

> So if no one objects I'd also like to do the rename of that
> file as suggested before and have:
>=20
> img,powervr-sgx.yaml
> img,powervr-rogue.yaml

Sounds good to me.

Maxime

--xdjqplvcfzg6bqbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZYP/PgAKCRDj7w1vZxhR
xecAAQCmVXhaAl7fZ7g76z9w82Bf0j4pTMmQspV3lIhk356FHgEA/xGS5jxCtd+G
824sqakZ7+v2m4QT6HsRgxUigbfQcQ8=
=eukR
-----END PGP SIGNATURE-----

--xdjqplvcfzg6bqbd--


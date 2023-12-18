Return-Path: <linux-kernel+bounces-3307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D08B816AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30ACBB20B70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5686713ADC;
	Mon, 18 Dec 2023 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd20Edhm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CF113FE6;
	Mon, 18 Dec 2023 10:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6755C433CA;
	Mon, 18 Dec 2023 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702894467;
	bh=6q68azC955xrTVALbmO5YmJ9GQg0JKxbUIF9Ow4nWMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cd20EdhmnmW7oYL7H6uIxJBVzPArC24QyeozGNWEQfFNW4Bbk65REhag58Ygu10QG
	 a9+MGQ5fmPYZgtzkuOJPbE3g+c0tnKSr+XxZL+UP8lR2WDl/3Opl2uYNR4S7dt7BGn
	 x0+EjwVXfswcjbrZ7lHyeiRJf/Luv6GYFnDZkrjoSmJTF69D5yqMLhJvDOt2B4lNLg
	 KirImYypTuab/eHtTNpIzs06W2oSyWpK+1uIjztjwFPs2tPvqPs1PBzlXPU9QLCZZp
	 e6JzkeBKkBjEFO2WH2548EohrR+s8IiaEFK1rKBrRA68XCdL1HpjWni4VWKQLbSf/e
	 v5p2Vjh6qbu/Q==
Date: Mon, 18 Dec 2023 11:14:24 +0100
From: Maxime Ripard <mripard@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Andrew Davis <afd@ti.com>, Frank Binns <frank.binns@imgtec.com>, 
	Donald Robson <donald.robson@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Adam Ford <aford173@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH RFC 01/10] dt-bindings: gpu: Add PowerVR Series5 SGX GPUs
Message-ID: <22cny5aumc5wafsrjd3j55zcjbjf2viip64kfbjiqis2grtd6t@wg5dxeuzil6l>
References: <20231204182245.33683-1-afd@ti.com>
 <20231204182245.33683-2-afd@ti.com>
 <23livt5mcc64bb6lkeec2uxp5cyn4wfekwaj6wzrjnrkndvwgj@6tveqglqpr4v>
 <B3A1B8A7-0363-4ECB-AFBF-576FECA569FA@goldelico.com>
 <vawv2mwhonuyvgmp7uox4rfgdcjwg5fa7hmbcfgl3wiase6e4p@tyavpclppfvu>
 <6BC60156-89E2-4734-BD00-B49A9A6C1D7A@goldelico.com>
 <6gpehpoz54f5lxhmvirqbfwmq7dpgiroy27cljpvu66wtn7aqy@lgrh7wysyxnp>
 <D8AB6CC4-DCA5-40DD-A311-94A16FF59254@goldelico.com>
 <oobcl2kfsuph27er7rflfqvt3lu6athufomxv5chf3uctx4emh@x6rzjtlskhbf>
 <F58855EC-D87D-4747-A363-0E7AA5DB1AEC@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fqek5qfw3sbzkpso"
Content-Disposition: inline
In-Reply-To: <F58855EC-D87D-4747-A363-0E7AA5DB1AEC@goldelico.com>


--fqek5qfw3sbzkpso
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 10:28:09AM +0100, H. Nikolaus Schaller wrote:
> Hi Maxime,
>=20
> > Am 15.12.2023 um 14:33 schrieb Maxime Ripard <mripard@kernel.org>:
> >=20
> >>>=20
> >>> It's for a separate architecture, with a separate driver, maintained =
out
> >>> of tree by a separate community, with a separate set of requirements =
as
> >>> evidenced by the other thread. And that's all fine in itself, but
> >>> there's very little reason to put these two bindings in the same file.
> >>>=20
> >>> We could also turn this around, why is it important that it's in the
> >>> same file?
> >>=20
> >> Same vendor. And enough similarity in architectures, even a logical se=
quence
> >> of development of versions (SGX =3D Version 5, Rogue =3D Version 6+) b=
ehind.
> >> (SGX and Rogue seem to be just trade names for their architecture deve=
lopment).
> >=20
> > Again, none of that matters for *where* the binding is stored.
>=20
> So what then speaks against extending the existing bindings file as propo=
sed
> here?

I mean, apart from everything you quoted, then sure, nothing speaks
against it.

> >> AFAIK bindings should describe hardware and not communities or drivers
> >> or who is currently maintaining it. The latter can change, the first n=
ot.
> >=20
> > Bindings are supposed to describe hardware indeed. Nothing was ever said
> > about where those bindings are supposed to be located.
> >=20
> > There's hundreds of other YAML bindings describing devices of the same
> > vendors and different devices from the same generation.
>=20
> Usually SoC seem to be split over multiple files by subsystem. Not by ver=
sions
> or generations. If the subsystems are similar enough they share the same =
bindings
> doc instead of having one for each generation duplicating a lot of code.
>=20
> Here is a comparable example that combines multiple vendors and generatio=
ns:
>=20
> Documentation/devicetree/bindings/usb/generic-ehci.yaml

EHCI is a single interface for USB2.0 controllers. It's a standard API,
and is made of a single driver that requires minor modifications to deal
with multiple devices.

We're very far from the same situation here.

> > If anything it'll make it easier for you. I'm really not sure why it is
> > controversial and you're fighting this so hard.
>=20
> Well, you made it controversial by proposing to split what IMHO belongs t=
ogether.

No, reviews aren't controversial. The controversy started when you chose
to oppose it while you could have just rolled with it.

> I feel that the original patch is good enough for its purpose and follows
> some design pattern that can be deduced from other binding docs.

[citation needed]

Maxime

--fqek5qfw3sbzkpso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZYAbgAAKCRDj7w1vZxhR
xS2kAQD1v8t8gOttSKasozzYFKDYkVASRfS4vwMhDEoa3VJGgAD/Sx0WPxcTR+rn
Eh5f073VqTXt6rP/hUjFqzHk27M30w0=
=p2+d
-----END PGP SIGNATURE-----

--fqek5qfw3sbzkpso--


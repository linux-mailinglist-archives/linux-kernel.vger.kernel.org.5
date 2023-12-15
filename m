Return-Path: <linux-kernel+bounces-1021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A31C8814959
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D502F1C23C12
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4BF2DB91;
	Fri, 15 Dec 2023 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJcTttLW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4490B2DB71;
	Fri, 15 Dec 2023 13:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44711C433C7;
	Fri, 15 Dec 2023 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702647194;
	bh=tGUhZ8a1wsbx0GalNAANJzpCwpQC3QW2iHSYADKeSd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJcTttLW46h1AIr8fYhPxXp/T5lrnGXfSuuj1cYQJ8Vp3lwBUMrFQ/RFMGzBVoHRl
	 XQEItc18liqK+qYbS2F+dntRyrr3ZwLueXZTw33eYCOIG7WrKiTs7XBDORhUYF5dn0
	 4dDOSP2CxoXqCAyAN3XJ3X15F7RkwLrcvLY5WObqXn+zvG53DTpV+58W1oUkT3B+mB
	 czKFhXsk4126nHSzSxrRd8yCS3V8JygX/BwifVKxD2D1gbt1LDkU/d8Cg60y9l3qyI
	 p5MRLg3p95hkUVScbzuNXtOur0zq/Qr578Jr3MsvB0ZJqvbRZnlXg0cPVwRHeSQF3v
	 gJ6z1AliF5MIA==
Date: Fri, 15 Dec 2023 14:33:12 +0100
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
Message-ID: <oobcl2kfsuph27er7rflfqvt3lu6athufomxv5chf3uctx4emh@x6rzjtlskhbf>
References: <20231204182245.33683-1-afd@ti.com>
 <20231204182245.33683-2-afd@ti.com>
 <23livt5mcc64bb6lkeec2uxp5cyn4wfekwaj6wzrjnrkndvwgj@6tveqglqpr4v>
 <B3A1B8A7-0363-4ECB-AFBF-576FECA569FA@goldelico.com>
 <vawv2mwhonuyvgmp7uox4rfgdcjwg5fa7hmbcfgl3wiase6e4p@tyavpclppfvu>
 <6BC60156-89E2-4734-BD00-B49A9A6C1D7A@goldelico.com>
 <6gpehpoz54f5lxhmvirqbfwmq7dpgiroy27cljpvu66wtn7aqy@lgrh7wysyxnp>
 <D8AB6CC4-DCA5-40DD-A311-94A16FF59254@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jgmzzpd4kephm2k6"
Content-Disposition: inline
In-Reply-To: <D8AB6CC4-DCA5-40DD-A311-94A16FF59254@goldelico.com>


--jgmzzpd4kephm2k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 11:33:53AM +0100, H. Nikolaus Schaller wrote:
> Hi Maxime,
>=20
> > Am 07.12.2023 um 10:20 schrieb Maxime Ripard <mripard@kernel.org>:
> >=20
> > On Tue, Dec 05, 2023 at 02:50:08PM +0100, H. Nikolaus Schaller wrote:
> >> Hi,
> >>=20
> >>> Am 05.12.2023 um 14:29 schrieb Maxime Ripard <mripard@kernel.org>:
> >>>=20
> >>> Hi,
> >>>=20
> >>> On Tue, Dec 05, 2023 at 09:18:58AM +0100, H. Nikolaus Schaller wrote:
> >>>>> Am 05.12.2023 um 07:57 schrieb Maxime Ripard <mripard@kernel.org>:
> >>>>>=20
> >>>>> On Mon, Dec 04, 2023 at 12:22:36PM -0600, Andrew Davis wrote:
> >>>>>> The Imagination PowerVR Series5 "SGX" GPU is part of several SoCs =
=66rom
> >>>>>> multiple vendors. Describe how the SGX GPU is integrated in these =
SoC,
> >>>>>> including register space and interrupts. Clocks, reset, and power =
domain
> >>>>>> information is SoC specific.
> >>>>>>=20
> >>>>>> Signed-off-by: Andrew Davis <afd@ti.com>
> >>>>>> ---
> >>>>>> .../devicetree/bindings/gpu/img,powervr.yaml  | 69 +++++++++++++++=
++--
> >>>>>> 1 file changed, 63 insertions(+), 6 deletions(-)
> >>>>>=20
> >>>>> I think it would be best to have a separate file for this, img,sgx.=
yaml
> >>>>> maybe?
> >>>>=20
> >>>> Why?
> >>>=20
> >>> Because it's more convenient?
> >>=20
> >> Is it?
> >=20
> > It's for a separate architecture, with a separate driver, maintained out
> > of tree by a separate community, with a separate set of requirements as
> > evidenced by the other thread. And that's all fine in itself, but
> > there's very little reason to put these two bindings in the same file.
> >=20
> > We could also turn this around, why is it important that it's in the
> > same file?
>=20
> Same vendor. And enough similarity in architectures, even a logical seque=
nce
> of development of versions (SGX =3D Version 5, Rogue =3D Version 6+) behi=
nd.
> (SGX and Rogue seem to be just trade names for their architecture develop=
ment).

Again, none of that matters for *where* the binding is stored.

> AFAIK bindings should describe hardware and not communities or drivers
> or who is currently maintaining it. The latter can change, the first not.

Bindings are supposed to describe hardware indeed. Nothing was ever said
about where those bindings are supposed to be located.

There's hundreds of other YAML bindings describing devices of the same
vendors and different devices from the same generation. If anything
it'll make it easier for you. I'm really not sure why it is
controversial and you're fighting this so hard.

Maxime

--jgmzzpd4kephm2k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXxVmAAKCRDj7w1vZxhR
xVw8AP41gJoEr4Iyn/S1Hezu3iKztXGS3daC3u3QCuAGL/pTzwD9HOO3pcwNEL/E
pFq4wYajjL/ypoQuClzjpZ6kW6ckSgs=
=YYGh
-----END PGP SIGNATURE-----

--jgmzzpd4kephm2k6--


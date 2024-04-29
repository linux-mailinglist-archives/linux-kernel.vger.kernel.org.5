Return-Path: <linux-kernel+bounces-162600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597108B5DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869561C21D03
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA288287A;
	Mon, 29 Apr 2024 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="De4NP2yx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC007F487;
	Mon, 29 Apr 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405093; cv=none; b=hkii+Tjosr365tneensqB5NpkjMuQrTa+YFctV0KyU19WTIe+Evm26W73jOLVwTodrQ2BZ5BQMxAv9ruP6j0MaJvXo/YVCIc326hGVahTESnGtdER+KC3vlnFcTqF+9SwYh3kbqtWLXvY0Cl9zouoDUqJjd2PDZN4TVG1GIefXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405093; c=relaxed/simple;
	bh=ly8rcgZd4JErsD1woWLcZbIKhq8mxl/wpftoaI/yZJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7gn9xQA70Uh7W9ndxjQPRdmBoBwp8k+QukowtgRChWCZwvsdnPu0YThYkpGBH7a6nBArgTd29cARc6k9zytPX2Ri6aN7fW1s9i422/jLZKgBXg8t6EiV/U1n2HYHGup5ThVrpXkMSqRS2P/kkfgrEddSQyoH9yq+67rs16izwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=De4NP2yx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A90C4AF14;
	Mon, 29 Apr 2024 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714405093;
	bh=ly8rcgZd4JErsD1woWLcZbIKhq8mxl/wpftoaI/yZJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=De4NP2yxDV3QCA73CgXXmVmBw6RyjAg44x00dghbOwaSiNtjx+n3UifNCYvTcZZzi
	 +SfvjsUQOm6Qbksxs8qHx5gnVMEuOFQHhXfRuoGUW9hdrbtxMlEl3E6+FFuYtijPTG
	 lCB/MO2rssRosHjrqGq85plIlefugvA2nHV25zrABVby7cgaaWPcaqbDk9TvR6lSFo
	 4TVfn7ncaMzk6uc131MC0HANcCcFh1pBVlHmS6lMdz9Fs6nohdCeElUKydCDbDrrZz
	 /sr4SunWBgRR2QpuhOeMfDYsihcgHK6uE2lqoa9M/9z80SF+KnKtLFmVjtRgMOd8sJ
	 a4AzZ8Gyv0vUg==
Date: Tue, 30 Apr 2024 00:38:10 +0900
From: Mark Brown <broonie@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PoE complex usage of regulator API
Message-ID: <Zi--4ko_vAtFSxyn@finisterre.sirena.org.uk>
References: <20240426124253.56fd0933@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+E3lYl72hi9pExTY"
Content-Disposition: inline
In-Reply-To: <20240426124253.56fd0933@kmaincent-XPS-13-7390>
X-Cookie: lisp, v.:


--+E3lYl72hi9pExTY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 12:42:53PM +0200, Kory Maincent wrote:

> Let's begin simple, in PSE world we are more talking about power.
> Would it be ok to add a regulator_get/set_power_limit() and
> regulator_get_power() callback to regulator API. Would regulator API have
> interest to such callbacks?

Why would these be different to the existing support for doing current
limiting?  If the voltage for the supply is known then the power is a
simple function of the current and the voltage.  I suppose you could try
to do a convenience functions for a fixed voltage, but there'd be issues
there if the voltage isn't configured to an exact voltage and might
vary.

> Port priority, more complex subject:
> Indeed a PSE controller managing several ports may be able to turn off po=
rts
> with low priority if the total power consumption exceed a certain level.
> - There are controller like PD692x0 that can managed this on the hardware=
 side.
>   In that case we would have a regulator_get/set_power_limit() callbacks =
=66rom
>   the regulator parent (the PSE contoller) and a regulator_get/set_priory=
()
>   callbacks for the regulator children (PSE ports).

All this priority stuff feels very PSE specific but possibly doable.
You'd have to define the domains in which priorities apply as well as
the priorities themselves.

> - There are controller like TPS23881 or LTC4266 that can set two prioriti=
es
>   levels on their ports and a level change in one of their input pin can
>   shutdown all the low priority ports. In that case the same callbacks co=
uld be
>   used. regulator_get/set_power_limit() from the parent will be only at s=
oftware
>   level. regulator_get/set_priority() will set the priorities of the port=
s on
>   hardware level. A polling function have to read frequently the total po=
wer
>   used and compare it to the power budget, then it has to call something =
like
>   regulator_shutdown_consumer() in case of power overflow. =20

I would expect the regulators can generate notifications when they go
out of regulation?  Having to poll feels very crude for something with
configurable power limits.

> https://lore.kernel.org/netdev/20240417-feature_poe-v9-10-242293fd1900@bo=
otlin.com/
> But in case the port is enabled from Linux then shutdown from the PSE con=
troller
> for any reason, I have to run disable and enable command to enable it aga=
in. Not
> really efficient :/

If that is a hot path something has gone very wrong with the system,
especially if it's such a hot path that the cost of a disable is making
a difference.  Note that hardware may have multiple error handling
strategies, some hardware will turn off outputs when there's a problem
while other implementations will try to provide as good an output as
they can.  Sometimes the strategy will depend on the specific error
condition, and there may be timeouts involved.  This all makes it very
difficult to assume any particular state after an error has occurred, or
that the state configured in the control registers reflects the physical
state of the hardware so you probably want some explicit handling for
any new state you're looking for.

> I am thinking of disabling the usage of counters in case of a
> regulator_get_exclusive(). What do you think? Could it break other usage?

Yes, that seems likely to break other users and in general a sharp edge
for people working with the API.

--+E3lYl72hi9pExTY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYvvuIACgkQJNaLcl1U
h9BgCgf/XuyrLBmNpdApLYYi0hsSfYV4lOxPUrKZvgnLl+FPoP0yx50VrcCsKSml
xNDnTaNsJWRQqYWXA4sjCSUbclzSlEZT9tCtg8cjDDzoRuYoNL5xQzIBMMVsu2Lo
UdmPnbUI/an3UyAfgpSUBwLP+u7kkJZShaJ8Fua+xaeTGG/vYb5G8qRudKx3f/on
lpO/riGAPjOb0xlwSy+VzQEdAATpZy6HscNigBhqitXnBMuqr65WePxrlvnJZU8A
XD1HS+NNA8ppBiKV8Na9nZJPG4JenykcRUVBoHWpIqrql+qChb3hjap9owh9+1Oq
x2SYFA7wlHtQsWtrRi24iqgASLL4Qw==
=vqvN
-----END PGP SIGNATURE-----

--+E3lYl72hi9pExTY--


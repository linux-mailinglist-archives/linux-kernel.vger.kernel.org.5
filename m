Return-Path: <linux-kernel+bounces-8755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7099E81BBD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA081F2715A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C00055E7D;
	Thu, 21 Dec 2023 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYRfrVk+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB855991E;
	Thu, 21 Dec 2023 16:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FABC433C8;
	Thu, 21 Dec 2023 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703175617;
	bh=n7fUGVM+SEvuGWo8qzDk63I/GzAyHgRn8q2TZjjNudM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYRfrVk+hL3FKrbLdQnZxKrkyyeoi2039+1fgKj8SO96zJ6EnlI3M7qqNlaPr8BG8
	 ujSwupaWgPj61b+1HTbM+Fcf442LrUxam6y9JhcFi8T6hINBlPHdAQC8ZI+agHCVZ/
	 S8HZ50QewRYc2MMn7fmgrH4u0HWiyyaZruJXEy6NRJqkMZPj2rQDJaF5S34WOtpFbY
	 ayDG+xoEVZddySlB3Q7GtecMSBMIbVPNDQnJ9bi41o+Jtsb+8zbg1IM+1Xgda4H8k8
	 vmlOLjEaCYBpjbcgwrn2kl8raIhxDzR3RsdO0r89rMyxbsimu3+cI2zrh4TSDrGCYn
	 5febw4BqNSqFw==
Date: Thu, 21 Dec 2023 16:20:10 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <501f671d-4e03-490b-a9d6-e1f39bb99115@sirena.org.uk>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
 <20231204225956.GG981228@pengutronix.de>
 <20231205064527.GJ981228@pengutronix.de>
 <4b96b8c8-7def-46e5-9c85-d9e925fb9251@sirena.org.uk>
 <20231205140203.GK981228@pengutronix.de>
 <88ed0c94-d052-4564-be0c-79a0f502eda8@sirena.org.uk>
 <20231221163610.47038996@kmaincent-XPS-13-7390>
 <ffda1003-b752-402e-8e51-e2e24a840cff@sirena.org.uk>
 <20231221171000.45310167@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3A6hdUUF9ZVYaylR"
Content-Disposition: inline
In-Reply-To: <20231221171000.45310167@kmaincent-XPS-13-7390>
X-Cookie: Results are not typical.


--3A6hdUUF9ZVYaylR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 05:10:00PM +0100, K=F6ry Maincent wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Dec 21, 2023 at 04:36:10PM +0100, K=F6ry Maincent wrote:
> > > Mark Brown <broonie@kernel.org> wrote: =20

> > > > OK...  I mean, if they're not using the regulator framework I'm not=
 sure
> > > > it has much impact - there are plenty of internal regulators in dev=
ices
> > > > already so it wouldn't be *too* unusual other than the fact that AF=
AICT
> > > > this is somewhat split between devices within the subsystem?  Neith=
er of
> > > > the messages was super clear. =20

> > > PSE Power Interface (which is kind of the RJ45 in PSE world) have sim=
ilar
> > > functionalities as regulators. We wondered if registering a regulator=
 for
> > > each PSE PI (RJ45 ports) is a good idea. The point is that the PSE
> > > controller driver will be its own regulator consumer.
> > > I can't find any example in Linux with such a case of a driver being a
> > > provider and a consumer of its own regulator. This idea of a regulator
> > > biting its own tail seems weird to me. Maybe it is better to implemen=
t the
> > > PSE functionalities even if they are like the regulator functionaliti=
es. =20

> > Is it at all plausible that a system (perhaps an embedded one) might use
> > something other than PSE?

> Do you mean to supply power to a RJ45 port?

Whatever it is that PSE does.

> This can be done with a simple regulator. In that case we use the pse_reg=
ulator
> driver which is a regulator consumer.
> I don't know about other cases. Oleksij do you?

In that case it sounds like you need the split to allow people to
substitute in a non-PSE supply, and everything ought to be doing the
consumer thing?

--3A6hdUUF9ZVYaylR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWEZbkACgkQJNaLcl1U
h9Dmsgf/Y+iuaKCT8rB5ZBLmEZC3fsyLePswrWIWi6K7Oup7pNwnrCMIG5DrHYIa
mP3mf9/4tOnsRyZtIpUmwL7LEirZV4iThcWwK8ylYJrWUhgUPhsEpSjllmFRKtBw
uFbCx2owtx7Y7nmn2uM2dJfY9Rk+ERGK9K29dTghqqzJppXYoELrNv70ZlGd0dqb
XztUXnzqG7cOTDxd+t3YESfr2jQnqssnLEmeQAJsBNBj/ANQ0e6JBOuHbX8LxNrl
WZvX8cNYKA5dz/TeeCR6S+KoGzVJ4jayp7Y8xhslAgA7KorBabc9gTA7aTaroMLO
UuvXolekEc4clNfpKWxHtKfhF7gH6Q==
=kWGK
-----END PGP SIGNATURE-----

--3A6hdUUF9ZVYaylR--


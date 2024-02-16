Return-Path: <linux-kernel+bounces-68620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D03E857D50
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA44287A49
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574BA129A67;
	Fri, 16 Feb 2024 13:10:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4B1292FA
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089053; cv=none; b=h2cj6RDdIoMqHoyGYJkmLPBk1ZLJlbdcZIEBIYBkm2Z2B/Go6GdVZVDqd+4SXlkgt6p0XFt8jq+OeIeV3cmeP49noqgG1X8iEXI+23p7m7Wc30hy7DR41LQlBxueCipp3wwD7sPQRFyV/tocg7M+WGV/aOGeEw2tsMb5atgM6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089053; c=relaxed/simple;
	bh=ietoiFvrkaXyNKDmB6+IOLYeD50+XaeHipYC88lYAHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l856SnfG7Ag4KGkQytQgQlKlpHNT8kT5YY/ODJXCKo5qkVQz1kKnBYIFj2c65QPDZf7G6jb050ESVgc99cYN4kkhCw/q3fNjggqD/J2K9tD0aAHg+mEtsSkoUwflriDWkDFsuCodTarEvaHgA1+AV9QbAtN+cQP0NaDVVZIMiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raxzA-00013z-Eo; Fri, 16 Feb 2024 14:10:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raxz9-00151g-Rg; Fri, 16 Feb 2024 14:10:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raxz9-005zdK-2T;
	Fri, 16 Feb 2024 14:10:35 +0100
Date: Fri, 16 Feb 2024 14:10:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: mediatek,mt2712: add compatible
 for MT7988
Message-ID: <45i5wid2fcf3lyucfferraolnxmdwoulz35js7biuhitiy576j@l3pslrkeehvu>
References: <20240213164633.25447-1-zajec5@gmail.com>
 <onnokyq7ciza7i7jzc74cun2khpst5iocuccks2cm433ux3za3@dou4oacrvuxj>
 <2dac95be-b23a-4c42-ac67-241100c7a51b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lrlyeofzr3gig4qw"
Content-Disposition: inline
In-Reply-To: <2dac95be-b23a-4c42-ac67-241100c7a51b@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--lrlyeofzr3gig4qw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 10:05:47AM +0100, Krzysztof Kozlowski wrote:
> On 13/02/2024 18:48, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Rafa=C5=82,
> >=20
> > On Tue, Feb 13, 2024 at 05:46:32PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> >> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >>
> >> MT7988 has on-SoC controller that can control up to 8 PWMs.
> >>
> >> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >=20
> > please make sure that the email address used for sending the patch
> > matches the Signed-off-by line.
> >=20
> > (It depends on the pickyness of the relevant maintainer if that is a
> > stopper or not.)
>=20
> Does not have to... It must match From field which is correct here.

Rafa=C5=82's Signed-off matches the author, but not the sender. Together wi=
th
"the Signed-off-by: must always be that of the developer submitting the
patch." (from Documentation/process/submitting-patches.rst) I'd say it's
reasonable to request that there is a sign-off with the email matching
the sender. In my understanding the Sign-off line by the author isn't
really required because the sender can vouch for the author. Of course
this is a somewhat artificial discussion if the sender is the same
person as the author and only the email addresses differ. So this about
the strictness of the applying maintainer.

FTR:

	$  curl -s https://lore.kernel.org/linux-pwm/20240213164633.25447-1-zajec5=
@gmail.com/raw | grep -E '^(From|Signed-off-by):'
	From: =3D?UTF-8?q?Rafa=3DC5=3D82=3D20Mi=3DC5=3D82ecki?=3D <zajec5@gmail.co=
m>
	From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
	Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

the first From: is the sender, the second the author.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lrlyeofzr3gig4qw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXPXsoACgkQj4D7WH0S
/k5n6gf/bwjc8ajUTwW3zBdQjV2Uv2vtl5UgwtnUgkacqy/DYxOQytC2hJ59AZ1e
ZcR/Z00k1RIXoftOmHBcLsH1hOoZ0t6dc9N4MrAH+sL3HbsM9tl0QKvdtqsYA8UB
qcrGwKx3vkq2PNhARGXmJv8D6KVju2QzrM33wlw75BWXVzw6SN1lDg5r3D5oXoOh
OkVw5lmiKU98GoG+tC6Kr14ZNV5Ff5HIx62omGYNw4U927UsGIhIXyGsMw2VUa9t
iTKmrv1+QWMXqgPdchoHsABDnnNCNJjmU+DvjBvx3zAetjt/Tvzl4cLJIc0jZ9WX
2T+98AdX4mDu2RUmraghTQB+4kegEg==
=54H0
-----END PGP SIGNATURE-----

--lrlyeofzr3gig4qw--


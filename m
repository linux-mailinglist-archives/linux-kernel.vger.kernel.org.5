Return-Path: <linux-kernel+bounces-95918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3268754F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971A5287BDA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3B8130AD7;
	Thu,  7 Mar 2024 17:12:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1612FF90
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831571; cv=none; b=itLCGuvwRjt67scmLx8/DfpMo0P0yYaZ/iXVqEFIcSlVxa4kK6U+O3NxE8+DR3j5gCrQxuqivvwx0ijQEvcm0PDklyVnxbVlj1/wjTWcRVzDuE6QcI18AcaCQF6T7LFs8yTcIJtwttRe4t9SwprObG+1Ed3vE3kq/bJn2gDfi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831571; c=relaxed/simple;
	bh=HZwu3odDFJCXISE5Vlkb1gNaI2s3H9r6EYrir93M3K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSRmVsRuduuhGFA/cH+hF88mtiRJgq2bYc3tVz7vtgkEKbp1qMNWglGxn77lLfAlwjaaslAqkk15TQophl9rzNprLYh4gm/7k4g8cK6weIkope5IhVlPe5Q2665+WKRuu61cnkF4ugNqovgRVRKrZJqIjvq1EDRtZTfCjwCBR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riHIV-0002Dk-Jx; Thu, 07 Mar 2024 18:12:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riHIU-004z5h-NB; Thu, 07 Mar 2024 18:12:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riHIU-001QKW-22;
	Thu, 07 Mar 2024 18:12:46 +0100
Date: Thu, 7 Mar 2024 18:12:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v1 0/5] w1: gpio: A set of cleanups
Message-ID: <46qzdowo2om2bbuokiksah27x4qok7hffiefwsj4bihz2xg62y@hxrag6h55zw7>
References: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
 <vsaqquulifmpk5fanl4i67nzag5huyibzy5lfr2jdsgk2dv7t3@5i4opts7npsj>
 <ZenuzMtybS4CzwHv@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6mi2ljkqtnwwl5vh"
Content-Disposition: inline
In-Reply-To: <ZenuzMtybS4CzwHv@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--6mi2ljkqtnwwl5vh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Thu, Mar 07, 2024 at 06:43:56PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 07, 2024 at 05:38:54PM +0100, Uwe Kleine-K=F6nig wrote:
> > I wonder about your choice of recipients. I would have added Krzysztof
> > to To and me at most to Cc:.
>=20
> It's automatically generated using get_maintainers.pl.
> See details in the source of the script [1] I'm using.
>=20
> [1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintaine=
r.sh

Getting something wrong automatically isn't an excuse for getting it
wrong :-)

That scripts has:

to=3D$(git show -$count "$COMMIT" | scripts/get_maintainer.pl $OPTS --no-m =
--no-r)
cc=3D$(git show -$count "$COMMIT" | scripts/get_maintainer.pl $OPTS --no-l)

I recommend to swap the values for to and cc here to make sure you have
the maintainer in $to and the relevant lists in $cc.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6mi2ljkqtnwwl5vh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXp9Y0ACgkQj4D7WH0S
/k6iHwf9GjQeQPB95z8r2cIM9D6umAza34pwVVHvwDwFhigRf5wWW5NHep00VHP6
TBEoWTMCQKC2DV2bNXjs6WNU23YPcqL3V1LZcBsp//o23uKYMJbdtHO7ImdUvXrz
G9VUEbanqB5zD/rb7vP8tC5wyNFttsPY4bbCNzTOo3TghdUsM/aqdxfHdPiUARXr
b+8aqZCBgi9W524YE8iUpkopZp1UZNHXqucD6quS6FPbwQwPeE2lS9TId5wnDv76
x9nmsDFJsfFlrhzSUJ8RXdkdOUm6h9I14p7bSgb6mJGR7FXxFUwrVHeT0/em+E0E
ehw9bty5LKWgAfJZw97k9EbEqII13Q==
=ecsR
-----END PGP SIGNATURE-----

--6mi2ljkqtnwwl5vh--


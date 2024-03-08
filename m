Return-Path: <linux-kernel+bounces-96611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76933875EE8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A9828300E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA89A5027B;
	Fri,  8 Mar 2024 07:56:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF44F61C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884588; cv=none; b=YMWhsD89WfT01cDkQoOv/5FIN0MsxQtW2AhAcH+87SySjnrffg3F29aGLQfetjRV4pN/ZUHnMFXTas8xjBHdsQXAR9gFl6iO+PD+ccNTnEJyp/6pxAk6PGdbRIg0Y1rqyV0jrRo+LtajViJq51MwndmO/bNxKnAtNQdli03chq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884588; c=relaxed/simple;
	bh=2+BbuL8rUlPJeNCPQtLsGDwZHHZX44F9NZJvGA4Digk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoGVT6ZmvO/Upd9rl/OK4/qrRlVaoAylf2nanL9bKIoFoE8f5Ebi7j0iz4+AEKOjMM3mSZQequbSiTRocpwkSDOSbaWs/LNkd9SIm5bByy5UgbJyhIjbd8CGczAVMFXpg9JOtEo4o36dm4tBAQ7ivpVOpAIH5akJF5PbYvJTkp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riV5Z-00040m-MZ; Fri, 08 Mar 2024 08:56:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riV5Y-0055tI-L2; Fri, 08 Mar 2024 08:56:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riV5Y-0021Vz-1p;
	Fri, 08 Mar 2024 08:56:20 +0100
Date: Fri, 8 Mar 2024 08:56:20 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v1 0/5] w1: gpio: A set of cleanups
Message-ID: <spc5otfv7s2wtunhbxdorm5bh5snvfbggoaqghowrxm2osbeoz@b2dsqa3amvtg>
References: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
 <vsaqquulifmpk5fanl4i67nzag5huyibzy5lfr2jdsgk2dv7t3@5i4opts7npsj>
 <ZenuzMtybS4CzwHv@smile.fi.intel.com>
 <46qzdowo2om2bbuokiksah27x4qok7hffiefwsj4bihz2xg62y@hxrag6h55zw7>
 <Zen_7fDQghq6GJ_s@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="djpsrzmcypk6c5jq"
Content-Disposition: inline
In-Reply-To: <Zen_7fDQghq6GJ_s@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--djpsrzmcypk6c5jq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Thu, Mar 07, 2024 at 07:57:01PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 07, 2024 at 06:12:46PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Thu, Mar 07, 2024 at 06:43:56PM +0200, Andy Shevchenko wrote:
> > > On Thu, Mar 07, 2024 at 05:38:54PM +0100, Uwe Kleine-K=F6nig wrote:
>=20
> ...
>=20
> > > > I wonder about your choice of recipients. I would have added Krzysz=
tof
> > > > to To and me at most to Cc:.
> > >=20
> > > It's automatically generated using get_maintainers.pl.
> > > See details in the source of the script [1] I'm using.
> > >=20
> > > [1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maint=
ainer.sh
> >=20
> > Getting something wrong automatically isn't an excuse for getting it
> > wrong :-)
>=20
> I'm not sure why you think it's wrong. You worked on the code lately and =
Git
> heuristics considered that over threshold of 67%.

When I send a patch I send it "to" the maintainers, because it's them
who I want an action from. This also matches the semantic of M: in
MAINTAINERS which requests to use these contaces in "To:".

> > That scripts has:
> >=20
> > to=3D$(git show -$count "$COMMIT" | scripts/get_maintainer.pl $OPTS --n=
o-m --no-r)
> > cc=3D$(git show -$count "$COMMIT" | scripts/get_maintainer.pl $OPTS --n=
o-l)
> >=20
> > I recommend to swap the values for to and cc here to make sure you have
> > the maintainer in $to and the relevant lists in $cc.

Thinking again, this is wrong. I'd recommend:

	to=3D$(git show -$count "$COMMIT" | scripts/get_maintainer.pl $OPTS --no-r=
 --no-l)
	cc=3D$(git show -$count "$COMMIT" | scripts/get_maintainer.pl $OPTS --no-m)

> Btw, you are the first one for the entire life cycle of that script (3 ye=
ars?)
> who complains about such details... So, patches are welcome! :-)

I won't do more than the above hint here.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--djpsrzmcypk6c5jq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXqxKMACgkQj4D7WH0S
/k74SggAsufoZoLLydlPozRRoUjVIvHER/jsy1iw/q11jz+zCHg3t7LfeMLXO9UJ
CYJcjY8MFO01BldAV0qEhOa9SLZmjpDmUmryAgnAkw390rpeEgWYbVMbcdmUBZXZ
2FZ3vi9JMKcqvNsb+rxeYJONixMvUg22nBcPZbzkrfpJlqfJZQH+Dt+mJwbXQbHh
FOUhmWxVLkJQJYwjrEoN1NNe6IRYQO0hGT6pof53a9v8NbRILtRLovGQ+U+fT1BX
MdsYl2vZHRfYn5EC8+5dVGgfZrL/VtVaOT/gz0jXDQlgSpW+wLZCUaB4j/JA3WH/
kqeA3tCln6zzKZnyMK3rVuu0EclBIg==
=s+ms
-----END PGP SIGNATURE-----

--djpsrzmcypk6c5jq--


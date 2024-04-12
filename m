Return-Path: <linux-kernel+bounces-142642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEA38A2E62
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0389828610D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9467D5674B;
	Fri, 12 Apr 2024 12:26:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDFD56444
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924813; cv=none; b=REDmCZ2j+3X48prAqrNjB3s5ItqGhv0dqjwh0xxu1zW2xQd4Oi/CHrv+sNBb0vZnSS8k+yuuRpwkFSznOZPYYyF9I9vaFSd4gWxo5nqnvMFtXQAv5iTgeuBd7f3YGI0lJQKnk+Tv95qTdRdD7KIIkumu2N1VWk28xxlX9ilbJdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924813; c=relaxed/simple;
	bh=tzP3amZEpajs2WOU6zX0VAE0WXMtT389H19L21TY/ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWAsvSJcrWJ5tqB3It0IVmnUF8Li5ILnX2LIj4e8sSfo4JafjntLX3dIVgggn0/V//0GiJu8+OEmnygwr8YnwotXZusybJBZdui96B+T3DBShBKg1D6oInXSs9V3sptvep07k/I6rjSD9tCXpU1jNW2axjR7dzk1OMk3Kmksh10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvFzV-00062F-LM; Fri, 12 Apr 2024 14:26:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvFzV-00BsD2-5A; Fri, 12 Apr 2024 14:26:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvFzV-000ANV-0E;
	Fri, 12 Apr 2024 14:26:49 +0200
Date: Fri, 12 Apr 2024 14:26:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	linuxpps@ml.enneenne.com
Subject: Re: [PATCH] pps: clients: gpio: Convert to platform remove callback
 returning void
Message-ID: <4iii7uxyfovs6ntm7hs2w546k3upbhkepgzxarjk4wnlqmeern@sh6gkyuiqpjs>
References: <f4b9402af72e5f285c8b0f068076a76418f653f5.1709886922.git.u.kleine-koenig@pengutronix.de>
 <6d73b0a4-34e6-44ce-8757-4f4931c3da85@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6gvlmrxnnidgo4ab"
Content-Disposition: inline
In-Reply-To: <6d73b0a4-34e6-44ce-8757-4f4931c3da85@enneenne.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--6gvlmrxnnidgo4ab
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Cc: +=3D linuxpps@ml.enneenne.com]

On Fri, Mar 08, 2024 at 09:57:29AM +0100, Rodolfo Giometti wrote:
> On 08/03/24 09:51, Uwe Kleine-K=F6nig wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is ignored (apart
> > from emitting a warning) and this typically results in resource leaks.
> >=20
> > To improve here there is a quest to make the remove callback return
> > void. In the first step of this quest all drivers are converted to
> > .remove_new(), which already returns void. Eventually after all drivers
> > are converted, .remove_new() will be renamed to .remove().
> >=20
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>

The MAINTAINERS entry for drivers/pps lists you as single maintainer.
Who is expected to pick up this patch given that you "only" send an ack
but didn't pick up the patch? (Or only picked it up in a tree not
included in next.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6gvlmrxnnidgo4ab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYZKIgACgkQj4D7WH0S
/k5IEwf/Q840SKxdW46c7jlpWLRe6JFxdoOz1zEv78UGoww+c6dPbdy4atrzx7gJ
J+7Tvevw52MlzKw9D9sW49RXn5nKHtXOStgJejdomTkLhVWX7O6ci3vq6JwuSStv
qsFe7/X325gDtP6yxPQGBO3UvjfEIHSPSWgHJPzAbVxjb+V2v6Ddb9Q2iBlpo1PZ
x7J2p+F8zLHYLw+KP3j99IdVABZS+9DOftASjIVZfg58YzEb3sgImZA0Ukgm+Hgo
ehExojDWdglDdmH7uIlaMzqK66ePa6XyYMjA+qm2+c2+IXF2C6/Z8pTzx0fosOyk
VU2UVP8EJ/VhfezTto04mqcgrtS5XA==
=VMef
-----END PGP SIGNATURE-----

--6gvlmrxnnidgo4ab--


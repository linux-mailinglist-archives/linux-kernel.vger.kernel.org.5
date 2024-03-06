Return-Path: <linux-kernel+bounces-94602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E4874202
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD8D1C2164C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5A51B5BF;
	Wed,  6 Mar 2024 21:33:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB48D1AADA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760796; cv=none; b=fN/exDxJUmnYDVKf5q8j1fP72ZqAytYtgEhiKAAIcca7tyFXWIg8PY+2nrQsFmuno1t5l0K90A+ltDlALdSHJMkLy7va2LfH/seGkbbOMazSZOWQqDlkgULnV2Ahtbb46fze97L6RxV+LMuWjWcw6ybeMI/WLLwuDL8ee9I4Fh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760796; c=relaxed/simple;
	bh=zB/4z/x2XKNW2JybP9Xy2g8+MGPxsQ8gqyCLV3EO/Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/f8DaSXJC0Sm+EzXgNBMnAXPT3TDMz6E2Z1/PlCdyOJVoybXLsbjbpXG0lVzICm2MlMKxrNgg6qNF3f/wmkFL5ZoH1hm7OZJdsBpq9d+/46pBLl5p4jeXGa4Kv8l1hGyFlt/Jrr1kUr1TvzoOKhypVfIHFk7YmxrngueIXY5Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhyst-0006SR-7s; Wed, 06 Mar 2024 22:33:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhyss-004ouw-9W; Wed, 06 Mar 2024 22:33:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhyss-000t66-0g;
	Wed, 06 Mar 2024 22:33:06 +0100
Date: Wed, 6 Mar 2024 22:33:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: kirkwood: Convert to platform remove callback
 returning void
Message-ID: <h2sjdrgs7hwmbucr3rxlpusnkpj5tgq2fx27gijtrglr5ffhs6@s63cp4isu4mx>
References: <20230712094014.41787-1-frank.li@vivo.com>
 <20231204115517.zxjgi6ateobjj52d@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aobpo24yxtew6zdt"
Content-Disposition: inline
In-Reply-To: <20231204115517.zxjgi6ateobjj52d@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--aobpo24yxtew6zdt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rafael, hello Daniel,

On Mon, Dec 04, 2023 at 12:55:17PM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Jul 12, 2023 at 05:40:13PM +0800, Yangtao Li wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is (mostly) ignored
> > and this typically results in resource leaks. To improve here there is a
> > quest to make the remove callback return void. In the first step of this
> > quest all drivers are converted to .remove_new() which already returns
> > void.
> >=20
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
> >=20
> > Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
>=20
> Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Can you pick this up?

This patch isn't in next yet. Is this still on someone's radar for
application? Would be great if this patch made it into the mainline
during the upcomming merge window.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--aobpo24yxtew6zdt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXo4REACgkQj4D7WH0S
/k62aQf8DUtqxc5xcDdA1xe6wBwVnuEiYFf9lf8qwNUoBlOCE1hR57BLXVYZI3Cm
DK1IIcg0qZ5+QvAqSn9L7jxPPrKnOQlh8UsToPpyuTCHQ6be5NVxO7aBEajJrwfL
0ahGrTRn7OdgFOLGqJzbuH+aOUUmxfqBnEF9HXm0lzmPKZDubOZGvOb3iHJ5Td9z
Y6h83Y885gY0XKk2H+YHeDzr2vgUmnkEE5M3lxR4lYuRGb7jjei8qy2Jf9NtbGY4
aA4vJmrzVAGASho7N+ZMj2dyqMXTCV426F7c/qWUGmndwhwErhsrLen64mEmibnH
SYxRz9mJ+aVW93brufO7Z0orYdhi5g==
=AEYf
-----END PGP SIGNATURE-----

--aobpo24yxtew6zdt--


Return-Path: <linux-kernel+bounces-161850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6773E8B522A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 910C1B21B97
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A642713FEA;
	Mon, 29 Apr 2024 07:18:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C48B28370
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375139; cv=none; b=aUspRf3LdDkUOcHMUpQgSdZvoPmW1SDerwXHLtcSVDvqEWZTwE+Ox69d7ip5dPvie2LZgiUPirkBzv7ny0Yt4MOF6SLDqUGBrCEvcHg+06IC9K7X4UKG9Qj5m2CsRAodVXJT6ejuStX1MrRapA84felAB1SSO5xNwDB2JKpB7NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375139; c=relaxed/simple;
	bh=XIi5agCWZan+5qkhUPfBdkSE85IbJXDVkWQj19yQfo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYj2nwEZrvTwbjdMyYTXkgrzXR4guMezoDJV4+ocOjeqMc1mQtAMYpBP3DIdtXJm9jz73RuX95hl33pvdnInF+Chuozd+x7MCtoDYPWHZELNbYCdGWJXOJTEYM42WZUjuumOjTESxpTVl/c+41b1iVgkuMMGRiFWqBxGsKM/eMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1LHm-0004D0-Kv; Mon, 29 Apr 2024 09:18:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1LHl-00Ew78-L9; Mon, 29 Apr 2024 09:18:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1LHl-00BDt1-1q;
	Mon, 29 Apr 2024 09:18:49 +0200
Date: Mon, 29 Apr 2024 09:18:49 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: kirkwood: Convert to platform remove callback
 returning void
Message-ID: <qwusw4lmmv7iff64l3qcdnnw762xlwag745dw5vhtfxspvsw2r@73ocsqlyhp5e>
References: <20230712094014.41787-1-frank.li@vivo.com>
 <20231204115517.zxjgi6ateobjj52d@pengutronix.de>
 <h2sjdrgs7hwmbucr3rxlpusnkpj5tgq2fx27gijtrglr5ffhs6@s63cp4isu4mx>
 <fgmvwuzy34cruggah2z7fau4nnfzopuylsgjs6zzdypp26boya@ekrj5myjef5f>
 <8fd3faf9-0179-425e-a68e-d0dc0a2d7da9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k54j2yns3bvhkxf4"
Content-Disposition: inline
In-Reply-To: <8fd3faf9-0179-425e-a68e-d0dc0a2d7da9@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--k54j2yns3bvhkxf4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Daniel,

On Tue, Apr 23, 2024 at 09:22:23AM +0200, Daniel Lezcano wrote:
> On 09/04/2024 18:32, Uwe Kleine-K=F6nig wrote:
> > On Wed, Mar 06, 2024 at 10:33:06PM +0100, Uwe Kleine-K=F6nig wrote:
> > > On Mon, Dec 04, 2023 at 12:55:17PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > On Wed, Jul 12, 2023 at 05:40:13PM +0800, Yangtao Li wrote:
> > > > > The .remove() callback for a platform driver returns an int which=
 makes
> > > > > many driver authors wrongly assume it's possible to do error hand=
ling by
> > > > > returning an error code. However the value returned is (mostly) i=
gnored
> > > > > and this typically results in resource leaks. To improve here the=
re is a
> > > > > quest to make the remove callback return void. In the first step =
of this
> > > > > quest all drivers are converted to .remove_new() which already re=
turns
> > > > > void.
> > > > >=20
> > > > > Trivially convert this driver from always returning zero in the r=
emove
> > > > > callback to the void returning variant.
> > > > >=20
> > > > > Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > >=20
> > > > Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > >=20
> > > > Can you pick this up?
> > >=20
> > > This patch isn't in next yet. Is this still on someone's radar for
> > > application? Would be great if this patch made it into the mainline
> > > during the upcomming merge window.
> >=20
> > It didn't made it into the merge window leading to 6.9-rc1. What are
> > the chances to get it into v6.10-rc1?
> >=20
> > I just checked, the patch was submitted when Linus's tree was just after
> > v6.5-rc1. So it already missed four merge windows without any maintainer
> > feedback :-\
>=20
> Sorry, it is applied now.

Is it expected that this patch didn't appear in next yet now that you
applied it?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--k54j2yns3bvhkxf4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYvSdgACgkQj4D7WH0S
/k6wZwf/ROJx+4F3jGbsl82pC70qDPklU+HM79ozyDgg8SB0xqzRu0/1nP8qwsCc
rekrYN4Gh/hQDK0PAzK2Fpr4OSfuAY1uJbl7QKE8XZrsQ+vcoBhNUT0a9A2qt3yP
OlNlJsebt2UReIzpJcmk3kV/o0skt7pNV+owEry3DNAu7ayDUDkyUTUbhPdSupvx
F4aUn/o5FnM51EeTIMnr7OjVE5Usjrh9X8kBgfZc0/QbBZc98UrSZWL6hvML+RBH
ucHgkQiN/B44PlqJM7ItZY4vxln/yT9f187d9ZhUX0AIYiBqY8Cl45nAwdsxuqMB
v7UESjOmBXS8/CNAeG3SFMKRt6RMxw==
=Q8H+
-----END PGP SIGNATURE-----

--k54j2yns3bvhkxf4--


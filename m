Return-Path: <linux-kernel+bounces-91367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DEF871029
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30D81C21371
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5153B7BAF0;
	Mon,  4 Mar 2024 22:36:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C9929CFE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591796; cv=none; b=KazsX/Ns1CwG9gP95W6TouTlX0CKMzr+/sFbIAvZaFxT8StmHqKAtxR2juirp2Y6ZTkx7cS23AoJsDDPrtWQ2qwvQi/UpGkgkiCzb8U/DHS/4r7AQ24l9KHUfWS7nOcgVhz91mZQNQADvRGdMsWOr0rbwtv4KVv8viS7KSA6Q4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591796; c=relaxed/simple;
	bh=5Q5aIComlWuNtnytT+SXnLlXQgTK0lIa/+09DRNUE04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmOi+B+I1lr/IPem+Qg8E8BGi3llS9mwlRV4m7wnLoLK8tHZ8ZlQFx0NJEsBiWN+uNgeekdzD3wUQ3N9goNo3FqS5aoOKFmKiEJQOfoMtoNP0jNhrDI4ppyEjjtB560je+g/bO8dOijZrkycr9VFoMswZVOjNuFPeB1gDkm1ecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGv4-0008Vk-S2; Mon, 04 Mar 2024 23:36:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGv1-004RE3-Kf; Mon, 04 Mar 2024 23:36:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGv1-00H7Yf-1g;
	Mon, 04 Mar 2024 23:36:23 +0100
Date: Mon, 4 Mar 2024 23:36:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	"derek.kiernan@amd.com" <derek.kiernan@amd.com>, Kees Cook <keescook@chromium.org>, linux-arm-msm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, John Stultz <jstultz@google.com>, 
	Michal Simek <michal.simek@amd.com>, "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Justin Stitt <justinstitt@google.com>, 
	Frederic Barrat <fbarrat@linux.ibm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Tomas Winkler <tomas.winkler@intel.com>, Amol Maheshwari <amahesh@qti.qualcomm.com>, 
	Jiri Slaby <jirislaby@kernel.org>, 
	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>, linux-arm-kernel@lists.infradead.org, 
	Andrew Donnellan <ajd@linux.ibm.com>
Subject: Re: [PATCH 00/11] misc: Convert to platform remove callback
 returning void
Message-ID: <p2rqzrmgfaqdcwj2hlgt7u2yrgfrf4dwizecicdpdmb3jezoky@zmkxw5vt7qyi>
References: <cover.1708508896.git.u.kleine-koenig@pengutronix.de>
 <d6c4ff9e-756a-4604-993a-cf14cfdbc53c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rqw7vqzv73lfjvx5"
Content-Disposition: inline
In-Reply-To: <d6c4ff9e-756a-4604-993a-cf14cfdbc53c@app.fastmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--rqw7vqzv73lfjvx5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Arnd, hello Greg,

On Wed, Feb 21, 2024 at 02:52:29PM +0100, Arnd Bergmann wrote:
> On Wed, Feb 21, 2024, at 10:53, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >
> > this series converts all drivers below drivers/misc to struct
> > platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
> > Provide a remove callback that returns no value") for an extended
> > explanation and the eventual goal.
> >
> > All conversations are trivial, because their .remove() callbacks
> > returned zero unconditionally.
> >
> > There are no interdependencies between these patches, so they could be
> > picked up individually. But I'd hope that Greg or Arnd picks them up all
> > together.
>=20
> These all look good to me, whole series
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.

You (=3D Arnd and Greg) are the listed maintainers for drivers/misc/. How
is this series supposed to be merged? Would a pull request help?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rqw7vqzv73lfjvx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXmTOYACgkQj4D7WH0S
/k7/bggAtLWuAbB65yreKqC3+3BQAW+yYHVR0gr5eF3xYgOQz1633vz0SPYZjaUe
v9bbou74JW3Qsav38qI+/Onjrk60Iov624KdbHUheuPaTwFsKne/+S+rFqZfAQpg
lrpDDpdBAZPeBWeqBUcy57wThrjH78HuAJyvSqldI4nxv0rjT1vYNlwChQ4IGsv9
Bu9oZAPJswmwB418yGlGb1SuyPgnbf78KkqHOy7GPwApOavIhjEqU+r5VZFEk/B5
RZ9smtJ/Rn+DrRUCV1rc0QUCLDkuT/bFFUaPwTI+2kY6NYA6CA7Nk361GfqSLvjx
Q/WnE2MMUAqxDf/RZIZulv6Jkz+u/A==
=hJf2
-----END PGP SIGNATURE-----

--rqw7vqzv73lfjvx5--


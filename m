Return-Path: <linux-kernel+bounces-57571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AFD84DADB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B4F1F214CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F6F69D35;
	Thu,  8 Feb 2024 07:47:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF566930E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378424; cv=none; b=pregPYjQAJwWJs24Ge0JWVEoq02xlJ7nAdNjT9jq34tMXOohiKon4UiIhR2C+nqSgT+ncc9GZhZFQ+cWFMNmh0jQajmLQ0GhMmvBG6LpwP0wDiHzX6e/nljxNmNnDOIEmdpknk4XBz2tWD6tois2Ooa94m8T8nK8Z6u0HzT9BgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378424; c=relaxed/simple;
	bh=jypAfUbIvbUyT0Wu4Q94MHamlS5MN7DK7z7R5vymIIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWHL8dnGbu6KHU4uO8p9BsHoulLYgMGX5i8jINJt/GAS/DDt9FoDXlkfopE7G0gtmx1A3TPw+sUVnmMkJ2GqBe+fcuYtnzS/T22Jenu5W5F2pqzUpNdrLRzfCic3o2sgS5ESrIZydVErQO5i92d+FM3JEiVWoyhlECClc8qAM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXz7O-0007qt-7f; Thu, 08 Feb 2024 08:46:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXz7M-005Aii-S1; Thu, 08 Feb 2024 08:46:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXz7M-000CVE-2W;
	Thu, 08 Feb 2024 08:46:44 +0100
Date: Thu, 8 Feb 2024 08:46:44 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: andriy.shevchenko@linux.intel.com, Raag Jadav <raag.jadav@intel.com>
Cc: jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, 
	lakshmi.sowjanya.d@intel.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] pwm: dwc: drop redundant error check
Message-ID: <qrwcje4t2pbbxilnlfz2q7njodcp6vl54uaypdbvjgvwhgvc5g@4eq5wvumpjjx>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-2-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xlh5lne2t7smrnyn"
Content-Disposition: inline
In-Reply-To: <20240208070529.28562-2-raag.jadav@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--xlh5lne2t7smrnyn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 12:35:25PM +0530, Raag Jadav wrote:
> pcim_iomap_table() fails only if pcim_iomap_regions() fails. No need to
> check for failure if the latter is already successful.

Is this really true? pcim_iomap_table() calls devres_alloc_node() which
might fail if the allocation fails. (Yes, I know
https://lwn.net/Articles/627419/, but the rule is still to check for
errors, right?)

What am I missing?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xlh5lne2t7smrnyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXEhuMACgkQj4D7WH0S
/k5Olwf/dwZIJw628t/aGAEw0FtU/HzoSUJ1BaFp000aDowWve+BF2cPDzakhFi4
BdLaB0m7H5BPs0FpeUv9mTaVEdCiXsQaOE2yPQTmbeiy5/cqMVftPkUfJvSx4oRM
uNAeg8VdiNC+7GrjJ9A9rcZwRbF9yoO8rjJ+1fH7M4q7IAfxWgKu2LcjhjFGRuAs
B4XRgoLdDBYpVtHX4IMFX3NVrk2nAFYMQmNd4mvjxteC7i3CRB9N8HDiFXzFTISl
1h7olr5Vq0sNB97QfZX100PeaJcdZo2o89NR/RMd3XWiL/fDPAnneWTgXduP3mxk
mbTudFFjPoRxG5POPxqzQYWo+yORiw==
=XhB1
-----END PGP SIGNATURE-----

--xlh5lne2t7smrnyn--


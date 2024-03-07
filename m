Return-Path: <linux-kernel+bounces-95870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CE9875456
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D638B22232
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B117F12FB12;
	Thu,  7 Mar 2024 16:41:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75710161
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829677; cv=none; b=PC617IOIKaVD/GEFzPOK3h/Zlf9q5Xwyl5JHMakehOrFQ+qUPXg62o6E9IMzzElZk7vMOdb158HCDdlg4VcXx7k9z4KxKpldtiPPTjQ0S9mnyGHtkf1XmlVNm3Wbaf137a7P6neM0d/kSeiuw5ymSeM1bs48rL3uv2CwKlemXb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829677; c=relaxed/simple;
	bh=KJfGUeu8WSVmtAjSDxmKWUj00+fVxnsdGA6iBjhRcDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAFnFA1Fx7PKyWpQuaTRuzPSkBwc592qgScEp7p35c2e1DaDLTGtQzLnuCgkzOxmGEUtPRwNqWoC9OcK7jGwPSUDQGyehv9WqTLdI3h55w/Pn3d9/gx+hPRtjwNLgK0We0Uy3XX5oHlmt7T5rXLa0cISs+MfC8sJ5nkwFfxB2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riGnx-00051x-Pp; Thu, 07 Mar 2024 17:41:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riGnx-004ygt-30; Thu, 07 Mar 2024 17:41:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riGnx-001OqA-03;
	Thu, 07 Mar 2024 17:41:13 +0100
Date: Thu, 7 Mar 2024 17:41:12 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v1 3/5] w1: gpio: Use sizeof(*pointer) instead of
 sizeof(type)
Message-ID: <klhbrxk6p4za4e5g34pg5kpeksk4ieuhcmhltj4yqoj4wllvgs@ojooclwpee3o>
References: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
 <20240307143644.3787260-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hwg4ejk7f5ofglm7"
Content-Disposition: inline
In-Reply-To: <20240307143644.3787260-4-andriy.shevchenko@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--hwg4ejk7f5ofglm7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 04:35:49PM +0200, Andy Shevchenko wrote:
> It is preferred to use sizeof(*pointer) instead of sizeof(type).
> The type of the variable can change and one needs not change
> the former (unlike the latter). No functional change intended.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hwg4ejk7f5ofglm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXp7igACgkQj4D7WH0S
/k5JQQgAs3KzqPEG1oYLq1UJmlW241JC8dE50T0x93Lcqzdquxo3OmWJj1gBxIuE
DL+xydHh5eiXSXyyZFeXSQtvUlBFUKPJ59cmvv9lpH3GCGeo0vUbYX7Dvfc9+zUl
90mEWb+TYl6WsOrV8bFKepeba+6mgPZ8lJ0MuDUsDAz5oYv3FzNy1SpuuNGgjeye
7nLV/02gCvhvb6kaw7wG8SVZ68v4HJj9VRPRuw4n4k1u1Ug/fqSoaiYi1QiYBpl0
U/dvqbPG1Ywp/Bd42YM/zHARrS8wbQn0u0y5TpjjeiyFbkxhMW0PEHmj1QEoygDx
dHhovs8eJscS1Q8ES0E8URfCqeFspw==
=RBJA
-----END PGP SIGNATURE-----

--hwg4ejk7f5ofglm7--


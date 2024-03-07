Return-Path: <linux-kernel+bounces-95868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A47AA875453
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34F51B24035
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD2083CAD;
	Thu,  7 Mar 2024 16:39:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F68C12DDA2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829540; cv=none; b=Nl7jlfXj04q5W3sSz0X2IMQwh3ROKBo7OzOEbczLCON0h7/wQNERjrDRS5JOW7rviBuQk6+tKCAMrL1pitTQgUr+U25nV0It9Cq0g81poCL5ylZO1iXXSdyatLQStCIA3z+8MaJpsnJm9ZXa8UH47K50iQWM5KPCuGXRL7zPo6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829540; c=relaxed/simple;
	bh=4ZK91/cv9NgrfLTaPgcBThp82ZsuZfWIlc6tv+68bPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fh4eSUfTa2eyULo7DEuYgRxglFhZXOTK7AQvfYVl/wZlZrp5yNiGueuHq4V9p/UOu7+g4A1CjtNcj0LT//RnBLMZRhVAJhzXhupvzgqRYusPElrI1Pz5rTx6d4ip6mbTrUMG7kkoi3RUyg0ZW8ovQYa7uddRkJPFDGazv0Fk7Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riGlj-0002Ld-Bu; Thu, 07 Mar 2024 17:38:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riGli-004ygI-BV; Thu, 07 Mar 2024 17:38:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riGli-001Ol3-0s;
	Thu, 07 Mar 2024 17:38:54 +0100
Date: Thu, 7 Mar 2024 17:38:54 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v1 0/5] w1: gpio: A set of cleanups
Message-ID: <vsaqquulifmpk5fanl4i67nzag5huyibzy5lfr2jdsgk2dv7t3@5i4opts7npsj>
References: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q3vjeqpuyx6duvlz"
Content-Disposition: inline
In-Reply-To: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--q3vjeqpuyx6duvlz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

I wonder about your choice of recipients. I would have added Krzysztof
to To and me at most to Cc:.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--q3vjeqpuyx6duvlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXp7Z0ACgkQj4D7WH0S
/k40YAf/eofFA4p487oTbWK8VnghpISB2NRngm+WMvyywd2TCEowfETpq799Qelw
liONQOd0URUIsivdtlHTm01FXkjT2LKPjWfkmiHlGJV64ku1fnkYjBLgj1gZg+8u
0wsckkqj2WobrA67UNbxgYbjwoGc6G8xLk3xuGiyZN3YqgXR0wM3sAWYmGR8frvw
FcGkgylJslx0lMlVz4HFz8vxL0ZxQ5lrfYnxJDQgakYMoWaYCuMAQH459z3RVM42
W2PNj/w21rrMhRzJmHZgRa73m5wgx7AijhGA4kqpswUH5fPRU1wrcnVfmwygPeAH
9BFeAQUe0gnP71PB9SgaEj6+6/NKJA==
=7qdi
-----END PGP SIGNATURE-----

--q3vjeqpuyx6duvlz--


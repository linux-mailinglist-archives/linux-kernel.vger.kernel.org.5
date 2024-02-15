Return-Path: <linux-kernel+bounces-66966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A5385642C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12226283F65
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A1112FF88;
	Thu, 15 Feb 2024 13:20:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE1612EBCD
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003201; cv=none; b=er6Q54FRh7ZuD7iy6riO2hqc1CIFje9Geqz/Ank12vzC/42Hjb3h5r/X2INwHyxE+wbvU4X7DSBtsflU/NcHQL2szpcsRVRejzbTB+luFaWUggTRXCo8ccsda3QsT1Y4DxpdSToLcIQRjkfPXrxF0Lc8wla/3yDLo/Gf3q8iKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003201; c=relaxed/simple;
	bh=/rVMH5DYiF+7pqvz5DrPqTvOE1fNuEbj8lHvB5lvWUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSPjWi15Jw2EdDzyPUrGL4et+7s+Ey3nr0GZMWtrHoj+DQU4NHWC1KieSgi1eHMV1qTUilgK8F0ZWPTg4Oh121rMb8VaVFlLxKmB6G7j0bobZousBV2fSFaXgaS11UUoWedMz8h+fIm7QT+k4WNzNTXtWLmOqV9Dbj/KxVZOVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rabeb-0006bL-BA; Thu, 15 Feb 2024 14:19:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rabea-000tW9-SN; Thu, 15 Feb 2024 14:19:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rabea-005Mq2-2Z;
	Thu, 15 Feb 2024 14:19:52 +0100
Date: Thu, 15 Feb 2024 14:19:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] mfd: mc13xxx: Use bitfield helpers
Message-ID: <43waieyxwqh62opb6lrds2r37azp2x4r6yauygldomwhpui7fb@6nookcosjzgt>
References: <ef7d5fc3d867338520392417cdf2b67ba19aecde.1708002264.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zuxdqi2fvc2r5g44"
Content-Disposition: inline
In-Reply-To: <ef7d5fc3d867338520392417cdf2b67ba19aecde.1708002264.git.geert+renesas@glider.be>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--zuxdqi2fvc2r5g44
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 02:07:13PM +0100, Geert Uytterhoeven wrote:
> Use the FIELD_GET() helper, instead of defining a custom macro
> implementing the same operation.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.

Comparing the compiled driver with and without this patch, there is no
difference when looking at

	objdump -d drivers/mfd/mc13xxx-core.o

So:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zuxdqi2fvc2r5g44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXOD3cACgkQj4D7WH0S
/k6f9wf/UcyEWk9DAMLbPPoQDUpaFiZZOet8kvazENB8v8sjVmxy0XvuKeuOmij/
eU2AC8z31lTclqd0IU76PyD0pTTyVW906prnfpYP3zlVJZTwsueqWhKmJWvZ+HMQ
Tdxnhjpvq2YCwO/D60jJDTxiSJL1SA+M23mKClsocanaT45luSSiIGnK6W5uw3kw
L+nilwr74A5pK7YajlL1/dPFMbmbx0d53wqrFnXSMJAc5+kXf+tP9sNK2f784dsu
Jasn5RbKXJTH//8xhggfsS1MAuooEZ40nK9AAZiNJJA9ZsdJiK2keeBf3M6wNjv3
NqDhlbvqMHZtZxsf0R5N+4sWXIiIuA==
=5seG
-----END PGP SIGNATURE-----

--zuxdqi2fvc2r5g44--


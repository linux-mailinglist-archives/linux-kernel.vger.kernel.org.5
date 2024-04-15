Return-Path: <linux-kernel+bounces-144655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEBF8A48D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082401C22E01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63BB2CCB4;
	Mon, 15 Apr 2024 07:19:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7DF2C848
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165547; cv=none; b=rRfc9UCzmh4HQp++UNRVHj/ZHRFMDzU3NV7t7zrNazP8rG67oS8foEEVytQSBUFyyGxlCTz9/YyGFrFIuz+gLqx/kmpTzPZIAMlm+MbyfRwUOKLl2LUoMRkmrF5RI6WQsuZxivgh2TowZA/a6NzRqdfgTVm4bWiGf/ufyemN+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165547; c=relaxed/simple;
	bh=0NQi3dxCxa3HgahBK+T/DQdGihTYfLCvP6CKsu8871U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcNsC8YY3i4BOx5uzqiPJpdB/j9OCccQd96sJIOY+yzQ8eJ+WHF3F2rOQnW9/U1o5mOKXXJUbrbex18rSxNVRxqSwBGZ84pjyFmr1UehPhI3UL/tPhAMI/GfL6nkoW4BfMlRIXkeUdKYO7hrZxy5USo83L2ZCPPQ5ghfBObNwb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwGcG-0003U1-RD; Mon, 15 Apr 2024 09:19:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwGcG-00CNfa-DV; Mon, 15 Apr 2024 09:19:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwGcG-001PYs-16;
	Mon, 15 Apr 2024 09:19:00 +0200
Date: Mon, 15 Apr 2024 09:19:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 0/2] uio: Convert to platform remove callback returning
 void
Message-ID: <g4bpnb64ylia6rlhqbjm5xctuy3uu6wnfu5sxuqkrze24y72od@e3tpnrwwl75t>
References: <cover.1709933231.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ew337vz4dn3pqnww"
Content-Disposition: inline
In-Reply-To: <cover.1709933231.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ew337vz4dn3pqnww
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Mar 08, 2024 at 10:31:00PM +0100, Uwe Kleine-K=F6nig wrote:
> this series converts the two platform drivers below drivers/uio that
> make use of .remove() to use .remove_new() instead.
>=20
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
> The TL;DR; is to make it harder for driver authors to leak resources
> without noticing. The drivers here get it right though and so can be
> converted trivially.
>=20
> This is merge window material. The two patches are independent of each
> other so they can be applied individually if necessary. But I assume
> and suggest that Greg will pick them up together.
>=20
> [..]
>=20
> Uwe Kleine-K=F6nig (2):
>   uio: fsl_elbc_gpcm: Convert to platform remove callback returning void
>   uio: pruss: Convert to platform remove callback returning void

The commit 1019fa4839c9 ("uio: pruss: Remove this driver") (currently in
next) makes the pruss patch obsolete. The fsl_elbc_gpcm patch was
applied.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ew337vz4dn3pqnww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYc1OMACgkQj4D7WH0S
/k5G5wf/U7WIeypfrNfD0St3uPzx3HFxCI0nXsTreKTLNKDZsvDD2iyM4ULyZw2+
ezZ0wyDGe7eAhHItk+4nKggtn45cy1frqpA8sf114pKFuy1CxUxrIRxQNS20Up6Z
FfGrHFRLQ7Oh96K05GLOvIgpx0B29XJMlGizqDWNv3UgBzpITmWByCXx6wRfTwrM
waIwoIo/5rE04tsejFPHTnqvlBvG+hLZ8cfVC+zaARJVuELnRY8bhoM6LsLo7fIH
Dop+ZbUtEU3iX+EMyAOj7AVwyLMi4AJxXCJVLT+Sr5QAFRne8Lx9sOZgSlNGwrql
TE/UzsbsNESrdwf6P5pSia3jBXLfVQ==
=hyQ7
-----END PGP SIGNATURE-----

--ew337vz4dn3pqnww--


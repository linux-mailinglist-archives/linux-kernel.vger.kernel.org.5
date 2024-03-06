Return-Path: <linux-kernel+bounces-94608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF568874212
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B961C220DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6487C1B5AD;
	Wed,  6 Mar 2024 21:35:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC6F1B299
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760951; cv=none; b=MkA2xKarb6rsis9hOIvFAeR+DQclTLHnSS53asxA72HxOw3flKd7y82wLEsvwkpNxFzxQ5UBsgTmzd5todp3Evuiz5Hgn9CnlQSEoK5ZJLCxceVxtXo/FCCHIo1RK5fMfTbI+dDOQhq4AQ4pOKJRLM83iv+HmRa+4PVLkh5wRZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760951; c=relaxed/simple;
	bh=qlVtypVd9DtXuYqgNI8gXdDE7MSGPR3XTAE2JsX2wYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWBLs7WEqUjwwZiGB3WL2p6ebSNSLl4ZZwHYpOKAMzq4JR08Z/wa39Vg4m8dSDBZkJCs2akYEiBuIHwaWfxLAVD3l+GKEF9NTI5zLMBn1RcRo1TsunlwZO5vpJSK0XkPbewBySscKI+kg8CN7xHTLbkgoywRY05kwFlY7thVPLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhyvK-0001D9-U4; Wed, 06 Mar 2024 22:35:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhyvJ-004oxV-Ka; Wed, 06 Mar 2024 22:35:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhyvJ-000t8u-1n;
	Wed, 06 Mar 2024 22:35:37 +0100
Date: Wed, 6 Mar 2024 22:35:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Dov Murik <dovmurik@linux.ibm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] virt: efi_secret: Convert to platform remove
 callback returning void
Message-ID: <dfw3rfgifkv5qliwzxlziwq5kvud4vdro36v22celda6wasy2d@fpcpgcuo22bo>
References: <cover.1703596577.git.u.kleine-koenig@pengutronix.de>
 <4a97c8e6996c9c95244715310b57ce5af6ccb1ad.1703596577.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nalqg2xhdoirh5tv"
Content-Disposition: inline
In-Reply-To: <4a97c8e6996c9c95244715310b57ce5af6ccb1ad.1703596577.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--nalqg2xhdoirh5tv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Dec 26, 2023 at 02:28:02PM +0100, Uwe Kleine-K=F6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Is this patch still on someone's radar? If a resend would help, please
tell me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nalqg2xhdoirh5tv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXo4agACgkQj4D7WH0S
/k5gxQf+K8fES7NTp5SLghXaAI5B67y9x3Yycg/wXPfcgZq3eXDjJAD8zhdKF1Hf
HJUT2i4GJh/uLUtzAjoMjP6/60zVGsFOQO3h3NnHrR5qp37oyC/aKaCa6J3Uwekg
Dva7Ompmdi8aE3L6401B9/30niParIlkJ6OBeNvU3xS7qeajcA1h8FUX/8l50YZF
/zSQPCm77Zl5P73h7CZO2vSVpuvjbHEWbdybduFCrc9cXm/jAslBlOp4CsFYtW7N
NnybBD72TwE2Afu3RpOD3N+Z6s9+fc9yIpmqE2/gcDwOMySAVD3UYcrW6SkLAd1C
HSl22cnHcefGO5ULjeTfBdEkbApVuA==
=YVdu
-----END PGP SIGNATURE-----

--nalqg2xhdoirh5tv--


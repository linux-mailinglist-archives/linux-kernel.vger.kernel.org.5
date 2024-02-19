Return-Path: <linux-kernel+bounces-71962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59EB85AD16
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BE41C21618
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C37053370;
	Mon, 19 Feb 2024 20:25:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0E5535B9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374330; cv=none; b=SDLSNzNflzw6Xg009z5Ld7moVpEpGkREIji/G2WV76kuEtc2pLCYX6GBcqx0yMkSOmVgZVlbI5YriBSlYd81Gf4EoBE95TS/7pI2FilyvThpqEV/oWnikAklPUftKv8aFmeiHDMsFXU08x1RejodvsJptAHuA0/vEUEhY98kv/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374330; c=relaxed/simple;
	bh=Uqg1R0qvaa5JA2Yh6FaRPVlAfSHxwxGSnZkxtpTv01s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxjwdMOukqpSUDg8hey9K1bEDYMhA+r7oy9gALYrCHgU1cHoZ+Ng2PBKcCory9qGMHHgNqZl2eSQvicAFA7yKqPJbabFerNwfYcGlnUfmZ/thP4rVDZTxvlcfgVnjcDbyLRzsLPMHjYJhCyn55mgk7xucdGAS19RdSZhT6rdLSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcACb-000534-VO; Mon, 19 Feb 2024 21:25:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcACb-001iPp-Dm; Mon, 19 Feb 2024 21:25:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcACb-00844W-13;
	Mon, 19 Feb 2024 21:25:25 +0100
Date: Mon, 19 Feb 2024 21:25:25 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/4] w1: Convert to platform remove callback returning
 void
Message-ID: <jodslbkntas5fzftwl4llynbvcw5p4pmup3t46euifpvzo36m7@yvlfqcmbkiux>
References: <cover.1708340114.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lrcv7jlcrjjcdbyn"
Content-Disposition: inline
In-Reply-To: <cover.1708340114.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--lrcv7jlcrjjcdbyn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Feb 19, 2024 at 11:59:26AM +0100, Uwe Kleine-K=F6nig wrote:
> this series converts all drivers below drivers/w1 to struct
> platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
> Provide a remove callback that returns no value") for an extended
> explanation and the eventual goal.
>=20
> All four conversations are trivial, because their .remove() callbacks
> returned zero unconditionally.=20
>=20
> There are no interdependencies between these patches, so they could be
> picked up individually. However I'd expect them to go in all together
> via Krzysztof's tree.

This series hit a corner case in my patch sending scripts (because the
maintainer entry title has a ' which I failed to properly quote). I'll
try to resend the patches that didn't hit the mailing list.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lrcv7jlcrjjcdbyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXTuTQACgkQj4D7WH0S
/k6Lcgf/apfewqeunOC48O19T0+Lgc4HAu4vzNGO2VXUNzo3sLWtLSXJ4/qgsZWW
ArafvrcBM4vqRAz4vPGjkqJCej1aML1IKMZxcf33u+124pngBofx1B2cHL9VM5g8
dxiPS163BaZgujHj+nq/ZVvS1t1DfTiYS0Y9DfWJVerTlfzAEW01CCd0GEtqM9Io
1cLosVtkqgys3Zc7O+YchI9hl+2MBjN8Ipuz2odxVTCHfHf6GDqu2Cpnmjfa47MZ
AZG4c3wH5j8e6QWeTm5Ai4Ew+Du0yoXgdl/we3T1aJhJ8m6IYSvOxkASkyN/jCkH
zbyjN/xMi4rL10l0TJ8th6qXNrtvzA==
=EZpa
-----END PGP SIGNATURE-----

--lrcv7jlcrjjcdbyn--


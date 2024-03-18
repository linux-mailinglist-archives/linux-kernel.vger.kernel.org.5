Return-Path: <linux-kernel+bounces-105842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF6387E54D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8AB1C2145D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D8028DD3;
	Mon, 18 Mar 2024 08:56:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143882C191
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710752159; cv=none; b=dHEP7km1x4vly1Y2l5Tso1M+kf5hPsmtrkfr68EH7EukFb2XxkmsNJE1j0eb2g6t+xZDp1hBE/JOSzLutWc8k7YMgpqxSsE8/4J8D1W8HbQvh9iP/W4cNB4loqMsSAURvzPBRiOVrLaENndrrskOrUPtVE4lKysVHuC11tGYQEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710752159; c=relaxed/simple;
	bh=KgiID1u9b6jsTKcZdyTtZYCrP4qZRlwO+wPt5NLQZ6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIIejgspCMHcyUoXYQ+wb1u6DIHSXFrUpsdsM1GiYZCLFDfrtPDGLp70WqgRo6bnzRD5y6wNYI6zcqdA3z2fP2uNTyfTpKp0VPMxQZNWczlY6XlHdOo3UvOkE3bSdjzxrUJQE0NH6AaJbfHmHrZiTEKmZcotPY5iIYCW/qI8oWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rm8mR-000807-Ap; Mon, 18 Mar 2024 09:55:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rm8mO-0072eN-6X; Mon, 18 Mar 2024 09:55:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rm8mO-007ozV-0L;
	Mon, 18 Mar 2024 09:55:36 +0100
Date: Mon, 18 Mar 2024 09:55:36 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: claudiu.beznea@tuxon.dev, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, nicolas.ferre@microchip.com, 
	alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/39] dt-bindings: pwm: at91: Add sam9x7 compatible
 strings list
Message-ID: <3kqufnvhnmelm7brtuutt7db7himhnb62pi5huq6jhc37n6jww@7emwacpgt6tp>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172619.672262-1-varshini.rajendran@microchip.com>
 <igmm3npqcnjuhhncfd22pjhjuzbtsl25jfzbpcsyx5bu2xbbto@ynp7psnpldxr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="llk2bc7ap25wcrcr"
Content-Disposition: inline
In-Reply-To: <igmm3npqcnjuhhncfd22pjhjuzbtsl25jfzbpcsyx5bu2xbbto@ynp7psnpldxr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--llk2bc7ap25wcrcr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Feb 23, 2024 at 11:42:57PM +0100, Uwe Kleine-K=F6nig wrote:
> What is the merge plan for this series? I'd expect it to go in
> completely via arm-soc. If you want me to pick up this patch, please
> tell me.

Other maintainers picked some patches from this thread and I didn't get
an answer to my question. To be able to close this thread on my side I
applied this patch now to my for-nexxt branch

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git for-nex=
xt

=2E This is expected to be rebased once v6.9-rc1 is available, but it
won't get lost this way.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--llk2bc7ap25wcrcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmX4AYcACgkQj4D7WH0S
/k55HAf/THdprVTV+CtYTdSymvUxL+vo9ng4B3Wg4714vu5TgVXfbXzRaGWpVp/g
wC8YSmArkKvoQNC33j8nZLTYncGvMWfoT0Jhy08XtPJ/tzkqBSrAz1kVzDS251g0
zoWgLrohzAMnJUvZqiBuLufx363NdCAG1tN3n2A6eSAgFIZq/qCZ9ghnHSpgmvmj
AnwQyeaBYGp0KE2ngoZTFVloQfptvsgE+ybX0P6WcN6dgqrHo+VqeP/0KNzwc46S
5ujRvo4kZSh+j/jLtQsfSe9KxRBw4sSW/AZ9O8eA4gRS5HC9v/Cn/af5qyMRfZi7
/yrvNNfQaApZg6v0Y66uyooQKW/83g==
=En9w
-----END PGP SIGNATURE-----

--llk2bc7ap25wcrcr--


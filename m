Return-Path: <linux-kernel+bounces-39285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EA683CE29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57E41F28E85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B580E13A251;
	Thu, 25 Jan 2024 21:06:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E836129A9E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216773; cv=none; b=syPfjpn9c4iKjmxOlHxPCUHxWJ7Bk9lOOo1wnIqhRTvgE6KNBD7cXaW46N12aFE5h4lnAollW+v3c83z32mArxrIMUppdRgBBSGfinM+rU/5Cx+Cy9Ye93d4EK15j+PeCVu50U3yIWiBNdNmtYQQbgFcVYzEqG3nsXYMvqMizhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216773; c=relaxed/simple;
	bh=/t0E1Y6vE87oGhYuku8ZEQl3ELZ80nnoKFiAV5zq5F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S95IaIT/Qncj01ikX8Zsv9non5lowdviWpYOrK7LnncZyRgqoEV1I0P1F18s0TTY53MVkJedr3CkRhD+wzwqRcnIZozs2jdLC4osL7f1+MoEw59rxn43Zeuq8wOqBPRZFQN2eYjLQzqQMfaLw9BXI7lDDeScsmbdCu+wOfT789I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT6v2-00027U-1J; Thu, 25 Jan 2024 22:05:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT6v1-002N2B-0R; Thu, 25 Jan 2024 22:05:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT6v0-0088nd-2w;
	Thu, 25 Jan 2024 22:05:50 +0100
Date: Thu, 25 Jan 2024 22:05:50 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3] dt-bindings: pxa-pwm: Convert to YAML
Message-ID: <siwvwaflm463aors7vqq3wymrctynz4ihuw3qict45k37p2y7u@iogttbcy54io>
References: <20240125-pxa-pwm-yaml-v3-1-10b0b0dc02bd@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="devzg4m57i2y5enr"
Content-Disposition: inline
In-Reply-To: <20240125-pxa-pwm-yaml-v3-1-10b0b0dc02bd@skole.hr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--devzg4m57i2y5enr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Duje,

On Thu, Jan 25, 2024 at 06:36:33PM +0100, Duje Mihanovi=C4=87 wrote:
> Convert the PXA PWM binding file from TXT to YAML.
>=20
> The original binding does not mention any clocks, but the PWM controller
> will not probe without a clock.
>=20
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

I still have your v3 on my radar, I just didn't come around yet to look
in more detail and (probably) apply. It might not apply to all
maintainers, but for me such a resend is just adding to my todo list. (I
searched for the original v3, compared the submissions, didn't find a
relevant difference and no further explanation for the resend and now
explain this.) As long as your patch appears on
https://patchwork.ozlabs.org/project/linux-pwm/list/ as actionable, I
will eventually come around to address it.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--devzg4m57i2y5enr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWyzS0ACgkQj4D7WH0S
/k7sBggAkHvP1NOnpeDKxfH962p5vKJwdWTKfATTV/7P1pGb9CTubZniCowSvLgZ
gWN/sb0lVJPLXcn47P7IcTycwHWy3OOghRomDxjYJrcGd2qgLSPzr1m6rbFp42ua
oZ/9v/MdIcXHP2St1Lr9J+rTGSrg9nKZV0VTMjh8kVcjTl6KIuLWuwlKj2B/4OQb
t9Z4/bRXHTm6jyiWeSJIKTCzU/rfF4mKQVH9D4qKP/9uzOiv0WVcHRRnqy5C0vJ+
44cGlnAEGN1smLeHE7S6uuTnfber1YuhMjQh8zSa0oSkB+hfgvNe47D8QgCQ5Fe7
Y8NoL4GoEztjoZfyNWQIfBEo16ko8Q==
=tem5
-----END PGP SIGNATURE-----

--devzg4m57i2y5enr--


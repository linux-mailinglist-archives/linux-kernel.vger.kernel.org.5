Return-Path: <linux-kernel+bounces-142627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F62D8A2DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C63284239
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C7A56450;
	Fri, 12 Apr 2024 12:08:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133E93F9D5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923716; cv=none; b=JfW7w+48g/bhV0McK0qriyjCPmxXghU99XC20DoZdvEN+GLCvn34wVr8Iv0e9qeupH8X3iFWlZzVrhgpziSIuunvZQJnXsTlc8mNeud/K2+QJbV0kFy/MGTqDYteaJV/4y6plcegjQW3pojehAKebD88puitYuIDpXEuFWRbJt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923716; c=relaxed/simple;
	bh=aGZGursS0e7p0NN8/DsscT4cCqk++laaAgsgmlWTm/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cC8cCvyUxuAGFp+1OT/aEdk5hEJyeD9/aQHY3YuQaY+WZAGk0WhyGwuY3GgcLDszq/vM7sDLux4rdMnhp8Z8ZaQpVIFOB+tCRAyE+fEyF05A4NufEkRVXYdWGUw5Mos3t1f4/b7Fzi53s2eG6i9xhgBPrpboDZGI3Ir7KYf8il8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvFhf-0007RX-Pr; Fri, 12 Apr 2024 14:08:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvFhe-00BsBA-On; Fri, 12 Apr 2024 14:08:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvFhe-0009i4-29;
	Fri, 12 Apr 2024 14:08:22 +0200
Date: Fri, 12 Apr 2024 14:08:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, 
	JunYi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v5 5/5] pwm: meson: add generic compatible for meson8 to
 sm1
Message-ID: <24ec3iiudmfapiosygpsvgu7kmdqe6csbkpuzx3p3sa4oyodqu@hshmbpvzhufb>
References: <20240221151154.26452-1-jbrunet@baylibre.com>
 <20240221151154.26452-6-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o6zwfw2ds5fuh2ws"
Content-Disposition: inline
In-Reply-To: <20240221151154.26452-6-jbrunet@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--o6zwfw2ds5fuh2ws
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 04:11:51PM +0100, Jerome Brunet wrote:
> Introduce a new compatible support in the Amlogic PWM driver.
>=20
> The PWM HW is actually the same for all SoCs supported so far. A specific
> compatible is needed only because the clock sources of the PWMs are
> hard-coded in the driver.
>=20
> It is better to have the clock source described in DT but this changes the
> bindings so a new compatible must be introduced.
>=20
> When all supported platform have migrated to the new compatible, support
> for the legacy ones may be removed from the driver.
>=20
> The addition of this new compatible makes the old ones obsolete, as
> described in the DT documentation.
>=20
> Adding a callback to setup the clock will also make it easier to add
> support for the new PWM HW found in a1, s4, c3 and t7 SoC families.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

After spending some brain cycles on this one I think I understood it.
Looks fine to me, I only considered questioning if the dev_warn_once is
too offensive.

b4 + git applied the patch just fine even without patch #4 of this
series. Would you be so kind to double check it works as intended?

BTW, b4 diagnosed:

Checking attestation on all messages, may take a moment...
---
  =E2=9C=97 [PATCH v5 5/5] pwm: meson: add generic compatible for meson8 to=
 sm1
    + Link: https://lore.kernel.org/r/20240221151154.26452-6-jbrunet@baylib=
re.com
    + Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
  ---
  =E2=9C=97 BADSIG: DKIM/baylibre-com.20230601.gappssmtp.com

Is this only because it took me so long to reply, or is there a
configuration issue with the baylibre MTA?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--o6zwfw2ds5fuh2ws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYZJDUACgkQj4D7WH0S
/k5YqAf9Gp+g65dKTx78fK8hzvxoD9Y3G0PBNvMZG0cgDhyEIvXcC0zVpdDqgL/L
UbcBW+DNc5Imw7H91xeUtyD4nDhybz1aG38vALuh8Ojuy+qqfxhZpaaDLl0344sB
QVRkyJQxgB2VYDslaNPD7caXYtuMTwdyrbXf1jE7dg5ui9zWpr7pR+1TFPEYGsRE
iRBqz3cZmq1MN0/1hhzw81jXz7rJVgv79bGBHr43wq2EwiAB/Rx1ztYFl9stz9PR
KLOWaASjPFjeHxdrv6gP/+TEJ2BweZe7wwkEHFe34KUysr2x+QUFK2+x727TD30j
gAmrGXJHW5AvlZZQMvhhKwxdFsxrpQ==
=JdWF
-----END PGP SIGNATURE-----

--o6zwfw2ds5fuh2ws--


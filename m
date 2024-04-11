Return-Path: <linux-kernel+bounces-140977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9378A19E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4ED1C215A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDD81BC7CF;
	Thu, 11 Apr 2024 15:37:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438541BC7A1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849850; cv=none; b=cMo8fmM/xFn0/FguoJzZ0w6HXgxKyuj7P/JbGAzjmHYOcdOmrCdIQJneSx0oc8Z8Zf6Kp4RImtI7UxV7ekJSlncKNlLky4De8n2udLiblkonkBOKW5tTxRM6W87OtHrXbR7Xn1wjOyXGpxyKy6yL8mNIOYhcPor0IZTRLcFAqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849850; c=relaxed/simple;
	bh=tm3OudM3U3aNloJACnj/5Z3NyHZxofdkBhqTIgpdlHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYuaFaAxhSfVoe9Cx1OcTGKHy8kLS90OVKf1+2GzIPjLIkDpqxpKPpNGlGEwveVCOijJO2lvBj/ybmgxiWw1dMwTfbQND8iHAxJmgRv4aoQy1PgsYypIjq3uymbFhkx9VG9zo1wu7ir3pxpJov5hYsICZbf/Y1ZcQQJhbhN3eI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruwUR-0008Tj-EC; Thu, 11 Apr 2024 17:37:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruwUQ-00BiHf-Cr; Thu, 11 Apr 2024 17:37:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruwUQ-000fi4-0y;
	Thu, 11 Apr 2024 17:37:26 +0200
Date: Thu, 11 Apr 2024 17:37:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, nuno.sa@analog.com, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, Drew Fustini <dfustini@baylibre.com>, 
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH 2/2 v4] pwm: Add driver for AXI PWM generator
Message-ID: <7i44urixaxohcae44gleqm6tvgterwjz7kerbozijxzrau7czd@bl6rkkmpes3u>
References: <20240301173343.1086332-1-tgamblin@baylibre.com>
 <20240301173343.1086332-3-tgamblin@baylibre.com>
 <zwer5e7jmrqfi3yeooandpfyhs663i3adcaxjeizmwgmfxltp3@gnpimhyoaqjf>
 <f2579349-2cb0-434a-bae1-493218a62d53@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z5pq6rhmfbngiav5"
Content-Disposition: inline
In-Reply-To: <f2579349-2cb0-434a-bae1-493218a62d53@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--z5pq6rhmfbngiav5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Apr 11, 2024 at 10:07:54AM -0400, Trevor Gamblin wrote:
> On 2024-04-11 12:59, Uwe Kleine-K=F6nig wrote:
> > > + * - Writing LOAD_CONFIG also has the effect of re-synchronizing all
> > > + *   enabled channels, which could cause glitching on other channels=
=2E It
> > > + *   is therefore expected that channels are assigned harmonic perio=
ds
> > > + *   and all have a single user coordinating this.
> > What does "re-synchronize" mean here? Are all counters reset to zero?
> > "harmonic" means that all channels should use the same period length?
> Yes, it means that all counters are reset to zero. Harmonic in this case
> means that channels can have different periods, but they should be integer
> multiples of each other. Should I rewrite the comment to be more explicit?

I hesitate to say "yes, please be more specific" because I think it's
mood. If all pwm lines restart with their counter =3D 0 as soon as one
line is reconfigured (without completing the current period) being a
multiple of each other doesn't help at all. So I think the right thing
to write there is:

 - Reconfiguring a channel doesn't complete the currently running period
   and resets the counters of all other channels and so very likely
   introduces glitches on these unrelated outputs.

(Even if the period was completed, and only assuming configuration
updates that don't modify the period, all channels that don't have a
period that is a divider of the just configured line (might) glitch. So
if you have one PWM with period =3D 200 and another with period =3D 400,
everything is fine if you update the latter, however updating the former
might make the latter glitch. So essentially you need to have a single
period for all channels. That's why I asked if "harmonic" means that all
channels should use the same period.)

> > Reading https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen I would
> > have expected:
> >=20
> > 	/* ch in { 0, ... 15 } */
> > 	#define AXI_PWMGEN_REG_PULSE_X_PERIOD(ch)	(0x40 + 4 * (ch))
> > 	#define AXI_PWMGEN_REG_PULSE_X_WIDTH(ch)	(0x80 + 4 * (ch))
> > 	#define AXI_PWMGEN_REG_PULSE_X_OFFSET		(0xc0 + 4 * (ch))
>=20
> The regmap you find there now reflects v2 of the pwmgen IP; v1 used a step
> of 12 instead of 4. The v2 series sent a little bit later on adds this ex=
tra
> support: https://lore.kernel.org/linux-pwm/20240314204722.1291993-1-tgamb=
lin@baylibre.com/
>=20
> I've added support for both versions since v1 of the IP could still be in
> use on some devices. Would it be better to have the two patch series
> squashed together into a v5 of the axi-pwmgen driver?

Not necessarily squashed, but I suggest to send them in a single series.
(Note, this doesn't mean "Don't squash". I didn't look at the other
series yet, so make a sensible choice yourself (or wait until I come
around reviewing that other series and hope that I remember the context
to comment about this question. :-)
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--z5pq6rhmfbngiav5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYYA7UACgkQj4D7WH0S
/k42rAf/dYYgtWgQCwgoIgEbZ3xDBVCMESJkV0AhyE6HM01lBRbUSA5YWTE3kV6b
opqkoV8PJn0Vc4l0cUkKrW/dtLYdn53XYIzu0G04IJLGN2qpj73UxAl/mcl3r+HW
5UcYF9SQiXF+xcalszH3x2q7g9Lk4YA2j19Jv1322HWp0PIQ59uD5a/MsDhzvsnr
e9ZlQ8nnvFVIDozffW+Dzi8TwisbywGvo8IEBtyW8/PQPlNtmvdKfTBiR/1Cjg8p
wS6wmlYNqqVBIeCMRWr377gE/16YAUCs7uzksJ33B5BuNT8NlkfmAI+2U5QD5jni
4B2Pqu0G5QpOwMipw/RLhIftklyaeQ==
=H5Ix
-----END PGP SIGNATURE-----

--z5pq6rhmfbngiav5--


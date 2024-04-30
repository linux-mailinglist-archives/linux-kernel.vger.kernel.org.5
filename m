Return-Path: <linux-kernel+bounces-163521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCE18B6C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEECF1C222FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0C64596D;
	Tue, 30 Apr 2024 08:07:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5427251C21
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464437; cv=none; b=D1SX/MM9G/wQS7aDfo9jOmkC9Khj//Z/VTk+Kl0bfQpdYz//C/My4RAATkq+cEMPf/YTcS4SLhmDUxoZgmHAOGbYS8qE5C0nV5UCbbg3D32wQZCQ6epTnuZ8fmbA1iNsuBODoZ10xz84+9BnyueL9W7FAgfVxD7hqGescRj7UKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464437; c=relaxed/simple;
	bh=GoMxzXO5ebIMyjF2fiATnKrXyv8nC1H9D+ggXt8GkRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocrpMi8MGS4YVppMPftrrLT33p1pS2JlIZ5X+5qEz7qf48KIZ1OrXSuebSAP3stLEsxvcV+tSCcfwoX2HB/t1TgQJAd9fS3U8Cm9wHIadnmjsJS9ICqkJwVYkD+TAKn2GdBpVMzILoyHGZVehU/owBc/f2ITZLry7zi1EoPYLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1iVq-0003Ve-AI; Tue, 30 Apr 2024 10:06:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1iVp-00F85P-5q; Tue, 30 Apr 2024 10:06:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1iVp-00BzUv-0H;
	Tue, 30 Apr 2024 10:06:53 +0200
Date: Tue, 30 Apr 2024 10:06:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, inochiama@outlook.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Message-ID: <vxolfkvbquiy2jllncjy3vbfl2jr26wkdvpxv65uz4dneln5jb@ozg6ejzgmj6f>
References: <20240406063413.3334639-1-qiujingbao.dlmu@gmail.com>
 <20240406063413.3334639-3-qiujingbao.dlmu@gmail.com>
 <njsvev4dxjln2guw3lr5zwvytzvvmj7qcuduo2v56dhvuxujs4@eqm4cmh6ddva>
 <CAJRtX8So3PifNFfsnq1BmP3+8kevhM6Fk6moMp=wFX4o8q89SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l6zw653cypgpdhtk"
Content-Disposition: inline
In-Reply-To: <CAJRtX8So3PifNFfsnq1BmP3+8kevhM6Fk6moMp=wFX4o8q89SQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--l6zw653cypgpdhtk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jingbao,

On Tue, Apr 30, 2024 at 12:36:56PM +0800, Jingbao Qiu wrote:
> On Mon, Apr 29, 2024 at 10:54=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Sat, Apr 06, 2024 at 02:34:13PM +0800, Jingbao Qiu wrote:
> > > + * Limitations:
> > > + * - It output low when PWM channel disabled.
> >
> > Just to be sure: the output is low independant of the POLARITY register?
>=20
> When the value of the POLARITY register is 1, the PWM outputs a high leve=
l.
> When the value of the POLARITY register is 0, the PWM output is low.
> Should I make this point here?

So that's: The hardware emits the inactive level when disabled.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--l6zw653cypgpdhtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYwppwACgkQj4D7WH0S
/k407wf/XEqAv+lfE2x1df8bBAO98sRXO0K23AiMkSaqemGqt0dnc3Plae17H1Uz
1U6g2M6M7JvkKCCdXcfkuekzcd9DF9f8OoQrQbyA0wkedI+rbxxci8JJIJFUvNjv
MoSt86M2sI0hIxAB4jDy2GoTVcrheo9P9pPI6QbLhVz20YFbs2uF0xP1/oVETwMN
DKghx1EVZOe4Xx32dXr35Cp1QuPpxFhvqvEnEO84bcU4Dk9jZmiHvf4hnl1yB/7O
4ICrIDwj9xlLd4CWGYgSAqKU2J6YhAc9PXRHKxEtJqixKiRTV5HnqihGbTGKHNFp
YbzbadVrS3rgPT3AU/gbpZDniis32Q==
=B9+q
-----END PGP SIGNATURE-----

--l6zw653cypgpdhtk--


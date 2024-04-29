Return-Path: <linux-kernel+bounces-161803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C478B5174
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861521C21346
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA3B944E;
	Mon, 29 Apr 2024 06:30:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1846810FF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372259; cv=none; b=q50ViepftY4UgZW0UhMciRy7idS6Qp/oPFI6RSuWucsKBMA3x0aXTwHnJhXcrpt8exHHFUhMXuAyQzqyjIliUyqaBKT75YmM2KHPF+kOi0Th8BvK7JfQWtaf9YOhDXieZgqBRpCF9qkSx1g8bv37N3drpb4r5TzpvJ8KBEJ3QxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372259; c=relaxed/simple;
	bh=R7C5wr96MqWDYR44Ry+prYbPTSvDWaKrG2gXzaFYjI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgxxySwu+oQA2KcnPEPrJ/xNQY8fHH4tI/ex2qW26+3tyU8hqe+uCXerOhA+mCxPxVzIkaqlWbZITD4p8N33GdlAfKj8woq9hX3G7D5D8OnKp+E6A8kv1GoFVxaGfJpeOo2FDG/80aGiZIn+5d2qa4RItEaSOTiO2l3uoMw7uVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1KXJ-0007Fa-Dv; Mon, 29 Apr 2024 08:30:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1KXI-00Evg4-9u; Mon, 29 Apr 2024 08:30:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1KXI-00BDAk-0h;
	Mon, 29 Apr 2024 08:30:48 +0200
Date: Mon, 29 Apr 2024 08:30:47 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com, 
	dlechner@baylibre.com, devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org
Subject: Re: [PATCH 1/2 v5] dt-bindings: pwm: Add AXI PWM generator
Message-ID: <sjgqbftxfz763qoj33p2diba4ify4lae2vc2amcpaudjtdlse7@buk2wrofz3fp>
References: <20240424125850.4189116-1-tgamblin@baylibre.com>
 <20240424125850.4189116-2-tgamblin@baylibre.com>
 <8bc13253-db16-4801-9f69-b06ba4e129be@baylibre.com>
 <148f8e69-ad44-40f8-b277-69c289b94c68@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gvrldjymnq56fhzd"
Content-Disposition: inline
In-Reply-To: <148f8e69-ad44-40f8-b277-69c289b94c68@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--gvrldjymnq56fhzd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Krzysztof,

On Mon, Apr 29, 2024 at 08:23:19AM +0200, Krzysztof Kozlowski wrote:
> On 26/04/2024 22:11, Trevor Gamblin wrote:
> >=20
> > On 2024-04-24 8:58 a.m., Trevor Gamblin wrote:
> >> From: Drew Fustini <dfustini@baylibre.com>
> >>
> >> Add Analog Devices AXI PWM generator.
> >>
> >> Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
> >> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> >> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> > Note that I missed the following two acks from the v4 series when=20
> > preparing v5:
> >=20
> > Acked-by: Michael Hennerich<michael.hennerich@analog.com>
> > Acked-by: Nuno Sa<nuno.sa@analog.com>
>=20
> You cannot add other people's tags that way. By default b4 ignores it.

I'm aware that I have to pay attention to that detail (i.e. using b4 am
-S). Full disclosure: I asked off-list if Trevor missed to add these
Acks and requested to add them this way if yes.

> Also, don't modify the tags...

you mean the missing space between name and email address? I can fix
that up when (and if) I apply the patches.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gvrldjymnq56fhzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYvPpcACgkQj4D7WH0S
/k7SUQf7BzKSUujDtEWtqcp4TGtptEioI6AM59Ll/ritKfTWBnFnWKdX7u4WnDJD
3p5P4fNBG/KKUsJoRJTYUT397NhSkot00rGWFHgGDOwFTggpPjEt8BE8Kut+k0QX
Nohl2BxUw6/UAeDG0zut9ObxmR9oGecTwtswRr9nK7Ol+5QOxlPQJn5jdwhiVAe4
8UeF1Hp/zt7WeDkCHWw3q8wM6hlFvqclE/4WYB1h5UfQ3ZLXxFd/2kltlyZwAtFm
YTuG2t/Ku/KnXlB07a+VIDFyHUPUj7xMXM3R7siYli+hZClqP+q12CK91dDu6fTh
G1Wbqcs033VybfJGNg3u+24MJaGyiw==
=6L5Y
-----END PGP SIGNATURE-----

--gvrldjymnq56fhzd--


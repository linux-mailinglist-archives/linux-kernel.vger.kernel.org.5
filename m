Return-Path: <linux-kernel+bounces-68286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2420857837
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A966288505
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179071B81D;
	Fri, 16 Feb 2024 08:57:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0161B1B297
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073830; cv=none; b=iZEVzi4bmldGCSig0Bbe2f2crjLkG6Wqf6ZaOgGP0prJVIUxRCmTT+sc8O7Rb3vfGHnOKwPd9h6EHbOVlpyhQ9Z0ir5BEAxGhusQ4TZSkvti6tbwAWoKVUqsVJIWLFiX7X14kJmvFw29XgNbRDec8tJdSt7m5e4cUmGh4Y5M4is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073830; c=relaxed/simple;
	bh=F7SJEois+X8tz2gjrxqqrDEy5yeqY6GzZm2Rtgg54X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5AstuMgZxh6j2I3GYAmeFNQvKGhrqeZQtIFAKYA0gfuZv4rf0X/dPbY4afz28+JAi0KcmzI6WLgo/jkaIRp8jH8VCLSmLnA0qIgnRjlEMIP76/M4qtx3loPCz/K7Mqeb0d3C3IaeRQNiFupe1IlRmRf61lvph1Yw1hRmgEoBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rau1c-0007VS-M6; Fri, 16 Feb 2024 09:56:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rau1b-0012eE-I9; Fri, 16 Feb 2024 09:56:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rau1b-005roU-1V;
	Fri, 16 Feb 2024 09:56:51 +0100
Date: Fri, 16 Feb 2024 09:56:51 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Conor Dooley <conor@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: mediatek,mt2712: add compatible
 for MT7988
Message-ID: <crisnlcmsylgjbyikwj4it5oee46lrcneegt35rkh7f7irpjt4@au5h4owkl4s3>
References: <20240213164633.25447-1-zajec5@gmail.com>
 <20240213-resource-evaluator-0754cfd5882d@spud>
 <d4391868-ddcd-4f66-b539-28d245fa83df@gmail.com>
 <e957b044-fe84-4b72-bdf1-cbc40c722019@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x6fer6asqpvyqikq"
Content-Disposition: inline
In-Reply-To: <e957b044-fe84-4b72-bdf1-cbc40c722019@collabora.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--x6fer6asqpvyqikq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Feb 14, 2024 at 10:27:54AM +0100, AngeloGioacchino Del Regno wrote:
> Il 14/02/24 07:34, Rafa=C5=82 Mi=C5=82ecki ha scritto:
> > On 13.02.2024 19:18, Conor Dooley wrote:
> > > On Tue, Feb 13, 2024 at 05:46:32PM +0100, Rafa=C5=82 Mi=C5=82ecki wro=
te:
> > > > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> > > >=20
> > > > MT7988 has on-SoC controller that can control up to 8 PWMs.
> > >=20
> > > I see a binding and a dts patch, but no driver patch, how come?
> >=20
> > I believe that to avoid cross-trees patchsets (which are sometimes
> > tricky for maintainers) there are two ways of submiting such changes:
> > 1. dt-binding + driver; then (separately) DTS
> > 2. dt-binding + DTS; then (separately) driver
> >=20
> > I chose later in this case as my personal priority right now is to deal
> > with all MediaTek DTS files.
> >=20
> > Is that wrong or unacceptable?
> >=20
>=20
> It's not wrong but it's partially unacceptable, at least on my side.
>=20
> In my opinion (and I believe many do agree with me), sending the binding =
along
> with the driver is the right choice, and if you also want to include the =
dts
> that is also appreciated: series can go through multiple maintainers appl=
ying
> subsets - it's ok to do.

Just to put in my 2 =C2=A2:
My preference is to not avoid cross-trees patchsets and put all three
patches in a single series. This combines the advantages of 1. and 2.
Given this happens often enough this is something that the maintainers
are used to handle just fine, so the cross-tree issue isn't problematic
most of the time. The conflicts that sometimes arise with cross-tree
patches aren't bad enough to out-weight having binding, driver and dts
changes all together.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--x6fer6asqpvyqikq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXPI1IACgkQj4D7WH0S
/k50eggAl5AH/OVaXRqlBR+khwnAAggxgfwh/au8rZ5x8SWflhcLnzmbI5goBNP+
QiVN6/885+APLBzrvTgeiEQAjlKGsc1Av9hy5x2gQy4U9rhPVikE3B8fE9pugDEr
ZIhljDbUobwdsu08aGbAr2sggD9tI8eJDcssD9sOF6Gwn73LjYJ7AxYuph9MWHqJ
Ztdiy+AjILaWSAq4jeCCmL6MFgXIGDq6Unb6w6lDFhAcjG6FKh09+gyjFkihNdsg
Ib93vHAw+rnrzUfcHhmFNaIIiw5d5mediZDrLKqWXp5U10ipOhfocOoyFK3AqKVS
9PS6i5I/jMerH5hRMqLY0+/3ZEjhlA==
=TKTq
-----END PGP SIGNATURE-----

--x6fer6asqpvyqikq--


Return-Path: <linux-kernel+bounces-60720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C83F8508E1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227411C228FE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7735A792;
	Sun, 11 Feb 2024 11:51:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C042A94
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707652315; cv=none; b=sGt70fCmTDtcWkilgi486EOHdsnMN3UooIGO03uW7oVAReCqUxXhBBZ+mj1naa/qN03aXpkGyo7fU53TJG3RVvobkuruet2i/c6hy7Ht3SltwQGi6zq1Kc5cZ6o4sqJweRzpTMi5454hCXM5mORKjb3LJEh49x0d01WxWqfc5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707652315; c=relaxed/simple;
	bh=XOk8Kr8T8eOC+VVzgQLqdZmZkP4QeC0s2lWogs+CjA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6zocXV9JlPpX/MNdwdVswQPvhlSRp3Y86T49YPg51YronzMpqmYPtZtIBvhrQc+87kbRG/Nk/e9aI0W5FaMWfXThK3142nFTHJxctCd9Z6B8pX0pX2+f3BazlprPO0FydMYrO2TqqAYXSstOJ3pvqOM5goXNzoq1BpnVMxNWsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZ8Mp-0000La-H1; Sun, 11 Feb 2024 12:51:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZ8Mj-0005Ea-EX; Sun, 11 Feb 2024 12:51:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZ8Mj-002Utq-17;
	Sun, 11 Feb 2024 12:51:21 +0100
Date: Sun, 11 Feb 2024 12:51:21 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Erick Archer <erick.archer@gmx.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Heiko Stuebner <heiko@sntech.de>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
	Rob Herring <robh@kernel.org>, Li Zetao <lizetao1@huawei.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <keescook@chromium.org>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: Prefer struct_size over open coded
 arithmetic
Message-ID: <rep3323evfhxh5ctmyd2biqrpg2ifej2jei5rsqpei7vuvnmsc@krh3gihuyoox>
References: <20240211091633.4545-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sfcqdcis3bm2zuuf"
Content-Disposition: inline
In-Reply-To: <20240211091633.4545-1-erick.archer@gmx.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--sfcqdcis3bm2zuuf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 10:16:33AM +0100, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
>=20
> As the "chip" variable is a pointer to "struct mtk_nfc_nand_chip" and
> this structure ends in a flexible array:
>=20
> struct mtk_nfc_nand_chip {
> 	[...]
> 	u8 sels[] __counted_by(nsels);
> };
>=20
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the argument "size + count * size" in the
> devm_kzalloc() function.
>=20
> This way, the code is more readable and safer.
>=20
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open=
-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sfcqdcis3bm2zuuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXItLgACgkQj4D7WH0S
/k5ikgf9F4/qTgtnox96aTKRccDzsaTgOw9Qi3pN71OjgluyHYlBZZuLkP5oxvMH
1xtEtrRoArhwg8s5AISfkCSKbJG6D3uSXUf9HsjiHx2K2tK+RkQy1vFalheaw7V5
E4xeT2nxo6jpRzzqeqs75p8KbDE1FdrEZZuarr3wqtfb+oapvNF8Fy9a82Yg1BZC
DMVilJ/dMLxb6nLJ6V0fGGOzzio9S8AIFx0alMWvEzVu8i+yDDLBWbQDlQZTqzIn
lfNs4OCNwrzqhNhlWD6V8lzYV8SaUtFW+1A6ZKJb19MwobAnXElAgIQJOWX0PSY1
vASWpbUmeY9zm+JPlBvqvX/3KIcWew==
=DQCU
-----END PGP SIGNATURE-----

--sfcqdcis3bm2zuuf--


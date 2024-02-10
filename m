Return-Path: <linux-kernel+bounces-60498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2308505B7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D281F2165B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3C85CDFF;
	Sat, 10 Feb 2024 17:23:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407CD5CDEE
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585791; cv=none; b=LUlq3h+dWvsYgt3r2CuVURrbrF1H4r6X02rcPSrW+9o1nkELBwMNLlAK94KEFn9zYY85HhRSocTOtrEdGJgQeNqZ3UdXkXGQszPFyMnRj1Ybnydn1L4PI35f6WzMRqj+yiV6PfSDZw3pCQIXa3WxATmx2ZbqonRZfL+lsZkS6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585791; c=relaxed/simple;
	bh=3HOTMAvrmTBnH4wx3urQWmGfStLlmr/dw+Sp1ocasV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFI6sAA0Mm4eLi5byVPNDhAIN45obbMiUh2cteD0eo1Sez4YDCFLL6RkDjyaN0D90QEqvYFSPm9M3at1dh7jxy5x+DIZ/F4SafalkplrdIMC77gupUfwv4KZRZEI2E1qsuAE17RYlSp54N7T+0ir+q1cLJHliu0dHqROWAB5lT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYr3s-0003V7-AK; Sat, 10 Feb 2024 18:22:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYr3n-005icH-Po; Sat, 10 Feb 2024 18:22:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYr3n-002FSV-2F;
	Sat, 10 Feb 2024 18:22:39 +0100
Date: Sat, 10 Feb 2024 18:22:39 +0100
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
Subject: Re: [PATCH] mtd: rawnand: Prefer struct_size over open coded
 arithmetic
Message-ID: <vm3fk7wbqxjl3i6kmd3dv2ofeszjxrvi2n7cd3ohasgjpi4j4g@d3f6estk2xol>
References: <20240210161619.12656-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="346zxj37n4z5j2px"
Content-Disposition: inline
In-Reply-To: <20240210161619.12656-1-erick.archer@gmx.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--346zxj37n4z5j2px
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 05:16:19PM +0100, Erick Archer wrote:
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
> This way, the code is more readable and more safer.

Unless you intend this non-English comparative: s/more safer/safer/

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--346zxj37n4z5j2px
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXHsN4ACgkQj4D7WH0S
/k7uhggAkjErCNtMO9Tgeku9UEu3BBrTsCG6cirem2RU9oGOT4pbrCjRb2KCGYfU
q+/lrPRkB6Tp8aLA3ljD5QZbmSN4UY7IFFRjTPhs2QeCfLX4USL2es+P4oCbd32u
gZqw7aoZgZ1Gb05G5gboHeun8K3eEQE8eWfj1hq4BetoLNdq53tlW/csK98ayxPA
JmPsBOXq5MHiGDSNqb1gp85oNS2F3D+F5YortaxkPr4F3L17MG9XDezixApG/nTw
Uz2+EdFzM6BJN1Zac6t3Z2/6IaYa+aHE+ugdYp5aQIZ2NqiFaTHL7c9UfO85Zsi7
1fYuhJr1sBGrZoWF8QnOgiJmoDAtPA==
=Sihr
-----END PGP SIGNATURE-----

--346zxj37n4z5j2px--


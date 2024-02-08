Return-Path: <linux-kernel+bounces-57861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9EB84DE4C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B503F28375D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6936DCFE;
	Thu,  8 Feb 2024 10:28:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2AC6F06D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388122; cv=none; b=BI/mO6ksgN2NSY9JkOHbY0RKzxi/LZbuwH/sYXIsNG4/gQS0bpL2DzUBi/LAMAMRx9FSJs71XQmz6fGxDgc4vCQuKGeD8ABDqNszhfJRFtdrKcs6QBlH7b/RoUHgwWyIesj4mzdAvyxO7VWvcaa0z05PIPu5+tA+BNjtjtg3Y/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388122; c=relaxed/simple;
	bh=rlNgloJk1bbDe0doAWtnBreqlo1LG7i1MjEav7L5J7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCCzBK3Azg/uXpS/5c7Tf1ZjaQEqnEpBnSWUkFqZg7gbIAEvVOt9UFpAXFM4RKNw0nz9AofMurj4n6mT4rV5nR5acUBx2NE3ElcEtJ9Xw4RdWOHhjv16hBIiTEB+CWmObRC0IODUQKxqDj5i5+desoVMuWQJakneU3hUOPvOMFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rY1dq-0002O7-Gf; Thu, 08 Feb 2024 11:28:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rY1do-005C8j-01; Thu, 08 Feb 2024 11:28:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rY1dn-000H0S-2w;
	Thu, 08 Feb 2024 11:28:23 +0100
Date: Thu, 8 Feb 2024 11:28:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Moritz Fischer <mdf@kernel.org>, 
	kernel@pengutronix.de, Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v3 01/32] fpga: ice40-spi: Follow renaming of SPI
 "master" to "controller"
Message-ID: <2ofekkoan42mm2v3uf6dc2mjlrzjekjc2k6iaoucrus3yy3e3p@vaco3ina7ohz>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
 <6a3ddedc955cf55dddbc68ccf5ff5e46af5e8b6f.1707324793.git.u.kleine-koenig@pengutronix.de>
 <20240208100909.00000432@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v2poqeekbi3ytyuk"
Content-Disposition: inline
In-Reply-To: <20240208100909.00000432@Huawei.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--v2poqeekbi3ytyuk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 10:09:09AM +0000, Jonathan Cameron wrote:
> On Wed, 7 Feb 2024 19:40:15 +0100
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> > some functions and struct members were renamed. To not break all drivers
> > compatibility macros were provided.
> >=20
> > To be able to remove these compatibility macros push the renaming into
> > this driver.
> >=20
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Looks like b4 or similar got carried away. I've no objection to any of th=
ese
> but the ack was only really meant to be for the IIO one.

Ah, indeed. b4 interpreted your ack as applying to the whole series
because it was given in reply to the cover letter.

If you're indifferent here (and want to improve your ack count :-) I'd
keep it as is. I'd expect that Mark will apply the series, if there
appears a need for a v4 I can drop your Acks again.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--v2poqeekbi3ytyuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXErMcACgkQj4D7WH0S
/k4Hogf9HLrGzV4g1B8aJCI/9VGhK81OKO7hhvB6XIncH9JZ4umzZkTEG/qmc4oC
idSEZBxlITL4Xli3P7aiVeS+FWWM1RzqGh71M8+2421qIkZtRHSy7MFJVRhaCfd7
S6OkFS2ZgB1LuUrntbY5ORA246YA8FArHBQRN2eg5D8CmWNIbOLBMPDiP2hTH8vj
nVc8rmKmWZaNSFaZKtBWfYHB6A9NVXFtwR1fZxis0mymW9JYFD8k0JK/wKL1U55t
GdJAXY7z5Cu3TkXd4upzYjfwHgAK2CNjU6SYsLBU6UI4QK/p2rXfxSrukT9bcPxG
Y87G0/T7crT1mVOtuMtz+igZN/fzNA==
=XutH
-----END PGP SIGNATURE-----

--v2poqeekbi3ytyuk--


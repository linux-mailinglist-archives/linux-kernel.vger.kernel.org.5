Return-Path: <linux-kernel+bounces-122869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E67588FEB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5F72935FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA1C7EEF6;
	Thu, 28 Mar 2024 12:10:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED005474B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627854; cv=none; b=gyHdBs4ffLYjnN+6IzlKsQfjTxX3OwE6Hnn5iPWCl+o4+EbDgOKIU67LungrXvcziT5sIlTdP9yxYeOtUzrrfFEMqVVBjGaADXGx5O2r9VNAskRpDVIN46/N2u1WgxULkofFQdS8axw7v6BT/gPwn7C+68mYoP4ww8/UftF86dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627854; c=relaxed/simple;
	bh=XLR5seFyaOZ89hdv/Ug8D4XWdLSyEghesi9PWjNcV6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZ0056mjwogczEW5ZoD8Hzhrc0kiF/tkqAtchWIClvg2LWYKrbgj0LvFvgXIZrPRNGnYwRYrzek37vIzivwmkah3ad15kp7LS9CDRYfYrYFffP2idN5vrZLbJr+nSng0+/x/Z/c+ENKVAIqHd5k/4stDM6+wyK1xHIRduOXgcTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rpoam-0003cy-1q; Thu, 28 Mar 2024 13:10:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rpoal-008zxt-FO; Thu, 28 Mar 2024 13:10:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rpoal-00CxMb-1I;
	Thu, 28 Mar 2024 13:10:47 +0100
Date: Thu, 28 Mar 2024 13:10:47 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: add missing kernel-doc for pwm_chip:cdev
Message-ID: <3xqcgvyz2dunxxnmstt63d3v235r3cfh6ddsajrnogpw4zvy7b@w7tzawgexthc>
References: <20240328045515.15874-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vl5k7ifaxjvijgw2"
Content-Disposition: inline
In-Reply-To: <20240328045515.15874-1-rdunlap@infradead.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--vl5k7ifaxjvijgw2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Randy,

On Wed, Mar 27, 2024 at 09:55:13PM -0700, Randy Dunlap wrote:
> Add a kernel-doc description of @cdev to prevent a build warning:
>=20
> include/linux/pwm.h:308: warning: Function parameter or struct member 'cd=
ev' not described in 'pwm_chip'
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for the fix, I applied it to my for-next branch at
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vl5k7ifaxjvijgw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYFXkYACgkQj4D7WH0S
/k6cKQf/RspDnaB8B793IIf5VGeniUSJQJ6Y+ZbSnl7Nd5F8rpMpZ+V2dNkJ02eA
sO64DEi9sdjm/xhiJh1qyZgJi4cmuHwl5SmZCOlQi4gVTtGXMydMUW8gL4MtsUiR
ZS3KXz57oDWs6ZPRz2cAUwfut/b1Qs/9R9qOnb2JM/KFrYFxlQgtwxaXga1wweFB
TJL7hElzajXZygks1pq7LNocMhvtdRz4hUBGjBekqLyLFXTLkY6TP2m0vep5UHJC
U9irHFFFh5y0a2yhoQDEwqG2AYsLa3uFPEMC/GjKM85sUngv6O1C1QrCA4D2FRnT
Adj9LPGcE8BWs4zr8UHUBElzBILs8g==
=0Tli
-----END PGP SIGNATURE-----

--vl5k7ifaxjvijgw2--


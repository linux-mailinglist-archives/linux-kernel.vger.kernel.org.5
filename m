Return-Path: <linux-kernel+bounces-161566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FFC8B4DCE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22A11F2109E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC458F5B;
	Sun, 28 Apr 2024 20:55:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EE717D2
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714337744; cv=none; b=e8KQWaJzxrRZfCBWSWGkQrIcOGcKymGZ1u2mmrEQQ3+0yEHEu3tfgi5bM/Ticnjz7p+DxVTovSKKHEs3wpHl6h1k/Ojy93oha/ngDE3DmFBQBGelTDYWjC9kxYYezBwtYoSA1v9qvxJNH10DuSZeZcqZ1r7qnh4a0Zblajembbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714337744; c=relaxed/simple;
	bh=CsQNCy2tJeC9QwysZIqCB9fAoeUUMB7m7cmqQW8o/nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdwGopJ9I7tntDooBo5c26Aieow5TLExYtLoYxH39THZ0b908CPHPTbPdbo9N+X+wF3OZag7BUi6FoyCS0ykLn9FxwlxqxGo9qcLHZm3wflui1tvZfeEv+DoWRh4kL0wDGbW58DR8sRHM1a49046aELFLs1gUsZFFNQnfQJwONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1BYW-0005hp-Dj; Sun, 28 Apr 2024 22:55:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1BYT-00ErFk-3y; Sun, 28 Apr 2024 22:55:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1BYT-00B0xP-05;
	Sun, 28 Apr 2024 22:55:25 +0200
Date: Sun, 28 Apr 2024 22:55:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: George Stark <gnstark@salutedevices.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, thierry.reding@gmail.com, hkallweit1@gmail.com, 
	linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@salutedevices.com
Subject: Re: [PATCH v3 0/3] meson pwm small fixes
Message-ID: <5xyqm5qvidgx5iluewlrctcpmokvwwgwfw3nulow53yydycyi3@edbe7544qsel>
References: <20240425171253.2752877-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6jamwu7skoxjxq2a"
Content-Disposition: inline
In-Reply-To: <20240425171253.2752877-1-gnstark@salutedevices.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--6jamwu7skoxjxq2a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Apr 25, 2024 at 08:12:50PM +0300, George Stark wrote:
> Just some small fixes for meson pwm.

Applied the series to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6jamwu7skoxjxq2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYut7sACgkQj4D7WH0S
/k7Ukgf/beah6hAPqjbTYMo/Qb+qQXf8dkWEnrst2EjJ9QdJ+S5+X3UVU+nFy1QK
hEqkffXS83j7lsQjOd6ULf6p/hN4VA2xOGJGaiZkeTXr+evFWp87S4ZfZJNUCbAx
6QCKgth1K/uH4B185V0r21dRxP2D2d5UuWycbJTEA5MIQBKJjVmIbpnLTq0hs6LN
Ie8MvIhaDcBJSv2y6RTnlwn10vKalSiAcBLhE6QdZ9MM72vE1F1v5aQBZ9VFj98s
d3nfw/7wUi94Z+hdh89DezUgRWdMHHiu1molc4Wn2BuHHcUQKCxcpeQh0aqSS9Tf
qRCgiXwrtQ53EsBTeLZynJZHx3CrYw==
=LWsI
-----END PGP SIGNATURE-----

--6jamwu7skoxjxq2a--


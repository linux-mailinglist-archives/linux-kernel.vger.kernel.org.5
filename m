Return-Path: <linux-kernel+bounces-151179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BC58AAAAE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92732820FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D646869DF4;
	Fri, 19 Apr 2024 08:39:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825064CE1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515966; cv=none; b=gHYqxy2n6p6Ti7ZnVfk7aPixPyz2WYQZeN60J6nvxfsJS5YOhxVp2hhbgKo3UqP5mVzQ6PepW0FCJSKvpbyaaMwzGPnFfIbx3+lwekAAaEUoHvtqF5Bk4lPyh3onLAMRRZqgL6I+PghXgMI6+6sH566sUH5lE8YZHNwY226V1SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515966; c=relaxed/simple;
	bh=4XnsuJ+dGb5Zs4AdzTAoqjEZYVqS+mTAQPGsKqUxtnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmFZchymbh6jMHOnX1vQU4wZzVwWBOloT79uVZtGiOKblwO0Ty97wBwZhgyXR98ir0EAmQAq2FX/pMYaursDw8ESgYmXVDaYE1bAbCxbL30LcEVPtiNyiugeppOfIP7DbDnhP/zSo42y4BYQYGA6eSvbW1JwOUYCbyl0gzH57Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rxjmF-0007E5-Hs; Fri, 19 Apr 2024 10:39:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rxjmE-00D7k8-60; Fri, 19 Apr 2024 10:39:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rxjmE-003wvy-0L;
	Fri, 19 Apr 2024 10:39:22 +0200
Date: Fri, 19 Apr 2024 10:39:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: William Qiu <william.qiu@starfivetech.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Hal Feng <hal.feng@starfivetech.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v11] pwm: opencores: Add PWM driver support
Message-ID: <n26xpd2plbmrv6oppad4uuz3itm4iw2kro4lnuc33y3prgdxdu@3ldylfkrgsde>
References: <20240223084332.100410-1-william.qiu@starfivetech.com>
 <ys5z3v7rmrjlwttwymhjlxtx36gnuvrbj7q3hdcczdb4t6y2m2@lz2bniiaaxe4>
 <ZQ2PR01MB1257DF97FF7B08FFB0DA62EB9F0DA@ZQ2PR01MB1257.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sfupm2fde2h6433u"
Content-Disposition: inline
In-Reply-To: <ZQ2PR01MB1257DF97FF7B08FFB0DA62EB9F0DA@ZQ2PR01MB1257.CHNPR01.prod.partner.outlook.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--sfupm2fde2h6433u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello William,

On Fri, Apr 19, 2024 at 08:10:18AM +0000, William Qiu wrote:
> Sorry for late reply.

I didn't hold my breath. And if there are no questions on your side (or
on mine that you want to answer), I don't expect an answer. Just sending
out a new revision when you find the time to do that is fine. No need
for excuses. (And compared to the time I needed to review your patch,
you're super fast :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sfupm2fde2h6433u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYiLbkACgkQj4D7WH0S
/k4Ibwf8C38+bcoe6HWOQR3r2XiPp1EnDI1B0Nzanik57MOmhvqblWj8/ALIYTO6
GoFoRbMHfFItW+4G/VNcq3PYBg3Z3UArwWQKF8ZAiqO2VuLOaVXMW/FvP8/ycPE+
kTrH1nqvWkcUbRV9KLNvCyiuBP8SToTijgfI4fQ9K7xdGVneDZnI9BudScaLjBxh
XZz74XZqpZk0daBIKhqJazp8fKZYMcCM+RcNU51+aCHQ8aUBgzcmn1s71r7KcRVV
Pk7rx13KUJEXqOvF7mbDrEwvqX4QA5/BL9fN8DXK6rf4QvZYJbba/c25jrgXbbCI
beKWS+3+Ki07eIrKqAkR/oHeh9MbkA==
=uP4N
-----END PGP SIGNATURE-----

--sfupm2fde2h6433u--


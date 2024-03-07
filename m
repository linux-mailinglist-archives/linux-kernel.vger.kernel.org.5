Return-Path: <linux-kernel+bounces-95869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DD1875454
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2E0B21A67
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE1112FB12;
	Thu,  7 Mar 2024 16:40:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9127F161
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829640; cv=none; b=hTKQrAAcAJRC/OOonQyuuhyUC7dH0Iddb0earOTl6zOhMjs4c5WTiLmjvBJLHvgT+O6kor5Wx29h70gtbasRbz/zokmbd/zBMSSmHz5QDV4Dg8yaX8GIN441H+Xe8ag9CEJMbi5VMZ6Bax65Brr05PzkqVjAXfeofDYBXgKvosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829640; c=relaxed/simple;
	bh=85afv4fwZvz7kwtjHMW4+wG6IXdKQx2WJymI1LtZ95M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeFXNRsBTmbBSsaDYhYH4na3XhDcZdLo3QksGAOP2sxpA1U4bx2KyzGyj3NPC/pPz4IlzAxfU907F5xTInlsH5xvL+dPOEfGd9NUaIV18QIPeYm7maSTVgC3Oom+mshMZEZoTpZFSbJzDxH2+MWyliRfTSJDwTbQeyjC7itO4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riGnM-0004G0-EG; Thu, 07 Mar 2024 17:40:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riGnL-004ygO-NE; Thu, 07 Mar 2024 17:40:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riGnL-001Oou-22;
	Thu, 07 Mar 2024 17:40:35 +0100
Date: Thu, 7 Mar 2024 17:40:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v1 2/5] w1: gpio: Switch to use dev_err_probe()
Message-ID: <xehvtxn2fvrhw5q4nub724p3msz2yde2b35h4uvgqpm6fghwg7@hfp67fqkpzm4>
References: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
 <20240307143644.3787260-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kq7pfo2nnazt77bw"
Content-Disposition: inline
In-Reply-To: <20240307143644.3787260-3-andriy.shevchenko@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--kq7pfo2nnazt77bw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 04:35:48PM +0200, Andy Shevchenko wrote:
> Switch to use dev_err_probe() to simplify the error path and
> unify a message template.

This also has the upside that the error code is included in the message
and EPROBE_DEFER is correctly handled.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kq7pfo2nnazt77bw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXp7gIACgkQj4D7WH0S
/k7bHAgAmzM3lNIoqv1l0p4cDU8R2PiqjeqAZZ6Oub/Wmak4zlZ2zSm8x2uwni3V
158/vM5DhD2x+/ohryUJah79OCFNokZtx6X96qhbs1BS+aydapPJrO+1d/HYLQtS
ANLg8pSW1iwgb2jqVnYsEWS5n46vgZ/Ao+ithfF0GjwGaJQDYFW+gCSlRFUo1e0L
MiiDZOw+Q5mP/v07vckHpzyFYJ5sE3Zzyb9YHPQqAhsiKFbH+6NWu1BH+JjqtWNX
Mgm6Rm4+5dkX9iL0ZeA4LwAfK1xULolzzhPHnaWG0A3GRDNpNpdAX/y2WhPK6wMw
l28JxBzCwFlcJIeoGkgbaF8a1tq/2Q==
=9yAw
-----END PGP SIGNATURE-----

--kq7pfo2nnazt77bw--


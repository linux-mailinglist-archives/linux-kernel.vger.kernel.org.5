Return-Path: <linux-kernel+bounces-126462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A30C893857
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F84281986
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90A18F6F;
	Mon,  1 Apr 2024 06:24:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200EF8F4E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711952675; cv=none; b=DLUpOYzGB1z+AN40AlMCm9ljJZqHq5JW6amFC/lIFTwDIywxZ1qnj5QJUUNZmw7vj85wPqhK1xVBs1860m3iUArT393M6BSM+bIaTlJTu0l0XC+cZNfdDLt4CZFK13mrdW/0LhG12fGnDvu7MddCfYAxYMSkJtFvTZtVMaIjWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711952675; c=relaxed/simple;
	bh=tNXqN5M71+tjw6FpcPPDIY/Rszo4GvwiHe9uN7gj2b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljkk7/vpozuZK0Ub7UKPSvFh7wX5bkWJQEec7bc9tM2OWqVw/KpP8UigD1EUrEBPFVpP0lQTuQbjEZXQs0OjFQS0bzuH8Vic39OWxKIfKcfjQS1lMp4fuEQXQdibEd5zDhU1aSLktY3sTJ+qusDvCOHjS07rGvBAeevUsMU8Tk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rrB5a-0000GP-Mi; Mon, 01 Apr 2024 08:24:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rrB5Z-009k0b-D4; Mon, 01 Apr 2024 08:24:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rrB5Z-00Dx64-0z;
	Mon, 01 Apr 2024 08:24:13 +0200
Date: Mon, 1 Apr 2024 08:24:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: llvm@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] surface3_power: avoid format string truncation
 warning
Message-ID: <yiqdxzxtcw4dpths24sl4x2qwmuf2bj5lnayd3pclk5zf4h3mm@oc4l3ojar2i4>
References: <20240326223825.4084412-1-arnd@kernel.org>
 <20240326223825.4084412-6-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v26yt34kxi4ilpyq"
Content-Disposition: inline
In-Reply-To: <20240326223825.4084412-6-arnd@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--v26yt34kxi4ilpyq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

just a nitpick:

On Tue, Mar 26, 2024 at 11:38:04PM +0100, Arnd Bergmann wrote:
> Change the format string two print two less bytes so it always fits. The =
string

s/two/to/

> is still truncated, so there is no change in behavior, but the compiler no
> longer warns about it.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--v26yt34kxi4ilpyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYKUwwACgkQj4D7WH0S
/k69qwgAo8++BQ8OE5ajtNU6wrlQxb07HGXRy3w/Nb7iL0ELQ6yDY51J7dRFylDo
/hmKPWn6X+ybKlK1W1VXlA1Qm+UbMHaj3KhHMUR9rFAC2r1SLzxJ1DpP0zdXe1Qw
h/rErFvH2tgtF/C9ZeNNWputJhMsSlTkJJUJYACkEb8hdEDDbv/wB0y/wBsl3uBi
KFdxlCFmr54MtZbQ+khq31iVIrmbAqHKL8VAVPiiuB16I0OJwsOzL5C0mr/w1t6F
C2Ijqcy2kHwcdzzNQYRwAJR48nwZNc6Vp3G2jD2FlhuptBMngX1RrFpUeYkAgjbt
04h9y2wTPfVkwMUViYBW/huM0Fgi+g==
=VQ95
-----END PGP SIGNATURE-----

--v26yt34kxi4ilpyq--


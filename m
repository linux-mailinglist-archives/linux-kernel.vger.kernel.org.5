Return-Path: <linux-kernel+bounces-44047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBB4841C98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4431F245DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB5353805;
	Tue, 30 Jan 2024 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ifDWtsGR"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FA7524CC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706599871; cv=none; b=ILDl6PlNoXnVeOrUban1tAzkllNco1CWDSeNGCrMEsMUxC1/xtVCz17UBhnBkFZPKNJLPH2C5p7pg5ypVyA4ocERHPc2RRryjyAOfyKtKQJ6kV9D826BdvotHzQ6NiKV1HpTd6HwUQfuUD7QiZmXP7FPIkzmiYnsQmnjEbPTv58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706599871; c=relaxed/simple;
	bh=+AboSCxXz2/lxMmny6wb2Q4v9oABMrH5i1uxlA1QTz0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJ3S9j1Pl+UYlr6YBTVlztt9wjcl5DtBIGa91DKPTMYFFNfA1m5ol+Rzic27GNnvxHNh/Gvl+Lj23EufaYSYDfzPwqFdOGqt9+/aQ5QmmzKYCx/be/ZeCvwQuo0pIUdngTWbr/O5dGMhSWI2EyOKnsLo2aCsi9FCOaQSGB0+7Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ifDWtsGR; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=YAlE
	6Y6T9E3XlAqyeFE3riY9S6rXQeiWA0mk6RgZ6t8=; b=ifDWtsGRUqC4rAPmAvDT
	pMZ5tPbbHfn6H4dGutoC9LVvZ4mvYw8L+pAMTu7+P1PgH7VHlfC9sjMBOFIHOcCB
	ZO/5MlBTnDfBEz3eLm3WxqZPagHQCnJl12ss+OTw00X279lPtIx89x/DozgLPC+u
	E+k/6IymLjAUM7Q2FckZ44famzqGHK2Rh0/l+dLY65+/g4fnT8ul+mtRhGjHyFpM
	0blfuYGR4NfV3WlTA6l5WkfKOVpitKRDBiWLUHszAIja6dqLV029vnBAbQKbpbdM
	Orx2ztzM4KsjkN3uT99K43REvoDNmu3wllnR5nsM6v47oY0Zp1sIZl8CenOW0Atz
	fA==
Received: (qmail 2745126 invoked from network); 30 Jan 2024 08:31:07 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Jan 2024 08:31:07 +0100
X-UD-Smtp-Session: l3s3148p1@finiviQQzpRehhtJ
Date: Tue, 30 Jan 2024 08:31:07 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>, ulf.hansson@linaro.org,
	takeshi.saito.xv@renesas.com, masaharu.hayakawa.ry@renesas.com,
	yoshihiro.shimoda.uh@renesas.com, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: Fix change point of data handling
Message-ID: <Zbilu9u9Z3MeeOb9@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	claudiu beznea <claudiu.beznea@tuxon.dev>, ulf.hansson@linaro.org,
	takeshi.saito.xv@renesas.com, masaharu.hayakawa.ry@renesas.com,
	yoshihiro.shimoda.uh@renesas.com, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240117110646.1317843-1-claudiu.beznea.uj@bp.renesas.com>
 <ZbeEPg1jc5qWJa5m@ninjato>
 <345bc392-cf28-479a-9453-5bc89f635759@tuxon.dev>
 <ZbikovLbujyGS1ub@ninjato>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GQRaf8k/U09nYrq6"
Content-Disposition: inline
In-Reply-To: <ZbikovLbujyGS1ub@ninjato>


--GQRaf8k/U09nYrq6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> But isn't it equal to the current code then? (Except for one thing: the
> smpcmp bit is only set when there is no cmd error. I need to double
> check but I think I like that.)

I double checked, I really like it. I'd just invert the logic. Pseudo
code:

if (!cmd_error)
	if (SMPCMP == 0) set_bit
else
	mmc_abort_tuning()



--GQRaf8k/U09nYrq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmW4pbsACgkQFA3kzBSg
KbZIbQ//Y36zPSqNnCfwh8mVJf6212a3SsOGiuFkR6GYcAlchDw2ofadF0ts7fL8
H7CNwSQ/13NSNE7BD/jRdzszu5Q+FUAha7+R/MJccwR5Z+an0b2AhC98geyGkm3+
LJWPMx+8YflXxxkJgy2DvkIK+dTHc5rX1sT/8hCtFqAsWs98QAPt6l+1tk65bM7e
QY10mKytTr9qetUbw/60NnlIuU43jMizHaa7/dvh0vob67qA5BDF+WDBPpUUOz/p
T96t2EvqB10E7oOX3n75ZUnXY+j4zTnUohdPlXuc34HmoFf/eGeNNYOmdj7gNhIN
EqkfFNTZt9ZtqntVkEuWV8kwDUjhxhWDjSAsUuLEvzP80cHJiys1Orj1StOzT34X
dSosnhGFNSnTogkkKaJ8L3c/xBFSwfS9IxsAa+4BPev9ABcilA/v2ibkfUqyzQcm
TNyYg3N9EuwHjNe2r2bMDmbFVy9KNdqjiw1YPNOC5kF6s33CAJfAWUWcXcsPjYJk
/ui/GRp6kiIJuAz9JQ7g3V3ziQZOaWtJd7dL3yB7RgGNL5lt1y9gHLrZD16m9/67
qnz9qj8Mg3Q/aSP8+vLRVSkcfrC5Y8eWkuPm8e5dlI9TennnMrKw49EwmuQPXUDX
oudYdpBPDLXLigpAMq0ASDLg9oHhpG2KarT+Z4PLO+yDrhT7404=
=CXPW
-----END PGP SIGNATURE-----

--GQRaf8k/U09nYrq6--


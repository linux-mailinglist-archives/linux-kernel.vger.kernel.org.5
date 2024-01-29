Return-Path: <linux-kernel+bounces-42558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C68840316
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826341C22456
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C9E57333;
	Mon, 29 Jan 2024 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="QS7bErN7"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9FB56745
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525026; cv=none; b=ZiS/overWoDuMeSq/yDyTiTB07mgBycUdhMT1hNKsU7AEXpcw5pxyK4cTv3JkZsPrF9KJhqSXc62XZPFjgww0DIkdsp++HxefZmoLSqol73s8yRnH/mER0hlqq7VaM3gD8UntLqjsle6zW5I5jva+O7Ju+yVB2X58tvX79u8q1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525026; c=relaxed/simple;
	bh=urJNpwubWdQrkLQ1QkSs6oez9caTULYOmdMIAy6qU/U=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9r1LXIRhTYmgYPmsnTKYZR6AKMyxzwJ5c3HeIPARPHV3dJY9/dvA8DtMXCcBBglOgsRkjiwKV/t4KVhTWAujBAk2Rr8phTQ7bAK2GUdSlUVlBk83pEWjdaDYzTcvl8do18SEmonBm/7tk86LPQrXRftvYSJM7CKlJK6WC4k9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=QS7bErN7; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=urJN
	pwubWdQrkLQ1QkSs6oez9caTULYOmdMIAy6qU/U=; b=QS7bErN7x4W2qxqi2Dw5
	PaTiJy53fDP/GIt8YLB1ZolJlggEiz7dIAyYWiLJ4VgEM8WdhP5oUmtE2mha5uAD
	fOANWrTbJP9J8IwAJ3yP3qkGzeCH5x/KjVpTvlpN8Gm1Y6Sm/FWMX1uO0YtPt9mq
	gAQ2jbLc+F+eDRZNcHHCOlco3OGO0SOqxzoveS/QYrxGXPXg0DDgVrbVnkRiNdyC
	66c12fz3gTgMzWHB/B3fAwbSm/3YPA1XvFe9339wO9Kb81+hI8DQMadQa38gMA9T
	O2MiR3YdHK30sqNZxo0K4o/nZ+sPfgPmTrYcRIOqdgmLcfHK//qE/4Wx8x+t4fmx
	aw==
Received: (qmail 2444091 invoked from network); 29 Jan 2024 11:43:33 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jan 2024 11:43:33 +0100
X-UD-Smtp-Session: l3s3148p1@Mjo3URMQcsBehhtJ
Date: Mon, 29 Jan 2024 11:43:32 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu <claudiu.beznea@tuxon.dev>, ulf.hansson@linaro.org,
	takeshi.saito.xv@renesas.com, masaharu.hayakawa.ry@renesas.com,
	yoshihiro.shimoda.uh@renesas.com, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: Fix change point of data handling
Message-ID: <ZbeBVL1iXwxMbV_p@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Claudiu <claudiu.beznea@tuxon.dev>, ulf.hansson@linaro.org,
	takeshi.saito.xv@renesas.com, masaharu.hayakawa.ry@renesas.com,
	yoshihiro.shimoda.uh@renesas.com, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240117110646.1317843-1-claudiu.beznea.uj@bp.renesas.com>
 <Zafe4do1sMVaV3rh@ninjato>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KFHA1xXecfN7YDwG"
Content-Disposition: inline
In-Reply-To: <Zafe4do1sMVaV3rh@ninjato>


--KFHA1xXecfN7YDwG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Very interesting patch! Please give me a few days to review/test it.

I am still at it. I got some objections from Renesas and am trying to
figure out more details.


--KFHA1xXecfN7YDwG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmW3gVQACgkQFA3kzBSg
KbbKkQ//TF1rx/cTwUWGdezATmCRCPZDLkoR4+u+5i2aYCshZlVsfm7i3XaY5O/6
cOlkvTvO67erNhKZAMSE95/yENwez+wGVqNNxIE8Ixe1ihSicPlFo5FwHaDeTIy9
x1C21Bzf0LE4dbs/PIlkp1eQsNChSqPeVSFcJLbg3+boTXC/bKrJyJkKsUYotMYn
4Rh1w9i9YVf9gfFlyvdH4wMbpOi9507VTJb5QH/c95VNJS42QbPULOX57UtuR536
sl2dv0bzo7Xl+qtDBzL0QweaG1Hwn0Qllu9lJhAPsETyx0JDzKKTeOSKkRo7b5QZ
68HLwMgOLGmNLOaVcBDHBy9w6oZeasOE3gs5bHPF3TnosZAh+4dtWCF/DnyhZdEm
Rx8Dbhz/F5+lmRBll2KtpjOqAtGSBDoCL0voWnjiWC3XC2Lae9INLBSi+vpNrIA9
tMgu5PodcRGH0jrUjlTUj24NcFfQq7FxSBq9l2A8gMoAJbV1DuZWHUInfnBAwjka
1HatuZRHRkZB5JVt7IPpnKQvcADWO+991ns55zqD75Z0+c34WVlG5Ne2XBjD70l1
yo2xBBOHZZtRenmxdAqn3fCDR03cWvPfl88u+RJZoQozP5M2t5asCmhe6w4g26Sl
PD8J8SNX71tmpadhINvSztKO7mRGmL73UupGWB1TeXYY/qrSvLg=
=/L2/
-----END PGP SIGNATURE-----

--KFHA1xXecfN7YDwG--


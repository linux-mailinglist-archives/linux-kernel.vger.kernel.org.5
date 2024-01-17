Return-Path: <linux-kernel+bounces-29045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8B383078E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551B31C214C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE0120327;
	Wed, 17 Jan 2024 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OhgLN0kj"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9707F2030E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500389; cv=none; b=Twm3IlgI2JvcrndLoVOENLZxEHFTCOL1HQuPUIvV4t9/tdARrdY94fLYqZoyeTxnvSDfXcyfxaHcBVwRUOcz34cxga0yLryVJKYn4tBzmqyfrnRiPjr1a6G0cb7NTiSWmdFgpldAcifrQTf8MqcvVdc0QXHkLHYnsUqxL24XDUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500389; c=relaxed/simple;
	bh=PTHnESe9ESqNEunWVFmNfZH+FSFfQXuYiifMq02P0lU=;
	h=DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:From:To:
	 Cc:Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9QtekfkjxyNZeVZHKZ/WodAgIPIsZ9mc7rQN3R4llzTUn2EZ+IqPaxXnVEYqrXGoLs52TsCxNNDf/ZtTXjY0Ewu8w2OsqILBSPdmgxu34CSrPWw7cEii38TVxrEfYjpL+F3L/liWHHXj+zUK5AiE6DB8V9ScRfxSMw39IQMNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=OhgLN0kj; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=PTHn
	ESe9ESqNEunWVFmNfZH+FSFfQXuYiifMq02P0lU=; b=OhgLN0kj0hggsnUXH9Z5
	5OFqwSqKMEFsi0HD5vB7WciPWsW6xHDayCrIXdIVaPZuWitUnM2AQ6LJ37XSI+0r
	p5FIPuDDOOcgPg8MSPrzuvYgF7jAut0ovUaWOdryRmn9M2LssGfn+oX1y0KFbrBh
	HyZwS0NwH88czRpvQp381nytA2P5o5XH2Vd9vJf4f6JH/3XR/7mCm3H1RFj9nS07
	OaeuV0kc1t4sRovEC+jBZEMFnxsothywETAz9HWGZEPTZdqmVJE0X29AYDXiQUL/
	co9GkMh8cqKeEnN+NCxAhdmhzmQ1fGvlGOOtj+mOlY7MAML1YkeMG2CF8PhE44Y1
	1w==
Received: (qmail 2768604 invoked from network); 17 Jan 2024 15:06:25 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jan 2024 15:06:25 +0100
X-UD-Smtp-Session: l3s3148p1@oo6hwCQPZNBehhtJ
Date: Wed, 17 Jan 2024 15:06:25 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: ulf.hansson@linaro.org, takeshi.saito.xv@renesas.com,
	masaharu.hayakawa.ry@renesas.com, yoshihiro.shimoda.uh@renesas.com,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: Fix change point of data handling
Message-ID: <Zafe4do1sMVaV3rh@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Claudiu <claudiu.beznea@tuxon.dev>, ulf.hansson@linaro.org,
	takeshi.saito.xv@renesas.com, masaharu.hayakawa.ry@renesas.com,
	yoshihiro.shimoda.uh@renesas.com, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240117110646.1317843-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9kRSAflqCj+rMp96"
Content-Disposition: inline
In-Reply-To: <20240117110646.1317843-1-claudiu.beznea.uj@bp.renesas.com>


--9kRSAflqCj+rMp96
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 01:06:46PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> On latest kernel revisions it has been noticed (on a RZ/G3S system) that
> when booting Linux and root file system is on eMMC, at some point in
> the booting process, when the systemd applications are started, the
> "mmc0: tuning execution failed: -5" message is displayed on console.
> On kernel v6.7-rc5 this is reproducible in 90% of the boots. This was
> missing on the same system with kernel v6.5.0-rc1. It was also noticed on
> kernel revisions v6.6-rcX on a RZ/G2UL based system but not on the kernel
> this fix is based on (v6.7-rc5).
>=20
> Investigating it on RZ/G3S lead to the conclusion that every time the iss=
ue
> is reproduced all the probed TAPs are OK. According to datasheet, when th=
is
> happens the change point of data need to be considered for tuning.
>=20
> Previous code considered the change point of data happens when the content
> of the SMPCMP register is zero. According to RZ/V2M hardware manual,
> chapter "Change Point of the Input Data" (as this is the most clear
> description that I've found about change point of the input data and all
> RZ hardware manual are similar on this chapter), at the time of tuning,
> data is captured by the previous and next TAPs and the result is stored in
> the SMPCMP register (previous TAP in bits 22..16, next TAP in bits 7..0).
> If there is a mismatch b/w the previous and the next TAPs, it indicates
> that there is a change point of the input data.
>=20
> To comply with this, the code checks if this mismatch is present and
> updates the priv->smpcmp mask.
>=20
> This change has been checked on the devices with the following DTSes by
> doing 50 consecutive reboots and checking for the tuning failure message:
> - r9a08g045s33-smarc.dts
> - r8a7742-iwg21d-q7.dts
> - r8a7743-iwg20d-q7.dts
> - r8a7744-iwg20d-q7.dts
> - r8a7745-iwg22d-sodimm.dts
> - r8a77470-iwg23s-sbc.dts
> - r8a774a1-hihope-rzg2m-ex.dts
> - r8a774b1-hihope-rzg2n-ex.dts
> - r8a774c0-ek874.dts
> - r8a774e1-hihope-rzg2h-ex.dts
> - r9a07g043u11-smarc-rzg2ul.dts
> - r9a07g044c2-smarc-rzg2lc.dts
> - r9a07g044l2-smarc-rzg2l.dts
> - r9a07g054l2-smarc-rzv2l.dts
>=20
> On r8a774a1-hihope-rzg2m-ex, even though the hardware manual doesn't say
> anything special about it in the "Change Point of the Input Data" chapter
> or SMPCMP register description, it has been noticed that although all TAPs
> probed in the tuning process are OK the SMPCMP is zero. For this updated
> the renesas_sdhi_select_tuning() function to use priv->taps in case all
> TAPs are OK.
>=20
> Fixes: 5fb6bf51f6d1 ("mmc: renesas_sdhi: improve TAP selection if all TAP=
s are good")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Very interesting patch! Please give me a few days to review/test it.


--9kRSAflqCj+rMp96
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWn3t0ACgkQFA3kzBSg
KbZDtw//YCGJZH4XsO3R9K/PpKOha0LHIw0wMXNaPvunIqcGbzHimaxi8B0W9Tej
+ds0L2vV85p/x6V0cOY3YtjVjs8r8rrWuVUSTzfzsjzQx+LPQVIGzOf5hXsZWFTy
Qfyop9TvZAeW44/xUccJX9pye8D4bohXO9pN1IabKmm5bzvSkohJd63Pg1BmNCuw
CqOdl7j23LwQmmXw9yu7s1UOZ/9CRAzB0NqAwDyP849TbyFNUAVNCLTGSZXubWcf
wuze2er2pIPS8O+EPsHyVoqrsFDtwT4v3CUOg/71PPJLJh2PSg+dCZt13eanf2YJ
mVem6vAD3PBb37mB/xo2v7PXxobVvf55dTdABiPMijKUAOqip7qGh9kYs4ssyj8k
D5Neriju+g0QhJqf2b5+zTT+6XvBhFdgsKCua/rL7jeH80g6FLIlc4wccc9Xrm/u
xguV/l9oI7qQU8H3nwtitrKtDCVrALcGpMh0QA4YyLNSiJUiLxBeAx3SZ9sf6w6E
CKJcG0H6bOpjFC/XonVlGYsewTfpa49NOSe0pwY6os7eyN+hbv1IWzN793lgD+ts
qaTJBSnYDRcDxVQP6mIofmP6Emgv5BqhQtfYe6lLH6TqRUGsmABHvbW5ahshiDoV
AQ1fl7RDmYzTrZeetmwbvpJyO3fdzwOBw9qNRTlGF648N1rdJM8=
=BjW7
-----END PGP SIGNATURE-----

--9kRSAflqCj+rMp96--


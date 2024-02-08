Return-Path: <linux-kernel+bounces-57356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AF184D752
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58202B20ACD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F1A1CD19;
	Thu,  8 Feb 2024 00:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="MjOOxirL"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC5156CF
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353774; cv=none; b=bhfYBRNwr23pIwsnRdRbGHjS2Gqt9GDDN4ekrNj7EQ+dVhIHgh3U+vumqpmEUiI4M5p/k7CC6qrGukJHhksdvQert1uSB3PDZ+QcbKsMQeQbVxcQC1j+wKHanTI0ejxXpVNiin0wPyFaHcUzQvMhptTT6ocNLQe5gLQRIh8am7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353774; c=relaxed/simple;
	bh=Z2ICpOVItjLSZvYCOOuIUl8jQTYpEGryfXq5XQgGzxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qk+KjO7zSoDyJRG1NvW2g+DzRSODXALnEvwiLT2SxQ74e6To0UjLsjD1/sSWzsQglP7sr+FPZ4Xt4srxDiU4dJEpwU7Mv5PU96X/WUGzY18Bx4aCgWT0Z2gMRZhRIQjnI9HXIZ6ssAUUlBSnSHOuX79g8gqUjtBbKVF2p95mTiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MjOOxirL; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=mqwy
	z219YogV29u1ps30jsIFNgrWScVT17DNSwGPVi4=; b=MjOOxirLJzsd819/J/U1
	5GLpFRfogtw/xMcPwb/Eu6oHDPHUrWNfsioM8r3NKOeftKRjJ7THPgI1hqYkF47X
	p/vfujhgyNNJrmuw0V8EySjr7DzEOF3GeTXQs86BksvK6ThWAwG2VQ02Ct5rzKEO
	Qog60FdSM9T47XEZx1T0VrLVxbEXbrqHO3180UGVNWPU4dmqLQLMArpNGteDE/uT
	jlFO66Mjvv59135iaCndKQhjUBCRLsb6GD/KYi+A6Y4Tq8oJu0ZZioS+hiEvacvW
	+8pVn4DhLH6qNR7JU4LQcvG7DXqYAQtu5d3v57+U2n1TpENXmHw5ycXJmYcDnEmw
	Zw==
Received: (qmail 2159446 invoked from network); 8 Feb 2024 01:56:00 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Feb 2024 01:56:00 +0100
X-UD-Smtp-Session: l3s3148p1@ahxpRtQQ8uUujnsZ
Date: Thu, 8 Feb 2024 01:56:00 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: ulf.hansson@linaro.org, yoshihiro.shimoda.uh@renesas.com,
	masaharu.hayakawa.ry@renesas.com, takeshi.saito.xv@renesas.com,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3] mmc: renesas_sdhi: Fix change point of data handling
Message-ID: <ZcQmoEkv_1PVURrT@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	claudiu beznea <claudiu.beznea@tuxon.dev>, ulf.hansson@linaro.org,
	yoshihiro.shimoda.uh@renesas.com, masaharu.hayakawa.ry@renesas.com,
	takeshi.saito.xv@renesas.com, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240205112702.213050-1-claudiu.beznea.uj@bp.renesas.com>
 <ZcDdn2AVz8FIXzak@shikoro>
 <237bd5c8-184d-4e46-ba66-253e3ef0c895@tuxon.dev>
 <ZcD17mTRnfIaueAW@shikoro>
 <63e1eabd-a484-48ee-b8db-1e460bce70ab@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SUT9mnFBoIjH0mM+"
Content-Disposition: inline
In-Reply-To: <63e1eabd-a484-48ee-b8db-1e460bce70ab@tuxon.dev>


--SUT9mnFBoIjH0mM+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

I got more information about SMPCMP now. I had a misunderstanding there.
According to your patch description, you might have the same
misunderstanding? Let me quote again:

=3D=3D=3D
RZ hardware manual are similar on this chapter), at the time of tuning,
data is captured by the previous and next TAPs and the result is stored in
the SMPCMP register (previous TAP in bits 22..16, next TAP in bits 7..0).
=3D=3D=3D

It is not the previous and next TAP but the previous and next clock
cycle using the *same* TAP. And the bits in the register describe if
there was a mismatch in the data bits across these clock cycles.

So, we really want SMPCMP to be 0 because the data should be stable
across all three clock cycles of the same TAP.

> As of my understanding the TAP where cmpngu =3D 0x0e and cmpngd=3D0x0e is=
 not
> considered change point of the input data. For that to happen it would me=
an
> that cmpngu !=3D cmpngd.

I am not sure you can assume that cmpngu !=3D cmpngd is always true for a
change point. I'd think it is likely often the case. But always? I am
not convinced. But I am convinced that if SMPCMP is 0, this is a good
TAP because it was stable over these clock cycles.

> From this snapshot, datasheet and our discussions:
>=20
> i=3D0, cmpngu=3D00000000, cmpngd=3D00000000, smpcmp=3D00000000
> i=3D1, cmpngu=3D00000000, cmpngd=3D00000000, smpcmp=3D00000000
> i=3D2, cmpngu=3D0000000e, cmpngd=3D0000000e, smpcmp=3D000e000e
> i=3D3, cmpngu=3D00000000, cmpngd=3D00000000, smpcmp=3D00000000
> *i=3D4, cmpngu=3D00000000, cmpngd=3D00000002, smpcmp=3D00000002*
> *i=3D5, cmpngu=3D00000000, cmpngd=3D000000ff, smpcmp=3D000001ff*
> *i=3D6, cmpngu=3D000000ff, cmpngd=3D00000000, smpcmp=3D01ff0000*
> i=3D7, cmpngu=3D00000000, cmpngd=3D00000000, smpcmp=3D00000000
> i=3D8, cmpngu=3D00000000, cmpngd=3D00000000, smpcmp=3D00000000
> i=3D9, cmpngu=3D00000000, cmpngd=3D00000000, smpcmp=3D00000000
> i=3D10, cmpngu=3D00000000, cmpngd=3D00000000, smpcmp=3D00000000
> i=3D11, cmpngu=3D00000000, cmpngd=3D00000000, smpcmp=3D00000000
> *i=3D12, cmpngu=3D00000000, cmpngd=3D00000002, smpcmp=3D00000002*
> *i=3D13, cmpngu=3D00000000, cmpngd=3D000000ff, smpcmp=3D000001ff*
> *i=3D14, cmpngu=3D000000ff, cmpngd=3D00000000, smpcmp=3D01ff0000*
> i=3D15, cmpngu=3D00000000, cmpngd=3D00000000, smpcmp=3D00000000
>=20
> I understand that TAP4,5,6 are change point of the input data and
> TAP8,0,1,2,3 are candidates for being selected, TAP 1,2 being the best
> (please correct me if I'm wrong).

I agree that TAP4-6 are the change point. TAP2 could be a candidate. I
dunno why SMPCMP is non-zero at i =3D=3D 2, maybe some glitch due to noise
on the board?

I do really wonder why probing failed, though? TAP1 sounds like a good
choice as well. I mean we consider SMPCMP only if all TAPs are good. So,
if probing fails, that means that SMPCMP was non-zero all the time?

That being said, our code to select the best TAP from SMPCMP is really
not considering the change point :( It just picks the first one where
SMPCMP is 0. We are not checking where the change point is and try to be
as far away as possible.

> root@smarc-rzg3s:~# md5sum out test
> b053723af63801e665959d48cb7bd8e6  out
> b053723af63801e665959d48cb7bd8e6  test
>=20
> Do yo consider this enough?

Yes, if done 100 times ;)

I hope this mail was helpful?

Thanks and happy hacking,

   Wolfram


--SUT9mnFBoIjH0mM+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmXEJqAACgkQFA3kzBSg
KbbJjA//f78KW4RL6ZMw+SWo1hQv3MKE3O7tqm8UYY6OBFSWNNSyGE6BDnw3AyZJ
7DnskBvXLjlPWi1m+De/il+6vUUKQZ/xup1cCjQEYr4IpFOKYQQVH6g+K6l6FJVj
ZDoqi6pHocY2sPyURZebfOdz+ynuFzZXGqsnc8HLEiaX/Gy1vm8O8taO4L6zYfT4
RmSGP5nU3zm7C/BbreupPvPQpEMwHxQgMz4mtiC5MlaVqVI0Vc+fICUO2NlNjYpz
33cDVBfbmceVw6DqddPRPPPnAuSV21MhwoA6Cdvj/VzzXG2I+ZDZsBtPAPVDfY1H
G8rbyb3FUwhu+7mhNoNgA00vnP82M7GADMCQX3usElqNjxtbPB+2NrF99QOGTnQn
hC5lQdX6J56ZGllJaEG/M/xKKnZPhEpn9ISwxqUlUzsmzicEsGjIgpbtn4k6lg7Y
o4bHCDZQfFIP1rHOPjMUuGNTVt+7r9qC/Litwl1utiJ/u4vZEDfeDYIo7qVlg1Ly
kvtQw4n6YKQUd1sobcmHkC6IKfh2JyX+VxczgdTuqWQ41LizjtMFNdXH+IrZ485W
fw0mX9AsCSQHXdAIUgHrLJ7naKVIL6GPjsC2nBgTut0JpLnIxFvVQ1qrD/AmsHe5
cWSNYhh9wocFt9jZ22DtVF1evm6s7fgzACndkJVcCSuxk7JFG8s=
=BsWR
-----END PGP SIGNATURE-----

--SUT9mnFBoIjH0mM+--


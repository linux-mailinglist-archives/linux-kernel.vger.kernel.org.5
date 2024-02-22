Return-Path: <linux-kernel+bounces-77470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFC78605C0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0D51F2351A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9852817C62;
	Thu, 22 Feb 2024 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="WF7Tlhgq"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC7E17BD3;
	Thu, 22 Feb 2024 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708641291; cv=none; b=DsTbs9otnI7vxZqG0PMoUmE9q9tiVkNL0n35FbNWGUqTdvNxrkslT1J9P6aCkFngyUfApgzrChJ8idT0im+8wbbPAq9Xb2O5z4NU04dakWlY19TQ6yNl14GftKsSRwgFEfOnULdvUHdJdjh6ggEKYrTP2ErOgt4DdrRsgrUwFkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708641291; c=relaxed/simple;
	bh=sHCgtF+3SPVUxRXilxtOAXQwZv6bdi2czoWMEY1b8xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnLAzLZFNaQW68tCbg4ScivAgHSgV9YZFzDpnbgV/Hiteq9snjACCxscvrldqBkLgxCeKkIAu6vNSTt7nV4DFZxYdk+SdNhP058H+zCq0jykJ6uzD6/8ix6Im0sWlqy2mwyQ/TkQB4L480Wqd68SJ+K6BcNeEqwWpb4Vvi1Q9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=WF7Tlhgq; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F1FCC1C0080; Thu, 22 Feb 2024 23:34:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708641281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LpsuB9TJUe60e7DobCRvweAVDCZBM7llT4gPHrmAs30=;
	b=WF7Tlhgqoih+8UyMgfkJE7f8cOlIK1DgBnan+hrjn3Squh3b+tpnUL3JJ/D+EMVKc6XTmo
	84tYuWBl7eHD2LiRMie60piU8CJwLPa8DJzMDajpz8vr9qBVprExFbVf/5OhE6cwwutH5B
	kNGo69gHumBvFcN2+hjNfR52L4y0MRA=
Date: Thu, 22 Feb 2024 23:34:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"lee@kernel.org" <lee@kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux support for a 7 segment LED display
Message-ID: <ZdfMAP5Z7fiKHtSf@duo.ucw.cz>
References: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
 <Zde966nsJ76QOuzm@surfacebook.localdomain>
 <f5e74774-226a-4678-a6f9-b4f17250ad91@alliedtelesis.co.nz>
 <CAHp75Vfq3Pc+Eo3Z5mhORZwwuKF+Y7_47dTO8qARcfba4nmj2w@mail.gmail.com>
 <9d00e1b1-120b-4c2b-89c5-0ac736bf6441@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Is30zc1S1g2MwTET"
Content-Disposition: inline
In-Reply-To: <9d00e1b1-120b-4c2b-89c5-0ac736bf6441@alliedtelesis.co.nz>


--Is30zc1S1g2MwTET
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Cc: Geert and Krzysztof (for the comments on the idea above).
>=20
> Would the gpio-aggregator be necessary? I was thinking something like=20
> this in the devicetree
>=20
> \{
>  =A0=A0=A0 led-7seg {
>  =A0=A0=A0 =A0=A0=A0 compatible =3D "kingbright,sa36";

Please make it something like "generic,7-segment-on-gpio". I assume
there's a ton of similar display units.

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--Is30zc1S1g2MwTET
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdfMAAAKCRAw5/Bqldv6
8gviAJ9bicus69zkqeRgXipTgffjH4NNLACfcN7uXyctpLmp7AyiV2qi+wTDCAo=
=J9Cw
-----END PGP SIGNATURE-----

--Is30zc1S1g2MwTET--


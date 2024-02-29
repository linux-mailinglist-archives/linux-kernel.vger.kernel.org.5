Return-Path: <linux-kernel+bounces-86513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3659F86C664
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CEC1C2159C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1816350C;
	Thu, 29 Feb 2024 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="GfUKnAHt"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92067634FE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201204; cv=none; b=c3o+/axlnSm8jWRL+Pp4zy6Lh5ajah/s1Orp7jQThduHpPOffgJFqAU8EXMg/XE5/bWNBohIV57svt6om84TmaF42wfEwZgeqVyRWK5w60zcerGq1+lLodFCjyB/KrN7fKwhr6E9o10iZtaYZ4fCpRli6CR/kWaNwW40C0O4+4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201204; c=relaxed/simple;
	bh=2Ijrm83CJqPfUxJ7UeLb8AF0yuIUcP5Kx05voKDJknk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUxt9axEe1ieDePBbr5eDk5ywJTh5pGpWXGB/UevGRxI1lwGCWxEtU8ziUmr0VMObv17DaQHx6BiVdLl+iq8zulvUz9lzSvMmfoEu9zddcDMADUK/mUb4Pc1h962DzcowbdfXIIWU9qSM0wSS4zUrq8+gQ9uD2CLGB94xIAQNzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=GfUKnAHt; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5FC1E1C006B; Thu, 29 Feb 2024 11:00:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1709200810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JejmsfzatcA+gHHSPLHgwEIVpgyudw52nGt83vec9dQ=;
	b=GfUKnAHt2uvUkG+YBnaR9jvDUXsofEVrrDxyv95ZzdhLDTO5LIgjE5MflGBTh7pLod6DJk
	RlrVICli0hgvQhsxsX3ckvyT1+6nsUI/Fuf5saskwFKyOtF5i2ePIOIbNrEZBsZy1/AlPU
	M/+lAsPqyH9hVMYrvTWkgVx4MptcY8k=
Date: Thu, 29 Feb 2024 11:00:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kees Cook <keescook@chromium.org>
Cc: Michal Hocko <mhocko@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <ZeBVqXvK3jFRRwQO@duo.ucw.cz>
References: <2024022257-CVE-2023-52451-7bdb@gregkh>
 <Zdylmz28rZ-mCeiN@tiehlicka>
 <2024022639-wronged-grafted-6777@gregkh>
 <ZdytVTOgfvKBBvtn@tiehlicka>
 <202402271029.FD67395@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iT/0XFoxpI1nuUqC"
Content-Disposition: inline
In-Reply-To: <202402271029.FD67395@keescook>


--iT/0XFoxpI1nuUqC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Does that mean that any potentially incorrect input provided by an admi=
n is
> > considered CVE now?
>=20
> Yes. Have you seen what USER_NS does? There isn't a way to know how
> deployments are using Linux, and this is clearly a "weakness" as defined
> by CVE. It is better to be over zealous than miss things.

Is it?

What is happening now is DoS on anyone who tries to use CVE
database... and on l-k users.

How do I get CVE number for that?

								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--iT/0XFoxpI1nuUqC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZeBVqQAKCRAw5/Bqldv6
8h+OAKCH++4jPiCiGylouvChUVfpnfx35ACeJ58XFUV/io46sBJajenSW4EpeQI=
=RVwC
-----END PGP SIGNATURE-----

--iT/0XFoxpI1nuUqC--


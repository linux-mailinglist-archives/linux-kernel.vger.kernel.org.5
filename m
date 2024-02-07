Return-Path: <linux-kernel+bounces-56850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84D284D035
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 234C4B25E26
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F15182D6C;
	Wed,  7 Feb 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="AJv7n9vD"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5B582C88;
	Wed,  7 Feb 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328318; cv=none; b=gBtFf+mQzpx+yxXeAugDP7yzFnmAmIQkq7qoWUKumW+lsPKaJphTpWbGY4Uqr0ADzf8IdBvZ8sVZdlAOvA20bbaCXme6bfio8O4kpRSIG4ylMNBXHOj1OTr0u0C+GBlfgVoRrFX4BE5HbSA39tnhNIbgtTzrdGGbPbe8U1aUx7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328318; c=relaxed/simple;
	bh=KB1LsbI9/iUC8oYPnytmZnQblhHYCQTehzwzfDiz2RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxauPeqm593dLMJhS0yuxIt8aMZj8gXHhUhLmDrHXxLwKsRmFxDjZkVVNE/mjB7/ZWK1982mrdnZsE4GsXReOg0TTfNMooxgeDYanNWoBg3ntm/LrcyDM3y2uzTdgzGpD8Hf4b5Q7ZkpG39ep0+cTeC5rGKRuvU8X/wXPhVVmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=AJv7n9vD; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 916C01C0076; Wed,  7 Feb 2024 18:51:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1707328306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eaGHk2OWa64/I10L/xQQJe59trrcxp4jWd9IlpfddAc=;
	b=AJv7n9vDjSfyeVJ2zRfFUlcvMAlJ5YlI0FUBCziNAg2SKhPXoBMIEiemllfSOK6zjhP+l/
	gNRZbnVdDpziFPHSXZzflNXhpNbPNqTw/bUXOXvsJUt/CH5Xb7W9heD7rAJgyTIZ/gL3eM
	yigL4XjNp7M0VPjFJmMmk0bsLTqHIc0=
Date: Wed, 7 Feb 2024 18:51:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] string: Allow 2-argument strscpy()
Message-ID: <ZcPDMZFPY08S4MGR@duo.ucw.cz>
References: <20240129202901.work.282-kees@kernel.org>
 <20240129215525.4uxchtrywzzsrauc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eLOfAe0GFtq5q4sl"
Content-Disposition: inline
In-Reply-To: <20240129215525.4uxchtrywzzsrauc@google.com>


--eLOfAe0GFtq5q4sl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Using sizeof(dst) is the overwhelmingly common case for strscpy().
> > Instead of requiring this everywhere, allow a 2-argument version to be
> > used that will use the sizeof() internally.
>=20
> Yeah, this is definitely the case. I have a ton of patches replacing
> strncpy with strscpy [1] and many of them match the pattern of:
> | strscpy(dest, src, sizeof(dest))
>=20
> BTW, this hack for function overloading is insane. Never really looked in=
to
> it before.

This hack is insane, but this is also highly confusing, please don't
do this.

BR,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--eLOfAe0GFtq5q4sl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcPDMQAKCRAw5/Bqldv6
8l3TAJ9JeO899iqkl6Ymsyx096x6S41JLQCdE2n2yCsojfhW1w17jM7QJNEtg/c=
=8PgS
-----END PGP SIGNATURE-----

--eLOfAe0GFtq5q4sl--


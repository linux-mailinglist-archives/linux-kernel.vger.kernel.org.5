Return-Path: <linux-kernel+bounces-93261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C636872D39
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCE71F2483B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3169E552;
	Wed,  6 Mar 2024 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LMj7DqoL"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA406FBD;
	Wed,  6 Mar 2024 03:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694276; cv=none; b=kNMq36JRo0kjV0NqM/PANpJBhv3TO+fqzlyArA+AginSHN/emtnXXAHXe522+1duyiN0l9mtiUOuAXuvO/dF5Ly3BKq8edv/G1o50fK2ETzzU/s4j/OMFuv8RZm87zIEG32+H50drSLamzqRC5gGmjJLLxCcH3jPn9IQZ77bUUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694276; c=relaxed/simple;
	bh=JyjzSJUGaqbxeBl1jQ/EmcWgAHdNKg9nJ33oHJMgwoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=enWzbEDAeV/P5dQXJXNP6bz4aKTPiDrPoza/+e7eJ7Nr6f7/lnxB2sbn4D9Qc7fUT8D2+GgQbwRpgnQ4OXfvGCxN/AK09Tw5JButyyqyYwPeADZq+czFDIvKugmimSoXmgGx5blIAK4vHrSJPa2DZUK9Az5hlKnIdZwsjJyQ3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LMj7DqoL; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709694269;
	bh=hpRAoziea5celHY51DssOfuNt9b12/CZ7msR4eZfA6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LMj7DqoLN9pGCtTB3iVdPDtKoI5B/FpVnYMOw4/X1LaKEiq9lR01jjzplbS9AT/Bi
	 aaE3/xoo/+VYdxTDTom5tu87QPrk77SzWYHkd60dcsGC17DqCXe9n8C7SY3QvQdkLA
	 fRvTvIyxpp8C7alfxuiBhkBdNZvS9A6w+wJ7Z08YU5S15EhYLm0v1DsayrbE2vu19F
	 uYfZY5xJsf5mFoWGJ+NJwuc/vXlgy0aSQpUw53T47ewqbrQqZ4w84jJgNFtLPBpwaf
	 Pr/IAiAhmjrjkmz9YsjRR+su7r0ZDDIms2BG8LkE1DPrPkXz23sEWhZGefS4qvYbic
	 jbD4N55YA6/0w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqHMw4n7Lz4wcD;
	Wed,  6 Mar 2024 14:04:28 +1100 (AEDT)
Date: Wed, 6 Mar 2024 14:04:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee@kernel.org>
Cc: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the backlight tree
Message-ID: <20240306140427.4cb24a5e@canb.auug.org.au>
In-Reply-To: <20240306095539.0da4e342@canb.auug.org.au>
References: <20240226132828.7524baec@canb.auug.org.au>
	<20240305111634.57e84398@canb.auug.org.au>
	<20240305091737.GB5206@google.com>
	<20240306095539.0da4e342@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GOAK+gnWa=diFn7z7lIQnuw";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/GOAK+gnWa=diFn7z7lIQnuw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Wed, 6 Mar 2024 09:55:39 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Tue, 5 Mar 2024 09:17:37 +0000 Lee Jones <lee@kernel.org> wrote:
> > On Tue, 05 Mar 2024, Stephen Rothwell wrote: =20
> > > On Mon, 26 Feb 2024 13:28:28 +1100 Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:   =20
> > > >
> > > > After merging the backlight tree, today's linux-next build (x86_64
> > > > allmodconfig) failed like this:
> > > >=20
> > > > drivers/video/backlight/ktd2801-backlight.c:8:10: fatal error: linu=
x/leds-expresswire.h: No such file or directory
> > > >     8 | #include <linux/leds-expresswire.h>
> > > >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >=20
> > > > Caused by commit
> > > >=20
> > > >   48749e2f14e3 ("backlight: Add Kinetic KTD2801 backlight support")
> > > >=20
> > > > I have used the backlight tree from next-20240223 for today.   =20
> > >=20
> > > I am still getting this failure.   =20
> >=20
> > I just pushed a bunch of patches. =20
>=20
> I saw only 3 new ones (forgot to push?) none of which addressed this
> problem.
>=20
> > Please let me know if this is still an issue tomorrow. =20
>=20
> The problem is that after Feb 23, you rebased your tree and dropped commit
>=20
>   25ae5f5f4168 ("leds: Introduce ExpressWire library")
>=20
> which (added the leds-expresswire.h header), but kept commit
>=20
>   48749e2f14e3 ("backlight: Add Kinetic KTD2801 backlight support")
>=20
> which uses it.

Now I see what happened.  I have 2 trees from you, the backlight tree
(git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git#for-backli=
ght-next)
and the leds-lj tree
(git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git#for-leds-next)
and the former implicitly depends on the latter (and I merge the
backlight tree first).  You should make that dependency explicit by
merging (part of) the latter into the former (or something).

--=20
Cheers,
Stephen Rothwell

--Sig_/GOAK+gnWa=diFn7z7lIQnuw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXn3TsACgkQAVBC80lX
0GzRbAf/VnPnRbwDaIyeXQcpSxo0mfy1eM/FQqsOSCrvZU+frg6aVH97QX2b17hy
VyKXb6clQHhrFmPnqv5AgrH9KkY39/TliPmYrv0dH3ihV2e3tL8GgYA8KngtqDVv
e6WJUlRlwZlfVklxXVA5c+8qFsntcVHrRn1idjmNMNwPP0DeOpxJNpBaskPGshu8
ausC8VpV+qq01D1wCzokw+OrRDvOH1nIpgYe5lksZ/A61E8b9VEKSjj/Q56eh2xX
jssDLDyg4eHEqSsEoMA1AeTcdOsqonp2cOPv/XLWONHMw+dpDR8Y9BSSWStnsSqF
VBdo6SfJy4VbCbUpQ+G13iPu413asg==
=BL6z
-----END PGP SIGNATURE-----

--Sig_/GOAK+gnWa=diFn7z7lIQnuw--


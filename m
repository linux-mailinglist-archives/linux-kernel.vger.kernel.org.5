Return-Path: <linux-kernel+bounces-105493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B8B87DF37
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABFF1F212DA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114121D52C;
	Sun, 17 Mar 2024 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuY3VPQy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C1E1CFAD;
	Sun, 17 Mar 2024 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700031; cv=none; b=pQvd5b/LmaDa1agS376mECUXL/3Fe+R1RjMYRhCpXTTjblaTLNM8nYs+GkOlnV2OIZ6a7dWHMeLUP8Ynj2Pb6i//fsyvz/P+UAl2Xcks3ifvGRFgGQKcfw09nNO3madYvBiYbnmzsIQVOOADDbkrQYoOPqmpZyiExRP5v0BlMVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700031; c=relaxed/simple;
	bh=zOYzWQsPGJvYUcdPDP1q01QXg7uVMZpyE9DAZrFA4N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJZQwenX6LJwgL6TpQo0GvGoqEnrv60+SUvZ7SXFMO6niLX+dlRxhEM2K4I7c+ibxF+ff3gSsmx7ghS3jOYHIa2Czv1k2N4lImjguTvxuZBOZGULNzj32vg6d3hhUtW3L+KeKDHsR8gzeklj59HONHk9Vqvlqu43jbBhWiKxReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuY3VPQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1710C433C7;
	Sun, 17 Mar 2024 18:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710700029;
	bh=zOYzWQsPGJvYUcdPDP1q01QXg7uVMZpyE9DAZrFA4N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AuY3VPQynwW/Kj5nC29DzIFgwYTqMnU1LKiWb8vNI4CXL4akD7cac3vubSeR29pLE
	 AD7P0TyeiV8tJWn+Xca196D0aK0RNqEB8sJAq8VWAGIOZn9RNKWoU91CZQsbgi3G5L
	 KjnhiqwjhsBgaPPeaHNtDiWEdq4n8wMIEH3+wgczx4gbW+1CD6m4A1pe+1czm4ZZYd
	 fPaYXPqgxQZOhI8f2mDPz2+00eLevIpXp94oW8p+LURDsh9gALyRmt/ePxYu1zjegO
	 9UXBWW8X3awgLQf9lNDnq+g4joKkQS+jBRKxp5nvtp081tV2UWlzVkzKQi1ppMVcQm
	 //OIjwtGcMtMQ==
Date: Sun, 17 Mar 2024 19:27:06 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: Oliver Crumrine <ozlinuxc@gmail.com>, linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
Message-ID: <Zfc1-sVsH-o6eQ4J@debian>
References: <hxiq3upwxs3j5mc5arwlx4jriqm7fq5z54wroc4h4kqcq4gq7m@uwnoq2vnkhup>
 <ZeXzuWVmC9AnsECt@debian>
 <7ubz52rfdl2i76sotvd3s4thv6jvbfao6zct3sywqus2owlvkx@wpbeqqdvipo4>
 <ZehMWQ0LkemsTHAC@debian>
 <CAK1VsR0XZMgUW8qMQMcDPohD8-+OZsgW68sZegLbVy6cdoWucQ@mail.gmail.com>
 <ZehrtwSDQV-X7BXV@debian>
 <20240317123135.24993051@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oZ9vMfKMq1aYkFw0"
Content-Disposition: inline
In-Reply-To: <20240317123135.24993051@gmx.net>


--oZ9vMfKMq1aYkFw0
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 Mar 2024 19:27:06 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: Oliver Crumrine <ozlinuxc@gmail.com>, linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options

Hi Peter,

On Sun, Mar 17, 2024 at 12:31:35PM +0100, Peter Seiderer wrote:
> On Wed, 6 Mar 2024 14:12:23 +0100, Alejandro Colomar <alx@kernel.org> wro=
te:
>=20
> > On Wed, Mar 06, 2024 at 08:02:10AM -0500, Oliver Crumrine wrote:
> > > Hi Alex,
> >
> > Hi Oliver,
> >
> > > Type into netcat, not the program I sent.
> > > My program is the server and prints out whatever it recieves,
> > > along with some other stuff that lets you know which options
> > > are supported.
> >
> > Nothing either.
> >
> > $ date; nc localhost 8888 -u | ts
> > Wed Mar  6 14:09:38 CET 2024
> > foo
> > $ echo $?
> > 0
>=20
> Same here, but with nc forced to IPv4
>=20
> 	$ nc localhost 8888  -u -4
> 	a
>=20
> And in the other window:
>=20
> 	$ ./a.out
> cmsg recieved
> data read: a
> byte =3D 02

Thanks for the help!

Have a lovely day!
Alex

>=20
> Regards,
> Peter
>=20
> >
> >
> > $ cc testDgramSocketServer.c
> > $ date; ./a.out | ts
> > Wed Mar  6 14:09:05 CET 2024
> > ^C
> > $
> >
> >
> > Have a lovely day!
> > Alex
> >
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--oZ9vMfKMq1aYkFw0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmX3NfoACgkQnowa+77/
2zIMAg//WULnGte7EjlSlg6uEpl3hIGTTssf8oZITvjgMgMa0HryrkKLfSmkY8rg
/b+uHk7cbWE7i8JEu/eUoTzQUhwbRjtjUXvbYyRyA+1nYixoArBgZZfagGeyfNnV
gADZmrHfaTrOBb2GRg8SiDKdc2F6KIT15n8SI+JeKISVh/xppqZiUpeJXBDENy0a
f0+2zBrczmBs8qDg7+Z6Tg9iB710iI9KzlxA7YSIiiw1cI16SFCvSd3vu9v3MzuN
3Z/pExYnl3f7VTK6Qevw7OY7DlprFpos3G+ZqalL83x3sCJ0fPiznnyAmxYj3Qqa
y35/e1yzCryC2vzs36IQGzq2WLtxFeMEBDPoAa5l0tDHYSUfLWeI8/FAA/3S1pCU
vbVyKbfEDzXQm/XmHdCwaRIUw9oVzbNc1SAe8hRtBL9WXt7TyqE0kr4sYCmmJ7bt
3I0KvqG+L+Korz4EX47aAy8q8F+Cc5sCKpkEI4YvsHyFYW0kn+BV9ohzK4vbCGXr
y4YU/9WvGTUA5iFdd6srOBafUWoNmGUTlJ+FMfTlpKx8JUAI6Zl2lzXBBFytFc5N
dOAsgKTQVqindwUEXTqdncZcFJX3queH0zQxAp3MytD0eNlsDxMSEAXFcY8MG/kn
fzo+ueX3CFn4okw9ZEJyPiMOVSiM0c2zETrdDlvlqrFbNVE1Q1s=
=shSU
-----END PGP SIGNATURE-----

--oZ9vMfKMq1aYkFw0--


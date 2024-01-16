Return-Path: <linux-kernel+bounces-27504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A327582F124
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F6AB232F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9158E1BF4E;
	Tue, 16 Jan 2024 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElxQ3hwZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFF91BF2B;
	Tue, 16 Jan 2024 15:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC7EC433F1;
	Tue, 16 Jan 2024 15:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705418050;
	bh=kqWQQUuaJdff5I0uGZCylWnTssX2s6YVxSu7iKtNMLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElxQ3hwZ20gajxxte3wUCNKg2VAhCCxGGHYpl4kbOsIOLp3oQ7GIErbk9QHGrY8aN
	 UuOfTcym1MVv82UdEbAEWbuwAcz3DrqcXk4QWMHvY9bPSjVkuiLU7m0loLwfgHxDKf
	 GJSdyTLsuRhjELnO1fMr22KG/bF3YuzmMQrQGsrwDxbFZA3fgc8Hbp1xRVbVQiuCKh
	 MyPywJvqUPmFkdKChqjP0ee5crxJfcSnQSayrDTNFekXJis7ZMM8T3zstphJvVGM2Z
	 jrnMkWTNsrqqBOTIx/miY2qjPuLJKPl8FseBR+5KQdnkqFKB+Anxwt1afUX8qyuxrE
	 7qAsarSBaNUjg==
Date: Tue, 16 Jan 2024 16:14:06 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-man@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Matthias Gerstner <matthias.gerstner@suse.com>,
	Avinesh Kumar <akumar@suse.de>
Subject: Re: [PATCH 1/1] socket.7: Mention CAP_NET_RAW on SO_MARK
Message-ID: <ZaadPmLFCI4rsGy_@debian>
References: <20240116110418.2577798-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bhiuGhNFMyNI74lX"
Content-Disposition: inline
In-Reply-To: <20240116110418.2577798-1-pvorel@suse.cz>


--bhiuGhNFMyNI74lX
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jan 2024 16:14:06 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-man@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Matthias Gerstner <matthias.gerstner@suse.com>,
	Avinesh Kumar <akumar@suse.de>
Subject: Re: [PATCH 1/1] socket.7: Mention CAP_NET_RAW on SO_MARK

Hi Petr,

On Tue, Jan 16, 2024 at 12:04:18PM +0100, Petr Vorel wrote:
> Added in 079925cce1d0 ("net: allow SO_MARK with CAP_NET_RAW") in v5.17.
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Patch applied.  Thanks!

Have a lovely day,
Alex

> ---
>  man7/socket.7 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/man7/socket.7 b/man7/socket.7
> index 3ff8fe51b..3ebfc770b 100644
> --- a/man7/socket.7
> +++ b/man7/socket.7
> @@ -614,7 +614,9 @@ Changing the mark can be used for mark-based
>  routing without netfilter or for packet filtering.
>  Setting this option requires the
>  .B CAP_NET_ADMIN
> -capability.
> +or
> +.B CAP_NET_RAW
> +(since Linux 5.17) capability.
>  .TP
>  .B SO_OOBINLINE
>  If this option is enabled,
> --=20
> 2.43.0
>=20

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--bhiuGhNFMyNI74lX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmWmnT4ACgkQnowa+77/
2zKrpw//eDslC0PUvAEIgtFOQAbGv+aFzPcmugouIlpPzK7ybnXFA2s41LQoEm/f
oRI1LtANL9BIC4M+eq0sNkevqjkTTHM9Gc++8MfqAfvvOhrqzpsVaHgMGcd7ys+J
xdvukkRmL0M/MdhKsn/IDJDTDwmmVpxFEyznNmjvKV1ZwrtUGnJNX9wSScZ9kkD8
nXDCbDg33cRKRHyOh09uBx4eqksznsJwBXPQuQtqVYLrXot8nAQcnsRifCZcpR8y
mn/m+pjFthQ98EJozUHtzans0hTjyBGR28ZaeHgjhko0cYwVO7Dj6wzdSsem8a9m
nmnotmPd7Y+6i+qpMdinJmHGBtIrb43u3I/iLapN7liP4vtkvCd1nimzXMeKYfdV
xUUk56YU7zbVCkdTFbX1lUkgAgUt2VsJZiM4CD/9u8ikiWKNxeNJuXK6NuMzL2td
RjrLYUcpU4pCSKEnKKi4273CWS94z9gb8sRpfGdNOr8bYXkn+aYsrMCZnZ6kftuw
QVIBU35zFMaB+O7b9flRupG7ICu0kWKs9aWi8/XUXBFz+XKOHW3VAAs6c3uXiYfb
ylCcip+BX5E0n6zDpyO7SreAWFw/lxXJ+5bZRuDA3JzlcJ73C/xnhoj+8srT+xem
i9QiufXjy3L9qtmQbKSnLpQJUBYSXxM1NzqOVMQHXhA0m6dpg0k=
=UOiT
-----END PGP SIGNATURE-----

--bhiuGhNFMyNI74lX--


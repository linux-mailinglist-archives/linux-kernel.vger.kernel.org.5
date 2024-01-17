Return-Path: <linux-kernel+bounces-28955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5104E830521
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6FB28A994
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0631DFE6;
	Wed, 17 Jan 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNNBdjQY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4571EA66;
	Wed, 17 Jan 2024 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705494286; cv=none; b=ERIUEhe1bLKxMpLh7tWjkK3ATJ3sBtq9mRRVxJP1BwtvWuI3KSGFnmB8a/Gh6uTJ1fS0MMUm2hVyP24uxQrK28lojv9qkmur/elCCydPCqDaBJb+7oIVFMcQjuX3X93APYLdNo3Q1auWASsIQw3rGxjlcV0yAgizbBiZXIux5Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705494286; c=relaxed/simple;
	bh=Xy6TRFXQaiav1mUE6Mj0qop4Z4Iqz9qTKNCOmawbTfI=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=e9jXm3YXwdqedbOY5HlZfiLRicmMFvevVyrpyPvkRjY0SvIVw2lVKDr9MLjMzw2/NOVlMORZEZSHidrfamKYxytZU2Dxs1MG2zX5Dr1mvFR1EmcvlTfr1coSZM6HzE64Edg7FRa2LF6MrYrW5xEQQ2LTxWhoITwgTynaQyLyxag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNNBdjQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F16C433C7;
	Wed, 17 Jan 2024 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705494286;
	bh=Xy6TRFXQaiav1mUE6Mj0qop4Z4Iqz9qTKNCOmawbTfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNNBdjQYNnD5VX30shshT50y20FdZWnH7XdxOhigSAhyFn/qxTzvmn/R/EcRSTzsF
	 s61UAuRCy/JgUHGHfMYsLaXHuLS8awbxzJPrk7aBUrZOB9wRf1bE+4I3UuIrY3S1cu
	 HKt0fZEttCO+ij1ueCh9T6XbU0J0RfYGQeWoG2ezKP8nZg/Qw41uHleRJkrEXhpv/x
	 Ua3RHCKwRZpiyY3iVM3SWKELVSjhXIeevMpAa/vleOIrSzVvUAA7qiRyJp9AOuJu7C
	 UcIhLGjkeEiiNfrzayr0pzfn9323rAJGoCePkjZuNktE5Zl0fcqHiDORZqm0lQOPNk
	 V4E0Vi4pMOYOw==
Date: Wed, 17 Jan 2024 13:24:42 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Add man-pages git trees
Message-ID: <ZafHChsGiKCLh9od@debian>
References: <20240117122257.2707637-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cA7PbLj8K5bpE6aw"
Content-Disposition: inline
In-Reply-To: <20240117122257.2707637-1-pvorel@suse.cz>


--cA7PbLj8K5bpE6aw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jan 2024 13:24:42 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Add man-pages git trees

On Wed, Jan 17, 2024 at 01:22:57PM +0100, Petr Vorel wrote:
> The maintainer uses both.
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Alejandro Colomar <alx@kernel.org>

(We sent it almost at the same time.  :)

> ---
> Changes v1->v2:
> * Add a second tree
>=20
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 391bbb855cbe..3f6a19f3e5e0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12833,6 +12833,8 @@ M:	Alejandro Colomar <alx@kernel.org>
>  L:	linux-man@vger.kernel.org
>  S:	Maintained
>  W:	http://www.kernel.org/doc/man-pages
> +T:	git git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
> +T:	git git://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.=
git
> =20
>  MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP)
>  M:	Jeremy Kerr <jk@codeconstruct.com.au>
> --=20
> 2.43.0
>=20

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--cA7PbLj8K5bpE6aw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmWnxwoACgkQnowa+77/
2zIqPQ//RqNkJeUcDj0HkcJ1lXUdiAGPN8qRBTBNj2D9EFwYFWPKibGKBer8eB7+
9jS4VH1pFIlho2sRJHo2cGzyY3JXTW2MhbxNrOxKayIdrQ3Il09qNyhMvqo8tf3V
cjCE9tlzabrlm6QTmIlVka+KXa+PtSErNXrZQ+P6aoTTNYsZfcLQhNPFzM2/8obJ
uMgN7z5b+mk31NPMOKOb4gkfgzebKQAjYg/fgFN1y2Cxw7xXWHfvo4QaqICkCF1y
vzj8/9jpjLjOB/Jipn9R3K/I1dGXMwvNkJTVSQuhnKTqetB3pT+jvQcP/PAKhb1d
0xaY+D7o6U+X7MTa/XIqUjoRBtBz7EQWYnD/b5E6XbetnqfXZA8pxeiVXM+YCLmk
4qKAqVIsGPlYAI/OXL2frnWcSp7nNjY3J74Q8W2fvgDJBazwA9wLATsDcT8D6fBQ
QEOZql8Xm7HnHlcPbYDmkZcu0+qouiiOyeXkc9viai9fO9BomoOHju3qXbmEc8Ux
eYIglEHvKgZPCNKHUN4VQTPAxw4kymQXSvqk529IDmYQvEVruGKDZpWqw6Yy0ZZn
wGJ1HY14gaKfz0NJ+1N4+dV7GgQ+kLL7w3fUj8eweiEnwyYL4JImvNdGHhk8S48X
8jII7NEDplCoIEVTaEOL3jmkLdhqsI1EypqhVAfazuRP3ZZN1Sc=
=KIVD
-----END PGP SIGNATURE-----

--cA7PbLj8K5bpE6aw--


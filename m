Return-Path: <linux-kernel+bounces-28939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0733F8304E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CCA1C23ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F831DFDD;
	Wed, 17 Jan 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dA326Eej"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C81D553;
	Wed, 17 Jan 2024 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705493208; cv=none; b=blckT7YJ6f9cGLpoFA+vTNMy8ElDbhtDEOpeXqdgxZZV3UZmYRjqCh5KxtPN72N6l1dP2iQ6fG1vc+gNrcPEZJsBTqcLBkhsiHLYrftDtKbrUbUPiInLAQE0/fyqe3EWKHURfq13lENwbWlW3iNhim/Cxrc23SxKS+/6aHfq72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705493208; c=relaxed/simple;
	bh=8nVizYFCDcIj21SkCq635Xj1qvW5+ER+HVXd1fP27Wk=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=q7nPVxpH1foFPf4/gtMEWB2Hke57GhxYF/z87l4vWgzOOTQ/dWl4lX9QGSHrTvPy5SXhsdUuQdgiqlflZUQJwxrcef3G0F03JENWXg60ryiO9C2Rs1MBvUgtczREQqraHIz8X+9Lj9JHeVKgb4mNr7Os/Bo4fzKWyg3NWy65TcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dA326Eej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E46C43390;
	Wed, 17 Jan 2024 12:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705493207;
	bh=8nVizYFCDcIj21SkCq635Xj1qvW5+ER+HVXd1fP27Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dA326EejhCeX3hHoFrzFQ15ZfF5409IQau/qLb+kT8L7yjsOEDPwEQsCOkIC/eJfr
	 sunY9cLOXP3yr9axVsRaebb4BJHO2DiVdD6YjyCmG1vTovCUDE+TLtWeolSTQoKcAf
	 sfsiIQZIpuHKMX2WIQYoN6X8Qez7e8KewfW4xjAgQBz2Zug8jNsXghNUqbENmTitXU
	 be4GDwMBPGvwgXILOC5olLRFpRTw+b9AdcL4VF1xQn3nqxWsHOqmwmlwbNWXumg73E
	 y7DCJINE6gMxqLT6YYewyMdlTtF+rqHisho/pu5zKB4uDlP/tsA3pq0bjDyEFG0de7
	 N9NUQ1ndgtp6Q==
Date: Wed, 17 Jan 2024 13:06:44 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] MAINTAINERS: Add man-pages git tree
Message-ID: <ZafC1MkKDAK2s6n1@debian>
References: <20240117091903.2668916-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A5ukflp3KcPRO+YT"
Content-Disposition: inline
In-Reply-To: <20240117091903.2668916-1-pvorel@suse.cz>


--A5ukflp3KcPRO+YT
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jan 2024 13:06:44 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] MAINTAINERS: Add man-pages git tree

Hi Petr,

On Wed, Jan 17, 2024 at 10:19:03AM +0100, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 391bbb855cbe..571749fe9e38 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12833,6 +12833,7 @@ M:	Alejandro Colomar <alx@kernel.org>
>  L:	linux-man@vger.kernel.org
>  S:	Maintained
>  W:	http://www.kernel.org/doc/man-pages
> +T:	git git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git

And there's a secondary tree, at
<git://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git>


Have a lovely day,
Alex

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--A5ukflp3KcPRO+YT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmWnwtQACgkQnowa+77/
2zL2WRAAlSk5btdnZKR8yyJNwl99TmlhFVT2IY/B16uGisykpOExbVZs9MvLsrJy
nNNCtbHVY22UNTjGSFfe1+nZ7Fif2Mnh1qzWhMDIfdablbXcgQC7tgUNZNy/M9/g
iMNMH6ftzQBQgBxkOES8mNzkPRttQJs8JZxtcrifi6ItIH/e2T3fnDfU0aQF1eVz
Q9OWOPMEFjQMfSpwsJzwLs9yVlGiDdaDyq32lJ4wwwCusGN0lptNVZBuitBFDcue
vA0LqeHmYszk6X3Q8d2r2MKHp+9ZmskhNpLotulNZia2fXGseOBPpJmS5sMu0/1s
LcJpqOI028f6FFXpRUwI5AiA+s9HC7O+U9oTYG8Iz5rfpAFKzVq+jttMcHQafaTj
bKO2FZZh+AGshz8ctbmEJTTMuu9v+6smhKHY4iS49MOwtJx0G398BimAKuoQAYcp
2E+za6sy3hddCHRmaMrDz6EMfzOOcTj4m9zrFis1bpvnzp8DXpqNUaRgaKjv6qps
QmbNbBbd8TF5gmRM/cC7M/jdjeY0bKnTGQTojhjRBR7pLsqZA5Wnxtl7fzHs40Ut
X4XDVn58L7XIhqPZR1chRMVXqG112F1ELg334Eb2xnkviLST9kTZdl66DziQbaIP
vWFXTvShYjA1bRjIHGJbrcpxjTdtqRjKXCq+P2TOIDASuIARXDE=
=lSz2
-----END PGP SIGNATURE-----

--A5ukflp3KcPRO+YT--


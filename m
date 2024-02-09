Return-Path: <linux-kernel+bounces-59720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9ED84FAE6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4011F287D3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDE47BB17;
	Fri,  9 Feb 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPyptdzw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019177BB07
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499188; cv=none; b=Oxc5ZXWnt+JWJdfUK3hbW3JUd5n+MZw7r9S3LaCHsZyQyNpK15Ew7HFvrHVghoHvrLPqkEq3m6BlS8Ui86deR9EJJXeQjcaPrs2+I/SCaGPZVVQ2rH5cxUm2kJ6usicQ88x2w2H/CibWDbk4ou0RN2UbUmXyUr/S9uZkL0a68hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499188; c=relaxed/simple;
	bh=azgwoHTButI3kOIJnk2XucQkOqgE76k9Z19iMMGneGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPy2bTT4Hh1hd2rjzP9KhkCjn/VPYnMoSIOyhtA/pJvjaGzqT5EiAbfOQvDz0bFgvxtCZ3dQNnXTIblp/3uG9gy8ALLuE+fPyfCgV9cLNJCdvv8W/hNDqIlq82pCKke+jl5Ium3RQR1AC/vHnxzWI2yg4wVOQcxoQEdeT0oowQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPyptdzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E7CC433C7;
	Fri,  9 Feb 2024 17:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707499187;
	bh=azgwoHTButI3kOIJnk2XucQkOqgE76k9Z19iMMGneGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPyptdzwkGYvbZZavy1sbxwbS3kNVKBl+ld444+CLmVwVRyYYNmo368MfBE9l7z0x
	 SL1Zf3DTr/+XZlVzEwM6qOU8auPtz4whyTNwE5frJ5jE6bAYW3T3/w/amZQ1OAwe/Q
	 AAsfKaCi9Gpu/0tA88zxiz45VPceotoA5HBdkaHk3pquc6iXWTVYJiqPV/PsAR9laZ
	 0Nc67mZr+Be43YieJcivf/O4n1MlbuMj4uQdnVriysgBlFjag3Y55U9jnBd5wZgbrI
	 pnnuVk5MYV1W27O+7i3+zFbiKzD0I1GD+9chezzf9OFfcqfuJ1u07HXp5aAxp5y25U
	 B57HyXvXK5cJA==
Date: Fri, 9 Feb 2024 17:19:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sporadic regmap unit test failure in raw_sync
Message-ID: <ZcZepsPXCbmBnv0j@finisterre.sirena.org.uk>
References: <dc5e573d-0979-4d7e-ab4a-de18a4711385@roeck-us.net>
 <ZcVRcH/D945GKWjG@finisterre.sirena.org.uk>
 <91218892-d8df-47f1-99a0-6c4564c7bebe@roeck-us.net>
 <ZcX7HMQBIG75In/A@finisterre.sirena.org.uk>
 <f9aec946-a969-4f63-859b-4769ca392faa@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1UIY4EoyEuvhEcOs"
Content-Disposition: inline
In-Reply-To: <f9aec946-a969-4f63-859b-4769ca392faa@roeck-us.net>
X-Cookie: You might have mail.


--1UIY4EoyEuvhEcOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 09, 2024 at 08:30:30AM -0800, Guenter Roeck wrote:
> On 2/9/24 02:14, Mark Brown wrote:

> > Something like that, perhaps not that specific diff.  There's a bunch of
> > tests that might be impacted as well so probably a helper would make

> You are correct, though, unless I am missing something, those other cases
> will result in wrongly passed tests, not wrongly failed tests. Not that
> this is really better, but in a way it is less severe since that will also
> only happen with the same low probability.

Yes, on further inspection the other tests don't care what the value
they're replacing is which isn't ideal.

> > sense here if nothing else, I should be able to take a look today or
> > tomorrow.

> Sounds good.

I've got a patch in CI now which fixes the failures and adds the helper,
I'll go back later and ensure that the other attempts to change actually
do change the values.

--1UIY4EoyEuvhEcOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXGXqMACgkQJNaLcl1U
h9BZKgf9FUyYfeZNOyPI1lL0tLhwmEs0BA62KX+WIjV3rsVdDQRcC33wZrDfY3IV
L56o9uPYu43GbtXdxFe2CXjosSGT7KE8DeA00e8dbSQwD0ysnL7DGcg+i8J7sl1u
BppYC/DhpNM5yhzeQtdL0Pn9pmfNknnYwqXvb4OL5N4UMkzamH5K4oEfVZIVT0l/
RDtRaeSoJlt9QZKRvZokiXgQIxlCckpCqI9vaj0jZdprgd0Qpw+zzT53VVp0xB5+
O5+8vd9bR4VgPAMum8+6pBUxsn6PVJ5bEB+8IfOBy3oSu6mupOjyIfqRT4wneSUN
Yy8yfGXjntus/tPTTBUeBkMUOujFGw==
=coAE
-----END PGP SIGNATURE-----

--1UIY4EoyEuvhEcOs--


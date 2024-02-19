Return-Path: <linux-kernel+bounces-72115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBC985AF3C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB111C23D01
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751345644B;
	Mon, 19 Feb 2024 22:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtOJZGDe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6050A87;
	Mon, 19 Feb 2024 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708383280; cv=none; b=rFAiQhvDyzV4J7PkPQYDFHPzvQiwidG1pqtMWK82l+eRVViXOi/DMDcgqiTb7wjwv5d9MiqXgmRbgwFx3FHeikPCidzRbLd/AZ0x9Orl5Mg7q7D7NhlLFsnqoKAp3RwE6HWKE/9Y5zdVapwLzdrZPS1hvFhEc6u5aUS0cZO8Epo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708383280; c=relaxed/simple;
	bh=HqMrGFJKGKvqA9frf2n8vKVDlaU38hGPg2Sf0TPQjNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9seggjUQOE7M+eXt+baH/c+lCvu9lX/FXWXFIN845Yke/LM8LtaKeJ/TZK3bB76f+Xh0hNkEYUCPwZQdZAc7wGyc32NsytlvhJ1obkfks4t++x6LrccHzomKcKjMUM3yOqSCKvB2X6577zaDhmWb6L6jcoWd0Iux8aAzPfgeg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtOJZGDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A02C433C7;
	Mon, 19 Feb 2024 22:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708383280;
	bh=HqMrGFJKGKvqA9frf2n8vKVDlaU38hGPg2Sf0TPQjNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jtOJZGDe+xEGW3p2/0JsxLIXpO/ciGzb9aaAjevQh2EdyobVarAc9v7UEAgegNwQU
	 4GO8NOM6vktLMdMwM0iUz+RGyiPew4MEhEITB32vn2jlO8doJmws8DkqaSJ2EeHDmq
	 1f5BmHUYEm+RMtauR3e1MXAWx2h0Iy68uu95HWkMa4R/zTethwrI2fzDlM5a6cJgN0
	 jRdTtNl1cx2fo/n41YUfYh5dRvEaAaSISpiPs8bkchl+/kjZ3aWRuk5lC8XkeDDr/0
	 9o61HWJpGlNax4osLP7iutPPbRr6VjnJKyV5CfoPzWI+r8w3hcWLSRZpGRZJB9AJRE
	 KcFu/PMMJKj5g==
Date: Mon, 19 Feb 2024 22:54:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the spi tree
Message-ID: <af7cfd01-c0ea-4e75-88a2-7202875650ca@sirena.org.uk>
References: <20240220084419.599716ce@canb.auug.org.au>
 <439d34e7-3bf9-4710-ae0d-6c2b94917c60@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TJUn/yZhp5n9Gpyf"
Content-Disposition: inline
In-Reply-To: <439d34e7-3bf9-4710-ae0d-6c2b94917c60@infradead.org>
X-Cookie: Kleeneness is next to Godelness.


--TJUn/yZhp5n9Gpyf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 19, 2024 at 02:48:51PM -0800, Randy Dunlap wrote:
> On 2/19/24 13:44, Stephen Rothwell wrote:

> > Fixes tag

> >   Fixes: hash ("spi: Update the "master/slave" terminology in documentation")

> > has these problem(s):

> >   - No SHA1 recognised

> > Maybe you meant

> > Fixes: 99769a52464d ("spi: Update the "master/slave" terminology in documentation")

> oh dear. Yes, I did.

> Mark, what do I need to do here?

Nothing.

--TJUn/yZhp5n9Gpyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXT3CsACgkQJNaLcl1U
h9A9iAf8CcBRA4bsTdfBxbPNldSE0nbB/J9uIb+VUrvc8uRsoQLd5LVOVW7H2bT7
G3wmhrsQ0ZxwCU9F9O6EK64fWqOXRNtvEj/V63DthrdhaFENUvxM1Mc6KuXwWxTh
t1Y/oB2gfYOc9ZS5OOgYUFBxFJxyNWQM8IhNvMEaE7Kkr/1kD+nYNrPJ0iJ5UbJl
EyQvum7CN5sA4RpDDf6SaCFGQUikfMkBIks0149q06xAA+LPIEwxsraK68cjLfZX
OyAsysh6BXY+Y+Q4H6NfDfEOqdy/iPqg+6XfxiSJmQsDztt+UnYf5tmB9IzvQ/LU
CFt/2UYJ4Hf6zHtz1P47jt+NGee+LA==
=nOwD
-----END PGP SIGNATURE-----

--TJUn/yZhp5n9Gpyf--


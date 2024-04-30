Return-Path: <linux-kernel+bounces-163255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A94B28B67CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DD028400E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FF08F5C;
	Tue, 30 Apr 2024 02:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJUMsfuC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE6A8BE0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714442974; cv=none; b=f9BA+SvXiaNrE0fNGs24pkOFq9Ll4gIFC1wwppYWREnGGGAhiDvLTia77MPGVsEXvcgHKdUYk2jjEKFx9P2eS0+MuP4N+2uxbQyVTPoi5zXT4BAu0kzoQhL4na8W0VGIZ2wQTwCdT/nxKaEr3h2buY9itgDCjecg489PfSAIvVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714442974; c=relaxed/simple;
	bh=Y7O3cz/eY7H13A5uDglsuhg1RXHmQHXFWlR0r6h7OFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlGFoIBEWoPCgaw+HWo9elblcWQUrooCmUHQMQsSHyPbDdHBlfLGr0Xo38ZgvupY4TFK0OHU673g23AhKA0MuZPbl6PKjiBdn/jFhDLyCIh/T6cLA4/KDdsccXkX3zbSBOVN1niMbjYKgFamwQtNrIMyKrAdJOEPOFyjHqzBdsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJUMsfuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D217AC116B1;
	Tue, 30 Apr 2024 02:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714442974;
	bh=Y7O3cz/eY7H13A5uDglsuhg1RXHmQHXFWlR0r6h7OFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJUMsfuCo235P3ok0OirBx4MRM0suwE4Pl5WqDxvJOmFfGuMXuUbushih197XaFyN
	 ZL8GcQ/QFbca2O3smWcsMaIRcy4SoYk135R7rpztm5+svp6AAFLxsi2nUQ6mx0O3UH
	 jhFxHv9wRgQDY85hRL2pzsAzo2dHtaiIJZgZ5XxVBUJ1AQO11viX5hIdInyrNOQNe4
	 82DU0iniMeC4IiCWGdtwVht7fPB6ib2wAF/e3UFPUH8hlLX/vzvmm6DQRS3lT1RqRT
	 UtSuM706+YJLcg2m/KGRe6IyjyhJXddtLBTO+Tm/CC5ec0BYdxz7s2rRbqMPOtn3ly
	 NwSsNq+sHUp8Q==
Date: Tue, 30 Apr 2024 11:09:31 +0900
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: tps6286x-regulator: Enable REGCACHE_FLAT
Message-ID: <ZjBS23rdJEUTopDt@finisterre.sirena.org.uk>
References: <20240430010019.1980-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vUPQgMyWj5wTiDjH"
Content-Disposition: inline
In-Reply-To: <20240430010019.1980-1-jszhang@kernel.org>
X-Cookie: lisp, v.:


--vUPQgMyWj5wTiDjH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 09:00:19AM +0800, Jisheng Zhang wrote:

> Enable regmap cache to reduce i2c transactions and corresponding
> interrupts if regulator is accessed frequently. Since the register map
> is small, we use a FLAT regmap cache.

There are a number of disadvantages to the flat cache, especially the
lack of sparseness, so it is generally better to use the maple cache
unless there's a specific need for the flat cache (usually the fact that
it doesn't allocate).

--vUPQgMyWj5wTiDjH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYwUtoACgkQJNaLcl1U
h9A4oQf/drHL14gR5AhLgItP1G/01UvnpM44BjIfwQ4RJLEqe9cHfoKrz5UT2W28
zY4heoUrWcdpNTlttQ+ZDe7lL0Ht4ZOTIFB/a0eg+JFogVNYGO/Ky4B6+//+Y/Lb
wT21YpcTrWaIf6eXKY3V1uHLTwvSoznaWdfH6vgD08TyDlMllvlhYX2SCWgfn5is
sQhuMzaUiClEhjx8Dv8OcYYcfTCuA+eWFY6GtrB4iTCY7ihupvxyBWMXyZo1LkRN
nPBPfuZTk7W8YY1GP2e6GRiPRKpEjfgiBTesA45vkCl6zqRSlObVDjT516YtahMn
wtyOGo862uijqBaJqrLKW64JwgV9sg==
=OLXB
-----END PGP SIGNATURE-----

--vUPQgMyWj5wTiDjH--


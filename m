Return-Path: <linux-kernel+bounces-102109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 485F887AE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F2E9B257E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FB55EE99;
	Wed, 13 Mar 2024 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igpBMHdg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFA55EE8A;
	Wed, 13 Mar 2024 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348778; cv=none; b=ucqoVxIS+gtUUHO4uhJHijJ9/ZqGnzMSYTFB4iHyHkaSJQVjZTfXcgVJb6b9WJvFkyeE7GBTTbOf+oL4Ic4m65NNH2kOMFtwz8uyof3rblPEDG84C+MjjboS04hnh1bgIEcrihXBB35b0Fud0VdhFQ7pN1D9YaeCTrPxU+TWoU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348778; c=relaxed/simple;
	bh=J1Pr+3VpE8ZujbDGegT2LVHFhljCEB6ex2jUS77yFFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9G/K+V0f7qOsUWidWQcV/OR8Rwv8NnCLo9jL8F6BsihlwVJMy9hVEOI0IqypXPZYX44IuNnO6uOUgmDWdvRlfAW553ug6WZrzCkliqc/9lX78I+XbReT6zMzusczZQouHlebj0w/ZrVEhBo0yveHIMeXIfO4e3CDHHY+uFGJSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igpBMHdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65590C3278C;
	Wed, 13 Mar 2024 16:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348777;
	bh=J1Pr+3VpE8ZujbDGegT2LVHFhljCEB6ex2jUS77yFFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igpBMHdgHOhVvxi7FhTiwMWpiJ3vzwt0kyQiVqizWRuUUfr76520EoH1oED4kHfc3
	 k7DzCQMfOpfBDkhipvKo4BHWx2eEMyXZTsvI+DC55bSOxVAVESB/lI3TIah4cVfCbP
	 LLUguCpLzGeZMm8MUHkEqF88OhON98rARSQdCzWn/qqaIy5G5X2NO0p9ZD6tErBM3Q
	 QWJH2TtciAQIKdcJMdrv38yIeJQJ7HXn/fFpwEXgSPZ2tSOM32P7YGiTmRtf5fctfE
	 XMCCowCWVUqZxvCMCaW25Bu2/wUJnImqFlMveduY9ib/r/M72YoIwqfH9xfyQwlIQa
	 0L/gNx9YN7aqw==
Date: Wed, 13 Mar 2024 16:52:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ansuel Smith <ansuelsmth@gmail.com>
Subject: Re: [PATCH 5.10 68/73] regmap: allow to define reg_update_bits for
 no bus configuration
Message-ID: <b8f5a59e-6ecc-4440-9fbc-b9932bd6ddd7@sirena.org.uk>
References: <20240313164640.616049-1-sashal@kernel.org>
 <20240313164640.616049-69-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AoEQviumDTaIy5xI"
Content-Disposition: inline
In-Reply-To: <20240313164640.616049-69-sashal@kernel.org>
X-Cookie: It's later than you think.


--AoEQviumDTaIy5xI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:46:35PM -0400, Sasha Levin wrote:
> From: Ansuel Smith <ansuelsmth@gmail.com>
>=20
> [ Upstream commit 02d6fdecb9c38de19065f6bed8d5214556fd061d ]
>=20
> Some device requires a special handling for reg_update_bits and can't use
> the normal regmap read write logic. An example is when locking is
> handled by the device and rmw operations requires to do atomic operations.
> Allow to declare a dedicated function in regmap_config for
> reg_update_bits in no bus configuration.

Again, new feature.

--AoEQviumDTaIy5xI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXx2eQACgkQJNaLcl1U
h9Dx3Qf/dAU7Fa7U+qSwLcAxAzKL0s4SMZcAq7Z5XFA+EjHdje3GcwvhUl3NeX9v
v2aXUzPgihhvNz2zWnJp394VZBMVk2eut9SfnK1OL+O50hXFf7uGJCS+ajXe5gr8
S+UrTRG4bGbW5zkzhrr5nU1iGQeulqSSZ4IOhgpMVAzJtEMGOmj5wDUc+//bXIKp
0FMyJaEMGv1L1rHJneM7TuoKJPJ6vkYOxvjwv3NYd566QMuZUuuhY4w1fzsDJNp2
SEiTfjsxXty/jmtVz45SnTvUgrQyu3t4V6IGV10+u5zl/nLAd0lJEuOYzOaOMaFr
wjgBSEI9lkGmv7FKLOplJY2RvF5fvQ==
=cmvV
-----END PGP SIGNATURE-----

--AoEQviumDTaIy5xI--


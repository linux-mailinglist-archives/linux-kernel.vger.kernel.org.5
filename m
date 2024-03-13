Return-Path: <linux-kernel+bounces-102023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C520287ADAF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F86282057
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABAC4BAA6;
	Wed, 13 Mar 2024 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ensjR6iq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8545490C;
	Wed, 13 Mar 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348368; cv=none; b=evmrsYvtbj4cXEuN2cb1pcjporcQlTo73y5dgvgDrGQ2HhZjHGpRpcJr2zfFTwQCYjkTzEVBvhG9tGsDQpR7Zns6U4VKMpWYW+80Fskr49ELsXlIqQtrarFn44zm2KyzR0FBbKoj6l/aVYK8HtDDSzEjwSQcitVXYNCG6poEfGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348368; c=relaxed/simple;
	bh=8vD9Fap8m+M7uwpWThRl5X5Lo2K26/LqwhLWSjz1ZmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvB2zHbGpYKhb0E70a4IZxeK5MACG64tWK/+zeHR+Lef57zkd2hu0EJG+8KYIqSx0d3jodkWZW3b/iXxKpWjNu4tN3G1ASVgv9jCKaP0s5S5S3znHWQtBjqWKkMr/cD4KeRZAnJVL26QnopTeI+b9PtVHG54QrcBw6M4HL5Bx8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ensjR6iq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D250C433C7;
	Wed, 13 Mar 2024 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348368;
	bh=8vD9Fap8m+M7uwpWThRl5X5Lo2K26/LqwhLWSjz1ZmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ensjR6iq9zII4CO79LRlV/0wlP/+PDEZjoLRHPjk5lwzHPZ+N3AEkfJhEUfW++Nsu
	 nqRXEU2Yvt72Ralt7bi+gK5v8VVu3hptZdS8thvIaOIy6FlJgiYgo+ehdBetDzY0CI
	 lc/XZZSRYhezzXvbb7IBPsluHQWO0dZizTR1ELmN4K3Anl4i7CoM+AvjNJAXSMOQcg
	 h/fCKRemVmunGwD2E4v2WtCrj5NRwit61PnuPwQW4hrRecg6xgDMlXi7OUyKWBAxuP
	 hL58ZklercW6C7p/lI9U30gujZOQD+eQQ6ksaWp3E/yyJrFXlb6GLNeZqzaSK36WFg
	 nvz5BFeZP4MJw==
Date: Wed, 13 Mar 2024 16:46:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ansuel Smith <ansuelsmth@gmail.com>
Subject: Re: [PATCH 5.15 72/76] regmap: allow to define reg_update_bits for
 no bus configuration
Message-ID: <6274f1ce-f2e0-414b-b9a9-bf2840fefd90@sirena.org.uk>
References: <20240313164223.615640-1-sashal@kernel.org>
 <20240313164223.615640-73-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cjF8jBOhLBvTK2G3"
Content-Disposition: inline
In-Reply-To: <20240313164223.615640-73-sashal@kernel.org>
X-Cookie: It's later than you think.


--cjF8jBOhLBvTK2G3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:42:19PM -0400, Sasha Levin wrote:
> From: Ansuel Smith <ansuelsmth@gmail.com>
>=20
> [ Upstream commit 02d6fdecb9c38de19065f6bed8d5214556fd061d ]
>=20
> Some device requires a special handling for reg_update_bits and can't use
> the normal regmap read write logic. An example is when locking is
> handled by the device and rmw operations requires to do atomic operations.
> Allow to declare a dedicated function in regmap_config for
> reg_update_bits in no bus configuration.

This is fairly clearly new functionality?

--cjF8jBOhLBvTK2G3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXx2EsACgkQJNaLcl1U
h9DU7wf8Cc9vW6X2/usR4C76o8n6h/sawjjlFC4FnswhsVx8SShR2YdDzOsdRCiK
r6SpKfi4Apx/anRoZ8Sc67tp0AY43NKh0hCUwiNsmhTDWoSHQ4i6NPgsHJNIDyyu
YCH/I6dPidoN3yzs6pBbrwHJKkMMRim5kjZbfgAZLfqV3nWHEDTkCF+EipuhyE4T
henmSMRPDdkfEIEe4zG6aHWr/9b9uG/XOdZ5W32iCFNNpmvMZ0X76KtYTALV0b9q
braOwEgoFBEmN2KQvVEqd5icIortuQhD1J9PoJ0CRmJbdoNGVJ+9RzAE8knTf1pg
eXR9f1bFSIg/KWbmoKY7+6w+7ZsRXA==
=yQty
-----END PGP SIGNATURE-----

--cjF8jBOhLBvTK2G3--


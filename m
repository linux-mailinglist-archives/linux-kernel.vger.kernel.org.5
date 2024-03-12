Return-Path: <linux-kernel+bounces-100389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC778796BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B91281F22
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5FE7B3D5;
	Tue, 12 Mar 2024 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nq8EZpQK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014F1DFD8;
	Tue, 12 Mar 2024 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254858; cv=none; b=BV25fmNl/V89MdEb9bsncf6bBxsvD0SE8NZlPZRpoII6iD7rSyrqbCNSung16JDb+N5d/4ccIpjYAHqQjQtG+MuP65kelgIR9uAbVjQC7iXUjTyzHv1InyjYJn/qWOnvQE2s3FNUCULqvD83mzbujoQ1dK1RWLeK1Z/bbwZCnXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254858; c=relaxed/simple;
	bh=WvqrNBs/dsANsTIam6QxqZAEnFp69mAAp5IdSpFvv0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaRjs6OyFTwPD1MRI9/hlIe7J+FjPHY6u7Rk0Q898F7FaoyamQfnxgd+zKgNDZi2N9+QQ3+/uYorPKwF8uJbfjcpGObhoMMSePyDSoYvSj1b+k0K1x23X/I5o0seLifr+dqYRiJLK8oJgR2CLzg+OnDgFea4ezZQjGGq7Fd1vMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nq8EZpQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B277C433F1;
	Tue, 12 Mar 2024 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710254857;
	bh=WvqrNBs/dsANsTIam6QxqZAEnFp69mAAp5IdSpFvv0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nq8EZpQKE4/pDtnBVHiu4xlQCU3rbOhVUm4uUXvXZkp72+qmwDkN2Rs/xbli93EsY
	 M4S/nrQ5G9YJdWctw6DU0tFPrYh3C35aTwXmJ0CoUEBBb+Ha2XZ7EEmDIK39l/WlT8
	 f1oLUfuFaREMLwZdR1MKqPy+/YSY+ECvtuzpn1gCL3bHfMBhKh3LwfYs6hyuXKp0vs
	 aiGDtYP2krSSpWmO/H1+UrUI0RernUS/wBkG23AiOiUWV9G9Gc8DTgdYYrSsdzRTd4
	 Ni+xHExOA71bHAnKl/Gzvj8nxfJ8rh7KRQagbFBZNxrH2jYlb5WXbO4byQEzCtO63o
	 hy3AYhT1QaP3w==
Date: Tue, 12 Mar 2024 14:47:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/2] string: Convert selftest to KUnit
Message-ID: <ecbcbccd-1c3e-4d5d-9502-0396d34648a3@sirena.org.uk>
References: <20240301202524.make.800-kees@kernel.org>
 <20240301202732.2688342-1-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lWQNWGwaL10PQ4jC"
Content-Disposition: inline
In-Reply-To: <20240301202732.2688342-1-keescook@chromium.org>
X-Cookie: Oh, so there you are!


--lWQNWGwaL10PQ4jC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 12:27:30PM -0800, Kees Cook wrote:
> Convert test_string.c to KUnit so it can be easily run with everything
> else.
>=20
> Additional text context is retained for failure reporting. For example,
> when forcing a bad match, we can see the loop counters reported for the
> memset() tests:

Reviewed-by: Mark Brown <broonie@kernel.org>

--lWQNWGwaL10PQ4jC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXwawQACgkQJNaLcl1U
h9Cljgf/Y4b0Xk1s21KrI6Vdrp5pctZ3Zcpq+u725G5xY+C9ItB3OI2i8k1PxJW1
r+qKuptg01FTkeqlIdzOHImeYmN80iKmZ1xxJC3Fo2EjuHbxWDe58ivfHTfTzJu5
V3aqPLjKoxjaTJ/NccyJH1LqQqIEtGfYfdpIGnLDWfLMOIaY4vNqGYjQgMd9grwq
S+f7S9Xz9w+ws4jrYKkrf2LwYBbTjbiOh1VF73GKq93dpLU4kOuT7Atqk+Yu9EDL
9z3i8o8uZ86prK5ceCP9PZBRy/4IfvjVFcTOd+EmKeurQ79dug5ysYBHFTX2SW0q
uCay40/O+aASTANo7rOZ2uj/YnA8LA==
=A0CZ
-----END PGP SIGNATURE-----

--lWQNWGwaL10PQ4jC--


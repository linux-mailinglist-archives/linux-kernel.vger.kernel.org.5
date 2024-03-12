Return-Path: <linux-kernel+bounces-100392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFCC8796D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F120A1C21B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A857B3E6;
	Tue, 12 Mar 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gbnix6EA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C196577655;
	Tue, 12 Mar 2024 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254967; cv=none; b=YVBa2bH3a7HJVDZ6UKGiyR1ggctgZB0tcoUenhz7z740TC2bVr0+4BXyZUVmqZqL6JR/tlCgFpU9SNTdyDm5zvxvGp6oW6jsPvc8QgfvGI5Om0A+bhhb/wWiq33h8lSKxD8AHNX5HbBnYFLlaBd8E4pddj1VAexTJYYHMRJD51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254967; c=relaxed/simple;
	bh=FeRCMT2GZqh+FkzLaT7miC0EprP3DvKZFBNkhmQycKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wrp4XAuyqsSNwJI8tleYLC+QFO7QyHTUK3YMT3wyliwvcL8rRIPRVFe9jpgIOdibW1xsTIAtDpf88uIolizpoZI36/erPyPa36vaUnDP6HTa7uhYBii2hCkhAyROLS5R6FMyxDIo1e3ZNaEBkd8ik1x5r/7uFIYjmTJu1eMtgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gbnix6EA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA5AC433F1;
	Tue, 12 Mar 2024 14:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710254967;
	bh=FeRCMT2GZqh+FkzLaT7miC0EprP3DvKZFBNkhmQycKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gbnix6EALh0+qAryKwkBbQFz7L2GbxXhHkkD4M406tKBM1aze8tWl/eBu3DmTA2UZ
	 5a6Rd+r7r+1Se95FX4tpIBWXCWn8EACdlQ4H0NRFCRlG2ama2pM0kr/y4Dwxnv7L70
	 K2XG0wDGQAuBoC2C6ckb/UgJ2SHKNbbK4AZ8FDAzX2mvL/bDeQ41BAO47hATvW17Ty
	 oM33r1mHKEAtPpj9rLbeQlfH1IVUKcvXZowqGag2ZMp0kbr2YiaWR6Gk+OrrbQjg6S
	 jXVukFwKBtT9t9rOzghoJJU1iu98uT+UbptlAwu24M7ZvAO/PqInYlo2QMclV8Elzn
	 gp4cf9aAd9wZA==
Date: Tue, 12 Mar 2024 14:49:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] string: Convert helpers selftest to KUnit
Message-ID: <102f201b-2ad3-4b41-b1bc-5280437aa820@sirena.org.uk>
References: <20240301202524.make.800-kees@kernel.org>
 <20240301202732.2688342-2-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XZgOaFjFlqex7GrJ"
Content-Disposition: inline
In-Reply-To: <20240301202732.2688342-2-keescook@chromium.org>
X-Cookie: Oh, so there you are!


--XZgOaFjFlqex7GrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 12:27:31PM -0800, Kees Cook wrote:
> Convert test-string_helpers.c to KUnit so it can be easily run with
> everything else.
>=20
> Failure reporting doesn't need to be open-coded in most places, for
> example, forcing a failure in the expected output for upper/lower
> testing looks like this:

Reviewed-by: Mark Brown <broonie@kernel.org>

--XZgOaFjFlqex7GrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXwa3IACgkQJNaLcl1U
h9CINQf9FZyCr1mwwp0I0ZAvYxN46NqkeDDqh+wPU6w/4KHNRiUlyQfkNRkAA+Xp
J+5TZcZE7OILqEngLybT0YW7vgEfBTGn6NmKimShCJPz1eQkHlpTYJj97IdgSd1x
y1US39o1HeQ2FjJhdDYpPB+oP7x6D/kNirLmwDO3apllBdGOKJdUrRt4op3xX0kE
Ati+hous5ZkNRKCbdk06Esgza2V8KunLQS66F1pamYICOFtvbLce8PwpGa7p4osr
OX1P7ilURCNOTf6f0++n2UI77pwN9cW8a2j9CRneXNcRz3+M7KE09B+XOc6Cee9D
rAns/5JTYWJzFu0SPe/1g2dxpTVBrg==
=pn9z
-----END PGP SIGNATURE-----

--XZgOaFjFlqex7GrJ--


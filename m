Return-Path: <linux-kernel+bounces-43375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A368412DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C981F22021
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F132AD0F;
	Mon, 29 Jan 2024 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm+t7Cdd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46F776C80;
	Mon, 29 Jan 2024 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554654; cv=none; b=qp8uW0LcnnGghHbCEntzXV5tcW3K3XqAgpRf3p6p9kunkMRKPaRMEU/YiOrLt1OL0wVaAxFqr4Zm+y0HPHJqqii9OcsyZueZ0WvICyeOR1hKBDesAV++A32vWDi3qfMgU9JHL18ojTHiLM8oOoI91irJwuOQMPrNUTn5Lqa6g98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554654; c=relaxed/simple;
	bh=SwDdJL+Nm9UEEmIj2eW+6ZzHj7AInw4B8ATbaB0vh7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTaSVmCXdtvbDNA7ZC739B7MeZ/XNjB18w8IeuyIZxdJCkaU4VeQB3F8Eq3pWfq0FS3UaI3dYJtQjJMxmgRKPX5ZyOhoZjcLp3JbV+5Lz5oi1ii99sowvyFQuT6DktSzUqbPnPMhZKEB4A9cqXHu9ZxM/jI1w0bNzCjad6Hg0xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm+t7Cdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD05EC433C7;
	Mon, 29 Jan 2024 18:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706554653;
	bh=SwDdJL+Nm9UEEmIj2eW+6ZzHj7AInw4B8ATbaB0vh7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hm+t7CddhYd3Bj79q1h2YjXnMdphkCvMPuOxR9oY5y6nTchHGliBNbYe0eYCFIIKr
	 qWBmDqQVZjfUepf7YlUx9EjlgNa+LePJQMEMr3IJ1zXKkXZ7XXdWR2XoB2/XxR+Jid
	 Z33d2V0Xt1jmRp6JpXKq/E5CmksuFPgH2EYw8W1qy9ijoQzhjn4R/vJVzdBlT9ZfpR
	 Vo46e1b6BieyguxmntOfIOoRtane6g5UiGDP5JK4Y1kidNgof8ttfxVpSYvjo5qJxc
	 Kz9QEn8e/jPJ63j9vZGDnUWRasv/T70fFSW4NKF6mJxXeFvGzPFk3o7VFxGrj27azy
	 e3FxQ9AjfxnWQ==
Date: Mon, 29 Jan 2024 18:57:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Conor Dooley <Conor.Dooley@microchip.com>,
	Arnd Bergmann <arnd@arndb.de>, Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the riscv-dt-fixes tree
Message-ID: <20240129-enquirer-rice-cf33d9da89a8@spud>
References: <20240128144537.78dcaf09@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VgeXS1sFY9w1/+LC"
Content-Disposition: inline
In-Reply-To: <20240128144537.78dcaf09@canb.auug.org.au>


--VgeXS1sFY9w1/+LC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 02:45:37PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
>=20
>   a75f0b6e6f74 ("riscv: dts: sophgo: separate sg2042 mtime and mtimecmp t=
o fit aclint format")
>=20
> This is commit
>=20
>   1f4a994be2c3 ("riscv: dts: sophgo: separate sg2042 mtime and mtimecmp t=
o fit aclint format")
>=20
> in Linus' tree.

Now dropped thanks. Ended up getting a new platform maintainer who send
it off themselves :)



--VgeXS1sFY9w1/+LC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbf1GQAKCRB4tDGHoIJi
0qVdAP9bhzmgws8NEXNBUF4pLmbTOkfELUoCjbXZNm/BBGMOHAD/ZegsMs3mJHPr
W/m9xlsWSDA0UxuI39p3iikJd0gojAw=
=qItF
-----END PGP SIGNATURE-----

--VgeXS1sFY9w1/+LC--


Return-Path: <linux-kernel+bounces-133034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8DA899DCE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D5A28329A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9B716D32F;
	Fri,  5 Apr 2024 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP12FiEh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10516D305;
	Fri,  5 Apr 2024 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321976; cv=none; b=OtZlXMOjQu/g7L3efNIGXzov+8PU456MRCN5nhzIE6qtVQSzh5IXhbL3+GuMGZtuSfD2DsYUsn2wBPFp0YGkQumXVV6oEeqbJP2auihJAKN37ET4RnUVYYdBNyAU0m9DfGJq2VVVjBjGk5DycZ6QUk/6WsAT9dYmb7PJyWHubdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321976; c=relaxed/simple;
	bh=j+b910jRggc+Z+Ag2kaw7df8pCW4UECJr1dOGtXjaig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyufp45c/SazihJEWypgVf+mZYdLYxpa0D7J62W7sUxcIz7KEHAWroxp6hofd9wpN03hqOoRm/tNvuq6ZqTkmt7NPn3qVgBm9UqdwMe4fDhrF3G67cDgxVswV6S7kQlxOWxwTxTtGJJ3/nC67Tq3jInuiOFyPIDCPI4t4baYZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP12FiEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B962C433C7;
	Fri,  5 Apr 2024 12:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712321976;
	bh=j+b910jRggc+Z+Ag2kaw7df8pCW4UECJr1dOGtXjaig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LP12FiEhh1tfOqNjA3XTEbk3BOPPm82yZ4TC1YfQBKcefxBU23AaYhktYqpwFhHin
	 FJpamzi5LeXcKDyYmyQhRWu+KSC/snU7/FH0R1M+2oyUC4sYL+YFGU+p8Gw5d7vb88
	 PS8D4XnA9JlhbfEBmkx1pwnHZe5uQI47xbEvCzkxawXTbF/E12UemrX48taiWp7n6/
	 QxD0Q2ohp8nnItKsySLWEGTpDDQzJ7mODKgqJznFwIHM4cF46aRxbFM57lrcQ7/jkq
	 /lVy2m14ccAGMJAeldQ9wSStWf5KcGmZqFjBVI9g7viTBfDBdvNxXDiqweXxtXtVJp
	 kLQbK1fI+p2+w==
Date: Fri, 5 Apr 2024 13:59:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/8] arm64/sysreg: Add register fields for HDFGRTR2_EL2
Message-ID: <4e594f2e-61a4-4068-af59-c81321fbfdb4@sirena.org.uk>
References: <20240405080008.1225223-1-anshuman.khandual@arm.com>
 <20240405080008.1225223-3-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VB7IkGFdiG69TJtH"
Content-Disposition: inline
In-Reply-To: <20240405080008.1225223-3-anshuman.khandual@arm.com>
X-Cookie: Honk if you love peace and quiet.


--VB7IkGFdiG69TJtH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 05, 2024 at 01:30:02PM +0530, Anshuman Khandual wrote:
> This adds register fields for HDFGRTR2_EL2 as per the definitions based
> on DDI0601 2023-12.

Reviewed-by: Mark Brown <broonie@kernel.org>

against DDI0601 2024-03.

--VB7IkGFdiG69TJtH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYP9bIACgkQJNaLcl1U
h9A23Af+OOTuLWiKJzWkExcPelcAYQ3jeCPvm/oGeiCoIhr9UhGnd9UXTCprJQKr
IbVZI4lkM/6oUkXAcan7B2ZPF/uN94XTFz9TAUTVIrwW8+OR/7jOwoY0EGqHGeno
0vaLwO9hIKM/unjKrrxlEzYw+A+JppeWe79pJPcUuwAFnilZV/xgNcieWAaZWeSY
ePEl5NeaW/ARC9gG5xr5sKvnDVq8QXQPEpXSSFW9vL+gKO5dBRVzcyuAFszRD2RG
AyiR1HYZdnCKKRVdgm4t4QLp7ytPpe8UMth8eQ3b6/WUn3CmgcBkJ3FAosYJWA9O
nul1V1EYnyiyte0/UD8j6IVvp6N3aA==
=4Po9
-----END PGP SIGNATURE-----

--VB7IkGFdiG69TJtH--


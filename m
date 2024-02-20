Return-Path: <linux-kernel+bounces-73216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A478685BF7A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E86F28338F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5E2745D2;
	Tue, 20 Feb 2024 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iks4cCru"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389CA71B41
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441712; cv=none; b=P7ccmc6kZFh381h6CEi3dHkFW26BmJmCJ2b0pbgEu6o/AHIN1J2hZDFDhlb4y25ZipvD3KfLCc+XXtSiwjyeOBWNaLNdLjVAnblLaESWiWPG6l3H2UkTnQ/95S1C6ntVrXsYzhEK2RN+lMslid11UGNUZCSslD/u+6lhe2F1YzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441712; c=relaxed/simple;
	bh=Pmt+GvuMgS7hCoJglDDgXMCEkXcCxAif3K2lNTn5WF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6JP3K8HFzSv/yn14sZgDA8ksILQV1DTmV7KS3PgrppI1TLB4/s86pMhiFRyYDZytZOiAlounHYIhdU2eocVAKORaH049E3NyiZHb5UJ0WQvgs7RunE6zUdL+bDCg2u6E7DUQQWKbobib+LHke57E2UY4o4CPTyzr9kjfdoY6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iks4cCru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B81C43390;
	Tue, 20 Feb 2024 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708441711;
	bh=Pmt+GvuMgS7hCoJglDDgXMCEkXcCxAif3K2lNTn5WF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iks4cCruPSd9nb7Jc0mZlKAyAFtrnq0xdKrnIAc0p0FjPykmIaAn7oTmrpYCj+X8h
	 6jhdPnXY2B67qiLXyUedFhTa9sK3a32Dsez0rcLKI40DgzxOeqntUvgxafJWakiCwm
	 dFqGy9vLn+C/xs5vmV93SaVVIaNmFIQ5k/m9fgzz40VgYxzs9Jn4SvMnBw0KVVzSoL
	 riPOw0bOm23Buh20PnQ13OAv+Nldybi5NmEWDXf401O1MtY1JWAOY+Vnijhj0ksQ/E
	 TpTCzlytOMbOOXLXaQXrntP6g+XdR7vOjJY33soOsHNWapQdUKIwiqMcBZ8CcNdCql
	 WeRCsxdRhq2ng==
Date: Tue, 20 Feb 2024 15:08:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/sysreg: Add register fields for ID_AA64DFR1_EL1
Message-ID: <c31cf2b5-ff37-4c52-a00e-d59549cd2f3b@sirena.org.uk>
References: <20240220023203.3091229-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C06Rr7gCSAQY6Llp"
Content-Disposition: inline
In-Reply-To: <20240220023203.3091229-1-anshuman.khandual@arm.com>
X-Cookie: E = MC ** 2 +- 3db


--C06Rr7gCSAQY6Llp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2024 at 08:02:03AM +0530, Anshuman Khandual wrote:
> This adds register fields for ID_AA64DFR1_EL1 as per the definitions based
> on DDI0601 2023-12.

Reviewed-by: Mark Brown <broonie@kernel.org>

--C06Rr7gCSAQY6Llp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXUwGoACgkQJNaLcl1U
h9CdOgf+Inw0wFQcdLDZW/U+Tjk/grIYANmebuYxV/RlkqPUDOByNYTD1Nb9Tqan
6CHciPOwM+UeRoqH1wJcqwVPM2MpnXzLEybQfv+hxL14DayghJMgN1C4rfTUO3by
B3nfNilY6tHmjC6fNnCuwtMaVPRFFv4XoP4tvFsjtu+kJnUv1X7pNWbveBz5pcT9
LCeCqRYb7QoLaU3RPPiJD/0mJa9zmuThlVlny862F6/SrmiXKTq1UzTvLBH8hE6N
/R9rZI5Cdc/0PcsDZ1ktZkayLcLtTQ5oxnEdEoes4IPI4Q1YA4qb+I5ihczu2/0r
L4rnUySnYzHe3PP+NV5PI/Yo2XUvdw==
=i8W9
-----END PGP SIGNATURE-----

--C06Rr7gCSAQY6Llp--


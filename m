Return-Path: <linux-kernel+bounces-66944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A008563DE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E0D28BD6D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED73712F5AC;
	Thu, 15 Feb 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5S4lnRe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD2A12F592
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002043; cv=none; b=qHMwu68eJjveaiCpD6JQr59U/yTmj0IMsGYcAtSAnuhXwZncvj/ZN/2TF/+8MKjaQuX4OCzMEa+W2zJWfMKfWdc/j9wnyWkDtyZMx0NsqQR4zCvWZNPoKiwE6MEfKjStjvHYseg+nWB1JxxrFIZL2+ne7wT80JT6ck/CV2HupYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002043; c=relaxed/simple;
	bh=4SWKPUMv7EW4nqf0ZKZcUDLMsoXj2DKQ/tnY3FHLWmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqCQcXQK8M7lNeHcP/rm/bGHsJ4s0D0BRZc2SlLzmT5ae7fDoYHwW3DtrSsCY5sgzVuG6Sq423kiozDTX2LVuw7kSaXLCwr1aeWZl2HiDX2T0YQpZHlCW8jqqIp9ITNFsritPSreni5sS0h8Vv/oneRHvTw0aGnR/12kQPeEbAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5S4lnRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5609BC433F1;
	Thu, 15 Feb 2024 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708002042;
	bh=4SWKPUMv7EW4nqf0ZKZcUDLMsoXj2DKQ/tnY3FHLWmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G5S4lnRejT1r2cpeQ2pgXFBcKA68xr0Wk2uiA7EcawuOMKFRGgxUcvdQ8cr+PG+LQ
	 88zC7TvqDxEeegJezK6D3qc98krHTD5iq7WPI8mf0gYGF16K0U382KWAV3cfD8AoYK
	 zZhAw3GicpTELP4xerHr+nue3/kTHXusTZIe4hIusVdeSPlk+QjReohPGgMKLHK7l/
	 OFnd19Vw4bTM2yeos//h0v00BoSi5Tyz2kFPkxsHkjWr4WV3xZQ7/V85idlQ5EH0bl
	 pxmb7OjbkgPyKC/WSbNvMgh4aZ5PHdwQtyXqDMBRJeXBgBfpqlsmKZR/aXT1dabyE6
	 YYXd5CA3hgSOQ==
Date: Thu, 15 Feb 2024 13:00:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: Update ID_AA64DFR0_EL1 and ID_DFR0_EL1
Message-ID: <b103244b-7776-48fb-8055-5c003d773087@sirena.org.uk>
References: <20240215055159.2440898-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MBoz6r3Q+x2lnwYa"
Content-Disposition: inline
In-Reply-To: <20240215055159.2440898-1-anshuman.khandual@arm.com>
X-Cookie: Pass with care.


--MBoz6r3Q+x2lnwYa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 11:21:59AM +0530, Anshuman Khandual wrote:

> This just updates ID_DFR0_EL1.CopDbg and ID_AA64DFR0_EL1.DebugVer register
> fields as per the definitions based on DDI0601 2023-12.

Just as a general note for non-trival registers it's easier to review if
we change one register per patch, it avoids having to re-review the same
registers repeatedly and for incremental changes like this it helps with
the fact that diff does badly at offering context.

> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -231,6 +231,7 @@ Enum	3:0	CopDbg
>  	0b1000	Debugv8p2
>  	0b1001	Debugv8p4
>  	0b1010	Debugv8p8
> +	0b1011	Debugv8p9
>  EndEnum
>  EndSysreg

This is ID_AA64DFR0_EL1 and is missing at least an update to PMSVer.

> =20
> @@ -1247,6 +1248,7 @@ UnsignedEnum	3:0	DebugVer
>  	0b1000	V8P2
>  	0b1001	V8P4
>  	0b1010	V8P8
> +	0b1011	V8P9
>  EndEnum
>  EndSysreg

This is ID_DFR0_EL1 and is missing an update to at least PerfMon.

--MBoz6r3Q+x2lnwYa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXOCvUACgkQJNaLcl1U
h9CLoQf/f/tySnlXtTw6EwUy+PReauGlutR8QcsfdBL7cZt2PBLrjiqatIGbOmQN
HYOB6Vc0iov2pqM0XoQckqy+8ZZdHbLShmkLUUft0M3Fa3sVy+SoOsCBgGEr8uFb
KSfnQmNPDqz8muO9ohWY+i4aiigjgmLilv+6izPBxlo+wxv/MtO2mvfuCOVpoBa3
pa/Lop3hdNB8RwP36hfCcX7irtWVlvCmjodl8pUdMJIBZ8Q1AJiKFKwkdqwQL0t2
IgUzVT2nlkTS2AvOeruoczvp/vPRdCvTEsa78+M5VqGfUg4QIqiOdrlpvUrrmJh1
5aS0cgkvP5PXJU9hKsVWKkWlk9atfg==
=y6dC
-----END PGP SIGNATURE-----

--MBoz6r3Q+x2lnwYa--


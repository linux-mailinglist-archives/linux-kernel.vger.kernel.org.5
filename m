Return-Path: <linux-kernel+bounces-133054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10052899E1E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4BE6B212DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D4F16D33A;
	Fri,  5 Apr 2024 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSG6GGXi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86C16ABDE;
	Fri,  5 Apr 2024 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322981; cv=none; b=h4al9zmvIaVwzNZaUOQs0aRMv76HAnam/KkxdAK6NTRLpjf7+Lb2x5BPf8J/wkC8PSw5LuBNzlkSGWKr0/CjHrWvO5Yrad9blS6c7Fq6w39wCJefz2GVeDHVPtEZYGLOL/s4ZKZ5jcPGt2ZiNAd7hi1VEwE1ovE26wG8keTXvks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322981; c=relaxed/simple;
	bh=qwfaU0u0xLh5iRlmJggGU9Ltv3x47SknZooFmsA6W/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvVes0jb/sF/n+91EsyLPXs9VWrdHMFECQ0xWJ5Eqp6PaUwIiH/3wlsyJzR/qJXtbe7qfrzm2/qv2RSfGUtuUEfzaZIoNAd/Vzi9wIBo1RytYL4SlutUbL+h/pDOtGhBg8XNsrs0q3K+4mye3vzpY2RSIZZOGehaavoQAp8ECDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSG6GGXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F88C433F1;
	Fri,  5 Apr 2024 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712322979;
	bh=qwfaU0u0xLh5iRlmJggGU9Ltv3x47SknZooFmsA6W/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pSG6GGXii8+7JoNp3tmKY9va6KoB3da5HFxSg0oi0RPmdQ1WzZCCMTNExq8Ivbrq5
	 ff2AGQrMSJkai/tsuPFBiNFZsmCxO6GT3EjEN6bAS8SqcTDVi4xyGJ4qDsA5dyWX/x
	 bd4U/JVMTQ4jfhRqwH86pDgigmCM+PC/RRd+8R7oSkgwKecsg1H7tZWB+/Ey64Jrcx
	 m7yluXVUKV7Ul4G0XR5lum6aOz7aKaxPDb0pOTIEIeHkOH8OfFsS/8aGFOu6TK3Acz
	 AG/eWcODXNTFcSrxyzMYhPGVCv3mFfqhq+m/AdGk+7kT2s6EkLwJpFS2fPq8Oahxdc
	 nYYywi8L9YHYw==
Date: Fri, 5 Apr 2024 14:16:14 +0100
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
Subject: Re: [RFC 4/8] arm64/sysreg: Update ID_AA64MMFR0_EL1 register
Message-ID: <9c7be563-7af9-42ef-a13e-d04493bf70a4@sirena.org.uk>
References: <20240405080008.1225223-1-anshuman.khandual@arm.com>
 <20240405080008.1225223-5-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="If4EORZDdzM3G+6G"
Content-Disposition: inline
In-Reply-To: <20240405080008.1225223-5-anshuman.khandual@arm.com>
X-Cookie: Honk if you love peace and quiet.


--If4EORZDdzM3G+6G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 05, 2024 at 01:30:04PM +0530, Anshuman Khandual wrote:
> This updates ID_AA64MMFR0_EL1.FGT and ID_AA64MMFR0_EL1.PARANGE register
> fields as per the definitions based on DDI0601 2023-12.

Reviewed-by: Mark Brown <broonie@kernel.org>

against DDI0601 2024-03

--If4EORZDdzM3G+6G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYP+Z0ACgkQJNaLcl1U
h9BtPwf/QcCvhPN6NLz+qvvMBLRj2nmUSW8C0FH7z9QyQKLrx49JeMZjS6StTu3u
GJI4l63r9QHQqAL1quOmAtBMbe+Nse67QZ+TcbB9p+8zmNaBRm6dE9GyY7oDqeVJ
is2oss4rRINkDqsKSEPoPIiLTZsbnxz++uQzzIq0bOx/8mEg7+Vq7KxQqUT4T/jI
4yKhMTTVafW3M5QxUQSJnCt1U2i7URgtn8OmZdmnyP/IkW+mclbOjOS66H2aA0ea
uEYWf2oWPc8CelIKHr2g5mtZaEf1X8liM507yxEvna8FQ/gntuRrWqGVB76tdvuB
v13frDL87dHoeRulgqC9SuoBBvv4zQ==
=biW5
-----END PGP SIGNATURE-----

--If4EORZDdzM3G+6G--


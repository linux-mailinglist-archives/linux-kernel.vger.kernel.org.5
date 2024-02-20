Return-Path: <linux-kernel+bounces-73228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCB285BF95
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1851C21009
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2AA74E38;
	Tue, 20 Feb 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT5yJvk6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CF974E2A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441992; cv=none; b=IqyUfArYLHS7s9y6NY+Po1mnB/WnuVaEf/h0TE97OhAFQAp/14Hfh+jIALj2aGJiYtfq+FEvHqpXYbMzDPVqPigDF/49zv8Rct51jH6sinXyLr7UzUOyk8gede4k2TknsPLSrlu9TasGYXX8/JlkgjiG6WUZ5lMuHEArCb3G1WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441992; c=relaxed/simple;
	bh=u9XzJSxwahXnlg4PyrwtpFwUO8y2aVA5WP+RZA2AYNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfToIf3TtYlydpR8p0/AA6zUIPLOJVFA0hwEd0ChXSsagqrC3bTLi2ScbReI8HsNqCr3J2SAW0E6sKKwFxZpGYOJiHfdg+7RRT69xgP/9egfEhr0f4gyvz1jba/UI/Q8sEQhix6m9lvCeAttLAfaYpLitYxEeypFQXnk2lnpDN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pT5yJvk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E822C433F1;
	Tue, 20 Feb 2024 15:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708441991;
	bh=u9XzJSxwahXnlg4PyrwtpFwUO8y2aVA5WP+RZA2AYNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pT5yJvk6flBYCPEf/x8H0WbdPgXKvQogS4rcbkcykwsKObMLyUGKjKNkzA/kmPd92
	 kXBDan9Pow1V7tosUgFrxMMRGTtaq7P1wOW20Q1Q10EaJkWlxrjxYwq+npuPEsGWyM
	 XBzuYQ4Ly1arPgB4zir2OW28hAIhzHoylh9onaS1v/CQwr6HH5qV/pqM+nMZULhSRr
	 fKItwbOmfXne58R8RqPkyQPUOSJE+LtP0H0IzA6AdTSvvGPUqdkilIWwusDwUj5P0B
	 7+f5W41p3xv+XiRJoypp6Qseb3WLklD7PssD2ULw+hMXcDlES7nrlWhumjaOHEvk6o
	 jIn5XLG/s/MNw==
Date: Tue, 20 Feb 2024 15:13:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/sysreg: Update ID_AA64DFR0_EL1 register
Message-ID: <bea8006b-4f4e-44e8-af68-3a52f8bace73@sirena.org.uk>
References: <20240220034829.3098373-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pRlXzp/2Iqf0vvJx"
Content-Disposition: inline
In-Reply-To: <20240220034829.3098373-1-anshuman.khandual@arm.com>
X-Cookie: E = MC ** 2 +- 3db


--pRlXzp/2Iqf0vvJx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2024 at 09:18:29AM +0530, Anshuman Khandual wrote:
> This updates ID_AA64DFR0_EL1.PMSVer and ID_AA64DFR0_EL1.DebugVer register
> fields as per the definitions based on DDI0601 2023-12.

Reviewed-by: Mark Brown <broonie@kernel.org>

> @@ -1223,6 +1223,7 @@ UnsignedEnum	35:32	PMSVer
>  	0b0010	V1P1
>  	0b0011	V1P2
>  	0b0100	V1P3
> +	0b0101	V1P4
>  EndEnum

There's also a FEAT_SPE_SME documented in the text but not in the table
of enumerated values (I've reported this) - it makes sense to me to skip
this until the XML is internally consistent.

>  Field	31:28	CTX_CMPs
>  Res0	27:24
> @@ -1249,6 +1250,7 @@ UnsignedEnum	3:0	DebugVer
>  	0b1000	V8P2
>  	0b1001	V8P4
>  	0b1010	V8P8
> +	0b1011	V8P9
>  EndEnum

There's an IMPDEF value defined for this like the 32 bit equivalent but
that was a preexisting issue.

--pRlXzp/2Iqf0vvJx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXUwYMACgkQJNaLcl1U
h9AfJAf9EgSWYZatFiomGhYXIxcd639txspikzYCdkog8+OPQe8z0W0fI8NVVR1m
VekaiqEUUvVJDdgZxq6mVnfEjehEcJMmZAM58MzRbvnrbjAPmw2N0p0+xhb0ciuU
s0AfFhL8EBtQdaewN6oPqqGSV4+Vh1bRaxL6N9nFrRoMsKfgvCwn3Sn02fh8sqCa
wshJ152hni7hP2MR39gVUGQ6ykOKM3jxvLRZ7t2Mv9OVRcWK4PVDNH3iL3+uI+ul
LXjvKPtVqAajfQfpLaBGr4gHwqcWwT1wa0Bo0SBxA2KGx1xdJfkJFMCpXdOGMAL/
dBIPvPpj1Hn9Ah5zhMASgpX5uRw5Uw==
=a+nz
-----END PGP SIGNATURE-----

--pRlXzp/2Iqf0vvJx--


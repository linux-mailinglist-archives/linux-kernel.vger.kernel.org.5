Return-Path: <linux-kernel+bounces-133045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0845B899E02
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63862843E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1A416D330;
	Fri,  5 Apr 2024 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyLgKTb7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABB22E401;
	Fri,  5 Apr 2024 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322537; cv=none; b=sLq47g3ND0Ew5q3J0iwdFvUDV/luWj4kgqi0xsg1usstZcWeVWq3Ub0s0p1pDT3QRCaEnkprxCOS6PFjxaWQ4Z5Vt9/z47zGKr6bdRUht8kpG5ufY+bZLKC+ZNlO6zUQurk2U1aA/OwI9fzsjddyqSs2ZhR/ZEEmbLlajzRFF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322537; c=relaxed/simple;
	bh=Xe7nVW0JBFWDHIxg7l4howMZi+d4mpWPEXxg8hrnZU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJZduGIBfQkq/XxH6mRZPSF8HYPskNpnchImsquO45GGfvion7hgaEcTwpiTcc2nWTOsdgflTBh1pVpB0AQcbs+n4uaWDx7pIDHAA4lo2JA01YEXtZa5NnSK3gqLtAnY8epemOPYUCq19OYH5uITkDlZFj0fyB0kuXjTciDYx4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyLgKTb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FE7C433C7;
	Fri,  5 Apr 2024 13:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712322536;
	bh=Xe7nVW0JBFWDHIxg7l4howMZi+d4mpWPEXxg8hrnZU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyLgKTb7anHyu2Mzr/VlqBQGyRvDmOEXY4HG6CW/4i+EuAHp2Bs07xaJpUZVeYN5N
	 W2mJhyy3fQbhLg3qgpyW0tHlDizeJI53/Mgbk0hH43Eia+Uel8Gpsp8j33eUaMDONP
	 q1nacHO48J2upJXUFimtiCUhgdOx1CxLGbn6EskczmLuKxvR6RUWAqepmU/0KPLLRt
	 /phHACRUqpofMF2D6/9iO7cQxOJM2No8KqbZyXKflHfuF5Z3KRjh+puypTvf6kLzkc
	 ZdonurX0i8WLNk6OVQYi1M85muI+BOtTUxdCVLwqpr0DXo2LqBdWIFYs0oLU8nS7RE
	 5hV7Kjz/X1emQ==
Date: Fri, 5 Apr 2024 14:08:51 +0100
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
Subject: Re: [RFC 3/8] arm64/sysreg: Add register fields for HDFGWTR2_EL2
Message-ID: <f1379a5f-1108-4ebe-a006-3ac3b4361bdf@sirena.org.uk>
References: <20240405080008.1225223-1-anshuman.khandual@arm.com>
 <20240405080008.1225223-4-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2jrabBnn+j8KSDKh"
Content-Disposition: inline
In-Reply-To: <20240405080008.1225223-4-anshuman.khandual@arm.com>
X-Cookie: Honk if you love peace and quiet.


--2jrabBnn+j8KSDKh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 05, 2024 at 01:30:03PM +0530, Anshuman Khandual wrote:
> This adds register fields for HDFGWTR2_EL2 as per the definitions based
> on DDI0601 2023-12.

Reviewed-by: Mark Brown <broonie@kernel.org>

aginst DDT0601 2024-03.

--2jrabBnn+j8KSDKh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYP9+IACgkQJNaLcl1U
h9BUtwf+Py09x70pYCnhRzZwf9hDn+ZXXJ/ccpPKKXkp0HHxx7bSW4gNE8hvtd92
8nfp/KnO50rpH/OAHfMEY+xM76pqSvsMwSyTeQSJR/yDcjbQOEFZ4oNPWYwbZW1N
QNNNIoSBpES27A0Mj/CpDiBVu2LHXcS3gx5vOE+k0dCjnN0Z/wmTcnqa+S+UeyQR
hXDdNmg88PnpTbfqYyvbHyZXzoQ+GmnKw74WFqce/LB4iZenE8qvsElNQbWblMn0
p+6kyAS/8mQCtZALSNyjt5UfBugvmFCpjpbT649AdbCXvy1ZBB2AW03Zb7FgsDMC
dkHUwNpF5v/iP7EzZOpzGfdJ6DcwXw==
=LdYu
-----END PGP SIGNATURE-----

--2jrabBnn+j8KSDKh--


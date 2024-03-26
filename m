Return-Path: <linux-kernel+bounces-119674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9D88CBDA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364001F86093
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04C38627B;
	Tue, 26 Mar 2024 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjgrPov3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C12D1CAA6;
	Tue, 26 Mar 2024 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476994; cv=none; b=ZErd3fshhJKelHhdX5OutLXRU8t8fqmCMcnMcDmXDYIMDYH/eTxD9EqzELjiaAl4kDdfqSqonNDShGc3rSrO7m30QgiKSPBGQ7FAxc/IA8T1cGuhMbaRtpExFSlPjXIJrZYVJNem366WwaTPpPoal7piW+REr938hs+QpHlbxrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476994; c=relaxed/simple;
	bh=uE1PCGry2C3KAziExolCdXLEmnkMrxJrBq9fma9G5bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epcoX45GWS3R/S5G5E345jw+2UKuPhQtamMzhoKKprs+PhrN3DZB3VE3IaCyTB6Z/jdeuy3rsU/UBDWuQ0VPVdJWK8LBm5ZH++LSrGrDj6C53czni39JQnpUOST1LPJcEl8blV23KmsomrtgY01ZtU99VIor44ntZfdVBD9ADlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjgrPov3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D496AC433C7;
	Tue, 26 Mar 2024 18:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711476992;
	bh=uE1PCGry2C3KAziExolCdXLEmnkMrxJrBq9fma9G5bY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EjgrPov3ARcTNv+E6ROoIN/SV//236j46ESmnVCp7/dz6qqzMR+t6xHxm78v6jGDg
	 If4HrrwDcYowWOtGnYqX/iaQw9eTFAR4WTtuE3/T0Qhpc7dzyo9CM62yRL5ziO+EMq
	 Wl1q/WEea74tYce5ognkYGx3kkBAUnSJhuZN5mCwjWREQUDnJ0hdJg7OwK7uQNc+u1
	 e+4llKKZ3ILx+7+6POVn806PR1dFBRbQBMrhLn3KxFSlB42WFIn5422/Z1HX52Xic+
	 x6RhohfZKKcfZlZENlNwA9yFe1eOFQ1QGaoPin9ZF/Mn7btot+sWr0ITzolyHC4W0q
	 7MpGiBzyLAngg==
Date: Tue, 26 Mar 2024 18:16:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 01/10] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
Message-ID: <14f08a50-edef-4b36-891e-2b4b2283f40c@sirena.org.uk>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
 <20240326181027.1418989-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="02hLAl/Gk7DHYzY5"
Content-Disposition: inline
In-Reply-To: <20240326181027.1418989-2-andriy.shevchenko@linux.intel.com>
X-Cookie: Equal bytes for women.


--02hLAl/Gk7DHYzY5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2024 at 08:07:51PM +0200, Andy Shevchenko wrote:
> Drop rather useless use of ACPI_PTR() and of_match_ptr().
> It also removes the necessity to be dependent on ACPI and
> of.h inclusion.

I think the ACPI dependency there is as much about hiding the device on
irrelevant platforms as anything else, might be better replaced with an
x86 dependency though.

--02hLAl/Gk7DHYzY5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYDEPsACgkQJNaLcl1U
h9BfcQf+MyppfojZvc5Bzad4vswSibGPW/eX/Ah+HKVl8je+MCOV5zjAsv7LsFDR
ivHdSBESyAUR5lDMdZ4It/Kf2zPElke0WbKT227h7XKHmQEjZSMXkWxXOfh62Qjk
e7WOBTCcc1EOZSr4EI+S2bLHW/EL9fg9rNeFj07Hy5ucQfHZREJ3x8wyu6G1QWE7
kOWF2cKhEykLS/g+Vyd9iXyGjR9HLkIGEz8duxSatdrk2B7F/5gO67E9wDej7Ikh
+Va8iJW0JgolKWtyk9F0MpYdTm3r1wmRtOA/3UQL8hK3M0bXY7EzfYfnQ8pFblig
1iFyFaxWSQBVlxBBdjsJ0K7Lo7Ua7g==
=YGEB
-----END PGP SIGNATURE-----

--02hLAl/Gk7DHYzY5--


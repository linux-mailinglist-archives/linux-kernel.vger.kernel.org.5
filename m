Return-Path: <linux-kernel+bounces-42635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA45840422
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AA07B24250
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DB15B5C5;
	Mon, 29 Jan 2024 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhsCfzMt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A855C8FC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529005; cv=none; b=pY1tW/VRFRUQ8pYj8uhG3SxF9PViQ2y7ks5+dMJRUiyokzKLiL4eaoQOjxAPJ8kofuqyI00OVbnCBL9Z6Y0uGscR6LuyahBOQ+EQ1ayRSyswrI+e39WODbNs9G9sYFfOBSD/hlDdXkAGcAv/VQnNtR/hMPWK+ICWguWPcGOrHZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529005; c=relaxed/simple;
	bh=d/7Cao1fa5uNtHVJeNeOcyV5BXPwyg7qKYG0DlJJURU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=px0pX+qDgX+suj00iaBuztu7pOErCrNiV9GWE3NQxZG9dJesfVEtuQNiliCmC+8fHuhG98j126Sr6DKAqWM/zx3fSK7z9LIhFbg09Dr8qq+TSOqUQIUwM5iDOxf13tJ7E98D/KJi+sTHcMvgnbLPismbMfBJRzMgd1aqxs4UB8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhsCfzMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5D6C433F1;
	Mon, 29 Jan 2024 11:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706529004;
	bh=d/7Cao1fa5uNtHVJeNeOcyV5BXPwyg7qKYG0DlJJURU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KhsCfzMtF+wa0MRKxpY6wjlhTJZ9p3pPVJ/mL6dNu/h5UzruWXsGFrwwg+zXoMdeO
	 faqJYtcL9qn0Ag34GPs9rPYMRMi2VOzHitogsyekads18D0O8mThUZgCHLVppzKXEj
	 PNcicpWZFcv310lzAeP/WToWutVe7YRjlCwP/sGmeJe/KC5m40ugmlQQFdZJh7Yiwz
	 sLPqf7DLssf7x5tA1/9w8DXKGTdWrXAEBj+ZlsDSMVKIaD4SVm7dAM3ATQ2U6zeitY
	 6Dr6P3QKOqLzD9pbeHdve+EiHxDhO5Wqi03qrRCXVy0yWsmVuxaN4RG5mthSlu2QCJ
	 bBfgJBbtSqkfA==
Date: Mon, 29 Jan 2024 11:50:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	sudeep.holla@arm.com, robh@kernel.org, conor.dooley@microchip.com,
	suagrfillet@gmail.com
Subject: Re: [RFC v1 0/2] riscv: Cache Population Code Refactoring for ACPI
 and DT Support
Message-ID: <20240129-disburse-plug-9f4a37c550f3@spud>
References: <20240129075957.116033-1-jeeheng.sia@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o34RwNIDBnTGdKPm"
Content-Disposition: inline
In-Reply-To: <20240129075957.116033-1-jeeheng.sia@starfivetech.com>


--o34RwNIDBnTGdKPm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 11:59:55PM -0800, Sia Jee Heng wrote:
> This series of patches refactors the cache population function to
> seamlessly accommodate both DT and ACPI-based platforms. Additionally,
> to streamline the code, the unused parameter in the ci_leaf_init()
> function has been removed.

Why's this an RFC? I don't see any mention of why.

Thanks,
Conor.

>=20
> Sia Jee Heng (2):
>   riscv: cacheinfo: Remove unused parameter
>   riscv: cacheinfo: Refactor populate_cache_leaves()
>=20
>  arch/riscv/kernel/cacheinfo.c | 50 ++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 30 deletions(-)
>=20
>=20
> base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--o34RwNIDBnTGdKPm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbeQ6AAKCRB4tDGHoIJi
0hrSAP9VpSG7xJ0EGkIkENZOYmiIn8wZFM2aQt/wBKaDPeX7fwD+Jx9Ffx+YGruo
IXh5n+p/dDi2z5gI/jsh/cRaRPk/7ww=
=0ZiD
-----END PGP SIGNATURE-----

--o34RwNIDBnTGdKPm--


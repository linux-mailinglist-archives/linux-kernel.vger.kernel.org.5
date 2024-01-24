Return-Path: <linux-kernel+bounces-36685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087BB83A4FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF51C28D0EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FAE17C77;
	Wed, 24 Jan 2024 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dF3ueRT8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3EA17C62;
	Wed, 24 Jan 2024 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087763; cv=none; b=aVxLQ58Qr8TyXpwzEBpP6Z4DHDsg0NYp11+RWKggxiSFBi2W5Z3RKGc28tEHevW19r27WJJoPhI+y1R7bGilnXikFIKzZFT4hf32tDoCTG2NbQGB+Loc+RV0xK92/7Y/khtol7VSRRPjnpYRdc00Kh2P2Y3wsj9QgaV4t+SBSQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087763; c=relaxed/simple;
	bh=u1YoV9dyStDKFJT8OsyND/CVnqRL02V+87XbdWXiaXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud3ylW13hwYdktyNqIl9X4kZq9zJ2RMRIms/45A40sJzrHHdMflBwN1vZvb5iTherTCmbxnpVTJ2wmDgm0pXzxBr0WXBBjkz52Nqa9t/546drol8ora/2cGp9qGMw0NaiEVTzRaIddqAn9rREmr5EvgxdtllDNdCZH+hYNYOrpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dF3ueRT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B2BC433C7;
	Wed, 24 Jan 2024 09:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706087763;
	bh=u1YoV9dyStDKFJT8OsyND/CVnqRL02V+87XbdWXiaXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dF3ueRT8kvAPOXcVLrXdR1DYyiF8NKjD2y87iKoQUH8a0DpKWv3IAVL9D21WDk3Lx
	 /FHG0MakOEtFq7RmxSLysQkDD02jN//w7T9E5mDjgqsoRtO6URCdbMTPKM75yRIuJR
	 fqouBzqAstojlXu49s8Oz1huBEU4eHzs39nIO+XgB5BnwJdC8xTuq+Tl+glMj8q3/z
	 cTTL4jgSx8ADeaUGbpR4kvi4dNGwkpPRZkhJkqFS2Du7lLi1RVH9rj0uTcH2NQZHUM
	 fsz7kVtut0Wb3oCDFaKp8nBXhUu6j6Rds8ujGOw68plXbYHvBL8wpPxLKIqatpRQYr
	 dBQ+nL69i9wlQ==
Date: Wed, 24 Jan 2024 09:15:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/414] 6.1.75-rc2 review
Message-ID: <20240124-gawk-precinct-70addd2c5286@spud>
References: <20240123174510.372863442@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J6riezYmzZEHjQTm"
Content-Disposition: inline
In-Reply-To: <20240123174510.372863442@linuxfoundation.org>


--J6riezYmzZEHjQTm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2024 at 09:47:46AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.75 release.
> There are 414 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--J6riezYmzZEHjQTm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbDVTQAKCRB4tDGHoIJi
0kT0AQCTo0CwghJnmWOVqxcVeqRV1QaioXaPqxVawMNxbpbVigD/VT3aNC8Iybaz
T+tB3EiSbCDU3fisuhDQcXw0BPk/jgM=
=G5o3
-----END PGP SIGNATURE-----

--J6riezYmzZEHjQTm--


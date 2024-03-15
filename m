Return-Path: <linux-kernel+bounces-104584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4626487D074
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD8A1B21844
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DA53EA77;
	Fri, 15 Mar 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYTGh0QP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33ED3D96E;
	Fri, 15 Mar 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517253; cv=none; b=Dqy6es4I7rQSUvNGV25FsHq7fHx6m/xzL/usXUCW7vTQVqGkiBSXs49mIF4DgQReMFuT6Fn/xxXT4bFg/0B3lBD2aKe7NPi5TVdRaL5ClH6jUI+XLoa344R1wBF9RVTq9LvXjwLORLt3Mp3dkJnwD7hl4OYjFv2F3uop6GN/ZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517253; c=relaxed/simple;
	bh=MJf2y2Zflcqhg26B6IegM18VqfaNaUfxtegMhDQiyhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h45azVX2/XCS7sVmUaUIcdEomIMMxANtvGiQsgcJfil3l305cZy5WaOkGUGolnVRfQVCHWstOpbqvwRqtArTNxR4m2bunhaS+RIoeKiy74oXjs+VgJ/Xx2yxNWWs/IIYJenQXC0GMg59Bje5HYd+P4OSsJ9FY+OM7y/pkDRleK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYTGh0QP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7D5C433C7;
	Fri, 15 Mar 2024 15:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710517253;
	bh=MJf2y2Zflcqhg26B6IegM18VqfaNaUfxtegMhDQiyhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UYTGh0QPfCsOWoz6oSpcjVtDYmsHpsLV/sge952M6zG4BJdWah+Lhkp0nEPN4q18o
	 Tjl7kAu1o9R1ZXDmz1cSh5kcxFZCveIeQRWt/OgP6TMNgmuLLCqOC6SwogucaN4WZV
	 pg9kZUl4YOVT0TpR5RfgblBR8Lp7qmL9E/iktw0aqXhrJNliKxYQYBsUz5QDkRYhQt
	 jEyG75X9YqGQAYimcISHtL8Xe17Yar8No2H4ZCTy0O/Cb3FW9NtpC1Nx3RnhihUDXV
	 LrjQHO5HiUiiPFltz/R8k+ejdsMz52oUWramKhHrYOX1g5LFbG9YUYL6JXvN++b7ep
	 hjTJU8y9piIwg==
Date: Fri, 15 Mar 2024 15:40:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 6.7 00/61] 6.7.10-rc1 review
Message-ID: <a4c3ee1e-6941-4426-87b9-c5bf3a58d8de@sirena.org.uk>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bdjzHhYfbtfWjhuh"
Content-Disposition: inline
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
X-Cookie: news: gotcha


--bdjzHhYfbtfWjhuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:31:35PM -0400, Sasha Levin wrote:
>=20
> This is the start of the stable review cycle for the 6.7.10 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--bdjzHhYfbtfWjhuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0a/0ACgkQJNaLcl1U
h9BJSQf9GVyzjI/ct6OiwzPHRdu2znNkxKV2Xz6+XvWxd2E945c52mMrEM9rLr5p
vLQS32l92PC86THfAaYfPRMhTrImLig7ptjTlx4vUr98w21MBzjOQfNHAA72WlXn
MVrNHam491F+nTZ37CeiywiBa8kpPVRTaXwaLw1zW6PfFHtnB5mq7v1gWbh5aMzv
zaajz58u2VruXvthEyQ9zGadh5F4Ecq2SasKgLmRsVn8skBj3A6kjU/A3OHJRMMj
KcqM0tyT/hD2j1HtoXN8wNVmTejZNjL8Z3JjBEh5QSB4LmIH9AMisUSAPFANv2Fr
Q2AYV8zpvKsG1nFD3WyHCqgBbHHViQ==
=4mH/
-----END PGP SIGNATURE-----

--bdjzHhYfbtfWjhuh--


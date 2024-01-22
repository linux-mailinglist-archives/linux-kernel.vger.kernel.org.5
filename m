Return-Path: <linux-kernel+bounces-34160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A541A8374BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548E52888FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A43481AE;
	Mon, 22 Jan 2024 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIIPI7Bx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172B6481A1;
	Mon, 22 Jan 2024 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957022; cv=none; b=kOdl34VaM7TaoSWeKhbgyLcsCVCY6DaR4Aigq0uXqDFIUmZMhg3HfFmxdDfFHxQueXCyyVCFVwIDieizkQ9Rx67IFIXswQP6q4FtdRRUB6p7l1jhI+s4LKZVB7Gd+uxd9SJRukCVwKqUGtqqWTKWJxmGKrheN0VEP9WescdNGUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957022; c=relaxed/simple;
	bh=30vMh/yunuAeIvcrZtsprLMxftdtP+dJWsdphN56t3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkaf+uR44Fvy93q1azbCyC/PSxw0mCDdAo0uH4BwmMZQ95zKVVX1zwYgIvm+ip20aaJ7te9mg/SnIITwfo/UcH4VgfXw+rfne6ABD62BBrlC42oYrU09gsaxyszAmiX3xWSSU8mShni1TSTBS8HMUu77DXx06hnDQUtcEzCBW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIIPI7Bx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805D1C43399;
	Mon, 22 Jan 2024 20:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705957020;
	bh=30vMh/yunuAeIvcrZtsprLMxftdtP+dJWsdphN56t3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YIIPI7Bx31kn7lnd7CuXfJk/mE7AUvUzDq+RMuO/Lv7lnE5IdM4pUJkAlKPJyER4p
	 AlVlcQygK9ExCKg2EnjLptfaajFoT9PeZ23xOBkn7urTlttw31wun9pKNW79rM0LXs
	 ejEr+0qBm7mK1js0TN6HLA3XBSqMQ6SOMC7qwOmJ+yX4vbNO8Laj4yzWqrGOAftkwy
	 OqohG2utwUxA8dHxJWw6Urd1fewMdVDUJbfx+SlAPyce2cYzTxjKRHz8LTH5snrfT9
	 TZVmaktu5SBvSy+lFNeaQbC3hAZL2q0I42KAETBkMgcEzVXeq1NbDG6PW9sUDWw1sM
	 RPbkagdyZeVTQ==
Date: Mon, 22 Jan 2024 20:56:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Conor Dooley <Conor.Dooley@microchip.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the riscv-dt tree
Message-ID: <20240122-harddisk-ancient-8a9d8216d3f8@spud>
References: <20240123073908.0580509b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jhfAtKZIEWbPWmC/"
Content-Disposition: inline
In-Reply-To: <20240123073908.0580509b@canb.auug.org.au>


--jhfAtKZIEWbPWmC/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 07:39:08AM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Commit
>=20
>   89e69872b909 ("fixup! riscv: dts: starfive: jh7100: Add PWM node and pi=
ns configuration")
>=20
> is missing a Signed-off-by from its author and committer.

Whoops, that was meant to be squashed... I'll go fix it up.

Thanks,
Conor.

--jhfAtKZIEWbPWmC/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa7WmQAKCRB4tDGHoIJi
0j0LAP4z/jlD0zRSfnHI5Oy8uJviY57OsXS/FCR9NVFI9EIKkQEAgIcwypfCWH5X
nidrgaaVfzbbt/iAu2xpGOcVdNVcHAQ=
=pKxT
-----END PGP SIGNATURE-----

--jhfAtKZIEWbPWmC/--


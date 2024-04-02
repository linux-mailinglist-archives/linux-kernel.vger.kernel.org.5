Return-Path: <linux-kernel+bounces-128164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B543589571D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69F01C2276D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14D612E1C1;
	Tue,  2 Apr 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3yexSpH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB212AADD;
	Tue,  2 Apr 2024 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068702; cv=none; b=Yq9s4utc09dHQPrELsdNxNUQKYIqybC8EahEgKh1O60PoJO8VxZkzz/DKEWrP7H39aVrEWuuBnTEqzkNqXAC/XRAQnQ2l8ZfZQn655c4nD3ajLQYcCmPzpma5ms7VnuWz8UoWjVQP9gfhogOQlUJYqCTEKKWFEwUrb2xRtoTwfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068702; c=relaxed/simple;
	bh=uaHDgbVpmbCEFQqxLX3e+sUYl7xuSBavCVIbfcGt8I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDW2BIHprchNW9fPVBBBlPCPHnh04HpzkBLowJfdmhEBiDhn+XMMgnuyur2JGCn3TWFMyvpNsXZi76vjN7bsJ4xDWcuqSfJGNFw+N0WwvupozNoN9NG2Jvmjn5hNNJkq9cQUq7D3jDwz8Jjzw7BvHPhpgJ6U9WVgAgo74/O0pY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3yexSpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696E9C43390;
	Tue,  2 Apr 2024 14:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712068702;
	bh=uaHDgbVpmbCEFQqxLX3e+sUYl7xuSBavCVIbfcGt8I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I3yexSpH9Qsi9FB5FeFa5mYlNpof5lBnkvZ/LLhPMBLInVuXCXZZzpqf9HEEX4pA2
	 Us8QJWhkW6hkaEENIGT1nJeqlvtTz9hbuW0d+mHzq4utAj/VY1DxpUCEsOAElB++Z8
	 lmuCueio75lRSAsEEfrWr8dMGrcRb8MyidRZH6x1aCGmXXtY5jH04gIumniBg1ZJVv
	 mED4nrmQcyJ+5PnAW3alWn9jwhFugCC8ew+ryh5j/qpRIHkaW7vvIpUdFXUtuxCR5b
	 b1wgiUJ4SGsRKQd2Kv9k6EW6Xj1H+rmwG76MDiqlV3JNUNZIccpUXlMQvO8yLhJq4I
	 BSwcPxKclTr3g==
Date: Tue, 2 Apr 2024 15:38:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/272] 6.1.84-rc1 review
Message-ID: <1e0188ee-60a1-4bf8-896e-8977694690d0@sirena.org.uk>
References: <20240401152530.237785232@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i/4KLPrS7IgDPwd9"
Content-Disposition: inline
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
X-Cookie: Knowledge is power.


--i/4KLPrS7IgDPwd9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 01, 2024 at 05:43:10PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.84 release.
> There are 272 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--i/4KLPrS7IgDPwd9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYMGFYACgkQJNaLcl1U
h9DZAQf+JKeWntC4LXBIEUKUv1L8b+UC7Axu0Ktzlwr3l4hrcpqQjxvoRBWAz6zn
PyNOwefXtW1Izv94AoS12+DcScrQAbCa6tFIAlg+j0OujehsBP395cSFwxoYLAsr
ddT2LJlmejQFeQzmNn2fFIJczUaTRBNlEg1gjH9jx1hUn9gayirXp9NBu/YUs6Ni
LBAmNxWHoIKmaccJNY4F04qu0IwU7HHShchU3tnZXst68DH6tmhehApZdEAPBWdd
qIOByNjAiudN48HVRJLmY0EqjM2jFbxp/vSmm/22fWY1gNFCb/PbrsXvvsnhL+3U
QfBuA6zjaSOqbnRzMULVLIUyssFi8A==
=jk4w
-----END PGP SIGNATURE-----

--i/4KLPrS7IgDPwd9--


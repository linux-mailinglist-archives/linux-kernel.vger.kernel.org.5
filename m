Return-Path: <linux-kernel+bounces-139314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278CC8A0149
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF81B28940B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624EE181BAD;
	Wed, 10 Apr 2024 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhgIgvvb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B68176FB8;
	Wed, 10 Apr 2024 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780808; cv=none; b=pMZCJOfdgXjm49OasJzYWYRUfMpbc82BikaAZEoo/ZMdZSJDHsY4NnJKg2JpPwDHNeRLRSfsLxTIQy117vb8uvnIesW44NCbR33FxPkyGujR/5nK4mXujInwd+2JKTASF6tXEcEdXGDaKyeWAOIWGnkTI4Ga1Sj/xj1ox3+scrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780808; c=relaxed/simple;
	bh=oY2LxLJjFva2lLhATy/u2Kut5WBp9BASBgwkbHx+eH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVHjD7Ei2jRN6YD/0AxqVOZGIujd2ipShm2xcVv9TY/rde1guN/ddXaBOwqmliuGrgdVTvSD5z828qACmDUYDJPLzefs7c1yxLfGLRZ5Tn/p/s6qxTvBzlus+wtYBtht7epDdmqst3dWuOKXT1FRy/uB8PxjNfwiUz17Jgy8KvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhgIgvvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3158C433F1;
	Wed, 10 Apr 2024 20:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712780808;
	bh=oY2LxLJjFva2lLhATy/u2Kut5WBp9BASBgwkbHx+eH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WhgIgvvb2Ck9MCEyj5UmkbvaO9Gf7jCHf5T9nJs/qlZmqMPxoRLSdfd4aVJYcVyxr
	 BVNJX9c95PudiLBFfAzInLo3Ce3xH5WY7jI8pz9DwaxkHhiqEbhF+ns4E2f+iIzBXM
	 2JqM8J5V/z4DmLWXJrd/YONvFZhqgyjDIe10N/ltNGTopC1QsNh50wO9N3Y7XYOpuw
	 qXAXpGiPBlTJPM3XeLywYauRnWHeukTgxTm9e9GQy43xyAhPt9fYrzplByNQAawX4q
	 P12ZkCS8b7ACH5Mv8wnIbXF6FT0D8LIjQ5sMJ04v3Gn5JmWmwNizrcDyHdl2E/Y+0v
	 vOUDHmaiB9bYg==
Date: Wed, 10 Apr 2024 16:26:43 -0400
From: William Breathitt Gray <wbg@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpio: pcie-idio-24: Use -ENOTSUPP consistently
Message-ID: <Zhb2A-8qHgwykrQB@ishi>
References: <20240410064156.1199493-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c0o6FbusgGPZ6zUB"
Content-Disposition: inline
In-Reply-To: <20240410064156.1199493-1-andy.shevchenko@gmail.com>


--c0o6FbusgGPZ6zUB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 09:41:56AM +0300, Andy Shevchenko wrote:
> The GPIO library expects the drivers to return -ENOTSUPP in some cases
> and not using analogue POSIX code. Make the driver to follow this.
>=20
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: William Breathitt Gray <wbg@kernel.org>

--c0o6FbusgGPZ6zUB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZhb2AwAKCRC1SFbKvhIj
K6DmAQCAsm2qzbaq2MV0vpYHJ3LONjkyJ+70ecG980O+B4VHCQEAq9XkrB5iQKtj
i+jDdj1Ydos0QvedXYD9UJsxKPTB7g0=
=sm5C
-----END PGP SIGNATURE-----

--c0o6FbusgGPZ6zUB--


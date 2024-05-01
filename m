Return-Path: <linux-kernel+bounces-165334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5B28B8B64
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5EF1B21BF8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA2712EBCC;
	Wed,  1 May 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi+bJ5/4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A01433D4;
	Wed,  1 May 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570883; cv=none; b=FRxsSIfx8upSVbmZwylydRPMl7dklRe5TWpIXKUyL7+zTt4K0QK+uaMBQR6TMsva7O+bksCYyEGLm2rEKpDS1S0sOOTQSBkM1mH3rJpZzWIpm4GLJYpknz62LyvG+468v8ZpHxNS+Ah6LtkEkWeF9+L1qldgcIIbJjssl1r6Tvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570883; c=relaxed/simple;
	bh=mIVoFqB2jj8J2sxYV14hvy0QYSo7/s9qBTZexAvJdQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2HhvCRhlPZzJX8/cvc4wyM8QGYR8I/kGO3/EGujvBpyNRDmGvja9r5n85QKZv3VwpDg4TW+tA7/BlLHvTZSrUFwyjPKZKdxv084eJOpqlgw6+TsiZ1D3u86OoZ1b4A5l6Fc+yzr6urXCJGuEINK4xa4riLEP7p2eMg4TFA59sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi+bJ5/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C06C113CC;
	Wed,  1 May 2024 13:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714570882;
	bh=mIVoFqB2jj8J2sxYV14hvy0QYSo7/s9qBTZexAvJdQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mi+bJ5/4FiOmyIY9Rq+a/ZQ9ECPLZYv9ruoIdb75V7cFvAtIgzKxlvC6DfgLgySwM
	 DekG2BVylPkBwMiyNzYzfwEAa2g0gcIPoNdad0fhtgRmvCo5tl2imlaVNbgg42fOrc
	 BpVKHKvOj32en/+BKv3hV7qPExRJKIgS3hgfT5yGT2AlYRhPBMXEQAQOz89wjRP57M
	 Io1Av48oHO0862CsY9ixDDbwiKBxIjhZ2tmRjKHzqMvFAHnX8HgD5wd5N0IH9LpCmr
	 VlBSSmg+Cj3oaTLkNVdstnM2ww52asdEBLdWWzQYExgG7P036cTFUZpZ+P+7eL6S2x
	 Rr7HtTjtY8ncw==
Date: Wed, 1 May 2024 22:41:19 +0900
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/186] 6.6.30-rc1 review
Message-ID: <ZjJGf4mbuTPGxMHm@finisterre.sirena.org.uk>
References: <20240430103058.010791820@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JezNBh0mpCYBWM70"
Content-Disposition: inline
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
X-Cookie: lisp, v.:


--JezNBh0mpCYBWM70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 12:37:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.30 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--JezNBh0mpCYBWM70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYyRnwACgkQJNaLcl1U
h9DBGgf/fDVe+2ryk/BFQsQISwzoV13YmHFivBp5+RF36TEH7Sue0g/h/KsdwI+p
NvoLAvNB4xwwfluqElq/RRIntk63S/CaLsABfg3bEzAzF8Kxbj1sxiRKfsKobtVS
3+BdNDb789wwi0l9smeYbLXIsniEHBN8UIp5eHIhppdj4Aps9gWdrB2+qpfkX7y4
ABdDj34x2XGs1lBLpm6GLIMcwY2jK34PO1HW4rHXbTWmCdbmKw/uJZ2lq433iUfa
3X8VHMtL6/uzV40ducQeGGPjoqcCF0vrTl8XiXBhUyNIkHlDc+EOvw/mmJ/i+t+L
8JUQMwdaml4L6NpyUph21TNBTOIFGg==
=N6z2
-----END PGP SIGNATURE-----

--JezNBh0mpCYBWM70--


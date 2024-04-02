Return-Path: <linux-kernel+bounces-128173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9008E89572F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5792839F6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9807513342C;
	Tue,  2 Apr 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcH6b73w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A9612C52C;
	Tue,  2 Apr 2024 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068802; cv=none; b=Zqkotjjtk2LnlD8gBnQmfJkQHWytZktCvubcy6GKr+8/4pvdj4l1wf9gnO1mb/T4OUzUF0CLfxjopDN7oVK5poleodII59exHWO0vwF8sZiZl3P6fTy1dnZNY9gYnVb8fqyE1gEnI0Y9xkktx66La4zzMIlWtyZod4KcY+WuAQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068802; c=relaxed/simple;
	bh=ObgRGpfFKsd5sJ/rrglmRB47dUBHcrHvv4Uxgn/87lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSgeMkBNMiQwSN9CQuYjV/2V1xe6bUEuMfQjx/CorAMHdOXUvWzcwKTFjqy2P9JQnoSFmVAblbERZZh69IhiU/ty+7rHExgxoZAljNBHacJGj7Z84vXgUeqF715nqlLDeH9mBSko2prn7IZRirO7OWLAVAdVBXXLU2vE63X0GkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcH6b73w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC5AC433C7;
	Tue,  2 Apr 2024 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712068802;
	bh=ObgRGpfFKsd5sJ/rrglmRB47dUBHcrHvv4Uxgn/87lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rcH6b73wNwdCDvhPYz/VMuH+qmE6KkDHgJ73EfUSwUFlZAb4GRbQvR7IWDHV/JrJz
	 CQ5VeL/cLMM9kyK+vu999qRSh5i46PKKJXgfxbgctac1xR1ol6e5nILVdfbEFpf0W9
	 kQk2MzyU1+snJYrLQnn5/iQoPFXkXG1KJFW5iGpFjGOcQrpTUyJkh74WsDHhCDRDtt
	 cWcF52p5Udl6OQxTdPUdE11Atf22/iI6M2iOR0yOK8m+cbkMCyRVIBPDXvqH7rwCeh
	 I4J0qreEldv9pPIp4kYPaCL+KrFbvNejD8dX3ZRrZ27aNArwhdG4yq9W18RlQNol6k
	 C6+rE74IKtB5A==
Date: Tue, 2 Apr 2024 15:39:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
Message-ID: <75dda5a8-8e55-4f6c-881e-4f10b58b379a@sirena.org.uk>
References: <20240401152547.867452742@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N6U6nv1eBDd/k+nX"
Content-Disposition: inline
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
X-Cookie: Knowledge is power.


--N6U6nv1eBDd/k+nX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 01, 2024 at 05:40:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.24 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--N6U6nv1eBDd/k+nX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYMGLsACgkQJNaLcl1U
h9BlLgf/Yip3R9Mm0E27EQtwGxRCbmnozkGnP1zKnskyDOBb+r99tCndiE0YSvTW
oCTDmN7sCjcmNbQUomLv3TwiDe4GbphrgiQlonUN5MEqTE5pas/HLN7RbIthWINY
870xEt6Bg0foBLgcPuv4urOR+DCc75MXyxn0msBWt0s8K4+kRUSgM+rjOiC9rPGj
bINxOHwK1TKjaU09C/NAbM5MXb/3cangqZsciOk1WhejLo6vvce4f6W2hs4RYo9z
siVTAYQb3C5czDW4hubZlOwAPbUTkGQ5LrTB1Fg+NyA61YpzrRYZ3CMJwx9rkKRQ
hDr5/Me1RFgkupI8NL+hEhlhSfP+EQ==
=ZgKx
-----END PGP SIGNATURE-----

--N6U6nv1eBDd/k+nX--


Return-Path: <linux-kernel+bounces-159724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9352A8B332E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF6DBB21126
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD2913C903;
	Fri, 26 Apr 2024 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E+4H8Rpd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B3043AC5;
	Fri, 26 Apr 2024 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714121068; cv=none; b=rYTnXwOA7Qb+3IEFZYADz4InWZux0zUbhhVKZOEqoeEAh9MSeiXh0nqdaeIckMN35UmmUYuf2qQoBkamqNrd4vSw77rTtr6bls7XfQ6zQLkz9X31M23oSvy63clQciU8+uaMxrRMNUH9fRb5UY/kwmvPsR3hGRrq4L0EvSGxVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714121068; c=relaxed/simple;
	bh=4wvOYv8+NIdUpdRb7Grmdgfv9If4faaLPcCOfZoDlE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvDZm2xUa6+kh9Z86+bXJXyS5HjLFM9tx3qy2ufgxqc7BFakL43zoziwcdI2KqKjA6Lc3NSbMijONoNuh8gM754xEipVbxNDni7R0qyGpIewcQoZC0b8mLSuTvTvY9CztUpwqQO6GPLZ0nLix4Nbt8xaZdLjPMrjaMcaL5Yqn7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E+4H8Rpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00E9C113CD;
	Fri, 26 Apr 2024 08:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714121067;
	bh=4wvOYv8+NIdUpdRb7Grmdgfv9If4faaLPcCOfZoDlE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+4H8Rpd6Cp58EWOWAjvv0PVZSWobDuIWzJvMc3meXBqGv5BkMauw98WEWTFTnwtx
	 ka/qKcLZu0uyQeQtYiXju71UOIVvQMjUxHu8cYy0qHTwwHyIi7wAma9KwI/G4uPknf
	 Z9v9rZJqFCnWpNLrv3iLR3WKKMMrQYi6YR5WGLTo=
Date: Fri, 26 Apr 2024 10:44:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, dianders@google.com, briannorris@google.com,
	momohatt@google.com, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 5.15 000/476] 5.15.149-rc1 review
Message-ID: <2024042603-sleek-janitor-34f8@gregkh>
References: <20240221130007.738356493@linuxfoundation.org>
 <aceda6e2-cefb-4146-aef8-ff4bafa56e56@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aceda6e2-cefb-4146-aef8-ff4bafa56e56@roeck-us.net>

On Thu, Apr 25, 2024 at 03:46:18PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On 2/21/24 05:00, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.149 release.
> > There are 476 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> > Anything received after that time might be too late.
> > 
> [ ... ]
> 
> > Herbert Xu <herbert@gondor.apana.org.au>
> >      crypto: api - Disallow identical driver names
> > 
> 
> This patch results in a severe performance regression on arm64 systems;
> there is more than 50% throughput loss on some sequential read tests.
> The problem affects v5.15.y and older kernel branches.
> 
> Analysis shows that v5.15.y and older kernel _do_ try to register the same
> crypto algorithm twice, once through
> 
>  __crypto_register_alg
>  crypto_register_alg
>  crypto_register_skciphers
>  aes_init
> 
> and then again through
> 
>  __crypto_register_alg
>  crypto_register_alg
>  crypto_register_skcipher
>  simd_skcipher_create_compat
>  aes_init
> 
> After above patch was applied, the second registration fails, resulting
> in the regression.
> 
> The problem is not seen in later kernels due to commit 676e508122d9
> ("crypto: arm64/aes-ce - stop using SIMD helper for skciphers"). Applying this
> commit or reverting above commit fixes the regression in v5.15.y and older.
> 
> Thanks is due to Momoko Hattori for reporting the problem and finding the
> offending patch, Doug Anderson for finding the duplicate registration attempt,
> and Brian Norris for finding the fix. I copied them on this e-mail in case
> there are further questions.

Thanks for the report.  I got a report that this breaks some android
systems as well due to some FIPS crypto code that happens to duplicate
the names as well.  I think reverting it makes sense and I'll queue that
up for the next round of releases.

greg k-h


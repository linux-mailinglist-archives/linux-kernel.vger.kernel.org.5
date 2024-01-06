Return-Path: <linux-kernel+bounces-18534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36872825EE4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 09:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8388D284D1D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CFA5244;
	Sat,  6 Jan 2024 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0svUTfy0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9563AA;
	Sat,  6 Jan 2024 08:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD0FC433C8;
	Sat,  6 Jan 2024 08:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704530336;
	bh=7vuXNlpf9BnOyE4McDlBL7Bb7sZyBrF0fs7gPJBM3V0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0svUTfy0dGrx5HeFZZ/hDbP4X/F8+SOMotQ3FfZhBYDqoUx/NkU+39mEMagngMbR/
	 t1MBIVJcEmV6+8YOpkN0L/Y5e43njc7NRcaRfsk4v4JWYPzZcOBFEwQYI/FOxxPbUC
	 TixtuLqkovVEJGoFWpyH3f1+GUfu3NxZMLT4M/kc=
Date: Sat, 6 Jan 2024 09:38:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, jpanis@baylibre.com
Subject: Re: [PATCH 5.4 00/47] 5.4.266-rc1 review
Message-ID: <2024010639-sinuous-expansion-417c@gregkh>
References: <20240105143815.541462991@linuxfoundation.org>
 <77569e45-ab73-4049-b90e-cd60cbb872ef@linaro.org>
 <92d8ecc9-7b51-4d54-9942-efc5beb156cf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92d8ecc9-7b51-4d54-9942-efc5beb156cf@linaro.org>

On Fri, Jan 05, 2024 at 11:01:44AM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 05/01/24 10:04 a. m., Daniel Díaz wrote:
> > Hello!
> > 
> > On 05/01/24 8:38 a. m., Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.4.266 release.
> > > There are 47 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sun, 07 Jan 2024 14:38:02 +0000.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > >     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.266-rc1.gz
> > > or in the git tree and branch at:
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > > and the diffstat can be found below.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Quick note that there are Arm32 failures:
> > 
> > -----8<-----
> >    /builds/linux/drivers/bus/ti-sysc.c: In function 'sysc_reset':
> >    /builds/linux/drivers/bus/ti-sysc.c:1847:4: error: implicit declaration of function 'fsleep'; did you mean 'ssleep'? [-Werror=implicit-function-declaration]
> >     1847 |    fsleep(ddata->cfg.srst_udelay);
> >          |    ^~~~~~
> >          |    ssleep
> >    cc1: some warnings being treated as errors
> >    make[3]: *** [/builds/linux/scripts/Makefile.build:262: drivers/bus/ti-sysc.o] Error 1
> > ----->8-----
> 
> Bisection points to:
> 
>   commit bed75624164c501b39531927d07a4fadc5738847
>   Author: Julien Panis <jpanis@baylibre.com>
>   Date:   Mon Aug 21 16:24:18 2023 +0200
> 
>       bus: ti-sysc: Use fsleep() instead of usleep_range() in sysc_reset()
>       [ Upstream commit d929b2b7464f95ec01e47f560b1e687482ba8929 ]
> 
> Reverting (swapping back the content of that commit, as it wasn't a clean revert) did make the build pass.

Thanks, now dropped and will push out a -rc2

greg k-h


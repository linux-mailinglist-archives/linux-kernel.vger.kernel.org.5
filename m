Return-Path: <linux-kernel+bounces-142236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015EF8A2954
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D021F2159E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6873C50291;
	Fri, 12 Apr 2024 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZJZU03Kh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31F24F1F5;
	Fri, 12 Apr 2024 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910590; cv=none; b=qi66jv9YCo6U1ik1cKKBs+QpDEOvQvjk8s4pJsGU3iwXANpXPu7kfJ4igDFqT5QelP9D6tYG2LjcCY1xhkf7dhSDr+Yw962lP82hqfmTkVn/pJcmk6qaR7pbHcrZ23rf7jr6BFCzr1yRBTfzEDAe6R3WSG9gAW/W0btC/Q1+wgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910590; c=relaxed/simple;
	bh=yNUCTY3R96uKh6sdpi2i9suu0OKXHjTflNqHMb3g/Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cO6iHRC574XY3vCjmHFRqTHxwk3S4sfKkTHUFJCJB45vQcOB9dTaEBW9yVYdhS3hFJZJWlzS7rmtYCP06ueRIyHxnx2QzuZe+DsHFDQTY85H0xHhitrHjnD6Y91KLXbq94FCt/ZfVqhW/iyOzJGXLh3vw4cK7LAIKeu85kZcRnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZJZU03Kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EA3C113CC;
	Fri, 12 Apr 2024 08:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712910590;
	bh=yNUCTY3R96uKh6sdpi2i9suu0OKXHjTflNqHMb3g/Zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZJZU03Khdu2WdxWk9+7wNcvmgMETU1OMUS2cQ7EKe2zNGS1IZnCskHzuBG7e2Zowj
	 1fTxSOA9v625MMNkgcQxWLNFl5t6/QWyjTEe0q7btzvTJ7V5orC7we2UYWN2T38Yd5
	 Kabaa965su4ebVWb03h4WHpzo48YTdmWFA5LUPUg=
Date: Fri, 12 Apr 2024 10:29:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	imx@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4.19 000/175] 4.19.312-rc1 review
Message-ID: <2024041240-drastic-crayon-e9d6@gregkh>
References: <20240411095419.532012976@linuxfoundation.org>
 <CA+G9fYuwCn0D6jzrn0dBKsa+X0zUBUMiuRqcYvc-qkKToXK5dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuwCn0D6jzrn0dBKsa+X0zUBUMiuRqcYvc-qkKToXK5dA@mail.gmail.com>

On Thu, Apr 11, 2024 at 07:50:57PM +0530, Naresh Kamboju wrote:
> On Thu, 11 Apr 2024 at 15:30, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.19.312 release.
> > There are 175 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.312-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> The arm imx_v6_v7_defconfig build failed with gcc-12 and clang on Linux
> stable-rc linux-4.19.y.
> 
> Regressions:
>  - arm
>     * gcc-12-imx_v6_v7_defconfig - failed
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build log:
> ----
> drivers/gpu/drm/imx/parallel-display.c: In function
> 'imx_pd_bridge_atomic_check':
> drivers/gpu/drm/imx/parallel-display.c:222:23: error: implicit
> declaration of function 'drm_bridge_get_next_bridge'
> [-Werror=implicit-function-declaration]
>   222 |         next_bridge = drm_bridge_get_next_bridge(bridge);
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.311-176-gf0cf5f6110a7/testrun/23411280/suite/build/test/gcc-12-imx_v6_v7_defconfig/details/
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2ex1v6eevudbi33g4ozA7hJ4fvs/

Offending commit now dropped, thanks!

greg k-h


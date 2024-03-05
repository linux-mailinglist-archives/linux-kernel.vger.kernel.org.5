Return-Path: <linux-kernel+bounces-92279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5D4871DDA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5118C284042
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F425BAE0;
	Tue,  5 Mar 2024 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oZT0ybGG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2355BAD9;
	Tue,  5 Mar 2024 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638255; cv=none; b=pCrn84XrTRNKLpJ4xGRmXHYwiCzDFdMU3BhEsvqVirflqZ4InS0fzqR7RiJPEdv5EGUh2+KqhPGJ4Ld1YEEE6HxTH7gVQOssxi28cN3s4geHs+jwpYQDdyQBR62R26b8HADNC4p2GUYwLIof9B7TBob+C1mpZwC01HQbX/BP/Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638255; c=relaxed/simple;
	bh=JHWuPGz+VGj/J/e0lYBFkaZdv959aJWqPnQBqFpfv+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ylzmjefb4dm9xZwozAl8Pj+fayklBtZoFdSEMhaWsWvw/I6unmA2muw1Jo6WXGf/H3bsy6yJQSkazbxyfGlYTB5FoCmbMv7vwZpIIgkPRqd65Lb8MnW5ZPOgDBNzkbjZznuSTcF+vzEF90Yl9oiZIp+awtAdGE7KGcNlIUQP8h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oZT0ybGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B6FC433F1;
	Tue,  5 Mar 2024 11:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709638255;
	bh=JHWuPGz+VGj/J/e0lYBFkaZdv959aJWqPnQBqFpfv+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZT0ybGGaePPCjl76VGXn962hbyS8wOPWZMjaIavm7XkJ6A68jKojYZlDgUr9/Q8Q
	 3kKNpzpRI7mTqUiOXYGBVNlu3L2a7X0CMluVUbCxRGmX22PJbg2RWys3F9YyLpXV/T
	 fJOcnpS/MqdgPF5NZznwAzGI4NwJDYIwp37+jiwQ=
Date: Tue, 5 Mar 2024 11:30:52 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com,
	Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5.15 00/84] 5.15.151-rc1 review
Message-ID: <2024030534-makeshift-gauging-72d2@gregkh>
References: <20240304211542.332206551@linuxfoundation.org>
 <CA+G9fYvOpuVjEe_0E5bwsmP39VQwdybDEoKTZGeYC3ULtqmViQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvOpuVjEe_0E5bwsmP39VQwdybDEoKTZGeYC3ULtqmViQ@mail.gmail.com>

On Tue, Mar 05, 2024 at 03:38:20PM +0530, Naresh Kamboju wrote:
> On Tue, 5 Mar 2024 at 03:23, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.15.151 release.
> > There are 84 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.151-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Following build failures noticed on riscv.
> 
> The riscv tinyconfig and allnoconfig builds on 5.15.
> The riscv defconfig, tinyconfig and allnoconfig builds on 5.10.
> 
> linux.5.15.y build failures on riscv.
> riscv:
>   build:
>     * gcc-12-tinyconfig
>     * gcc-8-allnoconfig
>     * clang-17-tinyconfig
>     * gcc-8-tinyconfig
>     * gcc-12-allnoconfig
> 
> linux.5.10.y build failures on riscv.
> riscv:
> 
>   * gcc-8-defconfig
>   * clang-17-allnoconfig
>   * gcc-12-tinyconfig
>   * gcc-8-allnoconfig
>   * gcc-8-allmodconfig
>   * clang-17-defconfig
>   * gcc-12-defconfig
>   * clang-17-tinyconfig
>   * gcc-12-allmodconfig
>   * gcc-8-tinyconfig
>   * gcc-12-allnoconfig
> 
>  Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> arch/riscv/kernel/return_address.c:39:9: error: implicit declaration
> of function 'arch_stack_walk' [-Werror=implicit-function-declaration]
>    39 |         arch_stack_walk(save_return_addr, &data, current, NULL);
>       |         ^~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> 
> Suspecting patch,
> 
> riscv: add CALLER_ADDRx support
> commit 680341382da56bd192ebfa4e58eaf4fec2e5bca7 upstream.

Thanks, will go drop this and push out -rc2 kernels for 5.15 and 5.10

greg k-h


Return-Path: <linux-kernel+bounces-87425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA30786D442
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EA71F24014
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF88A1428EA;
	Thu, 29 Feb 2024 20:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z1YbtChL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D9B7BAEB;
	Thu, 29 Feb 2024 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238668; cv=none; b=g/d6PDfzFrB8vgzYEwqBcCdeGeQz9Fp1nIysTxHycMCIHqWVB4oGac4Gf3OgCrbQ61VnQMEisgwSKDJVRMWJTJugDWPqgyaLLBtKqK61hoWTu/uSxB4Fdq4rZ9GW8cxKTiajTMPY1VrvSDVDTMY0nvmRKaKN6W1INfdxZRmRZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238668; c=relaxed/simple;
	bh=M4+6vQFkD+CYyHpmKhFMZOuZsQkEWvXMWLciVnbbYrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1ZDE4oQaWFsqGREBK78XDJOIUBCMG8uCv23LQ6gTtYi28PVjaVgPOAYJzTgkqh8CCU8+H7XY+Vk17uUTe3ymNx9B35AHOm4+uq7eH8rLX9zga+xLxHvIr965XgLhEwTg13nVLAmX2xozkC/yEBu4bftQf0UL2K4YqOQMIRBfPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z1YbtChL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF60C433F1;
	Thu, 29 Feb 2024 20:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709238667;
	bh=M4+6vQFkD+CYyHpmKhFMZOuZsQkEWvXMWLciVnbbYrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z1YbtChLPxbWtp5lARHdveXbF//APjjq3sKO2oW7h6SARgdWdLmMXJDhqLOMai56C
	 qXG3/zWQhqYf/PEfHYOOUxKvle47M3Z1EpwBF8gqwnGhRqdkJhJGDEHtbLz3Feljkh
	 G2wxTxt1bfuy5odd/agjuZXDTG8rTNcsiDjl7uJY=
Date: Thu, 29 Feb 2024 21:31:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, paul@crapouillou.net
Subject: Re: [PATCH 5.15 000/245] 5.15.150-rc1 review
Message-ID: <2024022927-bluish-anime-d70a@gregkh>
References: <20240227131615.098467438@linuxfoundation.org>
 <ac2c579e-4ff0-42e2-ab70-efb8ded2d257@linaro.org>
 <2024022905-skinny-making-7852@gregkh>
 <1223812f-1dc3-40c2-a58a-2485d68e92b6@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1223812f-1dc3-40c2-a58a-2485d68e92b6@roeck-us.net>

On Thu, Feb 29, 2024 at 12:19:40PM -0800, Guenter Roeck wrote:
> On 2/29/24 11:54, Greg Kroah-Hartman wrote:
> > On Tue, Feb 27, 2024 at 12:56:32PM -0600, Daniel Díaz wrote:
> > > Hello!
> > > 
> > > On 27/02/24 7:23 a. m., Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.15.150 release.
> > > > There are 245 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.150-rc1.gz
> > > > or in the git tree and branch at:
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > and the diffstat can be found below.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > We're seeing build regressions here with RISC-V, with GCC 8, GCC 12, and Clang 17:
> > > 
> > > -----8<-----
> > >    In file included from /builds/linux/include/linux/list.h:9,
> > >                     from /builds/linux/include/linux/module.h:12,
> > >                     from /builds/linux/drivers/net/ethernet/realtek/r8169_main.c:12:
> > >    /builds/linux/drivers/net/ethernet/realtek/r8169_main.c:5512:35: error: 'rtl8169_pm_ops' undeclared here (not in a function); did you mean 'rtl8169_poll'?
> > >     5512 |         .driver.pm      = pm_ptr(&rtl8169_pm_ops),
> > >          |                                   ^~~~~~~~~~~~~~
> > >    /builds/linux/include/linux/kernel.h:46:44: note: in definition of macro 'PTR_IF'
> > >       46 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
> > >          |                                            ^~~
> > >    /builds/linux/drivers/net/ethernet/realtek/r8169_main.c:5512:27: note: in expansion of macro 'pm_ptr'
> > >     5512 |         .driver.pm      = pm_ptr(&rtl8169_pm_ops),
> > >          |                           ^~~~~~
> > >    make[5]: *** [/builds/linux/scripts/Makefile.build:289: drivers/net/ethernet/realtek/r8169_main.o] Error 1
> > > ----->8-----
> > > 
> > > Bisection points to:
> > > 
> > >    commit ac2871f646a8f556203f5b6be875ce406d855ddb
> > >    Author: Paul Cercueil <paul@crapouillou.net>
> > >    Date:   Tue Dec 7 00:20:59 2021 +0000
> > >        PM: core: Redefine pm_ptr() macro
> > >        [ Upstream commit c06ef740d401d0f4ab188882bf6f8d9cf0f75eaf ]
> > > 
> > > A revert could not be done cleanly.
> > > 
> > > Tuxmake reproducer:
> > > 
> > >    tuxmake --runtime podman --target-arch riscv --toolchain gcc-12 --kconfig defconfig
> > > 
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > I've been beating on this for a while and I really don't know what is
> > happening, sorry.  The driver looks fine, something is "odd" with riscv
> 
> No, the driver is not fine. Upstream has commit 8fe6e670640e ("r8169: use new
> PM macros") which makes rtl8169_pm_ops unconditional. That commit is missing
> in v5.15.y. Applying it makes the problem disappear.
> 
> In other words, the problem is not riscv specific, but will be seen if the
> realtek driver is built with CONFIG_PM=n (which happens to be the case with
> riscv:defconfig).

Ugh, that wasn't obvious, I was thinking that the CONFIG_PM thing would
have worked properly there and was digging in riscv code all over the
place...

Thanks for this, now queued up.

greg k-h


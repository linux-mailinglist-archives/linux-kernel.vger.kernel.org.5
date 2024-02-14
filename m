Return-Path: <linux-kernel+bounces-65248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361D1854A11
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C971C219CB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99ED53393;
	Wed, 14 Feb 2024 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CGkHxOHC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0764524CD;
	Wed, 14 Feb 2024 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916127; cv=none; b=D8YDYmXh4JUP19LpxM+2LYF7hrkmGOer8IXNBi5gC76F+JESICTIkxE33xLBQ3737uE7zxf6qPkx8Hmy63NQjCTHmobYqG+P8KHXLVLt5n8LJ7D5i2N8sWNoGJ5sNednD47w+8dKIg6EwamR8NsTbjKTQJ8NthqWx4C88te1BT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916127; c=relaxed/simple;
	bh=IHcwF1sOsEfQq3VWY3GdXolnhsPbOpMy0ZYtGeksXTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqrI90FZC3G35F11jJgieWUpYz2Tk2YbybiAeK7M62qyjU5cFZiET8h76OLgXIeBNQZqhZTOtuyxZf29xk4YkQd04Lqns0Tx96bV6+g9WlmCUTEIVLud5LmA6ut1qigOrNVYa3UlrnvgszyNdR/lZXZVn5XOgNwMGUfDd4KnSbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CGkHxOHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A620C433F1;
	Wed, 14 Feb 2024 13:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707916126;
	bh=IHcwF1sOsEfQq3VWY3GdXolnhsPbOpMy0ZYtGeksXTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGkHxOHC41g8N0yA/P5KY/a2156nEPyA5bHeL44W9xbbcceIGO3sVZGSjpGljbA5l
	 +tEsDMGegPnkPcZtasOFnLyIJySkxC+bypjQXpBP9c+2iSIXF2Qywy96vZUlQrYTYK
	 rMLsFSrg4QptLba4OG+jC2OnxtwEo9FMuGXjF8qM=
Date: Wed, 14 Feb 2024 14:08:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 6.1 00/64] 6.1.78-rc1 review
Message-ID: <2024021422-reckless-remark-e721@gregkh>
References: <20240213171844.702064831@linuxfoundation.org>
 <83771838-c346-4a90-92c1-6ba592a620ac@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83771838-c346-4a90-92c1-6ba592a620ac@nvidia.com>

On Wed, Feb 14, 2024 at 09:03:59AM +0000, Jon Hunter wrote:
> Hi Greg,
> 
> On 13/02/2024 17:20, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.78 release.
> > There are 64 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> Builds are failing for Tegra ...
> 
> Test results for stable-v6.1:
>     10 builds:	3 pass, 7 fail
>     6 boots:	6 pass, 0 fail
>     18 tests:	18 pass, 0 fail
> 
> Linux version:	6.1.78-rc1-gb29c5b14893f
> Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
>                 tegra30-cardhu-a04
> 
> Builds failed:	aarch64+defconfig+jetson, arm+multi_v7
> 
> 
> > Furong Xu <0x1207@gmail.com>
> >      net: stmmac: xgmac: fix handling of DPP safety error for DMA channels
> 
> The above commit is causing a build regression for older toolchains and
> I have reported this [0]. This is also seen on the mainline and -next and
> there is a fix in the works [1].
> 
> Note this is breaking the build for linux-6.6.y and linux-6.7.y too.

Thanks, I've now queued up the fix.  Do you need me to push out a -rc2
for this issue for your testing?

thanks,

greg k-h


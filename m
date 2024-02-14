Return-Path: <linux-kernel+bounces-65331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B745854B56
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D81D1B26765
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6573D55E4A;
	Wed, 14 Feb 2024 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aK0vGsTH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5455C2B;
	Wed, 14 Feb 2024 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920608; cv=none; b=jPRxm2wX30Ah1nylrwZ/L1HVqcFODXKW1cyaxzBWdf+jqJMgW9dpKYYlodhphTnDHgYgKVboP+9ZqfMo9B+AuTxE45Sq5cczS20btavNlRqSJCdHjStUd3jb4XqkO19gWT986dsoYSebm4zFnDLTMtNqrpX6nRE37PQemTg6mXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920608; c=relaxed/simple;
	bh=Mufo7QEixa/saMH4nPt9rUB9pLUn5tKDkcuXjluUZpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwVnAGabAznuJWsj/LulewgXB+XO35SUVsI4tHed8VckFwZCXGW3gsGsevSX7bDWy1J4S1qB5hi4ii0xFfzbTnN3ggY+90RAhZjDnyVaA+EjWDqAej+gy+DyqdcnVVHCty9tiDWfCnkZl9ScIX0wfHRyVOUIlqm3g2XT9zFjXI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aK0vGsTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844ECC433C7;
	Wed, 14 Feb 2024 14:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707920608;
	bh=Mufo7QEixa/saMH4nPt9rUB9pLUn5tKDkcuXjluUZpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aK0vGsTHEZvh+MwhN6vDZ93Lal1aDL2/mht7nnXd9I6atr3e5WL69y80mbzic5kmb
	 1yfeJDYYO6x1OaD7f+H5i+KEEgTRS5TIzZvTnxf79Uvi4h4nRbH246+IkFfq2aVwqY
	 B3TsSD+UCd0TqM7/WwF1YrkNh0/5dIaYBABijQi8=
Date: Wed, 14 Feb 2024 15:23:22 +0100
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
Message-ID: <2024021409-elusive-overlaid-4fef@gregkh>
References: <20240213171844.702064831@linuxfoundation.org>
 <83771838-c346-4a90-92c1-6ba592a620ac@nvidia.com>
 <2024021422-reckless-remark-e721@gregkh>
 <d74b1c1d-a0dd-43f4-ad6a-0dca69329c16@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d74b1c1d-a0dd-43f4-ad6a-0dca69329c16@nvidia.com>

On Wed, Feb 14, 2024 at 01:15:47PM +0000, Jon Hunter wrote:
> 
> On 14/02/2024 13:08, Greg Kroah-Hartman wrote:
> > On Wed, Feb 14, 2024 at 09:03:59AM +0000, Jon Hunter wrote:
> > > Hi Greg,
> > > 
> > > On 13/02/2024 17:20, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.1.78 release.
> > > > There are 64 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc1.gz
> > > > or in the git tree and branch at:
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > > and the diffstat can be found below.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > 
> > > Builds are failing for Tegra ...
> > > 
> > > Test results for stable-v6.1:
> > >      10 builds:	3 pass, 7 fail
> > >      6 boots:	6 pass, 0 fail
> > >      18 tests:	18 pass, 0 fail
> > > 
> > > Linux version:	6.1.78-rc1-gb29c5b14893f
> > > Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
> > >                  tegra30-cardhu-a04
> > > 
> > > Builds failed:	aarch64+defconfig+jetson, arm+multi_v7
> > > 
> > > 
> > > > Furong Xu <0x1207@gmail.com>
> > > >       net: stmmac: xgmac: fix handling of DPP safety error for DMA channels
> > > 
> > > The above commit is causing a build regression for older toolchains and
> > > I have reported this [0]. This is also seen on the mainline and -next and
> > > there is a fix in the works [1].
> > > 
> > > Note this is breaking the build for linux-6.6.y and linux-6.7.y too.
> > 
> > Thanks, I've now queued up the fix.  Do you need me to push out a -rc2
> > for this issue for your testing?
> 
> 
> Ideally yes. That would be great.

Ok, will do in a few minutes, thanks for testing!

greg k-h


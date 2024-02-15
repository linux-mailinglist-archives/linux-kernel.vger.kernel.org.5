Return-Path: <linux-kernel+bounces-66786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575B585622B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D28B2E9E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9907312AAD6;
	Thu, 15 Feb 2024 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ui14pvUH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE416129A73;
	Thu, 15 Feb 2024 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996437; cv=none; b=rApBY1nxJJGzWVwrIQZs8yU5G8pX1/YrHwEd46HJOVHgh5XHDlsqyIyz2eFJUmYtUtAiXgexLuZkvdCpXP+5vtxNc5YxFSVaItSuuJHFAL/ayKQkdJzaXJyGmiJexjyzBHBBbkEp8uWYyvs/rhFOBMAQhrtYd3pVgxa3D4qoVeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996437; c=relaxed/simple;
	bh=3QEwyfFVheZ/zGtQUqz+1x4knQPosUQAoxSSUWU/cUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoZ996sLoMLgnsIa/X73/x2qtRTywJtFzuf4MMf+qsnBrY1cYOBSnw3ZUuQIsdRJr6ldGQgCjmshTF+LAhqEG0caSbBlzO15q4pND/hv0TdZvNN6D5uFtH5trPlPVTa5iTixVaFpuPC/CWmDWYZWTJ6gO/EW+NOrAPrKFa/u/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ui14pvUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975ABC433C7;
	Thu, 15 Feb 2024 11:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707996437;
	bh=3QEwyfFVheZ/zGtQUqz+1x4knQPosUQAoxSSUWU/cUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ui14pvUHZpUiECmyZ7f3D4E+AMnJNSbJEFwHeggEl6RX+PCmEiBnow7WcTEAd3RPq
	 kEMq8JcFvUvcQ12t3azIcJS6FlYb0DGo6rFxq1kCFwHz6uvZPe+bLewUl10iN6gekc
	 f33e5fFhpy1MsaBbanDmKK6HyVCBPbx9fq6iNTMQ=
Date: Thu, 15 Feb 2024 12:27:14 +0100
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
Subject: Re: [PATCH 6.7 000/127] 6.7.5-rc2 review
Message-ID: <2024021556-pungent-huddle-8204@gregkh>
References: <20240214142244.209814342@linuxfoundation.org>
 <4cc8718f-6035-49f7-bd50-39564ac4fba4@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cc8718f-6035-49f7-bd50-39564ac4fba4@nvidia.com>

On Thu, Feb 15, 2024 at 11:14:22AM +0000, Jon Hunter wrote:
> 
> On 14/02/2024 14:29, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.7.5 release.
> > There are 127 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 16 Feb 2024 14:22:16 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.5-rc2.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> No new regressions for Tegra ...
> 
> Test results for stable-v6.7:
>     10 builds:    10 pass, 0 fail
>     26 boots:     26 pass, 0 fail
>     116 tests:    115 pass, 1 fail
> 
> Linux version:    6.7.5-rc2-gc94a8b48bd4b
> Boards tested:    tegra124-jetson-tk1, tegra186-p2771-0000,
>                   tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
>                   tegra20-ventana, tegra210-p2371-2180,
>                   tegra210-p3450-0000, tegra30-cardhu-a04
> 
> Test failures:    tegra186-p2771-0000: pm-system-suspend.sh

Is this on track to be fixed anywhere in Linus's tree yet?

thanks for testing,

greg k-h


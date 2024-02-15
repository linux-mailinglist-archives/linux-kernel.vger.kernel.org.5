Return-Path: <linux-kernel+bounces-66740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CB08560E8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C971C2097B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4502012B159;
	Thu, 15 Feb 2024 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bkfbM1j0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5B657A0;
	Thu, 15 Feb 2024 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995198; cv=none; b=P1YAEa6h9jg3TMgk/L82Zb4vKBGHTHONCVO/ynF7nnmy3KheuTI8+9cMgPTl9Hi0CXE9m7IQrRDDjJ6KdCZJLaGBEh0rQvyzu0seTZnmd3O4BkXjfcLsMzWr+BRZfRvxDc/6bg6bogcJumTTZlUBH3X+ltDY1AwaU5x60Jdc97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995198; c=relaxed/simple;
	bh=+6f1RjKwFKHZixh15TYArKSQpcNXqz9ekQ2XC+tFlWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCFMq7FeSCmoanxbjflteW/Wj6+N+vGpaYzfkpzXpfrxbYTocNuDqcu8emYfh+BUPd58lztAdlB6DoLYZ6KuGve8FyM4+JHZ/uZ4ilUMIDI8GpGAIBA0XkfaBpgZzElSX2V4OKb3dyWZ5ZqkjK4JfYGSyzhVRvhSo7+2/UDiRk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bkfbM1j0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39266C433F1;
	Thu, 15 Feb 2024 11:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707995197;
	bh=+6f1RjKwFKHZixh15TYArKSQpcNXqz9ekQ2XC+tFlWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkfbM1j03Xn2tLhferLdzpwA8mvcu5xz9iPxpo+a7uNtPCdHmafXlWfYvvZNaVoFi
	 41Rm546gcGXlNPKE9oP/lpZoFFcCyI+EArUmHilcTlVggFsigBBjY8KEuLwkXhqi3C
	 UjDP0RqCBjia3enJec7y5MNDD19d81J+NDRIh9V4=
Date: Thu, 15 Feb 2024 12:06:34 +0100
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
Subject: Re: [PATCH 6.1 00/65] 6.1.78-rc2 review
Message-ID: <2024021517-robust-tuition-4ce0@gregkh>
References: <20240214142941.551330912@linuxfoundation.org>
 <6e281665-10d8-4db7-98cf-45829d3abf06@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e281665-10d8-4db7-98cf-45829d3abf06@nvidia.com>

On Thu, Feb 15, 2024 at 11:04:11AM +0000, Jon Hunter wrote:
> 
> On 14/02/2024 14:30, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.78 release.
> > There are 65 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 16 Feb 2024 14:28:54 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc2.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
>     10 builds:	10 pass, 0 fail
>     26 boots:	26 pass, 0 fail
>     116 tests:	115 pass, 1 fail
> 
> Linux version:	6.7.5-rc2-gc94a8b48bd4b
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
>                 tegra20-ventana, tegra210-p2371-2180,
>                 tegra210-p3450-0000, tegra30-cardhu-a04
> 
> Test failures:	tegra186-p2771-0000: pm-system-suspend.sh
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>

You sent 2 of these, one without a failure, and one with?

confused,

greg k-h


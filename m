Return-Path: <linux-kernel+bounces-18535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AFC825EE6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 09:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A57284D6A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7264B5253;
	Sat,  6 Jan 2024 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gGOEPENg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2B63B6;
	Sat,  6 Jan 2024 08:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DFEC433C8;
	Sat,  6 Jan 2024 08:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704530352;
	bh=IBM0x/OGk/ImQqqdyhIJM9Cb+AgjoD6fQM2tOsIWHSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGOEPENgBroeitWPipQs+wxUq3nhHzWIhjTYys82jmLfJBV2q+fosxGPBf9dQBxyK
	 bKywmepktNjvEGSuM6KsUjL6YeZOcHTchoDKVyscnBEfApF0KiSXKmAiB7rq6RmuVk
	 Jwi5TWjO8zXyOKekq2B+/v/itHrJWF4Az2948rdw=
Date: Sat, 6 Jan 2024 09:39:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com,
	Gustavo Padovan <gustavo.padovan@collabora.com>,
	kernel@collabora.com
Subject: Re: [PATCH 5.4 00/47] 5.4.266-rc1 review
Message-ID: <2024010659-quarterly-reliably-f764@gregkh>
References: <20240105143815.541462991@linuxfoundation.org>
 <1b20-65987a00-1-329a04c0@129853067>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b20-65987a00-1-329a04c0@129853067>

On Fri, Jan 05, 2024 at 09:51:10PM +0000, Shreeya Patel wrote:
> On Friday, January 05, 2024 20:08 IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > This is the start of the stable review cycle for the 5.4.266 release.
> > There are 47 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 07 Jan 2024 14:38:02 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.266-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> > 
> 
> KernelCI report for stable-rc/linux-5.4.y for this week :-
> 
> ## stable-rc HEAD for linux-5.4.y:
> 
> Date: 2024-01-03
> 5.4: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=84ea024efd547b80abad91a30eb7c86d313eb6a7
> 
> ## Build failures:
> 
> arm:
>     - multi_v7_defconfig (gcc-10) and omap2plus_defconfig (gcc-10)
>     - Build details :- https://linux.kernelci.org/build/stable-rc/branch/linux-5.4.y/kernel/v5.4.265-48-g84ea024efd54/
>     - Errors :-
>     drivers/bus/ti-sysc.c:1847:4: error: implicit declaration of function ‘fsleep’; did you mean ‘ssleep’? [-Werror=implicit-function-declaration]

Thanks, will fix this and push out a -rc2.


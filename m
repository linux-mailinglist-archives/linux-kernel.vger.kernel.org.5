Return-Path: <linux-kernel+bounces-31331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B74832CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B21DFB22D69
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D90754BFB;
	Fri, 19 Jan 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XoVVSUTe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB444EB4C;
	Fri, 19 Jan 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680109; cv=none; b=XJ8fnUyxrmbplPrkad+bgfDj7Gyvbyvfb7MiWaVW4aB8zw7DFFcKaowurHwS/7GXHcklk4d31ehBM8qUREez+H3NS1gpaogwRSWcXGCxISC6IRN1Nsw5IQ1SOlxKos4SZ/WeO8YNt9BsLqUur29o9R+DMVY5DLjFgc23P9CmUaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680109; c=relaxed/simple;
	bh=7qML3c1LMzQXGojxAojijvNWm8TwkKyneuzH927V+uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8VQyN2cBojOduf40UN6g8YgDad9hS/YW9s5XfKZ9ZOSnCz3pPZHGFn0FW506rJoi+UQ2bnm20Nj7imv8gpHjHZq9Y1K8qMeQLZJ8ub/z9pCf38h519Y5nRF+pxZiFUsKkuni95EJzbAZmmAnpxZmwdavGa+eIO0q7oZXi/gnU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XoVVSUTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE3CC433C7;
	Fri, 19 Jan 2024 16:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705680109;
	bh=7qML3c1LMzQXGojxAojijvNWm8TwkKyneuzH927V+uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XoVVSUTeN+pVBsFKN0+rHCtayvXr0yQntKR6hDJp34GwwhQdj3mSiBFG1uHy8pFQU
	 7kW61EVQe+wj/STMZq6CD2B8EOwG14utCHWcUpzoaAIGPKk+ENAu5tPoFZNzYyPTcQ
	 4s2KWrznVXGoWxXL4wTItj3Cq6n+AC/Q/h0uB664=
Date: Fri, 19 Jan 2024 17:01:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 00/28] 6.7.1-rc1 review
Message-ID: <2024011935-pushchair-affected-e2f0@gregkh>
References: <20240118104301.249503558@linuxfoundation.org>
 <CA+G9fYv4PdOsuFmd2BGoq57omiXWuvnSpJJ1HuLYT0rJ_h9xEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYv4PdOsuFmd2BGoq57omiXWuvnSpJJ1HuLYT0rJ_h9xEw@mail.gmail.com>

On Fri, Jan 19, 2024 at 09:18:29PM +0530, Naresh Kamboju wrote:
> On Thu, 18 Jan 2024 at 16:20, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.7.1 release.
> > There are 28 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.1-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> The arm allmodconfig clang-17 build failed on 6.7.y, Linux next and mainline.

So 6.7.0 is also broken?

thanks,

greg k-h


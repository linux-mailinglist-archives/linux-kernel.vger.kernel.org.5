Return-Path: <linux-kernel+bounces-30781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007BA832450
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87205B22E26
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4C94C6B;
	Fri, 19 Jan 2024 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rBw4YQNG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47B4A0F;
	Fri, 19 Jan 2024 05:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705642845; cv=none; b=hq8PtPWFjPPB6EpteoEEH3umo3dWUvBPU9Iqejm3HKkF4dj2VQhKDVgpWV0VAJcqrPuLFO94tiwy5KWuVgtIj65T6Z7pQrBW+WB91Xc4eaxNcSVbW0mzmapBC/GBn6Kc6mvpKi2WJPZ6YVcYf8NhvVV4P8hy/WBbaUvruFFc0is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705642845; c=relaxed/simple;
	bh=u9j17daQHcZtcaiTomO9tc+OzSndwaD8Ua17DNPn0WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyOmcTjMBrlTPWvne2kitzUswu52E1FcreOK4FgRmhJcAGwc0ATt9WUOhw73wBS+DBfu89JiBK+YI1XnJ+V1W0OMBFzkvMNY48sa3iiQuntUvPRHFb1jsAEFuiqG9he9O40gyhDlD7S6BnyX3zd/Vbpmy4d+bqmw0M/peEqX/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rBw4YQNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFCDC433F1;
	Fri, 19 Jan 2024 05:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705642845;
	bh=u9j17daQHcZtcaiTomO9tc+OzSndwaD8Ua17DNPn0WU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBw4YQNGZKZrMxgsbJNWhUeJzwlMr7b2vFWquT2EDVNec2J7aaThur3mJVF0a8aGz
	 rMeciJW+U9cNmh76fAaOncyyhy4Wnt3fc+5AC5MZvoNnvE0y/V/tkueUjKKU52DPqF
	 tsI46VfmCvGX8EBMFf5N6ID+QM91K3DDcr64EPWc=
Date: Fri, 19 Jan 2024 06:40:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/150] 6.6.13-rc1 review
Message-ID: <2024011930-congress-slimness-caa5@gregkh>
References: <20240118104320.029537060@linuxfoundation.org>
 <ab9bef24-a07b-4930-b09a-b3c0f4e04789@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab9bef24-a07b-4930-b09a-b3c0f4e04789@gmail.com>

On Thu, Jan 18, 2024 at 11:22:03AM -0800, Florian Fainelli wrote:
> On 1/18/24 02:47, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.6.13 release.
> > There are 150 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.13-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Same as with 6.1:
> 
> ARM and ARM64 builds worked fine and passed tests, however BMIPS_GENERIC
> fails to build with:
> 
> arch/mips/kernel/smp.c: In function 'start_secondary':
> arch/mips/kernel/smp.c:340:2: error: implicit declaration of function
> 'rcutree_report_cpu_starting'; did you mean 'rcu_cpu_starting'?
> [-Werror=implicit-function-declaration]
>   rcutree_report_cpu_starting(cpu);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   rcu_cpu_starting
> cc1: all warnings being treated as errors
> host-make[5]: *** [scripts/Makefile.build:250: arch/mips/kernel/smp.o] Error
> 1
> host-make[4]: *** [scripts/Makefile.build:500: arch/mips/kernel] Error 2
> host-make[3]: *** [scripts/Makefile.build:500: arch/mips] Error 2
> host-make[3]: *** Waiting for unfinished jobs....
> 
> which is caused by 1fa03a4622bb26a31279a453aa251154f11e6c70 ("mips/smp: Call
> rcutree_report_cpu_starting() earlier").
> 
> It looks like rcutree_report_cpu_starting() has been introduced
> 448e9f34d91d1a4799fdb06a93c2c24b34b6fd9d ("rcu: Standardize explicit
> CPU-hotplug calls") which is in v6.7.
> 
> For MIPS, it would like an adequate fix would be to
> 's/rcutree_report_cpu_starting/rcu_cpu_starting/' for the 6.1 and 6.6
> branches.

Again, the offending change has been dropped now, thanks.

greg k-h


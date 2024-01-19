Return-Path: <linux-kernel+bounces-30780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB52F83244E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C61A1F21872
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A30C4A3C;
	Fri, 19 Jan 2024 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xt7BvpKP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7520246AD;
	Fri, 19 Jan 2024 05:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705642824; cv=none; b=f0jioxxvao2Ac68QJ591Mh5hf3rtSv+pH7fVE0y4fa+/GXY8MKE9/VnCQo1tzrHS+i5eoisl+4lOmCcdIAJKBXmxQiaNFbSBFUwDHQ5JUznaH2X3rq3gV1h+sLLMYxv9VCbA6AmTfbV3Gb+hoWXpwSUNytyT4Mqgool2UZghK/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705642824; c=relaxed/simple;
	bh=5U2+txbxsG7CqjIgj3CsUOtH+mIhI/wUdDud2EcvgxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBgKDFlEuoJAYrneKli9B9juANXQPDYtumj5hWfpT/QvVQPWQhbvpI+Mfu5PsorRe4VYGYIkurVVhZsG57T5/loMU/K3x/CMI1y3jGJH92avoNvpwZd0/pqZx9G1/uMYeKl2QkQkLpJaVpzk1+WAQO5XtKe50TrKWcGPvzdUlzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xt7BvpKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C20C433F1;
	Fri, 19 Jan 2024 05:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705642823;
	bh=5U2+txbxsG7CqjIgj3CsUOtH+mIhI/wUdDud2EcvgxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xt7BvpKPfLtDTQX4t585RAz5DMjC7A/r8gycZSxmPZ8usGD8X8DiPiizaf7n7VBIW
	 OaxVOHd5rpEOQ+EhxIb02KB4mKzBuLId19K61uv1j/f+gIeEscHRK7wZqCfCGpIPFb
	 SH4DGjUZ8Bll9yJN6XYabGV04/JFqWCVT1SGQWN0=
Date: Fri, 19 Jan 2024 06:40:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: stable@vger.kernel.org, Stefan Wiehler <stefan.wiehler@nokia.com>,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/100] 6.1.74-rc1 review
Message-ID: <2024011902-unplanted-dice-2873@gregkh>
References: <20240118104310.892180084@linuxfoundation.org>
 <96dc2b0b-ad51-42f9-a305-744d9d97272e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96dc2b0b-ad51-42f9-a305-744d9d97272e@gmail.com>

On Thu, Jan 18, 2024 at 11:10:31AM -0800, Florian Fainelli wrote:
> +Stefan,
> 
> On 1/18/24 02:48, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.74 release.
> > There are 100 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.74-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
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
> which is caused by 7c20a4cc189eff36d5aeb586008a540d8024fbff ("mips/smp: Call
> rcutree_report_cpu_starting() earlier").
> 
> It looks like rcutree_report_cpu_starting() has been introduced
> 448e9f34d91d1a4799fdb06a93c2c24b34b6fd9d ("rcu: Standardize explicit
> CPU-hotplug calls") which is in v6.7.
> 
> For MIPS, it would like an adequate fix would be to
> 's/rcutree_report_cpu_starting/rcu_cpu_starting/' for the 6.1 and 6.6
> branches.
> 
> Stefan, do you agree?

The offending commit has been dropped from the queue, sorry, I didn't
push out a new -rc yet.

greg k-h


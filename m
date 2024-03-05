Return-Path: <linux-kernel+bounces-91822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD43A871721
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8938F285071
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065067E781;
	Tue,  5 Mar 2024 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mbBCPIkc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF9118E1D;
	Tue,  5 Mar 2024 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624473; cv=none; b=V4YReKQTZ8cpacq+ROsE7lLQxIATLlnATwwoQCbQfYD8fUxPsv/BPmntV5r1nrggwjFEh6eL4IZPBFChkYIOcybv7pYWZpkxxAPbm3UVIBWcLZrGJypyFALMJby6ygzoyRaGlTyVvzy40VwiUqBuaxHRXKdnAg+ame4dcxY/YHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624473; c=relaxed/simple;
	bh=wZQHnw7Und1vjbrZfzAviReNO4ZtbXwyaemuTtj+kv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bR8/9Ydjr/7ZLZdNhaJCHvTh+R5KMEwmVuOtUPTnRV+zUV5uRPYMJ+StYdJHzTKHqEwES9ptXruEUYh0siYV5WEpuffF6wuBvdOUyO/wBp5qd4HgZ2XbFxmtFpObRTkRUH2TsGO1GdX0Ej4YT283Mq/w4eLdJQh878sRAoSTWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mbBCPIkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FDCC433F1;
	Tue,  5 Mar 2024 07:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709624472;
	bh=wZQHnw7Und1vjbrZfzAviReNO4ZtbXwyaemuTtj+kv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mbBCPIkcRDa1PJgdhdZcSAmowwgkuEcX4RG3mcJd/SRCKilA3OfGzDU2iTklRlq+D
	 WRhf7Zer5HmRnaviuA6XA/Fy2eRHb23QB/G7PLSHOlpZqdXMEVv66qYZxlE7Cf1Vs3
	 NiSyY7T/hawDHfMwfqv2V0ctg/Bi9IMUHrGGU0OE=
Date: Tue, 5 Mar 2024 07:41:09 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ron Economos <re@w6rz.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/162] 6.7.9-rc1 review
Message-ID: <2024030538-affair-bristle-25d8@gregkh>
References: <20240304211551.833500257@linuxfoundation.org>
 <dcc13107-8e7e-12c9-e9f0-d0fa96ea9c39@w6rz.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcc13107-8e7e-12c9-e9f0-d0fa96ea9c39@w6rz.net>

On Mon, Mar 04, 2024 at 03:31:00PM -0800, Ron Economos wrote:
> On 3/4/24 1:21 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.7.9 release.
> > There are 162 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.9-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> The build fails on RISC-V RV64 with:
> 
> arch/riscv/kernel/suspend.c: In function ‘suspend_save_csrs’:
> arch/riscv/kernel/suspend.c:14:66: error: ‘RISCV_ISA_EXT_XLINUXENVCFG’
> undeclared (first use in this function); did you mean
> ‘RISCV_ISA_EXT_ZIFENCEI’?
>    14 |         if (riscv_cpu_has_extension_unlikely(smp_processor_id(),
> RISCV_ISA_EXT_XLINUXENVCFG))
> | ^~~~~~~~~~~~~~~~~~~~~~~~~~
> | RISCV_ISA_EXT_ZIFENCEI
> arch/riscv/kernel/suspend.c:14:66: note: each undeclared identifier is
> reported only once for each function it appears in
> arch/riscv/kernel/suspend.c: In function ‘suspend_restore_csrs’:
> arch/riscv/kernel/suspend.c:37:66: error: ‘RISCV_ISA_EXT_XLINUXENVCFG’
> undeclared (first use in this function); did you mean
> ‘RISCV_ISA_EXT_ZIFENCEI’?
>    37 |         if (riscv_cpu_has_extension_unlikely(smp_processor_id(),
> RISCV_ISA_EXT_XLINUXENVCFG))
> | ^~~~~~~~~~~~~~~~~~~~~~~~~~
> | RISCV_ISA_EXT_ZIFENCEI
> make[4]: *** [scripts/Makefile.build:243: arch/riscv/kernel/suspend.o] Error
> 1
> make[3]: *** [scripts/Makefile.build:480: arch/riscv/kernel] Error 2
> make[2]: *** [scripts/Makefile.build:480: arch/riscv] Error 2
> 
> The patch "riscv: Save/restore envcfg CSR during CPU suspend" (commit
> 64e54f78d9f2dc30ac399a632922bb1fe036778a) requires patch "riscv: Add a
> custom ISA extension for the [ms]envcfg CSR" (upstream commit
> 4774848fef6041716a4883217eb75f6b10eb183b).

Ah, that wasn't obvious, I've applied that pre-requsite patch now,
needed to be done by-hand.  I'll push out a -rc2 in a bit with this fix
in it, thanks for testing!

greg k-h


Return-Path: <linux-kernel+bounces-136858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5848889D914
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029971F228E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8893D12D1E9;
	Tue,  9 Apr 2024 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EJZdOfYF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EB712A160;
	Tue,  9 Apr 2024 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665204; cv=none; b=TUouTx1lHxZwiuS/lySr6hjqev6sOXhzMKUwz7fN1tDOD/4Nwm5rIvMP3Gt1n98pcT0tJVOUSRMFy/alvz5dNerX2BZSZazwZ2cD9C336BtQw1i3OjU+0HNvnSXoM/ALIhYQriNlxa7Srv8FHhTTkBZkKdPWURcbXbrNUj2/bdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665204; c=relaxed/simple;
	bh=NWxUNBkQQKPJg7yF9QZzxE7wn37+kXxBAOx3qwp4xxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUmwOGPR2GH+qAOleeJaaBEecGMc70vxFHIpUEWRrKDARsgqFtJ+hSpJmr6Obi0fblhozuTrS4ObIrv8pV99unKE2XUavOoBD/yWiARpzXOoqzLbxk8Wi4zgeka60zvtkZtm+e83Xhuj5oItZiYElHEdaXTIUil/0kr0khQUGVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EJZdOfYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143ACC433F1;
	Tue,  9 Apr 2024 12:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712665204;
	bh=NWxUNBkQQKPJg7yF9QZzxE7wn37+kXxBAOx3qwp4xxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJZdOfYFCDOiJEZcdVm0z4EBT63OPWwkBAY5YL9G1+KLXu4jTIcNxmWQsjCSmtFTg
	 W1V7U8kP/KzSeoVuwbLWL3Vwq9V6FrjLo160d36AGTcvuMIp1V8uGseJmMxZ9Zk6/5
	 O3WnHOzPswnKxf9c+S6IcL0HPp8BuUWAmQI3CBJ4=
Date: Tue, 9 Apr 2024 14:20:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 6.6 000/252] 6.6.26-rc1 review
Message-ID: <2024040949-storeroom-freebase-2ba7@gregkh>
References: <20240408125306.643546457@linuxfoundation.org>
 <CA+G9fYsvgN2ixfmDKc_x8yFnZ3SfrmSV5Ck1QC5KfmYN89CFYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsvgN2ixfmDKc_x8yFnZ3SfrmSV5Ck1QC5KfmYN89CFYQ@mail.gmail.com>

On Mon, Apr 08, 2024 at 10:45:44PM +0530, Naresh Kamboju wrote:
> On Mon, 8 Apr 2024 at 18:30, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.6.26 release.
> > There are 252 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.26-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> The s390 defconfig build failed with gcc-13 and clang-17 due following
> build warning / errors on Linux stable-rc linux-6.6.y.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build error:
> --------
> arch/s390/kernel/perf_pai_crypto.c: In function 'paicrypt_stop':
> arch/s390/kernel/perf_pai_crypto.c:280:51: error: 'paicrypt_root'
> undeclared (first use in this function); did you mean 'paicrypt_stop'?
>   280 |         struct paicrypt_mapptr *mp = this_cpu_ptr(paicrypt_root.mapptr);
>       |                                                   ^~~~~~~~~~~~~
> 
> Commit detail,
>   s390/pai: fix sampling event removal for PMU device driver
>   [ Upstream commit e9f3af02f63909f41b43c28330434cc437639c5c ]

I'll drop the pai patches from this queue as well, thanks!

greg k-h


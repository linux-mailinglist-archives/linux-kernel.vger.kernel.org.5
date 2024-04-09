Return-Path: <linux-kernel+bounces-136854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC70789D90D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D2228A249
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60D112C7E8;
	Tue,  9 Apr 2024 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0EWtxBMo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A624F883;
	Tue,  9 Apr 2024 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665055; cv=none; b=qY/u6LkJnOp9bc7WJai7SSuPWapMljuvAupFnpKQScD9WvFF92Ic9g//gfkCiL0kmE+U0Z3qh4pzHRXKyStSD8/zEGkZ8TpvFIGOesK1qyL7pPXcib5lW4SJZ8ZHZHLIsJRMawJ5nztdPbyv/HXmsWu75Js/i4bJDaMX8yGlfEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665055; c=relaxed/simple;
	bh=fH+pqInuqCP8bPr3hH0Y8Q86LVIvkMeVKXe0pif5V9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLws1CWK3JJ8GVC3bQTiPBwMbIYaLgZ27zs+WrA/a+BkktBKHFSRajp3K+HX8RIc+g/6h8hg7T6mN188fjAkS01RCY9PdjUROLC6knZlNBvNgIeC9jmUk0dcHd8Iark9reFMO/8d3sEH7dQqOqivQtZq0oIog+bDqaE6uDz2lQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0EWtxBMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DB4C433F1;
	Tue,  9 Apr 2024 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712665054;
	bh=fH+pqInuqCP8bPr3hH0Y8Q86LVIvkMeVKXe0pif5V9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0EWtxBMoqzphz7amkYmvLeLupc2mz5UF6CXnZt1n6bkV5RlOez9HF4pe9jifCU4Fh
	 a5ihOtuJpxsDI9TX2knf3Nl2NS9d4dQJlGOfeCLqmqVvKhp6XAQlOehOvPz7x0awI9
	 TUiUYJzJ18gZh9Unq9ncbHzICF+PO9DDY+A5SAgY=
Date: Tue, 9 Apr 2024 14:17:31 +0200
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
Message-ID: <2024040912-item-nearby-d068@gregkh>
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
> 
> Steps to reproduce:
> # tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
> --kconfig defconfig
> 
> Links:
>   - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.25-253-gec59b99017e9/testrun/23347738/suite/build/test/gcc-13-defconfig/log
>   - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.25-253-gec59b99017e9/testrun/23347738/suite/build/test/gcc-13-defconfig/details/
>   - https://storage.tuxsuite.com/public/linaro/lkft/builds/2eozoS8GQGxb94EUWNTPuXvYjVU/

Thanks, I'll go drop a bunch of s390 patches from this tree and push out
a -rc2 later tonight.

greg k-h


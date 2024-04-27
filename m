Return-Path: <linux-kernel+bounces-161064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25968B46A2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697A21F23670
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 14:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEBF50A6C;
	Sat, 27 Apr 2024 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QljWQy1j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AED14F888;
	Sat, 27 Apr 2024 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714227967; cv=none; b=FEhH26UaBsM3nk2wPSTLvBhbGSkJuAtZiBkv1WgIgDs3/hdKlpe4y+cqLkcLc0P2Kve4vYA4T2khAuZHV8gwXdR6FCCou985NaOFYLeI5dAohBqqSuK5Bq15dlt6kL6LemM6/D3a2JiQBSB0BGzmRzpIRP8UG8JEWlLVMfAuG+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714227967; c=relaxed/simple;
	bh=t/apW+NTFNF4ubyJBw+vwSAslJlVBGHf0Ykms0SIwzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRAkr1ZRH5WaNcE8le1Ubo9XITeDW6IAh6EnoY1IVPhi3PEvJpAW5rqqXQmmYSAEvJVuhvjJpOU7oZLr+a+gbb5tTE8YtXewFCFml+A4NGt455Gf/HIGDsFGbQApRxP7NzNmGr6rqjcyMgO5H0u3986BAuQTtjl9T2FEsu5Mp4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QljWQy1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63DEC113CE;
	Sat, 27 Apr 2024 14:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714227967;
	bh=t/apW+NTFNF4ubyJBw+vwSAslJlVBGHf0Ykms0SIwzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QljWQy1j6T1fBvnrVOQ0OTHQltI9XvKWK8WO9LbKVYCDgJ1VyIk2jlJP0NeWoJwJ9
	 6ksVP9DX/QhwT53mY74+g8J3Xu03mNpnn+bfUkIZGIfTlqJ4OAgZSGxznZ7T0xMCba
	 xXELV103kWwCMPk/T11BXOs2gHxHKKiW4zPE6jrI=
Date: Sat, 27 Apr 2024 16:26:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	linux-s390@vger.kernel.org,
	Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH 5.15 00/71] 5.15.157-rc1 review
Message-ID: <2024042757--e526@gregkh>
References: <20240423213844.122920086@linuxfoundation.org>
 <CA+G9fYsm9OYUh+H9X2kpJWXsPdde36=WbSWc+mU0vO0i-QaWOw@mail.gmail.com>
 <3b6b4973-0973-40e4-a107-4c81840c9ed3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b6b4973-0973-40e4-a107-4c81840c9ed3@linux.ibm.com>

On Wed, Apr 24, 2024 at 11:21:05AM +0200, Peter Oberparleiter wrote:
> On 24.04.2024 09:57, Naresh Kamboju wrote:
> > On Wed, 24 Apr 2024 at 03:16, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> This is the start of the stable review cycle for the 5.15.157 release.
> >> There are 71 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, please
> >> let me know.
> >>
> >> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> >> Anything received after that time might be too late.
> >>
> >> The whole patch series can be found in one patch at:
> >>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.157-rc1.gz
> >> or in the git tree and branch at:
> >>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> >> and the diffstat can be found below.
> >>
> >> thanks,
> >>
> >> greg k-h
> > 
> > 
> > The s390 defconfig build failed with gcc-12 and clang-17 on the Linux
> > stable-rc linux.5.15.y branch.
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > Build log:
> > ---
> > drivers/s390/cio/qdio_main.c: In function 'qdio_int_handler':
> > drivers/s390/cio/qdio_main.c:761:52: error: incompatible type for
> > argument 2 of 'ccw_device_start'
> >   761 |                 rc = ccw_device_start(cdev, irq_ptr->ccw,
> > intparm, 0, 0);
> >       |                                             ~~~~~~~^~~~~
> >       |                                                    |
> >       |                                                    struct ccw1
> > In file included from arch/s390/include/asm/qdio.h:13,
> >                  from drivers/s390/cio/qdio_main.c:18:
> > arch/s390/include/asm/ccwdev.h:172:50: note: expected 'struct ccw1 *'
> > but argument is of type 'struct ccw1'
> >   172 | extern int ccw_device_start(struct ccw_device *, struct ccw1 *,
> >       |                                                  ^~~~~~~~~~~~~
> > make[3]: *** [scripts/Makefile.build:289: drivers/s390/cio/qdio_main.o] Error 1
> > 
> > 
> > Suspected commit:
> > --------
> > s390/qdio: handle deferred cc1
> >   [ Upstream commit 607638faf2ff1cede37458111496e7cc6c977f6f ]
> 
> This is due to a type change of field 'ccw' in 'struct qdio_irq' that
> was introduced in v5.17 via commit 718ce9e10171 ("s390/qdio: avoid
> allocating the qdio_irq with GFP_DMA").
> 
> The following change to commit 607638faf2ff ("s390/qdio: handle deferred
> cc1") fixes the compile error on v5.15:
> 
> --- a/drivers/s390/cio/qdio_main.c
> +++ b/drivers/s390/cio/qdio_main.c
> @@ -758,7 +758,7 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
> 
>  	if (rc == -EAGAIN) {
>  		DBF_DEV_EVENT(DBF_INFO, irq_ptr, "qint retry");
> -		rc = ccw_device_start(cdev, irq_ptr->ccw, intparm, 0, 0);
> +		rc = ccw_device_start(cdev, &irq_ptr->ccw, intparm, 0, 0);
>  		if (!rc)
>  			return;
>  		DBF_ERROR("%4x RETRY ERR", irq_ptr->schid.sch_no);
> 
> 

Fix now made, thanks for this!

greg k-h


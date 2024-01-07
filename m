Return-Path: <linux-kernel+bounces-18856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B84B82640D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 13:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967691C20CF4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B95134A0;
	Sun,  7 Jan 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CT+1rRQB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A64A134A3;
	Sun,  7 Jan 2024 12:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D6DC433C7;
	Sun,  7 Jan 2024 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704631031;
	bh=EcBDDzyzHrdfz9dL2OagiVunhve5MMjugf9NKzxoFJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CT+1rRQBUKD00+xkbw312E4PS9V4L6m3yBBM7LT+M9ZktM20pHywgB7eXrrYe1PRZ
	 6GKAEU8sS1y2EI0bNRvoppSMsB1CRimHy2IukXFgGnOP+5P5l+DlMxCfGSnR32r1Jt
	 9vjaiGbZWKN3xRWskeO1GAY6NKIIsUvamaZX0e4M=
Date: Sun, 7 Jan 2024 13:37:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com,
	Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
	Liu Jian <liujian56@huawei.com>
Subject: Re: [PATCH 4.14 00/20] 4.14.335-rc2 review
Message-ID: <2024010750-trembling-starship-796b@gregkh>
References: <20240106084013.773696451@linuxfoundation.org>
 <CA+G9fYsjCRtzFpeBQJepL7H=wyyUu0hi0kN+A3w6-BzksHwYhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsjCRtzFpeBQJepL7H=wyyUu0hi0kN+A3w6-BzksHwYhg@mail.gmail.com>

On Sat, Jan 06, 2024 at 03:18:28PM +0530, Naresh Kamboju wrote:
> On Sat, 6 Jan 2024 at 14:10, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.14.335 release.
> > There are 20 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Mon, 08 Jan 2024 08:40:01 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.335-rc2.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> As Daniel reported on RC1 about this failure.
> Following build failures noticed on 4.14.335-rc2
> 
>  Arm64 with Clang 17:
> 
> -----8<-----
>    /builds/linux/net/8021q/vlan_core.c:332:39: error: incompatible
> integer to pointer conversion passing '__be16' (aka 'unsigned short')
> to parameter of type 'const struct vlan_vi
>    d_info *' [-Wint-conversion]
>      332 |                 if (!vlan_hw_filter_capable(by_dev, vid_info->proto))
>          |                                                     ^~~~~~~~~~~~~~~
>    /builds/linux/net/8021q/vlan_core.c:169:38: note: passing argument
> to parameter 'vid_info' here
>      169 |                                      const struct
> vlan_vid_info *vid_info)
>          |                                                                  ^
>    /builds/linux/net/8021q/vlan_core.c:344:39: error: incompatible
> integer to pointer conversion passing '__be16' (aka 'unsigned short')
> to parameter of type 'const struct vlan_vi
>    d_info *' [-Wint-conversion]
>      344 |                 if (!vlan_hw_filter_capable(by_dev, vid_info->proto))
>          |                                                     ^~~~~~~~~~~~~~~
>    /builds/linux/net/8021q/vlan_core.c:169:38: note: passing argument
> to parameter 'vid_info' here
>      169 |                                      const struct
> vlan_vid_info *vid_info)
>          |                                                                  ^
>    /builds/linux/net/8021q/vlan_core.c:366:39: error: incompatible
> integer to pointer conversion passing '__be16' (aka 'unsigned short')
> to parameter of type 'const struct vlan_vid_info *' [-Wint-conversion]
>      366 |                 if (!vlan_hw_filter_capable(by_dev, vid_info->proto))
>          |                                                     ^~~~~~~~~~~~~~~
>    /builds/linux/net/8021q/vlan_core.c:169:38: note: passing argument
> to parameter 'vid_info' here
>      169 |                                      const struct
> vlan_vid_info *vid_info)
>          |                                                                  ^
>    3 errors generated.
>    make[3]: *** [/builds/linux/scripts/Makefile.build:329:
> net/8021q/vlan_core.o] Error 1
> ----->8-----
> 
> Bisection in this case points to:
> 
>    commit f33474044777425b3578d4e8b22a003f034ae214
>    Author: Liu Jian <liujian56@huawei.com>
>    Date:   Sat Dec 16 15:52:18 2023 +0800
> 
>        net: check vlan filter feature in vlan_vids_add_by_dev() and
> vlan_vids_del_by_dev()
> 
>        [ Upstream commit 01a564bab4876007ce35f312e16797dfe40e4823 ]
> 
> Reproducer:
> 
>    tuxmake --runtime podman --target-arch arm64 --toolchain clang-17
> --kconfig defconfig LD=ld.lld LLVM_IAS=0
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Oops, sorry about that, I missed it, I'll go drop this one now, thanks.

greg k-h


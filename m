Return-Path: <linux-kernel+bounces-51168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B9848747
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401531F240D3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D31D5F852;
	Sat,  3 Feb 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vhkf1Tcw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B85F878;
	Sat,  3 Feb 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975860; cv=none; b=tnds2f6fpIAHUdfGsftxJc5GPwHJlusWjEsUkyIfuYzH50KRJODAJIuMWyKPIQoGZMG3rg5SP2aW7wp/2JpJfeVgd8+0H3/l2JaPblSe4+di52EqSAXYGSgP76arRkU6/TNSiuexPgkRfmUStZaKaxbmaOOkwXYsw05m5uPWFsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975860; c=relaxed/simple;
	bh=qOVHj3tECSeuFB3h+qxLUFSROh9Q5epVXcmihCP6cns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6RQwH0ZB8B7TiA6dbw32MnqchaP+VfuY77MGkvfC9bY/wOFMJfPoed6mpEYLSCighH6nXDgPkiBCCGAG9Fygfj2yuochBUGZGu+GdoIGoUDcN37kIgj7NR+/tqB1761rtcFNC10Bx97gRtdefvXjW/HyF6lqS6JmceEldiIebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vhkf1Tcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10EAC43143;
	Sat,  3 Feb 2024 15:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706975859;
	bh=qOVHj3tECSeuFB3h+qxLUFSROh9Q5epVXcmihCP6cns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vhkf1TcwriY8HWSBqFV4IKDf3QM5U3FMJtCnikffn6uSNUxNSoJZgbou4wYjMgw39
	 Gf7oMUblJ7eFtE8Y7BFggvokSi0g7umjFBGoaVVPpTeFmzEuBGymSNVnqQKN7ElffW
	 yqEunOxXOj4/qWY0XJVTvt1xmWTTeXbotuKAwFVY=
Date: Sat, 3 Feb 2024 07:43:33 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/322] 6.6.16-rc1 review
Message-ID: <2024020321-predict-twister-356f@gregkh>
References: <20240203035359.041730947@linuxfoundation.org>
 <CAKL4bV59sRxqmyn33Xyh9uU8EMxytfqqNFAKxAdFALdWXzr-pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKL4bV59sRxqmyn33Xyh9uU8EMxytfqqNFAKxAdFALdWXzr-pQ@mail.gmail.com>

On Sat, Feb 03, 2024 at 10:48:48PM +0900, Takeshi Ogasawara wrote:
> Hi Greg
> 
> On Sat, Feb 3, 2024 at 1:16 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.6.16 release.
> > There are 322 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Mon, 05 Feb 2024 03:51:47 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.16-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> 6.6.16-rc1 tested.
> 
> Build successfully completed.
> Boot error.
> 
> After selecting the rc kernel in grub I can't proceed further
> 
> Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)
> 
> Thanks
> 
> Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

Any traceback report from the boot error?


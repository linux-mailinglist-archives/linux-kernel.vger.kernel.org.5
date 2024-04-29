Return-Path: <linux-kernel+bounces-162041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996F08B551A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AD5282E16
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659F43716F;
	Mon, 29 Apr 2024 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XGFCufCE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FF02DF84;
	Mon, 29 Apr 2024 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386078; cv=none; b=C2sMYESm/RQKftYdipcKQ0ePlnaI7DpTKRC9MkKztqxEuAcz2V+blpX7cS7Z4+jHhDjTvqR9PjAptwEF1Jg2K0ae3jXIDjC0tyLERd+AEfgAor31F3MtZaj0WAXcHbDmAbHSGxxnEtBRhMrt0cogt0KDgUBxgCZ/MbWGis7rF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386078; c=relaxed/simple;
	bh=/US7Kw5kZPu80V6WMX21GLyYSVJhdIosHlGNM5PSbOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+sTAfW0zvu2UUXyMXCEZADH5VDkjg3oEHI3qysnOSadqT7GOFkGIoBa0xspvhM3YeUvaadWxZxhb/JK/e9XE72rhjWO17TM7lu5ymG+YGrdVB7wlzwMrM7jmDU44mGNd6wAh8dDJNJ9vbnSKrIHPuasg5xr5xcGPPpHnL3JXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XGFCufCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC14C116B1;
	Mon, 29 Apr 2024 10:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714386077;
	bh=/US7Kw5kZPu80V6WMX21GLyYSVJhdIosHlGNM5PSbOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGFCufCEN4QeLZtWcp83R4l7uPcHbawlARLavTvNbciWJe4B6OzB18s/ZIG1hDB6X
	 oDWw3pKaKtSv22/BED849DNjF2P3MuVb6o5FrbsZIxpXdHhBkeGnapuXADUgUl7dwP
	 13d16nQ01eYX70qleS/vBFxyWRJhsGKixdcQY1XA=
Date: Mon, 29 Apr 2024 12:21:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: Re: [PATCH 6.1 000/141] 6.1.88-rc1 review
Message-ID: <2024042950-zesty-napping-e524@gregkh>
References: <20240423213853.356988651@linuxfoundation.org>
 <CA+G9fYuv0nH3K9BJTmJyxLXxvKQjh91KdUi4yjJ0ewncW5cSjw@mail.gmail.com>
 <3yj4eo4ww6wfz4ggaurutemobxi7pwdg7gctnhmwytalimpdcz@hve522lspsdv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3yj4eo4ww6wfz4ggaurutemobxi7pwdg7gctnhmwytalimpdcz@hve522lspsdv>

On Sun, Apr 28, 2024 at 03:32:55PM +0300, Vitaly Chikunov wrote:
> Greg,
> 
> On Wed, Apr 24, 2024 at 01:53:35PM +0530, Naresh Kamboju wrote:
> > On Wed, 24 Apr 2024 at 03:14, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.1.88 release.
> > > There are 141 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.88-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > As Pavel reported,
> > 
> > LKFT also found these regressions on 6.1.
> > 
> > The arm build failed with gcc-13 and clang-17 on the Linux stable-rc
> > linux.6.1.y branch.
> > 
> > arm:
> >  * omap2plus_defconfig - failed
> >  * defconfig  - failed
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> I'm curious why v6.1.88 is still released nevertheless the reports of the
> build regression on ARM32.

Because I missed this, I thought I had dropped it already, sorry about
that.  I'll go do a new release with this commit reverted.

thanks,

greg k-h


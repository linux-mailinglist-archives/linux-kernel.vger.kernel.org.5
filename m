Return-Path: <linux-kernel+bounces-51165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C4B848743
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C6FB25EC5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8225F875;
	Sat,  3 Feb 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I/loqnf3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D62D5F558;
	Sat,  3 Feb 2024 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975858; cv=none; b=kjPrnXkM8Pug6UofZqsKtW0JdcE3ZM1lhsrlGcNbkpoIVz1Rmgr+Pdp6wznwfkbEKbcfFxe0mvkAH4qFdBvU+NCtPDmJqNz5O9eI3seeOHNs/cFlzPd+VueItDub5usHABqpYVd6w26pYN0Szz5QrOE6NXNeHNoSJOLjuSLxcW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975858; c=relaxed/simple;
	bh=RVZICuT7ZNXc0IdPylALsPQkZuzgT2vONmyqyXZSKvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jh/sOMq7bNIgvIfKjcFADVE6cLM3SNGVByGqpiZM4ekSRqYbUrpDVOGa80aVV28tK/W+ULrkCiVbS0V+OeboJcAZd6AQgb5iMasvrpnfxAv31LV/XFCrnrnc3FOjUs7K6GgRyk1PCMbsxSPM/wWnbtRwfovzcKN4Y61QwumdbNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I/loqnf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F84DC43390;
	Sat,  3 Feb 2024 15:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706975857;
	bh=RVZICuT7ZNXc0IdPylALsPQkZuzgT2vONmyqyXZSKvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/loqnf3xC0cpJOS1KVBzxuiHwFqkl+eRgurOlYPknMAzDY4dBmObIwzgxOZEF79A
	 UWK+NS0cIrSDLRl1E8LyL++K78wTXQ/iPd7cNcIpXYr3c4mGLubTyXksLo6x8p70TB
	 DT9DPXb2X1DzC39wd97dOvJ5G97gRmoBkE0aizFE=
Date: Sat, 3 Feb 2024 07:40:06 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com,
	mathias.nyman@linux.intel.com, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH 6.6 000/322] 6.6.16-rc1 review
Message-ID: <2024020313-studio-pronto-db36@gregkh>
References: <20240203035359.041730947@linuxfoundation.org>
 <4344da38-13b2-44db-8a2b-fd65ef5501c1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4344da38-13b2-44db-8a2b-fd65ef5501c1@linaro.org>

On Sat, Feb 03, 2024 at 01:09:15AM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 02/02/24 10:01 p. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.6.16 release.
> > There are 322 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Mon, 05 Feb 2024 03:51:47 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.16-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Same problems as reported on 6.7 and 6.1.
> 
> Build error/warning ("variable 'slot_id' is uninitialized", as seen on 6.7 and 6.1) can be found on this branch too, with Clang 17 and Clang nightly on Arm64, Arm32, i386, x86, MIPS, RISC-V.
> 
> Build error due to pmicintc is present on this branch too.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Yeah, looks like the xhci changes here are not for stable as the fix it
makes is not correct here (it depends on other changes.)  I'll go drop
them and push out new stable trees, hopefully that should resolve the
issues people are having.

thanks,

greg k-h


Return-Path: <linux-kernel+bounces-142235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8E88A2952
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F150B2444E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379CF50289;
	Fri, 12 Apr 2024 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wMzlvF2D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621D4F207;
	Fri, 12 Apr 2024 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910471; cv=none; b=Q34CaPT2H/HxiVgfYAagSPgl2syMsc7qTPkbbr/QDbL659PdInEIAVppYuqQAHxXbU/DCk+dMUzwkLn+IJjIMHI+KbSKukATA8uOKalZoXUAY3oLZ65PCaMbWL3R8msx88ywqGgp5WrDFhANon1sCyj9JYUlQXVCXqkTXpVNPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910471; c=relaxed/simple;
	bh=SI50fOegoy4JwcolEOsaawKppGsiXM/kU7sAEoFaA7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHZ9Zmz8Yd9amr54+VF7IMvLAOP68nc30N98iaeuI8/JzD7Dxzbggs+/73AXHO5F+QXtcBzI9GTEmdzWMYHoaZSWcc5YlsnRy/bvv8dTNGKPD3cQr2ileL73wnv9f751FwBgD1e5URdC4DvwYMK220s2r80DMghckMw9XaRmaHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wMzlvF2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7B8C113CC;
	Fri, 12 Apr 2024 08:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712910471;
	bh=SI50fOegoy4JwcolEOsaawKppGsiXM/kU7sAEoFaA7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wMzlvF2DMQNYWf39zEMXhp3luphHuwnEg3TdJnhAmaRy+pR5bNQ2IwWf8UnPAyh2B
	 RHjDNxiByP+62YOlcwsycjzv6ANVm+yB84tS8XWIsz1neRe21wofBZKs9yjRqsMlGB
	 GkijpeSJ5loAVxzSlL3S6fMcYPVBBOIxkWolYV7A=
Date: Fri, 12 Apr 2024 10:27:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
Message-ID: <2024041243-finishing-jump-c142@gregkh>
References: <20240411095407.982258070@linuxfoundation.org>
 <e944c094-b503-4a9a-a5d0-487c8b056e34@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e944c094-b503-4a9a-a5d0-487c8b056e34@linux.microsoft.com>

On Thu, Apr 11, 2024 at 11:36:28AM -0700, Easwar Hariharan wrote:
> On 4/11/2024 2:57 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.155 release.
> > There are 57 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.155-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> <snip>
> 
> I wanted to repeat my request from another thread[1] here, that we revert commit 4949affd5288 
> ("ACPI: CPPC: Use access_width over bit_width for system memory accesses") in 5.15.155 due to
> known problems with the patch, so it's not lost in the mail storm.
> 
> Thanks,
> Easwar
> 
> [1] https://lore.kernel.org/all/97d25ef7-dee9-4cc5-842a-273f565869b3@linux.microsoft.com/

Now handled, thanks.

greg k-h


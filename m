Return-Path: <linux-kernel+bounces-136864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 427B989D929
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8A728A000
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A5912D212;
	Tue,  9 Apr 2024 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mBDTJIn2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D7129A7B;
	Tue,  9 Apr 2024 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665401; cv=none; b=OqPOggGGEeXUffdn2e/h4E5wS/0uZNA0tdSPB7817aeHjxp1qNdu6Xz0K6vJ2vHn792hB41vNL2IgtMmdRbSSWaNw+gNxpezLS3GpVLDmGvcaDichDwyAeqOU4wr4vTI2z2sfJotgKOTsbFSVs8/5t2/5ay6QPBvALWVxVhKers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665401; c=relaxed/simple;
	bh=NycTO7793+mfVmUiuwrixveuDF/iXTzH2p2ZKDi6sAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhkB/pSPtBbYqtpU86Hm/fFSAvXunpIaxRKV9qJZYY5qhhxzxorff0WEfuZIud2Qdn43GgnisKUa/ECNkPBYj7gTJqioFRiHmU4xTS0hlJYqvQ07x0nnPKZhhxlpqpMcpahw2Lyu7QutSaZpF9bcSBqs1mQJ1RbPqhIf32KUexo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mBDTJIn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6503AC433F1;
	Tue,  9 Apr 2024 12:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712665401;
	bh=NycTO7793+mfVmUiuwrixveuDF/iXTzH2p2ZKDi6sAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBDTJIn2guxxOb42ddF31Oq2kE55NEuY/9V60CA49z/+O5gBZv67yiKLkQ79YyR9O
	 AdX1eMhyhsEQXS0RbqtTTQyTognxO/i4ASDA20yS3fcstV5VNeRPbg+z/jwLbshR2h
	 7tU0Su+ms1z0nXKmc9bYuqKlK+d+Qoe92YYcXlQc=
Date: Tue, 9 Apr 2024 14:23:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.15 000/690] 5.15.154-rc1 review
Message-ID: <2024040953-eclipse-recount-dda9@gregkh>
References: <20240408125359.506372836@linuxfoundation.org>
 <04151fac-3bf6-4199-a822-2fbaaef8b77b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04151fac-3bf6-4199-a822-2fbaaef8b77b@nvidia.com>

On Tue, Apr 09, 2024 at 07:53:14AM +0100, Jon Hunter wrote:
> Hi Greg,
> 
> On 08/04/2024 13:47, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.154 release.
> > There are 690 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.154-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> I am seeing a suspend regression on Tegra186 and Tegra194 ...
> 
> Test results for stable-v5.15:
>     10 builds:	10 pass, 0 fail
>     26 boots:	26 pass, 0 fail
>     102 tests:	100 pass, 2 fail
> 
> Linux version:	5.15.154-rc1-gbfeab055fa43
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
>                 tegra20-ventana, tegra210-p2371-2180,
>                 tegra210-p3450-0000, tegra30-cardhu-a04
> 
> Test failures:	tegra186-p2771-0000: pm-system-suspend.sh
>                 tegra194-p2972-0000: pm-system-suspend.sh
> 
> 
> Bisect is pointing to the following commit and reverting this fixes it ...
> 
> > NeilBrown <neilb@suse.de>
> >      nfsd: don't allow nfsd threads to be signalled.
> 
> 
> When suspend fails, I see the following error message ...
> 
>  Freezing of tasks failed after 20.006 seconds (1 tasks refusing to
>  freeze, wq_busy=0):

Odd.  I'll go drop this commit now, thanks for testing and bisecting!

greg k-h


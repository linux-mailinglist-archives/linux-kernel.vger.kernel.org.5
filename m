Return-Path: <linux-kernel+bounces-136927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B61489D9FD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1F51C2274F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66DD12F376;
	Tue,  9 Apr 2024 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NHMb4LZs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045A78287F;
	Tue,  9 Apr 2024 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668766; cv=none; b=jA3pNNMXetXN4LZwvjYjtlVsNg4iPaFPz4o/TT+1B8OHFIia78lwDAda9xrAmeg3hDJHDj2jdj/4A/emvOfJXG4LVsdBkz7n/sA5vVp7UsIzGnO1jgpnVf8XBcfEAVwiiWjC+6+YlUz6WmPlJwjU72H1O8LBFQk5d4+puJo/ufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668766; c=relaxed/simple;
	bh=YVG+/lZQ9MbdWHKh47sOgDL15xLsmMkosONhcqSo/28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5Jbv9FXHixu5vA17om9wVL2RreeLaZkjNFIQqI8eECcjcij4o+kxs6RDHFxe3bO2KSvYu2saZ0gBAGGqOgldg2vOy2urKuiecJah5vBMwMptPGgobMvjdgXP1aQoO6lJU3vxHs56KyBBeznQXHGbxsN6vXsZfvfB1tB70kp5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NHMb4LZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24574C433F1;
	Tue,  9 Apr 2024 13:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712668765;
	bh=YVG+/lZQ9MbdWHKh47sOgDL15xLsmMkosONhcqSo/28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHMb4LZsLl/7B122HbDaqYEGSMc0LY/6Fj34WaramIKrmhOxn4S27Nv4bged81Y6Y
	 ZxIuExjpkakltgj1xs59Vdd+xyLqcsgQ+XiR/4hIPhpUmiDG1gLuxcg+r7gQ9oewBA
	 sx1MCnh7cwbTCPYnYp1hwOaC5mKWe0HrmTxryQfw=
Date: Tue, 9 Apr 2024 15:19:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	bvanassche@acm.org, Alexander@wetzel-home.de
Subject: Re: [PATCH 6.8 000/273] 6.8.5-rc1 review
Message-ID: <2024040910-curable-scarce-70b6@gregkh>
References: <20240408125309.280181634@linuxfoundation.org>
 <CADYN=9KoZSBy_sbKR9ZTzcUXuUgA+PwdhAMuA5BEHP-BHjdnNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9KoZSBy_sbKR9ZTzcUXuUgA+PwdhAMuA5BEHP-BHjdnNg@mail.gmail.com>

On Tue, Apr 09, 2024 at 03:07:24PM +0200, Anders Roxell wrote:
> On Mon, 8 Apr 2024 at 15:00, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.8.5 release.
> > There are 273 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.5-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro's test farm.
> Regressions on x86_64, and i386.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Following kernel warnings have been noticed on  x86_64, qemu-x86_64 and
> qemu-i386 while running LTP cve ioctl_sg01 tests the kernel with stable-rc
> 6.6.26-rc1 and 6.8.5-rc1.
> 
> Reverted this patch and I couldn't see the repoted warning.
> scsi: sg: Avoid sg device teardown race
> [ Upstream commit 27f58c04a8f438078583041468ec60597841284d ]
> 
> This has been reported on stable-rc 6.8.3-rc1 [1].

Ugh, let me go drop this again, thanks for catching it!

greg k-h


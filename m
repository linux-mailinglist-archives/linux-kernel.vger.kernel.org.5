Return-Path: <linux-kernel+bounces-164026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6728B7751
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA13B21698
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31C6171E5E;
	Tue, 30 Apr 2024 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B3rsOOIE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790E171640;
	Tue, 30 Apr 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484314; cv=none; b=ctnYhg1UKQOrC8tVVmAY9PSeuxN5Wc7ugAxVkRCGUuTW77Qk/wArt6MkXjZVN6Qsbu3ZACuq+vHD1PVjzBOzS3BMLN72U34JsqD+CIMTvNM9QwkyopKRLSJrrHEwQCsp1OTGTB8b6pQ+9lEJGnj/lw31qOozRNUqDxHjeTft7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484314; c=relaxed/simple;
	bh=85423548L6PkpsrwZWJTzPuUBKlJs5S0cRwmVvzOFMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGCbErArsWH9AJXu2RvAr3W1Ihj7+EPydduZ4FNumJrx06qXHO12MsYHVIVHs19UxCBdy+TZ1Q0YcXpHBicrK6IwYSkb21dgnkKCFESMC6I2UJQ3HxmU2Boz8bTUBXYSX0N4rBgfB7vOzQ7b4h0stxUm86vZvSZi4ijfPTaL1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B3rsOOIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B3DC2BBFC;
	Tue, 30 Apr 2024 13:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714484313;
	bh=85423548L6PkpsrwZWJTzPuUBKlJs5S0cRwmVvzOFMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B3rsOOIEMN/S7NDgWQFYK0GTXRvljckyWMXgkxsV0Rs7Xe2cC2w6KrpNR//3abj+B
	 wh3p89w6cE2aGW22aPWGJg4ClWln1e7LezSKNlw8BwsHZ5spDEwFKp16yXOvpP8bxw
	 KNQ49qoqFb2mE1MJKY5PZ1iqJFaASvE4pnW6f6Q0=
Date: Tue, 30 Apr 2024 15:38:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 5.4 000/107] 5.4.275-rc1 review
Message-ID: <2024043018-freely-outscore-38c6@gregkh>
References: <20240430103044.655968143@linuxfoundation.org>
 <c114e341-be56-4e30-9e55-2b08f983c916@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c114e341-be56-4e30-9e55-2b08f983c916@oracle.com>

On Tue, Apr 30, 2024 at 05:40:44PM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> 
> > Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.275-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> > 
> ...
> 
> > Ikjoon Jang <ikjn@chromium.org>
> >      arm64: dts: mediatek: mt8183: Add power-domains properity to mfgcfg
> > 
> BUILDSTDERR: Error: arch/arm64/boot/dts/mediatek/mt8183.dtsi:580.26-27
> syntax error
> BUILDSTDERR: FATAL ERROR: Unable to parse input tree
> BUILDSTDERR: make[2]: *** [scripts/Makefile.lib:285:
> arch/arm64/boot/dts/mediatek/mt8183-evb.dtb] Error 1
> BUILDSTDERR: make[1]: *** [scripts/Makefile.build:497:
> arch/arm64/boot/dts/mediatek] Error 2
> BUILDSTDERR: make: *** [Makefile:1290: dtbs] Error 2
> 
> aarch64 builds are failing with the above error

Thanks, will go drop it from 5.10 and 5.4 queues and push out a -rc2.

greg k-h


Return-Path: <linux-kernel+bounces-18819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EC582637A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 09:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77544282739
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 08:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B35810A0F;
	Sun,  7 Jan 2024 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kxpDCqQs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0712B68;
	Sun,  7 Jan 2024 08:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AC7C433C8;
	Sun,  7 Jan 2024 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704617602;
	bh=k2CLj7z3NI/bECjiFCnxSPXUHkYt9xTah9XeKUga9uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxpDCqQs6tj3BJqdVPgigUcGV6cpho3tG7zYGlzcOkzvsDNEzGCO9SEVYhehQSSV3
	 VaKEwFmZdao8Z0Gsy7UIemI8yUvqvta8EbMDF4bjZJw6QGASVd2jvnHRVJYNOGyoqV
	 lEZaS5anjxbSPK6iNPvNJecOcEplzn1aag8HAyFA=
Date: Sun, 7 Jan 2024 09:53:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 5.15 00/67] 5.15.142-rc1 review
Message-ID: <2024010711-skeletal-material-15e8@gregkh>
References: <20231205031519.853779502@linuxfoundation.org>
 <c8ebf598-4d9a-4ce0-bccf-2109150919dc@oracle.com>
 <2023120618-around-duplicity-8f8f@gregkh>
 <CAM9d7cjNgbLPbKV11045zH8ULJxwPWUr3wikFU2Ex1cH_0XxQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjNgbLPbKV11045zH8ULJxwPWUr3wikFU2Ex1cH_0XxQA@mail.gmail.com>

On Sat, Jan 06, 2024 at 04:54:34PM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Dec 5, 2023 at 10:17 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Dec 05, 2023 at 12:46:43PM +0530, Harshit Mogalapalli wrote:
> > > Hi Greg,
> > >
> > > On 05/12/23 8:46 am, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.15.142 release.
> > > > There are 67 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc1.gz
> > > > or in the git tree and branch at:
> > > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > > Adrian Hunter <adrian.hunter@intel.com>
> > > >      perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
> > > >
> > > >
> > >
> > > ^^ This commit is causing the perf/ build failure:
> > >
> > > In file included from util/jitdump.c:29:
> > > util/genelf.h:5:10: fatal error: linux/math.h: No such file or directory
> > >     5 | #include <linux/math.h>
> > >       |          ^~~~~~~~~~~~~~
> > > compilation terminated.
> > >
> > > This was previously reported on 5.15.136-rc:
> > >
> > > Vegard shared his analysis on ways to fix here:
> > >
> > > https://lore.kernel.org/stable/fb1ce733-d612-4fa3-a1e4-716545625822@oracle.com/
> >
> > Now dropped from here and 4.19.y
> 
> Sorry for the super late reply and happy new year!
> 
> As Vegard noted we can change the header to <linux/kernel.h>
> to avoid the build issue.  I don't expect more changes in this
> code so it's unlikely we have conflicts here.  Let me know if
> it happens later.
> 
> Anyway this code is needed to handle JIT-dump binaries
> generated by perf inject.  I'll send a patch if it's ok to you.

Just send an updated patch please.


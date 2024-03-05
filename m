Return-Path: <linux-kernel+bounces-92470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E689B8720D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2261282CB9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06AA8612C;
	Tue,  5 Mar 2024 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPBEgT0z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A6762DF;
	Tue,  5 Mar 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646698; cv=none; b=j/8Po7ZYtbhq+FPh3SGHJsWAkthBrH6R29m6vKhjGXagflltT++ZZ180c6KMmybkuCBrg0c65yGB6MAdeBZyO0QPKOOCK1jhEyeEk+qgTKB6OnuS6n4dlRYUC1fgOaaIVrTE/vbOC4Suf2DPiOOTHaodzC2hVaaKMBbOmzOXXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646698; c=relaxed/simple;
	bh=fCj5iwo9v14uEMpRZ3mkoCxKtCZRsdCnJwUBfQ0/Fdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhYK73Rzt0p+ig/0LcuMOr4cUIG41yv+X91cmXry3HhbGB0PyYe/saRS+DWjaeLeWuAqioRIwXGFB7DDk9Yz52uucSX8RQp1pYO1efxCWvYG42Z6RcnYx5toFS+OjC9lt1bx8W2cPJ6+eI7DtBLD8PZBiQByx+8B5NVu/J3rdXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPBEgT0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572A2C433C7;
	Tue,  5 Mar 2024 13:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709646697;
	bh=fCj5iwo9v14uEMpRZ3mkoCxKtCZRsdCnJwUBfQ0/Fdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LPBEgT0zgzdMuuwlu9frzkuCZxVHaxx3EMz8btKj4RBSKZyvpEbHv/rza82HdbSew
	 GU49teZaKaKhLZj4AVjYuWvbLFMc+EFWau1wJq3xKehyLcJjbGl3RUSOF8FlliWiDC
	 GtNAkQlUsGWQbKbjIEjQTWy2okoPsnCg5Xi/GILvxhSpq6nFRYXHOp7Il99gaCpwas
	 lsu6Cp2GIcxMxROEzAmqBihJO8/sHP4PRQmGBGpqPLC0O5+gy7EUf2f56NJOPLw+3d
	 wv/JfOIEwcU71TqnImYTfc3NYIuKKSR/mjLvqw0yZnRM83gCpVkbNOei2LA42Isp00
	 LX8OtVHikO9SQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rhVCq-000000000Ek-2aI6;
	Tue, 05 Mar 2024 14:51:44 +0100
Date: Tue, 5 Mar 2024 14:51:44 +0100
From: Johan Hovold <johan@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vinod.koul@linaro.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: Lenovo ThinkPad X13s regerssions (was Re: Linux regressions
 report for mainline [2024-02-25])
Message-ID: <ZecjcApvdZSGRysT@hovoldconsulting.com>
References: <170886726066.1516351.14377022830495300698@leemhuis.info>
 <Zd23ZKlNnDKPaU9I@hovoldconsulting.com>
 <83c6019f-9c6f-4ad1-87d5-e4f1bdaca93c@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83c6019f-9c6f-4ad1-87d5-e4f1bdaca93c@leemhuis.info>

[ +CC: Vinod, Bjorn, Abhinav ]

On Tue, Mar 05, 2024 at 10:33:39AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> [dropping Linus from CC, we can add him back later when needed]
> 
> On 27.02.24 11:20, Johan Hovold wrote:
> > On Sun, Feb 25, 2024 at 01:21:46PM +0000, Regzbot (on behalf of Thorsten Leemhuis) wrote:
> > 
> >> Johan Hovold also deals with multiple issues affecting Lenovo ThinkPad
> >> X13s, but he send out patch series to fix some or all of those[1], so
> >> with a bit of luck those issues will soon be fixed as well.
> >> https://lore.kernel.org/lkml/ZctVmLK4zTwcpW3A@hovoldconsulting.com/
> 
> As 6.8 final might be just five days away, could you please help me out
> with a short status update wrt. unresolved regressions from your side if
> you have a minute? It's easy to get lost in all those issues. :-/ :-D

Heh. Indeed. It's been a rough cycle. :)

> >> [1]
> >> https://lore.kernel.org/lkml/20240217150228.5788-1-johan+linaro@kernel.org/
> > 
> > This series addresses a use-after-free in the PMIC glink driver caused
> > by DRM bridge changes in rc1 and which can result in the internal
> > display not showing up on boot.
> > 
> > The DRM/SoC fixes here have now been merged to drm-misc for 6.8.
> 
> What about the others from that series? Can they wait till 6.9? Or are
> they on track for 6.8?

Vinod, the PHY maintainer, just told me he will try to get them into
6.8.

> > But also with these fixes, there are still a couple of regressions
> > related to the Qualcomm DRM runtime PM rework in 6.8-rc1. I'll send
> > separate reports to track those.
> 
> Any decision yet if they are going to be reverted for now?
>
> Am I right assuming those would fix
> https://lore.kernel.org/lkml/Zd3kvD02Qvsh2Sid@hovoldconsulting.com/
> which did not get even a single reply?

That was the hope, but I've managed to trigger a reset on disconnect
once also with the runtime PM series reverted.

One of the patches from that series has already been reverted (to fix
the VT console hotplug regression) and there is some indication that
that was sufficient to address the issue with hotplug not being detected
in X/Wayland too. I'm waiting for confirmation from some users that have
not been able to use their external displays at all since 6.8-rc1, but
it does seem to fix the X/Wayland issues I could reproduce here.

But either way, the reset on disconnect is still there, and have since
been reproduced by Bjorn also on another Qualcomm platform without a
hypervisor so that we've now got a call stack. I've heard that Abhinav
is looking into that, but I don't know if there's any chance to have a
fix ready this week.

Johan


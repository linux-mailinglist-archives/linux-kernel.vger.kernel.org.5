Return-Path: <linux-kernel+bounces-140254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C6F8A1043
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A81E1C218A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023C614C5B5;
	Thu, 11 Apr 2024 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM6Rquck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAC8149E1A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831502; cv=none; b=pQe86Yj8pQfZ9eKTFbmVEUvM6vGhwlLPuGmO5VJghx8RwtBysJaKFT/Ie6MHJbiawKYKOhc/RTSLSQ3hKFDngm+Zhm+mXDv3sUIsW+E1S3sr0+qnY92R0jPqNT5FshFgcdjoaKUI+piZRg+BjRLZgv/I7zXuDDsSiyWJEdE45mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831502; c=relaxed/simple;
	bh=2d27AzIjl7bRIiAhdppOGrO+JSnCCLLNZjUvoT3BXNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KR8ilnTlAc5+9MSIMLa61THpRhPH9DhXt+pkCC82vadIM+5Vt8Q3Sv0WWYR1ox3MGLT2aWrAddNpq+oq68wXC354jEhbaXKrMhUJEyDw06mjlbHmoJ1U6PoKLphr8osTo3IiNEORtfOLLUYp37nFtPtMhSTxINMIMGwvQfjJcPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM6Rquck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E696DC433F1;
	Thu, 11 Apr 2024 10:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712831502;
	bh=2d27AzIjl7bRIiAhdppOGrO+JSnCCLLNZjUvoT3BXNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QM6RquckSTK7RmSEdm1KI3EVT+wPwz31nDlefiV8jjFod2Kf6g/CQC7mMFqGELtUz
	 PWDAlccKN1yQ22rkX+MsFZgLzFo/QzgSmDgjM0Vm7hFqfv4noA8lfIOKCp1ymRA5t4
	 Lw575JeE/wEoUa7xFy966rDM/SxcUXkvXWIKB4VmNePNpQKH8dWMaLKquk0TJw+GK+
	 gTSUEuS2W8Bzs44caBE8dzccIkv0+a36MtyM61/enOcgQDaqEW+wUriL9hIdUPzyS6
	 qYzCGyFSENRzNP26JU0v0qIc9Z3mPJvrEEv9iKB5be52v8Ltb2Upp1iT+cUN/NkZfo
	 4mCSyIdiGUp/Q==
Date: Thu, 11 Apr 2024 11:31:37 +0100
From: Will Deacon <will@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Robin Murphy <robin.murphy@arm.com>, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Set PMU device parent
Message-ID: <20240411103137.GA26072@willie-the-truck>
References: <25d4428df1ddad966c74a3ed60171cd3ca6c8b66.1712682917.git.robin.murphy@arm.com>
 <20240410180403.00004cff@Huawei.com>
 <20240410181226.000068eb@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410181226.000068eb@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 10, 2024 at 06:12:26PM +0100, Jonathan Cameron wrote:
> On Wed, 10 Apr 2024 18:04:03 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Tue,  9 Apr 2024 18:15:17 +0100
> > Robin Murphy <robin.murphy@arm.com> wrote:
> > 
> > > Now that perf supports giving the PMU device a parent, we can use our
> > > platform device to make the relationship between CMN instances and PMU
> > > IDs trivially discoverable, from either nominal direction:
> > > 
> > > root@crazy-taxi:~# ls /sys/devices/platform/ARMHC600:00 | grep cmn
> > > arm_cmn_0
> > > root@crazy-taxi:~# realpath /sys/bus/event_source/devices/arm_cmn_0/..
> > > /sys/devices/platform/ARMHC600:00
> > > 
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>  
> > Nice.  I'd forgotten all about this :( 
> > 
> > https://lore.kernel.org/all/20230404134225.13408-1-Jonathan.Cameron@huawei.com/
> > still has a bunch of these + there were many I never looked into.
> > 
> > Guess I should respin that series though probably 50% at least still apply.
> 
> Ironically other than this one, almost the only ones that didn't go in cleanly
> are the hisilicon drivers where there was some churn.
> 
> Will, if you 'want' to pick any of those up directly feel free, if not I'll sent
> them out again in a few days time (and check there weren't any requests for
> changes buried in that rather extensive thread!)

It's probably best to send a new series regardless, but I'm happy to
pick up anything touching drivers/perf/ if they don't depend on any core
changes.

Will


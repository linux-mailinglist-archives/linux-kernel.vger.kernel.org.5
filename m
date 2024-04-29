Return-Path: <linux-kernel+bounces-162341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FC98B5997
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45051B25616
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E626F510;
	Mon, 29 Apr 2024 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="I0IvXxBC"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C16A8DC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396329; cv=none; b=mYKezqvqz9YQCxeXxDiEPhfeTRIVmz41gzw06AaiUdMqNawzvzAq8f2rlKe20idJuJq3IdPKCQoIuki65cvQygex8LloMKOFLgAxo8i0UOn7v9pxLFmRikMFBEN3xMccuC4m5XD3FugWX8Cy7W1DPIMKjEwE8AB9B1QVx+8DKR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396329; c=relaxed/simple;
	bh=z19VIn1sG6igy5dUMxCt2WQyOdvkz0w8IHOvqAg2Rhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmYncc1BxUyaH/G+7Yq9rgZXNn0v5gcr9Lri8gNGk/cwbHD3/huX13AMsWFK+X+pXh69kcQVS5anPZtsObNne0IXJYGY15LqDJ8SZ6fvPYw6oV+Ml8ixUaGwr50q7mTZH+H0Y+VAEgHDoctN6JziV+ftslSFHgDBjTnUxWoNqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=I0IvXxBC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ox5aOTl2u3/O1HZ+ZjOWh89n2x4TqGAsSONUIygHFgI=; b=I0IvXxBCdTEiV8oJVfpfFuUtvt
	BExqcDkxn6HFrDIcmv5MVWJCgHmFydJw/wApnTjQU4ivtR6zuMuhbVHvgZIjhGQYoZUEobCybpZOR
	C8A07Z86xgAnGpUfyf2T/+/4rJWjGe7TstwmFZ8WgicG+kd+djDweRq1MV2AnJWfSFn2ODYc3uQ7L
	fwWFvVUY8MX+3C5038L54rPnenLAg92iwBdN/IjL+NYigOE2qmIqBRsNfBNsoaPpzx+VPX2HbK69N
	yIzu1aRRvWoaGRpIwuY6fdBm6KqzerhU5zevmY78awFLkLR9oUVyHi8qOIPWkdhdKCEx8A5imh8VY
	MDz52Dmg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60030)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s1QnV-0003Cq-2G;
	Mon, 29 Apr 2024 14:11:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s1QnV-0000sD-57; Mon, 29 Apr 2024 14:11:57 +0100
Date: Mon, 29 Apr 2024 14:11:57 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Boy Wu =?utf-8?B?KOWQs+WLg+iqvCk=?= <Boy.Wu@mediatek.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"andreyknvl@gmail.com" <andreyknvl@gmail.com>,
	"dvyukov@google.com" <dvyukov@google.com>,
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
	Iverlin Wang =?utf-8?B?KOeOi+iLs+mclik=?= <Iverlin.Wang@mediatek.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	Light Chen =?utf-8?B?KOmZs+aYseWFiSk=?= <Light.Chen@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"glider@google.com" <glider@google.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] arm: kasan: clear stale stack poison
Message-ID: <Zi+cnTPS1rgHtneN@shell.armlinux.org.uk>
References: <20240410073044.23294-1-boy.wu@mediatek.com>
 <CACRpkdZ5iK+LnQ0GJjZpxROCDT9GKVbe9m8hDSSh2eMXp3do0Q@mail.gmail.com>
 <Zi5hDV6e0oMTyFfr@shell.armlinux.org.uk>
 <292f9fe4bab26028aa80f63bf160e0f2b874a17c.camel@mediatek.com>
 <Zi+Vu29rmNZ0MIFG@shell.armlinux.org.uk>
 <f90f5352-30ed-419f-803b-7885b4298868@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f90f5352-30ed-419f-803b-7885b4298868@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 29, 2024 at 02:57:35PM +0200, Andrey Ryabinin wrote:
> On 4/29/24 14:42, Russell King (Oracle) wrote:
> > On Mon, Apr 29, 2024 at 07:51:49AM +0000, Boy Wu (吳勃誼) wrote:
> >> On Sun, 2024-04-28 at 15:45 +0100, Russell King (Oracle) wrote:
> >>>  On Fri, Apr 12, 2024 at 10:37:06AM +0200, Linus Walleij wrote:
> >>>> On Wed, Apr 10, 2024 at 9:31 AM boy.wu <boy.wu@mediatek.com> wrote:
> >>>>
> >>>>> From: Boy Wu <boy.wu@mediatek.com>
> >>>>>
> >>>>> We found below OOB crash:
> >>>>
> >>>> Thanks for digging in!
> >>>>
> >>>> Pleas put this patch into Russell's patch tracker so he can apply
> >>> it:
> >>>> https://www.armlinux.org.uk/developer/patches/
> >>>
> >>> Is this a bug fix? If so, having a Fixes: tag would be nice...
> >>>
> >>
> >> This is a patch for cpuidle flow when KASAN enable, that is in ARM64
> >> but not in ARM, so add to ARM.
> >>
> >> The reference commits did not mention fix any commits.
> >> [1] commit 0d97e6d8024c ("arm64: kasan: clear stale stack poison")
> >> [2] commit d56a9ef84bd0 ("kasan, arm64: unpoison stack only with
> >> CONFIG_KASAN_STACK")
> > 
> > These are not suitable for use as a Fixes: tag because these commits
> > refer to code in another part of the tree that has nothing to do with
> > the BUG() dump that is contained within your commit message.
> > 
> > I ask again... Is this a bug fix?
> > 
> > Is it a regression?
> > 
> > Is it something that used to work that no longer works?
> > 
> > When did it break?
> > 
> > Has it always been broken?
> > 
> > Has it been broken since KASAN was introduced on 32-bit ARM?
> > 
> 
> Yes, this is a bug fix and it has been broken since KASAN was introduced on 32-bit ARM.
> So, I think this should be
> 	Fixes: 5615f69bc209 ("ARM: 9016/2: Initialize the mapping of KASan shadow memory")

Brilliant, thanks! Now merged.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <linux-kernel+bounces-162263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C608B58CA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49321C21B27
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FF210961;
	Mon, 29 Apr 2024 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vYbycYWT"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252F8487
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394567; cv=none; b=FijIYvlxy+jA15R/gNfWN35qEvYVbflhC/ie3O9aVYDNbSXzginT19NhikOjxsw80rMHhtsbJVKAEpkSBT3sgCkXgbAGLdAU9NCinB7qZrphryzOTYZsA3sm9c6K1YXEgdRUQ6Hsihfo9MAGI1fYE9aiJknEtozkq5RwzH/aQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394567; c=relaxed/simple;
	bh=7HFasztXyIip+BZX7WZ3Rgr7TZnbM+tUYe/4THXxClw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7U9KkjCETPwAsmwbtOvoO/742yf/hQp2B1a66gFVWcO2rDYCWoyG2bkFuBZ6lUkxDF9xfwZqowH9kKNGtKfxu6CuQt+3nGnntFjnaOvuNW8DbKg6kJ7gvMReQTl4XpPWCrS5eVHg0B56W1CIeaYk6Ls0p3qQt8VFIPNURlxuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vYbycYWT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=359x1PKhAyHtMkK/vfg2dPAMOncA3H2TWjtf6Bw1En4=; b=vYbycYWT4MBRluDs5xVIosCe64
	PoAiVqtvB/HQB7xzaPjqvvXwoJk7GZsxbrkQg4SeLfaY9e6Q/9QwK674915+AG/aqy5rAIy/fZdGI
	sr23cYjAxdQ2jSvbWcuxLmxJK4TFe2UqbsnOdSYc1lyJFum1Poq8h+zValqB+Op9LtF7B/0JNAj6f
	1367WEZ0biSe8kNKt/WHyA7wStFD2iZ/J3Wcuas4Qr6FefpCj6t6qMZ4Stcf/KqTgZmFi8R++jHBL
	6Ixq+5mv1xgFNPHDV239kY/XTgDiXBc0ymvAH4MoaBnXHuG7pLs8UiNqa8IAMiRyvBhUCalMSlGrk
	4UkxbCXw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38466)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s1QL7-0003AY-2P;
	Mon, 29 Apr 2024 13:42:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s1QL6-0000rC-48; Mon, 29 Apr 2024 13:42:36 +0100
Date: Mon, 29 Apr 2024 13:42:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Boy Wu =?utf-8?B?KOWQs+WLg+iqvCk=?= <Boy.Wu@mediatek.com>
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"andreyknvl@gmail.com" <andreyknvl@gmail.com>,
	"dvyukov@google.com" <dvyukov@google.com>,
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
	Iverlin Wang =?utf-8?B?KOeOi+iLs+mclik=?= <Iverlin.Wang@mediatek.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	Light Chen =?utf-8?B?KOmZs+aYseWFiSk=?= <Light.Chen@mediatek.com>,
	"ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"glider@google.com" <glider@google.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] arm: kasan: clear stale stack poison
Message-ID: <Zi+Vu29rmNZ0MIFG@shell.armlinux.org.uk>
References: <20240410073044.23294-1-boy.wu@mediatek.com>
 <CACRpkdZ5iK+LnQ0GJjZpxROCDT9GKVbe9m8hDSSh2eMXp3do0Q@mail.gmail.com>
 <Zi5hDV6e0oMTyFfr@shell.armlinux.org.uk>
 <292f9fe4bab26028aa80f63bf160e0f2b874a17c.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <292f9fe4bab26028aa80f63bf160e0f2b874a17c.camel@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 29, 2024 at 07:51:49AM +0000, Boy Wu (吳勃誼) wrote:
> On Sun, 2024-04-28 at 15:45 +0100, Russell King (Oracle) wrote:
> >  On Fri, Apr 12, 2024 at 10:37:06AM +0200, Linus Walleij wrote:
> > > On Wed, Apr 10, 2024 at 9:31 AM boy.wu <boy.wu@mediatek.com> wrote:
> > > 
> > > > From: Boy Wu <boy.wu@mediatek.com>
> > > >
> > > > We found below OOB crash:
> > > 
> > > Thanks for digging in!
> > > 
> > > Pleas put this patch into Russell's patch tracker so he can apply
> > it:
> > > https://www.armlinux.org.uk/developer/patches/
> > 
> > Is this a bug fix? If so, having a Fixes: tag would be nice...
> > 
> 
> This is a patch for cpuidle flow when KASAN enable, that is in ARM64
> but not in ARM, so add to ARM.
> 
> The reference commits did not mention fix any commits.
> [1] commit 0d97e6d8024c ("arm64: kasan: clear stale stack poison")
> [2] commit d56a9ef84bd0 ("kasan, arm64: unpoison stack only with
> CONFIG_KASAN_STACK")

These are not suitable for use as a Fixes: tag because these commits
refer to code in another part of the tree that has nothing to do with
the BUG() dump that is contained within your commit message.

I ask again... Is this a bug fix?

Is it a regression?

Is it something that used to work that no longer works?

When did it break?

Has it always been broken?

Has it been broken since KASAN was introduced on 32-bit ARM?

I'm not applying this commit until I get *proper* answers to these
questions so that I can work out whether this needs to go in -rc
or whether it waits until the next merge window... and whether it
needs a Fixes: tag or not.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


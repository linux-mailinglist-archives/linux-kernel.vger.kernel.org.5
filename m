Return-Path: <linux-kernel+bounces-161457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067FB8B4C35
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8CF1C20891
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14D5405FC;
	Sun, 28 Apr 2024 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="abUND1j1"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A31E89A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714315550; cv=none; b=rTjqlQ7HH+bhzu+K6z6xg1IN3m4wqEub9SlHg+CQvDGeHg1Z1Lp+4M39b7hxkph+ifJzBCHnOHrY12azfStJViUqa3HWkFoTzewxv6zvOkRXXM2RFPhLEZ14J0jq9CMUnjYFoGVoDULF5hpEwTHieknJ7Ld7w7fH7NwhVnHOeNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714315550; c=relaxed/simple;
	bh=qrzuZJaiECPnplO6VAazHvYwFvEL7EYtvY9Fss9RMAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJbLMAoiDi1k+sq11vYlWGIuIH0Hq2r+OMPZOP+/jBAuzvW5En9qR+YRWAzE676O8o5mb4U9nnEJCVJW96fUVDrL3NvEZtfPT0qFX/g/NJ0F67/8XgiJamOI+KApXjZBYufN+WNPqSwiuEl5Tu1sB77I5FJSr5/7OQdHyhRv8ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=abUND1j1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9yWj9gnBpdQvY/FOoP2JiH4HKhrBwyUXjDq6sLrBxgw=; b=abUND1j1XB+cN7hv/0oa1HimyE
	tZ1UTp+F8tyWSADJtwPjRkIk+bY7PnpWh8xlvV56UPMLYdViQtiu6hj0xnWudE2tyquZNYXr5rk+3
	oge4P/2lcRclN+GxGB437c5nyOMZuxZDU4ljl//wdd9o0XKcHXhMLOBSA6ETiInfZB01iqWuTRUmJ
	gcOuOoh06k8eoa/4USr74QdLGRmfJTE/Y46a6kna27a6tm8jur9EHuaGYZH3dmis7Y+s5N0T2nGof
	bDURnQs/800x0oTUmudJVYAe6UkCq2ubvMPYSQshfRS5cD7BpAlB9DHM5sNs06rag5qxHZbpsYcXA
	r+BkWoZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41668)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s15mY-0002Eu-30;
	Sun, 28 Apr 2024 15:45:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s15mX-0008Qb-89; Sun, 28 Apr 2024 15:45:33 +0100
Date: Sun, 28 Apr 2024 15:45:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "boy.wu" <boy.wu@mediatek.com>, Mark Rutland <mark.rutland@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Iverlin Wang <iverlin.wang@mediatek.com>,
	Light Chen <light.chen@mediatek.com>
Subject: Re: [PATCH v2] arm: kasan: clear stale stack poison
Message-ID: <Zi5hDV6e0oMTyFfr@shell.armlinux.org.uk>
References: <20240410073044.23294-1-boy.wu@mediatek.com>
 <CACRpkdZ5iK+LnQ0GJjZpxROCDT9GKVbe9m8hDSSh2eMXp3do0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZ5iK+LnQ0GJjZpxROCDT9GKVbe9m8hDSSh2eMXp3do0Q@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 12, 2024 at 10:37:06AM +0200, Linus Walleij wrote:
> On Wed, Apr 10, 2024 at 9:31 AM boy.wu <boy.wu@mediatek.com> wrote:
> 
> > From: Boy Wu <boy.wu@mediatek.com>
> >
> > We found below OOB crash:
> 
> Thanks for digging in!
> 
> Pleas put this patch into Russell's patch tracker so he can apply it:
> https://www.armlinux.org.uk/developer/patches/

Is this a bug fix? If so, having a Fixes: tag would be nice...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


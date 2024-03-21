Return-Path: <linux-kernel+bounces-109959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ECF88583F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 237D3B21BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1615822B;
	Thu, 21 Mar 2024 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="W99tkOqB"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A4B58228;
	Thu, 21 Mar 2024 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020278; cv=none; b=DqdoqsmPZX8AEG55T29y3qqsU/yNyr6TNBUjOKDLbp/S87LGp7OQI3DytqW/3Z7zgOG1/IymVdS2eMzpiErvOXFZT2Njxfkh5yONZzVLehPx2mnZ5ny7NbOMjUm8iLkBURpD6neluPfpjiw3Z4CKre+4Ixh4Uts1f2SN5X6tAA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020278; c=relaxed/simple;
	bh=2xmJIUpAnX0WoR/2adOWV/CSntMFENrOlMHHKXNqdjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fED/qPVSN663kh3X01UD4mHGXbN1+s2GuOFYFw1oC09Azgh2t34Ri9IHvKZL0N2is1gi5CY+HsUCkU98AJnVKAbMaP4da3oTul/Qm3sfWMI79DDR7gCHmp0SYCkzNSwr0U/dLrvzneUmg3cLX+6EXuZ2Zzcr1H6LK8qOiAOySLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=W99tkOqB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/68CR4f0azvzcAmAfC291AOl4wS99r8FrcRejyLq6xM=; b=W99tkOqBejY893YpC1mtzh9mSp
	gSa43/zdRcQpaebucrIyVrHxRsSIDRvVgZnItXAPDixGHUB5u4//H27eDTOTj5newSQixHC6+jynm
	r5qETHV1Ogr4iSiXWxS3zADgqkER/fq/MSBqvSy/GOvGWWlzeV+SY1pG5MjPt9mOY5lligJmN3UIf
	yDp2jMybyFbaLB866k7EJlMFVUhcd0byz9JSyy+ds6mo4HUA1IBkeXoaAVNobNqzOepGc56fHbhct
	zKUDDEkpK0iAbRYRuCslUcOC/6KBZycr2Okkdz1t+aI3TOKfG5SePHOuDK5s5Tw7nf21CYpdbDkyk
	AQVn5l7g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46498)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rnGWd-0007UH-2y;
	Thu, 21 Mar 2024 11:24:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rnGWW-0003bL-0S; Thu, 21 Mar 2024 11:23:52 +0000
Date: Thu, 21 Mar 2024 11:23:51 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: David Laight <David.Laight@aculab.com>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: 'Jiangfeng Xiao' <xiaojiangfeng@huawei.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"haibo.li@mediatek.com" <haibo.li@mediatek.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"amergnat@baylibre.com" <amergnat@baylibre.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"douzhaolei@huawei.com" <douzhaolei@huawei.com>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"kepler.chenxin@huawei.com" <kepler.chenxin@huawei.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"nixiaoming@huawei.com" <nixiaoming@huawei.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"wangbing6@huawei.com" <wangbing6@huawei.com>,
	"wangfangpeng1@huawei.com" <wangfangpeng1@huawei.com>,
	"jannh@google.com" <jannh@google.com>,
	"willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v2] ARM: unwind: improve unwinders for noreturn case
Message-ID: <ZfwYx/8k8FVONg6+@shell.armlinux.org.uk>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
 <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
 <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk>
 <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
 <bbcca1e205384cf0b42236e17f3969f7@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbcca1e205384cf0b42236e17f3969f7@AcuMS.aculab.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 21, 2024 at 10:22:30AM +0000, David Laight wrote:
> How aggressively does the compiler optimise 'noreturn' functions?

I've seen cases where the compiler emits a BL instruction as the very
last thing in the function, and nothing after it.

This is where the problem lies - because the link register value
created by the BL instruction will point to the instruction after the
BL which will _not_ part of the function that invoked the BL. That
will probably cause issues for the ELF unwinder, which means this
issue probably goes beyond _just_ printing the function name.

I have vague memories that Ard has been involved in the unwinder,
maybe he could comment on this problem? Maybe we need the unwinder
itself to do the correction? I also wonder whether we should only
do the correction if we detect that we're pointing at the first
instruction of a function, and the previous instruction in the
text segment was a BL.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


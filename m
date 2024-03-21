Return-Path: <linux-kernel+bounces-110183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1E9885B38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F361284ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB70F85945;
	Thu, 21 Mar 2024 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="R9Q7yXVV"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EC058232;
	Thu, 21 Mar 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033011; cv=none; b=TfAkEV1j6ibjsFDXzBGPlb5iKxHRs3quc6BHK/P5guMTbFjA4vjGrxXzHTEPzZqNEp5Yj1lQGOWZGxi6YvqciqSQ32AA8R+v84XcMmUoHqHptou02YTXWd7o0Lxz1KPoqCrN5yo0reoBGiU1YFFvFy/hD8p9+iu67Lfr+2iadY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033011; c=relaxed/simple;
	bh=IYptOw1JdLSVTAap2b6UQcuFR8coEdbT6avF0DWiV0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYlyzsmyh2xShHL9kYccrwpkHGXuI4QH7RxQRnXPJfOBMePCspgB52jRkM0wDDstg342eWLh/APJCJOqMJ/0+8rBFDls0YgALroHyBQWfMl/uLODfgJgpx2ovC5YNwdQU/UB/SbQewHUGgU+jX+OKgN5JYuq9v493WhfhdnY8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=R9Q7yXVV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OLw2lU9lpBwjLUSQ/UpfVBslsUspZQKPHPTl4U7tJ60=; b=R9Q7yXVVqgdbeoUTqOfF1D1JUY
	aVv2jE88tkz8pMKojqD8CZqYgL9NubNF9nWhDccFAIkkV+5AJgfAM1EALCONOzStkFp1CSsMZQbpS
	IG5l3HeC2csOb9vAD64Ahpjih6SmyKwg3HLHGr6WiStHqNxDoTqA90taj0TBS9XOBjeQiewIjwZfM
	3lbNvC82x5qmvxcdFY1EGZ+zdq/ldoh0GIKmTyB2QMViG3lk1lSkqMaBnqW54Lc2t6vFGMImVmiuN
	+4j6EcjYrvSqHnpkc8ESZ8VCbxohMyaNsOvoXPkEMtyxab20/i4TuP8zdyPkNTVb8vQSweRG8kAjT
	XWDfLbRA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35816)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rnJq4-0007fb-2f;
	Thu, 21 Mar 2024 14:56:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rnJpx-0003jQ-8t; Thu, 21 Mar 2024 14:56:09 +0000
Date: Thu, 21 Mar 2024 14:56:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: David Laight <David.Laight@aculab.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	'Jiangfeng Xiao' <xiaojiangfeng@huawei.com>,
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
Message-ID: <ZfxKiQuNM/zruxSd@shell.armlinux.org.uk>
References: <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
 <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk>
 <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
 <bbcca1e205384cf0b42236e17f3969f7@AcuMS.aculab.com>
 <ZfwYx/8k8FVONg6+@shell.armlinux.org.uk>
 <db930076c837456f999daee5cb76735f@AcuMS.aculab.com>
 <ZfwmomjUwQdCefzh@shell.armlinux.org.uk>
 <0fd55e156195440bb1d815dd8300894b@AcuMS.aculab.com>
 <ZfwxMuPflqlVyCDd@shell.armlinux.org.uk>
 <9d6057b110034c04b6b590522c8c69cc@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d6057b110034c04b6b590522c8c69cc@AcuMS.aculab.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 21, 2024 at 02:37:28PM +0000, David Laight wrote:
> From: Russell King
> > Sent: 21 March 2024 13:08
> > 
> > On Thu, Mar 21, 2024 at 12:57:07PM +0000, David Laight wrote:
> > > From: Russell King
> > > > Sent: 21 March 2024 12:23
> > > ...
> > > > > That might mean you can get the BL in the middle of a function
> > > > > but where the following instruction is for the 'no stack frame'
> > > > > side of the branch.
> > > > > That is very likely to break any stack offset calculations.
> > > >
> > > > No it can't. At any one point in the function, the stack has to be in
> > > > a well defined state, so that access to local variables can work, and
> > > > also the stack can be correctly unwound. If there exists a point in
> > > > the function body which can be reached where the stack could be in two
> > > > different states, then the stack can't be restored to the parent
> > > > context.
> > >
> > > Actually you can get there with a function that has a lot of args.
> > > So you can have:
> > > 	if (...) {
> > > 		push x
> > > 		bl func
> > > 		add %sp, #8
> > > 	}
> > > 	code;
> > > which is fine.
> > 
> > No you can't.... and that isn't even Arm code. Arm doesn't use %sp.
> > Moreover, that "bl" will stomp over the link register, meaning this
> > function can not return.
> 
> With 9+ arguments they spill to see https://godbolt.org/z/Yj3ovd8bY
> 
> Where the compiler generates:
> f9:
>         cmp     w0, 0
>         ble     .L2
>         sub     sp, sp, #32
>         mov     w7, w0
>         mov     w6, w0
>         mov     w5, w0
>         mov     w4, w0
>         mov     w3, w0
>         stp     x29, x30, [sp, 16]
>         add     x29, sp, 16
>         mov     w2, w0
>         mov     w1, w0
>         str     w0, [sp]
>         bl      f
> .L2:
>         ret

Don't show me Arm64 assembly when we're discussing Arm32.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


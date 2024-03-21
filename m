Return-Path: <linux-kernel+bounces-110254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA8C885C25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1E81C2097D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB5786659;
	Thu, 21 Mar 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AbMqESPh"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9F86637;
	Thu, 21 Mar 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035255; cv=none; b=hEo2X3U2WioF42DfSu225zSo8DIveUctMrZWVtKDHOkZ45HIbnb+5bc0ivkmkgKAsy4fS5LEVZI32ULOGUCellO5LaiehGwVCt3w1KSrPv5bBC9g7CJKSahbyP7PZAk2FTorYeZ8jMSP0rVHMqhLxGLde7+CKxEnVglypjzMUgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035255; c=relaxed/simple;
	bh=OWuvRH9fuu5zd9LuMHig+jsEvrq1+LfyVPway8EBt5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=senoUH3+PgI2i+Q4tTPOdVgkeZ8l7pGGzvIJmFOZkehuhdLsBxYcg869VPkushzMBwfvKSfnOMaLCHxoie0XrTiuIapmS3f3lMmdrDynFpzSn8ZpfFFkU/GWlvZVONquajHN3YjafKxAqYPNkQuRvuR1UQTUbKjzm/7ySY8adx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AbMqESPh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r1uLotYzh1w/n8/XorCAtCsehwC+SrTBTj1aIYvDkuM=; b=AbMqESPhaZA5tNhCyI7jjEkxpE
	FeIj9N+ro0VrWw1AqrnnUp5d9kp9B9DlByKZtXjubJVvXfJObRAjbh7/d8Y/n4luVRGXPDKpYSggg
	0b1HJWKgB2XYEH5w8KYZ4QJPu02bTWJrgmlZEHLM/nda8XX4j9+yWDds5NCLErOdgKJU8uQHQ2/fI
	wqW4slom2JbhPRaiWscJF91dDj/KRrIIau9qlhpZi88wd49v8NpDzk1gfaHn4Qgwo5vGvFYOnyiQ+
	IMja0Psx9uGTa1C0o73vihKq2WXq1nMjrNMW6ujAvTPmzgYyI9RXjSCE590drglebMzVHu33WNCqM
	u75Ro8WA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57550)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rnKQP-0007jl-0f;
	Thu, 21 Mar 2024 15:33:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rnKQJ-0003kc-MI; Thu, 21 Mar 2024 15:33:43 +0000
Date: Thu, 21 Mar 2024 15:33:43 +0000
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
Message-ID: <ZfxTV+u4UWoRdGpJ@shell.armlinux.org.uk>
References: <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
 <bbcca1e205384cf0b42236e17f3969f7@AcuMS.aculab.com>
 <ZfwYx/8k8FVONg6+@shell.armlinux.org.uk>
 <db930076c837456f999daee5cb76735f@AcuMS.aculab.com>
 <ZfwmomjUwQdCefzh@shell.armlinux.org.uk>
 <0fd55e156195440bb1d815dd8300894b@AcuMS.aculab.com>
 <ZfwxMuPflqlVyCDd@shell.armlinux.org.uk>
 <9d6057b110034c04b6b590522c8c69cc@AcuMS.aculab.com>
 <ZfxKiQuNM/zruxSd@shell.armlinux.org.uk>
 <401453a216644af98d577f51c12d292b@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401453a216644af98d577f51c12d292b@AcuMS.aculab.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 21, 2024 at 03:20:57PM +0000, David Laight wrote:
> From: Russell King
> > Sent: 21 March 2024 14:56
> > 
> > On Thu, Mar 21, 2024 at 02:37:28PM +0000, David Laight wrote:
> > > From: Russell King
> > > > Sent: 21 March 2024 13:08
> > > >
> > > > On Thu, Mar 21, 2024 at 12:57:07PM +0000, David Laight wrote:
> > > > > From: Russell King
> > > > > > Sent: 21 March 2024 12:23
> > > > > ...
> > > > > > > That might mean you can get the BL in the middle of a function
> > > > > > > but where the following instruction is for the 'no stack frame'
> > > > > > > side of the branch.
> > > > > > > That is very likely to break any stack offset calculations.
> > > > > >
> > > > > > No it can't. At any one point in the function, the stack has to be in
> > > > > > a well defined state, so that access to local variables can work, and
> > > > > > also the stack can be correctly unwound. If there exists a point in
> > > > > > the function body which can be reached where the stack could be in two
> > > > > > different states, then the stack can't be restored to the parent
> > > > > > context.
> > > > >
> > > > > Actually you can get there with a function that has a lot of args.
> > > > > So you can have:
> > > > > 	if (...) {
> > > > > 		push x
> > > > > 		bl func
> > > > > 		add %sp, #8
> > > > > 	}
> > > > > 	code;
> > > > > which is fine.
> > > >
> > > > No you can't.... and that isn't even Arm code. Arm doesn't use %sp.
> > > > Moreover, that "bl" will stomp over the link register, meaning this
> > > > function can not return.
> > >
> ...
> > 
> > Don't show me Arm64 assembly when we're discussing Arm32.
> 
> Oops - I'd assumed no one did 32bit :-)
> In any case it is much the same, see https://godbolt.org/z/7dcbKrs76
> 
> f4:
>         push    {r3, lr}
>         subs    r3, r0, #0
>         ble     .L2
>         mov     r2, r3
>         mov     r1, r3
>         bl      f
> .L2:
>         pop     {r3, pc}
> 
> f5:
>         subs    r3, r0, #0
>         ble     .L6
>         push    {lr}
>         sub     sp, sp, #12
>         mov     r2, r3
>         mov     r1, r3
>         str     r3, [sp]
>         bl      f
> .L6:
>         bx      lr
> 
> That is with -mno-sched-prolog but with 5+ args they spill to stack
> and the %sp change is pulled into the conditional.
> 
> It does look like %lr is being saved (and for arm64 I think).

I see nothing that contradicts anything I've said in your example
output.

You have been previously refering to a "bl" in the prologue, which is
what I thought you were going to give an example of. There is no "bl"
in the prologue of f5, the "ble" instruction is a normal branch for
less-than-or-equal. It's b + le not bl + e.

At .L6, there will be a difference in stack, but as f() is declared
as no-return, anything that comes after it is utterly irrelevant as
control is not expected to reach any following instruction via that
path. If it _were_ to, then in the example you give above, because
"lr" points at the bx lr instruction, the result would be to endlessly
spin executing bx lr instructions.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


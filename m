Return-Path: <linux-kernel+bounces-109360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77BE88180B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F123B22BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4173085923;
	Wed, 20 Mar 2024 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vyT9UD0c"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A5B85298;
	Wed, 20 Mar 2024 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963675; cv=none; b=N5IfFR/K3PNSU1V94FwQWIxW6/LhP+7rF2SN+76VGT4ChRLCsVrC56sgMOFFH0rlS30jOndldeHd2wniUriY7JBKwAIh1am5ojdqIZkYOkHgmxP3YSk/qyKBFy4MVsYwZ6QLFyRrffiWjzwHVpyEwMVDT0zpF0gHHVTU4V8OGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963675; c=relaxed/simple;
	bh=A1iKKmqPanQSOQ2ysa38bmdsyVP54PUD/8At8LRfb+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMec1Y45Pey17cSuPM8O0EzEfUPNJnJRVj1TfAJ9vj8S6p6Yb0ExMyqZWVnP+c4YvZaQ8K/HVHJz9gtCH5HTJPYCkvd75/Oqzq1igyX4gRvuQN9Uf91BLpbI4HSEtd1L1219O42RZYeX8CmWZwJbPjS24kxUYWJJIzzRFvb/uvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vyT9UD0c; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=93N1WsDx3xkI8PIGtHQm769e5Sqg9ilfdoc7k8pVcyA=; b=vyT9UD0c5ZE5B6shX8UwlIjuz7
	D0ofXNzQqHqN/ia+R7/ZzzvKCoQGHMeANDGS0ABCfCUl/jDpCAkdJwLyjNqL5CrT0mpDOxN1sBYcS
	rXzXMopWHCVJNYwFaDgj8BHMyoVmGoT03lqSmKy5zaHJ82G5hD5+EYk9NEUMNIRc6w1eSHMx9NZWv
	IUaFzDfVPpEKGUzSzCHW7VDZbL0zCxVK6G7xexbv9yVcGoQkc9J60Muzrl6EC0g3acfRDsyzewrW+
	nrLbmbwutPROf+5XjrFWiAF2aTsm64+jHY1rmyZ6+WaOm4jy8YZdnfa8H5OG7WCMpGFENvKpDDkST
	EaEo6ALw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35180)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rn1nm-0006pk-10;
	Wed, 20 Mar 2024 19:40:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rn1nd-0002vx-Rw; Wed, 20 Mar 2024 19:40:33 +0000
Date: Wed, 20 Mar 2024 19:40:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Cc: arnd@arndb.de, keescook@chromium.org, haibo.li@mediatek.com,
	angelogioacchino.delregno@collabora.com, amergnat@baylibre.com,
	akpm@linux-foundation.org, dave.hansen@linux.intel.com,
	douzhaolei@huawei.com, gustavoars@kernel.org, jpoimboe@kernel.org,
	kepler.chenxin@huawei.com, kirill.shutemov@linux.intel.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	nixiaoming@huawei.com, peterz@infradead.org, wangbing6@huawei.com,
	wangfangpeng1@huawei.com, jannh@google.com, willy@infradead.org,
	David.Laight@aculab.com
Subject: Re: [PATCH v2] ARM: unwind: improve unwinders for noreturn case
Message-ID: <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
 <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 20, 2024 at 11:30:05PM +0800, Jiangfeng Xiao wrote:
> 
> 
> On 2024/3/20 16:45, Russell King (Oracle) wrote:
> > On Wed, Mar 20, 2024 at 11:44:38AM +0800, Jiangfeng Xiao wrote:
> >> This is an off-by-one bug which is common in unwinders,
> >> due to the fact that the address on the stack points
> >> to the return address rather than the call address.
> >>
> >> So, for example, when the last instruction of a function
> >> is a function call (e.g., to a noreturn function), it can
> >> cause the unwinder to incorrectly try to unwind from
> >> the function after the callee.
> >>
> >> foo:
> >> ...
> >> 	bl	bar
> >> ... end of function and thus next function ...
> >>
> >> which results in LR pointing into the next function.
> >>
> >> Fixed this by subtracting 1 from frmae->pc in the call frame
> >> (but not exception frames) like ORC on x86 does.
> > 
> > The reason that I'm not accepting this patch is because the above says
> > that it fixes it by subtracting 1 from the PC value, but the patch is
> > *way* more complicated than that and there's no explanation why.
> > 
> > For example, the following are unexplained:
> > 
> > - Why do we always need ex_frame
> 
> ```
> bar:
> ...
> ... end of function bar ...
> 
> foo:
>     BUG();
> ... end of function foo ...
> ```
> 
> For example, when the first instruction of function 'foo'
> is a undefined instruction, after function 'foo' is executed
> to trigger an exception, 'arm_get_current_stackframe' assigns
> 'regs->ARM_pc' to 'frame.pc'.
> 
> If we always decrement frame.pc by 1, unwinder will incorrectly
> try to unwind from the function 'bar' before the function 'foo'.
> 
> So we need to 'ext_frame' to distinguish this case
> where we don't need to subtract 1.

This just sounds wrong to me. We have two different cases:

1) we're unwinding a frame where PC points at the offending instruction.
   This may or may not be in the exception text.
2) we're unwinding a frame that has been created because of a branch,
   where the PC points at the next instruction _after_ that callsite.

While we're unwinding, we will mostly hit the second type of frames, but
we'll only hit the first type on the initial frame. Some exception
entries will have the PC pointing at the next instruction to be
executed, others will have it pointing at the offending instruction
(e.g. if it needs to be retried.)

So, I don't see what being in the exception/entry text really has much
to do with any decision making here. I think you've found that it works
for your case, but it won't _always_ work and you're just shifting the
"bug" with how these traces work from one issue to a different but
similar issue.

> > - What is the purpose of the change in format string for the display of
> >   backtraces
> ```
> unwind_frame(&frame);
> dump_backtrace_entry(...from) //from = frame.pc
> 	printk("...%pS\n", ...(void *)from);
> ```
> %pB will do sprint_backtrace and print the symbol at (from - 1) address
> %pS will do sprint_symbol_build_id and print the symbol at (from) address

The quote in printk-formats.rst states:

        %pS     versatile_init+0x0/0x110
	%pB     prev_fn_of_versatile_init+0x88/0x88

This is rather ambiguous on its own, since the definition of "previous
function" is ambiguous. Given the offset and size stated there, it's
also not obvious what pointer was passed. It would be nice if these
examples actually said what the pointer passed in actually was.

I had been interpreting "prev_fn_of_" to mean the caller of
versatile_init() but it could also be the preceeding function in the
kernel text to versatile_init() - that is where the ambiguity comes
from.

So, the question I now have is... if %pB prints the symbol corresponding
with "from - 1", then

- with the frame pointer walker, from will always be the return address
  found on the stack for the function we are currently in.
- with the unwinder it will be whatever the unwinder computes as the LR
  register unless the unwind instructions place a non-zero value in PC.

Is there a case where the unwinder gets this wrong?

I think what would help is if you split this patch up, and addressed
each part separately, describing the issue that each part is addressing
giving an example that clearly explains what the patch is doing.
However, please note my comments above that using the fact that we're
in an exception frame doesn't actually tell you anything about whether
you need to correct the PC value or not.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


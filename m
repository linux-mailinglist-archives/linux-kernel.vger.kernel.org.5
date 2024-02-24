Return-Path: <linux-kernel+bounces-79502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E551862355
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 08:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF81B1C21D28
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 07:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CC713FEA;
	Sat, 24 Feb 2024 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="fvtd4q7a";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="YdSuk4Qh"
Received: from mailrelay2-1.pub.mailoutpod3-cph3.one.com (mailrelay2-1.pub.mailoutpod3-cph3.one.com [46.30.211.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A695168A9
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708760189; cv=none; b=ESIO344pQqL63vDCYInK74aI6L/eeWBysiO4P2I7pIHzXsstz7Ag16gqgLkAjVOb73GA4b1L0cdrFOxELAN+DlINFVa2STBdpNBRqaLfinFNGR1Ck8zDMnoCyiK3AhZq+1/1b2RvJHuDgSaj7J/jr1fHVo6c/02Mw+Ce4pAsr9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708760189; c=relaxed/simple;
	bh=NBBFFEuDcsu1iPvXO+MDeW9qJLvD+c0z/ZAiy526cCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gABtDcYcJ4cvMmd/KZILPAOL0r8cACXWLpUNGYHIvDl1QoPSYLmT65GQeXlDlGVU/eoHZskWSw7uUmpMBRCvWjfZ34OCejFLB7s5hATqBYuSpNic3G2lkz0U29/ZtlOWfr7l81B9660Cfdp/frWuXYPVVF2k2Wm1gaPS+Xit/ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=fvtd4q7a; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=YdSuk4Qh; arc=none smtp.client-ip=46.30.211.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=8GmhWkSF8iRno9ChV3Han0O9GYjagY89c/HUMSM4bRA=;
	b=fvtd4q7aMKxtlMa0v+LfeBnULgo/aLgQXPrTKU8rvVRUrYswisVUp+T9/W3SBfHgpbgScoNrPQ41d
	 Nf8NkQ7BdQ6afTGkraVn1W1PTO0EylJYf3gSyEU38D4RJJrEdYUH5ez+h114xN9ywdkCl12w7c8JbH
	 s/FMnJXw7CT2tAo7VJRU9EyJi/XXjMm4EA1dFDjRpx+ipS/pL9ao5ya853qP8AYdS2HDKIgRdxr2c5
	 sToo2u4H5A7n//xVGqxEyCISmAbYZSpn3ZSZaPxRy+oaN3myDdujRGAikrfiBlXGKluK3ipzPQ08vm
	 MP5D0qJMcq4GLlwq1JwLNZwB2pkXPgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=8GmhWkSF8iRno9ChV3Han0O9GYjagY89c/HUMSM4bRA=;
	b=YdSuk4QhWqAelZnOC9jnrU87RJ77rjeSszc019nEuhgNE9Sz8ojaC7Lchcgv2ZmTejUDemEwscVxs
	 VblM+zhBg==
X-HalOne-ID: 64aa335a-d2e7-11ee-9f80-657348328a86
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay2.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 64aa335a-d2e7-11ee-9f80-657348328a86;
	Sat, 24 Feb 2024 07:36:18 +0000 (UTC)
Date: Sat, 24 Feb 2024 08:36:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kees Cook <keescook@chromium.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Helge Deller <deller@gmx.de>, Guo Ren <guoren@kernel.org>,
	sparclinux@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sparc: vdso: Disable UBSAN instrumentation
Message-ID: <20240224073617.GA2959352@ravnborg.org>
References: <20240223165942.work.950-kees@kernel.org>
 <20240223182646.GA2825372@ravnborg.org>
 <202402231523.F9E3740EB@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402231523.F9E3740EB@keescook>

Hi Kees,

On Fri, Feb 23, 2024 at 03:32:37PM -0800, Kees Cook wrote:
> On Fri, Feb 23, 2024 at 07:26:46PM +0100, Sam Ravnborg wrote:
> > Hi Kees,
> > 
> > On Fri, Feb 23, 2024 at 08:59:45AM -0800, Kees Cook wrote:
> > > The UBSAN instrumentation cannot work in the vDSO since it is executing
> > > in userspace, so disable it in the Makefile. Fixes the build failures
> > > such as:
> > > 
> > > arch/sparc/vdso/vclock_gettime.c:217: undefined reference to `__ubsan_handle_shift_out_of_bounds'
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: Andreas Larsson <andreas@gaisler.com>
> > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > Cc: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: Helge Deller <deller@gmx.de>
> > > Cc: Guo Ren <guoren@kernel.org>
> > > Cc: sparclinux@vger.kernel.org
> > > ---
> > >  arch/sparc/vdso/Makefile | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> > > index 7f5eedf1f5e0..e8aef2c8ae99 100644
> > > --- a/arch/sparc/vdso/Makefile
> > > +++ b/arch/sparc/vdso/Makefile
> > > @@ -2,6 +2,7 @@
> > >  #
> > >  # Building vDSO images for sparc.
> > >  #
> > > +UBSAN_SANITIZE := n
> > 
> > When I read:
> > 
> > config UBSAN_SANITIZE_ALL
> >         bool "Enable instrumentation for the entire kernel"
> >         depends on ARCH_HAS_UBSAN_SANITIZE_ALL
> >         default y
> >         help
> >           This option activates instrumentation for the entire kernel.
> >           If you don't enable this option, you have to explicitly specify
> >           UBSAN_SANITIZE := y for the files/directories you want to check for UB.
> >           Enabling this option will get kernel image size increased
> >           significantly.
> > 
> > 
> > I am left with the understanding that only arch's that
> > selects ARCH_HAS_UBSAN_SANITIZE_ALL would need to turn off
> > UBSAN_SANITIZE.
> 
> Ah, right. So, I removed[1] UBSAN_SANITIZE_ALL in -next (it was the only
> sanitizer using this logic) and this appears to be one of the impacts. :)
> I sent similar fixes for sh[2] and LoongArch[3].
> 
> > Are this fix papering over some other bug where we enable
> > UBSAN_SANITIZE_ALL for arch's that should not have it,
> > or something else that enable it?
> 
> It's possible we should implement HAVE_ARCH_UBSAN, but in my testing
> everything built fine with it, so I didn't opt to do that (it looked
> like just additional configs for no real benefit). What do you think?

Coffee has not yet kicked in, but...


> [1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/kspp&id=918327e9b7ffb45321cbb4b9b86b58ec555fe6b3

OK, I did not have this patch in my tree so it explain the need for the
patch in this mail. Looking at the linked patch the ARCH_HAS_UBSAN symbol
is selected by some architecture but I see no use of it. Maybe that is a
later patch and then all is good.


In general I am not fan of naked config symbols (no help / comment) like this:
config ARCH_HAS_UBSAN
 	bool

The reader is left only with the symbol name trying to understand the
purpose of a symbol that is selected by some architectures.
But that is a different matter for another day.

As you now put the patch in this mail in context it makes sense and it has my:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam


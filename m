Return-Path: <linux-kernel+bounces-40316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D5F83DE5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8246D1F254D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6D61D559;
	Fri, 26 Jan 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb6NbSgI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D624E1CD1F;
	Fri, 26 Jan 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706285428; cv=none; b=qGtGaK3/RwH1EYdVkfMMfYYwNcbHX1nuc+kcZ7Gw3991jr/pb55M465MM33NCSkT2vc7+G3N6zvswOPgKWn9NjZoDUN9JhDm+AmG62X1goibGQgFIjHuWbLz8ui/DOy8fog4faiH807LN0vONNyBKYBVT7451EX5O4ozN9ssCNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706285428; c=relaxed/simple;
	bh=dCh3Q7IJrxBpqeaYZ3wZ62jWq+kUi+XKjTJ8+Wu15U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgbzEvzAXaZ7sbQw+fGUNdQkocZzwV0rKHi2I1VZK27eb/9KTzRG7SR5IMHD1YwI9oh9G408mJjjB3QzCt49sEcAfE86yYjmmwqdBoY8BAjrvk7i3u50MUgkKc9fp3z6iOcLx7/Xil03MZ0iLDHtVB8NN9PyWbo8Z8dj8itSnJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb6NbSgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD07AC43390;
	Fri, 26 Jan 2024 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706285427;
	bh=dCh3Q7IJrxBpqeaYZ3wZ62jWq+kUi+XKjTJ8+Wu15U4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tb6NbSgIH5Jh9xM0TXplcprBK9xu5xjIlahezLx9JjLaeV3D++84RBlfi1tb0r+B6
	 ktXLrOiruZrF5P4D+icn+bveWbxq5S9iaVGmCWyDqHYgdYlor6C12TOGUJXC2fwIup
	 JiJdoKB8O18h/S6XqG30/QvhL/xLfKuqHzAzq9xoIu9cq4OZnFIl67icBw+brpRL9j
	 EKs4VLlE39mii6pG12TJ1NjeyCv9vje0I64wtexLpUrozbiZ07z+sDcY8DNuFx0e9H
	 RKPT/DXqqc9f2IHsymkR/kWJq1L9uriLoVILEXVBRw162F/Sm86OMkHbhe+ruZwnFq
	 kDB+ARKOuczmg==
Date: Fri, 26 Jan 2024 09:10:25 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: akpm@linux-foundation.org, masahiroy@kernel.org, nicolas@fjasle.eu,
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/11] arm64: Kconfig: Clean up tautological LLVM version
 checks
Message-ID: <20240126161025.GA3265550@dev-arch.thelio-3990X>
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
 <20240125-bump-min-llvm-ver-to-13-0-1-v1-5-f5ff9bda41c5@kernel.org>
 <ZbOsvhDB-6LMVACP@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbOsvhDB-6LMVACP@FVFF77S0Q05N>

On Fri, Jan 26, 2024 at 12:59:55PM +0000, Mark Rutland wrote:
> On Thu, Jan 25, 2024 at 03:55:11PM -0700, Nathan Chancellor wrote:
> > Now that the minimum supported version of LLVM for building the kernel
> > has been bumped to 13.0.1, several conditions become tautologies, as
> > they will always be true because the build will fail during the
> > configuration stage for older LLVM versions. Drop them, as they are
> > unnecessary.
> > 
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> > Cc: catalin.marinas@arm.com
> > Cc: will@kernel.org
> > Cc: mark.rutland@arm.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > ---
> >  arch/arm64/Kconfig | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 5a8acca4dbf4..cb34e7d780c0 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -383,7 +383,7 @@ config BUILTIN_RETURN_ADDRESS_STRIPS_PAC
> >  	bool
> >  	# Clang's __builtin_return_adddress() strips the PAC since 12.0.0
> >  	# https://github.com/llvm/llvm-project/commit/2a96f47c5ffca84cd774ad402cacd137f4bf45e2
> > -	default y if CC_IS_CLANG && (CLANG_VERSION >= 120000)
> > +	default y if CC_IS_CLANG
> >  	# GCC's __builtin_return_address() strips the PAC since 11.1.0,
> >  	# and this was backported to 10.2.0, 9.4.0, 8.5.0, but not earlier
> >  	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94891
> > @@ -1387,7 +1387,6 @@ choice
> >  
> >  config CPU_BIG_ENDIAN
> >  	bool "Build big-endian kernel"
> > -	depends on !LD_IS_LLD || LLD_VERSION >= 130000
> >  	# https://github.com/llvm/llvm-project/commit/1379b150991f70a5782e9a143c2ba5308da1161c
> 
> We can delete the URL here, since that was just to describe why this depended
> upon LLVM 13+; it's weird for it to sit here on its own.

I think this is the URL for the fix for the problem brought up by
commit 146a15b87335 ("arm64: Restrict CPU_BIG_ENDIAN to GNU as or LLVM
IAS 15.x or newer"), so I think it should stay? It does not look like I
ever added a link or context for the LLD line, I definitely should have.

> The URL above for __builtin_return_address() can stay or go; it may as well
> stay since we have the comment aboout LLvm 12+ above it.

That's the conclusion I came to as well.

Thanks a lot for taking a look!

Cheers,
Nathan

> With that:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.
> 
> >  	depends on AS_IS_GNU || AS_VERSION >= 150000
> >  	help
> > @@ -2018,8 +2017,6 @@ config ARM64_BTI_KERNEL
> >  	depends on !CC_IS_GCC || GCC_VERSION >= 100100
> >  	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106671
> >  	depends on !CC_IS_GCC
> > -	# https://github.com/llvm/llvm-project/commit/a88c722e687e6780dcd6a58718350dc76fcc4cc9
> > -	depends on !CC_IS_CLANG || CLANG_VERSION >= 120000
> >  	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_ARGS)
> >  	help
> >  	  Build the kernel with Branch Target Identification annotations
> > 
> > -- 
> > 2.43.0
> > 
> 


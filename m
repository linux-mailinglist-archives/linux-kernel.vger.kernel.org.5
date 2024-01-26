Return-Path: <linux-kernel+bounces-40114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A36A83DA74
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFD71C2564C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BFD1B80F;
	Fri, 26 Jan 2024 13:00:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD811B806;
	Fri, 26 Jan 2024 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706274018; cv=none; b=IRb9gbglJAzumlyvuf7DdyxW/+xFCyKUq2haWZ3Lpq85eDd8X2M4VGGMs0UHvfRKXVjJBvDIwrFQDcgUqaSG+3kNUJdr8HRye5NZC2PRTmR63zOM9KRHKV1z/jRjCM0SBeFSj7bWAapxPQSiNPtnKUydAbNVG1rgaD+Z49/7hF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706274018; c=relaxed/simple;
	bh=qP1uFdpRw1c5ef5F7S+gJtgy5/emH1e2Mw5YV7Iv6wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhwQKWBojMhGzmYOiPPDHxWsk9Wn5RbelhUgqzZk4QsZXT+RlTZHVfwhqndEmvx0nax8oGTleZ27hO6cs9LXv1WtijgUWum+0lExqWVfDwzvZt3ryXZGa7xB2iGc4Sp7BTlBci1vmHDBHxM2Y5bdm2QH3xZvcS83w98VjWjaKAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E86F01FB;
	Fri, 26 Jan 2024 05:00:59 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.47.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D79BF3F73F;
	Fri, 26 Jan 2024 05:00:13 -0800 (PST)
Date: Fri, 26 Jan 2024 12:59:55 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: akpm@linux-foundation.org, masahiroy@kernel.org, nicolas@fjasle.eu,
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/11] arm64: Kconfig: Clean up tautological LLVM version
 checks
Message-ID: <ZbOsvhDB-6LMVACP@FVFF77S0Q05N>
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
 <20240125-bump-min-llvm-ver-to-13-0-1-v1-5-f5ff9bda41c5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125-bump-min-llvm-ver-to-13-0-1-v1-5-f5ff9bda41c5@kernel.org>

On Thu, Jan 25, 2024 at 03:55:11PM -0700, Nathan Chancellor wrote:
> Now that the minimum supported version of LLVM for building the kernel
> has been bumped to 13.0.1, several conditions become tautologies, as
> they will always be true because the build will fail during the
> configuration stage for older LLVM versions. Drop them, as they are
> unnecessary.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Cc: catalin.marinas@arm.com
> Cc: will@kernel.org
> Cc: mark.rutland@arm.com
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/Kconfig | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5a8acca4dbf4..cb34e7d780c0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -383,7 +383,7 @@ config BUILTIN_RETURN_ADDRESS_STRIPS_PAC
>  	bool
>  	# Clang's __builtin_return_adddress() strips the PAC since 12.0.0
>  	# https://github.com/llvm/llvm-project/commit/2a96f47c5ffca84cd774ad402cacd137f4bf45e2
> -	default y if CC_IS_CLANG && (CLANG_VERSION >= 120000)
> +	default y if CC_IS_CLANG
>  	# GCC's __builtin_return_address() strips the PAC since 11.1.0,
>  	# and this was backported to 10.2.0, 9.4.0, 8.5.0, but not earlier
>  	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94891
> @@ -1387,7 +1387,6 @@ choice
>  
>  config CPU_BIG_ENDIAN
>  	bool "Build big-endian kernel"
> -	depends on !LD_IS_LLD || LLD_VERSION >= 130000
>  	# https://github.com/llvm/llvm-project/commit/1379b150991f70a5782e9a143c2ba5308da1161c

We can delete the URL here, since that was just to describe why this depended
upon LLVM 13+; it's weird for it to sit here on its own.

The URL above for __builtin_return_address() can stay or go; it may as well
stay since we have the comment aboout LLvm 12+ above it.

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  	depends on AS_IS_GNU || AS_VERSION >= 150000
>  	help
> @@ -2018,8 +2017,6 @@ config ARM64_BTI_KERNEL
>  	depends on !CC_IS_GCC || GCC_VERSION >= 100100
>  	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106671
>  	depends on !CC_IS_GCC
> -	# https://github.com/llvm/llvm-project/commit/a88c722e687e6780dcd6a58718350dc76fcc4cc9
> -	depends on !CC_IS_CLANG || CLANG_VERSION >= 120000
>  	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_ARGS)
>  	help
>  	  Build the kernel with Branch Target Identification annotations
> 
> -- 
> 2.43.0
> 


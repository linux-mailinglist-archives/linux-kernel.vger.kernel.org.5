Return-Path: <linux-kernel+bounces-94292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A124E873C95
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28571C2135A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4015137914;
	Wed,  6 Mar 2024 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugMPWBlv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9DED534;
	Wed,  6 Mar 2024 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743793; cv=none; b=Sq5LokE84CjZLNIX1z32HfCgZSGxZZEEwJ0xEj5MPUYPim+hTIzvoi+RJWiN+1+8bGEWfiqbNHUJoHsAOgH22srOyd5XdUvRsfL7DLXbMRUAu7pSjU2uqJuSJ0OWTuOtYxgYWIr5BmnNDceyfRWt79PXs1KjsBr64f6TzMpABvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743793; c=relaxed/simple;
	bh=a5cu4VstVW27LKHaRhJuDngoVkzcZqWPu4EMGvK+E3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2+LlTsLPSjsS5F8mHxlqWO9D9dBJkQ5143YmLZ19sbLPFud92nmyJz7QQqHnU12M/txtiUn4tHpMK0GyjLTXtG1g9L1hJD/x33JYbSkt0QlZrmZTqK8OzEBG+HNlGiiKhUvz8Kk5exvMYSvXA3r76T4AlzNnoNBwGL2v+JwJUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugMPWBlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C91C433C7;
	Wed,  6 Mar 2024 16:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709743792;
	bh=a5cu4VstVW27LKHaRhJuDngoVkzcZqWPu4EMGvK+E3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugMPWBlv6jJXkUrqOliq7DDfIXiYSrhOmScAO3x+5YvN4WPVwjvMnIzNjDq5CyEsX
	 khcZETsBdL9GKQyc1N3Vt7PuOka3S3+dpJ6sxH0PiLYlJxxPkSw79Y+Vrv7gy6fQ/+
	 dAzajj5ElBvfK0t/kZxAnq67J23Rvzd6y0gwr63de6SoIOLMpwzfclw3IOfsq5DBOP
	 OodV7UC7r+d6hvZNMXbN+aeWEYM+VZ8OCiS4wNeEK2EyfFWokLOQijE8RTl+xnVXfX
	 RAMw58RLhvIgt1QWaOuXQeyx+TNcXj4dC3GQ6xZ4un4wlJmAjyBghAmiaqzcW3n1VX
	 //HEu2nRI2zLA==
Date: Wed, 6 Mar 2024 09:49:50 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, llvm@lists.linux.dev
Subject: Re: [PATCH] kbuild: remove GCC's default -Wpacked-bitfield-compat
 flag
Message-ID: <20240306164950.GB3659677@dev-arch.thelio-3990X>
References: <20240306124709.324448-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306124709.324448-1-masahiroy@kernel.org>

On Wed, Mar 06, 2024 at 09:47:09PM +0900, Masahiro Yamada wrote:
> Commit 4a5838ad9d2d ("kbuild: Add extra gcc checks") added the
> -Wpacked-bitfield-compat flag.
> 
> GCC manual says:
>   "This warning is enabled by default. Use -Wno-packed-bitfield-compat
>    to disable this warning."
> 
> The test code in the manual:
> 
>   struct foo
>   {
>     char a:4;
>     char b:8;
>   } __attribute__ ((packed));
> 
> ... emits "note: offset of packed bit-field ‘b’ has changed in GCC 4.4"
> without W=3.
> 
> Let's remove it, as it is a default with GCC.
> 
> Clang does not support this flag, so its removal will not affect Clang
> builds.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/Makefile.extrawarn | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index a9e552a1e910..8192b497aae8 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -185,7 +185,6 @@ KBUILD_CFLAGS += -Wpointer-arith
>  KBUILD_CFLAGS += -Wredundant-decls
>  KBUILD_CFLAGS += -Wsign-compare
>  KBUILD_CFLAGS += -Wswitch-default
> -KBUILD_CFLAGS += $(call cc-option, -Wpacked-bitfield-compat)
>  
>  KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN3
>  
> -- 
> 2.40.1
> 
> 


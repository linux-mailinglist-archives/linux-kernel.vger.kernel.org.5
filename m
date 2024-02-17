Return-Path: <linux-kernel+bounces-69522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF95F858A86
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D153282A41
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E28B149DEF;
	Sat, 17 Feb 2024 00:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0gLWjb+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FE0173;
	Sat, 17 Feb 2024 00:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708128481; cv=none; b=MhEfG0AQ8gAC+fbcFy8Qqs998WrKUZXIgXULsBob6XtNMzi1sgFL1itURVuz3BIWWWrel5Wheud0JWIs0KYIWblvsdyxyNMQfCfIv0nlWyQQsTHFUly8QD4oEhPhlWQXIOm8ZJrFqkjn9oz4sEhlhJpVMqDzZl8HkfkJ5QlJPZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708128481; c=relaxed/simple;
	bh=9F5kBkR+QD3RmrjVjEGCYqMELge2iCuTz8j5HrnXFRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jnb+L3Y4iDYS4I6b1tQ9MtgAM9e0a+MP5n91jqXjPTENGIzHapbhxAu4YJSONl7lKEmm8rqu+F8nQs0d1NOUUbeX6h1WcmD5DRdZJGkNNBJH6lA5qk++mP4NSfhP/TY+Cbl468zYo/6ZRK8qvbR/kCXAvt11J/bIZ7e4r1mSGNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0gLWjb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B68AC433C7;
	Sat, 17 Feb 2024 00:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708128481;
	bh=9F5kBkR+QD3RmrjVjEGCYqMELge2iCuTz8j5HrnXFRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0gLWjb+FDPxs1UMz1jUt5NMr+iSpu9SkvJC+xuB18X9VFCkWKMdr4aToDfwxk8D7
	 rrjG4s9uO0be7A/t9cdH+lcxY9E+vgqSccWa87tVU4UN00xA4lszstIsOQ/sapgvgs
	 Vox2FK7TV1EnOyDtv6/GPBhh3kUNQOcPwDmHNVxMlVMZKtm2niuhIXi5mTNJ84VN55
	 qfDoL9TPl288IO+0ZhadsSZD+wzboDW4Q+JfINR683Uw4XiwKwXAW9HfvIq+RHm5tc
	 //2evRp21wsRu3tgGui20PJfUSXQ0DM8CvIohZHUb5A5kq+YZey+ZvKjpedqqzDEx9
	 AFPoSo4cIMkDQ==
Date: Fri, 16 Feb 2024 17:07:59 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: masahiroy@kernel.org, nicolas@fjasle.eu, mark.rutland@arm.com,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: Use -fmin-function-alignment when available
Message-ID: <20240217000759.GA3808452@dev-arch.thelio-3990X>
References: <20240215151642.8970-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215151642.8970-1-petr.pavlu@suse.com>

On Thu, Feb 15, 2024 at 04:16:42PM +0100, Petr Pavlu wrote:
> GCC recently added option -fmin-function-alignment, which should appear
> in GCC 14. Unlike -falign-functions, this option causes all functions to
> be aligned at the specified value, including the cold ones.
> 
> Detect availability of -fmin-function-alignment and use it instead of
> -falign-functions when present. Introduce CC_HAS_SANE_FUNCTION_ALIGNMENT
> and make the workarounds for the broken function alignment conditional
> on this setting.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Thanks, this looks good to me from a Kbuild perspective.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
> Changes since v1 [1]:
> - Check the availability of -fmin-function-alignment only in one place.
> 
> [1] https://lore.kernel.org/linux-kbuild/20240212145355.1050-1-petr.pavlu@suse.com/
> 
>  Makefile                       |  7 +++++++
>  arch/Kconfig                   | 12 ++++++++++++
>  include/linux/compiler_types.h | 10 +++++-----
>  kernel/exit.c                  |  5 ++++-
>  4 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 7e0b2ad98905..6f20ab5e2e44 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -974,8 +974,15 @@ export CC_FLAGS_CFI
>  endif
>  
>  ifneq ($(CONFIG_FUNCTION_ALIGNMENT),0)
> +# Set the minimal function alignment. Use the newer GCC option
> +# -fmin-function-alignment if it is available, or fall back to -falign-funtions.
> +# See also CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT.
> +ifdef CONFIG_CC_HAS_MIN_FUNCTION_ALIGNMENT
> +KBUILD_CFLAGS += -fmin-function-alignment=$(CONFIG_FUNCTION_ALIGNMENT)
> +else
>  KBUILD_CFLAGS += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
>  endif
> +endif
>  
>  # arch Makefile may override CC so keep this after arch Makefile is included
>  NOSTDINC_FLAGS += -nostdinc
> diff --git a/arch/Kconfig b/arch/Kconfig
> index a5af0edd3eb8..bd6c6335efac 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1507,4 +1507,16 @@ config FUNCTION_ALIGNMENT
>  	default 4 if FUNCTION_ALIGNMENT_4B
>  	default 0
>  
> +config CC_HAS_MIN_FUNCTION_ALIGNMENT
> +	# Detect availability of the GCC option -fmin-function-alignment which
> +	# guarantees minimal alignment for all functions, unlike
> +	# -falign-functions which the compiler ignores for cold functions.
> +	def_bool $(cc-option, -fmin-function-alignment=8)
> +
> +config CC_HAS_SANE_FUNCTION_ALIGNMENT
> +	# Set if the guaranteed alignment with -fmin-function-alignment is
> +	# available or extra care is required in the kernel. Clang provides
> +	# strict alignment always, even with -falign-functions.
> +	def_bool CC_HAS_MIN_FUNCTION_ALIGNMENT || CC_IS_CLANG
> +
>  endmenu
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 663d8791c871..f0152165e83c 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -99,17 +99,17 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Label-Attributes.html#index-cold-label-attribute
>   *
>   * When -falign-functions=N is in use, we must avoid the cold attribute as
> - * contemporary versions of GCC drop the alignment for cold functions. Worse,
> - * GCC can implicitly mark callees of cold functions as cold themselves, so
> - * it's not sufficient to add __function_aligned here as that will not ensure
> - * that callees are correctly aligned.
> + * GCC drops the alignment for cold functions. Worse, GCC can implicitly mark
> + * callees of cold functions as cold themselves, so it's not sufficient to add
> + * __function_aligned here as that will not ensure that callees are correctly
> + * aligned.
>   *
>   * See:
>   *
>   *   https://lore.kernel.org/lkml/Y77%2FqVgvaJidFpYt@FVFF77S0Q05N
>   *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88345#c9
>   */
> -#if !defined(CONFIG_CC_IS_GCC) || (CONFIG_FUNCTION_ALIGNMENT == 0)
> +#if defined(CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT) || (CONFIG_FUNCTION_ALIGNMENT == 0)
>  #define __cold				__attribute__((__cold__))
>  #else
>  #define __cold
> diff --git a/kernel/exit.c b/kernel/exit.c
> index dfb963d2f862..5a6fed4ad3df 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1920,7 +1920,10 @@ EXPORT_SYMBOL(thread_group_exited);
>   *
>   * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88345#c11
>   */
> -__weak __function_aligned void abort(void)
> +#ifndef CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT
> +__function_aligned
> +#endif
> +__weak void abort(void)
>  {
>  	BUG();
>  
> 
> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
> -- 
> 2.35.3
> 


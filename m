Return-Path: <linux-kernel+bounces-39787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CB083D613
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F9DB278B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09FA1CA91;
	Fri, 26 Jan 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJrwKq0Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C6014276;
	Fri, 26 Jan 2024 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258691; cv=none; b=eNYyBp6csFBDU2OSGyXT6UjBMXIBqbMfpLREvOTCYX8Lh7BJ0xGJh1yjxCAA59sWiSegOUa6de2R85pyRnCUTyHAtgJzOXsmA6fbijy/0VJOlwqT0zGRD7u4YXEc8KwpqcN/vb/bg67Mv6DynKkyRMjp7OcsjAt7L4FwL8Pv9fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258691; c=relaxed/simple;
	bh=gaO5xq4+iqo/CpWSTXlZvHIwYFC0rTJKMRPwhqMBRbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPRevf5e/WOCCNTPlvdDY5B3BhR8QCfgUYzORMWuRdxswXxxqQEQvI8nlEIXA8cNeiDh6mt5nM0yAGM0GTpKcdIdXtvGW34w4JJzpbCqeBuEn3Zo1GWHg3nO1jLhDZMvnMdIbRGx5nRRQ1enx+5LwCOkvdyAd6lEI2UZ/0Y7Aco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJrwKq0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD862C433B1;
	Fri, 26 Jan 2024 08:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706258690;
	bh=gaO5xq4+iqo/CpWSTXlZvHIwYFC0rTJKMRPwhqMBRbo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DJrwKq0YiCYXRsEOAkgnCozSU3DFfNvol2WhYcL+1l7yRpdzxU97/wyN6dC3VvYZi
	 AVQrz3RS5yS9M7Hi26EsL4tQTmix5gNZ5L0ydLrSsRJfcNqq9PHgR+uVj5mHn1WoZI
	 w6eKuPT/PK1ycyJoVYkSgq6yOWbT1hVxSy2lEw4XNllrCqh0ZZWQg0Lc1VLQ/IoXf7
	 OzdDPBQ+w7d3Qu7cq8kqO78yyb64RHjG1yNfiB0cAkxIrPoxGYUrOFuyKV5i8wbpaw
	 KysOQx0Yb2GKXV3kpzSNrUgl5Gm78WWcQfaMo6z2arb6GFDNu0TQ1ZGHESve7lNNZ9
	 tcWnTV9YcfvRQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5102188d2aeso94365e87.2;
        Fri, 26 Jan 2024 00:44:50 -0800 (PST)
X-Gm-Message-State: AOJu0Ywei91T/6fI16Pu0chJJNH6KVZZ3KJweRdUVX9ZiugojvnHu8S5
	Y9YZjFy8HhEwz2Hs1aPpC6yaSklYIGc6/WyVT/pVnwb9isnDYsURS+t+guuGb3NY5TncblghSwA
	ORtnplGK9iIFYjylgK/Oy2JeUvlA=
X-Google-Smtp-Source: AGHT+IFjNDG5Tm3UEEPA7ACJkYs/KdrtCbDYforcV54CpZLqF2gkX9FCsY5ZA2v/40T7zrcJxSycn+IRI/2GHFp2hns=
X-Received: by 2002:a05:6512:2246:b0:50e:7410:d5b0 with SMTP id
 i6-20020a056512224600b0050e7410d5b0mr669457lfu.28.1706258688908; Fri, 26 Jan
 2024 00:44:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
 <20240125-bump-min-llvm-ver-to-13-0-1-v1-4-f5ff9bda41c5@kernel.org>
In-Reply-To: <20240125-bump-min-llvm-ver-to-13-0-1-v1-4-f5ff9bda41c5@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 26 Jan 2024 09:44:37 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFzi=ijUBU0i3gq4Q9rcCvMw-a1wLc1u7fXRRN8QbN9hw@mail.gmail.com>
Message-ID: <CAMj1kXFzi=ijUBU0i3gq4Q9rcCvMw-a1wLc1u7fXRRN8QbN9hw@mail.gmail.com>
Subject: Re: [PATCH 04/11] ARM: Remove Thumb2 __builtin_thread_pointer
 workaround for Clang
To: Nathan Chancellor <nathan@kernel.org>
Cc: akpm@linux-foundation.org, masahiroy@kernel.org, nicolas@fjasle.eu, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux@armlinux.org.uk, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 23:56, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Now that the minimum supported version of LLVM for building the kernel
> has been bumped to 13.0.1, the conditional expression added to
> get_current() by commit c1e42efacb9b ("ARM: 9151/1: Thumb2: avoid
> __builtin_thread_pointer() on Clang") is always true, as the build will
> fail during the configuration stage for older LLVM versions. Remove it,
> effectively reverting the aforementioned change.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
> Cc: linux@armlinux.org.uk
> Cc: ardb@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm/include/asm/current.h | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/arch/arm/include/asm/current.h b/arch/arm/include/asm/current.h
> index 1e1178bf176d..5225cb1c803b 100644
> --- a/arch/arm/include/asm/current.h
> +++ b/arch/arm/include/asm/current.h
> @@ -18,18 +18,12 @@ static __always_inline __attribute_const__ struct task_struct *get_current(void)
>  {
>         struct task_struct *cur;
>
> -#if __has_builtin(__builtin_thread_pointer) && \
> -    defined(CONFIG_CURRENT_POINTER_IN_TPIDRURO) && \
> -    !(defined(CONFIG_THUMB2_KERNEL) && \
> -      defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 130001)
> +#if __has_builtin(__builtin_thread_pointer) && defined(CONFIG_CURRENT_POINTER_IN_TPIDRURO)
>         /*
>          * Use the __builtin helper when available - this results in better
>          * code, especially when using GCC in combination with the per-task
>          * stack protector, as the compiler will recognize that it needs to
>          * load the TLS register only once in every function.
> -        *
> -        * Clang < 13.0.1 gets this wrong for Thumb2 builds:
> -        * https://github.com/ClangBuiltLinux/linux/issues/1485
>          */
>         cur = __builtin_thread_pointer();
>  #elif defined(CONFIG_CURRENT_POINTER_IN_TPIDRURO) || defined(CONFIG_SMP)
>
> --
> 2.43.0
>


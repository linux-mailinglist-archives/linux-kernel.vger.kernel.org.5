Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D4A7B5850
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbjJBQsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbjJBQsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:48:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C49B3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:47:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c736b00639so4595ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696265278; x=1696870078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=72YupGIakc6xPMIaMfBiPv4QhtUc0gHH3bw4jZTtKPg=;
        b=eTRHjRhU4DcrJWtVqDz3oBov+abgSky20GFjUcybGFbMWawVYAtR5uKB6mHO1CkoQo
         hNqjDQ3qoi01wjNwERNQlCV3EC+MYThccTJH4u/MfZeCuqz06E0CoKytMT9E7irz4UyY
         ZT0sqGUf/01wAJpY8eWw/y5l0mjIGzX7gxbfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265278; x=1696870078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72YupGIakc6xPMIaMfBiPv4QhtUc0gHH3bw4jZTtKPg=;
        b=LHWsvG7ryX7FOf6g1NW9nY80F0hohchedgYFvbuvSXNQDVATVgs1vP6wqkEaQrfh0S
         sdcxNkcshmJiQFFC+ko+aLLg5jkCLGAM8gx2tSvIEmZ3yGq8aXKsc2TITqjxX7IJmhB1
         wdsycK1WBcnFegpGnMIA6LQEdeVrI/Z+H5aCuvnkvOVH9nR6cl7LUevOX/IItL8YoU5C
         AC+DDmbZ6IiDyjc8KjZFgqDMNgh4qCJi5kl6132q3FZcJ/xyv/4VB5wmKGvXkj2o1cvP
         OEOX2m0PtJL8eayePwKb62SB1h5nUF0NGr72YGmTmcMWywvgj1dqiEYM5O4d2MtYYRB5
         Xyqw==
X-Gm-Message-State: AOJu0Yz09vHOsdTCSNrv2T/mKIcK/qqitQHty2zqSprRy0UplQFqFsKV
        LmB5TsnEc1ZIe2bHQx2uMaEqnjT2flHDZCF9EGM=
X-Google-Smtp-Source: AGHT+IHq4Thj0DugoO/WYO0sPwDrntba6iCWfaQ/Ia6nS9T/ZB5cfS+kaxMh6i54iikgjbMvZpUA1w==
X-Received: by 2002:a17:903:41d1:b0:1bc:6861:d746 with SMTP id u17-20020a17090341d100b001bc6861d746mr13533333ple.58.1696265277859;
        Mon, 02 Oct 2023 09:47:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iz2-20020a170902ef8200b001c5bcc9d916sm5145578plb.176.2023.10.02.09.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:47:56 -0700 (PDT)
Date:   Mon, 2 Oct 2023 09:47:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux@rasmusvillemoes.dk'" <linux@rasmusvillemoes.dk>,
        'Steven Rostedt' <rostedt@goodmis.org>,
        "'bvanassche@acm.org'" <bvanassche@acm.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH next] compiler.h: Move __is_constexpr() to compiler.h.
Message-ID: <202310020947.CAF558C6@keescook>
References: <6d2b584e26544ee6a0810e494352d432@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d2b584e26544ee6a0810e494352d432@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 02:34:05PM +0000, David Laight wrote:
> Prior to f747e6667ebb2 __is_constexpr() was in its only user minmax.h.
> That commit moved it to const.h - but that file just defined ULL(x) and
>   UL(x) so that constants can be defined for .S and .c files.
> So apart from the word 'const' it wasn't really a good location.
> Instead move the definition to compiler.h just before the similar
>   is_signed_type() and is_unsigned_type().
> (Which were moved there by dcf8e5633e2e6)
> This may not be a good long-term home, but the three definitions
>   belong together.
> 
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
> This makes it possible to use __is_constexpr() inside is_signed_type()
> so that the result is constant integer expression for pointer types.
> In particular (void *)1 isn't constant enough.
> 
>  include/linux/compiler.h    | 8 ++++++++
>  include/linux/const.h       | 8 --------
>  tools/include/linux/const.h | 8 --------
>  3 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index d7779a18b24f..2efec9bfcc40 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -230,6 +230,14 @@ static inline void *offset_to_ptr(const int *off)
>  /* &a[0] degrades to a pointer: a different type from an array */
>  #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>  
> +/*
> + * This returns a constant expression while determining if an argument is
> + * a constant expression, most importantly without evaluating the argument.
> + * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> + */
> +#define __is_constexpr(x) \
> +	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> +
>  /*
>   * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
>   * bool and also pointer types.
> diff --git a/include/linux/const.h b/include/linux/const.h
> index 435ddd72d2c4..81b8aae5a855 100644
> --- a/include/linux/const.h
> +++ b/include/linux/const.h
> @@ -3,12 +3,4 @@
>  
>  #include <vdso/const.h>
>  
> -/*
> - * This returns a constant expression while determining if an argument is
> - * a constant expression, most importantly without evaluating the argument.
> - * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> - */
> -#define __is_constexpr(x) \
> -	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> -
>  #endif /* _LINUX_CONST_H */
> diff --git a/tools/include/linux/const.h b/tools/include/linux/const.h
> index 435ddd72d2c4..81b8aae5a855 100644
> --- a/tools/include/linux/const.h
> +++ b/tools/include/linux/const.h
> @@ -3,12 +3,4 @@
>  
>  #include <vdso/const.h>
>  
> -/*
> - * This returns a constant expression while determining if an argument is
> - * a constant expression, most importantly without evaluating the argument.
> - * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> - */
> -#define __is_constexpr(x) \
> -	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))

Doesn't tools/ still need its own copy somewhere?

-Kees

> -
>  #endif /* _LINUX_CONST_H */
> -- 
> 2.17.1
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

-- 
Kees Cook

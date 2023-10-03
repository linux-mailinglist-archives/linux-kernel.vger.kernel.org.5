Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9437B7534
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbjJCXjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjJCXjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:39:25 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41215A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:39:22 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57b811a6ce8so823152eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696376361; x=1696981161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHe8JYym2Ds2OFZFVeg/AdE0yJx5jpX05ec3eVSRCvE=;
        b=hSdcoybKOokerspqVkF9HEsQsQqnjop+uLPweb0CZRArvxr4PBAnP0+ZYOloMKJpDA
         iIR7Kw0RqKt60vstZJd2jTvfH7J6bXnreSJOo+hvJnHX7p5mJvRWpkesMZK7XbtxhPXM
         l/eSlCZaB4T8aZpzhzypbRuTNcfhDeRD92h1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696376361; x=1696981161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHe8JYym2Ds2OFZFVeg/AdE0yJx5jpX05ec3eVSRCvE=;
        b=Pct0/8ifvC1Kkoi+2UZLthDgLAoELYJZM79CW2Fdg8TQxyDqPFhCAepTBwlEDt4P9l
         Q+F+kym7Guie9i0AhXnnZmcd/mXZ4YPz7+LnCNVa2cQG4MAa7R/8kezBPeblhqEa1NRJ
         fevySST7D4bELavv9bydn/qc9DFyTSYHq8WclYLFUshyalvKQenYY4/WFi0sVgARbGEF
         kXlLCslaCtFEdqUeeQNwZC6CVpGUbovvEvH4LUAC/KlCMAicksJLzgL2hgmuodZxlSLS
         QJx1CXcWtxmHFjLRkto4CFHlNhuZo7SC54nub1c8v4uzEnMJ4S3NHDP4MY1yN6V1fEiX
         kZ/w==
X-Gm-Message-State: AOJu0Yx8IM1tjjOtRl6CYsGXa/1wVQXYydUeDYkAIOeQJrRbauLM/0st
        k0/0Z81vhcRRstV8Fa95CgFaBgPJ7dZcuXOuM+s=
X-Google-Smtp-Source: AGHT+IH9yQzBUXtP3fdaCapHuvlVlpBE0YsTKz0XBHyXXwlEidsXtlrQMpU6wnuaa3wSyWjUDqs5Dw==
X-Received: by 2002:a05:6358:430c:b0:133:b42:69ca with SMTP id r12-20020a056358430c00b001330b4269camr763881rwc.18.1696376361471;
        Tue, 03 Oct 2023 16:39:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a656a01000000b0056c5454105csm1694225pgu.93.2023.10.03.16.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:39:20 -0700 (PDT)
Date:   Tue, 3 Oct 2023 16:39:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] kernel.h: Move lib/cmdline.c prototypes to
 string.h
Message-ID: <202310031638.D39E80C32B@keescook>
References: <20231003130142.2936503-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003130142.2936503-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 04:01:42PM +0300, Andy Shevchenko wrote:
> The lib/cmdline.c is basically a set of some small string parsers
> which are wide used in the kernel. Their prototypes belong to the
> string.h rather then kernel.h.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I think these should live in string_helpers.h not string.h (which is, in
theory, supposed to be used for the standard C string library functions,
though that's not 100% currently)...

-Kees

> ---
>  include/linux/kernel.h | 6 ------
>  include/linux/string.h | 8 ++++++++
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index c07f9c779d45..3e6c5ac08f8b 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -195,12 +195,6 @@ static inline void might_fault(void) { }
>  
>  void do_exit(long error_code) __noreturn;
>  
> -extern int get_option(char **str, int *pint);
> -extern char *get_options(const char *str, int nints, int *ints);
> -extern unsigned long long memparse(const char *ptr, char **retptr);
> -extern bool parse_option_str(const char *str, const char *option);
> -extern char *next_arg(char *args, char **param, char **val);
> -
>  extern int core_kernel_text(unsigned long addr);
>  extern int __kernel_text_address(unsigned long addr);
>  extern int kernel_text_address(unsigned long addr);
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 3c920b6d609b..0995f2a737ef 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -181,9 +181,17 @@ extern void *kmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
>  extern void *kvmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
>  extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
>  
> +/* lib/argv_split.c */
>  extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
>  extern void argv_free(char **argv);
>  
> +/* lib/cmdline.c */
> +extern int get_option(char **str, int *pint);
> +extern char *get_options(const char *str, int nints, int *ints);
> +extern unsigned long long memparse(const char *ptr, char **retptr);
> +extern bool parse_option_str(const char *str, const char *option);
> +extern char *next_arg(char *args, char **param, char **val);
> +
>  extern bool sysfs_streq(const char *s1, const char *s2);
>  int match_string(const char * const *array, size_t n, const char *string);
>  int __sysfs_match_string(const char * const *array, size_t n, const char *s);
> -- 
> 2.40.0.1.gaa8946217a0b
> 

-- 
Kees Cook
